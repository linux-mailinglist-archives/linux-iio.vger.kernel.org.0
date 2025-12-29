Return-Path: <linux-iio+bounces-27412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9072CE6DFD
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 14:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32E88300B99C
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC711311958;
	Mon, 29 Dec 2025 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do86hzAX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC030FF32
	for <linux-iio@vger.kernel.org>; Mon, 29 Dec 2025 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767014636; cv=none; b=m6iXVuLXlYC9ZP81Ssmz4cGnHpzelVG1FE5W0acHfzey+DZay85m6naofGVlSqXCvSNKPhnGekyeaFpkxgz3i4VDhkJWSKpVQU0tEdLFZ9nPclDtNBWGT6lA9i+RaRpl9lio+JhaLtuNjQs321HAZBiO8ReMMtP3CU6jAkV46ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767014636; c=relaxed/simple;
	bh=Uk1RfjVJyKQ+tgH4YRtutVqI3YFZB+T0oNkbYL96PII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+64r/nBI6hjtSOsVwVrd9iJ3Wu1xlnAkqNYkN4EKyCVKvclZyoom+UbcXQUuhSjfNxGOf7PpQnMWb2NTRVMrTcy0N2v570VxmpRSo7lQ5ivLOPmXxHcqO0x7Rn7xInGIGxw4jvFg2IA+F5piF1lObB5U2Vw3hkl9lBcxw4NG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do86hzAX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5943d20f352so9760085e87.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Dec 2025 05:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767014633; x=1767619433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYz2s5u+HJFZpaoUYiP7p4BhV+8iFu1MO193Mzs7/UQ=;
        b=Do86hzAX5ViREeXoHBbfWoTLLFCVfYXJNu0Xu8xY6M3JXpZuP61lRuRcUXd4SV99Px
         3DTPBbYMGLvm4XamCxcAl7gB/Wmv7JpXlSkYNmI1Cl+TfvOpGqlPqIGEEGnEJdbNpr1c
         //lv+eFyoa47kL/iNEcOxIpSUkpkXWMikc4RdxVpTmPSN1DwB/B12dL13+C7fXdEnGsB
         5BNVqiHel0RKYiiEOPrJ267fwgamk205HKMI0c7jLboZkR4Ei3H+FavhZkxcnMeGLS1y
         hXNHVQ6LFANq5qXMJleZyJVv6m/8qh4Iqce76YfqtzBkJHbxt1OZ9u6EtRdOo6d3StH/
         sOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767014633; x=1767619433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYz2s5u+HJFZpaoUYiP7p4BhV+8iFu1MO193Mzs7/UQ=;
        b=fh/DrEoHqOBbimrpLpDk7I2opKP1gPDDnSzCRfYN8GusHDYlvjUpSD7JNUVjHWD2oM
         hEQcKL/03lTdUxdOiI+AL/58+dRMUGxsXDaSbt1p6817WZSeI0/pKmkZ+cgr8sy/19l8
         BsevT720y01Bo0EpSk6RvF7Wp0TN6FAL1c9EVvhgZk4y0rIPMB/pbgA4+KNcrPDvylaN
         REeq+EBdUhzA5I71j202V+46Nn0U1hYo53XSumW/ixRtQYXZa5i71hSgkhFp3TBdxy3K
         ZFvrbQn57E33vsEu0vurqMhAMGGVQYi8PMEraQpLHMj+Cd3gb1MEp7UB6w5+NNpfBiGL
         H5dw==
X-Forwarded-Encrypted: i=1; AJvYcCUZvg/2lXukmurMLtYleVdLEKxE2IMIlp47vC0+IUOKLCmA17alBNq//15YH2FzGKIAhFZ7LAWPzys=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsli14R80uPXakYa6ueIIVJRwiy1Uol/nxEjs+Kaemu1/Ca8wp
	spKpTEboByc4Bm7RxAHVH+FdsTRI6nLe0jCiBLY6yzqqv43SLytp05+9
X-Gm-Gg: AY/fxX5RGHyxftink1doVrhCVy3aY6px9fUAym8AOIdLiZN+CA3euNgtmbRuBwA+Nq4
	+FO6eguzOukCbV84N1ZwXq4wBOn0DKuovHWDgF/wP10vgz9nIviwgpZuusIeeKvXlKy0LROkubS
	/yieKISUsTeyQmj5XskFfuEPr/qeBM3nSRIstBhXMyI7r17tKHxqbTLMwR9vRTKX0HQFCk/IZ8h
	40+5Y3af8lR0h2SxPwnbpRzspJDhoGEXDJiN2Ut9cuueZR+Glw/n91+cDzFbbqCIdbcDzt03q7D
	FqawSWFFl2BqDava6ikUrkDNqSPFQCfY3inxZD3ypjGJAqf/aFkaJ1YY5eK5eFh9OoPNNQOM+VL
	jofkNo3y5poK5rQ+68Cx9pIHfhfnuN6of1B9lucAsEAX15R8vGNJsdLXlvg7Gavc0aHPighMnwG
	WuBwZ9pFZ984/8XYSF2kI5rhQqfMuW0cHb8YcSnBT7YtFyhCfyJrouAKU/DRgGTOql0NTS
X-Google-Smtp-Source: AGHT+IFa0k3Cw2xv5tgyHJPZwAhfk3MPquGhpdE7gPKATpe5MLbPoMdSC+u2Dbj6A6onRGmI43iZrA==
X-Received: by 2002:a05:6512:31ce:b0:592:f27d:75d4 with SMTP id 2adb3069b0e04-59a17df1dfcmr10799023e87.45.1767014632794;
        Mon, 29 Dec 2025 05:23:52 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18628040sm9192868e87.88.2025.12.29.05.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 05:23:52 -0800 (PST)
Message-ID: <323d7c6d-3082-4775-b5eb-4bcb3ee9b1ea@gmail.com>
Date: Mon, 29 Dec 2025 15:23:50 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add Texas Instruments TLA 2528
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jonathan Cameron <jic23@kernel.org>, nuno.sa@analog.com,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 duje@dujemihanovic.xyz, herve.codina@bootlin.com,
 Rodolfo Giometti <giometti@enneenne.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
 <20251223155534.220504-2-maxime.chevallier@bootlin.com>
 <56c03c7f-1e5b-4586-beb0-47a1fa3bc86c@baylibre.com>
 <c386a4bd-9c7d-4b4d-b614-fdec424d57a0@gmail.com>
 <CAHp75VfDnuyqRyHpVK40qRR59XB3RHV-aDO72UDNhjLDbJHDPg@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75VfDnuyqRyHpVK40qRR59XB3RHV-aDO72UDNhjLDbJHDPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/12/2025 11:31, Andy Shevchenko wrote:
> On Mon, Dec 29, 2025 at 10:04 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>> On 23/12/2025 20:26, David Lechner wrote:
>>> On 12/23/25 9:55 AM, Maxime Chevallier wrote:
> 
> ...
> 
>>> It looks like inputs can also be used as GPIOs, so
>>>
>>> gpio-controller: true
>>> #gpio-cells:
>>>     const: 2
>>>
>>> would be appropriate (it doesn't matter if the driver doesn't
>>> implement it, we know what the correct bindings are).
>>>
>>>> +
>>>> +  "#io-channel-cells":
>>>> +    const: 1
>>
>> I didn't check the data-sheet, but if the pins can be set to be GPIOs or
>> ADC inputs, then I would require channels to be specified. It's only 8
>> channels, so always listing channels that are present shouldn't be that
>> big of a problem - and it should avoid one to add extra properties to
>> denote channels used for GPIO if GPIOs need to be supported.
>>
>> Well, I am not insisting this, there are folks that know this stuff
>> better than I :)
> 
> Why would we need an extra property for that? GPIO controller has a
> property for valid_mask, should be enough to handle this case, no?
> 
Ah. You're right. The "valid_mask" should be perfectly usable.

I might still require the channel information to make it explicit - but 
as I said, I leave this for others to decide :)

Yours,
	-- Matti


---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

