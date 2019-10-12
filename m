Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFA5D4F4E
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 13:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfJLLec (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 07:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfJLLec (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 07:34:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6122196E;
        Sat, 12 Oct 2019 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570880071;
        bh=ONFdPvpx8+v3y0XIvRvQ8dm731zUd9kFlL1wfUWEIDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cTyFeKI2NHMU0I66JwYGmyBmT2JaVrXPVhuqfSYdy6axmCw/uVa1JFr7enYQaj07H
         13MVGV/j4oKUnpw8RuGmXt6eWXL+LEdZJivDAccbLNHIjzm42+FOqRA7bc8md3y0ls
         6qBiWUgDdDJ4I41y4gcm4bWaSLjj3bJ6TybfTC30=
Date:   Sat, 12 Oct 2019 12:30:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 5/8] iio: adc: max1027: Introduce 12-bit devices
 support
Message-ID: <20191012123040.41e22379@archlinux>
In-Reply-To: <20191011144347.19146-6-miquel.raynal@bootlin.com>
References: <20191011144347.19146-1-miquel.raynal@bootlin.com>
        <20191011144347.19146-6-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 16:43:44 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Maxim's max12xx series is very similar to the max10xx series, with the
> difference of the measurements depth which is upgraded from 10 to 12
> bits per channel. Everything else looks the same.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig   |  4 ++--
>  drivers/iio/adc/max1027.c | 38 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f0af3a42f53c..6ac16d738822 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -508,8 +508,8 @@ config MAX1027
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  Say yes here to build support for Maxim SPI ADC models
> -	  max1027, max1029 and max1031.
> +	  Say yes here to build support for Maxim SPI {10,12}-bit ADC models:
> +	  max1027, max1029, max1031, max1227, max1229 and max1231.
>  
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called max1027.
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 8b449044bef5..e171db20c04a 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -63,12 +63,18 @@ enum max1027_id {
>  	max1027,
>  	max1029,
>  	max1031,
> +	max1227,
> +	max1229,
> +	max1231,
>  };
>  
>  static const struct spi_device_id max1027_id[] = {
>  	{"max1027", max1027},
>  	{"max1029", max1029},
>  	{"max1031", max1031},
> +	{"max1227", max1227},
> +	{"max1229", max1229},
> +	{"max1231", max1231},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, max1027_id);
> @@ -78,6 +84,9 @@ static const struct of_device_id max1027_adc_dt_ids[] = {
>  	{ .compatible = "maxim,max1027" },
>  	{ .compatible = "maxim,max1029" },
>  	{ .compatible = "maxim,max1031" },
> +	{ .compatible = "maxim,max1227" },
> +	{ .compatible = "maxim,max1229" },
> +	{ .compatible = "maxim,max1231" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
> @@ -153,6 +162,18 @@ static const struct iio_chan_spec max1031_channels[] = {
>  	MAX1X31_CHANNELS(10),
>  };
>  
> +static const struct iio_chan_spec max1227_channels[] = {
> +	MAX1X27_CHANNELS(12),
> +};
> +
> +static const struct iio_chan_spec max1229_channels[] = {
> +	MAX1X29_CHANNELS(12),
> +};
> +
> +static const struct iio_chan_spec max1231_channels[] = {
> +	MAX1X31_CHANNELS(12),
> +};
> +
>  static const unsigned long max1027_available_scan_masks[] = {
>  	0x000001ff,
>  	0x00000000,
> @@ -190,6 +211,21 @@ static const struct max1027_chip_info max1027_chip_info_tbl[] = {
>  		.num_channels = ARRAY_SIZE(max1031_channels),
>  		.available_scan_masks = max1031_available_scan_masks,
>  	},
> +	[max1227] = {
> +		.channels = max1227_channels,
> +		.num_channels = ARRAY_SIZE(max1227_channels),
> +		.available_scan_masks = max1027_available_scan_masks,
> +	},
> +	[max1229] = {
> +		.channels = max1229_channels,
> +		.num_channels = ARRAY_SIZE(max1229_channels),
> +		.available_scan_masks = max1029_available_scan_masks,
> +	},
> +	[max1231] = {
> +		.channels = max1231_channels,
> +		.num_channels = ARRAY_SIZE(max1231_channels),
> +		.available_scan_masks = max1031_available_scan_masks,
> +	},
>  };
>  
>  struct max1027_state {
> @@ -486,5 +522,5 @@ static struct spi_driver max1027_driver = {
>  module_spi_driver(max1027_driver);
>  
>  MODULE_AUTHOR("Philippe Reynes <tremyfr@yahoo.fr>");
> -MODULE_DESCRIPTION("MAX1027/MAX1029/MAX1031 ADC");
> +MODULE_DESCRIPTION("MAX1X27/MAX1X29/MAX1X31 ADC");
>  MODULE_LICENSE("GPL v2");

