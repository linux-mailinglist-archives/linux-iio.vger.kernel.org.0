Return-Path: <linux-iio+bounces-22767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32517B28180
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 16:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A43AC5909
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517F821CC5A;
	Fri, 15 Aug 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1t/HCDyr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36A219A71
	for <linux-iio@vger.kernel.org>; Fri, 15 Aug 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267455; cv=none; b=D1IERqvqAT/8mnx4silVrcSKEJHzMSCenD0NuN43Zcl+6kHloIwozdEEGyqXtXC4B5Rpm4eXRGkthg8++TzuZljj8kiDkilu7S4xQYNKWlup0U1fNxz/MGJ461NS+JXtvz47ZaPtRu8D6wGjG/xm4Z0+Env289EQodwlAj0pDMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267455; c=relaxed/simple;
	bh=6UqgWiBtru3qNF4cKm5B90nNnc9QwBe82+mGbA/cY9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnsaysvGyo2WRtAhmGFiXEPULLJW8/gumTMTIzo61toSZSsgNo6XtlraAx2QwaciMa20LHzVYbCSsTPGH7ozfney7gNSn89cman0ZB9t71zNAOor3cOGPybpdwh2JFAp8GOp3L2T7IvS6yZ8i7Kv3F+q/A+nACA++th2NC+TA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1t/HCDyr; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30cce892b7dso865605fac.1
        for <linux-iio@vger.kernel.org>; Fri, 15 Aug 2025 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755267452; x=1755872252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbhrCfk9RYJnvvsbCToqdaCZcrcBbxt81Ogo6J2bM9c=;
        b=1t/HCDyrSenuVSwVqJ99IIM+83ZU2Mr1tC3lbMlBA8sZtQpzjyS2cct46AI7rGc62d
         htmBjVDDz+eTHlwtW+njCnNka6316YsNzwpG1+xhGH/tDlOc20E/3cntcnM7l4Ve3hCt
         Wsc4AFn7+04u0qVUfwTOBlSPvgZrrj2AaEWzhmKgAWvDaas/22qMSNPeYflmQjC0eMTb
         qGNDQ0pJXz/bShNCYOHG88HlPxVJy+Zij3uG+0RAtmDnzGVo2MFzliOSbJN+CH2Xeho7
         Iq8Td9V3RkslsYrKzh8wDHy87C5J58+PKDcrom9irRF01FczCnzZgbFQUMC9WFhZdvvy
         K3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755267452; x=1755872252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbhrCfk9RYJnvvsbCToqdaCZcrcBbxt81Ogo6J2bM9c=;
        b=fYDyu1kGgx52na5Uvn6qvA6QY/c32iKvHQYx1kE4hjKvPCa81XjyUV6lLk+Odea+bD
         zioroGFbbw769fZOFAy5/L4zMNaj8R1UE8yvHsSPEPyWR2h8kl09e/4bXfxL7HQ+JckY
         y51k9JFhJtplLwpZ8FlIv5XLQ8pdXMp6bhhwL2SNYUnr5FJ6cUm+PGWvQ19Fb2w15FGu
         GrtmSjiHg7481use6XpJWGP7lncPCitXfOYBhVqlpPlNbmPDeAHHbbzAXGTERYws/dp2
         yCdtuvfIWG7sKcy9ofAGyTtb4WL6ZU4jlnTmFCWoPR7AspHf4JNO8fN0IwUEgyCUVNyg
         Greg==
X-Forwarded-Encrypted: i=1; AJvYcCVXk6Xo3IYZwPgz+6izl59ZFLVqa0n+60GyA20gOAEBUHi6aiGA4MkdL3YZDEwKOxaJDEiTo1/Dsyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHG3d4NVMLdeYqU6WZIWUJVkmmmSjejl9dwWKSZKXZ8enUhIa0
	6bhIWAydLHtrPRPANqOC84CUwe2xPhi5HBx/sh4zkSluKl4aRO+UPoh2GTrgmBpJppQ=
X-Gm-Gg: ASbGncvDpONFDvLSt1tY+EeGQUXsrhT/oVL4/m3QtvFFu3r/KNElLV3hRm4o0TECR6l
	22HGjzuSYKYY7u1u/MeU8QCkHKwywXUVH/BSWrTClRlguJgV+lo1zTT0XAPk73s5DKWboLnSvwn
	60Q88FJ1v3Z5Ggcyu5QQMDkhCM49gCjzuA6KK/SjQ66sM0Eg9X4qJnMSZgIwdzaSSN4jBzyCJLk
	NGvJwEVMoudpi1mqSTTshZpLAatiTsPuvLfGdATZV7SYNcmpmK2RECIyMb4I7c/9Kn8MjBOHbo5
	OFP3Hl990FJdzxicJgGfgMzOXIXvO0tyquWR1IRzUurQw510MTxcSCGyb8Ewlap6XWKxrPgx6t7
	L9mnRpDtv4asKDldxOM8SXhB77vu1vrgZpawAYbs2c+pvD58/Mr5OHc2e9h9KxF728EWdylx0
X-Google-Smtp-Source: AGHT+IGjqpkyyKZlM08oY9DimEhkn8JHkSQ1hja/G82yMfhvgu4bjl6P3uoYQK3prUQOBvs9hxEJIQ==
X-Received: by 2002:a05:6870:1c9:b0:300:de55:8fa7 with SMTP id 586e51a60fabf-310aaf82636mr1088519fac.37.1755267451454;
        Fri, 15 Aug 2025 07:17:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c? ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abb34f14sm419442fac.20.2025.08.15.07.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 07:17:30 -0700 (PDT)
Message-ID: <ae976e31-78db-44f7-a3d7-b6178692401e@baylibre.com>
Date: Fri, 15 Aug 2025 09:17:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: adc: adc128s052: Support ROHM BD7910[0,1,2,3]
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sukrut Bellary <sbellary@baylibre.com>,
 Lothar Rubusch <l.rubusch@gmail.com>
References: <cover.1755159847.git.mazziesaccount@gmail.com>
 <e43c184fc6aa5c768045fc772b64d812fdb06254.1755159847.git.mazziesaccount@gmail.com>
 <014487e4-f8c7-42e6-a68a-9e984002fd46@baylibre.com>
 <3024c64b-48e4-4a28-bbab-b80cdaec4a9a@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3024c64b-48e4-4a28-bbab-b80cdaec4a9a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 12:23 AM, Matti Vaittinen wrote:
> On 14/08/2025 18:01, David Lechner wrote:
>> On 8/14/25 3:35 AM, Matti Vaittinen wrote:
>>> The ROHM BD79100, BD79101, BD79102, BD79103 are very similar ADCs as the
>>> ROHM BD79104. The BD79100 has only 1 channel. BD79101 has 2 channels and
>>> the BD79102 has 4 channels. Both BD79103 and BD79104 have 4 channels,
>>> and, based on the data sheets, they seem identical from the software
>>> point-of-view.
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>

...

> static const struct iio_chan_spec simple_adc_channels1 {}
> static const struct iio_chan_spec simple_adc_channels2 {}
> static const struct iio_chan_spec simple_adc_channels4 {}
> static const struct iio_chan_spec simple_adc_channels8 {}
> 
> This which should be clear(ish) for developer no matter which of the supported IC(s) were used. But if we stick with the IC based naming, then we should use naming by supported IC.
> 
>>
Even better.

