Return-Path: <linux-iio+bounces-7400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D911292982D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 15:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F03128262F
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 13:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5861F934;
	Sun,  7 Jul 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4x7KCEf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1581DFCF;
	Sun,  7 Jul 2024 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720359993; cv=none; b=cHSCR44emYXEAE41zOKKVTmbJ/lWU2vVzKcxvTQVn/idnNqYNZaaJOHuijEnRwZEahVZlP7Uf2k6aDMOtSMXFpJQR8y5X/nrOWSxjO5QFn+3ieDGnZZZ9WpdptgZzyHKkbOr12r+txY3WplMsh1JvetRbGqBr8HPvDWAoQ9Bflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720359993; c=relaxed/simple;
	bh=Y437p0HGRDsAVaKsfAQqNXmB45o3QlMcBmIPWaMOEfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdS1AuFmlMGVhzmwrcf4EDwpIPj5CidUJtjh7CZQ8fGQ4o9gdSFJQAdbhEeAAWTZp9ZT0FBqJadfSQKrWQvfgnCeotnRITY4P1j56JAdsSkv3j1wbbK97Ae1YwI1vD4km3+7juKYXjADFEdhxzk/gglheIqrVGKrCKdsnZDoIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4x7KCEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEC6C3277B;
	Sun,  7 Jul 2024 13:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720359992;
	bh=Y437p0HGRDsAVaKsfAQqNXmB45o3QlMcBmIPWaMOEfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R4x7KCEfnS+ZPUKH3fExtdsl5qVqoHNd/RuiwoePaLFah1Lun8Yb2y3I8IKB9Sx3p
	 azIWOTOxu154ZXN9mO0ZSoUYj+I0UO0DN3MEiYx+0sSU8EV6iyD29r6DIIT3kSrdsP
	 VSm4IWoPc3aKvuPplwnxbDlXvj1Lh9VyO35Nxdopx003jgzSxvoRJNCYVBFCsdTIdK
	 r8JPOpGRS7EEELsSgx2kADffP4w7YVrQlPL2tQkY950YbvyLhV7DAW78aHUXBh6S/i
	 Q8ehQGBdf2P5BQHiGJh5kHa9uAbh2h0U0NHD6iuI/nM5gu+yYITB/ufVJdxBIqY0h9
	 n0436Gn5AByrQ==
Message-ID: <1effec8c-8228-482b-b476-06838128adfa@kernel.org>
Date: Sun, 7 Jul 2024 15:46:26 +0200
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240707143759.7718e0f3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/07/2024 15:37, Jonathan Cameron wrote:
> On Sun, 7 Jul 2024 14:02:39 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 05/07/2024 12:42, Shreeya Patel wrote:
>>> On Friday, July 05, 2024 15:20 IST, Marek Vasut <marex@denx.de> wrote:
>>>   
>>>> The "ltr,ltrf216a" compatible string is not documented in DT binding
>>>> document, remove it.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> ---
>>>> Cc: Conor Dooley <conor+dt@kernel.org>
>>>> Cc: Jonathan Cameron <jic23@kernel.org>
>>>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>>>> Cc: Marek Vasut <marex@denx.de>
>>>> Cc: Rob Herring <robh@kernel.org>
>>>> Cc: Shreeya Patel <shreeya.patel@collabora.com>
>>>> Cc: devicetree@vger.kernel.org
>>>> Cc: linux-iio@vger.kernel.org
>>>> ---
>>>>  drivers/iio/light/ltrf216a.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
>>>> index 68dc48420a886..78fc910fcb18c 100644
>>>> --- a/drivers/iio/light/ltrf216a.c
>>>> +++ b/drivers/iio/light/ltrf216a.c
>>>> @@ -528,7 +528,6 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
>>>>  
>>>>  static const struct of_device_id ltrf216a_of_match[] = {
>>>>  	{ .compatible = "liteon,ltrf216a" },
>>>> -	{ .compatible = "ltr,ltrf216a" },
>>>>  	{}  
>>>
>>> This compatible string with a different vendor prefix was added for a specific reason.
>>> Please see the commit message of the following patch :-
>>> https://lore.kernel.org/all/20220511094024.175994-2-shreeya.patel@collabora.com/  
>>
>> And adding this specific compatible was clearly NAKed:
>> https://lore.kernel.org/all/20220516170406.GB2825626-robh@kernel.org/
>>
>> yet you still added it. That's a deliberate going around maintainer's
>> decision.
>>
> 
> The statement from Rob was very specific. The schema is not applicable to ACPI bindings
> - that's the basis on which he doesn't want this in the schema. Specifically
> because "There's not really any point in having this in schema as you can't
> use that schema with ACPI".
> 
> That is true (though arguably you could with sufficient tooling apply the schema
> to the relevant part of DSDT).
> 
> The compatible is usable, via PRP0001 ACPI IDs.

Uh, that's sounds like a slippery slope. To my understanding, PRP0001
allows to create ACPI IDs from OF IDs, so it requires to have a valid OF
ID. Valid OF ID requires bindings, doesn't it?

If it does not, then anyone can add any Devicetree properties, claiming
it is for ACPI ID thus not providing bindings (or bypassing bindings
review / NAK).

> 
>>>
>>> We were very well aware that not documenting this was going to generate a warning so  
>>
>> You *CANNOT* have undocumented compatibles.
> 
> Why not? This corner case is a valid reason for that to be allowed.
> You cannot use that compatible with DT bindings.  Absolutely.  The compatible
> has other uses...

Okay. With that approach what stops anyone from submitting DTS using
that compatible (claiming there is a driver for that compatible)?

> 
> 
>>
>>> we tried to fix that with a deprecated tag but it was NAKd by Rob. What we understood  
>>
>> Because the driver was NAKed obviously as well.
>>
>>> from his last message was that it wasn't necessary to fix the DT warning.  
>>
>> I am quite angry that maintainer tells you something, but you push your
>> patch through because apparently you need to fulfill your project
>> requirements.
> 
> I think this is a fundamental misunderstanding of the situation and probably
> at least partly my fault for not clarifying my reading of the situation more
> fully at the time.
> 
> As far as I am concerned. The situation is:
> 1) Existing shipping consumer device.  We have 100s of cases of ACPI bindings
>    that exist just to deal with garbage firmware's.  The folk involved in
>    reviewing these have pushed back hard for a long time, but sadly there
>    is still a lot of garbage shipping because Windows lets it through and
>    Linux support comes second.  It's made even worse by Microsoft defining
>    their own standards that aren't compliant with ACPI as they don't
>    even bother with reserving the methods IDs.  ROTM for example.

Hm, and these devices do not provide normal ACPI IDs? They use Of-like
ones? I don't know that much about ACPI, but aren't they coming without
vendor prefix thus "ltr,ltrf216a" is just wrong and should be "lTRF216A"
alone?

> 
> 2) This is an ACPI binding, it just happens to use a DT compatible via the
>    PRP0001 mechanism.  Yes, we strongly discourage people doing that in
>    shipping products but there have been other cases of it.

OK, is this the case here?

> 
> 3) Shreeya read a distinction (that I also agree with) between the schema
>    and the compatible list.  The schema does not apply to this situation
>    (because we can't actually check it today for DSDT) hence Rob's Nack
>    was making the point it was inappropriate to carry it there.
> 
> So, I don't see this as a deliberate attempt to bypass a maintainer Nack.
> I'd love to be in a position to say no on ACPI bindings that are garbage
> (there are a lot of them) but Windows is dominant in that space so
> we get stuck with their mess.  On server's it is a different game
> and the kernel community regularly gets significant changes made.

Original discussion had only vague statement of "vendor prefix name as
'ltr' through ACPI". But what does it even mean? What ACPI ID is
reported by these devices?

Best regards,
Krzysztof


