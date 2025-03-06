Return-Path: <linux-iio+bounces-16465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A291AA54668
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 10:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8891895C6F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 09:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836DA20967A;
	Thu,  6 Mar 2025 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="IhG3jeFS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC581DA634
	for <linux-iio@vger.kernel.org>; Thu,  6 Mar 2025 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253653; cv=none; b=Ddbm8G9sA0i3ib/uURKm+nKXJ3XozWg6BuQQup/ZC8sIrDyyw8Boh18h4a91dXhlGbSwKpaKau76yK3WZYT3CWqvbiOLAg6tcXxlK6aT4VFER0L0mU2D/p/5foJmjso1nfK1ZbAtMgyvUERRYEjkaE2vJLelXFSiAmZnRM+7N+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253653; c=relaxed/simple;
	bh=0Ul3W9RA2qbuwLSO2ikfxDnJ5d0Vyod5VAYqpLKoKLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bo9FthhknW+AQobVOcOau8PU4/0lSXQbCRqMNCEogoOuFJuNEImCwc4DPJPXzL+0ZAzPUYc4RmoaFWEBW/7GSezOAonGltF+lTHZcCDu6oEC4JutHTVVAr67ZuSY1UJrTSu3CHzldBXys5GO8lw4t2lOkubAkMznEItO3qH4n+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=IhG3jeFS; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=9tPUP8EiK8qOxuyJaWos1+XABWu3Bxs8tybweToNzbY=;
	b=IhG3jeFShdQXOFCjNcuAh7zmvleBiMEanWrwNgthK2jMovqGUK70iShaGa8NBl3aqXdAoTFwb/1qF
	 t0KwTL+AFF0Ga2NHug1pLMa3umU3Om+Ii94rOn2IwhV3TA2coa/daszdP1RQzT99jlSGBuy+x/4x+Y
	 fuloAPhWhfq0pdTnZfKEjEm4SusF9udSd5chvcc6veMbGzX8OiwU40ZBEd4NCXKVzr9HZO/l+6wpCm
	 JDlEeSB4Jf+lcrv67hOIYrSPhkrN3BDxFiR3VUBCHT0j9rRmw/OfF2qqWrZJPno5tDD+7shjiYs9Ed
	 q75ecYc08/4HkPjvyZrR8AcZ/lNQYgw==
X-MSG-ID: 23d7dec5-fa6e-11ef-b5ca-0050568164d1
Date: Thu, 6 Mar 2025 10:34:02 +0100
From: David Jander <david@protonic.nl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
Message-ID: <20250306103402.2b9e51d7@erd003.prtnl>
In-Reply-To: <2025030638-wavy-napkin-41ab@gregkh>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-2-david@protonic.nl>
	<6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
	<20250305164046.4de5b6ef@erd003.prtnl>
	<mzxammninwmak5ti4c6is4pbdx3xzzziiwbxiwrldjyxgae4ok@ocec24vu4txa>
	<2025030611-embezzle-sacrament-00d9@gregkh>
	<20250306092013.1147f27e@erd003.prtnl>
	<2025030638-wavy-napkin-41ab@gregkh>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 10:03:26 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Mar 06, 2025 at 09:20:13AM +0100, David Jander wrote:
> > On Thu, 6 Mar 2025 08:18:46 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >  =20
> > > On Thu, Mar 06, 2025 at 12:21:22AM +0100, Uwe Kleine-K=C3=B6nig wrote=
: =20
> > > > Hello David,
> > > >=20
> > > > On Wed, Mar 05, 2025 at 04:40:45PM +0100, David Jander wrote:   =20
> > > > > On Fri, 28 Feb 2025 17:44:27 +0100
> > > > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:   =20
> > > > > > On Thu, Feb 27, 2025 at 05:28:17PM +0100, David Jander wrote:
> > > > > > [...]   =20
> > > > > > > +static int motion_open(struct inode *inode, struct file *fil=
e)
> > > > > > > +{
> > > > > > > +	int minor =3D iminor(inode);
> > > > > > > +	struct motion_device *mdev =3D NULL, *iter;
> > > > > > > +	int err;
> > > > > > > +
> > > > > > > +	mutex_lock(&motion_mtx);     =20
> > > > > >=20
> > > > > > If you use guard(), error handling gets a bit easier.   =20
> > > > >=20
> > > > > This looks interesting. I didn't know about guard(). Thanks. I se=
e the
> > > > > benefits, but in some cases it also makes the locked region less =
clearly
> > > > > visible. While I agree that guard() in this particular place is n=
ice,
> > > > > I'm hesitant to try and replace all mutex_lock()/_unlock() calls =
with guard().
> > > > > Let me know if my assessment of the intended use of guard() is in=
correct.   =20
> > > >=20
> > > > I agree that guard() makes it harder for non-trivial functions to s=
pot
> > > > the critical section. In my eyes this is outweight by not having to
> > > > unlock in all exit paths, but that might be subjective. Annother
> > > > downside of guard is that sparse doesn't understand it and reports
> > > > unbalanced locking.
> > > >     =20
> > > > > > > +	list_for_each_entry(iter, &motion_list, list) {
> > > > > > > +		if (iter->minor !=3D minor)
> > > > > > > +			continue;
> > > > > > > +		mdev =3D iter;
> > > > > > > +		break;
> > > > > > > +	}     =20
> > > > > >=20
> > > > > > This should be easier. If you use a cdev you can just do
> > > > > > container_of(inode->i_cdev, ...);   =20
> > > > >=20
> > > > > Hmm... I don't yet really understand what you mean. I will have t=
o study the
> > > > > involved code a bit more.   =20
> > > >=20
> > > > The code that I'm convinced is correct is
> > > > https://lore.kernel.org/linux-pwm/00c9f1181dc351e1e6041ba6e41e4c30b=
12b6a27.1725635013.git.u.kleine-koenig@baylibre.com/
> > > >=20
> > > > This isn't in mainline because there is some feedback I still have =
to
> > > > address, but I think it might serve as an example anyhow.
> > > >    =20
> > > > > > > [...]
> > > > > > > +
> > > > > > > +static const struct class motion_class =3D {
> > > > > > > +	.name		=3D "motion",
> > > > > > > +	.devnode	=3D motion_devnode,     =20
> > > > > >=20
> > > > > > IIRC it's recommended to not create new classes, but a bus.   =
=20
> > > > >=20
> > > > > Interesting. I did some searching, and all I could find was that =
the chapter
> > > > > in driver-api/driver-model about classes magically vanished betwe=
en versions
> > > > > 5.12 and 5.13. Does anyone know where I can find some information=
 about this?
> > > > > Sorry if I'm being blind...   =20
> > > >=20
> > > > Half knowledge on my end at best. I would hope that Greg knows some
> > > > details (which might even be "no, classes are fine"). I added him t=
o Cc:   =20
> > >=20
> > > A class is there for when you have a common api that devices of
> > > different types can talk to userspace (i.e. the UAPI is common, not t=
he
> > > hardware type).  Things like input devices, tty, disks, etc.  A bus is
> > > there to be able to write different drivers to bind to for that hardw=
are
> > > bus type (pci, usb, i2c, platform, etc.)
> > >=20
> > > So you need both, a bus to talk to the hardware, and a class to talk =
to
> > > userspace in a common way (ignore the fact that we can also talk to
> > > hardware directly from userspace like raw USB or i2c or PCI config
> > > space, that's all bus-specific stuff). =20
> >=20
> > Thanks for chiming in. Let me see if I understand this correctly: In th=
is
> > case, I have a UAPI that is common to different types of motion control
> > devices. So I need a class. check. =20
>=20
> Correct.
>=20
> > Do I need a bus? If one can conceive other drivers or kernel parts that=
 talk to
> > motion drivers, I would need a bus. If that doesn't make sense, I don't=
. Right? =20
>=20
> Correct.
>=20
> > I actually can think of a new motion device that acts as an aggregator =
of
> > several single-channel motion devices into a single "virtual" multi-cha=
nnel
> > device... so do I need also a bus? I suppose...? =20
>=20
> Nope, that should just be another class driver.  Think about how input
> does this, some input /dev/ nodes are the sum of ALL input /dev/ nodes
> together, while others are just for individual input devices.

Understood. Thanks!

> > Then the question remains: why did the chapter about classes vanish? =20
>=20
> What are you specifically referring to?  I don't remember deleting any
> documentation, did files move around somehow and the links not get
> updated?

This:
https://www.kernel.org/doc/html/v5.12/driver-api/driver-model/index.html

vs this:
https://www.kernel.org/doc/html/v5.13/driver-api/driver-model/index.html

Maybe it moved somewhere else, but I can't find it... I'd have to git bisect
or git blame between the two releases maybe.

Best regards,

--=20
David Jander

