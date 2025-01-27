Return-Path: <linux-iio+bounces-14645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8ACA201C1
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 00:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4120716604D
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 23:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB611DC99A;
	Mon, 27 Jan 2025 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iPiR2eUM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E21DC04A
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738020901; cv=none; b=sAisNH7y5XGO+lThZHEk1GBVob6uPr9KgTkrqTSL+DWXcbpQn9dP1lOFwyQY4BeVc9gaMWRrLbn8rxAO39LiFMTqyl/LbfJ2Yyc7wBAc/8m3T7i8VVsMGJKaoW4TWH80GLmB5R6F8d25B32BHe5Avkn3DiuYMO7HDWhcuTQ2HoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738020901; c=relaxed/simple;
	bh=TEKLERqMSAPxqIY7oTlgAAdLDQbYtaQFm9CPt3GUFaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLVqMryGChSho0wvD59j+cg+H4LRIJuJrBC9brA96dZEZ6pdEz9o/g5VGT3FSIRUd9KHZJaN6FSudbywx/5ELtx+w2zb4D2OQdGBK1qNk49QWNWM6HNFI6r76hf/ThqYhJyP7jq64h3u4N83cd0N0v8AkNndFk0ollPCfvzIsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iPiR2eUM; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb9a0a2089so2817786b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 15:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738020898; x=1738625698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+QL1qOU7A+4dqKvXFFwxp1Aj2x3uAvltSGPeyEHEJ4=;
        b=iPiR2eUMaPAufoHxbnFoJDFTDd/YZl11HRafkghUF8tyB8G3Dbu6lVxf6ak1JP2Do6
         afFCKBG5A/qaLV46NZ/pNUnrBVA8RFkoaOb4IBpeB+xrjMkJMY+M5E7g4QCNyuI+fFOa
         KlVKNMk9Smdko0n0QM0c5nXDyontRCvEglKPsESwhQNKM5rSlcizNaLvcoYl0HoZhIiG
         5vH5L9Ry4awmhKqEUwYwE+biks1WE40bJsi3SeVxtUelLj1A3EgxyyokvJ2OdsDnsiNq
         Pg2YXrN/2RwezhlFdqbghQVUtgHhLQbI4pZxczNA/v1obwHnG94DlTBKXXnylcO8ySaq
         fSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738020898; x=1738625698;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+QL1qOU7A+4dqKvXFFwxp1Aj2x3uAvltSGPeyEHEJ4=;
        b=I1R9X7XHaD8j9BWKdG4qLDI5yuentqyRS3oEnT+7xo1KZE+k8rWS0xcPew7YwwOoxs
         h1TSBY09pLd7UtjzFboZFt43SGwmdHTJkfzHZ0GPZFK4yNtnkNXPaar2sRVbZFB2s2ED
         ZriwJ0gfmUUXkOI+Ii+XWkojNtTvkVJPq2vVXcFRm9eWdIIc6pyDRhXTB1hQuIZlDZBI
         1ijB27W9eNmyk02H2UZmYbGlY4lXMngXZrPzP8YaFWZRtmXYau7ytXf4vMx4cGm62M4J
         WoqKSg89tj6hv19fbdAEm6GSaLjynNyxXaKZfM0DSwgEqT5vOy2R/KfUr4l15AuEqJVm
         yVGg==
X-Forwarded-Encrypted: i=1; AJvYcCX82j7pAPHkmgNkiphyEL02LWRdYyUOOGGrhu8F8I2rBRTegpw9G3T2Of0vuGU5kWKfYcm8mYn+144=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7W9no9BDLwzkxT4Ne+MYh/sqScg91TNhgB4k6H0TTfNO1ZzRd
	taBQfGQg9L7PKdlI/vfO9+rftJrZE42grnrRoy0VWVXFIw/PJrWyr9U4hhdzJ88=
X-Gm-Gg: ASbGncv2FAUcxGWczfI4GwLFPKxu+t7CGd2gAPHp2UpxmGW8aDBdhPGVtViERuVeXYR
	rT82gd2ex2OLYBdCcNjRbvZ0LmW0XRObiD3qUxk3hT0Wmjk3FOsBXEzB7oQOyu6pllc/O1hO7dq
	m+a8gY0OB2bqrzS1JCvgp8dV9NpbdkC69MOMVNkNf6dNcA9Qxq2eD5mM5dQI50QLPHUa6fiI/xd
	gL1q9p5voF0ip9k+y9+yDo+ExDAyDm9Xf3AGDePNloJULjb6DWMmKjprD1FD1BznKN86+TEV3+X
	sTdD2ewdXX2PaQiuUwxkCz/8sVZl8LflhFDh/x5PGg==
X-Google-Smtp-Source: AGHT+IEs3sNWagG6eHA+nlF8rlclQIex7wRrfCAI6RprQRticQYNyzsa4zEFLR7JCuetpdSJzNkgvg==
X-Received: by 2002:a05:6808:330a:b0:3f1:d489:3d95 with SMTP id 5614622812f47-3f1d4894c56mr17531046b6e.17.1738020897189;
        Mon, 27 Jan 2025 15:34:57 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fa8b55598asm2589357eaf.23.2025.01.27.15.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 15:34:55 -0800 (PST)
Message-ID: <be495c92-6e6f-47dc-baee-9524055f4f53@baylibre.com>
Date: Mon, 27 Jan 2025 17:34:54 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] iio: adc: ad7768-1: Add GPIO controller support
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <4067fc67ef617edbaea0de21241d59d6ff8eaf98.1737985435.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <4067fc67ef617edbaea0de21241d59d6ff8eaf98.1737985435.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 9:13 AM, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The AD7768-1 has the ability to control other local hardware (such as gain
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
> 
> This change exports the AD7768-1's four gpios and makes them accessible
> at an upper layer.
> 
> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
> v2 Changes:
> * Replaced mutex for iio_device_claim_direct_mode().
> * Use gpio-controller property to conditionally enable the
>   GPIO support.
> * OBS: when the GPIO is configured as output, we should read 
>   the current state value from AD7768_REG_GPIO_WRITE.
> ---
>  drivers/iio/adc/ad7768-1.c | 148 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index c540583808c2..e3ea078e6ec4 100644
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
> @@ -79,6 +81,19 @@
>  #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
>  #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
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
> +#define AD7768_GPIO_INPUT(x)		0x00
> +#define AD7768_GPIO_OUTPUT(x)		BIT(x)
> +
>  #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
>  #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
>  
> @@ -160,6 +175,8 @@ struct ad7768_state {
>  	struct regulator *vref;
>  	struct mutex lock;
>  	struct clk *mclk;
> +	struct gpio_chip gpiochip;
> +	unsigned int gpio_avail_map;
>  	unsigned int mclk_freq;
>  	unsigned int samp_freq;
>  	struct completion completion;
> @@ -309,6 +326,125 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
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

Missing iio_device_release_direct_mode() here and in other functions.

(And we are in the process of removing iio_device_claim_direct_scoped(), so
don't use that.)

> +
> +	return regmap_update_bits(st->regmap,
> +				  AD7768_REG_GPIO_CONTROL,
> +				  BIT(offset),
> +				  AD7768_GPIO_INPUT(offset));

Can be simplified to regmap_clear_bits(), then we can get rid of the odd
AD7768_GPIO_INPUT macro that ignores the argument.

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
> +	return regmap_update_bits(st->regmap,
> +				  AD7768_REG_GPIO_CONTROL,
> +				  BIT(offset),
> +				  AD7768_GPIO_OUTPUT(offset));

And regmap_set_bits() here.

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
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val & BIT(offset))
> +		ret = regmap_read(st->regmap, AD7768_REG_GPIO_WRITE, &val);
> +	else
> +		ret = regmap_read(st->regmap, AD7768_REG_GPIO_READ, &val);

Can we get a comment explaining why GPIO_READ doesn't work in output mode?

Or if it does work, we can simplify this function.


> +	if (ret < 0)
> +		return ret;
> +
> +	return !!(val & BIT(offset));
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
> +	if (ret < 0)
> +		return;
> +
> +	if (val & BIT(offset))
> +		regmap_update_bits(st->regmap,
> +				   AD7768_REG_GPIO_WRITE,
> +				   BIT(offset),
> +				   (value << offset));

Can remove extra ().

> +}
> +
> +static int ad7768_gpio_request(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	if (!(st->gpio_avail_map & BIT(offset)))
> +		return -ENODEV;
> +
> +	st->gpio_avail_map &= ~BIT(offset);

Is this really needed? It seems like GPIO core would be keeping track already.

Also would need a .free callback to undo this action.

It seems like most ADC's with GPIO controllers don't implement .request though.

> +
> +	return 0;
> +}
> +

