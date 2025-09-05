Return-Path: <linux-iio+bounces-23739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C6FB44EC8
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5774823E4
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873192D47EF;
	Fri,  5 Sep 2025 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcBbmDl9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF332F76C;
	Fri,  5 Sep 2025 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056261; cv=none; b=J5WTCL7j2NqRDvOVV9HOiH7GiC3W1DkoYTx7dz6F5XWBdmyQIfaI7uzr2mtWbF7o0sc7FQDIDaIE9KnrsNNixVIjUf84KgQUsN/GJTD+9tIY6mPwSBw4Ux/aGlmnel/YRzXPMb6VsxvUgacMhulLXKU+xJiLB2LS3ewWfn3G6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056261; c=relaxed/simple;
	bh=GGfi3htzKuTZlupJ8A/9R0OP1UVodldjUfF8TFxYa4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGdMukF/YXn4Sgd9pgBx8ywwSx+zxqxdMjvr1mwGSOmo19c+4gUSgCz40+6QO3RfLnJJdpyiti4+CAGi1IInck6kU1Mvmcq7OG7Yxefg+xCKIUZUMtwYWMWUF420DBU/IBCDKzO5fcA2gBcNqUKt7lz2ZC6yMVI8KfHM+3LFlKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcBbmDl9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f7ad815ceso2056909e87.3;
        Fri, 05 Sep 2025 00:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757056258; x=1757661058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O15oaFlbSecL0xPawdsbWSzPwlKRkU4sBoLNzXpmMYI=;
        b=DcBbmDl93PNvhwaHmW/RAcMJ8T0rUOtVKq6SY00hvCWTXbyppqAqr4UrNfEGOB/2El
         ZwtGCHF5zLUcx/5Kzsxz+Xdy0MGV2r+H7vU7DIJ3SLRAgUjfGXh/YO3c3uY0tfRzSsiZ
         iwenXsPJ7pzusvGbvk/yh5lkvVJ8xfcdIACHS7xbNPo0uI6a4Ei0xWkypax6vqXcUQ2C
         Usl1H6Uj6lC+B8RoudiSlkrdNOFt5cequ7+7duaqB50dvrUEc5CqvAnio2UaHuanlsJB
         C8dDKgtzkDZiEmS2BceIU0Ke7C7aC8FR1+lBJWvrRz+CCftsNQ+t1fKOTcXBCbmRIiK0
         ze/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757056258; x=1757661058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O15oaFlbSecL0xPawdsbWSzPwlKRkU4sBoLNzXpmMYI=;
        b=RKjQPlwCyL9PirGtAXZFNYhZKpLADSSqu+yh1RuSinA3ffQM8K19unJBrBafLL/ym8
         bmurnjLeJr3zJDjeHwvyJ5av7FvGRbar1HnLToY9YcNi3NPkHUydZTy/qOOG5SpzGTRz
         KxKTXHNaKnkdLxeqA3F1Wp6sAfT/tJD3qhM+3nXtrygwWAWlIyVkC+cRRSH5rHgQYOsO
         juwMeGbnROwRy7HnkUSgQk/04x7g/NdJAkcPnYM0tUhKV4MR1IyKFQKjehhBX8jV5tYZ
         c+QsQ5MxHcW5uDmvUAgwjGG/7sDPPOglcqJde8pzRHCQNV8oNmP2wO6zM6QRRDGTmiEr
         x2Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVVy8k4pY6/aBwM2cVwlbFVNQ7BIumFPkps6bUfj2f1jXQIMfdHeNd59SBZTs+FDeBl61mqG/oSeWsHaw==@vger.kernel.org, AJvYcCXj6gdFNcTiALD+zcZDAxNf3OlBUPjeKSD3+F7yFilr+H3ZxtuGYeR/m2JvQs6S0SnpmZ7zKCDpyeZp@vger.kernel.org, AJvYcCXmO1dD5lNZvsLtoQ72tnV7VQ9H4LXwVUrzEHRixZbUI982I3EkA+Td6uCOyidmEawCppvKosPd/8tm@vger.kernel.org, AJvYcCXuusYHzPGY+DPM0MWatXNh5f0S8yFhJzW5snZ0vgN9so77d41PCtSJw/1Hweig5chWpJFlzm73SdIDXOuM@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXCvlFy4ZqjTWgGTiLuuU1sO2lWbhBQJhOmIQxozcPdDhErBe
	ZGPtMGLUjfWSe07h9MipDL555DWO0sJWYU6djBTo3ChgxzgAWPCsUmwxkhra6But
X-Gm-Gg: ASbGnctAY6jmVOcoLZ2OGXdoGzs2vi36033PWnySDPdT5y+QnxTVTJEO3qKGNCABlwm
	tDM6Pnbnq55rGaMOOaIWgAXJvozyrQzMwNAsjKEeYKMl89Lic7QPdnZfvdz1eAfKNjL/9QClcN8
	79R6UrSFsPJLHflP5o2Ojd7BwojjIJ/0HXtTwieyH/T+a86Y0pWT1MKmW440VTh7RJnfYGh60ki
	YtqYo20PBj/8kuleOr0iBufDw63EwAbNGkuX9CiwnapEVrxiwjQ8PSI6/KLJ4Zo0EwS9u6O3Xwu
	LA+l9t1sdT+VSAtPek0S9v3gTU4M9g4TmXtlD+4RM35+DSaDsClm9fvTC/X66TgHM4fUWXyEp21
	c2I/uGoAooZsnv/qIXiVLvwjhvU/CX2gq3SUDVjPDU7SdthlO8LliwkPfgnJuWHmCihE/iZEgQO
	0pt9B7KrArsr3QZ7U=
X-Google-Smtp-Source: AGHT+IHhKnvRXd70Bi88Un4YmSlqHa0PlAAVn+v9tZUCAv87NgGNYHCHUoVeLs1lU1dQzasnAc9nJA==
X-Received: by 2002:a05:651c:2344:20b0:336:c873:1b10 with SMTP id 38308e7fff4ca-336ca94901dmr41988781fa.15.1757056257406;
        Fri, 05 Sep 2025 00:10:57 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4cb9b5esm18215451fa.28.2025.09.05.00.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 00:10:56 -0700 (PDT)
Message-ID: <2c36496c-68bb-4c06-8580-3efc694429ea@gmail.com>
Date: Fri, 5 Sep 2025 10:10:55 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Hans de Goede <hansg@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1757053456.git.mazziesaccount@gmail.com>
 <3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount@gmail.com>
 <CAHp75VdaAH+1mh16KWoYtYFMV+_ec8x9YipeD3K8g6yQr-2VjA@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75VdaAH+1mh16KWoYtYFMV+_ec8x9YipeD3K8g6yQr-2VjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/09/2025 09:54, Andy Shevchenko wrote:
> On Fri, Sep 5, 2025 at 9:42 AM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>>
>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>>
>> The IC does also support CRC but it is not implemented in the driver.
> 
> ...
> 
>> +config ROHM_BD79112
>> +       tristate "Rohm BD79112 ADC driver"
>> +       depends on I2C && GPIOLIB
> 
> Still I2C?

Thanks :) I didn't spot this @_@. I just switched the REGMAP_I2C to 
REGMAP_SPI. Will fix.

> 
>> +       select REGMAP_SPI
>> +       select IIO_ADC_HELPER
>> +       help
>> +         Say yes here to build support for the ROHM BD79112 ADC. The
>> +         ROHM BD79112 is a 12-bit, 32-channel, SAR ADC, which analog
> 
> which --> where

I thought which (as a genetive case) would work here just fine?

> 
>> +         inputs can also be used for GPIO.
> 
> ...
> 
>> +/*
>> + * The data-sheet explains register I/O communication as follows:
>> + *
>> + * Read, two 16-bit sequences separated by CSB:
>> + * MOSI:
>> + * SCK:        | 1 | 2 | 3   | 4      | 5 .. 8 | 9 .. 16 |
>> + * data:| 0 | 0 |IOSET| RW (1) | ADDR   | 8'b0    |
>> + *
>> + * MISO:
>> + * SCK:        | 1 .. 8 | 9 .. 16 |
>> + * data:| 8'b0   | data    |
>> + *
>> + * Note, CSB is shown to be released between writing the address (MOSI) and
>> + * reading the register data (MISO).
>> + *
>> + * Write, single 16-bit sequence:
>> + * MOSI:
>> + * SCK:        | 1 | 2 | 3   | 4     | 5 .. 8 |
>> + * data:| 0 | 0 |IOSET| RW(0) | ADDR   |
>> + *
>> + * MISO:
>> + * SCK:        | 1 .. 8 |
>> + * data:| data   |
>> + */
> 
> What I meant in previous reviews is that the | are not aligned (in the
> same columns). Is it on purpose? If so, I can't read that as I don't
> understand the meaning of | in each case. For example, the data starts
> with 0, followed by 0, and the latter one is when SCL is #1? Okay, but
> how to read IOSET that overlaps 2 SCK cycles and is unaligned with
> times... I'm really quite confused by these charts.

Ah. I think I now know what you mean. Whitespaces are hard :)
I see I have '\t' between the SCK: and first |.
 >> + * SCK: /* '\t' here */       | 1 | 2 | 3   | 4     | 5 .. 8 |

It works perfectly on my editor, which has tab width 8. Thus, all the 
'|' on SCK and data rows are perfectly aligned for me. My original 
thought has been to align the first '|' on all rows by tab, but since 
the " * data:" is already 8 chars I didn't add a tab for this row...

I now realize this will not work if tabs behave different from my setup. 
I will do replacing the '\t' with ' '. Does this make it better for your 
editor or do you see some other problem besides that?

Thanks for the patience explaining it.

> ...
> 
>> +        * Ouch. Seems the pin is ADC input - shouldn't happen as changing mux
>> +        * at runtime is not supported and non GPIO pins should be invalidated
>> +        * by the valid_mask at probe. Maybe someone wrote register bypassing
> 
> wrote a
> 
>> +        * the driver?
> 

Yours,
	-- Matti


