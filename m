Return-Path: <linux-iio+bounces-14010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BB1A04DD3
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC6A16303A
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EA61F63E7;
	Tue,  7 Jan 2025 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y32RAQEy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70531DF27C
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 23:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293689; cv=none; b=Ui9z1GAsAS3VMmy2cnLw/uxVoaS2nIZE6halGQ+zl90xIEEuPfNBmXsRWSEhGVxp91W7Y0unCbnYk2T1XDYUyG/jJyymEWIWZIywzHUcLxqvKNzAMQkOYDVUSyAmFotewe9DQBgLb27NIHONKI6VXGf/2Q72Eo2yu5Qrmai2J2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293689; c=relaxed/simple;
	bh=12jv2li6bKsZbkrhTOXhXldiS/JNsqMgFKYLlf2AUDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7oMVGXedqpJk+41qs8Z32wi0UdRgLxOpOqn3ZliAJZ3we0um99+N6ySAwkc5vBoiNnbLsaBhyWs/hF7hIlhRcdihcGg4hopGP1JDj7FratOXTQuPX0kInu34oOfYPRPYTrfcjMLr4FEKJ9NC1d4QlcsGiFSS1OaxGXCHJMOma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y32RAQEy; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29f9e76802aso178439fac.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 15:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736293686; x=1736898486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4WBHM1Es8P45HhfwQj66qUNgxkHbYuA2hvPfr0axX0=;
        b=Y32RAQEyf2uN461ezC56PWAgj49NZxWj/9wMvody2UyVGNuj121tHPmkBWdAVk1v5v
         n1dLOp9hfzpMLPkRpT/NRnLfqELdSN05ZdIQ6Gb3pDKC30hKfvwYPc8AJ+mCuyqdkUFz
         KC/XRoy4eepOoZNDEzfmHXKvmXyzzNtjK+22VL12uUM3TqgdfYhX9QfQDC9NaFZhyuUz
         9SURpFE3cYjejQzPuTcEAF1PRMoV3xulMg9c+xdf4oaBx5AGaywpKtIT1OsXGn/yKxjK
         bgmE/OKAFX1JZ4U7oEHR4iVTlEzs/ALQlAxCSc8ndsoh1U7Pu0nPqNtjYCzl1CffjTAl
         psgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293686; x=1736898486;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4WBHM1Es8P45HhfwQj66qUNgxkHbYuA2hvPfr0axX0=;
        b=Z3aCB8e3HBBR0yIiJH6P3bpfGNTPwHMUfORYM3G9w4iySIBOVPHAVOrtd5HJh26DJc
         SIgaP8aspnES44Wc6gV7fBKr3T4XbB8sK8/zkCxDFBkuvwJA2aEdrfn8W2QVoW+2GUqt
         WiVLZaADGZP3sogSVMpRmXeYV3eQZBgBmOMENvb2OuPhZ26PBs+GBV/di0OWAluHtE4X
         ZvP1i+IlCAzMoSmTP+AsMpn7xen+m7tC+kxxpJjxDMict6eTCuck95kj1C+dk0hPPx0J
         LijwVJlj3mOPIhkDSaLH1inT1DcNJQSN2qhN9HyT/1CnEXPk0J5SRZjxSZ9u5sjwF6qw
         DkCg==
X-Forwarded-Encrypted: i=1; AJvYcCWsvaBgnkm1L331qrcgK9AnOkb65fKLKd5HrJUtPWQYqdD+MJJmrztQBsTbPbcnrLnA0fbrW7IAYGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFs/4odNFmeoI0RkN4UegnRQghsm84FleXMSCZ1si8rPX7MXU8
	ymwuCBefxmEDNCjS+nkhjThhLIrOwJFK/FmzSmwsqxE3pgDwd8TQYNE0fDvqGnY=
X-Gm-Gg: ASbGncvBLdSVD5z45TNiGHVxK+jkY9X2eteGxM77CicTHWK5T/T+Zb0ApLxwUq+NhcC
	OtLXlq0djRSZ+0MF9AoWPl7Jy2cp+wnfvoyw0CZKRvUFwtoK2nnCSZycRmF58DBOziNe9x8rG6K
	Y4bMEcHT6HQB9d429Kkevwz3YoHSbn6931sYWnI0POinOoVdJGY+A3ThkwQjzaGevyoxBCtyQRq
	2T/Pywkx+RpIv6/NZ7J+93rFG0bkzMKNN8xCI3gBH4UTKsNcpQKZtUHP8jTF/iev/h/s9gZvS+q
	Xmfs6uxPhxhqg+xhEg==
X-Google-Smtp-Source: AGHT+IHGIz2Z4qtDGdc9WbRZfHytcAWvpxN7bgy7PQyqGeucFxjS2mYnaQaCwl+4Qat2jZttrfm8SA==
X-Received: by 2002:a05:6871:53c6:b0:29f:c94b:3a06 with SMTP id 586e51a60fabf-2a9eaaa6de6mr2750163fac.8.1736293685907;
        Tue, 07 Jan 2025 15:48:05 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d7454102sm12907573fac.1.2025.01.07.15.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:48:05 -0800 (PST)
Message-ID: <c5890aee-78ac-45a7-b910-72a342f329b1@baylibre.com>
Date: Tue, 7 Jan 2025 17:48:04 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/15] iio: adc: ad7768-1: Add GPIO controller support
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <e09454c98accd763d6d5e67f9f7262aabec91acd.1736201898.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <e09454c98accd763d6d5e67f9f7262aabec91acd.1736201898.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:26 AM, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The AD7768-1 has the ability to control other local hardware (such as gain
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
> 
> This change exports the AD7768-1's four gpios and makes them accessible
> at an upper layer.

We will also need a dt-bindings patch to add gpio-controller and #gpio-cells
properties.

> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 121 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 675af9ea856d..9741a6d47942 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -10,6 +10,8 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -77,6 +79,19 @@
>  #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
>  #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
>  
> +/* AD7768_REG_GPIO_CONTROL */
> +#define AD7768_GPIO_CONTROL_MSK		GENMASK(3, 0)
> +#define AD7768_GPIO_UNIVERSAL_EN	BIT(7)

Bits should be ordered highest to lowest (from top to bottom) to be consistent
with other code.

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
> @@ -190,6 +205,8 @@ struct ad7768_state {
>  	struct regulator *vref;
>  	struct mutex lock;
>  	struct clk *mclk;
> +	struct gpio_chip gpiochip;
> +	unsigned int gpio_avail_map;
>  	unsigned int mclk_freq;
>  	unsigned int samp_freq;
>  	unsigned int common_mode_voltage;
> @@ -338,6 +355,106 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
>  	return 0;
>  }
>  
> +static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct ad7768_state *st = gpiochip_get_data(chip);
> +
> +	guard(mutex)(&st->lock);

As mentioned in another patch, this should be iio_device_claim_direct_mode()
instead of st->lock since we can't access registers during a buffered read
because the chip is in conversion mode. Same applies to other functions below.

> +	return ad7768_spi_reg_write_masked(st,
> +					  AD7768_REG_GPIO_CONTROL,
> +					  BIT(offset),
> +					  AD7768_GPIO_INPUT(offset));
> +}
> +
> +static int ad7768_gpio_direction_output(struct gpio_chip *chip,
> +					unsigned int offset, int value)
> +{
> +	struct ad7768_state *st = gpiochip_get_data(chip);
> +
> +	guard(mutex)(&st->lock);
> +	return ad7768_spi_reg_write_masked(st,
> +					  AD7768_REG_GPIO_CONTROL,
> +					  BIT(offset),
> +					  AD7768_GPIO_OUTPUT(offset));
> +}
> +
> +static int ad7768_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct ad7768_state *st = gpiochip_get_data(chip);
> +	unsigned int val;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	ret = ad7768_spi_reg_read(st, AD7768_REG_GPIO_CONTROL, &val, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val & BIT(offset))
> +		ret = ad7768_spi_reg_read(st, AD7768_REG_GPIO_WRITE, &val, 1);
> +	else
> +		ret = ad7768_spi_reg_read(st, AD7768_REG_GPIO_READ, &val, 1);

It doesn't work to just always read AD7768_REG_GPIO_READ?

> +	if (ret < 0)
> +		return ret;
> +
> +	return !!(val & BIT(offset));
> +}
> +
> +static void ad7768_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> +{
> +	struct ad7768_state *st = gpiochip_get_data(chip);
> +	unsigned int val;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	ret = ad7768_spi_reg_read(st, AD7768_REG_GPIO_CONTROL, &val, 1);
> +	if (ret < 0)
> +		return;
> +
> +	if (val & BIT(offset))
> +		ad7768_spi_reg_write_masked(st,
> +					    AD7768_REG_GPIO_WRITE,
> +					    BIT(offset),
> +					    (value << offset));
> +}
> +
> +static int ad7768_gpio_request(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct ad7768_state *st = gpiochip_get_data(chip);
> +
> +	if (!(st->gpio_avail_map & BIT(offset)))
> +		return -ENODEV;
> +
> +	st->gpio_avail_map &= ~BIT(offset);
> +
> +	return 0;
> +}
> +
> +static int ad7768_gpio_init(struct ad7768_state *st)
> +{
> +	int ret;
> +
> +	ret = ad7768_spi_reg_write(st,
> +				   AD7768_REG_GPIO_CONTROL,

nit: this can fit on the previous line

> +				   AD7768_GPIO_UNIVERSAL_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->gpio_avail_map = AD7768_GPIO_CONTROL_MSK;
> +	st->gpiochip.label = "ad7768_1_gpios";
> +	st->gpiochip.base = -1;
> +	st->gpiochip.ngpio = 4;
> +	st->gpiochip.parent = &st->spi->dev;
> +	st->gpiochip.can_sleep = true;
> +	st->gpiochip.direction_input = ad7768_gpio_direction_input;
> +	st->gpiochip.direction_output = ad7768_gpio_direction_output;
> +	st->gpiochip.get = ad7768_gpio_get;
> +	st->gpiochip.set = ad7768_gpio_set;
> +	st->gpiochip.request = ad7768_gpio_request;
> +	st->gpiochip.owner = THIS_MODULE;
> +
> +	return gpiochip_add_data(&st->gpiochip, st);
> +}
> +
>  static int ad7768_set_freq(struct ad7768_state *st,
>  			   unsigned int freq)
>  {
> @@ -538,6 +655,10 @@ static int ad7768_setup(struct ad7768_state *st)
>  	if (IS_ERR(st->gpio_sync_in))
>  		return PTR_ERR(st->gpio_sync_in);
>  

Since the GPIO pins can also be wired up as mode input pins, this should not be
always enabled. We can use the `gpio-controller` DT property as a flag to
conditionally enable GPIO support when it is actually wired up for that purpose.

> +	ret = ad7768_gpio_init(st);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* Set the default sampling frequency to 32000 kSPS */
>  	return ad7768_set_freq(st, 32000);
>  }


