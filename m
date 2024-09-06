Return-Path: <linux-iio+bounces-9251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8335196F981
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 18:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A591F22255
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 16:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B44A1D4167;
	Fri,  6 Sep 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRlCGNss"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192A1D4145;
	Fri,  6 Sep 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640991; cv=none; b=r8Kf8OVu6yBXPebUsFf5mQi37NogwsprstxwNTeb3/sGPFMbwjbtIZJHnIsY2uv0zIMTv/0BhSZ3jm31yDJajRZwQY6POBmWjvxdf8hW746f2Kyjg3TWLXwuRuaR0NHhJ1jm3odipedi9ITQl1IBK4RwJWmt3C5S78Src+Fk6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640991; c=relaxed/simple;
	bh=+2DeN+MyH/TfQZn0o3mVMo6P9rQy8HSh4KTpNhlZYFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxP3XLU3RkxG51m8I6yuFszjxP6Hs/oYr+9lnj31XHmhpoGLzmwv/4pbXQtso8zwZrHqjmh+pdMPwEConu4EE/O1SMOU4IxsRSuzkO06q+kcWBjakQvW4lYywlJoPM+NJrGIPG64Jz83n/DMvF+5sDPBZH2882IUu42h1Ni2mnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRlCGNss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A021AC4CEC4;
	Fri,  6 Sep 2024 16:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725640990;
	bh=+2DeN+MyH/TfQZn0o3mVMo6P9rQy8HSh4KTpNhlZYFk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dRlCGNssMfVnAD36Uu7/nDosW6FiwvKDAS8gv9dU6PIxKTsGc1etMZIRi7GWFEI1x
	 FGGAfHtDenHS8YRm+xoXqzTqPGaiSV21N6pxLw3AgiTh+NcGZT90BBnil3XqHJ+ZSL
	 bUuXW0QjvORGcohXn2EAN0dgI71F4S/gNsIXeUC4fiywyHA/hR0m8YKy7N1Vr2vR4q
	 ETzNFgoGdgFS0Jo+YBUB2OBZc6vHWKep1cxG89ZrcqTMtfT06CwJZLGSQLnym4bovF
	 4pkMOInXPWYS3Q8X2sMiCooc4J9mnAFN6zMWUh2PNoWjm9f/OMRfQLtJjlUpM7EH5/
	 vu4VmHoPinQwQ==
Message-ID: <8079f10b-8a20-467e-bdb4-504f201bd0f8@kernel.org>
Date: Fri, 6 Sep 2024 18:43:02 +0200
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
 Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com>
 <boahpvyzzmocnnpae2u6meub34yvqr2q3v5pzf2egp2fretlwk@ibas62hdypwo>
 <fd3f4874-b410-4e98-acba-d0fac041a40e@baylibre.com>
 <1928d0ce-cad9-4737-880e-3759c47fddbc@kernel.org>
 <058937fa93d484f3e81807d08a39bd8dfd3358e8.camel@gmail.com>
 <47c56239-51a0-4ff2-9db2-0e0184cfb086@kernel.org>
 <a0d213442b4de0b06991be2be1d7b2bb091f2b52.camel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <a0d213442b4de0b06991be2be1d7b2bb091f2b52.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/09/2024 15:52, Nuno Sá wrote:
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

I don't understand: what are the bindings for the device itself? What is
this patch/binding if not device itself?

> 
>> If ad3552 is something else, then the order of naming is not correct.
>> Product name is always the first.
>>
>>
>>> generic axi-adc). And in this design the IP is also acting as a qspi controller
>>> for
>>> actually controlling the configuration of the device while, typically, IIO
>>> backends
>>> are meant to only care about the dataplane. With all of this, there are
>>> discussions
>>> still happening on the RFC (Angelo was too fast with this version) between using
>>> different properties or new compatibles for changes so significant like this on
>>> the
>>> generic IP. See the thread where Conor is also involved.
>>
>> 1. Then what does it mean for "adi,axi-dac-9.1.b"?
>>
> 
> IIUC, it means that the generic IP cannot really be used with the ad3552r DAC given
> the qspi specific bits.

ok

> 
>> 2. Is there any real customer product which uses this compatible alone?
>>
> 
> Yes, we do have devices that can work with the generic IP.

Where are they? There is nothing in the upstream, so maybe that's just
misconfigured downstream DTS?

Or maybe these are just some sort of IP core designs which cannot be
used in real case alone/directly.

> 
>> If you need to come up with customized compatibles, it means versioned
>> one is not enough.
>>
> 
> Note this was something that was suggested to Angelo. There's also the option to just
> use typical FW properties like the original RFC to describe the HW changes in the IP.
> But Conor made some good points on using different compatibles when changes go this
> far as being also a bus controller...
> 
>> If this is 9.1.b but not usable as 9.1.b ("for changes so significant
>> like this on"), then I claim 9.1.b compatible is useless.
>>
> 
> The 9.1.b versioning refers to the generic IP version and the custom design for
> interfacing with the ad3552r DAC is also based on that version of the generic IP. It
> already happened (for non upstream versions of the IP) for the HW folks to increase
> the versioning (major) of the generic IP with some breaking change and then new
> designs will be based on the newer version. On the driver we use the major number to
> detect mismatches between driver expectations and what we really have in HW.
> 
>>>
>>>> Third, versions are useless if you do not use them as fallbacks.
>>>>
>>>
>>> In this particular case we can't use the generic IP as a fallback since without
>>> the
>>> bus controller feature the device can't really work. But it can happen we
>>> increase
>>> the version on the generic core and use the existing version as fallback 
>>>
>>>> Something this is really broken and I don't know if the binding or this
>>>> patch.
>>>
>>> Having said the above, I'm really not sure if what we have is the best approach
>>> but
>>> these are also early days (upstream) for this so we should still be able to
>>> change
>>> things if we need too. I'm fairly sure there's still no one relying on this so we
>>> should be able to change things in a breaking way (if we need to be that
>>> extreme).
>>
>> DT maintainers consistently (before someone here calls me inconsistent)
>> propose not to use versioned compatibles if they map one-to-one to
>> products or if they cannot be used alone. Several generic IP blocks like
>> Synopsys or Cadence, match the latter - the customization from customer
>> is needed, thus snps/cdns IP-block compatible is not usable.
>>
> 
> Given what you're saying above (and IIUC) one thing I can see we doing would be to
> forget about the version and assume the generic compatible cannot be used alone (so
> adi,axi-dac). I mean, it always has to connect to real device. So we could use the
> device name in the compatible and code the expected version for that project (instead
> of being part of the compatible name). I guess it's similar on what's happening on
> the macb driver? But in that case we do have a cdns,macb compatible that can be used
> alone I think.
> 
> Only problem I could see with this is that if we have a project adi,axi-foo based on
> version 9.1.b and then HW folks move on and introduce 10.0.a and re-do axi-foo on top
> of the new core version. Would it then be ok to come up with a compatible like axi-
> foo-v2 or axi-foo-10-0-a?
> 
> Not sure if any of the above makes much sense...

None of above make sense because they are again versioned or generic.
Use final product names, assuming they are such.

Best regards,
Krzysztof


