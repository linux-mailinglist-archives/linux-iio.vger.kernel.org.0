Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E87528A35F
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 01:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390385AbgJJW5J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Oct 2020 18:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731094AbgJJTxO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 15:53:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F91C223B0;
        Sat, 10 Oct 2020 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602346329;
        bh=/o6kc0w86AtQfZwMUUuejermsLWKUUm141TautCeueA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QthZT2Jf/4kVucgsha/eb8a9anw9MgY337YSbEsYgzCE2ZzgZUeJctUooOyDX2UUq
         9vElLjcUKvplOqDAwRQuZEjB2BRkKwEMxtPWw3WWZn6X4Kx5nKk2yxw5kyZb3b8QKh
         Am7IGbh6YH3KxHnzOX2YZe+86lQ7o/YVmVSIzbDU=
Date:   Sat, 10 Oct 2020 17:12:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: ad7887: invert/rework external ref logic
Message-ID: <20201010171205.56890964@archlinux>
In-Reply-To: <20201002082723.184810-1-alexandru.ardelean@analog.com>
References: <20201001141143.925-1-alexandru.ardelean@analog.com>
        <20201002082723.184810-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Oct 2020 11:27:23 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change inverts/reworks the logic to use an external reference via a
> provided regulator.
> 
> Now the driver tries to obtain a regulator. If one is found, then it is
> used. The rest of the driver logic already checks if there is a non-NULL
> reference to a regulator, so it should be fine.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Interestingly it seems something odd happened to my email and I was missing
random threads/part threads.  I've pulled them off lore.kernel.org but if
I seem to have lost anything let me know.

If anyone has a bounce message from me, please send it over as I'm curious
as to what went wrong!

Thanks,

Jonathan
 
> ---
> 
> Changelog v1 -> v2:
> * remove omitted '!pdata->use_onchip_ref' check; the field was removed from
>   the platform data, but was still used
> 
>  drivers/iio/adc/ad7887.c             | 12 ++++++++----
>  include/linux/platform_data/ad7887.h |  4 ----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 037bcb47693c..99a480ad3985 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -246,11 +246,15 @@ static int ad7887_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	if (!pdata || !pdata->use_onchip_ref) {
> -		st->reg = devm_regulator_get(&spi->dev, "vref");
> -		if (IS_ERR(st->reg))
> +	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
> +	if (IS_ERR(st->reg)) {
> +		if (PTR_ERR(st->reg) != -ENODEV)
>  			return PTR_ERR(st->reg);
>  
> +		st->reg = NULL;
> +	}
> +
> +	if (st->reg) {
>  		ret = regulator_enable(st->reg);
>  		if (ret)
>  			return ret;
> @@ -269,7 +273,7 @@ static int ad7887_probe(struct spi_device *spi)
>  	/* Setup default message */
>  
>  	mode = AD7887_PM_MODE4;
> -	if (!pdata || !pdata->use_onchip_ref)
> +	if (!st->reg)
>  		mode |= AD7887_REF_DIS;
>  	if (pdata && pdata->en_dual)
>  		mode |= AD7887_DUAL;
> diff --git a/include/linux/platform_data/ad7887.h b/include/linux/platform_data/ad7887.h
> index 732af46b2d16..9b4dca6ae70b 100644
> --- a/include/linux/platform_data/ad7887.h
> +++ b/include/linux/platform_data/ad7887.h
> @@ -13,13 +13,9 @@
>   *	second input channel, and Vref is internally connected to Vdd. If set to
>   *	false the device is used in single channel mode and AIN1/Vref is used as
>   *	VREF input.
> - * @use_onchip_ref: Whether to use the onchip reference. If set to true the
> - *	internal 2.5V reference is used. If set to false a external reference is
> - *	used.
>   */
>  struct ad7887_platform_data {
>  	bool en_dual;
> -	bool use_onchip_ref;
>  };
>  
>  #endif /* IIO_ADC_AD7887_H_ */

