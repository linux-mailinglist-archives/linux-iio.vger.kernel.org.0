Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E9843E3B6
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhJ1ObC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 10:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhJ1ObB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 10:31:01 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87FDD60F70;
        Thu, 28 Oct 2021 14:28:33 +0000 (UTC)
Date:   Thu, 28 Oct 2021 15:32:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ms5611: Simplify IO callback parameters
Message-ID: <20211028153259.2dc6647b@jic23-huawei>
In-Reply-To: <20211020142110.7060-1-lars@metafoo.de>
References: <20211020142110.7060-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Oct 2021 16:21:10 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The ms5611 passes &indio_dev->dev as a parameter to all its IO callbacks
> only to directly cast the struct device back to struct iio_dev. And the
> struct iio_dev is then only used to get the drivers state struct.
> 
> Simplify this a bit by passing the state struct directly. This makes it a
> bit easier to follow what the code is doing.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Make sense to me.

Applied to the togreg branch of iio.git and pushed out as testing to let
0-day poke at it for a few weeks.

Plenty of time for more reviews before I push this out as a non rebasing
tree.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/ms5611.h      |  6 +++---
>  drivers/iio/pressure/ms5611_core.c |  7 +++----
>  drivers/iio/pressure/ms5611_i2c.c  | 11 ++++-------
>  drivers/iio/pressure/ms5611_spi.c  | 17 +++++++----------
>  4 files changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
> index 86b1c4b1820d..cbc9349c342a 100644
> --- a/drivers/iio/pressure/ms5611.h
> +++ b/drivers/iio/pressure/ms5611.h
> @@ -50,9 +50,9 @@ struct ms5611_state {
>  	const struct ms5611_osr *pressure_osr;
>  	const struct ms5611_osr *temp_osr;
>  
> -	int (*reset)(struct device *dev);
> -	int (*read_prom_word)(struct device *dev, int index, u16 *word);
> -	int (*read_adc_temp_and_pressure)(struct device *dev,
> +	int (*reset)(struct ms5611_state *st);
> +	int (*read_prom_word)(struct ms5611_state *st, int index, u16 *word);
> +	int (*read_adc_temp_and_pressure)(struct ms5611_state *st,
>  					  s32 *temp, s32 *pressure);
>  
>  	struct ms5611_chip_info *chip_info;
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index ee75f08655c9..a4d0b54cde9b 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -85,8 +85,7 @@ static int ms5611_read_prom(struct iio_dev *indio_dev)
>  	struct ms5611_state *st = iio_priv(indio_dev);
>  
>  	for (i = 0; i < MS5611_PROM_WORDS_NB; i++) {
> -		ret = st->read_prom_word(&indio_dev->dev,
> -					 i, &st->chip_info->prom[i]);
> +		ret = st->read_prom_word(st, i, &st->chip_info->prom[i]);
>  		if (ret < 0) {
>  			dev_err(&indio_dev->dev,
>  				"failed to read prom at %d\n", i);
> @@ -108,7 +107,7 @@ static int ms5611_read_temp_and_pressure(struct iio_dev *indio_dev,
>  	int ret;
>  	struct ms5611_state *st = iio_priv(indio_dev);
>  
> -	ret = st->read_adc_temp_and_pressure(&indio_dev->dev, temp, pressure);
> +	ret = st->read_adc_temp_and_pressure(st, temp, pressure);
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev,
>  			"failed to read temperature and pressure\n");
> @@ -196,7 +195,7 @@ static int ms5611_reset(struct iio_dev *indio_dev)
>  	int ret;
>  	struct ms5611_state *st = iio_priv(indio_dev);
>  
> -	ret = st->reset(&indio_dev->dev);
> +	ret = st->reset(st);
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev, "failed to reset device\n");
>  		return ret;
> diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
> index 5c82d80f85b6..1047a85527a9 100644
> --- a/drivers/iio/pressure/ms5611_i2c.c
> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -20,17 +20,15 @@
>  
>  #include "ms5611.h"
>  
> -static int ms5611_i2c_reset(struct device *dev)
> +static int ms5611_i2c_reset(struct ms5611_state *st)
>  {
> -	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
> -
>  	return i2c_smbus_write_byte(st->client, MS5611_RESET);
>  }
>  
> -static int ms5611_i2c_read_prom_word(struct device *dev, int index, u16 *word)
> +static int ms5611_i2c_read_prom_word(struct ms5611_state *st, int index,
> +				     u16 *word)
>  {
>  	int ret;
> -	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
>  
>  	ret = i2c_smbus_read_word_swapped(st->client,
>  			MS5611_READ_PROM_WORD + (index << 1));
> @@ -57,11 +55,10 @@ static int ms5611_i2c_read_adc(struct ms5611_state *st, s32 *val)
>  	return 0;
>  }
>  
> -static int ms5611_i2c_read_adc_temp_and_pressure(struct device *dev,
> +static int ms5611_i2c_read_adc_temp_and_pressure(struct ms5611_state *st,
>  						 s32 *temp, s32 *pressure)
>  {
>  	int ret;
> -	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
>  	const struct ms5611_osr *osr = st->temp_osr;
>  
>  	ret = i2c_smbus_write_byte(st->client, osr->cmd);
> diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> index 79bed64c9b68..9fa2dcd71760 100644
> --- a/drivers/iio/pressure/ms5611_spi.c
> +++ b/drivers/iio/pressure/ms5611_spi.c
> @@ -15,18 +15,17 @@
>  
>  #include "ms5611.h"
>  
> -static int ms5611_spi_reset(struct device *dev)
> +static int ms5611_spi_reset(struct ms5611_state *st)
>  {
>  	u8 cmd = MS5611_RESET;
> -	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
>  
>  	return spi_write_then_read(st->client, &cmd, 1, NULL, 0);
>  }
>  
> -static int ms5611_spi_read_prom_word(struct device *dev, int index, u16 *word)
> +static int ms5611_spi_read_prom_word(struct ms5611_state *st, int index,
> +				     u16 *word)
>  {
>  	int ret;
> -	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
>  
>  	ret = spi_w8r16be(st->client, MS5611_READ_PROM_WORD + (index << 1));
>  	if (ret < 0)
> @@ -37,11 +36,10 @@ static int ms5611_spi_read_prom_word(struct device *dev, int index, u16 *word)
>  	return 0;
>  }
>  
> -static int ms5611_spi_read_adc(struct device *dev, s32 *val)
> +static int ms5611_spi_read_adc(struct ms5611_state *st, s32 *val)
>  {
>  	int ret;
>  	u8 buf[3] = { MS5611_READ_ADC };
> -	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
>  
>  	ret = spi_write_then_read(st->client, buf, 1, buf, 3);
>  	if (ret < 0)
> @@ -52,11 +50,10 @@ static int ms5611_spi_read_adc(struct device *dev, s32 *val)
>  	return 0;
>  }
>  
> -static int ms5611_spi_read_adc_temp_and_pressure(struct device *dev,
> +static int ms5611_spi_read_adc_temp_and_pressure(struct ms5611_state *st,
>  						 s32 *temp, s32 *pressure)
>  {
>  	int ret;
> -	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
>  	const struct ms5611_osr *osr = st->temp_osr;
>  
>  	/*
> @@ -68,7 +65,7 @@ static int ms5611_spi_read_adc_temp_and_pressure(struct device *dev,
>  		return ret;
>  
>  	usleep_range(osr->conv_usec, osr->conv_usec + (osr->conv_usec / 10UL));
> -	ret = ms5611_spi_read_adc(dev, temp);
> +	ret = ms5611_spi_read_adc(st, temp);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -78,7 +75,7 @@ static int ms5611_spi_read_adc_temp_and_pressure(struct device *dev,
>  		return ret;
>  
>  	usleep_range(osr->conv_usec, osr->conv_usec + (osr->conv_usec / 10UL));
> -	return ms5611_spi_read_adc(dev, pressure);
> +	return ms5611_spi_read_adc(st, pressure);
>  }
>  
>  static int ms5611_spi_probe(struct spi_device *spi)

