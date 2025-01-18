Return-Path: <linux-iio+bounces-14466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FACEA15E38
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 18:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CE63A6920
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1187D19D89E;
	Sat, 18 Jan 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IoANaibD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E3B187561
	for <linux-iio@vger.kernel.org>; Sat, 18 Jan 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737219813; cv=none; b=Jdb8F+dm5+HFEBPSkpdaw3pDmGc72g2xeLbTWoToQQ0Ql6DsY3FP6QjA0dnP2BO6HamNpYfRpJWcj6OtUOj9JuJ5KkJW6gP2GcHO3dTOW1X/pbl3M+JsJwBt7nS0Imwmeh6tygfZT/e2ydHVfMQ2PZTX3wgCMJyDsbfkcjqHrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737219813; c=relaxed/simple;
	bh=DcBlJ+yHGq37mW8GwdQGML28nY73k807Xz5nemwgYNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XV8ign6Z/5ojXtUCqpsirYfvSnSrDwQbjX8QUAND4wu2ZeLKEjDZ4S8VfMgbnAf3np8OtUInWqRwBZRGY4runeo/Ihcuhc3nKeufaHClIR96vJuylJ21MGl8QmYqnIlB1/dl4B/w7Ga9OzfR5EVswRQGJMD09fZkaEhMNfLudoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IoANaibD; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2adc2b6837eso990353fac.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jan 2025 09:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737219810; x=1737824610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1ANIyCbRWk79i6OyQ23QiGmTlB5taHEKJBo3hTbDHA=;
        b=IoANaibDouGlkSzMtvMONUGT/wVftir9F6ZpWzgzfWiMUzODOZsxq304qY7J6ZpRUt
         wBeJxkZQ+orpOzlMbsk13TUqhWE/8wIcHE9XJ0t66xY4oG/EH+2pNhUu7v4Hf627IHaE
         jTBJYf1LH905FxtQRwbDjF2d4MIpBGYuieUalq/tukwvjQ61JHhkuCygudvLwW4zJ5fR
         1PhSGiR48hi9K73v5wLgIZXePlmKGhfhvIhxxE0L+cdxqlXky855jPAQSX2A97iAR33l
         anRBkqHAnRg4SXE/olPK83vE0MBG22u4aumGbVcSviqZiaaRlBY7jWgA08ef6W9OdjGR
         fibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737219810; x=1737824610;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1ANIyCbRWk79i6OyQ23QiGmTlB5taHEKJBo3hTbDHA=;
        b=eUlrz8lco6J5ScYfrabSxoMN3Yan4sRcXVQ3A1SQ1Yxa9ip+5tXRBiJj6eFcYmf7dd
         ncinsraWI6UQlOgMiJRfN/JolQyaRI6xkogbtN+ssjihHLdT121RhJEu6ZxxWLsbnJfu
         8gNstnF7vB9HqmvCi9HrH7txpO1WEjZGlUxcr1oSlJiTLnck7II1oocJ/Ub0pP68JL6x
         FcbYEtJ6RatuhmDQLzw0nSTkWjLHPwSa0N1qg9NHFnRZQc0kYYKsm5CHeFrm6LhC5vy0
         4onZBAiaBAaq+v3RdwzsAzMM1Y6ymSPYFgSziaxpyUYnL2AqmfJY1GelHn5DI4jCgX8J
         Q9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUapnJokZbgSCReLBtsir6ELh51vBrWQqi9EyECyzMtwZfGaaXGIHHdHtNRNGebyku4SBBh4PeG59I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/n8jk5foQ258rI5RyVC7erhLcXaXeyBweMEnTDqT7992j9Be
	sG1lnQNaY09t3OO0Q/+4WCaJwW4gdXL/3GCu3FcSeODWMmk1cRi1Oqr+G/o5kyk=
X-Gm-Gg: ASbGncufbMIwT8NWzaxGHUKx4zrK5ChcLdlwQTKiicWEBrt5K89j6LcOxnBtxhPEKAc
	0bUDmctwoxcuWY1MP94N7x6T6ztsDGf1nSug2DlUqR4lWQOFEodGmTxkctR/Lo8MDej5ble01/Q
	CialB9fkzYxfJOjgkmGyK8uNCHKX+OarMQVdRMUdQKnjKq/nE/wdHFHeGujsAmFLzeSP7A8/ZKn
	wbSdyMfc4lujRUnXCD0JVJQaReA7bGpIo+9qktL4LbDpw2/jRqf99DDjPR/JHLIjqA1+DBH1zdY
	V/qaMcDTzwrZofYHNuR0oKdolGMeUAk=
X-Google-Smtp-Source: AGHT+IGaxsOFeQL9meWsDIzBtZAyWdpP3IMY/ltknxeZCB2vVovGDUMpfKmDrAXuoUZNZxN13+A8gw==
X-Received: by 2002:a05:6870:718d:b0:29e:5e54:76d9 with SMTP id 586e51a60fabf-2b1c0a26ba4mr3995063fac.11.1737219810074;
        Sat, 18 Jan 2025 09:03:30 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b1b90d0acdsm1857763fac.50.2025.01.18.09.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 09:03:28 -0800 (PST)
Message-ID: <f3c1f7d2-3cc7-43b0-a166-e2053b2dabfa@baylibre.com>
Date: Sat, 18 Jan 2025 11:03:26 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Documentation: iio: Add ADC documentation
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <efa1dba23c38b207716883d6226ce9e9df5a51b8.1736862045.git.marcelo.schmitt@analog.com>
 <3bd58574-36c6-4102-ad7d-1aeff0e46a95@baylibre.com>
 <20250118155153.2574dbe5@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250118155153.2574dbe5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/18/25 9:51 AM, Jonathan Cameron wrote:
> On Wed, 15 Jan 2025 11:23:24 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 1/14/25 7:53 AM, Marcelo Schmitt wrote:

...

>>> +1.2.2 Differential Unipolar Channels
>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> +
>>> +For **differential unipolar** channels, the analog voltage at the positive input
>>> +must also be higher than the voltage at the negative input. Thus, the actual
>>> +input range allowed to a differential unipolar channel is IN- to +VREF. Because
>>> +IN+ is allowed to swing with the measured analog signal and the input setup must
>>> +guarantee IN+ will not go below IN- (nor IN- will raise above IN+), most
>>> +differential unipolar channel setups have IN- fixed to a known voltage that does
>>> +not fall within the voltage range expected for the measured signal. This leads
>>> +to a setup that is equivalent to a pseudo-differential channel. Thus,
>>> +differential unipolar channels are actually pseudo-differential unipolar
>>> +channels.  
>>
>> I don't think this is equivalent to pseudo-differential unipolar. That one has
>> a common mode voltage supply on the negative input. This one has a full range
>> signal on the negative input. This is the diagram I was expecting here.
>>
>> ::
>>
>>   -------- VREF -------
>>     ´ `       ´ `               +-------------------+
>>   /     \   /     \   /        /                    |
>>          `-´       `-´    --- <  IN+                |
>>   ------ GND (0V) -----        |                    |
>>                                |            ADC     |
>>   -------- VREF -------        |                    |
>>         ´ `       ´ `     --- <  IN-                |
>>   \   /     \   /     \        \       VREF         |
>>    `-´       `-´                +-------------------+
>>   ------ GND (0V) -----                  ^        
>>                                          |       
>>                                   External VREF
> 
> If it's unipolar, output must be positive which isn't true here.
> Do we actually see differential unipolar except for the pseudo case with
> common mode voltage?   Seems like a weird device.

OK, it sounds like you and Marcelo are considering bipolar to mean that the
difference is bipolar rather than the inputs. In that case, it doesn't seem like
there would ever be such a thing as unipolar (true) differential.

I was looking at this from the point of view of only the inputs and not the
difference. I'm seeing that the input voltage can only be positive, so to me
that would be unipolar.

So at the very beginning, when we first mention unipolar and bipolar, it would
be helpful to add a bit making it clear exactly which point in the system we
are talking about, the input or the output.






