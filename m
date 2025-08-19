Return-Path: <linux-iio+bounces-22960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4D5B2B9BD
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 08:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2751636E2
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 06:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA742690C0;
	Tue, 19 Aug 2025 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP5vVfov"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949173FE7;
	Tue, 19 Aug 2025 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585586; cv=none; b=maqXhyUfW4kx6FzCs327AcQWdgRMJTJODlG2LM+W937G5ZtCML+WEEBMDcJqFUhWfXvfdb7HbaUbZQUpJOMJIAPx52OrFDgdyPstnpH3RAvILRtkz0XlLJ4Fp9TkKL8eKn2lWfpmDSmJCqdirw1FRgOUcpt1lysNSWdh9ypawd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585586; c=relaxed/simple;
	bh=5TdbgDMcTMoYx896jp5mrGxDjLrmQ8N8B6xExaeAz9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUCOtp72AM3yCAOVei90zwlKzMBtVsnslpdLvneHcEYeKygvbMc9maxUBSUPqD5JFj1P2usQOmNv2GrlXC2gW+iwV23lvnyewKyWM+VlUAAkmCb8ZdrMJcYBoRS84wKsIpaj1M87lhJYiZblwJ2gjufaFYAc+X5DjEQ63fvN5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nP5vVfov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0E1C4CEF4;
	Tue, 19 Aug 2025 06:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755585586;
	bh=5TdbgDMcTMoYx896jp5mrGxDjLrmQ8N8B6xExaeAz9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nP5vVfovPeiETnUhWL+gGPhzQZIp44Za85cLnr7UI7eZwRxbMPsK6krbj/7NbwKbh
	 WjZkCwKVcW+KgbQ+F3Vz89dtJ9za/ggHxfafHGXdZpX7n/sN8Way1b+U+NnLRG6RZO
	 JZ6h4Wu9Sp5NoGwichareey4LkgrVvQJi+1uRgCP37PkO9Joy/Ue3FBVdhEeloiJyP
	 7VXyl55A3OxGttHnGTDiDlIH0KzU3qo6Z69WnLFV0zc+H2B6BBkefIkN9iS2CIFuLY
	 q/BJwR4WdIfFeOEl0PqriLsHIj9LeCgeEVl17ckaM+lUsH/GQ5eoOt7Xosre+79to+
	 /wrD4872LsO/g==
Message-ID: <41ad5dc8-0179-49b7-a660-2c55b5048db6@kernel.org>
Date: Tue, 19 Aug 2025 08:39:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: ad7768-1: add new supported
 parts
To: 20250816141220.0dd8d68f@jic23-huawei.smtp.subspace.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
 <ecb7406f54938658b51b4469034d87a57086bd1e.1754617360.git.Jonathan.Santos@analog.com>
 <c3cf9b97-3883-4ebb-a2ed-0033adebda87@kernel.org>
 <aJ0UEUVmIH94Nuwi@JSANTO12-L01.ad.analog.com>
 <8c27b00c-5b80-400f-8538-b9ad96fd5feb@kernel.org>
 <20250816141220.0dd8d68f@jic23-huawei>
 <aKOVY+F8JfOFr0O4@JSANTO12-L01.ad.analog.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <aKOVY+F8JfOFr0O4@JSANTO12-L01.ad.analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2025 23:04, Jonathan Santos wrote:
> On 08/16, Jonathan Cameron wrote:
>> On Thu, 14 Aug 2025 08:03:23 +0200
>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>>> On 14/08/2025 00:39, Jonathan Santos wrote:
>>>>>>  
>>>>>> +  adi,aaf-gain:
>>>>>> +    description: |
>>>>>> +      Specifies the gain of the Analog Anti-Aliasing Filter (AAF) applied to the
>>>>>> +      ADC input, measured in milli-units. The AAF provides additional signal  
>>>>>
>>>>> What is milli unit? Isn't gain in dB, so maybe you want mB? Quite
>>>>> unpopular to see mB, but we cannot use 1/100 of dB, so I could
>>>>> understand it.
>>>>>  
>>>>
>>>> Actually, the gain is expressed in V/V, not in dB. I may have phrased it poorly, but since
>>>> there are fractional values like 0.364 and 0.143, I chose to represent it
>>>> in milli-units.  
>>>
>>> Why your reply to is corrupted:
>>> "c3cf9b97-3883-4ebb-a2ed-0033adebda87@kernel.org"?
>>>
>>>
>>> What sort of unit is milli-unit? Isn't this 1/1000 of some BASE unit,
>>> but you do not have here a base?
>>>
>>> I think you want just basis point if this is V/V (already in common
>>> property suffixes)
>> Nice. I didn't know about -bp.   That does sound like a good choice for ratio
>> stuff and here would be 100x larger actual values which is fine.
>>
> 
> Yes, it would be, but the here it is 1000x larger than the
> actual value (1/1000 V/V). I don't see another unit in

Huh? How? 1000x larger would be = 1... This makes no sense...


> property-units.yaml for this specifc case. Maybe using -milli suffix
> like in 'adi,ad4000.yaml' and 'adi,ad7380.yaml'?


Best regards,
Krzysztof

