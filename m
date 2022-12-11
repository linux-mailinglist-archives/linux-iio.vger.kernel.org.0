Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BB64947C
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 14:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLKNiY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 08:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLKNiX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 08:38:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C87C749
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 05:38:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EDF2B80A0A
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 13:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7403C433F0;
        Sun, 11 Dec 2022 13:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670765899;
        bh=EWsNj2srD3F4yda1ZR1yPExNnVRubtfXwo47oJLJS8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GOAQYUzi9i+E+8CNuyqjT/cgfB2TYjdJqpltOwzMb7A72/xl4J2Be8lSw7lWpbqoO
         a6KFDlNK2Mqgm6XEUX6N5KPOwoIHk/7gBgW3HA+n46Ds7VsvojFpdWZs31pFpC5CY4
         SUP0tsJfX54wPR0pXpYJN5qvQztOv/yF0pMclkkXMdhOY4FaUV+x4QeLUSzfkv/2gi
         84kttabWbW02lxg4PMgEoEcSZVvjKrlLUGCoDl+QDNA9iCbvX45xLrbNfjacGIJzpP
         fui/Xm+IlFOgiN0/Os+LhUE9IwOq6A1e49n3OAhfjHtGCNY88jcGusd6HDkorhM/qD
         gVEE8alMFBagw==
Date:   Sun, 11 Dec 2022 13:51:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/7] iio: imu: fxos8700: fix ACCEL measurement range
 selection
Message-ID: <20221211135114.08e57371@jic23-huawei>
In-Reply-To: <20221208071911.2405922-6-carlos.song@nxp.com>
References: <20221208071911.2405922-1-carlos.song@nxp.com>
        <20221208071911.2405922-6-carlos.song@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  8 Dec 2022 15:19:09 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> When device is in active mode, it fails to set an ACCEL full-scale
> range(2g/4g/8g) in FXOS8700_XYZ_DATA_CFG. This is not align with the
> datasheet, but it is a fxos8700 chip behavier.
> 
> Keep the device in standby mode before setting ACCEL full-scale range
> into FXOS8700_XYZ_DATA_CFG in chip initialization phase and setting
> scale phase.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
Applied to the fixes-togreg branch of iio.git and marked for stable inclusion.

Thanks,

Jonathan

> ---
> Changes for V2:
> - Rework commit log and comment
> - Using regmap_write() instead of regmap_update_bits() for readability
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index d2e784628820..773f62203bf0 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -345,7 +345,8 @@ static int fxos8700_set_active_mode(struct fxos8700_data *data,
>  static int fxos8700_set_scale(struct fxos8700_data *data,
>  			      enum fxos8700_sensor t, int uscale)
>  {
> -	int i;
> +	int i, ret, val;
> +	bool active_mode;
>  	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
>  	struct device *dev = regmap_get_device(data->regmap);
>  
> @@ -354,6 +355,25 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * When device is in active mode, it failed to set an ACCEL
> +	 * full-scale range(2g/4g/8g) in FXOS8700_XYZ_DATA_CFG.
> +	 * This is not align with the datasheet, but it is a fxos8700
> +	 * chip behavier. Set the device in standby mode before setting
> +	 * an ACCEL full-scale range.
> +	 */
> +	ret = regmap_read(data->regmap, FXOS8700_CTRL_REG1, &val);
> +	if (ret)
> +		return ret;
> +
> +	active_mode = val & FXOS8700_ACTIVE;
> +	if (active_mode) {
> +		ret = regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> +				   val & ~FXOS8700_ACTIVE);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	for (i = 0; i < scale_num; i++)
>  		if (fxos8700_accel_scale[i].uscale == uscale)
>  			break;
> @@ -361,8 +381,12 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
>  	if (i == scale_num)
>  		return -EINVAL;
>  
> -	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
> +	ret = regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
>  			    fxos8700_accel_scale[i].bits);
> +	if (ret)
> +		return ret;
> +	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> +				  active_mode);
>  }
>  
>  static int fxos8700_get_scale(struct fxos8700_data *data,
> @@ -631,14 +655,17 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
>  	if (ret)
>  		return ret;
>  
> -	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> -	ret = regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> -			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
> +	/*
> +	 * Set max full-scale range (+/-8G) for ACCEL sensor in chip
> +	 * initialization then activate the device.
> +	 */
> +	ret = regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG, MODE_8G);
>  	if (ret)
>  		return ret;
>  
> -	/* Set for max full-scale range (+/-8G) */
> -	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG, MODE_8G);
> +	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> +	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> +			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
>  }
>  
>  static void fxos8700_chip_uninit(void *data)

