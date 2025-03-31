Return-Path: <linux-iio+bounces-17425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53771A764E8
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A247D3A85BA
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E320C1DF277;
	Mon, 31 Mar 2025 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2knXX/c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AAF13A265;
	Mon, 31 Mar 2025 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743420377; cv=none; b=j7Q/PSzMTFYNFaSLjB2CN+Zsro0iwLe8ohzzP47DnGlKkxmg6kEIvEhoOkL+PkQMwupFATBgM7CgWuaN+5wIaBEKCcB7zwEEtLf5Meoseise536Hcdw5qD48eGYjH+hkqem25ewM4IRMl522ayJ61NeaaeiuZqQ1plD0DYPhtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743420377; c=relaxed/simple;
	bh=vVFMSvecr4GOgVULKbwlJWbt2FlWc2kxeEwklQiHIuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcozEOeOrYCikXga3gF4dsVdiMwCLXewa3XuCjT+4oTvHycice2GuKPC2+CYMAJL4LbMlooP6ItpkIBBKyHG0tXsN93V1u38EPcYtaXnLnXg7AqKykUQALpaVA8YKoEFmPBYewPlwVzxgc9LhXsAvYB4CQtRlSIsTye5nz+usA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2knXX/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B8DC4CEE3;
	Mon, 31 Mar 2025 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743420377;
	bh=vVFMSvecr4GOgVULKbwlJWbt2FlWc2kxeEwklQiHIuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H2knXX/cPlYIWK8rRXT2cO4t5pOdTgUY2GP9Fs1TFkMRYn3kDmfOMCtWieZC3M6YH
	 XpwLjUxsmRv/R+MedKcpt1hZb+ueAMdQdorJHW4aaBECicbmU2sAGsC31cCI+scxde
	 +xzeaInbYguGCWX9kS9vx2JdmuQWrNjR6kHRGPhyha95HOVLMmlzdvG08s+PAm001f
	 XfcrWGkyzo/KtRx0pG5vkRcOHz22bcZ5fR4tW8QCzqFYY3xwiPeyAjwQoizSJSd3Zk
	 Jn0RzvCEFqoP9ds10ap23sYicjxlxB+gPrWu0GbuxaDZQohbavHVzWTICqodeiqe07
	 QHEleuKYmNWiw==
Date: Mon, 31 Mar 2025 12:26:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup functionality
 for Wake-on-Motion
Message-ID: <20250331122609.508bc3e2@jic23-huawei>
In-Reply-To: <FR3P281MB175775CD8CDB29D7ACE8B544CED92@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com>
	<20250220-losd-3-inv-icm42600-add-wom-support-v1-2-9b937f986954@tdk.com>
	<20250222162224.60059025@jic23-huawei>
	<FR3P281MB17577B5BAF4C31E0C48F8504CED12@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20250315181758.2aaaf10e@jic23-huawei>
	<FR3P281MB175775CD8CDB29D7ACE8B544CED92@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Mar 2025 21:06:41 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Jonathan,
>=20
> I understand the issue, but using spi->irq for getting interrupt is somet=
hing we are already doing inside the driver. I agree we need to fix that, b=
ut I would prefer fixing it after adding WoM support.
>=20
> Is that OK for you? Or do I need to fix getting the right interrupt first?

It's a pretty trivial fix to add the sanity check,
but I don't mind if you do it as a follow up.

Jonathan


>=20
> Thanks,
> JB
>=20
> ________________________________________
> From:=C2=A0Jonathan Cameron <jic23@kernel.org>
> Sent:=C2=A0Saturday, March 15, 2025 19:17
> To:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Cc:=C2=A0Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maney=
rol.tdk.com@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; linux-iio@vg=
er.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>
> Subject:=C2=A0Re: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup function=
ality for Wake-on-Motion
> =C2=A0
> This Message Is From an External Sender
> This message came from outside your organization.
> =C2=A0
> On Tue, 11 Mar 2025 15:31:44 +0000
> Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
>=20
> > Hello Jonathan,
> >=20
> > still sorry for not being able to reply in-line.
> >=20
> > No problem for all changes, except handling the 2 interrupt lines. Curr=
ently our driver only supports INT1 and cannot work with INT2, and this is =
not related to Wake-on-Motion feature. This is something we could add in an=
other series, and I prefer to have a dedicated series for that. =20
>=20
> You should check it isn't INT2 that you are getting via spi->irq etc.
> Absolutely fine to reject that in the driver but you need to be
> sure you have what you think you do and the spi->irq etc don't
> provide that surety - they just give you the first one in the
> dt-binding.
>=20
> Jonathan
>=20
>=20
> >=20
> > For the mutex rework, I will delete them. This is something we can also=
 do in another dedicated patch not inside this series.
> >=20
> > Is that OK for you?
> >=20
> > Thanks,
> > JB
> >=20
> > ________________________________________
> > From:=C2=A0Jonathan Cameron <jic23@kernel.org>
> > Sent:=C2=A0Saturday, February 22, 2025 17:22
> > To:=C2=A0Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.man=
eyrol.tdk.com@kernel.org>
> > Cc:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-=
Peter Clausen <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.=
kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> > Subject:=C2=A0Re: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup functi=
onality for Wake-on-Motion
> > =C2=A0
> > This Message Is From an External Sender
> > This message came from outside your organization.
> > =C2=A0
> > On Thu, 20 Feb 2025 21:52:07 +0100
> > Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk=
.com@kernel.org> wrote:
> >  =20
> > > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > >=20
> > > When Wake-on-Motion is on, enable system wakeup and keep chip on for
> > > waking up system with interrupt.
> > >=20
> > > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com=
> =C2=A0 =20
> > Hi Jean-Baptiste,
> >=20
> > A few comments inline.
> >  =20
> > > ---
> > > =C2=A0drivers/iio/imu/inv_icm42600/inv_icm42600.h =C2=A0 =C2=A0 =C2=
=A0 | =C2=A02 +
> > > =C2=A0drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | =C2=A03 +
> > > =C2=A0drivers/iio/imu/inv_icm42600/inv_icm42600_core.c =C2=A0| 89 +++=
++++++++++++--------
> > > =C2=A03 files changed, 63 insertions(+), 31 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600.h
> > > index 8dfbeaf1c768d7d25cb58ecf9804446f3cbbd465..baf1dcd714800e84ccd21=
dc1d1e486849c77a9ae 100644
> > > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > > @@ -151,6 +151,7 @@ struct inv_icm42600_apex {
> > > =C2=A0 * =C2=A0@map:		regmap pointer.
> > > =C2=A0 * =C2=A0@vdd_supply:	VDD voltage regulator for the chip.
> > > =C2=A0 * =C2=A0@vddio_supply:	I/O voltage regulator for the chip.
> > > + * =C2=A0@irq:		chip irq. =C2=A0 =20
> >=20
> > Maybe say a little on what the variable is used for. It's not otherwise
> > obvious why we need it. =C2=A0Also, does this chip really only have one=
 irq line?
> > Looks like there are two. So the drivers should be fixed to cope with t=
he
> > only one wired being irq2 =C2=A0unless I've found the wrong datasheet w=
hich is
> > certainly possible.
> >=20
> >  =20
> > > =C2=A0 * =C2=A0@orientation:	sensor chip orientation relative to main=
 hardware.
> > > =C2=A0 * =C2=A0@conf:		chip sensors configurations.
> > > =C2=A0 * =C2=A0@suspended:		suspended sensors configuration.
> > > @@ -168,6 +169,7 @@ struct inv_icm42600_state {
> > > =C2=A0	struct regmap *map;
> > > =C2=A0	struct regulator *vdd_supply;
> > > =C2=A0	struct regulator *vddio_supply;
> > > +	int irq;
> > > =C2=A0	struct iio_mount_matrix orientation;
> > > =C2=A0	struct inv_icm42600_conf conf;
> > > =C2=A0	struct inv_icm42600_suspended suspended;
> > > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/driv=
ers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > > index 8ce2276b3edc61cc1ea26810198dd0057054ec48..4240e8c576f4d07af5434=
e9a91dfda532f87ffb9 100644
> > > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > > @@ -1149,6 +1149,9 @@ struct iio_dev *inv_icm42600_accel_init(struct =
inv_icm42600_state *st)
> > > =C2=A0	if (ret)
> > > =C2=A0		return ERR_PTR(ret);
> > > =C2=A0
> > > +	/* accel events are wakeup capable */
> > > +	device_set_wakeup_capable(&indio_dev->dev, true);
> > > +
> > > =C2=A0	return indio_dev;
> > > =C2=A0}
> > > =C2=A0
> > > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drive=
rs/iio/imu/inv_icm42600/inv_icm42600_core.c
> > > index c0fd2770d66f02d1965fa07f819fd2db9a1d6bd2..f94bda5dc094d6cc85e3f=
acbd480b830bfbaa3f9 100644
> > > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > > @@ -751,6 +751,7 @@ int inv_icm42600_core_probe(struct regmap *regmap=
, int chip, int irq,
> > > =C2=A0	mutex_init(&st->lock);
> > > =C2=A0	st->chip =3D chip;
> > > =C2=A0	st->map =3D regmap;
> > > +	st->irq =3D irq;
> > > =C2=A0
> > > =C2=A0	ret =3D iio_read_mount_matrix(dev, &st->orientation);
> > > =C2=A0	if (ret) {
> > > @@ -829,44 +830,56 @@ EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, "=
IIO_ICM42600");
> > > =C2=A0static int inv_icm42600_suspend(struct device *dev)
> > > =C2=A0{
> > > =C2=A0	struct inv_icm42600_state *st =3D dev_get_drvdata(dev);
> > > +	struct device *accel_dev;
> > > +	bool wakeup;
> > > +	int accel_conf;
> > > =C2=A0	int ret;
> > > =C2=A0
> > > -	mutex_lock(&st->lock);
> > > +	guard(mutex)(&st->lock); =C2=A0 =20
> >=20
> > As below. Pull these guard changes out as a precursor patch. That will =
make
> > it easier to spot the real changes here.
> >  =20
> > > =C2=A0
> > > =C2=A0	st->suspended.gyro =3D st->conf.gyro.mode;
> > > =C2=A0	st->suspended.accel =3D st->conf.accel.mode;
> > > =C2=A0	st->suspended.temp =3D st->conf.temp_en;
> > > -	if (pm_runtime_suspended(dev)) {
> > > -		ret =3D 0;
> > > -		goto out_unlock;
> > > -	}
> > > +	if (pm_runtime_suspended(dev))
> > > +		return 0;
> > > =C2=A0
> > > =C2=A0	/* disable FIFO data streaming */
> > > =C2=A0	if (st->fifo.on) {
> > > =C2=A0		ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
> > > =C2=A0				 =C2=A0 INV_ICM42600_FIFO_CONFIG_BYPASS);
> > > =C2=A0		if (ret)
> > > -			goto out_unlock;
> > > +			return ret;
> > > =C2=A0	}
> > > =C2=A0
> > > -	/* disable APEX features */
> > > -	if (st->apex.wom.enable) {
> > > -		ret =3D inv_icm42600_set_wom(st, false);
> > > -		if (ret)
> > > -			goto out_unlock;
> > > +	/* keep chip on and wake-up capable if APEX and wakeup on */
> > > +	accel_dev =3D &st->indio_accel->dev;
> > > +	wakeup =3D (st->apex.on && device_may_wakeup(accel_dev)) ? true : f=
alse;
> > > +
> > > +	if (!wakeup) {
> > > +		/* disable APEX features and accel if wakeup disabled */
> > > +		if (st->apex.wom.enable) {
> > > +			ret =3D inv_icm42600_set_wom(st, false);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > > +		accel_conf =3D INV_ICM42600_SENSOR_MODE_OFF;
> > > +	} else {
> > > +		/* keep accel on and setup irq for wakeup */
> > > +		accel_conf =3D st->conf.accel.mode;
> > > +		enable_irq_wake(st->irq);
> > > +		disable_irq(st->irq);
> > > =C2=A0	}
> > > =C2=A0
> > > =C2=A0	ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MOD=
E_OFF,
> > > -					 INV_ICM42600_SENSOR_MODE_OFF, false,
> > > -					 NULL);
> > > +					 accel_conf, false, NULL);
> > > =C2=A0	if (ret)
> > > -		goto out_unlock;
> > > +		return ret;
> > > =C2=A0
> > > -	regulator_disable(st->vddio_supply);
> > > +	/* disable vddio regulator if chip is sleeping */
> > > +	if (!wakeup)
> > > +		regulator_disable(st->vddio_supply);
> > > =C2=A0
> > > -out_unlock:
> > > -	mutex_unlock(&st->lock);
> > > -	return ret;
> > > +	return 0;
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0/*
> > > @@ -878,13 +891,25 @@ static int inv_icm42600_resume(struct device *d=
ev)
> > > =C2=A0	struct inv_icm42600_state *st =3D dev_get_drvdata(dev);
> > > =C2=A0	struct inv_icm42600_sensor_state *gyro_st =3D iio_priv(st->ind=
io_gyro);
> > > =C2=A0	struct inv_icm42600_sensor_state *accel_st =3D iio_priv(st->in=
dio_accel);
> > > +	struct device *accel_dev;
> > > +	bool wakeup;
> > > =C2=A0	int ret;
> > > =C2=A0
> > > -	mutex_lock(&st->lock);
> > > +	guard(mutex)(&st->lock); =C2=A0 =20
> >=20
> > Good change. =C2=A0But separate patch as not related to most of what is=
 going on here.
> >=20
> >  =20
> > > =C2=A0
> > > -	ret =3D inv_icm42600_enable_regulator_vddio(st);
> > > -	if (ret)
> > > -		goto out_unlock;
> > > +	/* check wakeup capability */
> > > +	accel_dev =3D &st->indio_accel->dev;
> > > +	wakeup =3D (st->apex.on && device_may_wakeup(accel_dev)) ? true : f=
alse;
> > > +
> > > +	/* restore vddio if cut off or irq state */
> > > +	if (!wakeup) {
> > > +		ret =3D inv_icm42600_enable_regulator_vddio(st);
> > > +		if (ret)
> > > +			return ret;
> > > +	} else {
> > > +		enable_irq(st->irq);
> > > +		disable_irq_wake(st->irq);
> > > +	}
> > > =C2=A0
> > > =C2=A0	pm_runtime_disable(dev);
> > > =C2=A0	pm_runtime_set_active(dev);
> > > @@ -895,13 +920,15 @@ static int inv_icm42600_resume(struct device *d=
ev)
> > > =C2=A0					 st->suspended.accel,
> > > =C2=A0					 st->suspended.temp, NULL);
> > > =C2=A0	if (ret)
> > > -		goto out_unlock;
> > > +		return ret;
> > > =C2=A0
> > > -	/* restore APEX features */
> > > -	if (st->apex.wom.enable) {
> > > -		ret =3D inv_icm42600_set_wom(st, true);
> > > -		if (ret)
> > > -			goto out_unlock;
> > > +	/* restore APEX features if disabled */
> > > +	if (!wakeup) {
> > > +		if (st->apex.wom.enable) {
> > > +			ret =3D inv_icm42600_set_wom(st, true);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > > =C2=A0	}
> > > =C2=A0
> > > =C2=A0	/* restore FIFO data streaming */
> > > @@ -910,11 +937,11 @@ static int inv_icm42600_resume(struct device *d=
ev)
> > > =C2=A0		inv_sensors_timestamp_reset(&accel_st->ts);
> > > =C2=A0		ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
> > > =C2=A0				 =C2=A0 INV_ICM42600_FIFO_CONFIG_STREAM);
> > > +		if (ret)
> > > +			return ret;
> > > =C2=A0	}
> > > =C2=A0
> > > -out_unlock:
> > > -	mutex_unlock(&st->lock);
> > > -	return ret;
> > > +	return 0;
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0/* Runtime suspend will turn off sensors that are enabled by ii=
o devices. */
> > > =C2=A0  =20
> >  =20
>=20


