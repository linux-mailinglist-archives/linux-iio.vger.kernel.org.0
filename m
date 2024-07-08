Return-Path: <linux-iio+bounces-7439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B1992A38A
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 15:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F70B214D9
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257B113774A;
	Mon,  8 Jul 2024 13:20:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298FB665;
	Mon,  8 Jul 2024 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720444859; cv=none; b=UI/R60zFV6M7YfDGmlF0bUtwW4OmYmafFyKGvbddiJ+GuaZfV9ZUIfYPMWHMw8sTuYiCaM97GqOXvP6F2or3KivpxIQ4x7fvpn3dvoD4yKM4Ir/xSzkvn6+m+fwDhuH5SjhYQqEs//HIi0XdLv8yZOHA1g7gALRi55REMngEBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720444859; c=relaxed/simple;
	bh=GmWZ5WA5I4riJvl4nr55zHidDjlnU17eAjGd8dWQywI=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=DNrY15IXNaA/3U6jO4AeEKXWB2RCPImrrLo98R0WIJtDTe9vVojPVxBKS0ruOTWkKW9XlYwf3uGhKlSgzxi6O+0kgYoyd3WUBj5elmd4pry4do5anZKcvviYlf9GX1RKgUucylVCE91N5y0UFQbTo7ENZbrZHYCnLD+Prou4kWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 7227F378065F;
	Mon,  8 Jul 2024 13:20:54 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240707150835.40db1897@jic23-huawei>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240705095047.90558-1-marex@denx.de>
	<3b2ca0-6687ce00-3-4dab7280@52083650>
	<98992b1d-c94a-4053-a755-32a25d7fdc46@kernel.org>
	<20240707143759.7718e0f3@jic23-huawei>
	<1effec8c-8228-482b-b476-06838128adfa@kernel.org> <20240707150835.40db1897@jic23-huawei>
Date: Mon, 08 Jul 2024 14:20:54 +0100
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Marek Vasut" <marex@denx.de>, linux-iio@vger.kernel.org, "Conor Dooley" <conor+dt@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, devicetree@vger.kernel.org, kernel@collabora.com, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <152a3f-668be780-9-37e01600@58959239>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?iio=3A?==?utf-8?q?_light=3A?=
 =?utf-8?q?_ltrf216a=3A?= Drop undocumented =?utf-8?q?ltr=2Cltrf216a?= 
 compatible string
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Sunday, July 07, 2024 19:38 IST, Jonathan Cameron <jic23@kernel.org>=
 wrote:

> On Sun, 7 Jul 2024 15:46:26 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>=20
> > On 07/07/2024 15:37, Jonathan Cameron wrote:
> > > On Sun, 7 Jul 2024 14:02:39 +0200
> > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >  =20
> > >> On 05/07/2024 12:42, Shreeya Patel wrote: =20
> > >>> On Friday, July 05, 2024 15:20 IST, Marek Vasut <marex@denx.de>=
 wrote:
> > >>>    =20
> > >>>> The "ltr,ltrf216a" compatible string is not documented in DT b=
inding
> > >>>> document, remove it.
> > >>>>
> > >>>> Signed-off-by: Marek Vasut <marex@denx.de>
> > >>>> ---
> > >>>> Cc: Conor Dooley <conor+dt@kernel.org>
> > >>>> Cc: Jonathan Cameron <jic23@kernel.org>
> > >>>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > >>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
> > >>>> Cc: Marek Vasut <marex@denx.de>
> > >>>> Cc: Rob Herring <robh@kernel.org>
> > >>>> Cc: Shreeya Patel <shreeya.patel@collabora.com>
> > >>>> Cc: devicetree@vger.kernel.org
> > >>>> Cc: linux-iio@vger.kernel.org
> > >>>> ---
> > >>>>  drivers/iio/light/ltrf216a.c | 1 -
> > >>>>  1 file changed, 1 deletion(-)
> > >>>>
> > >>>> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/=
ltrf216a.c
> > >>>> index 68dc48420a886..78fc910fcb18c 100644
> > >>>> --- a/drivers/iio/light/ltrf216a.c
> > >>>> +++ b/drivers/iio/light/ltrf216a.c
> > >>>> @@ -528,7 +528,6 @@ MODULE=5FDEVICE=5FTABLE(i2c, ltrf216a=5Fid=
);
> > >>>> =20
> > >>>>  static const struct of=5Fdevice=5Fid ltrf216a=5Fof=5Fmatch[] =
=3D {
> > >>>>  	{ .compatible =3D "liteon,ltrf216a" },
> > >>>> -	{ .compatible =3D "ltr,ltrf216a" },
> > >>>>  	{}   =20
> > >>>
> > >>> This compatible string with a different vendor prefix was added=
 for a specific reason.
> > >>> Please see the commit message of the following patch :-
> > >>> https://lore.kernel.org/all/20220511094024.175994-2-shreeya.pat=
el@collabora.com/   =20
> > >>
> > >> And adding this specific compatible was clearly NAKed:
> > >> https://lore.kernel.org/all/20220516170406.GB2825626-robh@kernel=
.org/
> > >>
> > >> yet you still added it. That's a deliberate going around maintai=
ner's
> > >> decision.
> > >> =20
> > >=20
> > > The statement from Rob was very specific. The schema is not appli=
cable to ACPI bindings
> > > - that's the basis on which he doesn't want this in the schema. S=
pecifically
> > > because "There's not really any point in having this in schema as=
 you can't
> > > use that schema with ACPI".
> > >=20
> > > That is true (though arguably you could with sufficient tooling a=
pply the schema
> > > to the relevant part of DSDT).
> > >=20
> > > The compatible is usable, via PRP0001 ACPI IDs. =20
> >=20
> > Uh, that's sounds like a slippery slope. To my understanding, PRP00=
01
> > allows to create ACPI IDs from OF IDs, so it requires to have a val=
id OF
> > ID. Valid OF ID requires bindings, doesn't it?
> >=20
> > If it does not, then anyone can add any Devicetree properties, clai=
ming
> > it is for ACPI ID thus not providing bindings (or bypassing binding=
s
> > review / NAK).
>=20
> True, but in a similar fashion to ACPI bindings (which Andy in partic=
ular
> keeps a close eye on!) we should ask for very specific device referen=
ce
> and document the broken part.  I've gotten a lot stricter on this ove=
r
> the last few years so new cases of this in IIO at least require such
> a comment alongside the ID table entry.
>=20
> >=20
> > >  =20
> > >>>
> > >>> We were very well aware that not documenting this was going to =
generate a warning so   =20
> > >>
> > >> You *CANNOT* have undocumented compatibles. =20
> > >=20
> > > Why not? This corner case is a valid reason for that to be allowe=
d.
> > > You cannot use that compatible with DT bindings.  Absolutely.  Th=
e compatible
> > > has other uses... =20
> >=20
> > Okay. With that approach what stops anyone from submitting DTS usin=
g
> > that compatible (claiming there is a driver for that compatible)?
>=20
> That's a good point.  Perhaps we should just add a check for this?
> Easy to add a check on the firmware type. This is a rare enough case =
that
> just doing it in the driver seems fine to me (rather than more genera=
l
> infrastructure).
>=20
> >=20
> > >=20
> > >  =20
> > >> =20
> > >>> we tried to fix that with a deprecated tag but it was NAKd by R=
ob. What we understood   =20
> > >>
> > >> Because the driver was NAKed obviously as well.
> > >> =20
> > >>> from his last message was that it wasn't necessary to fix the D=
T warning.   =20
> > >>
> > >> I am quite angry that maintainer tells you something, but you pu=
sh your
> > >> patch through because apparently you need to fulfill your projec=
t
> > >> requirements. =20
> > >=20
> > > I think this is a fundamental misunderstanding of the situation a=
nd probably
> > > at least partly my fault for not clarifying my reading of the sit=
uation more
> > > fully at the time.
> > >=20
> > > As far as I am concerned. The situation is:
> > > 1) Existing shipping consumer device.  We have 100s of cases of A=
CPI bindings
> > >    that exist just to deal with garbage firmware's.  The folk inv=
olved in
> > >    reviewing these have pushed back hard for a long time, but sad=
ly there
> > >    is still a lot of garbage shipping because Windows lets it thr=
ough and
> > >    Linux support comes second.  It's made even worse by Microsoft=
 defining
> > >    their own standards that aren't compliant with ACPI as they do=
n't
> > >    even bother with reserving the methods IDs.  ROTM for example.=
 =20
> >=20
> > Hm, and these devices do not provide normal ACPI IDs? They use Of-l=
ike
> > ones? I don't know that much about ACPI, but aren't they coming wit=
hout
> > vendor prefix thus "ltr,ltrf216a" is just wrong and should be "lTRF=
216A"
> > alone?
>=20
> Yes, they come with the ID that is matched on by the ACPI core as PRP=
0001
> which basically means use the DT compatible.
> Then a device specific property that provides 'compatible' to look up=
 against.
> The intent being to allow use of existing drivers without needing to =
modify
> them to add ACPI IDs to match against.=20
>=20
> LTRF216A is worse than using PRP0001 and DT vendor ID
> ACPI has it's own equivalent of vendor IDs and you have to apply for =
one from
> relevant committee in the UEFI forum (ASWG)
> https://uefi.org/ACPI=5FID=5FList
> (there is a 3 letter form as well).
> It's easy to get an ID (takes a few weeks though) but many sensor com=
panies
> etc don't bother.  Sometimes they say it's because the OEMs should do=
 this
> and sometimes those OEMs do, so the binding is under their vendor not=
 the
> device manufacturer.  That's when you see what looks like completely =
unrelated
> IDs being used.
>=20
> It would be good it liteon got a proper ID and started issuing device=
 numbers
> to go with it though.
>=20
> There are a lot of old bindings that make IDs up. Some are based on c=
ut and paste
> and we've been trying to scrub those, others are based on what Window=
s drivers
> bind against and so we are stuck with that set.
> For extra fun we have examples of hardware with a common ID for incom=
patible
> devices for which we have different drivers.  That's a real pain when=
 it happens
> but a few sensor manufacturers have 'one windows driver' for many yea=
rs worth
> of unrelated devices and use horrible matching routines to figure out=
 what is
> actually there...).
>=20
> >=20
> > >=20
> > > 2) This is an ACPI binding, it just happens to use a DT compatibl=
e via the
> > >    PRP0001 mechanism.  Yes, we strongly discourage people doing t=
hat in
> > >    shipping products but there have been other cases of it. =20
> >=20
> > OK, is this the case here?
>=20
> Shreeya, can you check this.  If we can get an example of such a devi=
ce
> that would help.  (This is the same request we've made when removing
> potentially false ACPI IDs).  If we can't actually pin it down to a d=
evice
> I don't mind dropping the ID and seeing if anyone shouts.
>=20

This is exactly the case here. Thank you for putting it in better words=
.

(B+)(root@linux iio:device0)# cat /sys/bus/i2c/devices/i2c-PRP0001\:01/=
modalias
of:NltrfTCltr,ltrf216a

Above is the output from the steam deck device which I had also shared =
with Rob
during the discussion of adding the string with a deprecated tag [1]

I understand that it was NAK'd by Rob but what I understood from his la=
st
email in the thread is that it is okay to add this compatible in the dr=
iver but
shouldn't be documented in the bindings.=20

https://lore.kernel.org/all/f37bccaf-233c-a244-3d81-849a988b1a92@collab=
ora.com/#t

> >=20
> > >=20
> > > 3) Shreeya read a distinction (that I also agree with) between th=
e schema
> > >    and the compatible list.  The schema does not apply to this si=
tuation
> > >    (because we can't actually check it today for DSDT) hence Rob'=
s Nack
> > >    was making the point it was inappropriate to carry it there.
> > >=20

Exactly! This was my understanding at that time.


Thanks,
Shreeya Patel

> > > So, I don't see this as a deliberate attempt to bypass a maintain=
er Nack.
> > > I'd love to be in a position to say no on ACPI bindings that are =
garbage
> > > (there are a lot of them) but Windows is dominant in that space s=
o
> > > we get stuck with their mess.  On server's it is a different game
> > > and the kernel community regularly gets significant changes made.=
 =20
> >=20
> > Original discussion had only vague statement of "vendor prefix name=
 as
> > 'ltr' through ACPI". But what does it even mean? What ACPI ID is
> > reported by these devices?
>=20
> PRP0001 is the only way it can be done that I know of so I read the
> original thread with that in mind.  I might be wrong though and
> that would indeed change this discussion!
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> >=20
> > Best regards,
> > Krzysztof
> >=20
>


