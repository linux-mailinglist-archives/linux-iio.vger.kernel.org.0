Return-Path: <linux-iio+bounces-8418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BBE94EE7F
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 15:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5621C2112D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9461017C7C2;
	Mon, 12 Aug 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uccGAWSQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9917C211
	for <linux-iio@vger.kernel.org>; Mon, 12 Aug 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470111; cv=none; b=p0GTlsxsWo8t9IvXaP3Czdp/hyKKUZe2SAFidgezjMcPMc8OJMDbd1VXFlF0QT9ixxAJ/dI/3BNvWByjFpEBBXvr43CFPLjJEnv/cify+O3W0HXHKo18Aalu1QE5lBT4uqctWRnIAocZ43JCSQdQtm79yZUOaJuCcbQsVMbnXmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470111; c=relaxed/simple;
	bh=PEyKKukDad7GSVDb0CG3ZU0fM7J0jKqyxUBcbGgzGX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aev0v3uBT9M1uyn6f3cbTpenof1SblbV6FyWxWt2xdAfkv/h4bb/wogAxg28/XGhZEswT5ghPefzRB7F8IcRhEvU20b/QhFr3183UuxQBWRzCAJ7wEiFjS8Npi//pczhQey0AQ0U4ZEG6StsBuubjwxEf73U4Eg9tEVm3u1JEjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uccGAWSQ; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-825a23c5e4cso887730241.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Aug 2024 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723470108; x=1724074908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZdPiM3eHhS0gXqA59iljos4r3z2B3CpNxMTL6TtBWM=;
        b=uccGAWSQ5ek9ShKj1pa75/hA7CBc0MhDjGaF6Jx9vTEhEQUDHxNCuOHni/XFi+3asI
         Y2Pma2fxk6NqejJushapyYUfxzP3owAOHHMC/nvuShxbslofMqdSEOaJEp3o/BgOBItz
         ZCNnqo7WzaXgfw21j2M27S1ZxLq8zmJx9ImXjxtK5g89aVLLXVzn45MQUeJLuk4V6WNk
         xNQ800OHV9c83J5YDd1uau7RMWduheEwBymqWG/vGzF8sN4fcuVovMNzWCpfgSHNkQTq
         8WqAjMGsdq18i35Nj2gHCMUGP/4V/RLNaSoPTVXAPsHi33EZFxwsh8ymXS96N/rtJwcz
         p64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723470108; x=1724074908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZdPiM3eHhS0gXqA59iljos4r3z2B3CpNxMTL6TtBWM=;
        b=qxGR+h/m0u+np3ADstTS+lq3XPeO7GEvx10WLUQOzF+bYi9VlY/WVx35GkK+yOMmB5
         gpFSRo7O6D/9MyxT268aHt/I5qA97vSRTR7JDsL8Te/LMsSmN8u8r3of9hX0OSQeVIXI
         tx3Q5/kWOee3Oxv9DeEIELz7eTNJO5DP4t/E32lZCVe75uIrye371/mJhcfdqO9aFpzG
         B8l5X2SWj+0vyYPsKUogk64NbH4saCbdQ5BtEz7UWxCk/XLFo4zIjxcEvtJF6LKaW+MA
         CgTDmxGCY1D5JsjZ3n/Xb9XqHOqBf7hTaynDRQwSCPmWMy9sMORNVcluhuRa/0dXq9MT
         wWWg==
X-Gm-Message-State: AOJu0YzVJ5QIa7JvgMTZSQLa9C0S47KXqjMD8Yx2/Cr4jhj7S7z2ma6w
	mkdr0VayPfvrZwnZ+X9IeXYx2+KQr6CkYL2kLCX/TFPf0VXL+CKsqxXwPGPlFCs=
X-Google-Smtp-Source: AGHT+IEsceJsLwcbe8ZaO6k0uxbmVJqWTyQSzd6+oN/GAqxRjkMASZhkewn/y1mFB5Us3W4ra8JFTg==
X-Received: by 2002:a05:6102:3587:b0:493:e582:70ce with SMTP id ada2fe7eead31-49743a4d67emr546286137.10.1723470108426;
        Mon, 12 Aug 2024 06:41:48 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d65006sm246372685a.1.2024.08.12.06.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 06:41:48 -0700 (PDT)
Message-ID: <f8a7754e-0f6b-4802-985b-d8817892ecbb@baylibre.com>
Date: Mon, 12 Aug 2024 09:41:46 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Lechner <dlechner@baylibre.com>,
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240809-ad7625_r1-v2-0-f85e7ac83150@baylibre.com>
 <20240809-ad7625_r1-v2-1-f85e7ac83150@baylibre.com>
 <03eca85c-50d7-4ff0-a5b6-83e3322cb04d@kernel.org>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <03eca85c-50d7-4ff0-a5b6-83e3322cb04d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-08-10 8:10 a.m., Krzysztof Kozlowski wrote:
> On 09/08/2024 20:41, Trevor Gamblin wrote:
>> Add a binding specification for the Analog Devices Inc. AD7625,
>> AD7626, AD7960, and AD7961 ADCs.
>>
> Thank you for your patch. There is something to discuss/improve.
>
>> +allOf:
>> +  - if:
>> +      required:
>> +        - ref-supply
>> +    then:
>> +      # refin-supply is not needed if ref-supply is given
> Not needed or not allowed? Schema says the latter.
Yes, this is poor wording on my part. I will fix it to say "not allowed".
>
>> +      properties:
>> +        refin-supply: false
>> +  - if:
>> +      required:
>> +        - refin-supply
>> +    then:
>> +      # ref-supply is not needed if refin-supply is given
>> +      properties:
>> +        ref-supply: false
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - adi,ad7625
>> +              - adi,ad7626
>> +    then:
>> +      properties:
>> +        en2-gpios: false
>> +        en3-gpios: false
>> +        adi,en2-always-on: false
>> +        adi,en3-always-on: false
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - adi,ad7960
>> +              - adi,ad7961
>> +    then:
>> +      # ad796x parts must have one of the two supplies
>> +      oneOf:
>> +        - required: [ref-supply]
>> +        - required: [refin-supply]
> That's duplicating first and second if. And all three - comment, first
> if:then: and this one here is kind of contradictory so I don't know what
> you want to achieve.

It sounds like there's a better way for me to specify this, but I'm not 
exactly sure how.

The AD762x parts can operate without external references, so the intent 
was that neither REF nor REFIN was required in the bindings, but if one 
is given then the other can't be.

For the AD796x parts, one of REF or REFIN must be provided, but not 
both. If REFIN is provided, then REF doesn't need an input because a 
reference voltage is generated on REF. If REF is provided, then REFIN is 
tied to ground.

Maybe there's a simpler way for me to specify the whole block?

>
>
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    adc {
>> +        compatible = "adi,ad7625";
>> +        vdd1-supply = <&supply_5V>;
>> +        vdd2-supply = <&supply_2_5V>;
>> +        vio-supply = <&supply_2_5V>;
>> +        io-backends = <&axi_adc>;
>> +        clocks = <&ref_clk>;
>> +        pwms = <&axi_pwm_gen 0 0>, <&axi_pwm_gen 1 0>;
>> +        pwm-names = "cnv", "clk_gate";
> Make example complete - en0 or en1 GPIOs or whatever else is applicable.
Will do, thank you.
>
>
> Best regards,
> Krzysztof
>

