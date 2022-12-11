Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3698D649483
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 14:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLKNso (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 08:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLKNsn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 08:48:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D75BAE5C
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 05:48:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CA8CB80A0A
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 13:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57242C433D2;
        Sun, 11 Dec 2022 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670766519;
        bh=EsdceXLGFbzfyJRSlpb1DUvsOGN2PuaO48aTcZQahtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tO1K+XDnJ5kc355/KrsMH0DJdfc/4LCoMkQRkmZZsUD4Da/oSvKn71b/cnRQfYN9g
         jr3FMdSO+eYrP/KaP2bitBL8cW99i8SIesXO7tO6TcpDzB5Ce/eIm/1LNEjZkvo0EM
         VYiuFMtsr0E75+djsEsaTeA5UaSu4i6f0cGEtTV/vH0jejH2BnnfqPbfzRhtLqT7AR
         AbGb9G1MxVWAGj/3S8U3Ic0wgut7wOzMgGw57RKlKXivayu6b9FOnrdfSZsA7KGXgb
         k+YF/It0ozSGbtwcqBbWMFp92c4m9gsXcUjcu3Ii13taj/57d4mJNO6OJL0wi9k8o7
         s2232nciJ3Krg==
Date:   Sun, 11 Dec 2022 14:01:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iio: imu: fxos8700: fix ODR register readback
 and initialization
Message-ID: <20221211140134.7745473c@jic23-huawei>
In-Reply-To: <20221208071911.2405922-7-carlos.song@nxp.com>
References: <20221208071911.2405922-1-carlos.song@nxp.com>
        <20221208071911.2405922-7-carlos.song@nxp.com>
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

On Thu,  8 Dec 2022 15:19:10 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> Use the hexadecimal number to read and write the incorrect bits of
> the ODR register. It fails to set MAX ODR mode in chip initialization
> and it will return an incorrect ODR mode to userspace.
> 
> Use of regmap_write() instead of regmap_update_bits() to update bits
> is good for readability. FIELD_GET()/FIELD_PREP() can help clear register
> bit definition and avoid separately to define an offset. Unified use of
> regmap_write(), FIELD_GET()/FIELD_PREP() to read and write correct ODR
> register bits.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
This should probably be split into the minimal fix and then the
cleanup (which can follow later, keeping the code to backport more minimal.)

Comments inline.

> ---
> Changes for V2:
> - Modify FXOS8700_CTRL_ODR_MSK MASK instead of hexadecimal
> - Use of regmap_write() instead of regmap_update_bits()
> - Use FIELD_GET()/FIELD_PREP() to avoid to separately define an offset
> - Rework commit log
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index 773f62203bf0..b4baef82f6d5 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -10,6 +10,7 @@
>  #include <linux/regmap.h>
>  #include <linux/acpi.h>
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -144,9 +145,9 @@
>  #define FXOS8700_NVM_DATA_BNK0      0xa7
>  
>  /* Bit definitions for FXOS8700_CTRL_REG1 */
> -#define FXOS8700_CTRL_ODR_MSK       0x38
>  #define FXOS8700_CTRL_ODR_MAX       0x00
>  #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)

Unrelated but this is a very odd thing to see.  A mask for something called _MIN.
It's not used but value is probably wrong.  Best thing is probably just to remove it.

> +#define FXOS8700_CTRL_ODR_MSK       GENMASK(5, 3)
>  
>  /* Bit definitions for FXOS8700_M_CTRL_REG1 */
>  #define FXOS8700_HMS_MASK           GENMASK(1, 0)
> @@ -481,6 +482,7 @@ static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
>  			    int odr, int uodr)
>  {
>  	int i, ret, val;
> +	int odr_mode;
>  	bool active_mode;
>  	static const int odr_num = ARRAY_SIZE(fxos8700_odr);
>  
> @@ -508,10 +510,10 @@ static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
>  	if (i >= odr_num)
>  		return -EINVAL;
>  
> -	return regmap_update_bits(data->regmap,
> -				  FXOS8700_CTRL_REG1,
> -				  FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
> -				  fxos8700_odr[i].bits << 3 | active_mode);
> +	odr_mode &= ~FXOS8700_CTRL_ODR_MSK;

This doesn't look right.   You are masking bits out of an uninitialized variable.
I'm guessing intent was to use the value read from the register which is in
val.


> +	odr_mode |= FIELD_PREP(FXOS8700_CTRL_ODR_MSK, fxos8700_odr[i].bits);

> +	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> +			   odr_mode | active_mode);
>  }
>  
>  static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
> @@ -524,7 +526,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
>  	if (ret)
>  		return ret;
>  
> -	val &= FXOS8700_CTRL_ODR_MSK;
> +	val = FIELD_GET(FXOS8700_CTRL_ODR_MSK, val);
>  
>  	for (i = 0; i < odr_num; i++)
>  		if (val == fxos8700_odr[i].bits)
> @@ -612,6 +614,7 @@ static const struct iio_info fxos8700_info = {
>  static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
>  {
>  	int ret;
> +	int odr_mode;
>  	unsigned int val;
>  	struct device *dev = regmap_get_device(data->regmap);
>  
> @@ -664,8 +667,10 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
>  		return ret;
>  
>  	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> +	odr_mode &= ~FXOS8700_CTRL_ODR_MSK;
odr_mode not set to anything so you shouldn't be masking bits out of it.

> +	odr_mode |= FIELD_PREP(FXOS8700_CTRL_ODR_MSK, FXOS8700_CTRL_ODR_MAX);
>  	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> -			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
> +			   odr_mode | FXOS8700_ACTIVE);
>  }
>  
>  static void fxos8700_chip_uninit(void *data)

