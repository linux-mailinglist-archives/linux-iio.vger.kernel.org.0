Return-Path: <linux-iio+bounces-23389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE181B3C1A5
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 19:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6B77A4648
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449AF33CEAC;
	Fri, 29 Aug 2025 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gEbI0DPY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55017334707
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487950; cv=none; b=Y70EVFJvPo0/+XjRQ58jlsWHRkdqd3MRMQy8OR+Xp8ZbZU8m5u4cLNxKEUstoOw2rqGPcOHWRpo8yAdRis9waTNV14cAQKTnHjfwoqQb4WSfifYXTMGgCczjx2y/nm2hbLib4NgMZ9ZrOGlNa2m7c4j7KIHB82hLgUfEpkqqRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487950; c=relaxed/simple;
	bh=TM3V3RRshJMWcoLLBm8hx/lAB1LvFN80zVkpuzPG9DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtdAbV3ut1tNZJv6EWGy3IUsiceRnvQZggSLzIS4IEDYAJ2y0qq2eGy1XkVV/nyi4dUrN17Smxu6O0nMjCkC8aSUjrbAPUftdeytLt3cvBnwAtI4Sd82JfBvk2/3BKh3GlujRKjHC4THGJV7gtnttbiE4xjyFweW0uQ771T1RXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gEbI0DPY; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cceb3be82so2196280fac.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 10:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756487947; x=1757092747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEP4vbK6aLFhZ+UZYsQsobsaIoV/mTQ+kv24X35w/xY=;
        b=gEbI0DPYHDC+Z6iMxXPecWF56LwuCVaiZGRGThT3nkCEWP8dZNx/hEXW5JiJESs9Cm
         dTbMAu3PANwSvK/e6xMPOq5XMcNSWDDA72NsysrAJqZG3U63ggmNae8akLa4kxYxeBQo
         46GUPEuC4JoWm0VvIiwZrciEXCzhRSQdhvzi+opOEg6N37xl6yQNxSDQ4OtIena2QNDE
         YnZBUitkC5Mk0f0R358LUWw5HlS/SsPaGeani1jHWVRGz2fkWux3jh5ST8pmStwFB/Yc
         pNajjnYGyMLKgaXg+0+3Q3SLoaMvsXuDVkUp1hfzKhp7f8ElhxixFsSiZu8Q4nWvkG2J
         ADVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756487947; x=1757092747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEP4vbK6aLFhZ+UZYsQsobsaIoV/mTQ+kv24X35w/xY=;
        b=eDU2UuOpu/m8XuQDu5Bo2Kdo+86sGIOIPac52OJmMLAM4NLDhrq0LYPsp796qmfAw+
         YArq/lZTR0oRPjnrma19hFKj0D1CvVYn9GJUtTyTcrk2+TO7xq2+w3diqInaDvATAB/h
         Y8PtHfYK7nY4RcFNOphJiW736VoGITpyVDQwQY1yrZHDVNJAB2Woi0ahNyzLBgkArQuQ
         2iOcmHLx4qNpu+v9A4Jnz2ho5im2xmnArVU3oH7pVQTrSPptVojHFO2xoF6dgAEFUX7E
         TkILxGfmWqCdDDIbrsu4EvkUQnRGy+52zuJ73CXwb3/485Z5M7GaHfwuBa2HusvS/pxS
         yGvg==
X-Forwarded-Encrypted: i=1; AJvYcCXauqTd+nUJRuJUDjQ3CahHi5/3gi3WMXCnrYWIAlaryX4cw2EYev68Wx1otOukLGB0f2AAjC0CDWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLEZ76XWYPGXIzCvnHTRmIYrs67MymCX1KLtSNgyFVqadZ2tKV
	xegcHf8SZ8DLaev3++HTq+RHodLc2HiHH6Ap4UIyJv8g+xfCg0UoKmQucAQkE0sH+Iw=
X-Gm-Gg: ASbGncuFRFNwFSGavYh7FVz5fpRYcB3LG8WdndYNWEo2V2WRHDa+PUI4C0QlBwaKwlM
	6ypD4XVKKBABubenJzdhtjd/l3UmbDO7KTI9pv0D4v7vEbnKuLs5494ycwM9hKxhrSRQqLO81uS
	MPn5LxJc+w/oUUjr+kGnfnZJiNXvm0qQ9Nbf5IPhQInnEwpKuICtnqXj1KtUUS7SOnKpiih3KDq
	9FkQhtgoUh5D1IinJbURvByWDwPrIcb9rNVHCZEvB3SASM382NjEX/Pb2KK51EVpBrlxlTI9ZDV
	TEdIex5zlff6sCxVMetdFkQI9ZoSM7O7F9YfQZECTz/VJCveuoc+1TqOg3Klfr9kXEEi0gSNHTX
	v+EZvp1TJbrIfGozQLDHlApn/PZqEuU53/dWRQA+vzUQBfPnT6AfB8LcS4XU0lyMuM/GwHXSypH
	OyG6uqFeXyJA==
X-Google-Smtp-Source: AGHT+IEDNwg5Ezv4Jrx9SDKm9RyylhoO8ne6U5dbzIqaQlFIzpaEo8k5fSGVlra8caUiERGlR0wePw==
X-Received: by 2002:a05:6871:5206:b0:315:91a3:2fb7 with SMTP id 586e51a60fabf-31591a34baamr4845495fac.35.1756487947326;
        Fri, 29 Aug 2025 10:19:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afe1937asm1472582fac.21.2025.08.29.10.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:19:06 -0700 (PDT)
Message-ID: <a20356ca-05ca-4c99-819b-4b278e799f2a@baylibre.com>
Date: Fri, 29 Aug 2025 12:19:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iio: adc: ad7124: add external clock support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250828-iio-adc-ad7124-proper-clock-support-v3-0-0b317b4605e5@baylibre.com>
 <20250828-iio-adc-ad7124-proper-clock-support-v3-3-0b317b4605e5@baylibre.com>
 <CAHp75VdtQ8vKULomgqPxwX=WZWUde7PC129BEznYqefd-U4DEQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VdtQ8vKULomgqPxwX=WZWUde7PC129BEznYqefd-U4DEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/29/25 10:53 AM, Andy Shevchenko wrote:
> On Fri, Aug 29, 2025 at 12:55 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Add support for an external clock source to the AD7124 ADC driver.
>>
>> Previously, the driver only supported using the internal clock and had
>> bad devicetree bindings that used a fake clock to essentially select
>> the power mode. This is preserved for backwards compatibility.
>>
>> If the clock is not named "mclk", then we know that the devicetree is
>> using the correct bindings and we can configure the chip to use an
>> external clock source rather than internal.
>>
>> Also drop a redundant comment when configuring the register fields
>> instead of adding more.
> 
> ...
> 
>> +                       if (clk_hz > MEGA) {
> 
> I read your answer, but maybe I missed something?  Can we use (1 *
> HZ_PER_MHZ) here?

I suppose we can. But it doesn't add any additional information.
We already know we are dealing with Hz because of clk_hz and 1
is implicit. So it is just a matter of style preference. Since I
read a lot of code, I tend to prefer the minimal approach - it is
less to read and still has the same meaning.

> 
>> +                               clk_sel = AD7124_ADC_CONTROL_CLK_SEL_EXT_DIV4;
>> +                               st->clk_hz = clk_hz / 4;
>> +                       } else {
>> +                               clk_sel = AD7124_ADC_CONTROL_CLK_SEL_EXT;
>> +                               st->clk_hz = clk_hz;
>> +                       }
> 
> 


