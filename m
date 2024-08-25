Return-Path: <linux-iio+bounces-8771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1D295E247
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2024 08:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A43282709
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2024 06:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95842AA0;
	Sun, 25 Aug 2024 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJuoVwSq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3158F48CCC;
	Sun, 25 Aug 2024 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724569062; cv=none; b=PulFUg0ilOErXh+oPAr+62xsZDCk/GGRIl4E/pYc5rOaJaZSNaNAizWx8sdrLDR74S2SbrHoWUPlSq81Paazzwt+oTJiBHl748Ma9mpJXH1bkvBFm4wkpmcmsbm/IXJVWn0vzbN/nyAFQoZhJ0TTNcdGA9nd9Vg6/30WD5Zh0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724569062; c=relaxed/simple;
	bh=LErsbjVHh/2RC4TzJkjoffgzZjjXdGkyTQ4ZdiQHAxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShKLBdA/mMu+fVikqiYuPTBJeGRSzaNBjFaFUAsC7PO0arKVpCCkAP9izPbME995HwQz6KkLcQSqUq1hc9ckJPBF2vafWzMHSytX+6+/2iKrrVw+QmTSMqfape+5AVBoWgryCgg+dudV+s6KIMSACapszaD188f6sCwJgTelrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJuoVwSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE36C32782;
	Sun, 25 Aug 2024 06:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724569061;
	bh=LErsbjVHh/2RC4TzJkjoffgzZjjXdGkyTQ4ZdiQHAxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FJuoVwSqKbrqpI8dt6tLIJiHK7NNGyg8gRNrbjtBSwShPZa9L3eJOQEwTbvhx6exE
	 dtst60Du/LPcxeYe500yRtdyAkBSugm0pGLsMnPAKpJLMeslyYOCrYYmqvGT6QPscI
	 j0EWLxvD+LSa1tANm3ALS90kTuqNArom3qDcmRDSutiQTFBQxKk8V6w2n3ClLXm8mK
	 XQLWf8FXstcB0+STb9Uc69RPvYJocXtALhJNtgl6pv/KDrLncJtt2tVOyYIB7vdHSt
	 Qxp8oGL6n55+4sgktwVyCQy+kkP4GTDZxMNQhXDd27ppZDB1nuC3McUHWn18TgXe8Q
	 Ifa3PDIS6+RmQ==
Message-ID: <1400d007-861d-432a-8fd6-a948556b5dcd@kernel.org>
Date: Sun, 25 Aug 2024 08:57:33 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add interrupts
 for BMP3xx and BMP5xx devices
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-6-vassilisamir@gmail.com>
 <7eqtnkkgnyskkmecv7dtiyzd6invdl7xa56cih6fbuuu2jrprx@s4jpi4ls6dxn>
 <20240824113511.GF9644@vamoiridPC>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240824113511.GF9644@vamoiridPC>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/08/2024 13:35, Vasileios Amoiridis wrote:
> On Sat, Aug 24, 2024 at 09:45:43AM +0200, Krzysztof Kozlowski wrote:
>> On Fri, Aug 23, 2024 at 08:17:12PM +0200, Vasileios Amoiridis wrote:
>>> Add interrupt options for BMP3xx and BMP5xx devices as well.
>>>
>>> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/iio/pressure/bmp085.yaml | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
>>> index 6fda887ee9d4..eb1e1ab3dd18 100644
>>> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
>>> @@ -48,9 +48,14 @@ properties:
>>>  
>>>    interrupts:
>>>      description:
>>> -      interrupt mapping for IRQ (BMP085 only)
>>> +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
>>
>> Supported by driver or device?
>> If the latter, this should be constrained per device variant in
>> allOf:if:then:.
>>
> 
> Hi Krzysztof,
> 
> Supported by some devices controlled by the same (just 1) driver.
> Thanks for the hint, I will take a look how other drivers do it :)
> 
>>
>>>      maxItems: 1
>>>  
>>> +  drive-open-drain:
>>
>> Missing type, unless some other core schema defined it? But then I
>> actually wonder if we need it.  Maybe this should be interrupt flag?
>> Just like GPIO has such.
> 
> I took it from the bindings/iio/imu/bosch,bmi323.yaml example which is
> the same. You think something needs to change?
> 

You need type: boolean.

Best regards,
Krzysztof


