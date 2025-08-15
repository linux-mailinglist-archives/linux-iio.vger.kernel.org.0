Return-Path: <linux-iio+bounces-22746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5B0B277EE
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 07:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F245E6061
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 05:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFCF223DEC;
	Fri, 15 Aug 2025 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hndl5ASm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395071E502;
	Fri, 15 Aug 2025 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234029; cv=none; b=OnfY5z7psssz7gXoIUW68JH5jOxCxQU/5rePG0NgoEiQQZLgqWaQFHfYaDUQSDb4+37ULiY85uwN9oSNCdU1HzeazIqbC2tmaWd2TDJ5OWpOGfWE7WogPHiYfCHX4lnbBNj84I0dnAUk3ZrpiWx1cJz1mRlFwoOi+zExCFhp0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234029; c=relaxed/simple;
	bh=BdXI9uDWb7s6Nrk7XG//Z7OFsqMRPHqalYnUc4lXmwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJOI/+c7brNPvSB/Uy+M6uv3LPVauHlrwICugDJKMgWfr/XlqwXef1mVJJvj6gYnXkfU/zFKmw6orwqTjTsWUm/k010MHMEpg4V5A4o/pqGNnIn/ac+o+JtybahMRFGkhcPlx3O3p1vhXPsjUcr7/jHfolwE9OjKRZytkxC0DTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hndl5ASm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55ce5287a47so1482793e87.3;
        Thu, 14 Aug 2025 22:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234025; x=1755838825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibYV2DXy3yJ+JImrUWfFgpWrleNjyaOJiO783aX8k0M=;
        b=hndl5ASmhFn0ORJVS9H8//T31Pi1+HXJBOjnuQUGl0eBNei0Cf2NaI7JDg/LdSHCmP
         c+wAL3/Rn+ih+sTTNlvPayEjrqHt5sNPtC4NN7VSrxQqeZwCdqohL2snND2AmXrXmbn/
         506M/+VptmHnao1z/oCNfrmRcmpDi75O/a/tSlN4RzQTbhWXry42X/+cspUx5BggYPyw
         uEPdkwFt5f3QBe779ufSCdPXV97eWt6xW6gP7C1YTrQfoMHYyneOKGYrpnFyLN/rmnUV
         LY5vCBeU5CUZsl89j/SdmSu13Tz/4g2QzmD/RijTb8MtmLMeDNp80d6rb5711FSWvnPl
         zf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234025; x=1755838825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibYV2DXy3yJ+JImrUWfFgpWrleNjyaOJiO783aX8k0M=;
        b=TUlCBieGZdViqh3qWZCmFUG/y1XWublofVvpD8ZwCB83PCxrDetUgYaNupMsrAeUto
         EJ6MC8IDqtLqWLSTNSi+KQWacJs41u4lQkSDBF/D1sgdQvmxMrqh8fUMvHICVYK6Euyo
         WRoepdTLJk7L+7nITPTCtW2/StTwTQn9trd3ljE2HSY8Xpyq7HRJqzlNK8CghamB7XSD
         nX58POq9rFKvIzZA4/v2x5flxx5iGXiJIK6AdGiqaPqrgQeXCysPQY/Xz3e9kMErPS9E
         rSGvcrH2KCvuMub4n2a9D382RQONOdRyMMaKe4rJcVBhQzw46cfXyqZlwEWV56X2rjRe
         xGog==
X-Forwarded-Encrypted: i=1; AJvYcCWii6DFR+opnzHMx2k/oZ2FHdFGIkSuSQJerAY1Ufsi8CVv6CmLSmq45Zhq/DjelhALSDa0aroZCsme@vger.kernel.org, AJvYcCWyrhnnL8fQudECSUjWc8jLEptOqDPQv0vCl8S3rzVHhecjiIF+ntaSDzwuV4OmuiF/6/jrqe/K9C4g@vger.kernel.org, AJvYcCXeyksVeNvgt6mec1CHG0oMhAg2Qs089iEjDqNidfH6wElCZbsGIHRfjlPy2JkN1KQ+HH4GVHtRyGkdwazH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5I4sV9btFmkf1r+YotaNdVCLZt5G5vqJ3UyaP8o3zIREh9Yq
	ig9O6XQC7RQ2i6aD5fb5qqBHJYLeLY7jWcy57i5MZpCNClkrGjayFzhn
X-Gm-Gg: ASbGncvP48LqP4iS22Z+DRIv7XSJGLGDa+NtQ3T5+atCoCz0I0g/MorhRuWegCBbSfs
	ly5icGKn/MD7RGIDVZE9ULjoralA8RtjMJbLi6MtaT6hd7cmpQJpjzNZtgA8QHRrVohhBTJREz2
	sJI3KzQigd5g1+6mieq/vuxBwSlAD02z63lGhG2ixO5tKvFy9YjWaDiUnjAUJjd/PF4EhH1uE52
	dY//MH+z7XyVqEB5XTcia3nxCPIVz+OIgbFMa41Qe57Ou7IK1IOlasikt7nRD+ywfpbyfD3LaAh
	5xNIhy+gf0TN+UeYbh8yppQoN9dqtggrPC8HfhPjQL0dCKTqxgkPs35oZlEeSGb8MtNqHTRSMrC
	Qt7nv8UyfElk+mtQ/USpAof6PCSdwc6Lqr2WGIBqDRDFV1ZYv/Cq8x02XluFzi+7OwcMFcFvPOc
	RQQd1331XwTLAgdw==
X-Google-Smtp-Source: AGHT+IEdtb+aXAX0+qkW3BXed4xKLSwz6zWlk3z6/Lm5JIc0U6agAFpFu98uH0yqHouY6nnMyIkPng==
X-Received: by 2002:a05:6512:1383:b0:55c:e988:9440 with SMTP id 2adb3069b0e04-55ceeaa185bmr176750e87.6.1755234024976;
        Thu, 14 Aug 2025 22:00:24 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351646sm79928e87.17.2025.08.14.22.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 22:00:24 -0700 (PDT)
Message-ID: <2a757c8d-4ac5-47b7-920b-96575213d6e1@gmail.com>
Date: Fri, 15 Aug 2025 08:00:23 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Add BD7910[0,1,2,3]
To: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1755159847.git.mazziesaccount@gmail.com>
 <8ef78e3cffcfdf99153a3fcf57860771890f1632.1755159847.git.mazziesaccount@gmail.com>
 <175ce750-7f5d-477c-8d18-dd418ba749be@gmail.com>
 <b1cc499b-403e-4dcf-9e6a-10d4d43a8b30@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <b1cc499b-403e-4dcf-9e6a-10d4d43a8b30@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2025 17:51, David Lechner wrote:
> On 8/14/25 4:57 AM, Matti Vaittinen wrote:
>> On 14/08/2025 11:35, Matti Vaittinen wrote:
>>> The ROHM BD79100, BD79101, BD79102, BD79103 are very similar ADCs as the
>>> ROHM BD79104. The BD79100 has only 1 channel. BD79101 has 2 channels and
>>> the BD79102 has 4 channels. Both BD79103 and BD79104 have 4 channels,
> 
> Is it just a difference in max sample rate? or pinout?

The BD79104 comes in 2 different packages (BD79104MUF - VQFN16FV3030 and 
BD79104FV - SSOP-B16).

BD79103MUF pins seem identical to the BD79104MUF pins. Not sure if there 
is (or will be) BD79103FV. (Both the MUF and FV have identically named 
pins, with same functionality. Only the pin positioning and potentially 
amount of unused pins differ).

So, looking at the functionality, the pinout is same. Looking at the 
physical IC, they may use different packaging for these ICs.

Finally, the only difference between BD79104 and BD79103 I have been 
able to find from the data-sheet is the differential nonlinearity.

For BD79104 it is said to be:
DNL: +1.2 / -0.99 LSB @ VDD = 3 V (Typ)

For BD79103 it is said to be:
DNL: ±0.99 LSB @ VDD = 3 V (Typ)

> 
>>> and, based on the data sheets, they seem identical from the software
>>> point-of-view.
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>> ---
>>>    .../devicetree/bindings/iio/adc/rohm,bd79104.yaml     | 11 ++++++++++-
>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
>>> index f0a1347ba4db..6a6e6ab4aca3 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
>>> @@ -14,7 +14,16 @@ description: |
>>>      properties:
>>>      compatible:
>>> -    const: rohm,bd79104
>>> +    oneOf:
>>> +      - items:
> 
> You can drop the items: here since there is only one item.

Thanks.

> 
>>> +          - enum:
>>> +              - rohm,bd79100
>>> +              - rohm,bd79101
>>> +              - rohm,bd79102
>>> +              - rohm,bd79104
>>> +      - items:
>>> +          - const: rohm,bd79104
>>> +          - const: rohm,bd79103
>>
>> Oops. I believe the order of the compatibles is wrong for the fallback.
> 
> Indeed.

Probably needless to say, but I'll fix this for the next version :)

Thanks for the review David!

Yours,
	-- Matti

