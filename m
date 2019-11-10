Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1BEF6993
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 16:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfKJPQC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 10:16:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfKJPQB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 10:16:01 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11AB820869;
        Sun, 10 Nov 2019 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573398960;
        bh=nOYnLsFrGyMmeJR4IIF0o6mJyW/v1EWL9wkBIouF9h0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C/6ruit22RchvVWXdzE/uT7AOJJjoMTreXDHFRgv07PUQGgGNF+cNLp+KsVQnpUEc
         eIkmmqs5WMobBNLangJ1S398XBD0XcRnZVc7LQxqDvDBeEDuofmhMqBbFfDYSPqmuh
         cEtzU3+9mIs7LCrksUQMESw0oOnfkeqJLlKbl5/Q=
Date:   Sun, 10 Nov 2019 15:15:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH] iio: dac: ad5446: Add support for new AD5600 DAC
Message-ID: <20191110151555.38a0bb37@archlinux>
In-Reply-To: <20191106094721.25575-1-alexandru.ardelean@analog.com>
References: <20191106094721.25575-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 6 Nov 2019 11:47:21 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Stefan Popa <stefan.popa@analog.com>
> 
> The AD5600 is a single channel, 16-bit resolution, voltage output digital
> to analog converter (DAC). The AD5600 uses a 3-wire SPI interface. It is
> part of the AD5541 family of DACs.
> 
> The ad5446 IIO driver implements support for some of these DACs (in the
> AD5441 family), so the change is a simple entry in this driver.
> 
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5600.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing

Thanks,

Jonathan

> ---
>  drivers/iio/dac/Kconfig  | 4 ++--
>  drivers/iio/dac/ad5446.c | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index cc42219a64f7..979070196da9 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -60,8 +60,8 @@ config AD5446
>  	help
>  	  Say yes here to build support for Analog Devices AD5300, AD5301, AD5310,
>  	  AD5311, AD5320, AD5321, AD5444, AD5446, AD5450, AD5451, AD5452, AD5453,
> -	  AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5601, AD5602, AD5611, AD5612,
> -	  AD5620, AD5621, AD5622, AD5640, AD5641, AD5660, AD5662 DACs
> +	  AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5600, AD5601, AD5602, AD5611,
> +	  AD5612, AD5620, AD5621, AD5622, AD5640, AD5641, AD5660, AD5662 DACs
>  	  as well as Texas Instruments DAC081S101, DAC101S101, DAC121S101.
>  
>  	  To compile this driver as a module, choose M here: the
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index 7df8b4cc295d..61c670f7fc5f 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -327,6 +327,7 @@ enum ad5446_supported_spi_device_ids {
>  	ID_AD5541A,
>  	ID_AD5512A,
>  	ID_AD5553,
> +	ID_AD5600,
>  	ID_AD5601,
>  	ID_AD5611,
>  	ID_AD5621,
> @@ -381,6 +382,10 @@ static const struct ad5446_chip_info ad5446_spi_chip_info[] = {
>  		.channel = AD5446_CHANNEL(14, 16, 0),
>  		.write = ad5446_write,
>  	},
> +	[ID_AD5600] = {
> +		.channel = AD5446_CHANNEL(16, 16, 0),
> +		.write = ad5446_write,
> +	},
>  	[ID_AD5601] = {
>  		.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 6),
>  		.write = ad5446_write,
> @@ -448,6 +453,7 @@ static const struct spi_device_id ad5446_spi_ids[] = {
>  	{"ad5542a", ID_AD5541A}, /* ad5541a and ad5542a are compatible */
>  	{"ad5543", ID_AD5541A}, /* ad5541a and ad5543 are compatible */
>  	{"ad5553", ID_AD5553},
> +	{"ad5600", ID_AD5600},
>  	{"ad5601", ID_AD5601},
>  	{"ad5611", ID_AD5611},
>  	{"ad5621", ID_AD5621},

