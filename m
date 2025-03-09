Return-Path: <linux-iio+bounces-16645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F697A587FD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 20:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C23C16B03A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0AB21A44E;
	Sun,  9 Mar 2025 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqTEi/uc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340F1DA109;
	Sun,  9 Mar 2025 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741550146; cv=none; b=pGyAEkmQ99fH5ldpt7uhNbkMd711eWQFBnMFOlP4fX3QbzOnIar/x4amJqaAddBLfS6jXU+q2f33hTkw99nrzxj2/pDUP/34d0+ZzF3hq2UJS5wYp37e/Asj+4iFE/sEbKkXgFSHhuWoBqIfe55aABGtmdGX7n3EilveIYovMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741550146; c=relaxed/simple;
	bh=zAPNcUFsX5MrJrlX6bLNUJsHyy42N48ffEZW73+2rUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifm6GTg2Z+OuNAbNSPR8qkdxM5i7EiYP4Ka0UX+wccYK0rP91fvg2d5DFBSgbrZKyMQgX/N7Mhm+buYObjzcB2Y1EC9QNJj/RysgoXYDiFJWhVMykboukBxYWNmB+hkD4e/pVHLpyZF8GrAi9kPGUydSe+uyYERl7QDAvBsWOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqTEi/uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7F6C4CEE3;
	Sun,  9 Mar 2025 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741550146;
	bh=zAPNcUFsX5MrJrlX6bLNUJsHyy42N48ffEZW73+2rUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JqTEi/uccPc2B7x4ifj3kLnrDXYgD3cQF7rNBNLDwcagkvL26TaEemWzJVflcHOxY
	 LJ0t9HR7PSsIaUyORMb3C2lRqAwFCMAiOIb0vgLjQvubvWupkyntj+wY2/uqLd4PMB
	 0ZPZJlWeBwMXr4O2CpK7Oqf1Vndw/UaiAecqMHv2hra0xZ6NGhB8BozYy1aCa+K3VY
	 T7pJTI5x8BiW/uI2+pG8lPfFHMYC/5isjtDvRtuUZlYYMvQQz3OnO+OiLzAFUneaeb
	 C843b9O7Qq3t4AZwOkEq5lcmvfSF46Alo7tUSSpYXmcJzcOrowTMOoZkATQa2bcot3
	 cFCXuz3yoP0VA==
Message-ID: <49d6bdfd-a2d3-48e6-aabc-e6674256e5a8@kernel.org>
Date: Sun, 9 Mar 2025 20:55:39 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] dt-bindings: iio: filter: Add lpf/hpf freq margins
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, bpellegrino@arka.org
References: <20250306183314.150253-1-sam.winchenbach@framepointer.org>
 <20250307-handsome-merry-alpaca-17da9f@krzk-bin>
 <Z8r45sR7uy0b4UEQ@65YTFL3.secure.tethers.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z8r45sR7uy0b4UEQ@65YTFL3.secure.tethers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2025 14:47, Sam Winchenbach wrote:
> On Fri, Mar 07, 2025 at 09:34:24AM +0100, Krzysztof Kozlowski wrote:
>> On Thu, Mar 06, 2025 at 01:33:09PM -0500, Sam Winchenbach wrote:
>>> Adds two properties to add a margin when automatically finding the
>>> corner frequencies.
>>>
>>> Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
>>> ---
>>>  .../bindings/iio/filter/adi,admv8818.yaml     | 23 +++++++++++++++++++
>>>  1 file changed, 23 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
>>> index b77e855bd594..3f9c61547a78 100644
>>> --- a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
>>> @@ -44,6 +44,27 @@ properties:
>>>    '#clock-cells':
>>>      const: 0
>>>  
>>> +
>>
>> Unnecessary blank line
>>
> 
> Noted for v6.
> 
>>> +  adi,lpf-margin-hz:
>>> +    description:
>>> +      Sets the minimum distance (in Hz) between the fundamental
>>> +      frequency of `rf_in` and the corner frequency of the low-pass, output
>>> +      filter when operatred in 'auto' mode. The selected low-pass corner
>>> +      frequency will be greater than, or equal to, `rf_in` + `lpf-margin-hz`. If
>>> +      not setting is found that satisfies this relationship the filter will be
>>> +      put into 'bypass'.
>>> +    default: 0
>>
>> hz are 32-bit, not 64-bit, so I think you need:
>>
>>   default: [0, 0]
>>   minItems: 2
>>   maxItems: 2
>>
> 
> I think I finally understand - "-hz" is a schema type defined as a uint32. 

No, it is uint32-array.

> Is that correct? I am really surprised that `dt_binding_check` did not complain about it being 64-bits.  I will update these to `-mhz` and make them uint32 in v6.

so your code worked fine, because it assumed you will pass two 32-bit
integers, so two items. That's why I proposed to define the number of
items, even though it looks odd, but that's result of 32-bit value.

Maybe we need "-hz-64" or "-64-hz" property suffix?

Best regards,
Krzysztof

