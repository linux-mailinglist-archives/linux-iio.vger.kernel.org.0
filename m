Return-Path: <linux-iio+bounces-7399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3584B929824
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 15:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD99282613
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BDA20319;
	Sun,  7 Jul 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF2AoR75"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106B18633;
	Sun,  7 Jul 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720359794; cv=none; b=cUkCgWVgmoFH6C4in9ZfN25JUA2EvxTtRJo19eS0tctka+74E802ZznI/lfHEcrreEZoj/1gbbok5qd+NHFVtyelGch2u8YJFZs4GEGsDjW50W8RwY3NMbuWZmQykb8Mkz9KGMIEL2Ys8hsH+Tbrjcyid+04UEGFJf29lclazqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720359794; c=relaxed/simple;
	bh=aXwoXeNGm49h5RebolLVRtRWyJWFXEBAany8IzYwsss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tmap4inuRtetAYNEHNT+xfOFwHOkbh8G+WeLOJGqMZSuLcl8k8tHnY2aVvusVIWZpbqcX2P7C2owsxbDEoyLCyAsZa+cJfdzUFco476cg4XpeW3I5L4x14kBAOPusZKx/YgKsSkjRwQ3lgJZy3t8qXAkl8U0ucMxhf50THKP3FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF2AoR75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922C2C3277B;
	Sun,  7 Jul 2024 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720359794;
	bh=aXwoXeNGm49h5RebolLVRtRWyJWFXEBAany8IzYwsss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PF2AoR753WUn/r6/yc2Jhs2aMnUQsvjZro1LOr8G1xDmVBoIXB3tB3VMLY6m3p6qt
	 h+BU04zuRTzROYtWUHbyLCsoVBm/LQu7NNeRLQ1Fput6ROlZA+IB7tyYLskkT/TiGQ
	 7oEii5yhvGY1CibJiaOSEUvw0+dwd9L3cMStLDLGD6hzH5rWrkYTynSk5K1yTodHkA
	 CvhYaDtzH+z+eOxGkgNxUVkJz1PvXoP3zeyfzouyJxK6SBpWh3OZHXUzxV+K4oNLbN
	 fngjDUhdRb9nnvJX3yeTU+7s5c4PCFQTVwtLkJYZBTNNOHmM+c2Z6JvlQzj/w43CDK
	 06i9s2ENtzboA==
Date: Sun, 7 Jul 2024 14:43:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shreeya Patel <shreeya.patel@collabora.com>, Marek Vasut
 <marex@denx.de>, linux-iio@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a
 compatible string
Message-ID: <20240707144306.7baa3f32@jic23-huawei>
In-Reply-To: <c0172272-88bd-44eb-94a6-40b5488e453a@kernel.org>
References: <20240705095047.90558-1-marex@denx.de>
	<3b2ca0-6687ce00-3-4dab7280@52083650>
	<13828cf9-4a93-45a5-b3a3-542ee9ec056b@denx.de>
	<3dd224-66883580-3-40d7c680@7066446>
	<20240707122620.7b3e6173@jic23-huawei>
	<c0172272-88bd-44eb-94a6-40b5488e453a@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Jul 2024 14:06:10 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 07/07/2024 13:26, Jonathan Cameron wrote:
> > On Fri, 05 Jul 2024 19:03:04 +0100
> > "Shreeya Patel" <shreeya.patel@collabora.com> wrote:
> >   
> >> On Friday, July 05, 2024 20:22 IST, Marek Vasut <marex@denx.de> wrote:
> >>  
> >>> On 7/5/24 12:42 PM, Shreeya Patel wrote:    
> >>>> On Friday, July 05, 2024 15:20 IST, Marek Vasut <marex@denx.de> wrote:
> >>>>     
> >>>>> The "ltr,ltrf216a" compatible string is not documented in DT binding
> >>>>> document, remove it.
> >>>>>
> >>>>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>>>> ---
> >>>>> Cc: Conor Dooley <conor+dt@kernel.org>
> >>>>> Cc: Jonathan Cameron <jic23@kernel.org>
> >>>>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> >>>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
> >>>>> Cc: Marek Vasut <marex@denx.de>
> >>>>> Cc: Rob Herring <robh@kernel.org>
> >>>>> Cc: Shreeya Patel <shreeya.patel@collabora.com>
> >>>>> Cc: devicetree@vger.kernel.org
> >>>>> Cc: linux-iio@vger.kernel.org
> >>>>> ---
> >>>>>   drivers/iio/light/ltrf216a.c | 1 -
> >>>>>   1 file changed, 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> >>>>> index 68dc48420a886..78fc910fcb18c 100644
> >>>>> --- a/drivers/iio/light/ltrf216a.c
> >>>>> +++ b/drivers/iio/light/ltrf216a.c
> >>>>> @@ -528,7 +528,6 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
> >>>>>   
> >>>>>   static const struct of_device_id ltrf216a_of_match[] = {
> >>>>>   	{ .compatible = "liteon,ltrf216a" },
> >>>>> -	{ .compatible = "ltr,ltrf216a" },
> >>>>>   	{}    
> >>>>
> >>>> This compatible string with a different vendor prefix was added for a specific reason.
> >>>> Please see the commit message of the following patch :-
> >>>> https://lore.kernel.org/all/20220511094024.175994-2-shreeya.patel@collabora.com/
> >>>>
> >>>> We were very well aware that not documenting this was going to generate a warning so
> >>>> we tried to fix that with a deprecated tag but it was NAKd by Rob. What we understood
> >>>> from his last message was that it wasn't necessary to fix the DT warning.    
> >>>
> >>>  From what I read in the aforementioned discussion thread, it seems Rob 
> >>> was very much opposed to this compatible string, so this shouldn't have 
> >>> gone in in the first place.
> >>>
> >>> But it did ... so the question is, what now ?    
> >>
> >> There were multiple versions sent for adding LTRF216A light sensor driver
> >> and this compatible string wasn't something that was accepted by mistake.
> >> Most of the versions of the patch series made it very clear that it generates a warning
> >> which you can check here :-
> >> https://lore.kernel.org/lkml/20220731173446.7400bfa8@jic23-huawei/T/#me55be502302d70424a85368c2645c89f860b7b40
> >>
> >> I would just go with whatever Jonathan decides to do here :)  
> > 
> > If it's needed for a released device (which is what Shreeya's linked thread suggests)  
> 
> Not entirely. The device was released EARLIER and they wanted to add
> support for ACPI or out-of-tree kernel for EARLIER releases.
> 
> Regression rule does not work like that.

> 
> > that we can't get the manufacturer to fix, we are stuck with that entry existing for ever.
> > No regressions rule applies.  
> 
> At the moment of posting their patch regression rule did not apply. Only
> now you could claim that Collabora's broken code is being part of ABI,
> even though it was explicitly NAKed.
> 

The problem is that I did take this patch.  So now it's a regression.

> So what does it mean for us? Collabora wants to add ABI, we NAK it, ABI
> sneaks in (happens) and now we are going to support that ABI?

I disagree and laid out why in the other branch of this thread so won't
repeat here.

> 
> So what incentive any company has to follow maintainers decision if they
> can sneak such stuff in and get away with it?

I may be misremembering but that wasn't how I interpreted things at the time.
I interpreted Rob's response in a much narrower way than you have.

> 
> > 
> > It would be helpful to have a specific reference to what that device is though.
> > When we've had this mess for horribly broken ACPI IDs that have gotten into devices
> > we try to add a comment on where they are known to exist.  I'd ideally like such
> > a comment added here.  
> 
> Sorry, I stand by decision from May 2022: this was NAKed by Rob and
> should have never been supported by kernel. We did not agree to support
> it. Will it affect users? Sure, Collabora's fault.

Fine, unless a consensus is clearly reached on this I'm not going to merge
this patch because I think it is an unfortunate fact of life that we should
endeavour to support consumer devices with the garbage we get handed in
consumer device ACPI tables because that's not a place we can force changes.

If I'm missing something about the background to this, then maybe it's a different
question.  Particularly if perhaps circumstances have changed and perhaps
the devices with this odd ACPI table are no longer relevant and we can drop
this as unnecessary.  I'd love that to be the case!

Jonathan

> 
> Best regards,
> Krzysztof
> 


