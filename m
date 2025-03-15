Return-Path: <linux-iio+bounces-16871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB308A63163
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E4D18931AC
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684A0204840;
	Sat, 15 Mar 2025 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KakJs1E7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235BF19007F;
	Sat, 15 Mar 2025 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742062687; cv=none; b=OtdSmI6ZntzLDr2GMHmOMY+Fta/3Zo29CgmMqvSB3k9aS9LmULVLLnFtlVEsyD/E7ku/MHjOIQa43weplxGr6N8ix6xCwfXLy6pSENfrBvYETzpbtW6CYcufZPh2u2hB1eVq1FGHyx9VR6RFtwt+MClZul6K/UiI4yBzisRWtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742062687; c=relaxed/simple;
	bh=BnLtQilf3oVuhPEhDjjvVvO/JcBr73N8Ruljy3mUS7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnGZ1KsJZ/ff3q1vdxHyCqNw3q4/g1Iz2fK4N5nt7LwXv7nz/ZjP/Qjh9CD7PcyYe2akhEAweKB0ZkjMmPVgT1OPk51nqkO3VlY/QKcUSk0tcegVk922PyfK5+Km/kD/6RDr8ku57XNBvoyLth4rWLKx1JjR2ee80Y9AnbdWuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KakJs1E7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8A3C4CEE5;
	Sat, 15 Mar 2025 18:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742062685;
	bh=BnLtQilf3oVuhPEhDjjvVvO/JcBr73N8Ruljy3mUS7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KakJs1E7c4RIKQm3AsiY8DrAHod2ZOf9SGNTVj/u/RwptG+/RtkPwPCg9Ga9PR0Qo
	 3MekhVKqqpOJ1jIq78KHl4MaKYciMzSiRocPUcOVHM8pLk5K6jo8QWrAZdXWsJRgWW
	 H/DgsFUle2vD5JB1lm1wVE5Hua6tH4XOwZzRvmevP6xjBsBMc6jsPaIvEPiAUbzZxR
	 FvFUKQORDBRtjPDbcAytALjeUxWRk1hK8O8cutTJgHtFeIqLTgMmw9W6i/fUUFbItm
	 TPgBY3EjQ+4q9v6c2b0H3EiKSp3prF8f6odyG/fHkFpJXY4yy9jbdUnmXnFfE20kfy
	 Y7uB7z/i+kDKw==
Date: Sat, 15 Mar 2025 18:17:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup functionality
 for Wake-on-Motion
Message-ID: <20250315181758.2aaaf10e@jic23-huawei>
In-Reply-To: <FR3P281MB17577B5BAF4C31E0C48F8504CED12@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com>
	<20250220-losd-3-inv-icm42600-add-wom-support-v1-2-9b937f986954@tdk.com>
	<20250222162224.60059025@jic23-huawei>
	<FR3P281MB17577B5BAF4C31E0C48F8504CED12@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Mar 2025 15:31:44 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Jonathan,
>=20
> still sorry for not being able to reply in-line.
>=20
> No problem for all changes, except handling the 2 interrupt lines. Curren=
tly our driver only supports INT1 and cannot work with INT2, and this is no=
t related to Wake-on-Motion feature. This is something we could add in anot=
her series, and I prefer to have a dedicated series for that.

You should check it isn't INT2 that you are getting via spi->irq etc.
Absolutely fine to reject that in the driver but you need to be
sure you have what you think you do and the spi->irq etc don't
provide that surety - they just give you the first one in the
dt-binding.

Jonathan


>=20
> For the mutex rework, I will delete them. This is something we can also d=
o in another dedicated patch not inside this series.
>=20
> Is that OK for you?
>=20
> Thanks,
> JB
>=20
> ________________________________________
> From:=C2=A0Jonathan Cameron <jic23@kernel.org>
> Sent:=C2=A0Saturday, February 22, 2025 17:22
> To:=C2=A0Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maney=
rol.tdk.com@kernel.org>
> Cc:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-Pe=
ter Clausen <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.ke=
rnel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject:=C2=A0Re: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup function=
ality for Wake-on-Motion
> =C2=A0
> This Message Is From an External Sender
> This message came from outside your organization.
> =C2=A0
> On Thu, 20 Feb 2025 21:52:07 +0100
> Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.c=
om@kernel.org> wrote:
>=20
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >=20
> > When Wake-on-Motion is on, enable system wakeup and keep chip on for
> > waking up system with interrupt.
> >=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com> =
=20
> Hi Jean-Baptiste,
>=20
> A few comments inline.
>=20
> > ---
> >  drivers/iio/imu/inv_icm42600/inv_icm42600.h       |  2 +
> >  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c |  3 +
> >  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c  | 89 +++++++++++++++=
--------
> >  3 files changed, 63 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/=
imu/inv_icm42600/inv_icm42600.h
> > index 8dfbeaf1c768d7d25cb58ecf9804446f3cbbd465..baf1dcd714800e84ccd21dc=
1d1e486849c77a9ae 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > @@ -151,6 +151,7 @@ struct inv_icm42600_apex {
> >   *  @map:		regmap pointer.
> >   *  @vdd_supply:	VDD voltage regulator for the chip.
> >   *  @vddio_supply:	I/O voltage regulator for the chip.
> > + *  @irq:		chip irq. =20
>=20
> Maybe say a little on what the variable is used for. It's not otherwise
> obvious why we need it.  Also, does this chip really only have one irq li=
ne?
> Looks like there are two. So the drivers should be fixed to cope with the
> only one wired being irq2  unless I've found the wrong datasheet which is
> certainly possible.
>=20
>=20
> >   *  @orientation:	sensor chip orientation relative to main hardware.
> >   *  @conf:		chip sensors configurations.
> >   *  @suspended:		suspended sensors configuration.
> > @@ -168,6 +169,7 @@ struct inv_icm42600_state {
> >  	struct regmap *map;
> >  	struct regulator *vdd_supply;
> >  	struct regulator *vddio_supply;
> > +	int irq;
> >  	struct iio_mount_matrix orientation;
> >  	struct inv_icm42600_conf conf;
> >  	struct inv_icm42600_suspended suspended;
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/driver=
s/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > index 8ce2276b3edc61cc1ea26810198dd0057054ec48..4240e8c576f4d07af5434e9=
a91dfda532f87ffb9 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > @@ -1149,6 +1149,9 @@ struct iio_dev *inv_icm42600_accel_init(struct in=
v_icm42600_state *st)
> >  	if (ret)
> >  		return ERR_PTR(ret);
> > =20
> > +	/* accel events are wakeup capable */
> > +	device_set_wakeup_capable(&indio_dev->dev, true);
> > +
> >  	return indio_dev;
> >  }
> > =20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_core.c
> > index c0fd2770d66f02d1965fa07f819fd2db9a1d6bd2..f94bda5dc094d6cc85e3fac=
bd480b830bfbaa3f9 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > @@ -751,6 +751,7 @@ int inv_icm42600_core_probe(struct regmap *regmap, =
int chip, int irq,
> >  	mutex_init(&st->lock);
> >  	st->chip =3D chip;
> >  	st->map =3D regmap;
> > +	st->irq =3D irq;
> > =20
> >  	ret =3D iio_read_mount_matrix(dev, &st->orientation);
> >  	if (ret) {
> > @@ -829,44 +830,56 @@ EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, "II=
O_ICM42600");
> >  static int inv_icm42600_suspend(struct device *dev)
> >  {
> >  	struct inv_icm42600_state *st =3D dev_get_drvdata(dev);
> > +	struct device *accel_dev;
> > +	bool wakeup;
> > +	int accel_conf;
> >  	int ret;
> > =20
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock); =20
>=20
> As below. Pull these guard changes out as a precursor patch. That will ma=
ke
> it easier to spot the real changes here.
>=20
> > =20
> >  	st->suspended.gyro =3D st->conf.gyro.mode;
> >  	st->suspended.accel =3D st->conf.accel.mode;
> >  	st->suspended.temp =3D st->conf.temp_en;
> > -	if (pm_runtime_suspended(dev)) {
> > -		ret =3D 0;
> > -		goto out_unlock;
> > -	}
> > +	if (pm_runtime_suspended(dev))
> > +		return 0;
> > =20
> >  	/* disable FIFO data streaming */
> >  	if (st->fifo.on) {
> >  		ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
> >  				   INV_ICM42600_FIFO_CONFIG_BYPASS);
> >  		if (ret)
> > -			goto out_unlock;
> > +			return ret;
> >  	}
> > =20
> > -	/* disable APEX features */
> > -	if (st->apex.wom.enable) {
> > -		ret =3D inv_icm42600_set_wom(st, false);
> > -		if (ret)
> > -			goto out_unlock;
> > +	/* keep chip on and wake-up capable if APEX and wakeup on */
> > +	accel_dev =3D &st->indio_accel->dev;
> > +	wakeup =3D (st->apex.on && device_may_wakeup(accel_dev)) ? true : fal=
se;
> > +
> > +	if (!wakeup) {
> > +		/* disable APEX features and accel if wakeup disabled */
> > +		if (st->apex.wom.enable) {
> > +			ret =3D inv_icm42600_set_wom(st, false);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +		accel_conf =3D INV_ICM42600_SENSOR_MODE_OFF;
> > +	} else {
> > +		/* keep accel on and setup irq for wakeup */
> > +		accel_conf =3D st->conf.accel.mode;
> > +		enable_irq_wake(st->irq);
> > +		disable_irq(st->irq);
> >  	}
> > =20
> >  	ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
> > -					 INV_ICM42600_SENSOR_MODE_OFF, false,
> > -					 NULL);
> > +					 accel_conf, false, NULL);
> >  	if (ret)
> > -		goto out_unlock;
> > +		return ret;
> > =20
> > -	regulator_disable(st->vddio_supply);
> > +	/* disable vddio regulator if chip is sleeping */
> > +	if (!wakeup)
> > +		regulator_disable(st->vddio_supply);
> > =20
> > -out_unlock:
> > -	mutex_unlock(&st->lock);
> > -	return ret;
> > +	return 0;
> >  }
> > =20
> >  /*
> > @@ -878,13 +891,25 @@ static int inv_icm42600_resume(struct device *dev)
> >  	struct inv_icm42600_state *st =3D dev_get_drvdata(dev);
> >  	struct inv_icm42600_sensor_state *gyro_st =3D iio_priv(st->indio_gyro=
);
> >  	struct inv_icm42600_sensor_state *accel_st =3D iio_priv(st->indio_acc=
el);
> > +	struct device *accel_dev;
> > +	bool wakeup;
> >  	int ret;
> > =20
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock); =20
>=20
> Good change.  But separate patch as not related to most of what is going =
on here.
>=20
>=20
> > =20
> > -	ret =3D inv_icm42600_enable_regulator_vddio(st);
> > -	if (ret)
> > -		goto out_unlock;
> > +	/* check wakeup capability */
> > +	accel_dev =3D &st->indio_accel->dev;
> > +	wakeup =3D (st->apex.on && device_may_wakeup(accel_dev)) ? true : fal=
se;
> > +
> > +	/* restore vddio if cut off or irq state */
> > +	if (!wakeup) {
> > +		ret =3D inv_icm42600_enable_regulator_vddio(st);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		enable_irq(st->irq);
> > +		disable_irq_wake(st->irq);
> > +	}
> > =20
> >  	pm_runtime_disable(dev);
> >  	pm_runtime_set_active(dev);
> > @@ -895,13 +920,15 @@ static int inv_icm42600_resume(struct device *dev)
> >  					 st->suspended.accel,
> >  					 st->suspended.temp, NULL);
> >  	if (ret)
> > -		goto out_unlock;
> > +		return ret;
> > =20
> > -	/* restore APEX features */
> > -	if (st->apex.wom.enable) {
> > -		ret =3D inv_icm42600_set_wom(st, true);
> > -		if (ret)
> > -			goto out_unlock;
> > +	/* restore APEX features if disabled */
> > +	if (!wakeup) {
> > +		if (st->apex.wom.enable) {
> > +			ret =3D inv_icm42600_set_wom(st, true);
> > +			if (ret)
> > +				return ret;
> > +		}
> >  	}
> > =20
> >  	/* restore FIFO data streaming */
> > @@ -910,11 +937,11 @@ static int inv_icm42600_resume(struct device *dev)
> >  		inv_sensors_timestamp_reset(&accel_st->ts);
> >  		ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
> >  				   INV_ICM42600_FIFO_CONFIG_STREAM);
> > +		if (ret)
> > +			return ret;
> >  	}
> > =20
> > -out_unlock:
> > -	mutex_unlock(&st->lock);
> > -	return ret;
> > +	return 0;
> >  }
> > =20
> >  /* Runtime suspend will turn off sensors that are enabled by iio devic=
es. */
> >  =20
>=20


