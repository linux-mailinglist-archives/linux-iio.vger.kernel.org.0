Return-Path: <linux-iio+bounces-23856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410E7B47B5C
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 14:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF78C3BBB94
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC626E143;
	Sun,  7 Sep 2025 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCoQKlGB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6082D1D6194;
	Sun,  7 Sep 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757248666; cv=none; b=D+cLbjuFMzkOhmHDbBfpVCCWpjoSDOAM6WrlxiyEtY+aIXl9Ey3hm+tjmhQ1ih0s1PQgsWPrJ4+GIWFNrB9CUlxakrbmokO710BDWokiQcMrklMScK1WyQHEimXR6WHEN/lrap9egU5VndKpyg6x3RF7nFczDxtYUL8w/Hi1ROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757248666; c=relaxed/simple;
	bh=HycviNnl0QtTxKO5LyHKEb5J1lb5WD9r+MFVPuxbUmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2H4x/dTpBLIT9mKABiiMSlMELytv0yKvzxw5n9MpxwUNz+nVNHl79ghKkCkQX+Kndh1wrqkJJeMBTKGkfNj2PA/RN1f+l307buqjgXFYXD5/DM8o1MxPOgjJLm7Ps+liMaNh9kPOprOS2iR86iyeNHQc4UIV99Dz189Azrf59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCoQKlGB; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f7039a9fdso3715239e87.1;
        Sun, 07 Sep 2025 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757248662; x=1757853462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4s58Bk/KijXBqHJUWnOOmuKtTmconNejosOHDLYvGk=;
        b=JCoQKlGB7o3hYV55IqpxwIXt8CSqt3j9eHKHoSfwVA/dUZqsIaMj9Esal0Y5LUFEqF
         w5Q0WsNBfkJnsYqHsJQFEui7hnf0hjU4HIYuG981w0GEbuSr57OVyxfJCCtGVT5qmAtS
         nGrb6OnLQz5CXtxynQT91eGTl54ouZTllwxXSPeCIvUA0DBY7YHMDNz/vTd+OcN10PlH
         dWp4mKWiiSEcWX3iI5CVxlRm5+PeIw2GZpVGd/fk46GJl2h1wPK1jCRvuXa9ghSQxAP1
         o1+iPtrUpEUbXot7f2KUHt0sNKuA8c0jCkx2asNAQcsxwUyKY6ncqYNhN+Nl6v+H8fuh
         gslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757248662; x=1757853462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4s58Bk/KijXBqHJUWnOOmuKtTmconNejosOHDLYvGk=;
        b=f28BihCHR/P2VPtlNRh+Se1pS+re976XUN3bnBxs7PIxSRK6DwmLfBsnhrRGnlFuIS
         0k4ItzG8qsZUemz6S1wJNqx09fgrtt5xDXRRHtTPhcHV2FDdinpeiezLDBxkUXxZ2c5R
         /Pcgl6TveYB3+81AX6pNI04axD7/gTf/6+YZ+KGsPBJVTfjmvMu75dFZT9qWTuh4Mwlr
         CVrOGmKGAJJSGy2b3AvC63YBfMETXMGHoSRklA2CFakMJRb81OzpTzk4oTetEpWsQrB8
         t9MzrmZXOWA/4g6rApI6d/BtPOvbivOn5Tp7F+9P837RWojqVOqeWtTWRHkGoFHCr35K
         ihvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMC1oqfveCZVup92VgonX3Jf8wDRfhaP77hx/jqTiIPBnX9RNZbEQ/k6Jpik8y5ZB/RtwVrhyy0WAX@vger.kernel.org, AJvYcCUaU0FTqD10a2S/k6DnsgDV78zmoeYWSErP41+B+gagv4kPf+VYVPeFzX1a0W+3enitPQBpO1ouyWXb+A==@vger.kernel.org, AJvYcCW9iQ6UUGr6nR8GteWp9izgVwfoe1NtfPLCYD4oJjcOtsFTqejknXFQjB0yxerNf7pfec9Iky89sswP@vger.kernel.org, AJvYcCXwGMhHImhRyZ9RJX6JhYJxjWUgHgxY/Yp1ExXVg6QHe7c8xBIVHho3/0Dy7Xv82Pj8uGcYEgw0bRZG3btZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMynDPQpTtQUN3cTZRxzdlevtmNzXhIH/5qowgmuL9FZ8ZcA1+
	4cJFurNfuGXH33WeJUCj4Z1bvYCTikAOhkW82UJVhcegD/97i3g9AXBJ
X-Gm-Gg: ASbGncs3zQtULbawputcxTJMM1Ezd0S2q/NnpmGRLsuT5bI2Dhp/CSAZmE3EwcEqNWD
	goNtTWIj2xmL9k+9eK8zq/BPkvgoTpVYap7m3o1cah0XMGM6xpESP52n0batNPWiTfsO/zHliJo
	35m3k0iiYfVJrDPmtn3Kxxu2wttve9sq5c3k6DEe5fB0EzQuaRkndwe89tPwke82j6XOWz/2btc
	AXrtATnym7bXIMQPR8LiVd4psEQmSMfzhTBIhL4KaNlTduSFdGmT4ZV16Pw2WZgThVorxaK3Izw
	vqcK+GIn8xVrEZpdi7WbrDTzxDgIDktSCIaepq7k4NOA7139/4QJRamODuykx63EGbW7xNGtJMz
	hWWWNuzSopih3pApVi+pxeBTxaZu6y5X8W8igA+w6TTtDl56P8plNAGbZRGI/W2ovvkmCd5O6gw
	iO0NTk
X-Google-Smtp-Source: AGHT+IE42icfVHU5uZzzNitKUaqMWOXWaxc/p/+9eZUGBW/kTuwbjFWBHpYx/5S/rCWX52lact97xw==
X-Received: by 2002:ac2:5685:0:b0:55f:71ed:b0da with SMTP id 2adb3069b0e04-56263ba2acamr1434099e87.55.1757248662349;
        Sun, 07 Sep 2025 05:37:42 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad11f25sm2815887e87.115.2025.09.07.05.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 05:37:41 -0700 (PDT)
Message-ID: <69eb8aaf-2ab4-4e54-89cf-1be51a616258@gmail.com>
Date: Sun, 7 Sep 2025 15:37:39 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
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
 Hans de Goede <hansg@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1757053456.git.mazziesaccount@gmail.com>
 <fc3cffa3b75d1fcd19df0ff794e6ad75c8c87373.1757053456.git.mazziesaccount@gmail.com>
 <20250907121911.7c2fa1cb@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250907121911.7c2fa1cb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/09/2025 14:19, Jonathan Cameron wrote:
> On Fri, 5 Sep 2025 09:42:18 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>>
>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>>
>> Add a device tree binding document for the ROHM BD79112.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Trivial comment below.  If everything else is good on this version
> it isn't worth a respin.
> 
>> +examples:
>> +  - |
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        adc: adc@0 {
>> +            compatible = "rohm,bd79112";
>> +            reg = <0x0>;
>> +
>> +            spi-cpha;
>> +            spi-cpol;
>> +
>> +            vdd-supply = <&dummyreg>;
>> +            iovdd-supply = <&dummyreg>;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            channel@0 {
>> +                reg = <0>;
>> +            };
>> +            channel@1 {
>> +                reg = <1>;
>> +            };
>> +            channel@2 {
>> +                reg = <2>;
>> +            };
>> +            channel@3 {
>> +                reg = <3>;
> Trivial point but I get bored scrolling.
> Would a smaller set of channels allow you to provide same level
> of testing / documentation?

I suppose yes. Trimming this to maybe 3 channels would be just fine. 
I'll re-spin the series anyways so I'll crop this too.

Yours,
	-- Matti


