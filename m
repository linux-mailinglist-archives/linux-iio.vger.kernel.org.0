Return-Path: <linux-iio+bounces-26383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A81C7D313
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 16:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E70F4E298A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 15:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1428A701;
	Sat, 22 Nov 2025 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eUCMvaYY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58128642D
	for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763824178; cv=none; b=R7afBwgT7RviydtFk6DqG4wlMhGV4vqftQaWzhnCTa0usd0ukAWlPeZfWObqyd98XHc9aGKSS3N9WrVMtG3Prro1xa9RQ0CRQwNo7xJhmkq0WKo+AiLQn8Vqza0G1lSrHkdmglHMTVrrE1H4Jf0Qs+z2aHXm9gQ23JD4HHWjIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763824178; c=relaxed/simple;
	bh=bD6IiCa7MG1LDG3Vy/sVRmJM8FL0GK3kXQ8ix0ygN3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMkfmHLlc4pom2FyRZVITZu4WTG0p+2Fw3HgQ4CvKVRa18A143ylU8sdJGqof+pbjEVuG0I5tPwaKTvN962YYcw9mU3Wf4boIOsqxWJDpZHmm6Y8Nd3ZBJ5XFhDD97Cn3FhzPxQ51fa8zWzmFyBf1GWexBJsJdPjR6FKv/qm4Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eUCMvaYY; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3e89a44007dso2207523fac.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 07:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763824174; x=1764428974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJ00G5DdHxmUWt9ADxO6Ey9yvGgI73+lh18WVqepTD4=;
        b=eUCMvaYYlDNGT02uOVYjeo0urVOipryLCetZu3yPMbqm15El+ya9j9wwqSuDn86VTj
         brO92kqLBeoTcBJhKd98Bqq3aD3D6NSQMXYEE4OLNyEemgVT6E/yDZiy3kxEWb8IwW9Y
         pXKa55iFVK7CfVWMY8tfdJ3ekeHw1SMZx8Sizq7UnTRpi0ZFj/rIkr4HNhJZ5ILyfBKC
         15tU9EdSwQGyqls0j9+UUVJzAk28puLJWY9X7rQWknlYyTiEUjoFDNJp12hw7tPTV01h
         k/DmBQMRW7C6hI/KSVIpogrkyucwl0Btjn/dygS6Hw0Q2Lp1GlkLAqTSVAnEzC4iGvbD
         5UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763824174; x=1764428974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJ00G5DdHxmUWt9ADxO6Ey9yvGgI73+lh18WVqepTD4=;
        b=XvsXB1m2rRBLk9KYDOMkWs1jXu425TPH3HKqZtB9fxzyolaG2LWFJ9c+8Y16IqeQLC
         WmG8JZKN8ihgzeLbQhIqKOY/rN9/+QketDV9Glym2LvePtsthRGs7+xztz9SJXSQx6A9
         /P12pWW2Keud9zIYttM5MYNmgucGPJy13bjo1cUW7/GpmpEYilm4Xw4JXwLBOvxXmeOQ
         03b7CWW4F1XMU/0qDiO9eyB14Tn2ays+TI74ZbdKoiUoxsDc+JkrhmsN2jOWyWN+ues1
         q4IcXX/71tHID2FM1V+VeGw07/kJqH1cb6czZ8LxkB9RF6Rx69OuSLBBKgzdw9OIauU7
         1RIw==
X-Forwarded-Encrypted: i=1; AJvYcCUojlK373pEDY7lxnh06IuCC9xw2/DvyRINhTZKgTkbVfG1DR9zowWdLoxJyM75BnEFOX3bvmwZiyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFAU/RseFs1Rqf2Vnku9uBfJyfX/Ou9reDUGHSfStyCElBW2Zj
	lSJdtn+NRYsEWIgwGng2Aryue4BpNikkMCjJiit7LHWkkIqbIWqTSX8WWWoueUZOcP8=
X-Gm-Gg: ASbGncuIeLXjRSEvzvJsOp/AJI1KY4fMkrP7XOFtKvKRdZ8aIkKM0sqX7CZZTpB4nd8
	Hi6xZpo5ZahkXhVFDRP6/Bt7b9ZpWSfkIktonMHr7UBBgIdd/Mp2Pb3YkVpxMe+8zrOBPWvUrPH
	Cyd3xzrtHNJIi38VM8WdTeOrux4V7jz1iBUHUegZtne5KJDXVSeaOvAVhSn1oE6a9GVyAoE9DF+
	Ol+asvAuFrBoq55OgfGcFsjC338UQZTbEKX7+sgsZlG70VUuDLC6ZgqOIT66JKrdY39T6YH5eu3
	ZjZWSJZVold6K1gsKdkDXdRD7WrBhBNc02VcJCTOsdziRRb14vXZg7LiWnxfRoACFN3TQx1XGJK
	6VvG/snMj564CmAdW5BvKSQp/ShhpX4nQKAc2LMoHJyqE7Z+f5GUe6y4lsVmXUoMX6sfFqcOTxF
	XbMG4BUDTIbdAJDXBHMRCYiRFjQwCWuDYovV8004jezxyU8E94+t5skiOTylQR
X-Google-Smtp-Source: AGHT+IEQOaRdqKonG9tlK9tE3Ji2R9zXetxeakG5C4CdmSrR6Ade+eh+1BwXwf4Y4MB7MZrKyrAlPg==
X-Received: by 2002:a05:6870:4409:b0:3ec:64bf:ef5 with SMTP id 586e51a60fabf-3ecbbe84eaemr2904401fac.27.1763824173974;
        Sat, 22 Nov 2025 07:09:33 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e782:93d8:7c2f:f9df? ([2600:8803:e7e4:500:e782:93d8:7c2f:f9df])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9dc88896sm4056963fac.15.2025.11.22.07.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 07:09:32 -0800 (PST)
Message-ID: <a61ad3ae-b511-4af6-80a2-590fc05b1bfc@baylibre.com>
Date: Sat, 22 Nov 2025 09:09:29 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
To: Krzysztof Kozlowski <krzk@kernel.org>, Kurt Borja <kuurtb@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Tobias Sperling <tobias.sperling@softing.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
 <20251121-ads1x18-v1-1-86db080fc9a4@gmail.com>
 <32e76bff-f535-40ce-88e2-7bbf7da87620@kernel.org>
 <DEEO8SSA15XY.1SDBZEILR5AHM@gmail.com>
 <2676d37e-fe3c-4504-8990-fbee0ce8407a@baylibre.com>
 <6ec98294-82b1-4d3e-a7b6-95cb1d65f206@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <6ec98294-82b1-4d3e-a7b6-95cb1d65f206@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/25 3:34 AM, Krzysztof Kozlowski wrote:
> On 21/11/2025 23:40, David Lechner wrote:
>> On 11/21/25 2:56 PM, Kurt Borja wrote:
>>> Hi Krzysztof,
>>>
>>> On Fri Nov 21, 2025 at 2:10 PM -05, Krzysztof Kozlowski wrote:
>>>> On 21/11/2025 18:16, Kurt Borja wrote:
>>>>> Add documentation for Texas Instruments ADS1018 and ADS1118
>>>>> analog-to-digital converters.
>>>>>
>>>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>>>
>>>> You did not test it before sending, so no full review but few nits to
>>>> save you one round of reviews:
>>>
>>> My bad! I will fix the errors. Thanks!
>>>
>>
>> ...
>>
>>>>> +  interrupts:
>>>>> +    description: DOUT/DRDY (Data Out/Data Ready) line.
>>>>> +    maxitems: 1
>>>>> +
>>>>> +  drdy-gpios:
>>>>> +    description:
>>>>> +      Extra GPIO line connected to DOUT/DRDY (Data Out/Data Ready). This allows
>>>>> +      distinguishing between latched and real DRDY IRQs.
>>>>
>>>> I have feeling that you miss proper handling of IRQs (e.g. active level)
>>>> on your board.
>>>
>>> Can you elaborate? Should I specify active level here?
>>>
>>>>
>> The problem is not about the levels. It is rather that the behavior of the
>> interrupt when disabled/masked is different on different interrupt controllers.
>>
>> On some controllers, if an event happens while disabled/masked, it "remembers"
>> that and will trigger the interrupt as soon as it is enabled even if the
>> condition doesn't exist anymore. Not a great hardware design IMHO, but there
>> is real hardware that does this.
> 
> Isn't it misconfiguration of trigger as I said before? It should be for
> example edge, instead of level?
> 
> Best regards,
> Krzysztof

No. It it still works like this for edge triggers.

