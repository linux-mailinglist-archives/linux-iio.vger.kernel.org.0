Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D263E3BEE
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 19:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhHHR2t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 13:28:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231486AbhHHR2q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 13:28:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F016260F0F;
        Sun,  8 Aug 2021 17:28:25 +0000 (UTC)
Date:   Sun, 8 Aug 2021 18:31:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensor-press: Add timestamp channel
Message-ID: <20210808183115.31df0580@jic23-huawei>
In-Reply-To: <20210731032556.26813-1-xiang.ye@intel.com>
References: <20210731032556.26813-1-xiang.ye@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Jul 2021 11:25:56 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> Each sample has a timestamp field with this change. This timestamp may
> be from the sensor hub when present or local kernel timestamp. The
> unit of timestamp is nanosecond.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
Applied to the togreg branch of iio.git and pushed out as testing to
let 0-day see what it can find.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/hid-sensor-press.c | 40 +++++++++++++++----------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index c416d261e3e3..b365483bd09e 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -16,17 +16,24 @@
>  #include <linux/iio/buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
> -#define CHANNEL_SCAN_INDEX_PRESSURE 0
> +enum {
> +	CHANNEL_SCAN_INDEX_PRESSURE,
> +	CHANNEL_SCAN_INDEX_TIMESTAMP,
> +};
>  
>  struct press_state {
>  	struct hid_sensor_hub_callbacks callbacks;
>  	struct hid_sensor_common common_attributes;
>  	struct hid_sensor_hub_attribute_info press_attr;
> -	u32 press_data;
> +	struct {
> +		u32 press_data;
> +		u64 timestamp __aligned(8);
> +	} scan;
>  	int scale_pre_decml;
>  	int scale_post_decml;
>  	int scale_precision;
>  	int value_offset;
> +	s64 timestamp;
>  };
>  
>  static const u32 press_sensitivity_addresses[] = {
> @@ -44,7 +51,9 @@ static const struct iio_chan_spec press_channels[] = {
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>  		.scan_index = CHANNEL_SCAN_INDEX_PRESSURE,
> -	}
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
> +
>  };
>  
>  /* Adjust channel real bits based on report descriptor */
> @@ -157,14 +166,6 @@ static const struct iio_info press_info = {
>  	.write_raw = &press_write_raw,
>  };
>  
> -/* Function to push data to buffer */
> -static void hid_sensor_push_data(struct iio_dev *indio_dev, const void *data,
> -					int len)
> -{
> -	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
> -	iio_push_to_buffers(indio_dev, data);
> -}
> -
>  /* Callback handler to send event after all samples are received and captured */
>  static int press_proc_event(struct hid_sensor_hub_device *hsdev,
>  				unsigned usage_id,
> @@ -174,10 +175,13 @@ static int press_proc_event(struct hid_sensor_hub_device *hsdev,
>  	struct press_state *press_state = iio_priv(indio_dev);
>  
>  	dev_dbg(&indio_dev->dev, "press_proc_event\n");
> -	if (atomic_read(&press_state->common_attributes.data_ready))
> -		hid_sensor_push_data(indio_dev,
> -				&press_state->press_data,
> -				sizeof(press_state->press_data));
> +	if (atomic_read(&press_state->common_attributes.data_ready)) {
> +		if (!press_state->timestamp)
> +			press_state->timestamp = iio_get_time_ns(indio_dev);
> +
> +		iio_push_to_buffers_with_timestamp(
> +			indio_dev, &press_state->scan, press_state->timestamp);
> +	}
>  
>  	return 0;
>  }
> @@ -194,9 +198,13 @@ static int press_capture_sample(struct hid_sensor_hub_device *hsdev,
>  
>  	switch (usage_id) {
>  	case HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE:
> -		press_state->press_data = *(u32 *)raw_data;
> +		press_state->scan.press_data = *(u32 *)raw_data;
>  		ret = 0;
>  		break;
> +	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
> +		press_state->timestamp = hid_sensor_convert_timestamp(
> +			&press_state->common_attributes, *(s64 *)raw_data);
> +		break;
>  	default:
>  		break;
>  	}

