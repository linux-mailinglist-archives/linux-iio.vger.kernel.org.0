Return-Path: <linux-iio+bounces-9248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A2F96F638
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 16:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571321C20E5B
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 14:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798D1D0488;
	Fri,  6 Sep 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3BUe9rnu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7531CF5FF
	for <linux-iio@vger.kernel.org>; Fri,  6 Sep 2024 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631481; cv=none; b=ik/+8gmwPMIu8ml/rZc4094zxBgA/9eB8phQlQUnmYZrwgPVHHiPyFlSXS4ugcprbDiT1EhfnMcnqnWXB+xMVpU54Q+Vi7YrJ0sdonr7AzCdJPIE/2/3GXL840C9ju9VYH1gvCUH8HaUqdxkCK3N9ROue22ygZ5sJ9rfb+cPDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631481; c=relaxed/simple;
	bh=bozoCpCN7VNizi6fYIXxvy9kovuAsx/0HPcnsKGc9S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbnVsGwpUb/zJ3AaZ753hoLqOTKpL2bhuN3tw7F5TNAFDM5LgbeBvaCYe/dpDSScX+KZMb+ekODD8PMNP/hQ27pwG2U67bWZn1hTa02+imSmXePQWkrso7OaunyJ09otAeJOvYNDFZSk0W0+EZ4be7rbAJ/pmaYAMVHnyIw6gkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3BUe9rnu; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e033e37bc9so167578b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Sep 2024 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725631478; x=1726236278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbvGWboAt/dTEq1gD2V5k8emDQaAfQAupylVV7SCoEg=;
        b=3BUe9rnuK8kqw/0Fthqt5mueSJg7NXqW+f3lQlsZNxetYkU8x9Q35aGJwe/Ay8Mcby
         gufQK3MWBdC7g+Q3gaR21yjfsThnIrk8AF63c9oKUi2iOI23GCBINQflhszcRBINRHkP
         6DQgfxJ+AvPQxu1o23/siWW3Np6bve5r0ppZ0mDYQS2E/htfFIdP6721CibGrezkGY15
         XKzzStvc00uBYGbdYd2ORleb2KDoj/XYkgHAHFtAG4fLyury2LMFDwc0sLlmcErcuADh
         QAaEBHnG1Y5TTsXOjm1RDZR6OPlijPOjJRKrgvfLMkW9q+tsnTDL316vRRYeelMkgxkx
         MhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631478; x=1726236278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbvGWboAt/dTEq1gD2V5k8emDQaAfQAupylVV7SCoEg=;
        b=PjsWK5dwvI9ZlNz1GWm1gkF6DHLajIPlPtRHwDbNEuQSj+A4V2OTmDjJWGoSW9jPSg
         WzlFPaZY9j+EDHRa1fgQf5XABhswliSbQz1IdXGiNtikPa9wrvQjS0t0bQddvd/t1vnT
         VXBwZGuXah0MoaWAzMnrrrZjI4I87ghPZwth5jn00IZsSe6BVkeGVXG0nnyguVWSp1TS
         JHVKTs7Z5+6uRq5T/9RwSXlN/ECNC935lLQr1Dk0+oOD2hJhaz1CZjYdUqDXTe+n8R9m
         2qZDH5/cVdq8zAeOyLzBi7/vrmPjktyWXCdEbvwwNKwJfbmYcgKGyNib5AaS6Zffw0h9
         3Hdw==
X-Forwarded-Encrypted: i=1; AJvYcCX69JG6GBauW6uaxO3YSlGDWyM3A++xw243c7S7yTyAi4JXtDuFg6fWJ2x0nUdH77TGYKCxC6BvM7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVfd6tKa2dou2bPm+VJwdyOhplJaLTzDBTmERdpt9qZ9tQ+EdO
	NT4H6VoNIh7CICJ+UuKJcH6tRS08wedF8ElIoRrz4HEXab2EIEX/4JOus44QIyM=
X-Google-Smtp-Source: AGHT+IFK9/4OL7nm7O7NBZ579F2/SvR1lDAVknbSPts5/rPSjp1vwADNXiIfNSJ+u0CxXV8DPB7tyQ==
X-Received: by 2002:a05:6808:221c:b0:3da:aac7:43b2 with SMTP id 5614622812f47-3e029f2baf6mr3255446b6e.34.1725631478015;
        Fri, 06 Sep 2024 07:04:38 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e0355bf88dsm414b6e.21.2024.09.06.07.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:04:37 -0700 (PDT)
Message-ID: <de4718f5-a36f-4e5c-b5e1-f1c6e2484420@baylibre.com>
Date: Fri, 6 Sep 2024 09:04:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] dt-bindings: iio: dac: add ad3552r axi-dac
 compatible
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com>
 <boahpvyzzmocnnpae2u6meub34yvqr2q3v5pzf2egp2fretlwk@ibas62hdypwo>
 <fd3f4874-b410-4e98-acba-d0fac041a40e@baylibre.com>
 <1928d0ce-cad9-4737-880e-3759c47fddbc@kernel.org>
 <058937fa93d484f3e81807d08a39bd8dfd3358e8.camel@gmail.com>
 <47c56239-51a0-4ff2-9db2-0e0184cfb086@kernel.org>
 <a0d213442b4de0b06991be2be1d7b2bb091f2b52.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a0d213442b4de0b06991be2be1d7b2bb091f2b52.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/6/24 8:52 AM, Nuno Sá wrote:
> On Fri, 2024-09-06 at 14:13 +0200, Krzysztof Kozlowski wrote:
>> On 06/09/2024 13:53, Nuno Sá wrote:
>>> On Fri, 2024-09-06 at 11:37 +0200, Krzysztof Kozlowski wrote:
>>>> On 06/09/2024 11:11, Angelo Dureghello wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> On 06/09/24 9:22 AM, Krzysztof Kozlowski wrote:
>>>>>> On Thu, Sep 05, 2024 at 05:17:35PM +0200, Angelo Dureghello wrote:
>>>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>>>>
>>>>>>> Add a new compatible for the ad3552r variant of the generic DAC IP.
>>>>>>>
>>>>>>> The ad3552r DAC IP variant is very similar to the generic DAC IP,
>>>>>>> register map is the same, but some register fields are specific to
>>>>>>> this IP, and also, a DDR QSPI bus has been included in the IP.
>>>>>>>
>>>>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>>>>>> ---
>>>>>>>   Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 1 +
>>>>>>>   1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>> b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>> index a55e9bfc66d7..c0cccb7a99a4 100644
>>>>>>> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>> @@ -24,6 +24,7 @@ properties:
>>>>>>>     compatible:
>>>>>>>       enum:
>>>>>>>         - adi,axi-dac-9.1.b
>>>>>>> +      - adi,axi-dac-ad3552r
>>>>>> I am sorry, but what is the product here? It looks like either wrong
>>>>>> order or even completely redundant. What is ad3552r?
>>>>>>
>>>>>> And why versions are mixed with real products but without any
>>>>>> compatibility. What does the version express in such case?
>>>>>
>>>>> dac-ad3552r IP (fpga) is a variant of the dac IP, very similar,
>>>>> about the version, it still reads as 9.1.b
>>>>>
>>>>> so i can eventually change it to:
>>>>>
>>>>> adi,axi-dac-ad3552-9.1.b
>>>>>
>>>>> Should be more correct.
>>>>
>>>> No. First ad3552r is the product, so axi-dac is redundant. Second why
>>>> adding versions if you have product names? Versioning was allowed
>>>> because apparently that's how these are called, but now it turns out it
>>>> is not version but names.
>>>>
>>>
>>> Let me try to explain on how this whole thing works...
>>>
>>> We have a generic FPGA IP called axi-dac (same story is true for the other axi-
>>> adc
>>> IP) which adds some basic and generic capabilities like DDS (Direct digital
>>> synthesis) and the generic one is the compatible existing now. This IP is a so
>>> called
>>> IIO backend because it then connects to a real converter (in this case DACs)
>>> extending it's capabilities and also serving as an interface between another
>>> block
>>> (typical DMA as this is used for really high speed stuff) and the device. Now,
>>> depending on the actual device, we may need to add/modify some features of the IP
>>> and
>>> this is what's happening for the ad3552r DAC (it's still build on top of the 
>>
>> What is "ad3552"? DAC right? Then as I said axi-dac is redundant. We do
>> not call ti,tmp451 a ti,sensor-tmp451, right?
>>
> 
> Yes, I agree the DAC part is redundant. But I think the axi prefix (or suffix) is
> meaningful to differentiate it from the bindings for the device itself.
> 
The binding is for this [1] IP core. The documentation calls the core
"AXI AD3552R", so I agree that "adi,axi-ad2552r" is the most sensible
compatible name.

http://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html

