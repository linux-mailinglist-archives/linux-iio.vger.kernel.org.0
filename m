Return-Path: <linux-iio+bounces-23671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D9CB4183A
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 10:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D1567A30CD
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 08:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C3C2E173E;
	Wed,  3 Sep 2025 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVjxMN0U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4D16FF37;
	Wed,  3 Sep 2025 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887453; cv=none; b=q+H1K1U1850HmEiGb7MIcNRtjcFK6RCn9QNOIWFzGB92pTw4tN6/oEoaHXkd+F8RAkCs77pKGe9IpVRyjK0W6iCXEBkqqI1iRf9Mzw11bNw4FAZcfnoyVtu5lG43vKjGZC/PoARUrXMrFHRtaYlkB5at84HkJBk5A53efKkSBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887453; c=relaxed/simple;
	bh=uKpnAzLWfdtof80SJFgJD/xWRmX2bPTYKS22SYlBT1w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UWDASLlbURu5WKQdJDwK/NXhGUgRrb4U+iXOn7qcvj+d1XORqfC/xbXSz5uU0IAxYQu2HiDujpjWYs8oIvwrMt6ug3h47W0pZ1rS16pqzmq3taDZ8uqiuhNIOoQrXlIjkXB+InSaBSVrJnd77A2Wr9Dk419Zapje0kjT/cRtEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVjxMN0U; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-336cee72f40so32910141fa.2;
        Wed, 03 Sep 2025 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756887450; x=1757492250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e5yMQaGuq2FEjQpYIbcJelW06QsO4qSYIb22l/g+sVs=;
        b=MVjxMN0U+cIcybAONrjqBzNPYQCZ4f7KEwjcOLEdPg+HkzVDddyRmUX2+8FILk6tXN
         MSg1IxkrliHufVJqJjbVZRhuLNoRLRQg29JDO1xo9EYqaijWrITBMCCjzykGB8jlCLun
         OyFRmWC9ONyxGKNeAeB6PYiwjm0kfWEPEPej+KyBkClTKhmkFnz+Y9e52/z+hj9Q5gAj
         H0RCcEl/qHxmicHFlKW2dUkuy2oOgIDkTekH4n46zCWs8avxPvmH2q+V3PVd2wTccDFf
         8cuDxDLvQXrfB4BvRNRp6ZA98Y8kqgrcOkkNJzuUV14i4LLDF+NLkNVC41n/WO7QZYw3
         G1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756887450; x=1757492250;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5yMQaGuq2FEjQpYIbcJelW06QsO4qSYIb22l/g+sVs=;
        b=psZGpJFYHxy6/ZVk0V7Q3aXC1chxoz55AhGldK/vJcTg453j0H4u54+Fv3REszcHyh
         xR0K7OdcPl/IOX0V2d8HF9O1oIF5RKF111UVwf3yaKTfgG+22PDy9xo16IcunK5wCvJk
         8beHggB3FJHeP5N0Z1ts/v0KNW9VFsL0/HgDF/BX3xwNxcHkfk7Daqnan8b2tC9LCUml
         16pwZVK5nnFbqkjHQMHKyU4KcZkj2Ud5cm3aKIG+81nrIyDkxSdiwHlXAHtHCFCjMX2F
         oonencpk1RixWIg2tPQOuyeDqmWd4cZmQZLWYW0w0x/EC1IDhqpXFL/ezk2Tcdn3iod+
         yysQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKTdkZ2lKOkTCrQskq2/sEy9FzYiAlohJHRkLQE3C3DzYGxs1Hu7TX1rYTwD7VmwqZU2CLZP/1Nt3S@vger.kernel.org, AJvYcCUYo9WzEGzlgxoSb9IrWHxFkhBw96fLfbeddnZIKVtP1vUG13ZwU2sCTGy1Dfu0thnnqaYMX1k/a3JO7vQw@vger.kernel.org, AJvYcCW4AarsVBe3Qo/Sby1LU38nLwCDYZrU788X1Nk50fDMDmAiF5IO5LxSVGEZyKlXRfzBvnfxqai1haFd@vger.kernel.org, AJvYcCXYBdlUHNgIWRA8y8bVPPyRxMpxB5OxsnJnPi+bOy/LfRdq04jdRXYoQumHF56KODTwQSS9X9mQDzblgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKFl7UJnFeyhOWweRbGPukWsFv+vXy18SGVYIKoMuMFoihfS4a
	pA2ONU3/ZZTtULQRUTkdvu6PmPItRSr++B96MpufditWqz5Jnf6nTj4g
X-Gm-Gg: ASbGncvKxAdidM7zO6ECcegqe732alcCREAfFV2c9qLKFnqXaPXyUXm1EqbBcR7DEK4
	DS8FDereguT5iiS4qwUiv+GWtnTIx+zSP6ZYCebYmSq9r0J5/CpYvzsERbzHvaEKhGZ6aER1c8Z
	UR76QGo/aqwitAls5HwKN7nOKjLbxv02Z92jXqnB9koY7VV1z6YJKszGTSyI+vwy2lNc6UhHss8
	aAdqT7SblVh6heo7buHXHn2oHEurSwowFO14bLmiOrzhjohtINh7skQFQCGCbVvOZqln9+m9MQw
	AfyRL9NjcQh9FmyFEk34GC3GnGE3g5VLDDHtdVqqXjt6ETXvKp7v6/L1TksbvxG3q49bDRhflhB
	fQ3UCTlHNZTnZNFPp/VOrdNDnngRXG2rSKuW32uYt5ngBTWHKaR/wXX+3PGXAArTDuX4KT4uxCH
	kk3GPr
X-Google-Smtp-Source: AGHT+IG+YijVHFyUxNVvzXnWLLiyTtyGCjk3sCs0cNHeF6s+anfHpB6noxI0ggPIV9/xDPtaPgyzkA==
X-Received: by 2002:a2e:a4d8:0:b0:32a:6e20:7cdb with SMTP id 38308e7fff4ca-336ca997e26mr28937091fa.17.1756887449970;
        Wed, 03 Sep 2025 01:17:29 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032df6sm8788741fa.39.2025.09.03.01.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:17:29 -0700 (PDT)
Message-ID: <86f7a107-cf69-40d2-9f96-e2025e28eaa7@gmail.com>
Date: Wed, 3 Sep 2025 11:17:28 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Michael Walle <mwalle@kernel.org>
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
 <ffef0fa6-45e4-467b-b264-1df15754d213@gmail.com>
 <CACRpkdbPzq6yKMHJXaFmXZSsttUkt5OAKRTSc_pjLwZZiZr7Gw@mail.gmail.com>
 <9f69e164-5e63-44c1-9354-90b8de2ca27c@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <9f69e164-5e63-44c1-9354-90b8de2ca27c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/09/2025 10:17, Matti Vaittinen wrote:
> On 03/09/2025 09:47, Linus Walleij wrote:
>> On Wed, Sep 3, 2025 at 7:23 AM Matti Vaittinen 
>> <mazziesaccount@gmail.com> wrote:
>>
>>> Anyways, fast-forward to this day, I don't see it handling valid_mask. I
>>> think it is a must for this device/driver, where pins can be either
>>> GPIOs or ADC inputs.
>>
>> Why not just add a .init_valid_mask() to
>> struct gpio_regmap_config so it can just pass that
>> down to its gpio_chip?
> 
> Sigh. I suppose that would technically make sense. (So would allowing 
> other IC-specific callbacks... ;) ).
> 
>> OK I don't want to load you with too much extra work for
>> the driver, but it seems such a small thing for a blocker,
>> and Michael who wrote the library is really helpful
>> with extending the code, so consider it!
> 
> I suppose I can see how that works out. I am not a fan of maintaining 
> the extra code. Thanks for the suggestion.

After more thorough look, I don't think the gpio-regmap is flexible 
enough for this IC (either). The BD79112 direction setting requires 
accessing two registers (one for input, other for output), and I don't 
see how this could be done with the current gpio-regmap.

...If only I was able to override the direction setting callback with IC 
specific one, then I could use the regular gpio-regmap for all the rest...

Yours,
	-- Matti

