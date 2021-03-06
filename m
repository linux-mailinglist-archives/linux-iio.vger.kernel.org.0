Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2938A32FC27
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 18:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhCFRF7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 12:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhCFRFf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 12:05:35 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D291E64FFD;
        Sat,  6 Mar 2021 17:05:33 +0000 (UTC)
Date:   Sat, 6 Mar 2021 17:05:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: hid-sensor-humidity: Fix alignment issue of
 timestamp channel
Message-ID: <20210306170529.64d6a2f3@archlinux>
In-Reply-To: <20210303063615.12130-2-xiang.ye@intel.com>
References: <20210303063615.12130-1-xiang.ye@intel.com>
        <20210303063615.12130-2-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  3 Mar 2021 14:36:12 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> This patch ensures that, there is sufficient space and correct
> alignment for the timestamp.
> 
> Fixes: d7ed89d5aadf ("iio: hid: Add humidity sensor support")
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
ouch.  I guess we were trampling over the next few elements and somehow
getting away with it (mostly).

Applied to the fixes-togreg branch of iio.git and marked for stable.

As the next patch isn't a fix, we'll have to wait for this to get
upstream and round the loop so I can apply the next patch via the
slower path.  Give me a poke if I seem to have lost it once the
dependency is in my togreg branch.

thanks,

Jonathan


> ---
>  drivers/iio/humidity/hid-sensor-humidity.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
> index ec88ae3f233d..74383abc0d44 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -15,7 +15,10 @@
>  struct hid_humidity_state {
>  	struct hid_sensor_common common_attributes;
>  	struct hid_sensor_hub_attribute_info humidity_attr;
> -	s32 humidity_data;
> +	struct {
> +		s32 humidity_data;
> +		u64 timestamp __aligned(8);
> +	} scan;
>  	int scale_pre_decml;
>  	int scale_post_decml;
>  	int scale_precision;
> @@ -129,9 +132,8 @@ static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
>  	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
>  
>  	if (atomic_read(&humid_st->common_attributes.data_ready))
> -		iio_push_to_buffers_with_timestamp(indio_dev,
> -					&humid_st->humidity_data,
> -					iio_get_time_ns(indio_dev));
> +		iio_push_to_buffers_with_timestamp(indio_dev, &humid_st->scan,
> +						   iio_get_time_ns(indio_dev));
>  
>  	return 0;
>  }
> @@ -146,7 +148,7 @@ static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
>  
>  	switch (usage_id) {
>  	case HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY:
> -		humid_st->humidity_data = *(s32 *)raw_data;
> +		humid_st->scan.humidity_data = *(s32 *)raw_data;
>  
>  		return 0;
>  	default:

