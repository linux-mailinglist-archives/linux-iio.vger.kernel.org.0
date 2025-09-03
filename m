Return-Path: <linux-iio+bounces-23665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C1DB4144F
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 07:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328351BA04A9
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 05:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89ED2D594B;
	Wed,  3 Sep 2025 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b89xv3a+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20342D24A4;
	Wed,  3 Sep 2025 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756877005; cv=none; b=cvsEYfbr9moFprENBsj6/KnLYkeZVVsN283mqY4AzqkGjRxe0S8ZafyOM//AvEZqZ4gto4eYy3476sIsVBtGcSV3HctZD+BYIk1p14z+K/8JDyqH45uWiqcMh5/zRDs8FWAzseNT9HMbtIVSEezB5SKsCh8VseGtlCoOkjzH7BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756877005; c=relaxed/simple;
	bh=KaObTtBgadRB4aZZUNrcngukeIsotpLMlnkYwfPODPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnE6pecJ7SMayLMY8WrKgHQjdXaJUAYIuFOAxybK7VS1tnm29PeZfcbFPL2muOKVJcUiVn5f75KQHy5jeXld0nLc6ud7J47EnKNmiNWJlsQbye2scAItD1XGrzJlQT0cRoqpiwIepIYBUkNzWpRq5JrJtwj2P7sD3hbfGLSjDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b89xv3a+; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-336b5c44a5bso4539561fa.1;
        Tue, 02 Sep 2025 22:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756877002; x=1757481802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OgWMe5VZc0P4oCL4svW7wUtQ2mqMGRwwRtj+h0neqNo=;
        b=b89xv3a+8QWvDPLz2JuqIpX9+dTkjJBe60COpJYySj9pLNG24pFSorYEXGczV7NayI
         /lCi3v6jGI/rSuLC4jnw9YHeyk1yjViBwStyvu7+Ptd9nMWSjOjZ0NUr43V1253OYAqJ
         al5SWht5n+beuQwxlZeObcir+u8Zk8aNu3Z5KUVdz85Y6VKrHhLy5B7gC4RTvS1NLXxw
         Y/R3ptv10qevwzmU5ojZqBhFMAMUTC+kjM7q8VxPBM80ej7srLfeMdt+UdRECAD3UuIw
         ODpniEXGi2X2otrOT2hqFJpVIjev3UVlepRyKcr2w7J89r1c4JlOUASyJq7kkUjBEp7u
         mUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756877002; x=1757481802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgWMe5VZc0P4oCL4svW7wUtQ2mqMGRwwRtj+h0neqNo=;
        b=s/Gqk9oB8/XC4I7nOLgbsNxy7aIy5RlFruzUNw13t/bOTY8kPXg+50nC9m4qzlr1YB
         n1LRTXETf6v1lIK0v4HXKblDNNrCnB4sSOyaFMjoXOuWQVuDkym96mcqISsb2vCJyTZT
         6zjnsApzdkJbI0MkhXE032e6l3uf7YCFHinwcX82Adq8qYhs2eJSNbLBT2yMfQ7wKQoX
         Pf+LlftaMy7evcGp3BJ1EkxVMY0cet9iVEQ3kQ4VoFyKmKIRpIhXJwslZsGllrS4V2/E
         XOMwVHR4hVw+dknEW9rMHf/tQLFkw6LUXLrY56Rn5bN4ogOlVWowGPgH8VlIYhNgK5gh
         0MsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2dThuaRr9sEQ36M0d7ro7BFrmO9U31cNjSJPx7yS01n2MpPEx9S4Fqw7UgoWNN1CAft9qip5tLlhH@vger.kernel.org, AJvYcCVX8fhcAmqTGU48QmYgDO9fAVKDuV3s8m56snMAduhM+PdXu5YVQOip82bWkSrkENW0PkJdFdf73Myd52nb@vger.kernel.org, AJvYcCWYJigmS3YimjOqre93jS40MsbkksIBD4+n3zVQ7GK8UkhUOafex8NHtOGejqVqtcDWVjNNHjPrYQZO@vger.kernel.org, AJvYcCXPcwGWdu/0y2Dfr5b9hm2syYsnpCeX4OQ9hVQaiEG3STSTWP++mExlSUejlHZPJhQV7/wGukavs8aSUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+q4CI3uAS3sYmVkush2taNao80VAs5/Gd7qLe0CXV98YkZAi
	fQuDtuBSh0mLFcviVzB9wR+s8fP3CjsYSSGwe/EkFBO3drCidh+sSQ5g
X-Gm-Gg: ASbGncsnxu4d9gpme42mtSkaAES9PFpWZ6FHa3DIg/OsU03Qf/HHgd1LV7mV9BTHMIM
	W++feW0mpDBsJxEqWXd1LBSNALyp6VbgS+bL8nMPT7p2aq1cPAfb7He4VmKk2SzwVmMMEUCM6FW
	RMm+T1Y+eHrwTQOzkppGmPrVoNWFhVfKPXHi1rDY9jJGDmA7hNI19QVMeKMKXIH2tGJxuwYti0r
	G37hA3KI2fDAei6JFxs99BEN3mdQ4mpl9i8gR4WL24CKDD0hiIxmz51V6pOt8i6Y9fgAXUXk5j6
	GX5InE31oS+d4oC2t2m9W4XEG7p58+hvc3Es88gLRDZQBu98dYsYRCECw9Zx9QSRHH2EJsbfoHs
	7wTcUrrYnVJavGjnewMDApMoxdbSoGUeBsuJJ9ecZsgMoFsijKs+TqTRXhBkd1zNLGMHZ33nuFK
	7wbuqqBsmBM6RcDso=
X-Google-Smtp-Source: AGHT+IGWPOQdXbzAlZL/kPLWMGdVLFFRdkHqC80V2OpQ8IVEg4/tdgoa4gAcBqd0FUQy+LPGtCcCQw==
X-Received: by 2002:a2e:a00d:0:b0:334:145:4fa3 with SMTP id 38308e7fff4ca-336c7f29c0amr28522651fa.4.1756877001624;
        Tue, 02 Sep 2025 22:23:21 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032caasm8320201fa.35.2025.09.02.22.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 22:23:19 -0700 (PDT)
Message-ID: <ffef0fa6-45e4-467b-b264-1df15754d213@gmail.com>
Date: Wed, 3 Sep 2025 08:23:18 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
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
 <CACRpkdbOhm4PawYZUxU1SMi8WGr-LxhR1jhSVPDvPh3TTp8SWQ@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CACRpkdbOhm4PawYZUxU1SMi8WGr-LxhR1jhSVPDvPh3TTp8SWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi deee Ho Linus,

Long time no chat. Thanks for the review!

On 03/09/2025 01:34, Linus Walleij wrote:
> Hi Matti,
> 
> On Tue, Sep 2, 2025 at 2:24 PM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
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
> 
>> +static int bd79112_gpio_dir_get(struct gpio_chip *gc, unsigned int offset)
>> +static int bd79112_gpio_get(struct gpio_chip *gc, unsigned int offset)
>> +static int bd79112_gpio_set(struct gpio_chip *gc, unsigned int offset,
>> +                           int value)
>> +static int bd79112_gpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>> +                                    unsigned long *bits)
>> +static int bd79112_gpio_dir_set(struct bd79112_data *data, unsigned int offset,
>> +                               int dir)
>> +static int bd79112_gpio_input(struct gpio_chip *gc, unsigned int offset)
>> +static int bd79112_gpio_output(struct gpio_chip *gc, unsigned int offset,
>> +                              int value)
> 
> This looks like it could use
> 
> select GPIO_REGMAP
> 
> #include <linux/gpio/regmap.h>
> 
> struct gpio_regmap_config config = {};
> 
> etc. Did you check out the GPIO_REGMAP
> helper library?

I did - but that was couple of years ago :) I was very excited about it 
back then. I actually tried (tried hard, fingers almost bleeding) to 
write a patch to make it cover all of the ROHM PMIC GPIOs which I had to 
deal with. I thought it won't get it's full potential due to it's 
somewhat inflexible design. (And to tell the truth, I still believe so).

Anyways, fast-forward to this day, I don't see it handling valid_mask. I 
think it is a must for this device/driver, where pins can be either 
GPIOs or ADC inputs.

Yours,
	-- Matti

