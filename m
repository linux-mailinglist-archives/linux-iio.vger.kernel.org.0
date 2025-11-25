Return-Path: <linux-iio+bounces-26459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD8FC86003
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 17:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986113B1606
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9084329C4B;
	Tue, 25 Nov 2025 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsPvCFZd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A6432937E
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088649; cv=none; b=QL6VGZ47klbWw/rq49lwkKr17iRlOKg7glRLeYAq2Lu2TVYFlAptftXCMYT+6KjCqQJLZRv0ldesqe1mKK5JfBayVCgz0lcDA/47guk2GEU1mbyT2d29cowduue7uS5+lGEI/fs+k7wVUt4dD7rJ6qa5DOqMLjhik9W+4n34N9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088649; c=relaxed/simple;
	bh=TAlmXzkH1KqpnNqrCrXGhz8fQgBzldHSxQYp4L9bbL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5o9oCpCwGKTsl8V2AGM7phwc2+gdQkWzf84NzCnoMctc6HB+Jvznl40koVLBw1L+/k1nFgb4et+ryaZAqewoIoV9mOHhWfTyUHpfq+6N9euOL3k06G4Ut9z8IR0panN+mP58xpwIYqvQK209FYExpwf8A8ni20ktvF6ZKQYmao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsPvCFZd; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34372216275so5807521a91.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 08:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764088647; x=1764693447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BSWJkC14D263EaCk7olh/4x9IvEymCiNm9Dm8xKZmcc=;
        b=DsPvCFZdv+ulKh8LgL7ahJPF70vGMfe5q5ajFdS3G4SmcOyjjMubEg0TsR4Kads5i1
         8MY22+xFEm5wi0Kt1753mhPdJkIziFC1ZLhb4IHhg4fSj6wihfxeqiS4McVUSRrbv9mZ
         6LVsKRhCHrbogEoEaJxTaipcWdUYl0mpKDTqGS6TTfiF7cPaWuC/TsiEtaTh6uUuGJrB
         hE5wilE1sV1Y1OAlcDYXD9ekmMyaSPSqWqcBGU0SmW3g3erfJPzSgb2a0SJrOdiAECGq
         HTmbUX7LduKtvM0eNtAq6B/EDD2DyH2gQHC7qtK9D5a9cFKPFpbk+OE/YPRq0N9Ul441
         HvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764088647; x=1764693447;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSWJkC14D263EaCk7olh/4x9IvEymCiNm9Dm8xKZmcc=;
        b=bG9MCsj4is0b2BuJ4goOPaTT6RpGsVyz/DvzoWkoHyMATiK55TktZHNuJwBaGECPEf
         c+WR2o4GWxLuF+jnPJqVEidCCS2dn4mPim+3NH00Hj1UCe0NvpY9kAxHJ/EaWbGk4jSb
         KZLgxCG74QfO2ALQP7XJYNAD6j3Is87tjdoPvfUArwpiadC2bt+hxK2FIPKd1PI5Y6gA
         NkuDzRV+yZFAI1TWLriWv3Gfp60pgPSgx41oLS/d6ZnYP7Y0c84GGWDtXg1zumKr8ZJE
         1eoew4CydYqZovf5t7V5sRfFmZnLBoQeuolq4zFwsNr4J++sUnGaZhoRWgMs57QKbywK
         DIcg==
X-Forwarded-Encrypted: i=1; AJvYcCXuD1NSmHXLIwqvuwdwHhfb2r6blbg5cTgBR2xxx1Akmg2etvaqvDLriOWDL0UXWq8NLKD7o7Bos8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiP35I8UgXxvgFGcoCx5UaITj6xr9wurXMlFK3FeH5wBIdY8o
	z9i69x4rBSezLQNS7DrbU9bx7mIlnOcGiQs59aVPEnnpdwXeOGyH7iVr
X-Gm-Gg: ASbGncs0Ay7sF2/MIJD5hRr7qRUBFjU961lr77RcRVaoAUUWV0/bORNoaresw4T/o/I
	buxJ38vS7o+oC/zMZbHlizWu5FBKf/00cT2Y+M+uvDtgTjcdq5ZOzzvKSHJYL6G2qOPIA80l9Ae
	QB8YrbwugQ9/iBtR0C0Tb6P2m3tg3GyK3xG1Pys5h/w0GixJzf0gUYQCjIEOTOR1GgQHu7be95M
	AtRtu8lr15TTFBS/D5fwB9zNMLXdGJDYs9wNGxP/Kt+C9qlkHdTASRP6D8nHEg0iweiXvOlVpTr
	wQvRIqdV+wcqjgwnb2z4hEo8iEiBhXnRq+gfGwXGVXWfxcnL7OubY2PsYFtVJQHghTaocCg5L7h
	I2XsAX+OofZ/zQUUJXafj8a4iiCkdkcHhdpchmlyP9gAApfyZPgF+8gmQA/T7lx02QQCYzTd5La
	9DO3Lae63URVV/1TRWAREFKMQ4lwcXP6fuIYXogcbXzbU7
X-Google-Smtp-Source: AGHT+IFHy57b+hpQflAZiQVaoxIk86czwU51KAJ0ICKXYmkBowPOIfdH8aTLY+SWpNInrUa/0Wei8g==
X-Received: by 2002:a17:90b:3c01:b0:340:cb39:74cd with SMTP id 98e67ed59e1d1-34733f589e8mr14550720a91.32.1764088646710;
        Tue, 25 Nov 2025 08:37:26 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475ff34831sm1342209a91.5.2025.11.25.08.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 08:37:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9b43da0b-61e1-49bb-acc2-392de3817db7@roeck-us.net>
Date: Tue, 25 Nov 2025 08:37:20 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Add support for the LTM8054 voltage regulator
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
 Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Peter Rosin <peda@axentia.se>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Kevin Tsai <ktsai@capellamicro.com>, Linus Walleij
 <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Support Opensource <support.opensource@diasemi.com>,
 Paul Cercueil <paul@crapouillou.net>, Iskren Chernev <me@iskren.info>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matheus Castello <matheus@castello.eng.br>,
 Saravanan Sekar <sravanhome@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Casey Connolly <casey.connolly@linaro.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Dixit Parmar <dixitparmar19@gmail.com>, linux-hwmon@vger.kernel.org,
 linux-input@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <4053840.MHq7AAxBmi@fw-rgant>
 <732D3F12-0361-4800-8981-EF629B4C491F@goldelico.com>
 <3021060.e9J7NaK4W3@fw-rgant>
 <0E900830-E248-4F0F-A048-075EAF1D2440@goldelico.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <0E900830-E248-4F0F-A048-075EAF1D2440@goldelico.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/25 02:25, H. Nikolaus Schaller wrote:
...
> Another suggestion: what extending the "regulator-fixed", "regulator-gpio",
> "regulator-fixed-clock" pattern by some "regulator-gpio-iio-dac-current-limiter"
> driver to make it independent of your specific chip?
> 
The name is terrible ;-), but that is what I would have suggested as well.
I don't see anything chip specific in this code. If there is a need for
a regulator driver which uses gpio to enable it and a DAC for current limiting,
it should be made generic.

> By the way, are you aware of this feature of the regulator-gpio driver?
> 
> https://elixir.bootlin.com/linux/v6.18-rc7/source/drivers/regulator/gpio-regulator.c#L97
> 
> Just to note: I am neither maintainer nor doing any decisions on this, just asking
> questions for curiosity and from experience and giving hints for alternative approaches,
> where I hope they help to find the really best solution.
> 
Same here.

Thanks,
Guenter


