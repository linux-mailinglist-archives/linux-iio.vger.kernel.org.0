Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5993632FC2B
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 18:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhCFRII (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 12:08:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231229AbhCFRHt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 12:07:49 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFA2B64FFD;
        Sat,  6 Mar 2021 17:07:47 +0000 (UTC)
Date:   Sat, 6 Mar 2021 17:07:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: hid-sensor-temperature: Fix issues of
 timestamp channel
Message-ID: <20210306170743.16d30d95@archlinux>
In-Reply-To: <20210303063615.12130-4-xiang.ye@intel.com>
References: <20210303063615.12130-1-xiang.ye@intel.com>
        <20210303063615.12130-4-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  3 Mar 2021 14:36:14 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> This patch fixes 2 issues of timestamp channel:
> 1. This patch ensures that there is sufficient space and correct
> alignment for the timestamp.
> 2. Correct the timestamp channel scan index.
This isn't technically a bug because channel index numbers just need
to be monotonic.  Still it's a reasonable tidy up given 1.
> 
> Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
Applied to the fixes togreg branch of iio.git and marked for stable.
Patch 4 is not a fix (I think) so will have to wait for this to
be upstream.

Jonathan

> ---
>  drivers/iio/temperature/hid-sensor-temperature.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
> index e3d38cbcf354..dc534ed784c3 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -15,7 +15,10 @@
>  struct temperature_state {
>  	struct hid_sensor_common common_attributes;
>  	struct hid_sensor_hub_attribute_info temperature_attr;
> -	s32 temperature_data;
> +	struct {
> +		s32 temperature_data;
> +		u64 timestamp __aligned(8);
> +	} scan;
>  	int scale_pre_decml;
>  	int scale_post_decml;
>  	int scale_precision;
> @@ -36,7 +39,7 @@ static const struct iio_chan_spec temperature_channels[] = {
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  			BIT(IIO_CHAN_INFO_HYSTERESIS),
>  	},
> -	IIO_CHAN_SOFT_TIMESTAMP(3),
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
>  };
>  
>  /* Adjust channel real bits based on report descriptor */
> @@ -127,9 +130,8 @@ static int temperature_proc_event(struct hid_sensor_hub_device *hsdev,
>  	struct temperature_state *temp_st = iio_priv(indio_dev);
>  
>  	if (atomic_read(&temp_st->common_attributes.data_ready))
> -		iio_push_to_buffers_with_timestamp(indio_dev,
> -				&temp_st->temperature_data,
> -				iio_get_time_ns(indio_dev));
> +		iio_push_to_buffers_with_timestamp(indio_dev, &temp_st->scan,
> +						   iio_get_time_ns(indio_dev));
>  
>  	return 0;
>  }
> @@ -144,7 +146,7 @@ static int temperature_capture_sample(struct hid_sensor_hub_device *hsdev,
>  
>  	switch (usage_id) {
>  	case HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE:
> -		temp_st->temperature_data = *(s32 *)raw_data;
> +		temp_st->scan.temperature_data = *(s32 *)raw_data;
>  		return 0;
>  	default:
>  		return -EINVAL;

