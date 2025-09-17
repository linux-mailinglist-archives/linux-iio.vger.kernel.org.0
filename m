Return-Path: <linux-iio+bounces-24210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3CBB7F35E
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 15:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF2C1889DA2
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B419328978;
	Wed, 17 Sep 2025 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JQOJBz4r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325A33C765
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114903; cv=none; b=SEX+VM37FocFwlihWhIQuzulTbkdBel9Lpb31IqISJuGb79+6tKDIbe9n570bz22ps9TiMyjk6v/E/Uwh11KngJqqcgxv/TyT02b4Fsm19YsleHWfYtD6XFdWzzWtCmz9jzP/DoveIsWfXsvEuecs3DMcqlqoMpFkMEru7/wr40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114903; c=relaxed/simple;
	bh=4VrqzSHnqfIZFSJUMKobQty8aJAljwwTZqC9uLs6RM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ao4WenrREDUj3AafUREBv0RlByCSyk33dqneXtB2kyct4U0xX6lWN9fadmLncUl99jGO34PuYyCDl1NYozydeT40S043gwVPUoJHrRbIQ2qYEHPx8FfnnHfaCgJhIsiK3ClqW2j6TnvG3hSKbpvciSHdMe2F3WDXR9VZ5HdiKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JQOJBz4r; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-62355a687e6so1828281eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 06:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758114900; x=1758719700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Y1CBE/f5s1brH0aS8WGhaIOsO3+43juyj2g7QT7y6s=;
        b=JQOJBz4rSywAXLvP3gYe2BXe22vl0vMlGbw4V35IeUwrXulDPMpFnpenBCdCFDcR4v
         CTXT74sSv17Zb9XB9jSdWwpZCiFed5jYWPQ3Xvn4GeK0wT/Ib8UJuLtsB0DGLVszUyIy
         j2nVhZRbeDF+Zpvgdm8XLac21/Z6BqmeH5UzmM0dJbaMB+9SxXs6bUoh2gUeDNeS8JVW
         b1xVt+V2gxyiIQ5qjtwnMA4vlOudJ/ScTwJiUrOh7/E4CYbIgXkiw0zzOLGKwIOZXoJw
         y8MOCcEA+Zb3Ss6S8wTATnB/s5OgfR8I5XbsHkXLKD7bRBTTFk/v9FaXEvegUNNrQjW6
         EBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114900; x=1758719700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Y1CBE/f5s1brH0aS8WGhaIOsO3+43juyj2g7QT7y6s=;
        b=km5dvp3bmK7PeWfOj4zy7cljwdEMRe4RQiCEL7T1EQL4FbIRZHtARe2ULIOosJ1vny
         pijf3I9G6VgxzVDiWJoqKTHQ+CRls+gdb4MFpVWXXFg11BXrWlnH8S5HDeVQrl6iLik2
         9c8rco2L1gFVP138/EnkxaB41jGBk6j9bFGhBL6qZgSncZ5UWheqRBmL807bEDrEsKSd
         EW5xKz50Pv0FL8sPecg0Rn9BFZ+pbCnTIENNWdnpI4PIEpN/R16s7L9yrfU5fAPOspHt
         34EyxPDKiawofIvPNA8Ggr3wNEmr2LY1EomacIiOmRHvhdulHPgCgbGleuUluGzXxCza
         u+FA==
X-Forwarded-Encrypted: i=1; AJvYcCVvUMdIo7xX/LMtw00CcJyr64ZQXm5GHjNIY//cLBbcHW4rIJLyObTQ66QThUbpcxYj2cAGhVEbIjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8pjlS9gWwHUSwn/hQGDzupXm7qmYQQG3UFte+8jXtciK7mNva
	OmeIdn5Wzc9iPKwuHKODspy3xfn1Pe6FRXUpL51DHrJxQgzTaTLe4ui947CXGvogvZo=
X-Gm-Gg: ASbGnct4JzZcVCJ0WYat/qwhM+oGZPOBAepgXJlhmfMxcZ1GeEqaFvbU65BeMdn2dbC
	wWAKs/Qe+FzKgSgrVOe+mcDZFOvZ1CBWuLSA3mLEKbhHvzeiZ4qGaoLGnwBvEXjc2ATZnEZ5G+W
	ubXsJSy01PITruKQjIVjBpYF1lT4mZ1YjJuflPSEyRy1CQ0Y1lxXpMiZcuAaSxrskwqP4HKPnqK
	FEtC5KbU0wu/dxRAGwjACzytB+GigQy5Efnx9PWSS4LhBLAn3bOe7kEeMoB7hFvrLzI3jJx6TB4
	hTSbRLRUIoXQRNh8JQA0HYI8bW3CaALZhDdfTYHYe067Q0M9VvAq7XDWPPbqU+q/diBJm5ecUw2
	AkxdEF14DBlFqUX3Xe7NqQHBBvTz2vhLM4waJH08ix/+L+/7HY5E5DkMsrw/R+/Vt7Y5+5hGA
X-Google-Smtp-Source: AGHT+IFhTUt0P3767NPnyQxfn6fx/Ob88p+3+zA2O3pkXJeilzkFlrMeGbkz3MTLc15Ux1O1i1hzXA==
X-Received: by 2002:a05:6808:18a7:b0:438:4117:a863 with SMTP id 5614622812f47-43d50d49258mr767802b6e.39.1758114899762;
        Wed, 17 Sep 2025 06:14:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:72c:cb37:521d:46e2? ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82a72a53sm4260182b6e.16.2025.09.17.06.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:14:59 -0700 (PDT)
Message-ID: <e8734476-2b47-4031-92fe-98b325629408@baylibre.com>
Date: Wed, 17 Sep 2025 08:14:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] iio: adc: max14001: New driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <c257f7feb92dcf33bf7a55810fe69d13890374d5.1757971454.git.marilene.agarcia@gmail.com>
 <2d5ef36b-ae37-453d-a19b-76fc97b7f14f@baylibre.com>
 <aMptAUsQaUIYpVNG@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aMptAUsQaUIYpVNG@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 3:10 AM, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 01:04:41PM -0500, David Lechner wrote:
>> On 9/15/25 5:16 PM, Marilene Andrade Garcia wrote:
> 

...

>>> +	if (ret < 0)
>>> +		ret = 1250000;
>>> +	else
>>> +		ext_vrefin = 1;
>>> +	st->vref_mV = ret / (MICRO / MILLI);
>>
>> Just a style choice here, but in other drivers with similar handling
>> we wrote it like this to avoid the extra if statement:
> 
> I didn't get this. You move from clear if to not-so-clear ternary. How is
> the proposed code better?

I can't say one is better than the other. What I suggested is just
how we've done it other similar other drivers.

> 
>> 	if (ret < 0 && ret != -ENODEV)
>> 		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");
>>
>> 	ext_vrefin = ret != -ENODEV;
>> 	st->vref_mV = ext_vrefin ? ret / 1000 : 1250;
>>
>> Keeping (MICRO / MILLI) instead of 1000 is fine too. There are varying opinions
>> on this.
> 
>> Or we could drop ext_vrefin and have:
> 
> It goes back and force. Can we keep the code as it's in this version?

Sure. Existing code is good enough for me. (And in that case, I
agree that renaming to `use_ext_vrefin` is an improvement.)

> 
>> 	if (ret < 0 && ret != -ENODEV)
>> 		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");
>>
>> 	if (ret != -ENODEV) {
>> 		st->vref_mV = ret / 1000;
>>
>> 		/* regmap set bits goes here. */
>> 		... 
>> 	} else {
>> 		st->vref_mV = 1250;
>> 	}
> 

