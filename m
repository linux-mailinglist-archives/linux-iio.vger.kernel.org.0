Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3237FC7F
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhEMR2D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhEMR2D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:28:03 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2828F61029;
        Thu, 13 May 2021 17:26:51 +0000 (UTC)
Date:   Thu, 13 May 2021 18:28:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 03/19] iio: accel: hid: Fix buffer alignment in
 iio_push_to_buffers_with_timestamp()
Message-ID: <20210513182800.0a105545@jic23-huawei>
In-Reply-To: <20210501170121.512209-4-jic23@kernel.org>
References: <20210501170121.512209-1-jic23@kernel.org>
        <20210501170121.512209-4-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  1 May 2021 18:01:05 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> To make code more readable, use a structure to express the channel
> layout and ensure the timestamp is 8 byte aligned.
> Note this matches what was done in all the other hid sensor drivers.
> This one was missed previously due to an extra level of indirection.
> 
> Found during an audit of all calls of this function.
> 
> Fixes: a96cd0f901ee ("iio: accel: hid-sensor-accel-3d: Add timestamp")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 2f9465cb382f..27f47e1c251e 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -28,8 +28,11 @@ struct accel_3d_state {
>  	struct hid_sensor_hub_callbacks callbacks;
>  	struct hid_sensor_common common_attributes;
>  	struct hid_sensor_hub_attribute_info accel[ACCEL_3D_CHANNEL_MAX];
> -	/* Reserve for 3 channels + padding + timestamp */
> -	u32 accel_val[ACCEL_3D_CHANNEL_MAX + 3];
> +	/* Ensure timestamp is naturally aligned */
> +	struct {
> +		u32 accel_val[3];
> +		s64 timestamp __aligned(8);
> +	} scan;
>  	int scale_pre_decml;
>  	int scale_post_decml;
>  	int scale_precision;
> @@ -245,8 +248,8 @@ static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
>  			accel_state->timestamp = iio_get_time_ns(indio_dev);
>  
>  		hid_sensor_push_data(indio_dev,
> -				     accel_state->accel_val,
> -				     sizeof(accel_state->accel_val),
> +				     &accel_state->scan,
> +				     sizeof(accel_state->scan),
>  				     accel_state->timestamp);
>  
>  		accel_state->timestamp = 0;
> @@ -271,7 +274,7 @@ static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
>  	case HID_USAGE_SENSOR_ACCEL_Y_AXIS:
>  	case HID_USAGE_SENSOR_ACCEL_Z_AXIS:
>  		offset = usage_id - HID_USAGE_SENSOR_ACCEL_X_AXIS;
> -		accel_state->accel_val[CHANNEL_SCAN_INDEX_X + offset] =
> +		accel_state->scan.accel_val[CHANNEL_SCAN_INDEX_X + offset] =
>  						*(u32 *)raw_data;
>  		ret = 0;
>  	break;

