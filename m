Return-Path: <linux-iio+bounces-22766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DECB28175
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 16:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 267FDB675B5
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 14:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE649202983;
	Fri, 15 Aug 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L4Em8DIT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150821C9ED
	for <linux-iio@vger.kernel.org>; Fri, 15 Aug 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267391; cv=none; b=BXUMD4enUg8Rnd7fg1nPA8UR0Aet3e2RSqlRwPzsrN8c/2O/AJ+yq8uLJw2wmjOGCmAwAsWMOegEOmxKO07AbA10TjafgT3UeBVw3PiK/hKJVBsUvjy9yZbYHZT68SXWTNmLEZP62U0hfVr+IZkk2uIKpjBLgTsVwefaqoTLUTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267391; c=relaxed/simple;
	bh=KOhlSg0qcYg9ob3Mm7f2krs+0oUtcXnKHGyVvRFd7qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJ44BNVxDM1RtE228Xbc3+EtgWAwz/NdQIYXMw3kZdOlArc/T1OYJY8sPKb0oO7EX9v9Zki0jNqQchUe16MOqJq88A0cE6b4RXb1FtFowYKsf4JPfTJ+c2XPox/fSuIS2UUa4zfOg+uVuZA763D5P5zhxwE+Uhcoa3ZQ6sGWPZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L4Em8DIT; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74382048b8cso1047922a34.3
        for <linux-iio@vger.kernel.org>; Fri, 15 Aug 2025 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755267387; x=1755872187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+dzZAqMWMrU9JQ+HnPQcZbDejbmWGfSuQd14G8BjoE=;
        b=L4Em8DITgSwkQaL2gneAQwGvbYpPWWUKhAmzj8MnnTVT/ewnqtdk/KVoLzoCjaLsuo
         Z1iVBXVHARtmuCP7RsKOYODxBWenZwwdMKJ+WbTnI4cUg4T067WJiVfMNGDdjtu7HrpH
         unVuTuImmmuod3GEXDdCLL7+nuWxdHaiSO84rs8i8sGiWRJSajnR8W8ORMe8K4BaYIqX
         3ilgJxEwREfO5MRFdXVkQAVOA25o5IW+uM8Fwui4JETnB1nVecPOExzpwlfu+E2xwZ4A
         vVfiuKY2K0F3VWl6islCSTJENFECRhZ6pHYnK8HC71AwiRHnnr8wzGWGBXjM5A6et6b7
         ktCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755267387; x=1755872187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+dzZAqMWMrU9JQ+HnPQcZbDejbmWGfSuQd14G8BjoE=;
        b=o+yBOcdBZd+c0p0l4QEBkPwDoOZ9a2Cake3yB1pfNjPWkzMUy6iz+/X3kT/V0xbZDT
         gIARmdosHwvAM6Y7+taRbCGdgIPPeA4VuUlAVwLwbLdms6BzjqyUNY4BPsfmarJJQo9j
         zpn+gNooXqg1Dr2O3nJgkeYjzuG4Bv3qn5WLeXCBfxu9XMU0mUsaDU+f9jRLrBWbckHA
         LpYLJsqUe924pavshovMul8a90u5sr66l0NhhkzEs45SQUNLARw6Ksv9M2zZSsBKV0/U
         Ww2aS6ylstMK/gj8apw9NFSGRX29Krv//PaBITfqYbEubRx7pjx+z7pVGgBHBFVQxpVB
         R+sg==
X-Forwarded-Encrypted: i=1; AJvYcCUpnZMOSvsOnd6AQKNPK8Y0pptgMPZyRQHRBCVI21A1QvYwZgq7a+KCmTPbIwG0SJ2/hFUDyScNRgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIG52mWWkxrHWyqNChPxC00DQPOWKsjjXsU+zA3iZTOj70ArT
	Eba0Ix/ize6eK79PxMvmJYp2DHZt2nyjtkEUiVlJ974zYgHXuxt7pqjOifmhTCHrbow=
X-Gm-Gg: ASbGncuDTel+QtEn2DX6kyqOoaJ/33scVq84nl1OBGpqx8n2clhpCnnuR8hYkySuW1N
	QxfZmcTI5Y5mrV7dh/2J3tToyyromIhezsRN6OhBvgRLKvDdHU9/a7xg1fesK4hU5GuZ99eqnot
	1BQiMvRo4skJ50S7i1LljeVVRoD6iJlFWQMA9zMIkqttHKLUTOhv917X62pKFBvMUUyBXhFJTpR
	2i0Z0kOPQShW17qP4kQfndV2ImBmQVZzMYwCGQGTtEEk8n5gclDrdGxDkC7eJ/mMd4dd+pCiayi
	mgHzwNmo+thxnWYXWZJpaZdkfaBJ7t1dL54fuBL5Dk6Sk3E1AyPivmICbMEdDlbX77I1irTOcmn
	cFCftbDI5FI92FpV7ZKut1h/SQ52O6xIZOX3RO8fUMlApzvu31JxzimLznnNwYn55NCRj234L
X-Google-Smtp-Source: AGHT+IHUesJ2V4GKpXl067F97odMOMFwnwY0zqEdIAx4kIEiR13a/+37EIRwtokkyj02SDIkZXFr9Q==
X-Received: by 2002:a05:6830:6585:b0:741:9b10:5f80 with SMTP id 46e09a7af769-743923abd24mr1135235a34.7.1755267387266;
        Fri, 15 Aug 2025 07:16:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c? ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439204d28dsm318773a34.35.2025.08.15.07.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 07:16:26 -0700 (PDT)
Message-ID: <384f56af-efb3-412b-9874-4d422fe2ac8c@baylibre.com>
Date: Fri, 15 Aug 2025 09:16:24 -0500
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
Content-Transfer-Encoding: 8bit

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
>>> ---
>>
>> One small suggestion. With that:
>>
>> Reviewed-by: David Lechner <dlechner@baylibre.com>
>>
>>> ---
>>>   drivers/iio/adc/ti-adc128s052.c | 36 +++++++++++++++++++++++++++++++++
>>>   1 file changed, 36 insertions(+)
>>>
>>> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
>>> index 81153253529e..2f2ed438cf4e 100644
>>> --- a/drivers/iio/adc/ti-adc128s052.c
>>> +++ b/drivers/iio/adc/ti-adc128s052.c
>>> @@ -122,6 +122,10 @@ static const struct iio_chan_spec adc124s021_channels[] = {
>>>       ADC128_VOLTAGE_CHANNEL(3),
>>>   };
>>>   +static const struct iio_chan_spec bd79100_channels[] = {
>>
>> Even though the driver doesn't support it yet, there is a
>> adc121s021 [1] so would be nice to use that instead of bd79100
>> to keep the naming consistent.
> 
> I have to disagree on this one. For people who don't use the TI ADCs, the TI numbering does not bring any clarity. 


I think it does in this case because the part number includes the bits
and number of channels. And the pattern is pretty easy to spot without
looking at the datasheets. This is why I suggested it. Otherwise, I would
agree with your points in general.

