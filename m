Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22FBC77E86
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 09:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfG1H7P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 03:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfG1H7P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jul 2019 03:59:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58CF7214C6;
        Sun, 28 Jul 2019 07:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564300754;
        bh=uyNwFO/2WaZym/Btyl8etoUfiutNdN0xZKXJWmBE+so=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pO4WnONDbtvvX94/jEsvujnCdsDTduPcfrpFEFkZUx/lBD4H7J/vw0+hkvo8XSdjX
         9LGfBiB0MZ1dlSiqRzVNgAbrhwqFx0/t8R7q634pThhvOUioHwGzvHKkPdIhyk0az6
         kjzUvPtHTVVAxzl8tDmD0UoCTRLnkdm3jCKAdKpU=
Date:   Sun, 28 Jul 2019 08:57:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <biabeniamin@outlook.com>
Subject: Re: [PATCH 1/5] iio: adc: ad7606: Move common channel definition to
 header
Message-ID: <20190728085719.71ff3be7@archlinux>
In-Reply-To: <20190718062734.17306-1-beniamin.bia@analog.com>
References: <20190718062734.17306-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 09:27:30 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> The common channel definition which are going to be used by both core
> file but also spi file, were moved in header file. Some devices have
> different channel definitions when are used in software mode, feature
> available only with spi, and those definitions will be added in spi file.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> -nothing changed
> 
>  drivers/iio/adc/ad7606.c | 23 -----------------------
>  drivers/iio/adc/ad7606.h | 23 +++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index aba0fd123a51..a49dc106a21c 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -308,29 +308,6 @@ static const struct attribute_group ad7606_attribute_group_range = {
>  	.attrs = ad7606_attributes_range,
>  };
>  
> -#define AD760X_CHANNEL(num, mask) {				\
> -		.type = IIO_VOLTAGE,				\
> -		.indexed = 1,					\
> -		.channel = num,					\
> -		.address = num,					\
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
> -		.info_mask_shared_by_all = mask,		\
> -		.scan_index = num,				\
> -		.scan_type = {					\
> -			.sign = 's',				\
> -			.realbits = 16,				\
> -			.storagebits = 16,			\
> -			.endianness = IIO_CPU,			\
> -		},						\
> -}
> -
> -#define AD7605_CHANNEL(num)	\
> -	AD760X_CHANNEL(num, 0)
> -
> -#define AD7606_CHANNEL(num)	\
> -	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> -
>  static const struct iio_chan_spec ad7605_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
>  	AD7605_CHANNEL(0),
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index d8a509c2c428..d547e88f4c9d 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -8,6 +8,29 @@
>  #ifndef IIO_ADC_AD7606_H_
>  #define IIO_ADC_AD7606_H_
>  
> +#define AD760X_CHANNEL(num, mask) {				\
> +		.type = IIO_VOLTAGE,				\
> +		.indexed = 1,					\
> +		.channel = num,					\
> +		.address = num,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
> +		.info_mask_shared_by_all = mask,		\
> +		.scan_index = num,				\
> +		.scan_type = {					\
> +			.sign = 's',				\
> +			.realbits = 16,				\
> +			.storagebits = 16,			\
> +			.endianness = IIO_CPU,			\
> +		},						\
> +}
> +
> +#define AD7605_CHANNEL(num)	\
> +	AD760X_CHANNEL(num, 0)
> +
> +#define AD7606_CHANNEL(num)	\
> +	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> +
>  /**
>   * struct ad7606_chip_info - chip specific information
>   * @channels:		channel specification

