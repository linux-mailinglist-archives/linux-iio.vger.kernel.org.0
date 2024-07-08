Return-Path: <linux-iio+bounces-7444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38B92A6B4
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 18:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F161F1F22822
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5C9146595;
	Mon,  8 Jul 2024 16:01:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFB3145FE1;
	Mon,  8 Jul 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454481; cv=none; b=VlfaM3mw/AIrZhL6uF/xNHHOJslQ3+moZmWNu1926W+D5eZE2KScmw5/CoX0onTFC7UB9bPV8r3KvIKpVAO6VbzqL7M/XR9915NJ2JMf7L827SvaChhEYeiVfNKPAJKWP4Mv+qLfwvAykLKG5msRkpngP1EKa68qPlPJdL1x40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454481; c=relaxed/simple;
	bh=vWraWx/T6wy7da5KVvXmkUEK4IISIDy7xJ4hKq/jQIo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/Pruq6QphZRB627nLxrS0LDSddo2Ix9p4NO17IFRpRJ67qWLF1aQBzscJlwzZ9UE157sZNptJ4cO2LO9tvHIO6HOH6Tf5i6L8oSmoGx+ZibxtsmpaIRvEj+w+vbfDbW+vjQb8VKNuYMmbu6FBk/YQSg7I9Qy/Mmjnf1UYVNzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WHpjT343Wz6K6K9;
	Mon,  8 Jul 2024 23:59:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 19C1D1400CF;
	Tue,  9 Jul 2024 00:01:17 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 17:01:16 +0100
Date: Mon, 8 Jul 2024 17:01:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shreeya Patel <shreeya.patel@collabora.com>
CC: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>, Marek Vasut <marex@denx.de>, <linux-iio@vger.kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "Krzysztof Kozlowski"
	<krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Rob Herring"
	<robh@kernel.org>, <devicetree@vger.kernel.org>, <kernel@collabora.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a 
 compatible string
Message-ID: <20240708170115.00007ad4@Huawei.com>
In-Reply-To: <152a3f-668be780-9-37e01600@58959239>
References: <20240705095047.90558-1-marex@denx.de>
	<3b2ca0-6687ce00-3-4dab7280@52083650>
	<98992b1d-c94a-4053-a755-32a25d7fdc46@kernel.org>
	<20240707143759.7718e0f3@jic23-huawei>
	<1effec8c-8228-482b-b476-06838128adfa@kernel.org>
	<20240707150835.40db1897@jic23-huawei>
	<152a3f-668be780-9-37e01600@58959239>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 8 Jul 2024 14:20:54 +0100
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> On Sunday, July 07, 2024 19:38 IST, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sun, 7 Jul 2024 15:46:26 +0200
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >   
> > > On 07/07/2024 15:37, Jonathan Cameron wrote:  
> > > > On Sun, 7 Jul 2024 14:02:39 +0200
> > > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >     
> > > >> On 05/07/2024 12:42, Shreeya Patel wrote:    
> > > >>> On Friday, July 05, 2024 15:20 IST, Marek Vasut <marex@denx.de> wrote:
> > > >>>       
> > > >>>> The "ltr,ltrf216a" compatible string is not documented in DT binding
> > > >>>> document, remove it.
> > > >>>>
> > > >>>> Signed-off-by: Marek Vasut <marex@denx.de>
> > > >>>> ---
> > > >>>> Cc: Conor Dooley <conor+dt@kernel.org>
> > > >>>> Cc: Jonathan Cameron <jic23@kernel.org>
> > > >>>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > > >>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > >>>> Cc: Marek Vasut <marex@denx.de>
> > > >>>> Cc: Rob Herring <robh@kernel.org>
> > > >>>> Cc: Shreeya Patel <shreeya.patel@collabora.com>
> > > >>>> Cc: devicetree@vger.kernel.org
> > > >>>> Cc: linux-iio@vger.kernel.org
> > > >>>> ---
> > > >>>>  drivers/iio/light/ltrf216a.c | 1 -
> > > >>>>  1 file changed, 1 deletion(-)
> > > >>>>
> > > >>>> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> > > >>>> index 68dc48420a886..78fc910fcb18c 100644
> > > >>>> --- a/drivers/iio/light/ltrf216a.c
> > > >>>> +++ b/drivers/iio/light/ltrf216a.c
> > > >>>> @@ -528,7 +528,6 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
> > > >>>>  
> > > >>>>  static const struct of_device_id ltrf216a_of_match[] = {
> > > >>>>  	{ .compatible = "liteon,ltrf216a" },
> > > >>>> -	{ .compatible = "ltr,ltrf216a" },
> > > >>>>  	{}      
> > > >>>
> > > >>> This compatible string with a different vendor prefix was added for a specific reason.
> > > >>> Please see the commit message of the following patch :-
> > > >>> https://lore.kernel.org/all/20220511094024.175994-2-shreeya.patel@collabora.com/      
> > > >>
> > > >> And adding this specific compatible was clearly NAKed:
> > > >> https://lore.kernel.org/all/20220516170406.GB2825626-robh@kernel.org/
> > > >>
> > > >> yet you still added it. That's a deliberate going around maintainer's
> > > >> decision.
> > > >>    
> > > > 
> > > > The statement from Rob was very specific. The schema is not applicable to ACPI bindings
> > > > - that's the basis on which he doesn't want this in the schema. Specifically
> > > > because "There's not really any point in having this in schema as you can't
> > > > use that schema with ACPI".
> > > > 
> > > > That is true (though arguably you could with sufficient tooling apply the schema
> > > > to the relevant part of DSDT).
> > > > 
> > > > The compatible is usable, via PRP0001 ACPI IDs.    
> > > 
> > > Uh, that's sounds like a slippery slope. To my understanding, PRP0001
> > > allows to create ACPI IDs from OF IDs, so it requires to have a valid OF
> > > ID. Valid OF ID requires bindings, doesn't it?
> > > 
> > > If it does not, then anyone can add any Devicetree properties, claiming
> > > it is for ACPI ID thus not providing bindings (or bypassing bindings
> > > review / NAK).  
> > 
> > True, but in a similar fashion to ACPI bindings (which Andy in particular
> > keeps a close eye on!) we should ask for very specific device reference
> > and document the broken part.  I've gotten a lot stricter on this over
> > the last few years so new cases of this in IIO at least require such
> > a comment alongside the ID table entry.
> >   
> > >   
> > > >     
> > > >>>
> > > >>> We were very well aware that not documenting this was going to generate a warning so      
> > > >>
> > > >> You *CANNOT* have undocumented compatibles.    
> > > > 
> > > > Why not? This corner case is a valid reason for that to be allowed.
> > > > You cannot use that compatible with DT bindings.  Absolutely.  The compatible
> > > > has other uses...    
> > > 
> > > Okay. With that approach what stops anyone from submitting DTS using
> > > that compatible (claiming there is a driver for that compatible)?  
> > 
> > That's a good point.  Perhaps we should just add a check for this?
> > Easy to add a check on the firmware type. This is a rare enough case that
> > just doing it in the driver seems fine to me (rather than more general
> > infrastructure).
> >   
> > >   
> > > > 
> > > >     
> > > >>    
> > > >>> we tried to fix that with a deprecated tag but it was NAKd by Rob. What we understood      
> > > >>
> > > >> Because the driver was NAKed obviously as well.
> > > >>    
> > > >>> from his last message was that it wasn't necessary to fix the DT warning.      
> > > >>
> > > >> I am quite angry that maintainer tells you something, but you push your
> > > >> patch through because apparently you need to fulfill your project
> > > >> requirements.    
> > > > 
> > > > I think this is a fundamental misunderstanding of the situation and probably
> > > > at least partly my fault for not clarifying my reading of the situation more
> > > > fully at the time.
> > > > 
> > > > As far as I am concerned. The situation is:
> > > > 1) Existing shipping consumer device.  We have 100s of cases of ACPI bindings
> > > >    that exist just to deal with garbage firmware's.  The folk involved in
> > > >    reviewing these have pushed back hard for a long time, but sadly there
> > > >    is still a lot of garbage shipping because Windows lets it through and
> > > >    Linux support comes second.  It's made even worse by Microsoft defining
> > > >    their own standards that aren't compliant with ACPI as they don't
> > > >    even bother with reserving the methods IDs.  ROTM for example.    
> > > 
> > > Hm, and these devices do not provide normal ACPI IDs? They use Of-like
> > > ones? I don't know that much about ACPI, but aren't they coming without
> > > vendor prefix thus "ltr,ltrf216a" is just wrong and should be "lTRF216A"
> > > alone?  
> > 
> > Yes, they come with the ID that is matched on by the ACPI core as PRP0001
> > which basically means use the DT compatible.
> > Then a device specific property that provides 'compatible' to look up against.
> > The intent being to allow use of existing drivers without needing to modify
> > them to add ACPI IDs to match against. 
> > 
> > LTRF216A is worse than using PRP0001 and DT vendor ID
> > ACPI has it's own equivalent of vendor IDs and you have to apply for one from
> > relevant committee in the UEFI forum (ASWG)
> > https://uefi.org/ACPI_ID_List
> > (there is a 3 letter form as well).
> > It's easy to get an ID (takes a few weeks though) but many sensor companies
> > etc don't bother.  Sometimes they say it's because the OEMs should do this
> > and sometimes those OEMs do, so the binding is under their vendor not the
> > device manufacturer.  That's when you see what looks like completely unrelated
> > IDs being used.
> > 
> > It would be good it liteon got a proper ID and started issuing device numbers
> > to go with it though.
> > 
> > There are a lot of old bindings that make IDs up. Some are based on cut and paste
> > and we've been trying to scrub those, others are based on what Windows drivers
> > bind against and so we are stuck with that set.
> > For extra fun we have examples of hardware with a common ID for incompatible
> > devices for which we have different drivers.  That's a real pain when it happens
> > but a few sensor manufacturers have 'one windows driver' for many years worth
> > of unrelated devices and use horrible matching routines to figure out what is
> > actually there...).
> >   
> > >   
> > > > 
> > > > 2) This is an ACPI binding, it just happens to use a DT compatible via the
> > > >    PRP0001 mechanism.  Yes, we strongly discourage people doing that in
> > > >    shipping products but there have been other cases of it.    
> > > 
> > > OK, is this the case here?  
> > 
> > Shreeya, can you check this.  If we can get an example of such a device
> > that would help.  (This is the same request we've made when removing
> > potentially false ACPI IDs).  If we can't actually pin it down to a device
> > I don't mind dropping the ID and seeing if anyone shouts.
> >   
> 
> This is exactly the case here. Thank you for putting it in better words.
> 
> (B+)(root@linux iio:device0)# cat /sys/bus/i2c/devices/i2c-PRP0001\:01/modalias
> of:NltrfTCltr,ltrf216a
> 
> Above is the output from the steam deck device which I had also shared with Rob
> during the discussion of adding the string with a deprecated tag [1]
> 
> I understand that it was NAK'd by Rob but what I understood from his last
> email in the thread is that it is okay to add this compatible in the driver but
> shouldn't be documented in the bindings. 
> 
> https://lore.kernel.org/all/f37bccaf-233c-a244-3d81-849a988b1a92@collabora.com/#t

Ok. If we don't make any other changes as a result of this discussion (not sure
where we will end up yet).  I'd like a patch adding a comment about the device
that is in the wild alongside the compatible.

Jonathan

> 
> > >   
> > > > 
> > > > 3) Shreeya read a distinction (that I also agree with) between the schema
> > > >    and the compatible list.  The schema does not apply to this situation
> > > >    (because we can't actually check it today for DSDT) hence Rob's Nack
> > > >    was making the point it was inappropriate to carry it there.
> > > >   
> 
> Exactly! This was my understanding at that time.
> 
> 
> Thanks,
> Shreeya Patel
> 
> > > > So, I don't see this as a deliberate attempt to bypass a maintainer Nack.
> > > > I'd love to be in a position to say no on ACPI bindings that are garbage
> > > > (there are a lot of them) but Windows is dominant in that space so
> > > > we get stuck with their mess.  On server's it is a different game
> > > > and the kernel community regularly gets significant changes made.    
> > > 
> > > Original discussion had only vague statement of "vendor prefix name as
> > > 'ltr' through ACPI". But what does it even mean? What ACPI ID is
> > > reported by these devices?  
> > 
> > PRP0001 is the only way it can be done that I know of so I read the
> > original thread with that in mind.  I might be wrong though and
> > that would indeed change this discussion!
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> > > 
> > > Best regards,
> > > Krzysztof
> > >   
> >  
> 
> 


