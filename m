Return-Path: <linux-iio+bounces-22443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2177B1E52F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 11:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988093A233E
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0FD23535A;
	Fri,  8 Aug 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLDiFpz0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122F26A1A8;
	Fri,  8 Aug 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643670; cv=none; b=OpNn8DWSS8lAeR+Ge/VkQBv8vuKb5Tqoy8LPlteYl0tQGCv/8bR9KulL7pMy1BSAaUYA/GLpKmiplAYijvQZLvxXy8bSo65WZ33LaKj4LEtXqMK6sRW44IN97++/kZcLG1KrWI7QPb6ysMDdA6HA3NBX0yWAIyy/PlgiFhWmvnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643670; c=relaxed/simple;
	bh=1LbQYxv+uEmEfmk9w/U9/tOmLfA8HuJ+dBFmopJiVm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/UgPFUl3zeAbO6gPZysGq+Aiv/GORv8FepMkmv4liIkldF/9xQCmrOpmFWrGHZlSGUMDvwYo5j4am3gARJrlOYeYImOKDreA2BBG4d+kVveSJ/exzu7mELKvYXefXeKf0l54C5Qjvi9rhXLuANgKl9403souU/HyRwHLcMXBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLDiFpz0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54b10594812so2139475e87.1;
        Fri, 08 Aug 2025 02:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643664; x=1755248464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6MavA5nJNsvMG9xx0PcTftiCh+5uHKFSh91f+LoJBo=;
        b=QLDiFpz0Bts1xQNqvLOBjWBprMuZNNYjaBJh+sQBRfRTBYEjyDE3x36FHzfOiDzF+F
         xYb3ov+ZIWSJeuXhnLB9Z9OA9/t1GOhtZoJX08p8rcARKozxAFPFqhijHoTv9tOtPvnM
         /J4BjLGT/wVCfDdJoDH+UxkPlatnLiuVjGdb11mDjd3h4AgDKUSp7T7Dz67wz3DpRTRk
         rqsxpnBa4zR3xcrmVgzaQ99SH9Op84gCa6XNV8gnOEi9j0DuZtApmC7TC5lv1YM7Pz7B
         dLnFKgHRPolfz8I4sQ1SLYCwhKoueOGTv4UWcu5asSXGhoQGeAMVLL3Qo16qujQF1U5o
         vllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643664; x=1755248464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6MavA5nJNsvMG9xx0PcTftiCh+5uHKFSh91f+LoJBo=;
        b=YnR0nsW7z6e10nzhXakly6Bz/krovEVshsHy8tUWHeOWPL/z2aQMfz2YuHvzXg+zCq
         rVdsEFn/21Sh6WBAKIDDEdEPk6MXe+CTf115T399sD0vjW8RkephP5cQrpzwdXtvFale
         w+MQqEVtacxAeo3VjQZ7Ur+I4oA6N8BIFlv+tKxBU4scTAq5mVqEyfVOniG6PUn1fN94
         sk4xjCvEWnIVrG13DkG0K9iaZ7sDDGQwD2nEnX4AGOTo294brPC+fimZg2ohzRmP2nMD
         i6mWgIOWeYauewN+bKIFQhSKSXYbkRbLs/kOI/QYvAZ6jvAxJduhx+mSXe6n/uXBZxfi
         ccug==
X-Forwarded-Encrypted: i=1; AJvYcCVzuFEmzT5+KXBlAvsePbNQiZZSYlMUHNjl9lmMG3MpZUJ/MSiExoLmyVtLg2f1/AGvemk1u/hjQEU8@vger.kernel.org, AJvYcCWyAtDfxB5MfKaubetOitaLMIwtHentQWRnh1hzU7JV4820lw+10EzGjr2PmVZhqwQe2u5SusheZb3O@vger.kernel.org, AJvYcCXeiyOEEb3f2bt1kLFWzL40NFcZSAliN2Sm67et9f1pifxSBcoY6G8si1tyD+1qlyB99vPoZfM2XEZndszS@vger.kernel.org
X-Gm-Message-State: AOJu0YyT22T/VY0ad/knWHX1Yc6oO/15oUfCEXx8GNNDznDc5Yn3sc6a
	GhLJjVt8E7/L07jtoTlCPTsEEof69rtojmFS+S9fLNqfX2S3ZTFA+k+I1+dA9g==
X-Gm-Gg: ASbGncuWQjYwNLxill0BD9eDO92o2lZ60LjkJo3awYVSrFylQTl4knX0+xGXYZaIL6a
	WP8wgwVuPhi6ZZoWUduegfOSg7lZ/3QM3K0csCruip+0/RYOy/2KdcVXH86mT8JDGcG4I/6OC7V
	N78Dtp9L3I2bqMd5Zpu+5DM5cIuycgPv7zUHvpYno9eDNHeTzK1BpY/4LH4BLxu7/fb71z+9Xt3
	Q+RuUMXYIlNrThPFYMHo9cdbMZy9lmjKMzDvkJUnTFfqk6i29WIFvnq2eK372IUOVgGJutNLEcc
	IiZsTxmJr96IkJCrVhcmkXL1KrqXC/mpOnXwW/rwon11/imUVXubVrOKF9INVd/TsmVOBwcelUz
	aTWlAz0JdYtbvADmvXB9oiJzG6OJh0MXwQkMBW/33SXyRfysX/xMXKGe6aHm1Y2NRBrlnnAfknx
	ahm2E=
X-Google-Smtp-Source: AGHT+IHcEHzRarzPfv8ooyQNRcZ0b2FcqnAOFrZrk3dR1dxtp259FGDfRs0RExwr3uvGwIf6Za73ag==
X-Received: by 2002:a05:6512:1586:b0:55b:840c:5636 with SMTP id 2adb3069b0e04-55cc012c8camr559935e87.50.1754643663843;
        Fri, 08 Aug 2025 02:01:03 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ac4dbsm2948790e87.63.2025.08.08.02.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 02:01:03 -0700 (PDT)
Message-ID: <1348e677-d8ea-40db-831b-2f75a7ff6d79@gmail.com>
Date: Fri, 8 Aug 2025 12:01:02 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] iio: adc: ad7476: Support ROHM BD79105
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <da7e6b31a0f25106d7e2f56fb089c8fe71224654.1754559149.git.mazziesaccount@gmail.com>
 <stmpyitqnjst2l26xdlkfqdedczpnxhoydges7xumtl5e46pof@cyidmsvdtdnj>
 <2a678156-8e0b-4fa9-a940-f368cfac8f7a@gmail.com>
 <5w6ryx7dvu5fuxfyz3hwqbncwwh573a6nou3w3ebspbm4e4p7k@ne637fm22n5i>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <5w6ryx7dvu5fuxfyz3hwqbncwwh573a6nou3w3ebspbm4e4p7k@ne637fm22n5i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/08/2025 11:54, Nuno Sá wrote:
> On Fri, Aug 08, 2025 at 09:11:03AM +0300, Matti Vaittinen wrote:
>> On 07/08/2025 16:01, Nuno Sá wrote:
>>> On Thu, Aug 07, 2025 at 12:35:25PM +0300, Matti Vaittinen wrote:
>>>> The ROHM BD79105 is a simple 16-bit ADC accessible via SPI*.
>>>>
>>>> The BD79105 has a CONVSTART pin, which must be set high to start the ADC
>>>> conversion. Unlike with the ad7091 and ad7091r which also have a
>>>> CONVSTART pin, the BD79105 requires that the pin must remain high also
>>>> for the duration of the SPI access.
>>>>
>>>> (*) Couple of words about the SPI. The BD79105 has pins named as
>>>> CONVSTART, SCLK, DIN and DOUT. For the curious reader, DIN is not SPI
>>>> ISO.
>>>>
>>>> DIN is a signal which can be used as a chip-select. When DIN is pulled
>>>> low, the ADC will output the completed measurement via DOUT as SCLK is
>>>> clocked. According to the data-sheet, the DIN can also be used for
>>>> daisy-chaining multiple ADCs. Furthermore, DOUT can be used also for a
>>>> 'data-ready' -IRQ. These modes aren't supported by this driver.
>>>>
>>>> Support reading ADC scale and data from the BD79105 using SPI, when DIN
>>>> is used as a chip-select.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> ---
>>>> Revision history:
>>>>    v1 => v2:
>>>>    - Fix the conversion delay for the BD79105
>>>>    - Drop unnecessary GPIO check from the convstart disable
>>>>    - Drop unintended whitespace change
>>>>    - Fix spelling
>>>> ---
>>>

...

>>
>> ...I see two other options. One is adding the check in probe as you suggest.
> 
> I do think this is the right approach. We should make sure no one tries
> to probe this device without any gpio because it will be pretty much
> useless so better to fail probe in the first place.

I Agree.

> I'm also not sure
> it's that complicated. Maybe just a chip_info flag like
> 'convgpio_mandatory' (likelly a bad name) and act accordingly when
> checking the return value.

Just sent v3 couple of minutes ago, and this was exactly what I did. 
(although with another name for the flag).

Thanks! :)

Yours,
	-- Matti

