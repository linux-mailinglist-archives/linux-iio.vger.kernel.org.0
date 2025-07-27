Return-Path: <linux-iio+bounces-22036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF42B12F71
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 14:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA8D7A4C6A
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EAB20B7FE;
	Sun, 27 Jul 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qS3he+nd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54FF86329;
	Sun, 27 Jul 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753619088; cv=none; b=rogExKDRV12zCOg6D6DNmnto7kKoZUdX4fhy2okZoTNaOUbScygj1XUI9/y7AHw4P0H+67YF9eval3xhAtph+7SsIZ8wd29MEZPb3bzBtNZQeWDf6KS8YpRx5SXYTEmNb5hzlIF4vzXUY2C83sOXELjdKTa2m5QxYILvoTATleI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753619088; c=relaxed/simple;
	bh=mP57AqouNPy8gt/qQcdld+p77sRqtt0Tv1mU+i7fIuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aStuBG1JoLbg6EqRprvZSG7EHMpclpvvJCb5rffLiyGvz0AC9+TiObZUcP3Ma3UB6BeasniJ1r9PBKQOXKOe/R+jf9kRJV865Pk0r1obujQ+pF4xxLJ7I/+DQjfHrBx8iFy3tTmyk8g6P3K5wnvGO5+IFUPiWq3T+EXG7JWkZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS3he+nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC76C4CEEB;
	Sun, 27 Jul 2025 12:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753619087;
	bh=mP57AqouNPy8gt/qQcdld+p77sRqtt0Tv1mU+i7fIuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qS3he+ndjzZlJwXlxVN+KqEhQA95Ts2b9fAW46oh+p8FSuEGojFGoVQ8cE4VwZjkz
	 6+Rw2XLkHxYamogVlfdnpXREFbqbechW8jN4esuzQ08ULfEWv/Ydqenr4p1AL/ydoe
	 lbyI1M3nnNLCAR2c+LpzpzVtL86yMyOeHgEDrcyE8Bm7nLywPByDyYxOGsKuv/LK5u
	 ShZUNfSX1D8TEDIW4qqdhtRW1rmMRnJIw4dOqXqRgsZJSTuuEcZgvyu0vwSx4rnwwu
	 WdEofjMcz9ewXiqO8GrgCIhMQ9nyoSAEuT0yXuJ/9yzirWpyeRkVhWPcgG/WnC6Z18
	 Q2mgEqVom7WUQ==
Date: Sun, 27 Jul 2025 13:24:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: adc: ad7124: add external clock support
Message-ID: <20250727132439.775523b1@jic23-huawei>
In-Reply-To: <20250724-iio-adc-ad7124-proper-clock-support-v1-3-88f35db2fcaf@baylibre.com>
References: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
	<20250724-iio-adc-ad7124-proper-clock-support-v1-3-88f35db2fcaf@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 18:25:24 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add support for an external clock source to the AD7124 ADC driver.
> 
> Previously, the driver only supported using the internal clock and had
> bad devicetree bindings that used a fake clock to essentially select
> the power mode. This is preserved for backwards compatibility.
> 
> If the clock is not named "mclk", then we know that the devicetree is
> using the correct bindings and we can configure the chip to use an
> external clock source rather than internal.
> 
> Also drop a redundant comment when configuring the register fields
> instead of adding more.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Hi David,

A few trivial things inline.

> ---
>  drivers/iio/adc/ad7124.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index f587574e8a24040540a470e13fed412ec9c81971..b0b03f838eed730347a3afcd759be7c1a8ab201e 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -18,6 +18,7 @@
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/adc/ad_sigma_delta.h>
> @@ -44,6 +45,11 @@
>  #define AD7124_STATUS_POR_FLAG			BIT(4)
>  
>  /* AD7124_ADC_CONTROL */
> +#define AD7124_ADC_CONTROL_CLK_SEL		GENMASK(1, 0)
> +#define AD7124_ADC_CONTROL_CLK_SEL_INT			0
> +#define AD7124_ADC_CONTROL_CLK_SEL_INT_OUT		1
> +#define AD7124_ADC_CONTROL_CLK_SEL_EXT			2
> +#define AD7124_ADC_CONTROL_CLK_SEL_EXT_DIV4		3
>  #define AD7124_ADC_CONTROL_MODE			GENMASK(5, 2)
>  #define AD7124_ADC_CONTROL_MODE_CONTINUOUS		0
>  #define AD7124_ADC_CONTROL_MODE_SINGLE			1
> @@ -1112,7 +1118,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
>  static int ad7124_setup(struct ad7124_state *st)
>  {
>  	struct device *dev = &st->sd.spi->dev;
> -	unsigned int power_mode;
> +	unsigned int power_mode, clk_sel;
>  	struct clk *mclk;
>  	int i, ret;
>  
> @@ -1155,9 +1161,41 @@ static int ad7124_setup(struct ad7124_state *st)
>  			if (ret)
>  				return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
>  		}
> +
> +		clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT;
> +	} else {
> +		struct clk *clk;
> +
> +		clk = devm_clk_get_optional_enabled(dev, NULL);
> +		if (IS_ERR(clk))
> +			return dev_err_probe(dev, PTR_ERR(clk), "Failed to get external clock\n");

Somme very long lines here where breaks won't hurt readability.

> +			return dev_err_probe(dev, PTR_ERR(clk),
					     "Failed to get external clock\n");

> +
> +		if (clk) {
> +			unsigned long clk_hz;
> +
> +			clk_hz = clk_get_rate(clk);
> +			if (!clk_hz)
> +				return dev_err_probe(dev, -EINVAL, "Failed to get external clock rate\n");

Add a break.

> +
> +			/*
> +			 * The external clock may be 4x the nominal clock rate,
> +			 * in which case the ADC needs to be configured to
> +			 * divide it by 4. Using MEGA is a bit arbitrary, but
> +			 * the expected clock rates are either 614.4 kHz or
> +			 * 2.4576 MHz, so this should work.
> +			 */
> +			if (clk_hz > MEGA)
> +				clk_sel = AD7124_ADC_CONTROL_CLK_SEL_EXT_DIV4;
> +			else
> +				clk_sel = AD7124_ADC_CONTROL_CLK_SEL_EXT;
> +		} else {
> +			clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT;
> +		}
>  	}
>  
> -	/* Set the power mode */
> +	st->adc_control &= ~AD7124_ADC_CONTROL_CLK_SEL;
> +	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_CLK_SEL, clk_sel);
> +
>  	st->adc_control &= ~AD7124_ADC_CONTROL_POWER_MODE;
>  	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_POWER_MODE, power_mode);
>  
> 


