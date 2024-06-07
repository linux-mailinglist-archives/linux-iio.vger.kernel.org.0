Return-Path: <linux-iio+bounces-6020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 678E8900856
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 17:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187AE1F23E2D
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A97197548;
	Fri,  7 Jun 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkCWOoNt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261F25740;
	Fri,  7 Jun 2024 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773176; cv=none; b=VzBFBIPi8gcmMWreVFlQ1PwfhAxagXGACXvmFGETBkxmJTw6ZckZx5vOa9bOMeNoRD5nRw4F5asAXVB2mtIo0m1BsU0IOpdq2PIxYVWW/SxmynEYTFRCOl/z2wi6DgCg2W3y6pxvQYDBvZk+mHjqc6GczDJGjEwsNZO2UzAJ95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773176; c=relaxed/simple;
	bh=RRbnxR6kVfJ9fmXvviuMCAtU+DY4kjQrDHnTVVNV/ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=jjE6uacyBKc9MdMoRYQiyXan9iihFrjmT8VLr2gj8INxabOwpcsI4ylHmmlaSf+i29JpWzVMA2NOsTuLOTXL4Qgm6BgB0qIVqcZ/Qqqo+Y8yRxhf8U85a9Sq4XA0DUhflv/H5WXM1KhIZw2XTCz1hkxJmUwWsmGJE+IiTYcKufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkCWOoNt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42163fed884so11577605e9.1;
        Fri, 07 Jun 2024 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717773173; x=1718377973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DYxh+g5f5O4azupPwLnK1YGn9F+3wPD8Hs0+Ru70dLI=;
        b=QkCWOoNtM+1tVCUnsg6jZGdyx3Z2SBedJPyGWErpNfLws+CaJfcYGbeJ5nzNLlSov1
         roXii2D4NAGhezDVmqupNqlgkooj1+ATf8r0AgjD5MWlTRoGWtjr00IQ8siw+cwWj1Tm
         v+Ay9MixsrS2mb1vT9YgoOlTraxj4ZtyTfiUPZQ8026yhraDmWQGnzASoxKlzbKer2gL
         6T7zhEx9tNYW5u0goNhrMVE8UH8wuGRKa1t0TmKgNRO6RoNONOm7SWGOc3LqxoBoYQBr
         LisiwWyOElcehc0VOzxTjmhh4fWRAEZ9wdhe/k1h5lLPRxQzpzL1hyFC8S0RrJ4POEWk
         Mo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717773173; x=1718377973;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYxh+g5f5O4azupPwLnK1YGn9F+3wPD8Hs0+Ru70dLI=;
        b=gCqpa6NEotshKJ+B8UkY2QAEvYOepD709YuvaN6kwrfTN+fPzaQpnnnLEtQ4ot99qz
         EoWnXAYYw1Bsybnl36s1h5jaSENVXv9DTzT8/tsd6nzQj/deg9qAxzcAYenCmgeO+rHP
         7bIp++4Q1drQJUO0imCdjobuvFAGcTmEcaZmbYl2SeMaWQSZrOeAlmdlAxY5VNUkVTnV
         jm1jvI0nAESANtbzbkFms79Hx2Aub/WSRMEharrBGSnF9BZUGGnumYqI9NYn4MeF/ttS
         PDZ6SeX3yH/qDZYcaFSw3Sy+MMeUbTpEMO2RvlIxYeE1h8G8hX8owRN8tajXNFmU3xjM
         qFuA==
X-Forwarded-Encrypted: i=1; AJvYcCUst1POenQIMW6OoDnNIXOtJ2anrDInHmeqvrskVYrwvOQi9TpBKXp8S3abyytH2BjTrZFP5cHdRdQmKW5aXP7EZ3n7vl0A3aaUFG3L0xEXYYEMAmTJf8tV0w7oJhuMNJZnXanc4UIYZ1KqBVps29avDeAzspVDIexkuFGM6Mu7rwtF9KJGQlAYqisiZ+zdQGSoyWyKeKS6KmgYM2hr
X-Gm-Message-State: AOJu0YyG/235pH0W1kOV+bXO3jQs8vgX2iAcSNDrYi5goLJv8EgiT0Mw
	KfjE5Q6WNInYx80ayE6DTecMc7j9VckCEfXw2l+77I/hy/i6aRA=
X-Google-Smtp-Source: AGHT+IFLp2nndxaMppnuETVfMi7bIa8z06pB2kDGICrguP3x31uN5dp+Y1PVLgrZrVZPJppD++VRYw==
X-Received: by 2002:a05:600c:3542:b0:421:494c:9e92 with SMTP id 5b1f17b1804b1-421649f4f8amr23759575e9.14.1717773172505;
        Fri, 07 Jun 2024 08:12:52 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:7a2c:14dd:f1d8:f717? ([2a02:810b:f40:4600:7a2c:14dd:f1d8:f717])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4214bf59f60sm102292345e9.1.2024.06.07.08.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 08:12:52 -0700 (PDT)
Message-ID: <1535049f-1e4c-446b-8070-6f51877b2649@gmail.com>
Date: Fri, 7 Jun 2024 17:12:51 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/13] Add support for AXP192 PMIC
To: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
Cc: jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 wens@csie.org, ee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
 samuel@sholland.org, linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aidan,

Am 17.10.22 um 01:43 schrieb Aidan MacDonald:
> This series adds support for the AXP192 PMIC to the AXP20x MFD driver
> framework, including support for regulators, ADCs, and AC/USB/battery
> power supplies.
>
> v6 is a resend of v5 from July -- the patches haven't changed at all
> but I've rebased them on the latest git master branch.
I'm not entirely sure if I've found the latest version of the patches - at
least b4 didn't find a newer. It looks a lot like only mfd and usb-power
patches have been applied for some reason. Are you planing to resend the
other ones?

Regards,
Alex

> Aidan MacDonald (13):
>    dt-bindings: mfd: add bindings for AXP192 MFD device
>    dt-bindings: iio: adc: axp209: Add AXP192 compatible
>    dt-bindings: power: supply: axp20x: Add AXP192 compatible
>    dt-bindings: power: axp20x-battery: Add AXP192 compatible
>    mfd: axp20x: Add support for AXP192
>    regulator: axp20x: Add support for AXP192
>    iio: adc: axp20x_adc: Minor code cleanups
>    iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
>    iio: adc: axp20x_adc: Add support for AXP192
>    power: supply: axp20x_usb_power: Add support for AXP192
>    power: axp20x_battery: Add constant charge current table
>    power: axp20x_battery: Support battery status without fuel gauge
>    power: axp20x_battery: Add support for AXP192
>
>   .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
>   .../bindings/mfd/x-powers,axp152.yaml         |   1 +
>   .../x-powers,axp20x-battery-power-supply.yaml |   1 +
>   .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
>   drivers/iio/adc/axp20x_adc.c                  | 356 ++++++++++++++++--
>   drivers/mfd/axp20x-i2c.c                      |   2 +
>   drivers/mfd/axp20x.c                          | 141 +++++++
>   drivers/power/supply/axp20x_battery.c         | 142 ++++++-
>   drivers/power/supply/axp20x_usb_power.c       |  84 ++++-
>   drivers/regulator/axp20x-regulator.c          | 100 ++++-
>   include/linux/mfd/axp20x.h                    |  84 +++++
>   11 files changed, 856 insertions(+), 74 deletions(-)
>

