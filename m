Return-Path: <linux-iio+bounces-27087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC22CBECFA
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 17:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 280B6301DE05
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15632BF24;
	Mon, 15 Dec 2025 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g4aS1b0M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066C30FF1D
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765814320; cv=none; b=tcZCN2Uj0Z+qXJqnytCz5f/UBso3wS/gj6bwQ24+knptGsrKl5qCta/TQ7xtG/UvxzuvCO3xkFoL+B4mX+5rFK5PTsMKPz9XfcQyhcW5mF54xoOk6TS5E9q/Xa5CqYqi/+Y5j1rEjLcxBoGUW6QuPnsjuvbmxG0pC669Zttv5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765814320; c=relaxed/simple;
	bh=eRv7AfNkcTJVknA4Das5S0e6Q7KjBZJ1udFtKIBB6d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8sxzA2wMaEg1vV9XXKXOaejm3KmJMZBbVxpeQ8/lsBT9WZa44xtaaaqXQquxCy/ULkcDUIdcBGlVp1fg1LvDvqh5LkNy3oWlxKaHRNI9mzSN+sKvYBa1agUSJV525Js6M7722zsUifGifHW3LJvlZO0aNPlHDUUtABWkuxqxFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g4aS1b0M; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c71cca8fc2so2670041a34.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 07:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765814318; x=1766419118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FAg1Z81+fT0z4IQz8r+6XMjGkoDKjdatvxs7gjb/AyE=;
        b=g4aS1b0MfzxkEphC3luwnUZQ8geoJEq1q9F9xEz8iuIGI+Ao4Qve/zhCdxWBaQ/NbS
         hqtwMoiltyGOoofsoed0WPjoxlpawHUyQxT7urm0EE+CYvH6SULLic55fCfEYSW7daGV
         O8g5FsS1oLuJKx234L/lBl40CxmY/hkT2oNBI+D5PqMJyEP78zuk5zJt1J1ZpQYJ5lKM
         WxcWBOSYAjhDTGHTbSCgq9Sc+dFBBKF/hIi4ejc2mhiES1lBlJvkqCXgsI7vHgMaBm38
         iXR9PnS+DC9z4C6AtgRKH3R1MrJ/iLcntEfocOGSri8G20pnPtdJEhuAuqN7J/cIh4b2
         m5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765814318; x=1766419118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAg1Z81+fT0z4IQz8r+6XMjGkoDKjdatvxs7gjb/AyE=;
        b=q8hZo5Mp2jl0z43T7RbdwwUDGB72EOdbhizUz02M/KUxL8MBDwkrCSOAjzQJOT6pYp
         CauOU4MOG+vw09HLgAA5srUjtFDtM27GzZl1lxLEWiZ3RccKpKnKYNK530DXjpW6szl+
         OGG3DDIH7giZUtcdBG6ppb+6AUJT54pBegzqM9D60GTNvet1ifQSG4WdKFRixw2bFWQU
         my5p5TwNf6tEDHbAN6S+lpdLuCgyctgQxZ6zqI/bAvHufKkeLf5f3CAwdgNxFMEh5Bm8
         PZibw55teuG7kZiN1lC6lHrp/fgGg/hL2NKZg8eJ0Y8ILoMQdT2oh3b6jMcSCjjYLZMM
         HiPw==
X-Forwarded-Encrypted: i=1; AJvYcCWk3kdC75BIyFxvlw8rzu7TdIpvZRYX1EqwvqOwbJoacFUtKoHntlXsCBdgFxAd4Xm0lgN1rau+KNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQKY9IHVYeILcULOXmwWPK6p4pIycQT2q+d1VLTtf0q7xABEP6
	Z618oHQ8elf0UGEcPgJ9DHYX7sARd7jQKpk36VCFQmTAjc90bxkvDg1HoPtnfrJCJUI=
X-Gm-Gg: AY/fxX57ueDN6tcakQ3ogs7CvSlrCcj9c6gX2wEpoBDSdSsmX6nCj75CbwS+vsnHUN3
	Cv18D8lulK+O0WnSBAFS1HSkqA3/S1HXaltMw00Qmq8ARaKhfL0iDUzv/ppBnlo7Jj9deMiZCiW
	EDLjoOpJo6SUn5GcSkt0QeST8UAlv3oQXARj9rLfAZ4qyrEVeIwRGCV+Usqdbb5O1AwpJGThq6P
	WOMDAXg201Sv5J2nByzQi0x1lC+nxyJj9Mi5QnAtG3RumAXqEkgKy8bmNsANYK0QEt0Iv/FCz45
	F8ivZqbgksZZqRfL59nsxCT1XlOWQAqjx+VCVz2mRdLcwZ1Cg/Dg+s31g1qn814pxQPPLC4uKIW
	xA60S3ZfGvnuRS9mKJtcs4oZKyHpPM8kD9jKsUHIH3F+YkDgNqW6JDtTwMw2euoxCDT/xcY7RrM
	CdnJgpDv1RN6n8QrmXzTGWxD4dNInTrV1LMM1W2mtcVqwaqn09iDIuv9bKIxUt9JxX5Il7r6E=
X-Google-Smtp-Source: AGHT+IErjR8OzAEn6sK+72q9AhulVm00s3z7ntoS+Df2bMmfuqscJ9cXWsujF6in7Q1hr5h3VM3W0g==
X-Received: by 2002:a05:6830:67ff:b0:7c7:6219:6852 with SMTP id 46e09a7af769-7cae8381a11mr5824150a34.28.1765814317789;
        Mon, 15 Dec 2025 07:58:37 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1635:b560:bfdd:f758? ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb1ff4desm10030529a34.7.2025.12.15.07.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 07:58:37 -0800 (PST)
Message-ID: <8ef3fbd1-b746-4379-b615-e3034ec8f39e@baylibre.com>
Date: Mon, 15 Dec 2025 09:58:36 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add TI ADS1120 binding
To: Ajith Anandhan <ajithanandhan0406@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
 <20251109141119.561756-2-ajithanandhan0406@gmail.com>
 <20251115183144.15b3e236@jic23-huawei>
 <5cb6243e-f47b-48dc-9f43-299cde632e08@baylibre.com>
 <d25b91b2-20c2-492a-b056-bf3bdaf4494a@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d25b91b2-20c2-492a-b056-bf3bdaf4494a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/15/25 8:49 AM, Ajith Anandhan wrote:
> On 11/18/25 5:49 AM, David Lechner wrote:
>> On 11/15/25 12:31 PM, Jonathan Cameron wrote:
>>> On Sun,  9 Nov 2025 19:41:18 +0530
>>> Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:
>>>

...

>>>> +
>>>> +  ti,avdd-is-ref:
>>>> +    type: boolean
>>>> +    description: |
>>>> +      If present, indicates that the AVDD supply voltage is of sufficient
>>>> +      quality and stability to be used as the voltage reference instead of
>>>> +      the internal reference. This allows the driver to select AVDD as the
>>>> +      reference source for potentially better performance.
>>> This one is interesting as I don't recall anyone arguing this made
>>> sense before.  In what way better performance?  Are their boards out
>>> there where this definitely makes sense to do?
>>>
>> Seems harmless to have the property even if no one ever uses it. But I would
>> be curious to know the answers to those questions too.
> 
> 
> I included this property based on the datasheet mentioning AVDD as a possible reference source, butit doesn't claim this provides better performance, and I don't currently have a specific use case or hardware design that requires it.
> 
> How to proceed ? Need your valuable suggestions.
> 
> 
> BR,
> 
> Ajith.
> 
>>
> 

It sounds like it is unlikely to be used in practice, so I won't
object if you want to drop it to keep things simple.

