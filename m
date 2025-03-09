Return-Path: <linux-iio+bounces-16625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6862A5864E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF9D3A7E6E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758CC1E32D4;
	Sun,  9 Mar 2025 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8l0st9r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315813B2A4;
	Sun,  9 Mar 2025 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541581; cv=none; b=QI7y+Z6g/Zaw+6ly0TefQ8T0BJqJ80XjJoQ7FHYiwiJTY9qonHdIR6jTv3NILjI34JPtSzm0/Rrwa7IOsvLfkCqvyu3oaknGfh01dmEJcHqO+WYbjti/gg9h9QZbwLrvjk9u5qBoI/OXAxNK//N+Srsxf7qJiCHyh01pxN1HM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541581; c=relaxed/simple;
	bh=1UgctfymUV83xC3ix68vRlr3FAGTggR5aGYQLCNzbDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2EuKmcvUL+YqL4g4yCcnM6Tt4TS3hYai4EaX/GDMl5vDghuScTfDhweG9W2KbHxX4YX2AuGdYgDXwGv0o39TphKNWX6CzqYEx5mXTXXfwP2OerM8kBCehjTne60hv4egfrvJ5HPbOHU7W3DyK0UfbXXiL8SmgTrdNONpWptoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8l0st9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D34C4CEE5;
	Sun,  9 Mar 2025 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741541580;
	bh=1UgctfymUV83xC3ix68vRlr3FAGTggR5aGYQLCNzbDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y8l0st9r5NUNHRLdUc6QAuvfdp7z/SGXIVYgdibKL3oMiKK/TWKbgUu7of3jDgSJT
	 xa1+UvktOZf0ZyjgzcCB1VpcCY/RKn8nBSglNhwCA4obeuG7RDSB3iWMVUsU7W2DAr
	 ubx4ZOMoG4vanFDBA+k9aONrtifQ7qKeL9dyoh/2DOjpUR7Wk6u21gPeGBKYjyoX/X
	 46lReRVXDgt4bRDZ2s5wJ2Yh0XD/nkaAxQxZwLUrTEGDFolP7YD56S7J2kLZKHnK4h
	 29GCa+GzIk5hMQASMu/mSknKEcaB58Abch9CZMJDhQcOFqqxdb71s6ENh/rUiR6rIX
	 NxD45unJiPLzQ==
Date: Sun, 9 Mar 2025 17:32:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Jander <david@protonic.nl>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
Message-ID: <20250309173250.68956c88@jic23-huawei>
In-Reply-To: <20250306102540.7f0f6146@erd003.prtnl>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-2-david@protonic.nl>
	<6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
	<20250305164046.4de5b6ef@erd003.prtnl>
	<mzxammninwmak5ti4c6is4pbdx3xzzziiwbxiwrldjyxgae4ok@ocec24vu4txa>
	<20250306102540.7f0f6146@erd003.prtnl>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 10:25:40 +0100
David Jander <david@protonic.nl> wrote:

> On Thu, 6 Mar 2025 00:21:22 +0100
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > Hello David,
> >=20
> > On Wed, Mar 05, 2025 at 04:40:45PM +0100, David Jander wrote: =20
> > > On Fri, 28 Feb 2025 17:44:27 +0100
> > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:   =20
> > > > On Thu, Feb 27, 2025 at 05:28:17PM +0100, David Jander wrote:
> > > > [...]   =20
> > > > > +static int motion_open(struct inode *inode, struct file *file)
> > > > > +{
> > > > > +	int minor =3D iminor(inode);
> > > > > +	struct motion_device *mdev =3D NULL, *iter;
> > > > > +	int err;
> > > > > +
> > > > > +	mutex_lock(&motion_mtx);     =20
> > > >=20
> > > > If you use guard(), error handling gets a bit easier.   =20
> > >=20
> > > This looks interesting. I didn't know about guard(). Thanks. I see the
> > > benefits, but in some cases it also makes the locked region less clea=
rly
> > > visible. While I agree that guard() in this particular place is nice,
> > > I'm hesitant to try and replace all mutex_lock()/_unlock() calls with=
 guard().
> > > Let me know if my assessment of the intended use of guard() is incorr=
ect.   =20
> >=20
> > I agree that guard() makes it harder for non-trivial functions to spot
> > the critical section. In my eyes this is outweight by not having to
> > unlock in all exit paths, but that might be subjective. Annother
> > downside of guard is that sparse doesn't understand it and reports
> > unbalanced locking. =20
>=20
> What I was referring to, and what I want to know is, is it okay to mix gu=
ard()
> with lock/unlock? I.e. Use guard() when there are multiple exit paths inv=
olved
> and revert back to simple lock/unlock if it is just to encase a handful of
> non-exiting operations?

Mixing is fine.  In some cases scoped_guard() can also make things
clearer though at the cost of increased indent.

> >=20
> > Sad, so a userspace process still has to know some internal things about
> > the motor it drives. :-\ =20
>=20
> Unfortunately that is almost impossible to avoid entirely.
> You can replace one stepper motor driver with another that might have
> different micro-stepping subdivision, by looking at struct
> mot_capabilities.subdiv, but a simple brushed DC motor just isn't able to
> replace a stepper motor in all but the most trivial applications. I also =
think
> that burdening the kernel with all sorts of complicated math to model the
> mechanical conversion factors involved in anything that's connected to the
> motor drive shaft is overkill. As well as trying to emulate all missing
> capabilities from a motion device that is lacking that functionality nati=
vely.
>=20
> So just like in IIO you cannot just replace one ADC with any other, in LM=
C you
> also cannot replace any device with any other.
>=20
> That's why there is struct mot_capabilities and MOT_IOCTL_GET_CAPA. It en=
ables
> user-space to optionally support different devices more easily. It is pro=
bably
> best used in conjunction with a LMC user-space library, although I don't =
want
> to rely on such a library for being able to use LMC. There is some middle
> ground here I guess... just like in IIO.
>=20
> One thing I could try to improve though, is to include some additional
> information in struct mot_capabilities that tells something more about the
> nature of the used units, just like the speed_conv and accel_conv constan=
ts do
> for time conversion. Something that can be placed in the device tree (pos=
sibly
> in a motor child-node connected to the motor-controller) that contains so=
me
> conversion constant for distance. That way, if one were to (for example)
> replace a stepper motor with a BLDC motor + encoder in a new hardware
> revision, this constant could be used to make the units backwards compati=
ble.
>=20
> As background information: A stepper motor controller counts distance in =
steps
> and/or micro-steps. There are mot_capabilities.subdiv micro-steps in each
> step. The amount of angle the actual motor shaft advances with each whole=
 step
> depends on the motor construction and is often 200 steps per revolution (=
1.8
> degrees), but can vary from 4 to 400 steps per revolution depending on the
> motor. So it is not only the controller that matters but also the type of
> motor. This suggests the need of motor sub-nodes in the device-tree if one
> wanted to extend the hardware knowledge further down from the motor drive=
r.
> But then there are gear boxes, pulleys, etc... it's basically conversion
> factors all the way down. How many of them is sensible to bother the kern=
el
> with?

I'd have a motor description that is sufficient to be able to swap steppers
between hardware versions and present sufficient info to userspace to allow
a library to hide those differences. That description might well be of
an aggregate device consisting of motor and whatever mechanics to get you
to the point you care about (actuator motion).  Hardest bit will be documen=
ting
'where' in the system the DT is describing.

It's not that heavily used but we do have analog front ends in IIO that
provide a not dissimilar thing to the various potential mechanisms here.

Jonathan


>=20
> Best regards,
>=20


