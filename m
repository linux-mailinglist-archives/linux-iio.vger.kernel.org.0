Return-Path: <linux-iio+bounces-7395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658079297BE
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 14:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB23B20F07
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 12:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091021CA96;
	Sun,  7 Jul 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxjgU4kh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB66FBE;
	Sun,  7 Jul 2024 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720353976; cv=none; b=bCsnbbIf4c2tVApcar8soXWcbitAz4LCZK19+h7PP1MEGJIh3Lu6seGW4kVTctrPX/aKgj5k4ZjaMt/kXLtrv9rHVhuRW6IMfdhFzBscEOv/7TlLJO2n5QuJMvqxhSWtS44lu0dnjs+6ihKQthvdUMm2ZuU4PHikcowWL271g8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720353976; c=relaxed/simple;
	bh=00bQCX7YO7qb1Gb+6Z0Zr2Nmihjx2XaZ13Cm1h+5edE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbbfGdXIfbV69zDZw/bWHbiZvz+SfjpHA9/v6R+UFkKz37H4Sh4XTYRwosjNgMv9cA81ygK13BgFLy98scwwhv0yTEvaIvgp1AIz8nQeYYJHvzn67xckuwC6AeSctzIsElkiprjj9lMVfclGSWgU4EhcbJk7VggNWsxVB1mUis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxjgU4kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933C8C3277B;
	Sun,  7 Jul 2024 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720353976;
	bh=00bQCX7YO7qb1Gb+6Z0Zr2Nmihjx2XaZ13Cm1h+5edE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BxjgU4khwD+iodFdePlbg1hT8cmkFuiaMVgj9W1TF1xK3ZaUZQQngnROYdxKIp83t
	 9bLNZPwGMAtLE1Lon+J2U1jIxmdgxfsDtOBx2g9jes6MuW6fDQFTXOH8GYZ+SrvsU2
	 C6Nw/qEzEHPqGJg1b2E6K1tG/aiS94TbM+J1fR00DevEqOQ3GObQiw3UfD+n3pHTKR
	 GUkPUOjdlvxH2kHZPEERwP5geJjs4jJ78ZGD7Z/U6v4GU+lXA4Ku8ddKzXwQxk2oRt
	 cIIGf8FXVavharx4Z73M7hZdRs3LzR7c7U2mx0NnfAkxKYdjVIAGUh8y3U16nQzSVw
	 H87NZt5aollzw==
Message-ID: <c0172272-88bd-44eb-94a6-40b5488e453a@kernel.org>
Date: Sun, 7 Jul 2024 14:06:10 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a
 compatible string
To: Jonathan Cameron <jic23@kernel.org>,
 Shreeya Patel <shreeya.patel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 kernel@collabora.com
References: <20240705095047.90558-1-marex@denx.de>
 <3b2ca0-6687ce00-3-4dab7280@52083650>
 <13828cf9-4a93-45a5-b3a3-542ee9ec056b@denx.de>
 <3dd224-66883580-3-40d7c680@7066446> <20240707122620.7b3e6173@jic23-huawei>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240707122620.7b3e6173@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/07/2024 13:26, Jonathan Cameron wrote:
> On Fri, 05 Jul 2024 19:03:04 +0100
> "Shreeya Patel" <shreeya.patel@collabora.com> wrote:
> 
>> On Friday, July 05, 2024 20:22 IST, Marek Vasut <marex@denx.de> wrote:
>>
>>> On 7/5/24 12:42 PM, Shreeya Patel wrote:  
>>>> On Friday, July 05, 2024 15:20 IST, Marek Vasut <marex@denx.de> wrote:
>>>>   
>>>>> The "ltr,ltrf216a" compatible string is not documented in DT binding
>>>>> document, remove it.
>>>>>
>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>> ---
>>>>> Cc: Conor Dooley <conor+dt@kernel.org>
>>>>> Cc: Jonathan Cameron <jic23@kernel.org>
>>>>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>>>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>>>>> Cc: Marek Vasut <marex@denx.de>
>>>>> Cc: Rob Herring <robh@kernel.org>
>>>>> Cc: Shreeya Patel <shreeya.patel@collabora.com>
>>>>> Cc: devicetree@vger.kernel.org
>>>>> Cc: linux-iio@vger.kernel.org
>>>>> ---
>>>>>   drivers/iio/light/ltrf216a.c | 1 -
>>>>>   1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
>>>>> index 68dc48420a886..78fc910fcb18c 100644
>>>>> --- a/drivers/iio/light/ltrf216a.c
>>>>> +++ b/drivers/iio/light/ltrf216a.c
>>>>> @@ -528,7 +528,6 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
>>>>>   
>>>>>   static const struct of_device_id ltrf216a_of_match[] = {
>>>>>   	{ .compatible = "liteon,ltrf216a" },
>>>>> -	{ .compatible = "ltr,ltrf216a" },
>>>>>   	{}  
>>>>
>>>> This compatible string with a different vendor prefix was added for a specific reason.
>>>> Please see the commit message of the following patch :-
>>>> https://lore.kernel.org/all/20220511094024.175994-2-shreeya.patel@collabora.com/
>>>>
>>>> We were very well aware that not documenting this was going to generate a warning so
>>>> we tried to fix that with a deprecated tag but it was NAKd by Rob. What we understood
>>>> from his last message was that it wasn't necessary to fix the DT warning.  
>>>
>>>  From what I read in the aforementioned discussion thread, it seems Rob 
>>> was very much opposed to this compatible string, so this shouldn't have 
>>> gone in in the first place.
>>>
>>> But it did ... so the question is, what now ?  
>>
>> There were multiple versions sent for adding LTRF216A light sensor driver
>> and this compatible string wasn't something that was accepted by mistake.
>> Most of the versions of the patch series made it very clear that it generates a warning
>> which you can check here :-
>> https://lore.kernel.org/lkml/20220731173446.7400bfa8@jic23-huawei/T/#me55be502302d70424a85368c2645c89f860b7b40
>>
>> I would just go with whatever Jonathan decides to do here :)
> 
> If it's needed for a released device (which is what Shreeya's linked thread suggests)

Not entirely. The device was released EARLIER and they wanted to add
support for ACPI or out-of-tree kernel for EARLIER releases.

Regression rule does not work like that.

> that we can't get the manufacturer to fix, we are stuck with that entry existing for ever.
> No regressions rule applies.

At the moment of posting their patch regression rule did not apply. Only
now you could claim that Collabora's broken code is being part of ABI,
even though it was explicitly NAKed.

So what does it mean for us? Collabora wants to add ABI, we NAK it, ABI
sneaks in (happens) and now we are going to support that ABI?

So what incentive any company has to follow maintainers decision if they
can sneak such stuff in and get away with it?

> 
> It would be helpful to have a specific reference to what that device is though.
> When we've had this mess for horribly broken ACPI IDs that have gotten into devices
> we try to add a comment on where they are known to exist.  I'd ideally like such
> a comment added here.

Sorry, I stand by decision from May 2022: this was NAKed by Rob and
should have never been supported by kernel. We did not agree to support
it. Will it affect users? Sure, Collabora's fault.

Best regards,
Krzysztof


