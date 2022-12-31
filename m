Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC965A51B
	for <lists+linux-iio@lfdr.de>; Sat, 31 Dec 2022 15:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiLaOlZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Dec 2022 09:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaOlY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Dec 2022 09:41:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154BB1098
        for <linux-iio@vger.kernel.org>; Sat, 31 Dec 2022 06:41:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B941FB8075F
        for <linux-iio@vger.kernel.org>; Sat, 31 Dec 2022 14:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22215C433F1;
        Sat, 31 Dec 2022 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672497681;
        bh=6rzAuNWOPamnE7x7E/S7d1alBUBH5wtP0kbbs7hQvmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DdYZwaeFJ9PhH1zzxGox2bQhvZSCsaZZzqOaoHdLruxnukdY7irYWQ6WyBfwN78ml
         yrG+u4RTqzJanV3fDz3G4gG/7qvgJQuHce0RV9QDT76gQbtdjHu825T7hZA+xN0ZuZ
         4/Ll/BwXAvK27U/u6LBU2Z8t1fCQIGVvcQrhFZbbPamT1RlUYkZYOnAUNZg3jCIOQb
         gLwMoUlUe7NMaZjZEJYqtVO+C1IQyxv7Rz9mYe83ppbGZLlCvRRM8fzn1D4SH/Ciwu
         aA0NffPhM4Cpd0PMs5lMjtux5195Jm2iTlLrC7uDwzW7z2uUpiCdBODIYAjqH+XZr+
         ZdS2x8Z2gCnuQ==
Date:   Sat, 31 Dec 2022 14:54:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: imu: fxos8700: fix failed initialization
 ODR mode assignment
Message-ID: <20221231145439.08564db1@jic23-huawei>
In-Reply-To: <20221228093941.270046-3-carlos.song@nxp.com>
References: <20221228093941.270046-1-carlos.song@nxp.com>
        <20221228093941.270046-3-carlos.song@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Wed, 28 Dec 2022 17:39:39 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> The absence of correct offset leads a failed initialization ODR mode
> assignment.
> 
> Select MAX ODR mode as the initialization ODR mode by field mask and
> FIELD_PREP.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
> Changes for V4:
> - None
> Changes for V3:
> - Legal use of FIELD_PREP() and field mask to select initialization
>   ODR mode
> - Rework commit log
> ---
>  drivers/iio/imu/fxos8700_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index a1af5d0fde5d..de4ced979226 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -611,6 +611,7 @@ static const struct iio_info fxos8700_info = {
>  static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
>  {
>  	int ret;
> +	int reg;
>  	unsigned int val;
>  	struct device *dev = regmap_get_device(data->regmap);
>  
> @@ -663,8 +664,11 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
>  		return ret;
>  
>  	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> -	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> -			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
> +	ret = regmap_read(data->regmap, FXOS8700_CTRL_REG1, &reg);
> +	if (ret)
> +		return ret;
> +	reg = reg | FIELD_PREP(FXOS8700_CTRL_ODR_MSK, FXOS8700_CTRL_ODR_MAX) | FXOS8700_ACTIVE;
reg |= will work here. However, like in previous patch I'd expect to see the
_CTRL_ODR_MSK used in
	reg &= ~FXOS8700_CTRL_ODR_MASK;
	reg |= FIELD_PREP(FXOS8700_CTRL_ODR_MSK, FXOS8700_CTRL_ODR_MAX) | FXOS8700_ACTIVE;

This is a good place to use regmap_update_bits() as there is no need to see what the previous
values were (unlike in previous patch).

> +	return regmap_write(data->regmap, FXOS8700_CTRL_REG1, reg);
>  }
>  
>  static void fxos8700_chip_uninit(void *data)

