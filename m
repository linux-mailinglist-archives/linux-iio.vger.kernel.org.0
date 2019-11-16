Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D625FF241
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 17:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfKPQSE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 11:18:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbfKPQR6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 11:17:58 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AE0021844;
        Sat, 16 Nov 2019 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573921078;
        bh=PoAjATiyMw59a4B+QqOkZq9Qem/RNBGHAwCV08vIXVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NiwuN3cA5wNzoy+x+tLZQfyxvfyWNPzhLN6tZr4PAOrsYM5JegUavQuoUHPsTD8xk
         W7IrhDvv90baPuGBVxR33GKjGPY8OXFsepKcSuvuzXQLvaYJLs80YkOCVDbTnX6Z8u
         dH145/up7L911obt7v5ID9W3H/3IcMgPi51jqtx0=
Date:   Sat, 16 Nov 2019 16:17:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH] iio: dac: ad7303: use regulator get optional to check
 for ext supply
Message-ID: <20191116161753.24d620df@archlinux>
In-Reply-To: <20191113083303.2229-1-alexandru.tachici@analog.com>
References: <20191113083303.2229-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Nov 2019 10:33:03 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> Previously, the code was using the of_read_property_bool() to check if
> an external regulator was provided. However, this is redundant, as it's
> more simple/direct to just ask the regulator is provided, via a
> `devm_regulator_get_optional()` call.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

Hi.
I agree in principle but I don't think devm_regulator_get_optional
returns NULL when a regulator isn't supplied.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad7303.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
> index 14bbac6bee98..e0c5fed4475c 100644
> --- a/drivers/iio/dac/ad7303.c
> +++ b/drivers/iio/dac/ad7303.c
> @@ -12,7 +12,6 @@
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -202,7 +201,6 @@ static int ad7303_probe(struct spi_device *spi)
>  	const struct spi_device_id *id = spi_get_device_id(spi);
>  	struct iio_dev *indio_dev;
>  	struct ad7303_state *st;
> -	bool ext_ref;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -224,24 +222,13 @@ static int ad7303_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	if (spi->dev.of_node) {
> -		ext_ref = of_property_read_bool(spi->dev.of_node,
> -				"REF-supply");
> -	} else {
> -		struct ad7303_platform_data *pdata = spi->dev.platform_data;
> -		if (pdata && pdata->use_external_ref)
> -			ext_ref = true;
> -		else
> -		    ext_ref = false;
> +	st->vref_reg = devm_regulator_get_optional(&spi->dev, "REF");
> +	if (IS_ERR(st->vref_reg)) {
> +		ret = PTR_ERR(st->vref_reg);

devm_regulator_get_optional returns a ptr  encoding -ENODEV if the
regulator is not supplied.  That isn't an error here so needs to be
handled differently from other error codes.

> +		goto err_disable_vdd_reg;
>  	}
>  
> -	if (ext_ref) {
> -		st->vref_reg = devm_regulator_get(&spi->dev, "REF");
> -		if (IS_ERR(st->vref_reg)) {
> -			ret = PTR_ERR(st->vref_reg);
> -			goto err_disable_vdd_reg;
> -		}
> -
> +	if (st->vref_reg) {
>  		ret = regulator_enable(st->vref_reg);
>  		if (ret)
>  			goto err_disable_vdd_reg;

