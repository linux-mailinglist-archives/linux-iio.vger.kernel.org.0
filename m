Return-Path: <linux-iio+bounces-14829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B9A24A25
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01290188651B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E71C4A0E;
	Sat,  1 Feb 2025 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yk5gTbCM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E112F56
	for <linux-iio@vger.kernel.org>; Sat,  1 Feb 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738426160; cv=none; b=MsdfIrW0id+p0EVJw+T9kW6/c/seOgONMknFFLt50sae+1fgCy9he7L4BEgnp8OhW9rs2ZF4B69xAXPxj1qEQjxcH/OPUNDvq7Cyn+bFr2/5p1RpIG/aowBdPrri6XRzF8UU1dgTKcfIl+9PMPkisffgpTwRNWG6S5CDiq0T7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738426160; c=relaxed/simple;
	bh=1D36JuSUvj+vjMHfIzJ73Ejh/BelZ12eFT5aIafgzFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUVZaT178hzrHChbbM/FFEIVXFGtPj0WkltdsU+vdZnfb9bRqL1ODkwzJ+dBdfkioGrPQybann/8++Iw391THrgxbjqi6KjazLRgL6d6zIpYlrkYsJClBlKQJdZJcQlB+TRqpWnuJqSVNkrquBU/j3UTTYkocIefgHbe05ec7Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yk5gTbCM; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f1c94936c5so1533320b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Feb 2025 08:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738426156; x=1739030956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/HWj5hSehOUGeRp7am4uO7k2toUSpAz0X3lYENSi1c=;
        b=yk5gTbCM1tvq/gNujNwELqWdpamk9s2eJgFLtc+wbAhCLSZamwwF1H1flxULJOmqBi
         llvuVCh8QXOkx5CmijhXn5rF9NZmPOXQbfH/JX5TuptWJqKcmreyHnNRRhli84A0pOCD
         Mi5TL0m/OJYSgR2XpO53jlzZc6pJn4KDiK6NHJtmNTCm/SX0JuwiGAyh88ShMzepl0XO
         GFeoFP3kPFWIlwu8wuo4odCwi8w5lYYq4oizZ0REzz3xcGzAs5MgYgBTlMPaGx4KaFUx
         UMRw52BKnfFeSYtbp08gxyV/YZzDy+LofX1oCncUwQdeXkaqcaL/MqK0Me7IvXTTpjyA
         lwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738426156; x=1739030956;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/HWj5hSehOUGeRp7am4uO7k2toUSpAz0X3lYENSi1c=;
        b=FeKyBkLaFSEpXEI2rUP375gL4ebimcTJkHy5332OuZ7Y6iD/OGr7yyyUfHPCxlbqrO
         d2hBAq+CWh4+JmAqiMRerrxeylPqS2H7aVpK3JxUiHvHFdFWTbUwfX8S42FYJF0oJWPH
         Libmt9PCCMF2isQ7Rxxzu6cnuiRxS0DycT1LSM5RXKcxN87N/ATKWK3MKszeqKJkHnUm
         VujkEe2L0Wyb6WGYWuk/bPLR54ZiHnYvxkLXdtpeZCAsbmg1Kk76q8R4Jrkr6S7y45Dl
         ecNdFyND3XRaVjSYfbTK4BzrS1bDF11X3q9msozCIZ/o4yW5F0OmSGCJD7CrLTqmrsQF
         7eYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBpxtfngpG9fRk6RL3CCoWUddo0IZXprCAEueOjo5H6dnW1XNe8W2xpok1U6tw+gAqBOrvB4JeU40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDciZw6l9OiMZMG5s5vuP7naYGtY7jr7K8ktTBV3eAd57oMPWc
	JXc8JNDMu8/inQJFAbQ9AQzeDxK8eGhPk5NKp1KWhPO6y169nN5C2Pz0151ZbGQ=
X-Gm-Gg: ASbGnctilY394sJhyjIn7q1c5wxy63QG78kHIZxusNfvR1ZKzLWMEUbNaKaDyGm96dH
	Feae0RKlSITtL7igOp2M7sIwfebNyS4lch6UaMjZD+Ax/hBB5Kila73hCOWskm7nG2VzdMIsk0R
	vY5hrU35N983rfQsqZJG6MuGGOdCDot2UrwH/KgEK23WWV6jF5VQaV16jVOwmMAzyzpYHPVe9RA
	9VOg/ziBytXz8dw9HgBcEL7zoobbXwHAYPIp9D0JEcE2UFyJNhQD2fZUM4XNgOdqmI4iEWkLmr1
	/MZKhKhdWob5xMeuKuVDdk/S6TQXw3Bx3QQCnK0Cl0QEizJaV6xx
X-Google-Smtp-Source: AGHT+IHlRVUNM84414C8bMX22/8bNBRk4Wz6BZnDGgM7+x56FCD0VuxaQe5kTozn9TxT7X99cEoMmA==
X-Received: by 2002:a05:6808:3c85:b0:3f1:b124:59ae with SMTP id 5614622812f47-3f33c41c93bmr5106514b6e.13.1738426156387;
        Sat, 01 Feb 2025 08:09:16 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f333523fd6sm1405864b6e.3.2025.02.01.08.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 08:09:15 -0800 (PST)
Message-ID: <9931433b-5cde-4819-ac96-eea4f1f0f1f2@baylibre.com>
Date: Sat, 1 Feb 2025 10:09:12 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
 <CAMRc=MdwQL8dWU5zF5fp+KUbC2RA2Q264by8HGXMg2k1rxhsTA@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAMRc=MdwQL8dWU5zF5fp+KUbC2RA2Q264by8HGXMg2k1rxhsTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/25 4:36 AM, Bartosz Golaszewski wrote:
> On Fri, 31 Jan 2025 21:24:40 +0100, David Lechner <dlechner@baylibre.com> said:
>> This series was inspired by some minor annoyance I have experienced a
>> few times in recent reviews.
>>
>> Calling gpiod_set_array_value_cansleep() can be quite verbose due to
>> having so many parameters. In most cases, we already have a struct
>> gpio_descs that contains the first 3 parameters so we end up with 3 (or
>> often even 6) pointer indirections at each call site. Also, people have
>> a tendency to want to hard-code the first argument instead of using
>> struct gpio_descs.ndescs, often without checking that ndescs >= the
>> hard-coded value.
>>
>> So I'm proposing that we add a gpiods_set_array_value_cansleep()
>> function that is a wrapper around gpiod_set_array_value_cansleep()
>> that has struct gpio_descs as the first parameter to make it a bit
>> easier to read the code and avoid the hard-coding temptation.
>>
>> I've just done gpiods_set_array_value_cansleep() for now since there
>> were over 10 callers of this one. There aren't as many callers of
>> the get and atomic variants, but we can add those too if this seems
>> like a useful thing to do.
>>
>> ---
>> David Lechner (13):
>>       gpiolib: add gpiods_set_array_value_cansleep()
>>       auxdisplay: seg-led-gpio: use gpiods_set_array_value_cansleep
>>       bus: ts-nbus: validate ts,data-gpios array size
>>       bus: ts-nbus: use gpiods_set_array_value_cansleep
>>       gpio: max3191x: use gpiods_set_array_value_cansleep
>>       iio: adc: ad7606: use gpiods_set_array_value_cansleep
>>       iio: amplifiers: hmc425a: use gpiods_set_array_value_cansleep
>>       iio: resolver: ad2s1210: use gpiods_set_array_value_cansleep
>>       mmc: pwrseq_simple: use gpiods_set_array_value_cansleep
>>       mux: gpio: use gpiods_set_array_value_cansleep
>>       net: mdio: mux-gpio: use gpiods_set_array_value_cansleep
>>       phy: mapphone-mdm6600: use gpiods_set_array_value_cansleep
>>       ASoC: adau1701: use gpiods_set_array_value_cansleep
>>
>>  drivers/auxdisplay/seg-led-gpio.c           |  3 +--
>>  drivers/bus/ts-nbus.c                       | 10 ++++++----
>>  drivers/gpio/gpio-max3191x.c                | 18 +++++++-----------
>>  drivers/iio/adc/ad7606.c                    |  3 +--
>>  drivers/iio/adc/ad7606_spi.c                |  3 +--
>>  drivers/iio/amplifiers/hmc425a.c            |  3 +--
>>  drivers/iio/resolver/ad2s1210.c             |  8 ++------
>>  drivers/mmc/core/pwrseq_simple.c            |  3 +--
>>  drivers/mux/gpio.c                          |  4 +---
>>  drivers/net/mdio/mdio-mux-gpio.c            |  3 +--
>>  drivers/phy/motorola/phy-mapphone-mdm6600.c |  4 +---
>>  include/linux/gpio/consumer.h               |  7 +++++++
>>  sound/soc/codecs/adau1701.c                 |  4 +---
>>  13 files changed, 31 insertions(+), 42 deletions(-)
>> ---
>> base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
>> change-id: 20250131-gpio-set-array-helper-bd4a328370d3
>>
>> Best regards,
>> --
>> David Lechner <dlechner@baylibre.com>
>>
>>
> 
> This looks good to me except for one thing: the function prefix. I would
> really appreciate it if we could stay within the existing gpiod_ namespace and
> not add a new one in the form of gpiods_.
> 
> Maybe: gpiod_multiple_set_ or gpiod_collected_set...?
> 
> Bartosz

I was waiting for someone to complain about the naming. ;-)

I was going for as short as possible, but OK, the most obvious prefix to me
would be `gpio_descs_...` (to match the first parameter). Any objections to
that?


