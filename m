Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E9C28A36A
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 01:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbgJJW5I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Oct 2020 18:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731188AbgJJTxO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 15:53:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272A420829;
        Sat, 10 Oct 2020 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602349314;
        bh=4GaaOYpeyMUnLNGhyYwBFY4c3rpB7JB1MtriAPl6+Hs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uvY3jPhAPWzsLy8qa3RPVEawQzL31rotv3m3rreFQ3P6W7UzL0C/hqu5uK8eApq9/
         HPGLxqOidGWS73peJIQRlLU/weLtAYrlcQtQD88jh/a4ozRZjHMAyaG0H+OX8uLgRx
         vuPzzptgJ658becbPqAY2uV4dy1mzSxyftjuAw+U=
Date:   Sat, 10 Oct 2020 18:01:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7298: rework external ref setup & remove
 platform data
Message-ID: <20201010180151.0e85ba9e@archlinux>
In-Reply-To: <20201001141048.69050-1-alexandru.ardelean@analog.com>
References: <20201001141048.69050-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Oct 2020 17:10:48 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change removes the old platform data for ad7298. It is only used to
> provide whether to use an external regulator as a reference.
> 
> So, the logic is inverted a bit. The driver now tries to obtain a
> regulator. If one is provided, then the external ref is used. The rest of
> the logic should work as before.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7298.c             | 17 +++++++++--------
>  include/linux/platform_data/ad7298.h | 19 -------------------
>  2 files changed, 9 insertions(+), 27 deletions(-)
>  delete mode 100644 include/linux/platform_data/ad7298.h
> 
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index 48d43cb0f932..fa1047f74a1f 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -23,8 +23,6 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  
> -#include <linux/platform_data/ad7298.h>
> -
>  #define AD7298_WRITE	BIT(15) /* write to the control register */
>  #define AD7298_REPEAT	BIT(14) /* repeated conversion enable */
>  #define AD7298_CH(x)	BIT(13 - (x)) /* channel select */
> @@ -283,7 +281,6 @@ static const struct iio_info ad7298_info = {
>  
>  static int ad7298_probe(struct spi_device *spi)
>  {
> -	struct ad7298_platform_data *pdata = spi->dev.platform_data;
>  	struct ad7298_state *st;
>  	struct iio_dev *indio_dev;
>  	int ret;
> @@ -294,14 +291,18 @@ static int ad7298_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	if (pdata && pdata->ext_ref)
> +	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
> +	if (!IS_ERR(st->reg)) {
>  		st->ext_ref = AD7298_EXTREF;
> +	} else {
> +		ret = PTR_ERR(st->reg);
> +		if (ret != -ENODEV)
> +			return ret;
>  
> -	if (st->ext_ref) {
> -		st->reg = devm_regulator_get(&spi->dev, "vref");
> -		if (IS_ERR(st->reg))
> -			return PTR_ERR(st->reg);
> +		st->reg = NULL;
> +	}
>  
> +	if (st->reg) {
>  		ret = regulator_enable(st->reg);
>  		if (ret)
>  			return ret;
> diff --git a/include/linux/platform_data/ad7298.h b/include/linux/platform_data/ad7298.h
> deleted file mode 100644
> index 3e0ffe2d5d3d..000000000000
> --- a/include/linux/platform_data/ad7298.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * AD7298 SPI ADC driver
> - *
> - * Copyright 2011 Analog Devices Inc.
> - */
> -
> -#ifndef __LINUX_PLATFORM_DATA_AD7298_H__
> -#define __LINUX_PLATFORM_DATA_AD7298_H__
> -
> -/**
> - * struct ad7298_platform_data - Platform data for the ad7298 ADC driver
> - * @ext_ref: Whether to use an external reference voltage.
> - **/
> -struct ad7298_platform_data {
> -	bool ext_ref;
> -};
> -
> -#endif /* IIO_ADC_AD7298_H_ */

