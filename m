Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823F13016AC
	for <lists+linux-iio@lfdr.de>; Sat, 23 Jan 2021 17:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbhAWQNP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Jan 2021 11:13:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbhAWQNO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Jan 2021 11:13:14 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63B822A84;
        Sat, 23 Jan 2021 16:12:32 +0000 (UTC)
Date:   Sat, 23 Jan 2021 16:12:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: hid-sensors: Move get sensitivity attribute to
 hid-sensor-common
Message-ID: <20210123161228.3a52121d@archlinux>
In-Reply-To: <20210120074706.23199-2-xiang.ye@intel.com>
References: <20210120074706.23199-1-xiang.ye@intel.com>
        <20210120074706.23199-2-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Jan 2021 15:47:04 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> No functional change has been made with this patch. The main intent here
> is to reduce code repetition of get sensitivity attribute.
> 
> In the current implementation, sensor_hub_input_get_attribute_info() is
> called from multiple drivers to get attribute info for sensitivity
> field. Moving this to common place will avoid code repetition.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>

One trivial note inline about an accidental indentation change. If that's
all I find in the series I'll fix it up whilst applying.

Thanks,

Jonathan

...
>  /* Channel definitions */
>  static const struct iio_chan_spec magn_3d_channels[] = {
>  	{
> @@ -448,32 +453,11 @@ static int magn_3d_parse_report(struct platform_device *pdev,
>  			&st->rot_attr.scale_pre_decml,
>  			&st->rot_attr.scale_post_decml);
>  
> -	/* Set Sensitivity field ids, when there is no individual modifier */
> -	if (st->magn_flux_attributes.sensitivity.index < 0) {
> -		sensor_hub_input_get_attribute_info(hsdev,
> -			HID_FEATURE_REPORT, usage_id,
> -			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> -			HID_USAGE_SENSOR_DATA_ORIENTATION,
> -			&st->magn_flux_attributes.sensitivity);
> -		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
> -			st->magn_flux_attributes.sensitivity.index,
> -			st->magn_flux_attributes.sensitivity.report_id);
> -	}
> -	if (st->magn_flux_attributes.sensitivity.index < 0) {
> -		sensor_hub_input_get_attribute_info(hsdev,
> -			HID_FEATURE_REPORT, usage_id,
> -			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> -			HID_USAGE_SENSOR_ORIENT_MAGN_FLUX,
> -			&st->magn_flux_attributes.sensitivity);
> -		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
> -			st->magn_flux_attributes.sensitivity.index,
> -			st->magn_flux_attributes.sensitivity.report_id);
> -	}
>  	if (st->rot_attributes.sensitivity.index < 0) {
>  		sensor_hub_input_get_attribute_info(hsdev,
>  			HID_FEATURE_REPORT, usage_id,
>  			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> -			HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH,
> +				HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH,

This change of alignment shouldn't be here.

>  			&st->rot_attributes.sensitivity);
>  		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
>  			st->rot_attributes.sensitivity.index,
> @@ -507,12 +491,16 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
>  
>  	ret = hid_sensor_parse_common_attributes(hsdev,
>  				HID_USAGE_SENSOR_COMPASS_3D,
> -				&magn_state->magn_flux_attributes);
> +				&magn_state->magn_flux_attributes,
> +				magn_3d_sensitivity_addresses,
> +				ARRAY_SIZE(magn_3d_sensitivity_addresses));
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup common attributes\n");
>  		return ret;
>  	}
>  	magn_state->rot_attributes = magn_state->magn_flux_attributes;
> +	/* sensitivity of rot_attribute is not the same as magn_flux_attributes */
> +	magn_state->rot_attributes.sensitivity.index = -1;
>  
>  	ret = magn_3d_parse_report(pdev, hsdev,
>  				&channels, &chan_count,
