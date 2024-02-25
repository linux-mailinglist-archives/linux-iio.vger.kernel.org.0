Return-Path: <linux-iio+bounces-3044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F286862A1F
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 12:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBA41F21468
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E2E101EE;
	Sun, 25 Feb 2024 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vop8WFZO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501C10940;
	Sun, 25 Feb 2024 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708861607; cv=none; b=cQahLtgkV2f5bxJ6B0vR08B/XIodNFih6wp6zOnrz240h6zefuZUXsX2GKxLi5m2V3KWsmHFeiZhX/Z6bcl1Kgx0//ootipkgSZVCmTPYyitsZgFg4DN2TDzPLbN/6tjRweiB2/455xOr79fHFpT/nbO0qKye4RVFBaOia0NwJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708861607; c=relaxed/simple;
	bh=KDkYWIe7wiZmqCmivXbkUqK02LzeTUDMYcV6Xrp8TSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4JyDG4n4TozpiYsypae9WU/ZVYKKCW/s4XwXJ2zygQarBy2m2AW3GoXIgW30nvio3EFuvkM9f5snPC5cegiUzjd3BQkjXQsD1plA5H7pp/rVzT2WhPPVNB5X1qbdRf0bG1YxMZbDWzBNpd3aDCXXFHjfkQ/K/8X/cy2Cn/doDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vop8WFZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DDAC433C7;
	Sun, 25 Feb 2024 11:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708861606;
	bh=KDkYWIe7wiZmqCmivXbkUqK02LzeTUDMYcV6Xrp8TSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vop8WFZOi9QXeQWkODy+8PSuzqp6Rdeh0YBVhQhVS0ocpxk4zJyVNQV2EuXXc1nwJ
	 1fI+P8BtTHCcKnR9spaw1N1fzgfiGpBYeYGGdfYOlUhXAckZapgVv4aRdRvROP4clf
	 d+hxf3fpmUwtYY0yBDe+p7SYEKiYvHjZkfoxlB//NfDaXRwrark3Av+rfs0JSYDNxc
	 wMIzgBnURi24Ij8v1juT/EAO/yLSUq4uNKX+D+rsSdPE1Wy00un5ifjDBvsbuJYz26
	 7mp+LoyXT46u3gyRGeFdbNImtrJy20ZhD2rFEBHjhkuJw0lkdYMsK8EIe33tPIB3hP
	 +jQjxO+AtyFKg==
Date: Sun, 25 Feb 2024 11:46:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: INV Git Commit <INV.git-commit@tdk.com>, "lars@metafoo.de"
 <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: fix frequency setting when
 chip is off
Message-ID: <20240225114634.36c735ef@jic23-huawei>
In-Reply-To: <FR3P281MB1757A98D6B0EC6B48526C849CE542@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240219154741.90601-1-inv.git-commit@tdk.com>
	<20240224162208.02d28bcd@jic23-huawei>
	<FR3P281MB1757A98D6B0EC6B48526C849CE542@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 24 Feb 2024 17:50:26 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Jonathan,
>=20
> the problem comes from the fifo rate setting code that is now using these=
 states to compute if FIFO is on:
> fifo_on =3D st->chip_config.accl_fifo_enable ||
>           st->chip_config.gyro_fifo_enable ||
>           st->chip_config.magn_fifo_enable;
> result =3D inv_sensors_timestamp_update_odr(&st->timestamp, fifo_period, =
fifo_on);
> if (result)
>         goto fifo_rate_fail_unlock;
>=20
> It was not the case before using the inv_sensors_timestamp module.
>=20
> If we don't set these states back to false, it is not possible to change =
frequency more than 1 time. This restriction comes from inv_sensors_timesta=
mp module that is not able to handle accurately more than 1 frequency chang=
e when sensor FIFO is on. This restriction obviously doesn't exist when FIF=
O is off.

Thanks, now I understand.  I've added a note to say the restriction
to a single pending update of ODR should only apply when the fifo
is on.  Along with a link to this thread that should be enough to
help people understand the issue when consider whether to backport this
fix.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

>=20
> Thanks,
> JB
>=20
>=20
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, February 24, 2024 17:22
> To: INV Git Commit <INV.git-commit@tdk.com>
> Cc: lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.org>; Jean-=
Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: fix frequency setting when=
 chip is off=20
> =C2=A0
> On Mon, 19 Feb 2024 15:=E2=80=8A47:=E2=80=8A41 +0000 inv.=E2=80=8Agit-com=
mit@=E2=80=8Atdk.=E2=80=8Acom wrote: > From: Jean-Baptiste Maneyrol <jean-b=
aptiste.=E2=80=8Amaneyrol@=E2=80=8Atdk.=E2=80=8Acom> > > Track correctly FI=
FO state and apply ODR change before starting > the chip. Without the fix,=
=20
> ZjQcmQRYFpfptBannerStart
> This Message Is From an External Sender=20
> This message came from outside your organization.=20
> =C2=A0
> ZjQcmQRYFpfptBannerEnd
> On Mon, 19 Feb 2024 15:47:41 +0000
> inv.git-commit@tdk.com wrote:
>=20
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >=20
> > Track correctly FIFO state and apply ODR change before starting
> > the chip. Without the fix, you cannot change ODR more than 1 time
> > when data buffering is off. =20
>=20
> Hi Jean-Baptiste.
>=20
> I think this patch needs a little more explanation.
> 1) Why has state changed such that we need to update these cached values?
> 2) What does that have to do with ODR - or is this two unrelated fixes?
>=20
> I'm sure the fix is right - I just don't fully understand the issues!
> >=20
> > Fixes: 111e1abd0045 ("iio: imu: inv_mpu6050: use the common inv_sensors=
 timestamp module")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > ---
> > V2: add missing stable tag
> >=20
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/ii=
o/imu/inv_mpu6050/inv_mpu_trigger.c
> > index 676704f9151f..e6e6e94452a3 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > @@ -111,6 +111,7 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_sta=
te *st, bool enable)
> >  	if (enable) {
> >  		/* reset timestamping */
> >  		inv_sensors_timestamp_reset(&st->timestamp);
> > +		inv_sensors_timestamp_apply_odr(&st->timestamp, 0, 0, 0);
> >  		/* reset FIFO */
> >  		d =3D st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
> >  		ret =3D regmap_write(st->map, st->reg->user_ctrl, d);
> > @@ -184,6 +185,10 @@ static int inv_mpu6050_set_enable(struct iio_dev *=
indio_dev, bool enable)
> >  		if (result)
> >  			goto error_power_off;
> >  	} else {
> > +		st->chip_config.gyro_fifo_enable =3D 0;
> > +		st->chip_config.accl_fifo_enable =3D 0;
> > +		st->chip_config.temp_fifo_enable =3D 0;
> > +		st->chip_config.magn_fifo_enable =3D 0; =20
> I think the write to actually do this is in prepare_fifo and it's not
> conditional on these, so why do we care?
>=20
> Are these effectively paired with inv_scan_query in the enable path?
>=20
>=20
> >  		result =3D inv_mpu6050_prepare_fifo(st, false);
> >  		if (result)
> >  			goto error_power_off;
> > --
> > 2.34.1
> >  =20
>=20


