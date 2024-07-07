Return-Path: <linux-iio+bounces-7402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2112A929850
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 16:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445081C20912
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540042261D;
	Sun,  7 Jul 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAWScSYi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCE7210EC;
	Sun,  7 Jul 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720361325; cv=none; b=nVYD2B6GsUYDISvJUqyA5d+UxvpG3ZCXG7pkONwYFmjR6RWb2vNWAmfbLDhuKxMSyPXwybSCDCPcS5cYcamJwtx5a0UU/iyTaKJtf4EaaWpnNCBC50+aKvDggms9UaVTXBk4TGpBu7gL6G6qwYSHcWMOC98zMfuGtRUUN9KDcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720361325; c=relaxed/simple;
	bh=APb3owfajHa58YxU2rbCOFM9wWI5gLvEEkczPG6ODMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iehj0GOoeg3O1HQD16Kzqspf4tU4/H1yRqAmn5p4g46uTSOuyB+BMbxTxLeDRJZcmXRNtVBotzrTFRyp2S9wKXDEbEURRO8Hlqgb5tznDtdkVHspB23XpOqzV7vUKF65QXdBdrLcfoe2aPzEHFYlJ3ngw+YMRy/S0XDG3X970no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAWScSYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94926C3277B;
	Sun,  7 Jul 2024 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720361324;
	bh=APb3owfajHa58YxU2rbCOFM9wWI5gLvEEkczPG6ODMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sAWScSYigeBrdu9EN9cWmEpdZit0udrI4+eYu58oa6Nk/wZx8Q2OmTaZH9DzkOUpf
	 pc4y0XGP3pDitK6TR9WPJfITJEiMW007MCSgRDRFFrU0obOSJDJWGJIE+A2DSZ9GKP
	 DmCF6ZjnzBuIBNtlEVjXyKeBBfN9XZLmvMfbXBu/hbKcpSPhuFhbqEzo1YMVL1Z6i8
	 RAsCI8Wq9mOkcaWlzsD8gGRuYN5SB+uogqcz1vWLwSUPtMJh5zqA9yPkjgVTlyrlvh
	 SfpBwzL92CeqXMVjDhoH1PrKN2yZvZS9isKt1eRLb0XKFC1BnNmmNuRorutINclEM7
	 pnitb4bYEa2ig==
Date: Sun, 7 Jul 2024 15:08:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shreeya Patel <shreeya.patel@collabora.com>, Marek Vasut
 <marex@denx.de>, linux-iio@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, kernel@collabora.com, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a
 compatible string
Message-ID: <20240707150835.40db1897@jic23-huawei>
In-Reply-To: <1effec8c-8228-482b-b476-06838128adfa@kernel.org>
References: <20240705095047.90558-1-marex@denx.de>
	<3b2ca0-6687ce00-3-4dab7280@52083650>
	<98992b1d-c94a-4053-a755-32a25d7fdc46@kernel.org>
	<20240707143759.7718e0f3@jic23-huawei>
	<1effec8c-8228-482b-b476-06838128adfa@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Jul 2024 15:46:26 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 07/07/2024 15:37, Jonathan Cameron wrote:
> > On Sun, 7 Jul 2024 14:02:39 +0200
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >   
> >> On 05/07/2024 12:42, Shreeya Patel wrote:  
> >>> On Friday, July 05, 2024 15:20 IST, Marek Vasut <marex@denx.de> wrote:
> >>>     
> >>>> The "ltr,ltrf216a" compatible string is not documented in DT binding
> >>>> document, remove it.
> >>>>
> >>>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>>> ---
> >>>> Cc: Conor Dooley <conor+dt@kernel.org>
> >>>> Cc: Jonathan Cameron <jic23@kernel.org>
> >>>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> >>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
> >>>> Cc: Marek Vasut <marex@denx.de>
> >>>> Cc: Rob Herring <robh@kernel.org>
> >>>> Cc: Shreeya Patel <shreeya.patel@collabora.com>
> >>>> Cc: devicetree@vger.kernel.org
> >>>> Cc: linux-iio@vger.kernel.org
> >>>> ---
> >>>>  drivers/iio/light/ltrf216a.c | 1 -
> >>>>  1 file changed, 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> >>>> index 68dc48420a886..78fc910fcb18c 100644
> >>>> --- a/drivers/iio/light/ltrf216a.c
> >>>> +++ b/drivers/iio/light/ltrf216a.c
> >>>> @@ -528,7 +528,6 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
> >>>>  
> >>>>  static const struct of_device_id ltrf216a_of_match[] = {
> >>>>  	{ .compatible = "liteon,ltrf216a" },
> >>>> -	{ .compatible = "ltr,ltrf216a" },
> >>>>  	{}    
> >>>
> >>> This compatible string with a different vendor prefix was added for a specific reason.
> >>> Please see the commit message of the following patch :-
> >>> https://lore.kernel.org/all/20220511094024.175994-2-shreeya.patel@collabora.com/    
> >>
> >> And adding this specific compatible was clearly NAKed:
> >> https://lore.kernel.org/all/20220516170406.GB2825626-robh@kernel.org/
> >>
> >> yet you still added it. That's a deliberate going around maintainer's
> >> decision.
> >>  
> > 
> > The statement from Rob was very specific. The schema is not applicable to ACPI bindings
> > - that's the basis on which he doesn't want this in the schema. Specifically
> > because "There's not really any point in having this in schema as you can't
> > use that schema with ACPI".
> > 
> > That is true (though arguably you could with sufficient tooling apply the schema
> > to the relevant part of DSDT).
> > 
> > The compatible is usable, via PRP0001 ACPI IDs.  
> 
> Uh, that's sounds like a slippery slope. To my understanding, PRP0001
> allows to create ACPI IDs from OF IDs, so it requires to have a valid OF
> ID. Valid OF ID requires bindings, doesn't it?
> 
> If it does not, then anyone can add any Devicetree properties, claiming
> it is for ACPI ID thus not providing bindings (or bypassing bindings
> review / NAK).

True, but in a similar fashion to ACPI bindings (which Andy in particular
keeps a close eye on!) we should ask for very specific device reference
and document the broken part.  I've gotten a lot stricter on this over
the last few years so new cases of this in IIO at least require such
a comment alongside the ID table entry.

> 
> >   
> >>>
> >>> We were very well aware that not documenting this was going to generate a warning so    
> >>
> >> You *CANNOT* have undocumented compatibles.  
> > 
> > Why not? This corner case is a valid reason for that to be allowed.
> > You cannot use that compatible with DT bindings.  Absolutely.  The compatible
> > has other uses...  
> 
> Okay. With that approach what stops anyone from submitting DTS using
> that compatible (claiming there is a driver for that compatible)?

That's a good point.  Perhaps we should just add a check for this?
Easy to add a check on the firmware type. This is a rare enough case that
just doing it in the driver seems fine to me (rather than more general
infrastructure).

> 
> > 
> >   
> >>  
> >>> we tried to fix that with a deprecated tag but it was NAKd by Rob. What we understood    
> >>
> >> Because the driver was NAKed obviously as well.
> >>  
> >>> from his last message was that it wasn't necessary to fix the DT warning.    
> >>
> >> I am quite angry that maintainer tells you something, but you push your
> >> patch through because apparently you need to fulfill your project
> >> requirements.  
> > 
> > I think this is a fundamental misunderstanding of the situation and probably
> > at least partly my fault for not clarifying my reading of the situation more
> > fully at the time.
> > 
> > As far as I am concerned. The situation is:
> > 1) Existing shipping consumer device.  We have 100s of cases of ACPI bindings
> >    that exist just to deal with garbage firmware's.  The folk involved in
> >    reviewing these have pushed back hard for a long time, but sadly there
> >    is still a lot of garbage shipping because Windows lets it through and
> >    Linux support comes second.  It's made even worse by Microsoft defining
> >    their own standards that aren't compliant with ACPI as they don't
> >    even bother with reserving the methods IDs.  ROTM for example.  
> 
> Hm, and these devices do not provide normal ACPI IDs? They use Of-like
> ones? I don't know that much about ACPI, but aren't they coming without
> vendor prefix thus "ltr,ltrf216a" is just wrong and should be "lTRF216A"
> alone?

Yes, they come with the ID that is matched on by the ACPI core as PRP0001
which basically means use the DT compatible.
Then a device specific property that provides 'compatible' to look up against.
The intent being to allow use of existing drivers without needing to modify
them to add ACPI IDs to match against. 

LTRF216A is worse than using PRP0001 and DT vendor ID
ACPI has it's own equivalent of vendor IDs and you have to apply for one from
relevant committee in the UEFI forum (ASWG)
https://uefi.org/ACPI_ID_List
(there is a 3 letter form as well).
It's easy to get an ID (takes a few weeks though) but many sensor companies
etc don't bother.  Sometimes they say it's because the OEMs should do this
and sometimes those OEMs do, so the binding is under their vendor not the
device manufacturer.  That's when you see what looks like completely unrelated
IDs being used.

It would be good it liteon got a proper ID and started issuing device numbers
to go with it though.

There are a lot of old bindings that make IDs up. Some are based on cut and paste
and we've been trying to scrub those, others are based on what Windows drivers
bind against and so we are stuck with that set.
For extra fun we have examples of hardware with a common ID for incompatible
devices for which we have different drivers.  That's a real pain when it happens
but a few sensor manufacturers have 'one windows driver' for many years worth
of unrelated devices and use horrible matching routines to figure out what is
actually there...).

> 
> > 
> > 2) This is an ACPI binding, it just happens to use a DT compatible via the
> >    PRP0001 mechanism.  Yes, we strongly discourage people doing that in
> >    shipping products but there have been other cases of it.  
> 
> OK, is this the case here?

Shreeya, can you check this.  If we can get an example of such a device
that would help.  (This is the same request we've made when removing
potentially false ACPI IDs).  If we can't actually pin it down to a device
I don't mind dropping the ID and seeing if anyone shouts.

> 
> > 
> > 3) Shreeya read a distinction (that I also agree with) between the schema
> >    and the compatible list.  The schema does not apply to this situation
> >    (because we can't actually check it today for DSDT) hence Rob's Nack
> >    was making the point it was inappropriate to carry it there.
> > 
> > So, I don't see this as a deliberate attempt to bypass a maintainer Nack.
> > I'd love to be in a position to say no on ACPI bindings that are garbage
> > (there are a lot of them) but Windows is dominant in that space so
> > we get stuck with their mess.  On server's it is a different game
> > and the kernel community regularly gets significant changes made.  
> 
> Original discussion had only vague statement of "vendor prefix name as
> 'ltr' through ACPI". But what does it even mean? What ACPI ID is
> reported by these devices?

PRP0001 is the only way it can be done that I know of so I read the
original thread with that in mind.  I might be wrong though and
that would indeed change this discussion!

Thanks,

Jonathan


> 
> Best regards,
> Krzysztof
> 


