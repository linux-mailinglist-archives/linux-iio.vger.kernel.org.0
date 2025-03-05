Return-Path: <linux-iio+bounces-16436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6D3A53E59
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031757A389A
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 23:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB792046BF;
	Wed,  5 Mar 2025 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hGpe/Ugq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41941EF0BC
	for <linux-iio@vger.kernel.org>; Wed,  5 Mar 2025 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216890; cv=none; b=RWqOs9unErxF3ssmbLhPT9BBfc7Gegzy6g2KSY+JIa2oQRBu9PIfFlClXEU/goPOP2BWswGwMHzrIJzsMjN+1OZmSKyJFPdca2NRXHp3dbHsTZBjXrUF71kQbbXBZBbs/HUfDPQUimwVXyYxva6P7UroR+nhB5LV9og00MeMCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216890; c=relaxed/simple;
	bh=LYXqEZ/GNnF7105I/x7F4cJvGSIdk+36OQUyInKk3dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUpFeIv+/VSsjkyNYAzDNbzxAlH8Z4s/NCoy6A8mVM/eqRlwugYClfVEQdfSLpOCvEh59RQHJ+hWWtKu1I7PUkZ36D/9WjINYxUvH5PFUvFm6EwCbhsbzGUTW9oa+E7gIY8MSUr5bvInV0cSYe8F6sdvcQkOfgcn+hfQF7p/sfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hGpe/Ugq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bd87f7c2eso5357855e9.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Mar 2025 15:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741216887; x=1741821687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qacB18MzFobUffMftGee8Zz295Q+/XP/67XU9eQDjdA=;
        b=hGpe/UgqNoOCwxXXz3JThSZEpsBLSH/djAbsHx7RJy0pJX7wfJB4/QhuxyfJ9OLyzS
         KDoAPfTHAYwQ43LHiQufk+FHU5Z0ZkYMwCYdtg8T3X13DAPIPx2aWIMx+rf0TD2JdxNa
         WCkOpvmXsqC9e0ix1D07F6OwlzcM7A84xUSxTIdbiCUfS2MtZeh1E8X5gVhe9bhUo4CE
         WFADMYHz+TaV8LmqbOMQvPYG2tf2AEBAJaDymfgqRrdF0EvTgpE8POGSu5O9PyX4KbXQ
         J5NHHdt1RbCy8CeTr3WklfsJiHqSi1UAejxFpaXxi3nj+wdr/J1XiIG/Ks4DohJuTOgA
         dIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741216887; x=1741821687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qacB18MzFobUffMftGee8Zz295Q+/XP/67XU9eQDjdA=;
        b=nrLSt6/XinIUtiUG18OufRg3GtKIaHKzH+I2YVzAjF9zxahDuaWhtuP1VK+ZRrbxoY
         60bJ0O8hpjEoulYySWBLeBcc1BWxChQ+c0jh7DQH94sqG097Rx+aM1OHKnCH5WJRaT7k
         EbArt8rT6mcKPwGcICbvecXesy6nDDQ/hehzaG+0bA2qyLAKCCVWFwtKvybGqT8+XhNb
         0buecUevQ9JVhSjYB1CopnYdrWBsTts1AqeuvF+8P31h/HS77zI77i51XXDY5TkQHiru
         44csLG4Mm6a8N8ALNjmFhi5m4EkqukwXoR1BJTTZRze974Zop+CB+Z3f56j7uDoVDO9L
         3hmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWikXzA1V4SJh3a+IkNUV48bgSf7dfAF/9gbDV4qnhPxRMaMImOK+5zlPzQUkvME2N2y9Uzu2A568s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzabluDO2ftpEKTDqlF+p1L2bI7Ra2+paeu9Ql+hmACH7cm0OM2
	RKvZyJMxmeY0CtPk4z6OkqL6FSVwzxsZSiCKmEaqvcsjXgFvcV3mrS+cpgEZNxI=
X-Gm-Gg: ASbGncscqmE6kcy5KL/fyVhLbo8QYmQgBTGiyN0R/zOcwctL1gy4B0eeHG3ugf0ej70
	yiaAffe2QdQkhrVuD3GHaqWgHKn7oCpQAIdwQ0Undb1IPxQRJuX8QZaeRyjbZy7vdkmNmA7QhBK
	/A8+pz3YXyzOt2KuhxIANnGPMx2N2qmC4Q/vVjRPqLgCYnWBx19WSlE4q6wtjGYtWeYabfpB2Et
	2ym1+GZsHVQgAEd/DyFBvaMBpjTGlQdYlclrhizguBemr2X1A4fyrNiFcoJ2imS0cyBJZ2ovrBC
	AMxLJ2zblxFy4wSDQ+G/YkEfVCIT6K+PzVpiKpnPuLutyCw174/Nd9BeUXwsMb1nWR6PFVhvDIc
	fiEb2LbT1im8eEcI=
X-Google-Smtp-Source: AGHT+IENKXPai5TKebpsO/kveH3cbJuJ1j7cTubmsBuhS47qzTQfgDvOZrssIpixyulc1S2B2GwUAg==
X-Received: by 2002:a05:600c:3b17:b0:439:8a62:db42 with SMTP id 5b1f17b1804b1-43bd29404eemr37764975e9.8.1741216886433;
        Wed, 05 Mar 2025 15:21:26 -0800 (PST)
Received: from localhost (lfbn-nic-1-357-249.w90-116.abo.wanadoo.fr. [90.116.189.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcbcbe64fsm42848815e9.0.2025.03.05.15.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:21:25 -0800 (PST)
Date: Thu, 6 Mar 2025 00:21:22 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Jander <david@protonic.nl>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
Message-ID: <mzxammninwmak5ti4c6is4pbdx3xzzziiwbxiwrldjyxgae4ok@ocec24vu4txa>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-2-david@protonic.nl>
 <6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
 <20250305164046.4de5b6ef@erd003.prtnl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pxoguxghgkglkmsp"
Content-Disposition: inline
In-Reply-To: <20250305164046.4de5b6ef@erd003.prtnl>


--pxoguxghgkglkmsp
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
MIME-Version: 1.0

Hello David,

On Wed, Mar 05, 2025 at 04:40:45PM +0100, David Jander wrote:
> On Fri, 28 Feb 2025 17:44:27 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
> > On Thu, Feb 27, 2025 at 05:28:17PM +0100, David Jander wrote:
> > [...]
> > > +static int motion_open(struct inode *inode, struct file *file)
> > > +{
> > > +	int minor =3D iminor(inode);
> > > +	struct motion_device *mdev =3D NULL, *iter;
> > > +	int err;
> > > +
> > > +	mutex_lock(&motion_mtx); =20
> >=20
> > If you use guard(), error handling gets a bit easier.
>=20
> This looks interesting. I didn't know about guard(). Thanks. I see the
> benefits, but in some cases it also makes the locked region less clearly
> visible. While I agree that guard() in this particular place is nice,
> I'm hesitant to try and replace all mutex_lock()/_unlock() calls with gua=
rd().
> Let me know if my assessment of the intended use of guard() is incorrect.

I agree that guard() makes it harder for non-trivial functions to spot
the critical section. In my eyes this is outweight by not having to
unlock in all exit paths, but that might be subjective. Annother
downside of guard is that sparse doesn't understand it and reports
unbalanced locking.
=20
> > > +	list_for_each_entry(iter, &motion_list, list) {
> > > +		if (iter->minor !=3D minor)
> > > +			continue;
> > > +		mdev =3D iter;
> > > +		break;
> > > +	} =20
> >=20
> > This should be easier. If you use a cdev you can just do
> > container_of(inode->i_cdev, ...);
>=20
> Hmm... I don't yet really understand what you mean. I will have to study =
the
> involved code a bit more.

The code that I'm convinced is correct is
https://lore.kernel.org/linux-pwm/00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.=
1725635013.git.u.kleine-koenig@baylibre.com/

This isn't in mainline because there is some feedback I still have to
address, but I think it might serve as an example anyhow.

> > > [...]
> > > +
> > > +static const struct class motion_class =3D {
> > > +	.name		=3D "motion",
> > > +	.devnode	=3D motion_devnode, =20
> >=20
> > IIRC it's recommended to not create new classes, but a bus.
>=20
> Interesting. I did some searching, and all I could find was that the chap=
ter
> in driver-api/driver-model about classes magically vanished between versi=
ons
> 5.12 and 5.13. Does anyone know where I can find some information about t=
his?
> Sorry if I'm being blind...

Half knowledge on my end at best. I would hope that Greg knows some
details (which might even be "no, classes are fine"). I added him to Cc:

> > [...]
> > > +	devt =3D MKDEV(motion_major, mdev->minor);
> > > +	mdev->dev =3D device_create_with_groups(&motion_class, mdev->parent,
> > > +				devt, mdev, mdev->groups, "motion%d", mdev->minor); =20
> >=20
> > What makes sure that mdev doesn't go away while one of the attributes is
> > accessed?
>=20
> Good question. I suppose you mean that since mdev is devres-managed and
> device_create_with_groups() apparently isn't aware of that, so there is no
> internal lock somewhere that prevents read() or ioctl() being called whil=
e the
> devres code is freeing the memory of mdev?

I'm not sure there is an issue, but when I developed the above mentioned
patch it helped me to test these possible races. Just open the sysfs
file, unbind the device (or unload the module) and only then start
reading (or writing).

> > > +	if (IS_ERR(mdev->dev)) {
> > > +		dev_err(mdev->parent, "Error creating motion device %d\n",
> > > +				mdev->minor);
> > > +		mutex_unlock(&motion_mtx);
> > > +		goto error_free_trig_info;
> > > +	}
> > > +	list_add_tail(&mdev->list, &motion_list);
> > > +	mutex_unlock(&motion_mtx);
> > > +
> > > +	return 0;
> > > +
> > > +error_free_trig_info:
> > > +	kfree(trig_info);
> > > +error_free_trigger:
> > > +	iio_trigger_free(mdev->iiotrig);
> > > +error_free_minor:
> > > +	motion_minor_free(mdev->minor);
> > > +	dev_info(mdev->parent, "Registering motion device err=3D%d\n", err);
> > > +	return err;
> > > +}
> > > +EXPORT_SYMBOL(motion_register_device);
> > > [...]
> > > +struct mot_capabilities {
> > > +	__u32 features;
> > > +	__u8 type;
> > > +	__u8 num_channels;
> > > +	__u8 num_int_triggers;
> > > +	__u8 num_ext_triggers;
> > > +	__u8 max_profiles;
> > > +	__u8 max_vpoints;
> > > +	__u8 max_apoints;
> > > +	__u8 reserved1;
> > > +	__u32 subdiv; /* Position unit sub-divisions, microsteps, etc... */
> > > +	/*
> > > +	 * Coefficients for converting to/from controller time <--> seconds.
> > > +	 * Speed[1/s] =3D Speed[controller_units] * conv_mul / conv_div
> > > +	 * Accel[1/s^2] =3D Accel[controller_units] * conv_mul / conv_div
> > > +	 */
> > > +	__u32 speed_conv_mul;
> > > +	__u32 speed_conv_div;
> > > +	__u32 accel_conv_mul;
> > > +	__u32 accel_conv_div;
> > > +	__u32 reserved2;
> > > +}; =20
> >=20
> > https://docs.kernel.org/gpu/imagination/uapi.html (which has some
> > generic bits that apply here, too) has: "The overall struct must be
> > padded to 64-bit alignment." If you drop reserved2 the struct is
> > properly sized (or I counted wrongly).
>=20
> Oh, thanks for pointing that out... I wouldn't have searched for that
> information in that particular place tbh. ;-)
>=20
> I am tempted to add another __u32 reserved3 though instead. Better to have
> some leeway if something needs to be added in a backwards-compatible way =
later.

Note that you don't need reserved fields at the end because in the
ioctl handler you know the size of the passed struct. So if the need to
add members to the struct arise, you can do that by checking for the
size. This is even more flexible because otherwise you can only add
fields that must be 0 when the old behaviour is intended. Most of the
time this is no problem. But only most.
=20
> > > +struct mot_speed_duration {
> > > +	__u32 channel;
> > > +	speed_raw_t speed; =20
> >=20
> > What is the unit here?
>=20
> Speed doesn't have a fixed unit in this case. Or rather, the unit is
> device-dependent. For a motor it could be rotations per second, micro-ste=
ps per
> second, etc... while for a linear actuator, it could be micrometers per s=
econd.
>=20
> Why no fixed unit? That's because in practice many devices (controllers) =
have
> their inherent base-unit, and it would get overly complicated if one need=
ed to
> convert back and forth between that and some universal unit just for the =
sake
> of uniformity, and user-space most certainly expects the same unit as the
> hardware device it was initially designed for. So in this case it is a de=
sign
> decision to make user-space deal with unit-conversion if it is necessary =
to do
> so.

Sad, so a userspace process still has to know some internal things about
the motor it drives. :-\

Best regards
Uwe

--pxoguxghgkglkmsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfI3G8ACgkQj4D7WH0S
/k6WWwgAq03768ktc23FO561aNP/9BC0Pt1zK+XHVMrfRyy1A9lsJZ57APt4S4BG
pUwyaTDT8NutC9OIjjqlhr87nGJhJ01/xiEQskiAwz2oT4V05jIIFmGoVN4EGZWl
Iyj/H8NR8UxqvFCF2sxJ2bNQFU27h+LoEP/CKEne08tWGOTwAmEkslRWITt3Dbcy
ZIki1FvxHzGMoH+g9lwJJkFcITRZ5dL2bZhL5iT83o7Vz4MA5VXR4fsmJMDxDeRA
bAFz1MJ7uVAE6iTKWZOVRsH1bssF3cIWDKfn7W6In3KYSBDAKdCcuJaVMxItbJhp
2sTlQ7h0o4+RLgXvL9MBLfKQfXyNng==
=fiHI
-----END PGP SIGNATURE-----

--pxoguxghgkglkmsp--

