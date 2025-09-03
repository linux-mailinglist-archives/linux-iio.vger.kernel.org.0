Return-Path: <linux-iio+bounces-23668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01642B415C7
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 09:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5173564F55
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 07:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EBE2D7DCA;
	Wed,  3 Sep 2025 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFIuHZgW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B72D877A;
	Wed,  3 Sep 2025 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883010; cv=none; b=NQw366h4zmezQ5klOIwEdb7s2N2O8wl5GhyqAMiGJhZRWflBDa12F6ZSGonpqmbPUxMO5M9wn2DizzW3LrgyE6AOD76FWmvkrz68fZ55MI/ow7qbjFzeanvdVOKhmhsgJShEXNuA6CDW3D0fhEY9jgPz/0Nd6Pbx0fbY/rLf/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883010; c=relaxed/simple;
	bh=twKg17NiiaX4b+nsPqQ7l1vh4UkOISR51Ac1/4E0fdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACrmVZGe/hvsjnGhdJTRPA47scXI3QKsPY7x4PBzBW0f+OqKbfWam5gjypxnqyBJN9t2r3FsayyETCIT1/NDO9zJmYlNPq1N1xOrbCg6Y5D2DqA303gIsfsJpitez9wZhpbJmKiGULKiO4q0NoWNKS2Mv5CVNpPrH0Abl5IJVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFIuHZgW; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f720ffe34so902470e87.1;
        Wed, 03 Sep 2025 00:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756883007; x=1757487807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqbTa59zKcp1kRY3+8ifl5pxub5gmL+oR4nSabqGse8=;
        b=IFIuHZgWqq8XO2f8hU2hNfHMeuSNFWRtks3MfAiDX+ryNOdpdq0vqdw+ffYl95RGBg
         Fwp6PpLvXVZ+DIdw6fPFukS/WhNwJ8AgH2ZgdgJcvm3n1re81BH06il2I4jHlRZrE6fM
         IAlBLO7nW44Mwud8wbBjOs5Lfibms3ZkdeViQyu/dp7UeA/k2fFlXsTPwvTRYt6CiBDW
         5tvTRnre8Nap/jMP1lX4iB/A0YGiZeJrtvAyAnpZqTeP8hPOPab8vbmOulyNYaPaKTow
         x6GA3rXeiaHicxUowV0qvmgagyr88UKCyc8GJQk1+vN9s85dAYTiLR17WF7IFGnkLpCG
         0tgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756883007; x=1757487807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqbTa59zKcp1kRY3+8ifl5pxub5gmL+oR4nSabqGse8=;
        b=DhklmfM6FC6I4PLjGzogfPL7jFDzPaDFEWqCkQ34g3rGhyTJKlmdj2sno2E24mSVBo
         SwH+RKPk5gF/j+cg01kQBXnVromW/YVIn9UrzZYTla7wj5nkKmtJ+Kns4Fp1T/x2QUEF
         6P25RvyC+G+JA+hj8ShbtTAml6qZWotCayac2CIz4Q4nVzZAClsi25jbZdNrrFViKUp+
         6EL0XlCB10LLAZbB6lqmjQiV2E1i23wsg7VorJh8y18jpU8owHeJqD+oiQPRphC2Fnmm
         iviEkr0hCd+XLejuYOSB0OqkuQl/8qlljJPLIVWyk98cBOtvFMzjjA6crbR6Y5LjvkJs
         p7Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUyT5hSBrS8FklrqnZ6kUaHyXCJv8Ue8zbt8Hn9ssQg2CcweanFoBViZO0JeaBnISl9KJZrFeAKIfgb@vger.kernel.org, AJvYcCV61G3lzhN1Lajb5NjyiGDFNKn3KPbwn2YIsgIs5RBGyfgNCPk6dQ01xlO0th1hVBw1KfOMyB7Jd0Lfeg==@vger.kernel.org, AJvYcCWUI0LfW1JIq1AtkZcsezE+I5zb+AhOXI2f1OorwoQjbrlNo4NxolrvbXkODMFflj3Io5KGtz4bVJsQ@vger.kernel.org, AJvYcCXm4pSWyOdo5Uz7ld+V3u7eIGk24+4UrrhfFiekxHdT8chhClvpP5KFgKcKWdr2M0UXGvJ6Plq9sYZ/fHwX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5l9lW8O6xsaa12IDvn94UAP4V6ttnxbw9KQc9TeianGnauGPc
	R6tqTI2YiC1Dqbw7wm9otuyN4hAE7WYXIB3cP+R52CxDRvZItjFDp7gr
X-Gm-Gg: ASbGncsofnQxiC/ZKe0LEvmvxx12FJUzfqLJuVRQqW92fNYqeQ9Rue5BAmNN230MZxN
	W/jMmVxMP5LssIjpwp995szIWd2a/ouQ5nVkFhe8xSd0Z5MM+1rg7LNKFOcntQhjQvu8KiivNNn
	j/OMlCvfA7ytmPIWkgUyBB1d6uSUHyw14SpphPHrDG8TZwKJs1mbI0vtTW6aXCGPMkMMObw8npv
	zx0JrQ403+lOVGuinr782beoLjwoe+a6c9B7AtygfQ1fTqT0e//rgEvVrJvAGoUSnPCk5n7dUAC
	Qzpf3nKYHRR1Bmj9HT3CIOgv+CKhyyjKjg8pxGLHiI3vdIpkPluRWBemLy0gvxFUqjGRP+ERF7U
	MiRDWXtAWGeng5r1OG7GZ0ef3OGkbXLs6CLNGIgMJQfLLCo04/2gOSBT4nDAZuExx5dZiQnYNIY
	MA+9bC
X-Google-Smtp-Source: AGHT+IF0p3WcBP/JALbJd3F0HgYZLGRyq6GR53LXy15SNQwHDfi88vjTB+GOxRtGp/dyIU/NC667YA==
X-Received: by 2002:ac2:5f72:0:b0:55f:552c:f731 with SMTP id 2adb3069b0e04-55f6f6b4c11mr3068666e87.7.1756883006453;
        Wed, 03 Sep 2025 00:03:26 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608abc1fdesm327943e87.58.2025.09.03.00.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:03:25 -0700 (PDT)
Message-ID: <b2650751-2f23-4508-9959-c55bc0530dfa@gmail.com>
Date: Wed, 3 Sep 2025 10:03:24 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
 <a6ae372e-e0c9-4874-8be1-8070ee3e880f@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <a6ae372e-e0c9-4874-8be1-8070ee3e880f@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/09/2025 18:14, David Lechner wrote:
> On 9/2/25 7:24 AM, Matti Vaittinen wrote:
>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>>
>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>>
>> The IC does also support CRC but it is not implemented in the driver.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   drivers/iio/adc/Kconfig        |  10 +
>>   drivers/iio/adc/Makefile       |   1 +
>>   drivers/iio/adc/rohm-bd79112.c | 542 +++++++++++++++++++++++++++++++++
>>   3 files changed, 553 insertions(+)
>>   create mode 100644 drivers/iio/adc/rohm-bd79112.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index e3d3826c3357..4b78929bb257 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -1309,6 +1309,16 @@ config RN5T618_ADC
>>   	  This driver can also be built as a module. If so, the module
>>   	  will be called rn5t618-adc.
>>   
>> +config ROHM_BD79112
>> +	tristate "Rohm BD79112 ADC driver"
>> +	depends on I2C && GPIOLIB
>> +	select REGMAP_I2C
> 
> I think you want SPI rather than I2C. :-)

Ouch! :) Well spotted! Thanks!

> 
>> +	select IIO_ADC_HELPER
>> +	help
>> +	  Say yes here to build support for the ROHM BD79112 ADC. The
>> +	  ROHM BD79112 is a 12-bit, 32-channel, SAR ADC, which analog
>> +	  inputs can also be used for GPIO.
>> +
> 
> 
> 
>> +struct bd79112_data {
>> +	struct spi_device *spi;
>> +	struct regmap *map;
>> +	struct device *dev;
>> +	struct gpio_chip gc;
>> +	unsigned long gpio_valid_mask;
>> +	unsigned int vref_mv;
>> +	struct spi_transfer read_xfer[2];
>> +	struct spi_transfer write_xfer;
>> +	struct spi_message read_msg;
>> +	struct spi_message write_msg;
>> +	/* 16-bit TX, valid data in high byte */
>> +	u8 read_tx[2] __aligned(IIO_DMA_MINALIGN);
>> +	/* 8-bit address followed by 8-bit data */
>> +	u8 reg_write_tx[2] __aligned(IIO_DMA_MINALIGN);
>> +	/* 12-bit of ADC data or 8 bit of reg data */
>> +	__be16 read_rx __aligned(IIO_DMA_MINALIGN);
> 
> Usually, we only need one __aligned(IIO_DMA_MINALIGN) (on the first
> field). Since these are only used for SPI messages and we can only
> send one message at a time, there isn't a way for there to be a
> problem that would require them to each need to be in their own
> cache line.

I was wondering about this and hoping to get a good comment explaining 
it :) I noticed I don't really know how different SPI controllers handle 
DMA or cache. Hence I just went with what felt like safest option - and 
hoped to get a comment like yours if it wasn't needed ;) So, Thanks!

> 
>> +};
>> +
> 
> 
> 
>> +static int bd79112_probe(struct spi_device *spi)
>> +{
> 
> ...
> 
>> +	iio_dev->channels = cs;
>> +	iio_dev->num_channels = ret;
> 
> This is quite far from where it is assigned. Better to have a dedicated
> local variable for this.

Gah! I agree. Actually there is now a bug where the 
iio_dev->num_channels is used before it is set. So, datasheet names 
won't be assigned correctly. (I did some re-ordering of stuff in probe 
to cover the 'all ADCs and all GPIOs cases. I must've messed this at 
that point!).

Thanks! I feel like I owe you a beer :] Just remind me if we meet! ;)

Yours,
	-- Matti

