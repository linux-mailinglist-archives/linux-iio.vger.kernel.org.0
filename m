Return-Path: <linux-iio+bounces-16464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A4AA54639
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 10:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE3A3AF7DB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E15209681;
	Thu,  6 Mar 2025 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="ngNBnlNb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190D920101A
	for <linux-iio@vger.kernel.org>; Thu,  6 Mar 2025 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253147; cv=none; b=l4qDWkj8tUhdi4xuZ5lQvit2fq6h46yBsNk3q8Nq9Ut7S5vxSAe4yMrQpToXslDqYczVnKa1KX+GUeA54DOgMdGS9+sajhx6I+CAkoJuu2vCsKU3DAV9HscmzAVkniftznDdcW6pemNCS2YTC1Lkcl0BFgyvwqnK4wOPmTo3aI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253147; c=relaxed/simple;
	bh=ujhTmBxUWe+Povm0t6oeR6nbXG8MvwSz6Fg4OmoZmwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPLb/maTvWOYkRUsEvMcwUo7H/FvhtAwpl9lK5R1ARmAX8Z/8K8BjdvpetfoDM2qhNh4K9swjI19c4FvMI7T6yEtfOCB4FVHo1naYnTprs8C6Ni/ikfC+thk08zrgBskJJqOg1KKxfotumZtU68t6rsYBlrGRCFoBjfjjB037Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=ngNBnlNb; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=wJYrZH4XiQ1CcC+Mtz4pQ13yx/4NwG3+aWLIrFAyMis=;
	b=ngNBnlNbsbOzcvc5HdJ8mMNutTGWV4/TG4lwHuvi9B+QJOoNofX80+azVgOLq5mNSZZDzB69f9vKU
	 goMGjIWtTn4V9jQBAc5U+iEBS6a4+Se7y8Q6xgOPvtrEr740ypy2CBSz0PaLwStmDaVynYlYIJkZqF
	 c6Z33Oay6ZfE9td96Ebx/2eLN+1ntTw/+YWLiaKywN48NkDAFov4EJPU0VokA0wIewQZF04j5Kr443
	 juHRIRQRkHv5fBxlRYxC8zLB17pPGQsknbQOaltv4idRha9cqk/nO51yrrLfMl/WqJT+FqrzZGO1KB
	 gO/724LfzioUcfagVOjU9GTjA6fDg1w==
X-MSG-ID: f9080ddd-fa6c-11ef-a39e-00505681446f
Date: Thu, 6 Mar 2025 10:25:40 +0100
From: David Jander <david@protonic.nl>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
Message-ID: <20250306102540.7f0f6146@erd003.prtnl>
In-Reply-To: <mzxammninwmak5ti4c6is4pbdx3xzzziiwbxiwrldjyxgae4ok@ocec24vu4txa>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-2-david@protonic.nl>
	<6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
	<20250305164046.4de5b6ef@erd003.prtnl>
	<mzxammninwmak5ti4c6is4pbdx3xzzziiwbxiwrldjyxgae4ok@ocec24vu4txa>
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

On Thu, 6 Mar 2025 00:21:22 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello David,
>=20
> On Wed, Mar 05, 2025 at 04:40:45PM +0100, David Jander wrote:
> > On Fri, 28 Feb 2025 17:44:27 +0100
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote: =20
> > > On Thu, Feb 27, 2025 at 05:28:17PM +0100, David Jander wrote:
> > > [...] =20
> > > > +static int motion_open(struct inode *inode, struct file *file)
> > > > +{
> > > > +	int minor =3D iminor(inode);
> > > > +	struct motion_device *mdev =3D NULL, *iter;
> > > > +	int err;
> > > > +
> > > > +	mutex_lock(&motion_mtx);   =20
> > >=20
> > > If you use guard(), error handling gets a bit easier. =20
> >=20
> > This looks interesting. I didn't know about guard(). Thanks. I see the
> > benefits, but in some cases it also makes the locked region less clearly
> > visible. While I agree that guard() in this particular place is nice,
> > I'm hesitant to try and replace all mutex_lock()/_unlock() calls with g=
uard().
> > Let me know if my assessment of the intended use of guard() is incorrec=
t. =20
>=20
> I agree that guard() makes it harder for non-trivial functions to spot
> the critical section. In my eyes this is outweight by not having to
> unlock in all exit paths, but that might be subjective. Annother
> downside of guard is that sparse doesn't understand it and reports
> unbalanced locking.

What I was referring to, and what I want to know is, is it okay to mix guar=
d()
with lock/unlock? I.e. Use guard() when there are multiple exit paths invol=
ved
and revert back to simple lock/unlock if it is just to encase a handful of
non-exiting operations?

> > > > +	list_for_each_entry(iter, &motion_list, list) {
> > > > +		if (iter->minor !=3D minor)
> > > > +			continue;
> > > > +		mdev =3D iter;
> > > > +		break;
> > > > +	}   =20
> > >=20
> > > This should be easier. If you use a cdev you can just do
> > > container_of(inode->i_cdev, ...); =20
> >=20
> > Hmm... I don't yet really understand what you mean. I will have to stud=
y the
> > involved code a bit more. =20
>=20
> The code that I'm convinced is correct is
> https://lore.kernel.org/linux-pwm/00c9f1181dc351e1e6041ba6e41e4c30b12b6a2=
7.1725635013.git.u.kleine-koenig@baylibre.com/
>=20
> This isn't in mainline because there is some feedback I still have to
> address, but I think it might serve as an example anyhow.

Thanks. I will study this example.

> > > > [...]
> > > > +
> > > > +static const struct class motion_class =3D {
> > > > +	.name		=3D "motion",
> > > > +	.devnode	=3D motion_devnode,   =20
> > >=20
> > > IIRC it's recommended to not create new classes, but a bus. =20
> >=20
> > Interesting. I did some searching, and all I could find was that the ch=
apter
> > in driver-api/driver-model about classes magically vanished between ver=
sions
> > 5.12 and 5.13. Does anyone know where I can find some information about=
 this?
> > Sorry if I'm being blind... =20
>=20
> Half knowledge on my end at best. I would hope that Greg knows some
> details (which might even be "no, classes are fine"). I added him to Cc:
>=20
> > > [...] =20
> > > > +	devt =3D MKDEV(motion_major, mdev->minor);
> > > > +	mdev->dev =3D device_create_with_groups(&motion_class, mdev->pare=
nt,
> > > > +				devt, mdev, mdev->groups, "motion%d", mdev->minor);   =20
> > >=20
> > > What makes sure that mdev doesn't go away while one of the attributes=
 is
> > > accessed? =20
> >=20
> > Good question. I suppose you mean that since mdev is devres-managed and
> > device_create_with_groups() apparently isn't aware of that, so there is=
 no
> > internal lock somewhere that prevents read() or ioctl() being called wh=
ile the
> > devres code is freeing the memory of mdev? =20
>=20
> I'm not sure there is an issue, but when I developed the above mentioned
> patch it helped me to test these possible races. Just open the sysfs
> file, unbind the device (or unload the module) and only then start
> reading (or writing).

Will check this. Thanks.

> > > > +	if (IS_ERR(mdev->dev)) {
> > > > +		dev_err(mdev->parent, "Error creating motion device %d\n",
> > > > +				mdev->minor);
> > > > +		mutex_unlock(&motion_mtx);
> > > > +		goto error_free_trig_info;
> > > > +	}
> > > > +	list_add_tail(&mdev->list, &motion_list);
> > > > +	mutex_unlock(&motion_mtx);
> > > > +
> > > > +	return 0;
> > > > +
> > > > +error_free_trig_info:
> > > > +	kfree(trig_info);
> > > > +error_free_trigger:
> > > > +	iio_trigger_free(mdev->iiotrig);
> > > > +error_free_minor:
> > > > +	motion_minor_free(mdev->minor);
> > > > +	dev_info(mdev->parent, "Registering motion device err=3D%d\n", er=
r);
> > > > +	return err;
> > > > +}
> > > > +EXPORT_SYMBOL(motion_register_device);
> > > > [...]
> > > > +struct mot_capabilities {
> > > > +	__u32 features;
> > > > +	__u8 type;
> > > > +	__u8 num_channels;
> > > > +	__u8 num_int_triggers;
> > > > +	__u8 num_ext_triggers;
> > > > +	__u8 max_profiles;
> > > > +	__u8 max_vpoints;
> > > > +	__u8 max_apoints;
> > > > +	__u8 reserved1;
> > > > +	__u32 subdiv; /* Position unit sub-divisions, microsteps, etc... =
*/
> > > > +	/*
> > > > +	 * Coefficients for converting to/from controller time <--> secon=
ds.
> > > > +	 * Speed[1/s] =3D Speed[controller_units] * conv_mul / conv_div
> > > > +	 * Accel[1/s^2] =3D Accel[controller_units] * conv_mul / conv_div
> > > > +	 */
> > > > +	__u32 speed_conv_mul;
> > > > +	__u32 speed_conv_div;
> > > > +	__u32 accel_conv_mul;
> > > > +	__u32 accel_conv_div;
> > > > +	__u32 reserved2;
> > > > +};   =20
> > >=20
> > > https://docs.kernel.org/gpu/imagination/uapi.html (which has some
> > > generic bits that apply here, too) has: "The overall struct must be
> > > padded to 64-bit alignment." If you drop reserved2 the struct is
> > > properly sized (or I counted wrongly). =20
> >=20
> > Oh, thanks for pointing that out... I wouldn't have searched for that
> > information in that particular place tbh. ;-)
> >=20
> > I am tempted to add another __u32 reserved3 though instead. Better to h=
ave
> > some leeway if something needs to be added in a backwards-compatible wa=
y later. =20
>=20
> Note that you don't need reserved fields at the end because in the
> ioctl handler you know the size of the passed struct. So if the need to
> add members to the struct arise, you can do that by checking for the
> size. This is even more flexible because otherwise you can only add
> fields that must be 0 when the old behaviour is intended. Most of the
> time this is no problem. But only most.

You are right. Thanks.

> > > > +struct mot_speed_duration {
> > > > +	__u32 channel;
> > > > +	speed_raw_t speed;   =20
> > >=20
> > > What is the unit here? =20
> >=20
> > Speed doesn't have a fixed unit in this case. Or rather, the unit is
> > device-dependent. For a motor it could be rotations per second, micro-s=
teps per
> > second, etc... while for a linear actuator, it could be micrometers per=
 second.
> >=20
> > Why no fixed unit? That's because in practice many devices (controllers=
) have
> > their inherent base-unit, and it would get overly complicated if one ne=
eded to
> > convert back and forth between that and some universal unit just for th=
e sake
> > of uniformity, and user-space most certainly expects the same unit as t=
he
> > hardware device it was initially designed for. So in this case it is a =
design
> > decision to make user-space deal with unit-conversion if it is necessar=
y to do
> > so. =20
>=20
> Sad, so a userspace process still has to know some internal things about
> the motor it drives. :-\

Unfortunately that is almost impossible to avoid entirely.
You can replace one stepper motor driver with another that might have
different micro-stepping subdivision, by looking at struct
mot_capabilities.subdiv, but a simple brushed DC motor just isn't able to
replace a stepper motor in all but the most trivial applications. I also th=
ink
that burdening the kernel with all sorts of complicated math to model the
mechanical conversion factors involved in anything that's connected to the
motor drive shaft is overkill. As well as trying to emulate all missing
capabilities from a motion device that is lacking that functionality native=
ly.

So just like in IIO you cannot just replace one ADC with any other, in LMC =
you
also cannot replace any device with any other.

That's why there is struct mot_capabilities and MOT_IOCTL_GET_CAPA. It enab=
les
user-space to optionally support different devices more easily. It is proba=
bly
best used in conjunction with a LMC user-space library, although I don't wa=
nt
to rely on such a library for being able to use LMC. There is some middle
ground here I guess... just like in IIO.

One thing I could try to improve though, is to include some additional
information in struct mot_capabilities that tells something more about the
nature of the used units, just like the speed_conv and accel_conv constants=
 do
for time conversion. Something that can be placed in the device tree (possi=
bly
in a motor child-node connected to the motor-controller) that contains some
conversion constant for distance. That way, if one were to (for example)
replace a stepper motor with a BLDC motor + encoder in a new hardware
revision, this constant could be used to make the units backwards compatibl=
e.

As background information: A stepper motor controller counts distance in st=
eps
and/or micro-steps. There are mot_capabilities.subdiv micro-steps in each
step. The amount of angle the actual motor shaft advances with each whole s=
tep
depends on the motor construction and is often 200 steps per revolution (1.8
degrees), but can vary from 4 to 400 steps per revolution depending on the
motor. So it is not only the controller that matters but also the type of
motor. This suggests the need of motor sub-nodes in the device-tree if one
wanted to extend the hardware knowledge further down from the motor driver.
But then there are gear boxes, pulleys, etc... it's basically conversion
factors all the way down. How many of them is sensible to bother the kernel
with?

Best regards,

--=20
David Jander

