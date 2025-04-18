Return-Path: <linux-iio+bounces-18263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4B7A939AD
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFA18A6C6E
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E3213227;
	Fri, 18 Apr 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjanPdXR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99EF9EC;
	Fri, 18 Apr 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990518; cv=none; b=ex2+PErpj7mTG7r7tF2c6FZuM8KMJINyIWyqAk/fRQxyv6AnfcVdUoVALBDDsGabftCPvpJ9mvvIX5zOAWvOaKddgUy8vlv0ve/gDQctEAeK9g92W5bcCViJ5PRrsEaAhYP9q4eYLyt/81EIm8GSEW2BZ6oXlvgCWKygmOY8d48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990518; c=relaxed/simple;
	bh=P4t0RS1mi3GBrCyrkQOyER8mTaJlcoQB6fJm195efpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dm5G9AJzkQjm2do+N4YmPdmzXefvFXb+qhXfmYNy45vhuSJsrB3Nsl1iB/37wHnujHxoUsLqA0a3ZlHem/78tGg80F2eVeNdGjbABXLNHDXVTCwFAhl+UqBpkHm/65lV3jhql4MnWv5t261hy1S0LtByMK7JXottHXbNkfdW/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjanPdXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF802C4CEE2;
	Fri, 18 Apr 2025 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990516;
	bh=P4t0RS1mi3GBrCyrkQOyER8mTaJlcoQB6fJm195efpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OjanPdXRCCAM8w+d65aZF7IrMXpBdECIo7HnQXWK4zqvCQ0udXvwCGq6UOctPeX5D
	 5MFs+3ecskaa9VMkvHgDn7X/fzOryH3fIiafVGaMVrjHAAjNYT0f/xsG3EXEMUdfki
	 1qyGywlZDWDB4msCKvkbminkXxijgfYQaHj4Ao1TrmJuBLvo9zC1UB4mQu9RXipkEI
	 T8vvFnZoJ4nqmLN56LWjkVGMr9F1qyGPLnkwULRS4GmqQkVgd2yF2oiHWbDsordm+g
	 +oDj8wfZWYP8cy0H7FK+ERqndrBBw5St/PxsVvfrG5ypclrE15biQ/p8+dg5w1ovo1
	 xtT3EWAQhGTuA==
Date: Fri, 18 Apr 2025 16:35:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, sonic.zhang@analog.com, vapier@gentoo.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: Include valid channel for channel
 selection
Message-ID: <20250418163510.5dac416e@jic23-huawei>
In-Reply-To: <20250417170109.602659-1-gshahrouzi@gmail.com>
References: <20250417170109.602659-1-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 13:01:09 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> According to the datasheet on page 9 under the channel selection table,
> all devices (AD7816/7/8) are able to use the channel marked as 7. This
> channel is used for diagnostic purposes by routing the internal 1.23V
> bandgap source through the MUX to the input of the ADC.
> 
> Replace checking for string equality with checking for the same chip ID
> to reduce time complexity.
> 
> Group invalid channels for all devices together because they are
> processed the same way.
> 
> Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>

This is doing too many things for one patch.  The fix wants be
on it's own. Ideally before everything else but if that is tricky to do
then I don't mind that much.

> ---
> Changes since v2:
> 	- Refactor by adding chip_info struct which simplifies
> 	  condtional logic.
> ---
>  drivers/staging/iio/adc/ad7816.c | 68 ++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 6c14d7bcdd675..ec955cbf06c17 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -41,8 +41,20 @@
>   * struct ad7816_chip_info - chip specific information
>   */
>  
> +enum ad7816_type {
> +	ID_AD7816,
> +	ID_AD7817,
> +	ID_AD7818,
> +};
The aim of moving to a chip_info structure is typically
to get rid of this sort of enum in favour of specific data
in the chip_info structures.  Anyhow see below for more on that.

> +
>  struct ad7816_chip_info {
> -	kernel_ulong_t id;
> +	const char *name;
> +	enum ad7816_type type;
> +	u8 max_channels;
> +};
> +
> +struct ad7816_state {

This effective rename needs to be a patch on it's own before
you introduce the new struct ad7816_chip_info.  That lets
us clearly see that all instances are renamed and is
an easy patch to review as it's just a rename.

> +	const struct ad7816_chip_info *chip_info;
>  	struct spi_device *spi_dev;
>  	struct gpio_desc *rdwr_pin;
>  	struct gpio_desc *convert_pin;
> @@ -52,16 +64,11 @@ struct ad7816_chip_info {
>  	u8  mode;
>  };
>  
> -enum ad7816_type {
> -	ID_AD7816,
> -	ID_AD7817,
> -	ID_AD7818,
> -};
>
> @@ -215,7 +215,7 @@ static ssize_t ad7816_show_value(struct device *dev,
>  				 char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> +	struct ad7816_state *chip = iio_priv(indio_dev);
>  	u16 data;
>  	s8 value;
>  	int ret;
> @@ -271,7 +271,7 @@ static ssize_t ad7816_show_oti(struct device *dev,
>  			       char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> +	struct ad7816_state *chip = iio_priv(indio_dev);
>  	int value;
>  
>  	if (chip->channel_id > AD7816_CS_MAX) {
> @@ -292,7 +292,7 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
>  				     size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> +	struct ad7816_state *chip = iio_priv(indio_dev);
>  	long value;
>  	u8 data;
>  	int ret;
> @@ -345,14 +345,22 @@ static const struct iio_info ad7816_info = {
>  	.event_attrs = &ad7816_event_attribute_group,
>  };
>  
> +static const struct ad7816_chip_info ad7816_chip_infos[] = {
> +	[ID_AD7816] = { .name = "ad7816", .max_channels = 0, .type = ID_AD7816 },
Use separate named structures.

This approach with an enum and an array is something we used to do but it
actually obscures what is going on when compared with separate names structure
instances.

static const struct ad7816_chip_info ad7816_chip_info = {..};

static const struct ad7816_chip_info ad7817_chip_info = {..};

etc.
> +	[ID_AD7817] = { .name = "ad7817", .max_channels = 3, .type = ID_AD7817 },
> +	[ID_AD7818] = { .name = "ad7818", .max_channels = 1, .type = ID_AD7818 },
> +};
> +
>  /*
>   * device probe and remove
>   */
>  
>  static int ad7816_probe(struct spi_device *spi_dev)
>  {
> -	struct ad7816_chip_info *chip;
> +	struct ad7816_state *chip;
>  	struct iio_dev *indio_dev;
> +	const struct spi_device_id *id = spi_get_device_id(spi_dev);
> +	enum ad7816_type chip_type = (enum ad7816_type)id->driver_data;

Don't go via an enum.  Put pointers directly in the driver_data field.
+ if the driver has on in the of_match_id table as well.

Then use spi_get_device_match_data() to retrieve it in a firmware type
independent way.

Ideally by the end of the series you should no such enum

>  	int i, ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
> @@ -361,12 +369,12 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	chip = iio_priv(indio_dev);
>  	/* this is only used for device removal purposes */
>  	dev_set_drvdata(&spi_dev->dev, indio_dev);
> +	chip->chip_info = &ad7816_chip_infos[chip_type];
>  
>  	chip->spi_dev = spi_dev;
>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;
>  
> -	chip->id = spi_get_device_id(spi_dev)->driver_data;
>  	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
>  	if (IS_ERR(chip->rdwr_pin)) {
>  		ret = PTR_ERR(chip->rdwr_pin);
> @@ -382,7 +390,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  			ret);
>  		return ret;
>  	}
> -	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> +	if (chip->chip_info->type == ID_AD7816 || chip->chip_info->type == ID_AD7817) {

Given you now have a chip_info structure make this data rather than code.  That is
it should be something ilke

	if (chip->chip_info->has_busy_pin)

>  		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
>  						GPIOD_IN);
>  		if (IS_ERR(chip->busy_pin)) {
> @@ -393,7 +401,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  		}
>  	}
>  
> -	indio_dev->name = spi_get_device_id(spi_dev)->name;
> +	indio_dev->name = chip->chip_info->name;
>  	indio_dev->info = &ad7816_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  


