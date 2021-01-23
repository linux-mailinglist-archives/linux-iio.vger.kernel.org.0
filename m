Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC730168E
	for <lists+linux-iio@lfdr.de>; Sat, 23 Jan 2021 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbhAWQDU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Jan 2021 11:03:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbhAWQDT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Jan 2021 11:03:19 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0CF222A84;
        Sat, 23 Jan 2021 16:02:34 +0000 (UTC)
Date:   Sat, 23 Jan 2021 16:02:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensor-rotation: Fix quaternion data not
 correct
Message-ID: <20210123160207.710dbe3b@archlinux>
In-Reply-To: <20210120074909.25707-1-xiang.ye@intel.com>
References: <20210120074909.25707-1-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Jan 2021 15:49:09 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> Because the data of HID_USAGE_SENSOR_ORIENT_QUATERNION defined by ISH FW
> is s16, but quaternion data type is in_rot_quaternion_type(le:s16/32X4>>0),
> need to transform data type from s16 to s32
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>

Hi Ye Xiang,

So from a quick check of the "HID Sensor Usages" spec, I 'think' that we can only
have s16 and s32 for this type of channel in which case this fix is sufficient for
all possible cases.

Also, please figure out a best estimate for a
Fixes: tag as that will help with backporting this.

Thanks,

Jonathan


> ---
>  drivers/iio/orientation/hid-sensor-rotation.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index b0245b3b7ffc..cf7f57a47681 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -21,7 +21,7 @@ struct dev_rot_state {
>  	struct hid_sensor_common common_attributes;
>  	struct hid_sensor_hub_attribute_info quaternion;
>  	struct {
> -		u32 sampled_vals[4] __aligned(16);
> +		s32 sampled_vals[4] __aligned(16);
>  		u64 timestamp __aligned(8);
>  	} scan;
>  	int scale_pre_decml;
> @@ -175,8 +175,15 @@ static int dev_rot_capture_sample(struct hid_sensor_hub_device *hsdev,
>  	struct dev_rot_state *rot_state = iio_priv(indio_dev);
>  
>  	if (usage_id == HID_USAGE_SENSOR_ORIENT_QUATERNION) {
> -		memcpy(&rot_state->scan.sampled_vals, raw_data,
> -		       sizeof(rot_state->scan.sampled_vals));
> +		if (raw_len / 4 == sizeof(s16)) {
> +			rot_state->scan.sampled_vals[0] = ((s16 *)raw_data)[0];
> +			rot_state->scan.sampled_vals[1] = ((s16 *)raw_data)[1];
> +			rot_state->scan.sampled_vals[2] = ((s16 *)raw_data)[2];
> +			rot_state->scan.sampled_vals[3] = ((s16 *)raw_data)[3];
> +		} else {
> +			memcpy(&rot_state->scan.sampled_vals, raw_data,
> +			       sizeof(rot_state->scan.sampled_vals));
> +		}
>  
>  		dev_dbg(&indio_dev->dev, "Recd Quat len:%zu::%zu\n", raw_len,
>  			sizeof(rot_state->scan.sampled_vals));

