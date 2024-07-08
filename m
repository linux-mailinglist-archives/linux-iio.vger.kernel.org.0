Return-Path: <linux-iio+bounces-7431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC192A0FC
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 13:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C791C21069
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 11:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBE97C6D4;
	Mon,  8 Jul 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVgYVGuZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D27A715;
	Mon,  8 Jul 2024 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437916; cv=none; b=dH5PX5S1lq5j7cJpthqb5CjTlWsVUu1T5EVNsSC1zXyHWN0qVRZH0GmGLhSps4c2Y6mDk7Ai49XMCV7+mvolviKhxSy8c6ljQIhL9KFv+Q1lDtoVUg2Bph5LRh+xGWcZqmyheY+8Cy5vdV9A/mkvWhC7FxIBNqMUrYBRCuItDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437916; c=relaxed/simple;
	bh=QrRKS+3iDLmeUQXoJ08zl803lCFnPF6mGpqzE/kCciM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gO7OLzI4XPeXHVN/AXVPpGvCoCqSY9QetHbKKGGptsPVYH9ouffftafY2qODZnLJX0bcpCJp1Ofj8Dx/tVmPCDBq0WhLIQ965H/gwvrazjGCx1spB0+jh56e48pGb7h++JrnBcGwpJcOB/0lipNR2PH2d8xzosjBhzppM5CniLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVgYVGuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14618C116B1;
	Mon,  8 Jul 2024 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720437915;
	bh=QrRKS+3iDLmeUQXoJ08zl803lCFnPF6mGpqzE/kCciM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iVgYVGuZrT8xc/2wXlg8hJItfn6ClJ+teYVEIKdMnaBLPYy6a7tLXsUTZRxiBO0+Q
	 r68K5aqcr98hIMiskn1icNuBVabKB5XrACs3kIUntnVCWC19vl8/GkGP8AchpDPljw
	 utrZ+Cxtd0oD0Azd3wEpPufRihBIriwJGHQeSkJin6AtG5ylndqdyo6ZaMsAjtC2Xs
	 WZsOzvoIeVSBCUxKvpzCegyuU7tDRhtz2tc0SqkgfFcFctn6vbFKE8cNLVfy4pAtJq
	 wfqOjybf6SiEAai/ZroxnHAi87jqqtfzCMgPbGDMfU2bq00AZ8etLh/dobUxJMsJPo
	 UN0AAGA8+c6FQ==
Message-ID: <9db672d4-a305-45ed-95f1-402c70a15379@kernel.org>
Date: Mon, 8 Jul 2024 13:25:10 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a
 compatible string
To: Jonathan Cameron <jic23@kernel.org>
Cc: Shreeya Patel <shreeya.patel@collabora.com>, Marek Vasut <marex@denx.de>,
 linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240705095047.90558-1-marex@denx.de>
 <3b2ca0-6687ce00-3-4dab7280@52083650>
 <98992b1d-c94a-4053-a755-32a25d7fdc46@kernel.org>
 <20240707143759.7718e0f3@jic23-huawei>
 <1effec8c-8228-482b-b476-06838128adfa@kernel.org>
 <20240707150835.40db1897@jic23-huawei>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240707150835.40db1897@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/07/2024 16:08, Jonathan Cameron wrote:
>>
>>>   
>>>>>
>>>>> We were very well aware that not documenting this was going to generate a warning so    
>>>>
>>>> You *CANNOT* have undocumented compatibles.  
>>>
>>> Why not? This corner case is a valid reason for that to be allowed.
>>> You cannot use that compatible with DT bindings.  Absolutely.  The compatible
>>> has other uses...  
>>
>> Okay. With that approach what stops anyone from submitting DTS using
>> that compatible (claiming there is a driver for that compatible)?
> 
> That's a good point.  Perhaps we should just add a check for this?
> Easy to add a check on the firmware type. This is a rare enough case that
> just doing it in the driver seems fine to me (rather than more general
> infrastructure).

Another point of slippery slope:
1. We accept such undocumented compatible in OF device id for ACPI
(PRP0001).
2. Out-of-tree DTS uses it.
3. Whatever we decide to do now with that compatible, we have
undocumented ABI exposed and used by users.

That's the answer why we cannot have undocumented compatibles: because
we do not want to have implicit ABI. We want explicit ABI, which is:
1. Clearly documented,
2. Reviewed/accepted explicitly.


> 
>>
>>>
>>>   
>>>>  
>>>>> we tried to fix that with a deprecated tag but it was NAKd by Rob. What we understood    
>>>>
>>>> Because the driver was NAKed obviously as well.
>>>>  
>>>>> from his last message was that it wasn't necessary to fix the DT warning.    
>>>>
>>>> I am quite angry that maintainer tells you something, but you push your
>>>> patch through because apparently you need to fulfill your project
>>>> requirements.  
>>>
>>> I think this is a fundamental misunderstanding of the situation and probably
>>> at least partly my fault for not clarifying my reading of the situation more
>>> fully at the time.
>>>
>>> As far as I am concerned. The situation is:
>>> 1) Existing shipping consumer device.  We have 100s of cases of ACPI bindings
>>>    that exist just to deal with garbage firmware's.  The folk involved in
>>>    reviewing these have pushed back hard for a long time, but sadly there
>>>    is still a lot of garbage shipping because Windows lets it through and
>>>    Linux support comes second.  It's made even worse by Microsoft defining
>>>    their own standards that aren't compliant with ACPI as they don't
>>>    even bother with reserving the methods IDs.  ROTM for example.  
>>
>> Hm, and these devices do not provide normal ACPI IDs? They use Of-like
>> ones? I don't know that much about ACPI, but aren't they coming without
>> vendor prefix thus "ltr,ltrf216a" is just wrong and should be "lTRF216A"
>> alone?
> 
> Yes, they come with the ID that is matched on by the ACPI core as PRP0001
> which basically means use the DT compatible.
> Then a device specific property that provides 'compatible' to look up against.
> The intent being to allow use of existing drivers without needing to modify
> them to add ACPI IDs to match against. 
> 
> LTRF216A is worse than using PRP0001 and DT vendor ID
> ACPI has it's own equivalent of vendor IDs and you have to apply for one from
> relevant committee in the UEFI forum (ASWG)
> https://uefi.org/ACPI_ID_List
> (there is a 3 letter form as well).
> It's easy to get an ID (takes a few weeks though) but many sensor companies
> etc don't bother.  Sometimes they say it's because the OEMs should do this
> and sometimes those OEMs do, so the binding is under their vendor not the
> device manufacturer.  That's when you see what looks like completely unrelated
> IDs being used.
> 
> It would be good it liteon got a proper ID and started issuing device numbers
> to go with it though.
> 
> There are a lot of old bindings that make IDs up. Some are based on cut and paste
> and we've been trying to scrub those, others are based on what Windows drivers
> bind against and so we are stuck with that set.
> For extra fun we have examples of hardware with a common ID for incompatible
> devices for which we have different drivers.  That's a real pain when it happens
> but a few sensor manufacturers have 'one windows driver' for many years worth
> of unrelated devices and use horrible matching routines to figure out what is
> actually there...).

BTW, I really miss the information what sort of users they have for that
compatible. The explanation was vague. What are the "released devices"?
What ACPI tables do they have?


Best regards,
Krzysztof


