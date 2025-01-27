Return-Path: <linux-iio+bounces-14591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D70A1D327
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 10:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D391887232
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2F1FC0E9;
	Mon, 27 Jan 2025 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Mk+a/G+6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E1B1FC7FC
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737969356; cv=none; b=VUZOgj+1MadBq+wSDMMF2WyAtNOy8BSNa1G+xk23YucwrzN2bCeChXGtxW6O2UVe1LqtGJW+JL9KOXfiqEQWOD6s56BWrrpROQFzCv1hwDLJgAQq2666g9KHsq+JqTE8qrripOuDpn4RJ74PaznQuH3u0bmzJeyP1DIn5xgxBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737969356; c=relaxed/simple;
	bh=TiphF4zr2Pj5KkcZbHO32+T00/RteL1cHzkWaqktWc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W08CjQ1V5KmMIy53Ey4If1aXJt2GhMBpHBjaDUczv7Pac3PQmzCdu2G5H8JbQq+9SPb7A/wzkJPd8nHbUwRU23dew1UgasEuJBxyBFCbOkwa/8cIlVWgsMyLVQZ+y/IxoShpZGnss+oxvM3XMe3hy5LbiBoQ3DISsQf8UcOofq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Mk+a/G+6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43634b570c1so28958315e9.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 01:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737969353; x=1738574153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBqjoTrsUdniKM56G4qXF9X4Og44OEoMJTzifBY6c9E=;
        b=Mk+a/G+6vr1BN8wXmR2AxAJZ+ulwGCdaYuf6PeOL32ke+WmK6W06D4IpC5Wb6uxEC+
         za/YSj7yo2mXvK3/nyo273k4LSRMdY8CApSCLEEIRQzdY32redtZOb7csWpBHt199+Xo
         DGDulDf4vglDReZfTlvExL7e6z/ArbJI/ut5UM82W+sc6sgmW7nArroClpSXh3elC7uz
         TPd0SHQkbeXMzTYtyHjvxt91++KMqY5sBCmZzjbBBKfsR4n2yLQ/gEBB81gfO5HXlRut
         cDJqR1CLofqFqJOmuwUBcbhH61z3tIXF5z/tbQ97FHw8fYU/9OUDiiv85DRPjRckYrST
         cWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737969353; x=1738574153;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBqjoTrsUdniKM56G4qXF9X4Og44OEoMJTzifBY6c9E=;
        b=HlALmhWYEreSttH5AqtjSWdvW0KUFrDnO3NBl9GszhCKDrpckZxzNCyuxJJBl7So/M
         UWLUC1FMmJDt8/slTzZl5NOqMrBHo09M44TM7WUFDxml5RJkFulCac7q8IC6d1HAkYBh
         tkw4nG/6jDTQqrJvm3h6s0FFAiapqawHaJ2eZa8/s7tqSZWb6Bn7xM0M1UCwtC3R1RxI
         WLChSd0QlzzGuNmeJ0sbZHv1oF1bPcnJczUdUQIQM8FvoUZxkxd4PSvxRUHFjKxy6NG0
         gK3DOUhYaRrvuRoqPNRguU743ezrfzZYNkr2AGIPSb1Tg7cSDsV6fx+zpjtIZzhEwOgs
         vAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm5iOgwtAaL9s3q6tP2r3Vgc1wxs05nXDoYTSlx6cm2Kte8qI3yXOiIIhAjQq9QY+14OkZkXJMB+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSCsFYn4bwqW/1155tW+1/3wmECSrXA1HEG0yE/uCFGDo2Eufl
	BjceyMO8Znb+wchg5JgRLTV0iyrFCa/vbbQyZ+7rBo3lFxiH9FX1KgZtEVK86sI=
X-Gm-Gg: ASbGnct7jWQQYePnuN3wLeOXfQ4f1m51i7/oGCI6cgYE9Mc67lJINkzpvgfgIDO/tg3
	6P1OSyFxy/wZ4DuQXHUV/BHRqF1xJY9+vSF0TbBE9wlrqavc5HWcNLsa0cO6VWXLM9DO6Bmte3l
	dtqB27PHvhQntKT+IBSjdsCic7aodsf2e8xuBvEZCYKGGNldaL4T8XVHnJRcM2FBxK+jjZ7Bql/
	J1c5oPF5opGDTrxIbZIpyrq1h1rAfhU9mNCZGn2IOnvTR1UunL8enTJDTkTr7M6ZdhnCb0eCQs0
	AR8qGLD38x6e
X-Google-Smtp-Source: AGHT+IGH2u1eK/B2vFgK4fpD5Gq2Q6iaPMn6CotExrSV6h3jJObH/bOJSe5pLBi065ce7RjDuJEklA==
X-Received: by 2002:a05:600c:4710:b0:434:a59c:43c6 with SMTP id 5b1f17b1804b1-43891451388mr301531235e9.26.1737969352480;
        Mon, 27 Jan 2025 01:15:52 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd502007sm123494365e9.14.2025.01.27.01.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 01:15:51 -0800 (PST)
Message-ID: <3efa204f-ed98-42a4-a708-828bcf1f976a@tuxon.dev>
Date: Mon, 27 Jan 2025 11:15:49 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] thermal: renesas: rzg3s: Add thermal driver for the
 Renesas RZ/G3S SoC
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jonathan Cameron <jic23@kernel.org>, "rafael@kernel.org"
 <rafael@kernel.org>, "daniel.lezcano@linaro.org"
 <daniel.lezcano@linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103163805.1775705-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUDKFRsZWsZG9DY4PHdxQEDoPqzfeRx8MNTreOpxdLvpw@mail.gmail.com>
 <20250125121826.6abbe7de@jic23-huawei>
 <3c7f5a92-254c-4ce1-9813-80c98c1f549e@tuxon.dev>
 <CAMuHMdUPPTyuJuWDEuHFT8EQCTVpy5=UtDh9GajdWUvZBNqy0g@mail.gmail.com>
 <TY3PR01MB113465C742C78714F7BC09D5786EC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <TY3PR01MB113465C742C78714F7BC09D5786EC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Biju,

On 27.01.2025 11:11, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Geert Uytterhoeven <geert@linux-m68k.org>
>> Sent: 27 January 2025 08:55
>> Subject: Re: [PATCH 4/6] thermal: renesas: rzg3s: Add thermal driver for the Renesas RZ/G3S SoC
>>
>> Hi Claudiu,
>>
>> On Mon, 27 Jan 2025 at 09:33, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>> On 25.01.2025 14:18, Jonathan Cameron wrote:
>>>> On Wed, 22 Jan 2025 11:29:19 +0100
>>>> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>> On Fri, Jan 3, 2025 at 5:38 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>
>>>>>> The Renesas RZ/G3S SoC features a Thermal Sensor Unit (TSU) that
>>>>>> reports the junction temperature. The temperature is reported
>>>>>> through a dedicated ADC channel. Add a driver for the Renesas RZ/G3S TSU.
>>>>>>
>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>
>>>>> Thanks for your patch!
>>>>>
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/thermal/renesas/rzg3s_thermal.c
>>>>>
>>>>>> +static int rzg3s_thermal_probe(struct platform_device *pdev) {
>>>>>> +       struct rzg3s_thermal_priv *priv;
>>>>>> +       struct device *dev = &pdev->dev;
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>>>> +       if (!priv)
>>>>>> +               return -ENOMEM;
>>>>>> +
>>>>>> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
>>>>>> +       if (IS_ERR(priv->base))
>>>>>> +               return PTR_ERR(priv->base);
>>>>>> +
>>>>>> +       priv->channel = devm_iio_channel_get(dev, "tsu");
>>>>>
>>>>> Given there's only a single IIO channel, you could pass NULL
>>>>> instead of the name, and drop "io-channel-names" from the DT bindings.
>>>>> I don't know what's the IIO policy w.r.t. unnamed channels, though.
>>>>
>>>> It's supported, so fine as long as no future additional names show up.
>>>> Will just fallback to index 0 I think.
>>>
>>> If everyone agrees, I would keep the name, too, to avoid complications
>>> in case this IP variant will be extended on future SoCs.
> 
> If you are planning to extend this driver to other SoCs then may be update

I don't plan to extend it. My point here was to keep the driver as is for
any possible future extensions that might arise.

Thank you,
Claudiu

> KConfig with dependency on ARCH_RENESAS? see [1]
> 
> [1] https://lore.kernel.org/linux-renesas-soc/20250118-trout-of-luxurious-inquire-aae9aa@krzk-bin/
> 
> Cheers,
> Biju


