Return-Path: <linux-iio+bounces-26436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C37C81EFF
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 18:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAE804E694E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF19E2C0296;
	Mon, 24 Nov 2025 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uGvAq5iG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7C32BCF6C
	for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764005903; cv=none; b=Hs2O6vFp29LO/uy18Z1IFks40trFF6MLeP+/aKqDpJntjwzvQNlTFjSWwE91EZDOYeyJec5biIWxMn6rf1AdBhVfV6Bt92kMkYSFqYhJBdPq5m2LcR/ilnOolF4QkacoxipmMxBA8WSuMuY/zq2OTu+UpvDdu38+xYd5r8/bShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764005903; c=relaxed/simple;
	bh=KMlWQB7AOIOzyYJhTj0B28sxJc/jSZAfZdb+tJ7XAUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LAaamv4JV/ZoG7pEU50NWjPqn1s4Z0viVJ2YZyDLlOKcaoNT7gC22aJa1QFKe7mkO62aiYg7R59mCR6CY94f5n5/wh18+i9tLkXOeM0u+K8RUttMPJ1IDojfep88nFcZqBrGRTQ/XtQoBKVOur2DXFcW8l5Crayy8ePm0owePJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uGvAq5iG; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3ebd1b07919so1061533fac.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764005900; x=1764610700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IM2QtAR8pkeEr/p0bVpusa4zLAxQY32DCc9xBmEC9fA=;
        b=uGvAq5iGwz7drb5g80IT6X3YsHeomZhRU4rYt3+l2XA5PzDXe0WDlu5aTeR6mQcuM4
         0YizjKSTZhiQNTWAf6I+tBCXT3jskJ4kpx7BgiyDB4Y37e9ObTJXnq9+z5/iZa8JriCk
         sPHrBYX2VYCKxdQTZF5Jnh/AAljcW63zEg7s1VaM8gpKkNs52Ii04vu85ahCr8qcIh2Y
         uy9dok27lG7/m8dGLc+sf+ESCTkDVlAbKUiu2owPZNNTOD1zoF2pk76heVNUDbTI3bMN
         1y6Fpm2bzYvVVcp7hWp69Adnk3/i0oeJEjpbiPqlwX0Vacv5I3M2YkSo8OpAKq4PdD4r
         nOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764005900; x=1764610700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IM2QtAR8pkeEr/p0bVpusa4zLAxQY32DCc9xBmEC9fA=;
        b=X4N/5KgX8U07hdv2g1U96A+VjUIhVTZWdH+DOjePVqR1lmDhX0/vYkzoWP68A0AjSM
         SJC/NljqVNdIL9A94eOqYfcBKWUM/FSU4JFSQ+agpiZ/Mv8puS7FqyVl/T9x9E4guJWH
         pVAxA0Lfw3lV1s36ZQ8OzgKhR1JKbtOGvaLEvsQNRtOwTJhrhsXSXjUvZrh1y/+jObA0
         FRoKrURLp5ST4BzpS71uPksV7k8G+XAs5stLVSrrGMKAvaCvPPD3fFDAVD5FUPCZwUyY
         /dwS7E/IGH0nw0qD/oy+fn5j6i2qH5X7H1BlzEx50tZOmxVdimy76prMyJe05EULOal5
         ykeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyFPtUhurRYcyHmbtHCAxaEkRZG3Ql8E3ksKyufGSBybv/wLS2iIG/VS/BBVu1kZRcAfFguF6q9aI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi6NxnSjIEQqJ3GWg1j4wtj7TTPv0iHupWvOk/i65qjTYQlVQ3
	YdRUjrAV4IqiLO6+WGi8CPE4XOYGnMzZN6NJj7Tm0vb2t1GOFE0cArdQHgjCawHyxO13CUmIcNO
	Q/YVy
X-Gm-Gg: ASbGncsexQQ7/9sm2UvmqDYLs7Wg+wo11vuFOH6rbFhkuz6tC06CSgdW3OaaKkYGtjZ
	UQMyd9egozkhf8xB9HogFHS6p0mDUXbo2x1viBl10+vogYuT2o2TUw1uU467eAlkpSYhXEYFsfI
	/bexREb3Oj84m0KvIn8yFBUFAVFWdnjgk969BZUS0o+HS5uqOEbP5wYKjp9yOBi16HorHpByJ9t
	zWZDFv11v19OSqnz5RdASHZNWy9NJwdOpYdCHXNZgPfS1loziKZdxwipSXi1um/rLgJy9rKGqxo
	PIy0R8NNQx+52jpgsGEd7hdsP30M9dzuLVuFftKQ/VJzmkrvddRzj+L20pP9fQR6HS3pQCAoNu+
	NEbcCX2Ne/T913WH9Mj2dCe2jZRFOfsuVWLiWpUIYXkkZ3DtXvi3TBWZmUB6HbG+K3lhvehLb5Q
	jofUzPUYh/UgeytahWZEMn6M0bJHE2HEB8R0BUxzF939PDXhxzVwE8yK9fjaOZ
X-Google-Smtp-Source: AGHT+IGx3mc/Rz3SDW3zPuI+4+eMrrwhqJj6Kmdxvwlw5NVA4vxWo2y830231IUxYrpJWGKOWMA9pQ==
X-Received: by 2002:a05:6808:1903:b0:450:b0b2:96ea with SMTP id 5614622812f47-4511572ee91mr4339658b6e.1.1764005900291;
        Mon, 24 Nov 2025 09:38:20 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1f0e:7ca2:8633:22cb? ([2600:8803:e7e4:500:1f0e:7ca2:8633:22cb])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782b4cc31sm3661246eaf.12.2025.11.24.09.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 09:38:18 -0800 (PST)
Message-ID: <531c2dfa-b96b-4fa2-ac45-4a5be14fafca@baylibre.com>
Date: Mon, 24 Nov 2025 11:38:17 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 0/2] iio: frequency: adf4377: add clock provider
 support
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20251121095933.19032-1-antoniu.miclaus@analog.com>
 <37d15b55-4483-428f-9950-46f1b0ab2a56@baylibre.com>
 <CY4PR03MB3399892478516DB8724CDF549BD0A@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CY4PR03MB3399892478516DB8724CDF549BD0A@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/24/25 6:09 AM, Miclaus, Antoniu wrote:
>> On 11/21/25 3:59 AM, Antoniu Miclaus wrote:
>>> This series adds clock provider functionality to the ADF4377 frequency
>>> synthesizer driver to address user requests for controlling output
>>> frequencies from userspace.
>>>
>>> While implemented as an IIO driver, the ADF4377 is commonly used as a
>>> clock source. This patch series enables it to function as either:
>>> - A traditional IIO device (when #clock-cells is not specified)
>>> - A clock provider (when #clock-cells is present in device tree)
>>>
>>> The implementation provides standard clock framework integration with
>>> rate control, enable/disable support, and maintains backward
>>> compatibility with existing IIO configurations.
>>>
>>> Antoniu Miclaus (2):
>>>    dt-bindings: iio: frequency: adf4377: add clk provider
>>>    iio: frequency: adf4377: add clk provider support
>>>
>>>   .../bindings/iio/frequency/adi,adf4377.yaml   |   8 ++
>>>   drivers/iio/frequency/adf4377.c               | 119 +++++++++++++++++-
>>>   2 files changed, 125 insertions(+), 2 deletions(-)
>>>
>>
>> When doing a RESEND, please add a note that says why.
>>
>> Also, you still didn't include the clock mailing list or maintainers,
>> so I don't expect this to progress since the last time.
> 
> I forgot to mention in the resend patch, but i missed some of the changes 
> when i sent the first v2 series.
> Should i send a v3 with the mentions + clock mailing list?

Doing a v3 with a proper changelog compared to the original v2
+ cc the clock list/maintainers seems like the best way to me.

> Or do another RESEND PATCH for v2?
> 

No, I think that would confuse things even more.

