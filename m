Return-Path: <linux-iio+bounces-8699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9196B95C8DC
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 11:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E08428565B
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 09:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5582D149E0A;
	Fri, 23 Aug 2024 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCgt+uDS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A4149C79;
	Fri, 23 Aug 2024 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404156; cv=none; b=I7sZSryRaUZDfhDaV5jC8zjYtw0e1N/2CKCiIrUk2azRzOJdgGvBwtygp24Ojn+rYVz1KjQtgwOP0+GSj9iSofoecXgAZufy8IzMavmiiubjGH/n5qg94rg6/ImCSYKTv/Z7ga3ma6WmqyqILPLCdFXTGSDYYO+qXZm1NLeGEp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404156; c=relaxed/simple;
	bh=pWVW/DKrRF/+sVlMcTSKkgOJkDnCjGIovyZ27nyrLs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i67b6GYADHwE33wgyM2MZI2HttMx6pCzZ/6lIouTmTdDHRZ/2k2Y4sbz3wAetIEjoiXrvqnNZUWY023UlyGzMboE53vm8a78JBJ9kMSd5qdri4vpFP0J1+AjWXy4dZ0kV/ew1kMgJol4MJxVcO/g4qc3Fi9MaIdx/R8yF5LNG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCgt+uDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD55EC32786;
	Fri, 23 Aug 2024 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724404155;
	bh=pWVW/DKrRF/+sVlMcTSKkgOJkDnCjGIovyZ27nyrLs4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OCgt+uDS0N2lw/qclh3LAkT4zfKSNtONT9mnxq5NzY24VfaIngVmwtcrfR89wq/i+
	 XnU/A1beEmk8w+IeYvHFwKwGwTuNpi0T4AyLpIiOpSCi79yX+Uanp053iwoag9vlpT
	 CSJpEe1Qt7UjN03+QqC7t0S7LdA1gVwsagDaNUScXJNEijwXhrtC0/ItB4mpDYtlVr
	 +P0XHwcCjEIE76G6UkKHRwlugabef48VxDUVEjpPmAOuzFQbCdSrVnhTTKh7vHyGEw
	 uBN+uEphEKEGl979evy9IROdaO00MsUAupdLx2hS1DIK+i0ZqTDCzxN76vKyJHyWhp
	 Z7aTsaF48Ki1g==
Message-ID: <46153017-9ab2-4a2f-afe6-9321e0f65f03@kernel.org>
Date: Fri, 23 Aug 2024 11:09:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] dt-bindings: iio: adc: add adi,ad7606c-{16,18}
 compatible strings
To: Jonathan Cameron <jic23@kernel.org>,
 Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
References: <20240819064721.91494-1-aardelean@baylibre.com>
 <20240819064721.91494-7-aardelean@baylibre.com>
 <zuvwoy5wtdel7qgkz6wa6valwjwajpwoqnizyoooiawghrxvc3@cuoswu32h4fl>
 <CA+GgBR_V8r0Vz1PeKxwD6ovwHXxGM6=Z6XVd03ehokT5C3zjnQ@mail.gmail.com>
 <20240821212606.6981eae1@jic23-huawei>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240821212606.6981eae1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2024 22:26, Jonathan Cameron wrote:
> 
>>>> +    type: object
>>>> +    $ref: adc.yaml
>>>> +    unevaluatedProperties: false
>>>> +
>>>> +    properties:
>>>> +      reg:
>>>> +        description: The channel number.
>>>> +        minimum: 0
>>>> +        maximum: 7
>>>> +
>>>> +      diff-channel:
>>>> +        description: Channel is bipolar differential.  
>>>
>>> There is diff-channels property, why do we need one more?  
>>
>> Yeah, I wanted to use that.
>> Maybe I will try another spin at that.
>> The thing with "diff-channels" is that it requires 2 ints.
>> So,  diff-channels = <0 0>.
>> To use it here, a rule would need to be put in place where  "reg ==
>> diff-channels[0] && reg == diff-channels[1]".
>> That also works from my side.
>> Part of the reason for this patchset, was to also get some feedback
>> (if this is the correct direction).
>>
> So I 'think' this is a datasheet matching thing.
> In many cases, even for strictly differential devices, the pin
> naming allows for a clear A - B channel description. Here
> in the non differential modes, the negative pins are effectively
> not used (from a really quick look at the datasheet)
> 
> So we 'could' introduce magic channels (give them high numbers) for
> the negative ends. I think we may want to do that for the
> userspace ABI (0-0 on the few times it has come up has been a
> calibration / self check mode not what you have here - it
> wires the actual inputs together).  Alternative is just present
> them as a simple voltage and don't worry about the differential aspect
> as it's not hugely different to bipolar (where the zero level is
> effectively the negative input of a differential ADC.
> 
> For the binding I'm fine with the binding using A, A as you suggest
> with an update to adc.yaml to cover this corner.

Yep, let's add it to adc.yaml.

> 
> We never (I think) have bindings for the self check case where the input
> is wired to both sides. It's just a mode that is applied to
> any inputs that are wired. 
> 
Best regards,
Krzysztof


