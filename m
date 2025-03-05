Return-Path: <linux-iio+bounces-16431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B785A5039C
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 16:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA143A79C8
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 15:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8AF250BE0;
	Wed,  5 Mar 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="Qk+UO+6v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D512500AA
	for <linux-iio@vger.kernel.org>; Wed,  5 Mar 2025 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189258; cv=none; b=ir162gIbmbDZofTIyDw5XB64uakLXPD9PXjZ0RbrC+JOJDY2YBHasvxsmf/Mc/3oTAdDik9k3LNiEp6vIPzVYPqQ3xnBGhlpcxLsh1xJPtBiC7plaC9guMdNCq+sC/jLxqB/Ex0R44A/QrQyTH3EmtIKWEfPZrc5Uj8D+F1P7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189258; c=relaxed/simple;
	bh=S5V4K4G9/5vJWNMjiayM1hFuWoqlo2JQsadqMzM6j4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qALWIs+bRdYjpGvDhmWmZssux1o6ZyOJ8P4BsvrMrvr+hlje3ppZqE3MJZRFpne28LZDlng6ZZXhNdzq/4Q+JGG0ZagmcFSaniRTQdDhaJR9C61a//qIfbivcqXetQ3mDNFCdv9ghgFBxuu/nTdQ13FJiAOTUxonP6wPI+q6ItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=Qk+UO+6v; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=E+kuQhjj9xzNE6BQn+tsChkhWmfrDEIZBYOWMsZmgiI=;
	b=Qk+UO+6vvgBlPcvycrq9X9afftKz9msDJkOE4JHf9WXUXPHPlDemBTl6Ow4XjhWWOX8wlJfzCpxib
	 aOlPD38wDrVUqO9xCaJ2kdtI/nY7hFlIS5xz4peuoSM/nPQFVd0a21QBOXFZC2HDtJH4Ac3i/KzSfX
	 Oe5rqDbpHNRkglhrSfp9ki803Bxw/F2P3m5Dsob6QFhhTIajO1VhK7z/LdPNGeAsgebx5uYAKlSeJe
	 uhEqeA3Te23Ec9/ctbFt3XU2h2F2WDzXYWI7GI6IS2qBkpAapzGHuvnNZyjUgadFJG50U8Jpw7xvY7
	 EN6XLHNM+2dvv0oJCmnKzo6Xg4glinA==
X-MSG-ID: 34bb63cf-f9d8-11ef-a39e-00505681446f
Date: Wed, 5 Mar 2025 16:40:45 +0100
From: David Jander <david@protonic.nl>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
Message-ID: <20250305164046.4de5b6ef@erd003.prtnl>
In-Reply-To: <6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-2-david@protonic.nl>
	<6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
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


Hi Uwe,

On Fri, 28 Feb 2025 17:44:27 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello David,
>=20
> just a few highlevel review comments inline.

Thanks...

> On Thu, Feb 27, 2025 at 05:28:17PM +0100, David Jander wrote:
> [...]
> > +static int motion_open(struct inode *inode, struct file *file)
> > +{
> > +	int minor =3D iminor(inode);
> > +	struct motion_device *mdev =3D NULL, *iter;
> > +	int err;
> > +
> > +	mutex_lock(&motion_mtx); =20
>=20
> If you use guard(), error handling gets a bit easier.

This looks interesting. I didn't know about guard(). Thanks. I see the
benefits, but in some cases it also makes the locked region less clearly
visible. While I agree that guard() in this particular place is nice,
I'm hesitant to try and replace all mutex_lock()/_unlock() calls with guard=
().
Let me know if my assessment of the intended use of guard() is incorrect.

> > +	list_for_each_entry(iter, &motion_list, list) {
> > +		if (iter->minor !=3D minor)
> > +			continue;
> > +		mdev =3D iter;
> > +		break;
> > +	} =20
>=20
> This should be easier. If you use a cdev you can just do
> container_of(inode->i_cdev, ...);

Hmm... I don't yet really understand what you mean. I will have to study the
involved code a bit more.

> [...]
> > +static int motion_release(struct inode *inode, struct file *file)
> > +{
> > +	struct motion_device *mdev =3D file->private_data;
> > +	int i;
> > +
> > +	if (mdev->ops.device_release)
> > +		mdev->ops.device_release(mdev);
> > +
> > +	for (i =3D 0; i < mdev->num_gpios; i++) {
> > +		int irq;
> > +		struct motion_gpio_input *gpio =3D &mdev->gpios[i];
> > +
> > +		if (gpio->function =3D=3D MOT_INP_FUNC_NONE)
> > +			continue;
> > +		irq =3D gpiod_to_irq(gpio->gpio);
> > +		devm_free_irq(mdev->dev, irq, gpio); =20
>=20
> It seems devm is just overhead here if you release by hand anyhow.

Ack. This looks indeed unnecessary... I'll try to use non-devres calls here.

> > [...]
> > +
> > +static const struct class motion_class =3D {
> > +	.name		=3D "motion",
> > +	.devnode	=3D motion_devnode, =20
>=20
> IIRC it's recommended to not create new classes, but a bus.

Interesting. I did some searching, and all I could find was that the chapter
in driver-api/driver-model about classes magically vanished between versions
5.12 and 5.13. Does anyone know where I can find some information about thi=
s?
Sorry if I'm being blind...

> [...]
> > +int motion_register_device(struct motion_device *mdev)
> > +{
> > +	dev_t devt;
> > +	int err =3D 0;
> > +	struct iio_motion_trigger_info *trig_info;
> > +
> > +	if (!mdev->capabilities.num_channels)
> > +		mdev->capabilities.num_channels =3D 1;
> > +	if (mdev->capabilities.features | MOT_FEATURE_PROFILE)
> > +		mdev->capabilities.max_profiles =3D MOT_MAX_PROFILES;
> > +	if (!mdev->capabilities.speed_conv_mul)
> > +		mdev->capabilities.speed_conv_mul =3D 1;
> > +	if (!mdev->capabilities.speed_conv_div)
> > +		mdev->capabilities.speed_conv_div =3D 1;
> > +	if (!mdev->capabilities.accel_conv_mul)
> > +		mdev->capabilities.accel_conv_mul =3D 1;
> > +	if (!mdev->capabilities.accel_conv_div)
> > +		mdev->capabilities.accel_conv_div =3D 1;
> > +
> > +	mutex_init(&mdev->mutex);
> > +	mutex_init(&mdev->read_mutex);
> > +	INIT_KFIFO(mdev->events);
> > +	init_waitqueue_head(&mdev->wait);
> > +
> > +	err =3D motion_of_parse_gpios(mdev);
> > +	if (err)
> > +		return err;
> > +
> > +	mdev->minor =3D motion_minor_alloc();
> > +
> > +	mdev->iiotrig =3D iio_trigger_alloc(NULL, "mottrig%d", mdev->minor);
> > +	if (!mdev->iiotrig) {
> > +		err =3D -ENOMEM;
> > +		goto error_free_minor;
> > +	}
> > +
> > +	trig_info =3D kzalloc(sizeof(*trig_info), GFP_KERNEL);
> > +	if (!trig_info) {
> > +		err =3D -ENOMEM;
> > +		goto error_free_trigger;
> > +	}
> > +
> > +	iio_trigger_set_drvdata(mdev->iiotrig, trig_info);
> > +
> > +	trig_info->minor =3D mdev->minor;
> > +	err =3D iio_trigger_register(mdev->iiotrig);
> > +	if (err)
> > +		goto error_free_trig_info;
> > +
> > +	mdev->iiowork =3D IRQ_WORK_INIT_HARD(motion_trigger_work);
> > +
> > +	INIT_LIST_HEAD(&mdev->list);
> > +
> > +	mutex_lock(&motion_mtx);
> > +
> > +	devt =3D MKDEV(motion_major, mdev->minor);
> > +	mdev->dev =3D device_create_with_groups(&motion_class, mdev->parent,
> > +				devt, mdev, mdev->groups, "motion%d", mdev->minor); =20
>=20
> What makes sure that mdev doesn't go away while one of the attributes is
> accessed?

Good question. I suppose you mean that since mdev is devres-managed and
device_create_with_groups() apparently isn't aware of that, so there is no
internal lock somewhere that prevents read() or ioctl() being called while =
the
devres code is freeing the memory of mdev?

I will try to search for some example code to see how something like this is
handled in other places. I assume I'd need to add a per-mdev lock or use the
big motion_mtx everywhere... which sounds like a performance penalty that
should be avoidable. If you know of a good example to learn from, I'd be
grateful to know.

> > +	if (IS_ERR(mdev->dev)) {
> > +		dev_err(mdev->parent, "Error creating motion device %d\n",
> > +				mdev->minor);
> > +		mutex_unlock(&motion_mtx);
> > +		goto error_free_trig_info;
> > +	}
> > +	list_add_tail(&mdev->list, &motion_list);
> > +	mutex_unlock(&motion_mtx);
> > +
> > +	return 0;
> > +
> > +error_free_trig_info:
> > +	kfree(trig_info);
> > +error_free_trigger:
> > +	iio_trigger_free(mdev->iiotrig);
> > +error_free_minor:
> > +	motion_minor_free(mdev->minor);
> > +	dev_info(mdev->parent, "Registering motion device err=3D%d\n", err);
> > +	return err;
> > +}
> > +EXPORT_SYMBOL(motion_register_device);
> > [...]
> > +struct mot_capabilities {
> > +	__u32 features;
> > +	__u8 type;
> > +	__u8 num_channels;
> > +	__u8 num_int_triggers;
> > +	__u8 num_ext_triggers;
> > +	__u8 max_profiles;
> > +	__u8 max_vpoints;
> > +	__u8 max_apoints;
> > +	__u8 reserved1;
> > +	__u32 subdiv; /* Position unit sub-divisions, microsteps, etc... */
> > +	/*
> > +	 * Coefficients for converting to/from controller time <--> seconds.
> > +	 * Speed[1/s] =3D Speed[controller_units] * conv_mul / conv_div
> > +	 * Accel[1/s^2] =3D Accel[controller_units] * conv_mul / conv_div
> > +	 */
> > +	__u32 speed_conv_mul;
> > +	__u32 speed_conv_div;
> > +	__u32 accel_conv_mul;
> > +	__u32 accel_conv_div;
> > +	__u32 reserved2;
> > +}; =20
>=20
> https://docs.kernel.org/gpu/imagination/uapi.html (which has some
> generic bits that apply here, too) has: "The overall struct must be
> padded to 64-bit alignment." If you drop reserved2 the struct is
> properly sized (or I counted wrongly).

Oh, thanks for pointing that out... I wouldn't have searched for that
information in that particular place tbh. ;-)

I am tempted to add another __u32 reserved3 though instead. Better to have
some leeway if something needs to be added in a backwards-compatible way la=
ter.

> > +struct mot_speed_duration {
> > +	__u32 channel;
> > +	speed_raw_t speed; =20
>=20
> What is the unit here?

Speed doesn't have a fixed unit in this case. Or rather, the unit is
device-dependent. For a motor it could be rotations per second, micro-steps=
 per
second, etc... while for a linear actuator, it could be micrometers per sec=
ond.

Why no fixed unit? That's because in practice many devices (controllers) ha=
ve
their inherent base-unit, and it would get overly complicated if one needed=
 to
convert back and forth between that and some universal unit just for the sa=
ke
of uniformity, and user-space most certainly expects the same unit as the
hardware device it was initially designed for. So in this case it is a desi=
gn
decision to make user-space deal with unit-conversion if it is necessary to=
 do
so.

> > +	mot_time_t duration; =20
>=20
> duration_ns? That makes usage much more ideomatic and there should be no
> doubts what the unit is.

Yes, mot_time_t is defined as nanoseconds, so I'll add the _ns suffix here.

> > +	pos_raw_t distance; =20
>=20
> What is the unit here?

Again this unit can have different meanings: micrometers, micro-steps,
angle-degrees, etc... so what suffix to use?

> > +	__u32 reserved[3]; =20
>=20
> Again the padding is wrong here.

Will fix. thanks.
=20
Best regards,

--=20
David Jander

