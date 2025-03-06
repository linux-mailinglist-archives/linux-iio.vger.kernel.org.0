Return-Path: <linux-iio+bounces-16477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE165A54DAC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 15:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD4F7A36D3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E201632FE;
	Thu,  6 Mar 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="eQwCDqkL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE1154449
	for <linux-iio@vger.kernel.org>; Thu,  6 Mar 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271136; cv=none; b=nimCPE9TW6NjTkBl65kFJebIj2dRHlpIY6DANgl9gLSDKNLCNjXPWplyldb2ujZYiDOzYeEZxQ9nWBTR+KxsxLm7JoZioKoM0KMP1biRRWO8Mj77fZ6GT7zN3Cu2lAH14nT3wjlLXzstKgXbFULD2Iatb8T9TAhdiZfBFWkKoUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271136; c=relaxed/simple;
	bh=rewbDqtOzkoRQWXlMx1uF1dSYCNyFmWtML0qp55+0Io=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXuDZ8sUWn42+eNBgeA0FV7FDq7zuXOKSI9PAhNbBTDD8yDnjHcFIBQbADxJ5zERsyL2eamsqqhqV1AUMsCs1Q2Tofz/CSEWPa8qMZu6l5G63Izd0rP1ZIXY6C6NjvfbHcNq0EpsL2J2yxYREsd4sg09QPDtlpL9wBMXSrjVij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=eQwCDqkL; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=Muv0tidnHLtV2deO81+NbGyTlOS+APQ2U35gCWqb6N0=;
	b=eQwCDqkLRQhan6nnkk+SYJeicRcs5KSan9ERkS6JqfB3D8+uF5OeLQEG8Z14QvCUrAJ3apgFnDSxa
	 hvS5/L0InHPOmAjWO4gi/Go59M0C6WcWewdlfiAM50DOg9m03r4XEmRKgo+daVCwQgMymFUiEOj4Kh
	 zwGDPwdQ1QYmgFiu9WwPHZou7zN9lMy0IdseXFt3vK3T94UGbzoHNj1mnlUuTH8zZqZGKzz5adL5Yw
	 Cb5qhR2zEnnwxMrVNNc6FzHylZ4uWcNR6Y1jtZ3EUq+mKJ9dJA1D8duyYxw2tDipGzsNFOVYRo/Uyn
	 CGxZBLXiIootXbkXmvjrBJ2IU8LwVKQ==
X-MSG-ID: db25a176-fa96-11ef-a39e-00505681446f
Date: Thu, 6 Mar 2025 15:25:29 +0100
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
Message-ID: <20250306152529.31dbfef2@erd003.prtnl>
In-Reply-To: <2025030633-covenant-bootlace-7163@gregkh>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-2-david@protonic.nl>
	<6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
	<20250305164046.4de5b6ef@erd003.prtnl>
	<mzxammninwmak5ti4c6is4pbdx3xzzziiwbxiwrldjyxgae4ok@ocec24vu4txa>
	<2025030611-embezzle-sacrament-00d9@gregkh>
	<20250306092013.1147f27e@erd003.prtnl>
	<2025030638-wavy-napkin-41ab@gregkh>
	<20250306103402.2b9e51d7@erd003.prtnl>
	<2025030633-covenant-bootlace-7163@gregkh>
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

On Thu, 6 Mar 2025 14:39:16 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Mar 06, 2025 at 10:34:02AM +0100, David Jander wrote:
> > On Thu, 6 Mar 2025 10:03:26 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >  =20
> > > On Thu, Mar 06, 2025 at 09:20:13AM +0100, David Jander wrote: =20
> > > > On Thu, 6 Mar 2025 08:18:46 +0100
> > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > >    =20
> > > > > On Thu, Mar 06, 2025 at 12:21:22AM +0100, Uwe Kleine-K=C3=B6nig w=
rote:   =20
> > > > > > Hello David,
> > > > > >=20
> > > > > > On Wed, Mar 05, 2025 at 04:40:45PM +0100, David Jander wrote:  =
   =20
> > > > > > > On Fri, 28 Feb 2025 17:44:27 +0100
> > > > > > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:  =
   =20
> > > > > > > > On Thu, Feb 27, 2025 at 05:28:17PM +0100, David Jander wrot=
e:
> > > > > > > > [...]     =20
> > > > > > > > > +static int motion_open(struct inode *inode, struct file =
*file)
> > > > > > > > > +{
> > > > > > > > > +	int minor =3D iminor(inode);
> > > > > > > > > +	struct motion_device *mdev =3D NULL, *iter;
> > > > > > > > > +	int err;
> > > > > > > > > +
> > > > > > > > > +	mutex_lock(&motion_mtx);       =20
> > > > > > > >=20
> > > > > > > > If you use guard(), error handling gets a bit easier.     =
=20
> > > > > > >=20
> > > > > > > This looks interesting. I didn't know about guard(). Thanks. =
I see the
> > > > > > > benefits, but in some cases it also makes the locked region l=
ess clearly
> > > > > > > visible. While I agree that guard() in this particular place =
is nice,
> > > > > > > I'm hesitant to try and replace all mutex_lock()/_unlock() ca=
lls with guard().
> > > > > > > Let me know if my assessment of the intended use of guard() i=
s incorrect.     =20
> > > > > >=20
> > > > > > I agree that guard() makes it harder for non-trivial functions =
to spot
> > > > > > the critical section. In my eyes this is outweight by not havin=
g to
> > > > > > unlock in all exit paths, but that might be subjective. Annother
> > > > > > downside of guard is that sparse doesn't understand it and repo=
rts
> > > > > > unbalanced locking.
> > > > > >       =20
> > > > > > > > > +	list_for_each_entry(iter, &motion_list, list) {
> > > > > > > > > +		if (iter->minor !=3D minor)
> > > > > > > > > +			continue;
> > > > > > > > > +		mdev =3D iter;
> > > > > > > > > +		break;
> > > > > > > > > +	}       =20
> > > > > > > >=20
> > > > > > > > This should be easier. If you use a cdev you can just do
> > > > > > > > container_of(inode->i_cdev, ...);     =20
> > > > > > >=20
> > > > > > > Hmm... I don't yet really understand what you mean. I will ha=
ve to study the
> > > > > > > involved code a bit more.     =20
> > > > > >=20
> > > > > > The code that I'm convinced is correct is
> > > > > > https://lore.kernel.org/linux-pwm/00c9f1181dc351e1e6041ba6e41e4=
c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com/
> > > > > >=20
> > > > > > This isn't in mainline because there is some feedback I still h=
ave to
> > > > > > address, but I think it might serve as an example anyhow.
> > > > > >      =20
> > > > > > > > > [...]
> > > > > > > > > +
> > > > > > > > > +static const struct class motion_class =3D {
> > > > > > > > > +	.name		=3D "motion",
> > > > > > > > > +	.devnode	=3D motion_devnode,       =20
> > > > > > > >=20
> > > > > > > > IIRC it's recommended to not create new classes, but a bus.=
     =20
> > > > > > >=20
> > > > > > > Interesting. I did some searching, and all I could find was t=
hat the chapter
> > > > > > > in driver-api/driver-model about classes magically vanished b=
etween versions
> > > > > > > 5.12 and 5.13. Does anyone know where I can find some informa=
tion about this?
> > > > > > > Sorry if I'm being blind...     =20
> > > > > >=20
> > > > > > Half knowledge on my end at best. I would hope that Greg knows =
some
> > > > > > details (which might even be "no, classes are fine"). I added h=
im to Cc:     =20
> > > > >=20
> > > > > A class is there for when you have a common api that devices of
> > > > > different types can talk to userspace (i.e. the UAPI is common, n=
ot the
> > > > > hardware type).  Things like input devices, tty, disks, etc.  A b=
us is
> > > > > there to be able to write different drivers to bind to for that h=
ardware
> > > > > bus type (pci, usb, i2c, platform, etc.)
> > > > >=20
> > > > > So you need both, a bus to talk to the hardware, and a class to t=
alk to
> > > > > userspace in a common way (ignore the fact that we can also talk =
to
> > > > > hardware directly from userspace like raw USB or i2c or PCI config
> > > > > space, that's all bus-specific stuff).   =20
> > > >=20
> > > > Thanks for chiming in. Let me see if I understand this correctly: I=
n this
> > > > case, I have a UAPI that is common to different types of motion con=
trol
> > > > devices. So I need a class. check.   =20
> > >=20
> > > Correct.
> > >  =20
> > > > Do I need a bus? If one can conceive other drivers or kernel parts =
that talk to
> > > > motion drivers, I would need a bus. If that doesn't make sense, I d=
on't. Right?   =20
> > >=20
> > > Correct.
> > >  =20
> > > > I actually can think of a new motion device that acts as an aggrega=
tor of
> > > > several single-channel motion devices into a single "virtual" multi=
-channel
> > > > device... so do I need also a bus? I suppose...?   =20
> > >=20
> > > Nope, that should just be another class driver.  Think about how input
> > > does this, some input /dev/ nodes are the sum of ALL input /dev/ nodes
> > > together, while others are just for individual input devices. =20
> >=20
> > Understood. Thanks!
> >  =20
> > > > Then the question remains: why did the chapter about classes vanish=
?   =20
> > >=20
> > > What are you specifically referring to?  I don't remember deleting any
> > > documentation, did files move around somehow and the links not get
> > > updated? =20
> >=20
> > This:
> > https://www.kernel.org/doc/html/v5.12/driver-api/driver-model/index.html
> >=20
> > vs this:
> > https://www.kernel.org/doc/html/v5.13/driver-api/driver-model/index.html
> >=20
> > Maybe it moved somewhere else, but I can't find it... I'd have to git b=
isect
> > or git blame between the two releases maybe. =20
>=20
> Ah, this was removed in:
> 	1364c6787525 ("docs: driver-model: Remove obsolete device class document=
ation")
> as the information there was totally incorrect, since the 2.5.69 kernel
> release.  "device classes" aren't a thing, "classes" are a thing :)

Aha. Thanks for pointing this out. The sheer removal of this, combined with
other indirect indications, such as /sys/class/gpio being replaced with
/sys/bus/gpio in the new api, Uwe's comment, etc... derailed my interpretat=
ion.
:-)

Btw, sorry to ask here and now @Greg: I didn't CC you with this whole series
while I probably should have... now I am tempted to move V2 of this series =
to
staging, due to higher chances of potentially breaking UAPI changes during
initial development, and in order to have a more flexible discussions over =
the
UAPI of LMC in general. Is that advisable or should we better make sure that
the version to get merged upstream (I hope it eventually will be) is set in
stone?

Best regards,

--=20
David Jander

