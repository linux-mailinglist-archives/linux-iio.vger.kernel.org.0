Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDCC0571F0
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 21:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFZTnQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 15:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZTnQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 15:43:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F31A2085A;
        Wed, 26 Jun 2019 19:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561578194;
        bh=Fc100cECJjr5SYsyo1x+bSAh9OozTjsFyISKkg06BI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r0jTRwG/VgVF5HIa8xdJFmtYFTjwr0HEf+AJg1hAormiJeVRprt46yXEBVy/IiOG2
         +tbOcPO/+bc78x8ge7jPLFtYkeKQRJvD6IiCWHgq/yMFvzsLr8OzWOwhonK92BUeMz
         EozTjTV+VhtUT+YuXPl0QENSEkLKvgxrbjkqi5kU=
Date:   Wed, 26 Jun 2019 20:43:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio: frequency: adf4371: Add support for ADF4372
 PLL
Message-ID: <20190626204309.723e2f97@archlinux>
In-Reply-To: <1561389132-26182-1-git-send-email-stefan.popa@analog.com>
References: <1561389132-26182-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Jun 2019 18:12:12 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The ADF4372 is part of the same family with ADF4371, the main difference
> is that it has only 3 channels instead of 4, as the frequency quadrupler
> is missing. As a result, the ADF4372 allows frequencies from 62.5 MHz to
> 16 GHz to be generated.
> 
> Datasheet:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adf4372.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Straight forward, so applied to the togreg branch of iio.git and pushed
out as testing. I'll probably do the pull request tomorrow, so hopefully
it will make the merge window.

Thanks,

Jonathan

> ---
>  drivers/iio/frequency/Kconfig   |  6 +++---
>  drivers/iio/frequency/adf4371.c | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index e4a921f..353914b 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -39,12 +39,12 @@ config ADF4350
>  	  module will be called adf4350.
>  
>  config ADF4371
> -	tristate "Analog Devices ADF4371 Wideband Synthesizer"
> +	tristate "Analog Devices ADF4371/ADF4372 Wideband Synthesizers"
>  	depends on SPI
>  	select REGMAP_SPI
>  	help
> -	  Say yes here to build support for Analog Devices  ADF4371
> -	  Wideband Synthesizer. The driver provides direct access via sysfs.
> +	  Say yes here to build support for Analog Devices ADF4371 and ADF4372
> +	  Wideband Synthesizers. The driver provides direct access via sysfs.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adf4371.
> diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
> index d8c414b..f874219 100644
> --- a/drivers/iio/frequency/adf4371.c
> +++ b/drivers/iio/frequency/adf4371.c
> @@ -87,6 +87,11 @@ enum {
>  	ADF4371_CH_RF32
>  };
>  
> +enum adf4371_variant {
> +	ADF4371,
> +	ADF4372
> +};
> +
>  struct adf4371_pwrdown {
>  	unsigned int reg;
>  	unsigned int bit;
> @@ -140,6 +145,11 @@ static const struct regmap_config adf4371_regmap_config = {
>  	.read_flag_mask = BIT(7),
>  };
>  
> +struct adf4371_chip_info {
> +	unsigned int num_channels;
> +	const struct iio_chan_spec *channels;
> +};
> +
>  struct adf4371_state {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
> @@ -152,6 +162,7 @@ struct adf4371_state {
>  	 * writes.
>  	 */
>  	struct mutex lock;
> +	const struct adf4371_chip_info *chip_info;
>  	unsigned long clkin_freq;
>  	unsigned long fpfd;
>  	unsigned int integer;
> @@ -429,6 +440,17 @@ static const struct iio_chan_spec adf4371_chan[] = {
>  	ADF4371_CHANNEL(ADF4371_CH_RF32),
>  };
>  
> +static const struct adf4371_chip_info adf4371_chip_info[] = {
> +	[ADF4371] = {
> +		.channels = adf4371_chan,
> +		.num_channels = 4,
> +	},
> +	[ADF4372] = {
> +		.channels = adf4371_chan,
> +		.num_channels = 3,
> +	}
> +};
> +
>  static int adf4371_reg_access(struct iio_dev *indio_dev,
>  			      unsigned int reg,
>  			      unsigned int writeval,
> @@ -537,12 +559,13 @@ static int adf4371_probe(struct spi_device *spi)
>  	st->regmap = regmap;
>  	mutex_init(&st->lock);
>  
> +	st->chip_info = &adf4371_chip_info[id->driver_data];
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = id->name;
>  	indio_dev->info = &adf4371_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = adf4371_chan;
> -	indio_dev->num_channels = ARRAY_SIZE(adf4371_chan);
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = st->chip_info->num_channels;
>  
>  	st->clkin = devm_clk_get(&spi->dev, "clkin");
>  	if (IS_ERR(st->clkin))
> @@ -568,13 +591,15 @@ static int adf4371_probe(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id adf4371_id_table[] = {
> -	{ "adf4371", 0 },
> +	{ "adf4371", ADF4371 },
> +	{ "adf4372", ADF4372 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, adf4371_id_table);
>  
>  static const struct of_device_id adf4371_of_match[] = {
>  	{ .compatible = "adi,adf4371" },
> +	{ .compatible = "adi,adf4372" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, adf4371_of_match);

