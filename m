Return-Path: <linux-iio+bounces-23669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 761D0B4160E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 09:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D921B21795
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 07:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E5E2D7DF1;
	Wed,  3 Sep 2025 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGwoJCjJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A32B14A4CC;
	Wed,  3 Sep 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883846; cv=none; b=r+UJOQQXU3At/YED5HFGvj07wYR7cgbjl3VvqBOzo55jMjNki7HdGlyR/eiwWexm25/Fiu5MtbreYP4eWhCqK8ASKU55tzWb63wj8HL5jx7XR4/k0OWsfZblUOF/wbx+5lUJagrthwS/KCtOkHCbao+ddcDRipsPZFjxanguUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883846; c=relaxed/simple;
	bh=rS+GMFN6DYpMK/tMXtZeCXtyfW339LfrvEVMkyMjPf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onC+mfnVD17FKiI+cJzZ0ui8IuQ188RuVxSkiRCNai/+d9uZpECanwaMBKGdrlwLSUSkPQT20NmFvlz8c0qVzlyzVSJiQKIhxAqHjpCfd0jbX/cc598GxaaI4bYAqWoPAEQQGFq4hqqo34pKXF/6hEuug97nd6yE4ysaxkfR5I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGwoJCjJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-336cdca667aso31072091fa.0;
        Wed, 03 Sep 2025 00:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756883843; x=1757488643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IeRZ06/PcOGv5wFop3bzPLZKGGCh1W+n5JN85+7/Z4g=;
        b=YGwoJCjJH7BtaTb+GF+EE3Cn2LyufMMouAwZhJoFs7HeTV+KsFt320QGxxiHtIB6nL
         m0S6f27dYE9IIBdhvwX9BpdeYvmkgs0V7kju1HeHuyiOielhvIDJM4NolMgfIKMDJleF
         9eVdvgtg12zSN9XuCPJB9wA934uthQKlok1bvGdvwL94feNj/5GjmbaSmJ6fWitJf0tV
         WwQVIJVbM3urZ4Wn3SOte2jAPfaDXewUxMWbc9oqU/oj8CG/eMi44EaJR/amgx8jzI5R
         xFPPtGxKI1LG4tuyw96FpXB54wSgvoWKY4xPk0atABeGykldiKtezXwrrn5vMYc6woZ7
         XmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756883843; x=1757488643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeRZ06/PcOGv5wFop3bzPLZKGGCh1W+n5JN85+7/Z4g=;
        b=YUsCahL6hhEEXXHrpXue+gPZLxynwlTTrQ+7+lKMerBL7snTyDj4HDPKoVwqopL2G/
         imF9Q1ryUHkoFRDpXw/NuD9rey9CQ1qTKS1l+YLkJZs2IjU/duzamt0LmnBAXcLqpiVH
         idGnVQGFuR2PEf9/hXgXIoXMup/5YeVxbwaHd24z30vUWs2lXWiruZvZkKJZ1qltRsmM
         ID6giZREonKa4VfxSIemu2TzJE5ur/5NyiHuWbra696a5+LcTNFNhC+vWHgI9WgOtRP/
         ClbfdAdy6cP+WfgLxaGQgpr1cjrVL4AWTwelud+X7DLHr8mt9+RWFx1oRRxY7uZnJu0d
         nXRA==
X-Forwarded-Encrypted: i=1; AJvYcCUA3UnV4qaPlfaBFgIsH0x878aKwCS79c5MdLVWzFW6u/kAQlmceRW8CKqrvjHD0TxU3H0aPYGyBuOH@vger.kernel.org, AJvYcCUnPUbLryrf2Tt3beZArNo28ceVL0hXM0SVSHXbN2qhuJzmULXmzlQEBx4gnAGHKVq5KNW7AL8UIJ3Eqrjx@vger.kernel.org, AJvYcCUz+CJLsFR13MwagQ55Gb3h/efheHhIp3lgE/PnU3ikP+H8/AC5q8sg862AXu5C3apjGsqVMeLw75nomQ==@vger.kernel.org, AJvYcCXPyMVbyGBdtyh/IOfyTcJLg6HiN9S4n728EGiIIBTVOCjDyJ1n7VjF41CAPhX7L8s8MA1DNuW8w5Gh@vger.kernel.org
X-Gm-Message-State: AOJu0YxSd9EexxQUZyA1h7UtsxoxjZSn7QyPax27URdS4Iw9iDevLm3u
	UY6+yJTnhtMYeiWl2RnsIDblQHLxOX1mJ9roTJy+8w3FX0VEyzhR7NKE
X-Gm-Gg: ASbGncsFh8Qie4IG6LlX7JuB1UB/YeKh+NlhY1216mNP1jME9FjFGHVW/TN6vXeSvdy
	btabDXMfGdq6E34QbYy6HcTm+IGvJLXvpaD/ejlJxVvPfNgpDcpr8hXRges6Y0I2kX+ArLdvwyj
	w7aW4jzAfPVMrvataCWY/jqBWuKRBPX5cjKQTfd0n3Y8qY+0yG1p8899Mf3PqVeug9/LcEJU0jn
	/mHVhwGFALYayb7ffNxuuXfYuNANrcIMG8reooL49NdnToK3YGFvNPErnKhZrg28A5K0uaq9iLk
	B3CmleyoZ6+aUtIWAD2akpDVR9i/9iDYlt6yH8IrbWi1pWLqkDyDN8VfCZmH4ywj+5DApHyJfjb
	Y7jR57PrBq4qCAUp29+3e4A5QWPxayBbVkTBMudWUuBeV889jAaKxjXHHWwoXjT/C0eH8ODOKMu
	ZnekEhGGtIc8X5oyQ=
X-Google-Smtp-Source: AGHT+IH4donoMajQ1ZDtMHQf7JgfO1jPt6SevfQxLs1STRELrKW/ySlmrBxaws4E9U+sRDecrkzamA==
X-Received: by 2002:a05:651c:19a3:b0:336:7e2f:cc0d with SMTP id 38308e7fff4ca-336caae0708mr42291641fa.23.1756883842863;
        Wed, 03 Sep 2025 00:17:22 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032aaesm8252801fa.37.2025.09.03.00.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:17:22 -0700 (PDT)
Message-ID: <7fcdd66c-4c3a-4df0-b4ef-ce61cdaf5112@gmail.com>
Date: Wed, 3 Sep 2025 10:17:21 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
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
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CACRpkdbPzq6yKMHJXaFmXZSsttUkt5OAKRTSc_pjLwZZiZr7Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/09/2025 09:47, Linus Walleij wrote:
> On Wed, Sep 3, 2025 at 7:23 AM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Anyways, fast-forward to this day, I don't see it handling valid_mask. I
>> think it is a must for this device/driver, where pins can be either
>> GPIOs or ADC inputs.
> 
> Why not just add a .init_valid_mask() to
> struct gpio_regmap_config so it can just pass that
> down to its gpio_chip?

Sigh. I suppose that would technically make sense. (So would allowing 
other IC-specific callbacks ;) ).

> OK I don't want to load you with too much extra work for
> the driver, but it seems such a small thing for a blocker,
> and Michael who wrote the library is really helpful
> with extending the code, so consider it!

I suppose I can see how that works out. I am not a fan of maintaining 
the extra code. Thanks for the suggestion.

Yours,
	-- Matti

