Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B128641D8A
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 15:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLDO7W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 09:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLDO7V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 09:59:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1531006E
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 06:59:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66EA1B8098D
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 14:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7888C433D6;
        Sun,  4 Dec 2022 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670165958;
        bh=0Ze83rxSaFY6VGXReLopcCXOoSSG9P9Tlio3Uhjbms4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bjSgFg3CDV1jXjVq8YUDiWRj+4p5hu00FQaVUr07PBix1D0xDOI42UYmd738P3W9R
         RSlFPbJcj5tEcM18w000CGo1tFBJjMSI3N8Fiu/hZhj2DguD4ilcScQIKvGnb2zkpZ
         y7KliWiMfloVl45+Jej4ZdJmJzZaEfB56dC3e6OpH7Hvq3rOSPMssK5xiMnrP1BXAa
         p9Py6twMjDiQzl7KIkYmEXUTjfewo+fMGBIc7bkFlxsNS0+4DCT650fOzOLwSBWOoi
         9rLcbNy3JnGzml91oNW0sXOxQIExMpuQRfk7MD/+WP/m+AUVEYr5fsRW/zhRAHqTez
         YA794b6RrszhQ==
Date:   Sun, 4 Dec 2022 15:12:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Carlos Song <carlos.song@nxp.com>
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: imu: fxos8700: fix CTRL_REG1 register
 configuration error
Message-ID: <20221204151204.2fd6f19d@jic23-huawei>
In-Reply-To: <20221202103538.2218925-3-carlos.song@nxp.com>
References: <20221202103538.2218925-1-carlos.song@nxp.com>
        <20221202103538.2218925-3-carlos.song@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri,  2 Dec 2022 18:35:36 +0800
Carlos Song <carlos.song@nxp.com> wrote:

> When the device is in active mode, any change of the other fields
Other from what?  I.e. say "any change of fields other than xxx within..."

> within
> CTRL_REG1 will lead an invalid configuration. This not align with the
> datasheet, but it is a fxos8700 chip behavier.

Spell check your patch descriptions (I forget to do this sometimes as well.)

Given it's an NXP part, any chance of a datasheet errata to fix this?

> 
> Set the device in standby mode before configuring CTRL_REG1 register
> in chip initialization phase and setting scale phase.

In the initialization you don't do this, you simply reorder the code so
that other settings are written first.  So make sure the patch description
is consistent with the code.

Also the write you've moved isn't in CTRL_REG1 so the above description does
not explain why it is necessary to do this in standby mode.

> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/iio/imu/fxos8700_core.c | 36 ++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index a69122799892..60c08519d8af 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -343,7 +343,8 @@ static int fxos8700_set_active_mode(struct fxos8700_data *data,
>  static int fxos8700_set_scale(struct fxos8700_data *data,
>  			      enum fxos8700_sensor t, int uscale)
>  {
> -	int i;
> +	int i, ret, val;
> +	bool active_mode;
>  	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
>  	struct device *dev = regmap_get_device(data->regmap);
>  
> @@ -352,6 +353,23 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
>  		return -EINVAL;
>  	}
>  
> +	ret = regmap_read(data->regmap, FXOS8700_CTRL_REG1, &val);
> +	if (ret)
> +		return ret;
> +
> +	active_mode = val & FXOS8700_ACTIVE;
> +	/*
> +	 * The device must be in standby mode to change any of the
> +	 * other fields within CTRL_REG1. This not align with the
> +	 * datasheet, but it is a fxos8700 chip behavier.
> +	 */
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
> @@ -359,8 +377,12 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
>  	if (i == scale_num)
>  		return -EINVAL;
>  
> -	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
> +	ret = regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
>  			    fxos8700_accel_scale[i].bits);

As below, this isn't in CTRL_REG1 so not clear why we need to be
in standby mode to set it.

> +	if (ret)
> +		return ret;
> +	return regmap_update_bits(data->regmap, FXOS8700_CTRL_REG1,
> +				  FXOS8700_ACTIVE, active_mode);
Odd to use update bits here, but not when you clear the bit above.
Given you have the register value read back, either just using regmap_write()
in both cases, or use regmap_update_bits() in both cases would be fine by me.
Mixing the two isn't good for readability.

>  }
>  
>  static int fxos8700_get_scale(struct fxos8700_data *data,
> @@ -607,14 +629,14 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
>  	if (ret)
>  		return ret;
>  
> -	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> -	ret = regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> -			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
> +	/* Set for max full-scale range (+/-8G) */
> +	ret = regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG, MODE_8G);

Not in CTRL_REG1 so by the patch description, this doesn't need to be
done in standby mode. I'm guessing that description is meant to cover
other registers.

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

