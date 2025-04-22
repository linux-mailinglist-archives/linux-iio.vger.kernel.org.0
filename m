Return-Path: <linux-iio+bounces-18544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC427A97A82
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F803A4EF3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012DF280A5F;
	Tue, 22 Apr 2025 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M0Ty1pmh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110225D202
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745361177; cv=none; b=oFNqRo30aDcCCFsoWwg55MeoYuWqC579ipkXUBL7HyV8etw7rod0TO/kGf+BdTXZ3Mdebx++lF8D65qP693//eS334Eq5OxCJ2gRvIEFR1PcVz/JyXoKpqKIlB/SJBe+IDIh4RipqlOuahyx5uCeMV94Jf2/c3+sRA25TxfhlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745361177; c=relaxed/simple;
	bh=aCS2cK9NMLOgdPJc2YMJuBdkvSB+hznw6VZLrT4/yrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APU+EvMBT9mZunfqR0qL/xFtQ9zi0jrNYu2nZyP8LlONHPfm9cnLKW5mq2z7P90fNAD5keGvFRrCTvVBEV3doq06XsDZjQXeRjG+qlhGZNNc8z1PuYosTsTcu0H+CSy1MxPe3Pr5f2u857K8gt89V67u94gMgh9Lmb9EAn+N7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M0Ty1pmh; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f9832f798aso3996241b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745361174; x=1745965974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0enfuZN8PYOZ9kUVWVSTuEglj88WTzbGk4XLCM/1V/4=;
        b=M0Ty1pmhGgdurJfIRT4zGoaHK6YWNX4hfZH2DMElQwDpQt3NXuf5sTFHuFtktObCI7
         hlKqk1YIbIL7Hl0k7tBiUeKdEK3VwRAxeQ4Q9xO1xJz5SCJ/ClZflqsdmJOZTB0L93rF
         vegoXvsWvgMA/APQzB72HEKlGpsE0KIobRbibwI+monu0ZDNesieNw4rA4Z9w3JOehuL
         xHRhS4maY4yCOomIm6q4QhfwHlKlOB+PyT+5WnTU7VX5etTtCtvtZSbYxL2CLiT9Hfrs
         SI8pRHuhdlef+Lp+VbHUpLF7EcC/Utzp3NntfZiEG0hk8dvqkvVs5ob10w/IXQKldwq9
         LI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745361174; x=1745965974;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0enfuZN8PYOZ9kUVWVSTuEglj88WTzbGk4XLCM/1V/4=;
        b=H/wS2DdMp3UeNEsTCzuYD2VdM2zWhUNYD9JvFsTSbsPdgumHC1COJ2AnFaS7c86CTT
         to3UY8UX4Lm2zSOx+NtCj3C97w9s4Sm3HndC1bO+bX2Ho2dNZ39OAhu6twZcNAVyWW0M
         /VMjTGk7SzvZ46TA2MtfNadiQZ6duxtUCZriG8OmqPy3lIszszDXNfVc/GwkhTEIbRJ+
         bxxLC/5sGGfDYlaqcNdT6PKHtc26hVYS02XgJPipT1WihKB2n3mu9G0bT6pga51NVBDQ
         TfUZeokRs1Uz7K82tLak4Hh06syvJCYvANYs479NLMtCkFS7CyCjQFR0xYOAnhup5XDE
         m41A==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9KZu4jQPwsoMSCnYCTvIDrMcyvXtwscS0XvnyZl1qz3eDFKPj8xkVkwwbcbXu8Lz0WiWpCsviEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+7JyIZPETr8tmg6hiG1+cA/yq17o7aOv3JGgkpsMnSiC2o0l
	rMmquowCNVLQBUncU91B6HnxDxvFn2KiKT5sU6OIaTo17+pxlqTOi6+SYX3fABg=
X-Gm-Gg: ASbGnct4d+AjWr/Q3JLZd1dLsCvIstskjA+GnJYqIfPfgw8DKllGTxUAikq4XI3DtWD
	5bFVpSwmyy8H4SfPOl5GCqgmFtiu5Mcla/zWdgbKnxmJaSb5nbJ7rufOwUpEgGD2kIRYcuotuGU
	WXDB898vCalxow4q5SSnsE6aqkTdGAxpMXz3MRmJPM6P2m2pbgorhtZpgyKadDfVk5WyXjmkWsO
	WQp0ueQ1JvyBQryJB5qWWJNgtg6JqLJbVlnSEDwCjC75t9XajcNXCnHBnZY6sgBwyRv2Qiaq4g3
	BFRc5U3v/pY3kotVhUHtI8/IrMGsYrX+1tzJCyk0Jkg4NI793q4zrfDF/tz/WmJv7tGf2W2U2YM
	xXLP3CZ9A90VGPB/+kA==
X-Google-Smtp-Source: AGHT+IHvVrklhnSlyJTxpErpE/n72OpKh62nNWyp8cMVFUzxtrhvNrhnh0eu4ElUTBXm+gMfXgTvuw==
X-Received: by 2002:a05:6808:4c07:b0:3f7:ff67:1d9a with SMTP id 5614622812f47-401c0c8bd38mr7958485b6e.36.1745361174563;
        Tue, 22 Apr 2025 15:32:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3? ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeaf3f4sm2331375b6e.6.2025.04.22.15.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 15:32:53 -0700 (PDT)
Message-ID: <22e934cd-117f-40fb-a788-edcfc0f8b0ba@baylibre.com>
Date: Tue, 22 Apr 2025 17:32:51 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: bmp280: drop sensor_data array
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250422-iio-pressure-bmp280-rework-push-to-buffers-v1-1-ee722f29aeca@baylibre.com>
 <CAHp75Ve_C6BXo75xy4+xZ5b1O9-TT5TGGQDgTR_F1s3TFK3p6Q@mail.gmail.com>
 <12dac98d-3e6b-4c2b-8ac0-d526bdb5efd4@baylibre.com>
 <CAHp75VcHMTSGRrodixsLDS-xCi8KQJ0MtMSMi7tfATUgd3E5uA@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAHp75VcHMTSGRrodixsLDS-xCi8KQJ0MtMSMi7tfATUgd3E5uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/22/25 5:19 PM, Andy Shevchenko wrote:
> On Wed, Apr 23, 2025 at 12:22 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 4/22/25 3:57 PM, Andy Shevchenko wrote:
>>> On Tue, Apr 22, 2025 at 10:28 PM David Lechner <dlechner@baylibre.com> wrote:
>>>>
>>>> Drop the sensor_data array from struct bmp280_data and replace it using
>>>> local structs in each interrupt handler.
>>>>
>>>> The sensor_data array in struct bmp280_data is not used to share data
>>>> between functions and isn't used for DMA, so there isn't really a need
>>>> to have it in the struct. Instead, we can use the struct pattern for
>>>> scan data in each interrupt handler. This has the advantage of allowing
>>>> us to see the actual layout of each scan buffer for each different type
>>>> of supported sensor. It also avoid juggling values between local
>>>
>>> of the supported
>>
>> I think what I wrote is correct grammar. Same as if I would have written
>> "each type of sensor". I would not write "each type of the sensor".
> 
> Ah, I meant the plural: of the supported sensors. Otherwise are you
> talking only about one sensor?
> 
"each type of the sensors" doesn't sound right to me either.

I am talking about more than one type, not more than one sensor. Sensor just
describes what types I am talking about.

So perhaps we could just avoid it with "each different sensor type".

