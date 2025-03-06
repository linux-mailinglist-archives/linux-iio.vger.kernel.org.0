Return-Path: <linux-iio+bounces-16459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ED2A54494
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 09:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A163171D94
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764FD1FC11D;
	Thu,  6 Mar 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="btdUpXCk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980AF1A238D
	for <linux-iio@vger.kernel.org>; Thu,  6 Mar 2025 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249221; cv=none; b=ksyKFMlKKqmH0ghz5D2p+uYEdeHq8Qi47SmAZ5ogBXyP388obQCHqkqR8Q21TnwMDD/Fpf5hX8RIkaIyeKLP2Kj2lT/JLxopJpvZ4Tgzn3CkLPKDOktz0Y4C5mGaqx1hLsGflF9gqrNjjR3RLyhNwnqLjpnWSI4//bQjkCj48Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249221; c=relaxed/simple;
	bh=kceH0gTrTRVWZzXH93HjhlGVBTj2mbk4AUyaS4+UToM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtKqj7FIdHuWXHEuovbNBkC0QYcyrOMVV6dnUD1J5Och5P8lLp4o2ZtpPvEIK9YEM3kCyvrlUyWSHizBSmcDUoB24YpBSqD7n0sVKYnu3MfYGm2tKOHlCOPystYl2hzGfv2vT7D1ZsO5Sr9pfucT6xxYxCNwWllZFNKt6PyR4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=btdUpXCk; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=+lejcC24gc0iyhaiB1u+hyb9XJFYxfRXSIGs4t6bvk4=;
	b=btdUpXCkXyXHybWKKSrI8Spk1EYJ4kyvUqTVl9D31+thMsJf8szZRebmNpC56qJzKaa2Q3UKGufYy
	 aypgWEnSRAMbMCiCiNYYlJStMZB3LF57Mg9UH32m8NNGn+5FNiDG4aLbjiAuYAsxtaJyhwwuDsmUhi
	 E3VXpsLoRKerGAJFqs7NTx6PyTU74X/w8gx3TMre+W50NOCVxRMIdjBNb7tRk42iDhtRmVfHavD6Xy
	 Jhjk1pW63KFs0ifHfQqvzi2jjXaHhvFADwlycqOkGPU4VOxwfbmGTTaSjbnpPBK1aXV830Vg6MbhG1
	 ycw8Zs1X01zsYZLIX7zxM7PO1JnrJoQ==
X-MSG-ID: d4355bb4-fa63-11ef-a39e-00505681446f
Date: Thu, 6 Mar 2025 09:20:13 +0100
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
Message-ID: <20250306092013.1147f27e@erd003.prtnl>
In-Reply-To: <2025030611-embezzle-sacrament-00d9@gregkh>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-2-david@protonic.nl>
	<6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
	<20250305164046.4de5b6ef@erd003.prtnl>
	<mzxammninwmak5ti4c6is4pbdx3xzzziiwbxiwrldjyxgae4ok@ocec24vu4txa>
	<2025030611-embezzle-sacrament-00d9@gregkh>
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

On Thu, 6 Mar 2025 08:18:46 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Mar 06, 2025 at 12:21:22AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello David,
> >=20
> > On Wed, Mar 05, 2025 at 04:40:45PM +0100, David Jander wrote: =20
> > > On Fri, 28 Feb 2025 17:44:27 +0100
> > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote: =20
> > > > On Thu, Feb 27, 2025 at 05:28:17PM +0100, David Jander wrote:
> > > > [...] =20
> > > > > +static int motion_open(struct inode *inode, struct file *file)
> > > > > +{
> > > > > +	int minor =3D iminor(inode);
> > > > > +	struct motion_device *mdev =3D NULL, *iter;
> > > > > +	int err;
> > > > > +
> > > > > +	mutex_lock(&motion_mtx);   =20
> > > >=20
> > > > If you use guard(), error handling gets a bit easier. =20
> > >=20
> > > This looks interesting. I didn't know about guard(). Thanks. I see the
> > > benefits, but in some cases it also makes the locked region less clea=
rly
> > > visible. While I agree that guard() in this particular place is nice,
> > > I'm hesitant to try and replace all mutex_lock()/_unlock() calls with=
 guard().
> > > Let me know if my assessment of the intended use of guard() is incorr=
ect. =20
> >=20
> > I agree that guard() makes it harder for non-trivial functions to spot
> > the critical section. In my eyes this is outweight by not having to
> > unlock in all exit paths, but that might be subjective. Annother
> > downside of guard is that sparse doesn't understand it and reports
> > unbalanced locking.
> >   =20
> > > > > +	list_for_each_entry(iter, &motion_list, list) {
> > > > > +		if (iter->minor !=3D minor)
> > > > > +			continue;
> > > > > +		mdev =3D iter;
> > > > > +		break;
> > > > > +	}   =20
> > > >=20
> > > > This should be easier. If you use a cdev you can just do
> > > > container_of(inode->i_cdev, ...); =20
> > >=20
> > > Hmm... I don't yet really understand what you mean. I will have to st=
udy the
> > > involved code a bit more. =20
> >=20
> > The code that I'm convinced is correct is
> > https://lore.kernel.org/linux-pwm/00c9f1181dc351e1e6041ba6e41e4c30b12b6=
a27.1725635013.git.u.kleine-koenig@baylibre.com/
> >=20
> > This isn't in mainline because there is some feedback I still have to
> > address, but I think it might serve as an example anyhow.
> >  =20
> > > > > [...]
> > > > > +
> > > > > +static const struct class motion_class =3D {
> > > > > +	.name		=3D "motion",
> > > > > +	.devnode	=3D motion_devnode,   =20
> > > >=20
> > > > IIRC it's recommended to not create new classes, but a bus. =20
> > >=20
> > > Interesting. I did some searching, and all I could find was that the =
chapter
> > > in driver-api/driver-model about classes magically vanished between v=
ersions
> > > 5.12 and 5.13. Does anyone know where I can find some information abo=
ut this?
> > > Sorry if I'm being blind... =20
> >=20
> > Half knowledge on my end at best. I would hope that Greg knows some
> > details (which might even be "no, classes are fine"). I added him to Cc=
: =20
>=20
> A class is there for when you have a common api that devices of
> different types can talk to userspace (i.e. the UAPI is common, not the
> hardware type).  Things like input devices, tty, disks, etc.  A bus is
> there to be able to write different drivers to bind to for that hardware
> bus type (pci, usb, i2c, platform, etc.)
>=20
> So you need both, a bus to talk to the hardware, and a class to talk to
> userspace in a common way (ignore the fact that we can also talk to
> hardware directly from userspace like raw USB or i2c or PCI config
> space, that's all bus-specific stuff).

Thanks for chiming in. Let me see if I understand this correctly: In this
case, I have a UAPI that is common to different types of motion control
devices. So I need a class. check.

Do I need a bus? If one can conceive other drivers or kernel parts that tal=
k to
motion drivers, I would need a bus. If that doesn't make sense, I don't. Ri=
ght?

I actually can think of a new motion device that acts as an aggregator of
several single-channel motion devices into a single "virtual" multi-channel
device... so do I need also a bus? I suppose...?

Then the question remains: why did the chapter about classes vanish?

Best regards,

--=20
David Jander


