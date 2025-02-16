Return-Path: <linux-iio+bounces-15580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D1CA3759B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E825163088
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2FD19ADA2;
	Sun, 16 Feb 2025 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzzzP1yV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32019ABC3;
	Sun, 16 Feb 2025 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722509; cv=none; b=WyMXEa61KKM+8sXLbTrkzT/ON33BlDO9oanlnIM/5uG0Pc0rCTSyCUZOtO2Kg9a8kRS0Xrg7ypjPmBdYRSL9bxn3o/ir6GYw1J+hBKRAivPC+Y0AJx+idKOGE4rcLA0oUDfWDegC927sn0Q2VqSjlA0GLzjojIsVBeyJhdcBhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722509; c=relaxed/simple;
	bh=cN6cpr4EL2mJeOn4Fl/18etOSqcDsy+IcC7FKlJp72s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLoeQg+0WEZtTtM5QxknNS199avRaSzpHT53xDUu8B5hhdSezsr7+URunLoK0FyGXOrQmx9tqCSH+9gGp/Ybxe/VecrAaKnzrX0xx/r63biHNDPTZJWORydPsAd9IbGxVONWzFO0eFqC7EhzsTVDZ/LyEtwZ2Owc/XhQ/iAKRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzzzP1yV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B44C4CEDD;
	Sun, 16 Feb 2025 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739722509;
	bh=cN6cpr4EL2mJeOn4Fl/18etOSqcDsy+IcC7FKlJp72s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DzzzP1yVCXJ4+fHZ1/dlOCY6NdTM/TBHYaJmR+JMsgxEhI1Peqs1BImqS5hTPOeU/
	 HqQDrVkaxpwzlFT+zZZSGsVgbnbDdt7ayTCKsfd07yJetnnXoEP06rKaa8EpTjTWhN
	 2w0S4s8lFhinBNtWGJLQq2wmagGRZ2CmpFdSqBMio3q5UqvngXMGN5EBezC1Uqm678
	 +G6dBZP46dqW2K5w12mq0YQh14scRcAmuLZg8RHWHBlYraS8DAdTgyk/hXoO9qGPaC
	 wLotDB7v7QLca9Vx39Fp4/88x7F7HYVG3dKhloyyfDNI7VOiiuknz4AQL8xYC/iAZl
	 ArAUVh2wKhPKA==
Date: Sun, 16 Feb 2025 16:14:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>,
 <dlechner@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH RESEND v3 12/17] iio: adc: ad7768-1: Add GPIO controller
 support
Message-ID: <20250216161458.0f9029e9@jic23-huawei>
In-Reply-To: <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
	<62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 15:18:04 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The AD7768-1 has the ability to control other local hardware (such as gain
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
> 
> This change exports the AD7768-1's four gpios and makes them accessible
> at an upper layer.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

Similar to previous.  +CC the gpio driver maintainers.
Whilst small part of this much larger driver, good to make sure
they have visibility and can choose whether to review or not.

+CC Linus, Bartosz and the linux-gpio list.
Probably also worth calling out in this patch description the reason we can't set
the GPIO state when in buffered mode as that won't be obvious to
anyone just reviewing the GPIO part of the driver.

> ---
> v3 Changes:
> * Fixed SoB order.
> * Added mising iio_device_release_direct_mode().
> * Simplified some regmap writes.
> * Removed ad7768_gpio_request() callback.
> * Fixed line wrapping.
> 
> v2 Changes:
> * Replaced mutex for iio_device_claim_direct_mode().
> * Use gpio-controller property to conditionally enable the
>   GPIO support.
> * OBS: when the GPIO is configured as output, we should read 
>   the current state value from AD7768_REG_GPIO_WRITE.
> ---
>  drivers/iio/adc/ad7768-1.c | 143 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 141 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index a359cd8fceca..afcc8678cf83 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -9,6 +9,8 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -86,6 +88,16 @@
>  #define AD7768_REG_ANALOG2_VCM_MSK	GENMASK(2, 0)
>  #define AD7768_REG_ANALOG2_VCM(x)	FIELD_PREP(AD7768_REG_ANALOG2_VCM_MSK, x)
>  
> +/* AD7768_REG_GPIO_CONTROL */
> +#define AD7768_GPIO_UNIVERSAL_EN	BIT(7)
> +#define AD7768_GPIO_CONTROL_MSK		GENMASK(3, 0)
> +
> +/* AD7768_REG_GPIO_WRITE */
> +#define AD7768_GPIO_WRITE_MSK		GENMASK(3, 0)
> +
> +/* AD7768_REG_GPIO_READ */
> +#define AD7768_GPIO_READ_MSK		GENMASK(3, 0)
> +
>  #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
>  #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
>  
> @@ -170,6 +182,7 @@ struct ad7768_state {
>  	struct regulator *vref;
>  	struct regulator_dev *vcm_rdev;
>  	struct clk *mclk;
> +	struct gpio_chip gpiochip;
>  	unsigned int mclk_freq;
>  	unsigned int samp_freq;
>  	struct completion completion;
> @@ -349,6 +362,124 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
>  	return 0;
>  }
>  
> +static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
> +				BIT(offset));
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int ad7768_gpio_direction_output(struct gpio_chip *chip,
> +					unsigned int offset, int value)
> +{
> +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
> +			      BIT(offset));
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int ad7768_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &val);
> +	if (ret)
> +		goto err_release;
> +
> +	/*
> +	 * If the GPIO is configured as an output, read the current value from
> +	 * AD7768_REG_GPIO_WRITE. Otherwise, read the input value from
> +	 * AD7768_REG_GPIO_READ.
> +	 */
> +	if (val & BIT(offset))
> +		ret = regmap_read(st->regmap, AD7768_REG_GPIO_WRITE, &val);
> +	else
> +		ret = regmap_read(st->regmap, AD7768_REG_GPIO_READ, &val);
> +	if (ret)
> +		goto err_release;
> +
> +	ret = !!(val & BIT(offset));
> +err_release:
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static void ad7768_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> +{
> +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &val);
> +	if (ret)
> +		goto err_release;
> +
> +	if (val & BIT(offset))
> +		regmap_update_bits(st->regmap, AD7768_REG_GPIO_WRITE,
> +				   BIT(offset), value << offset);
> +
> +err_release:
> +	iio_device_release_direct_mode(indio_dev);
> +}
> +
> +static int ad7768_gpio_init(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL,
> +			   AD7768_GPIO_UNIVERSAL_EN);
> +	if (ret)
> +		return ret;
> +
> +	st->gpiochip = (struct gpio_chip) {
> +		.label = "ad7768_1_gpios",
> +		.base = -1,
> +		.ngpio = 4,
> +		.parent = &st->spi->dev,
> +		.can_sleep = true,
> +		.direction_input = ad7768_gpio_direction_input,
> +		.direction_output = ad7768_gpio_direction_output,
> +		.get = ad7768_gpio_get,
> +		.set = ad7768_gpio_set,
> +		.owner = THIS_MODULE,
> +	};
> +
> +	return gpiochip_add_data(&st->gpiochip, indio_dev);
> +}
> +
>  static int ad7768_set_freq(struct ad7768_state *st,
>  			   unsigned int freq)
>  {
> @@ -492,8 +623,9 @@ static const struct iio_info ad7768_info = {
>  	.debugfs_reg_access = &ad7768_reg_access,
>  };
>  
> -static int ad7768_setup(struct ad7768_state *st)
> +static int ad7768_setup(struct iio_dev *indio_dev)
>  {
> +	struct ad7768_state *st = iio_priv(indio_dev);
>  	int ret;
>  
>  	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
> @@ -526,6 +658,13 @@ static int ad7768_setup(struct ad7768_state *st)
>  	if (IS_ERR(st->gpio_sync_in))
>  		return PTR_ERR(st->gpio_sync_in);
>  
> +	/* Only create a Chip GPIO if flagged for it */
> +	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
> +		ret = ad7768_gpio_init(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	/* Set the default sampling frequency to 32000 kSPS */
>  	return ad7768_set_freq(st, 32000);
>  }
> @@ -845,7 +984,7 @@ static int ad7768_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = ad7768_setup(st);
> +	ret = ad7768_setup(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "AD7768 setup failed\n");
>  		return ret;


