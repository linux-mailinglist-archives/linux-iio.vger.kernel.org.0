Return-Path: <linux-iio+bounces-4774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7E98BA8C4
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 10:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387651C22184
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 08:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ABD149C57;
	Fri,  3 May 2024 08:29:54 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E3B139D1B;
	Fri,  3 May 2024 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724994; cv=none; b=L1YPs6WmQmQW/+4FFdY3HUZ3mO0vGuL2qPhD18AfBx/4ggrtgspKizfh5wLKJs1gmqPNbvA1YHxJpmSrSHtmlJTC5bqp2UgK/1P+QMq6DQkF1ALzdEe57of+P0P88s2LMq87647CEyOkB7KKGwl+NHD4WVi/xk6AI/Ac8+C6x1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724994; c=relaxed/simple;
	bh=ztn8GcbXQ5YltlL8YIDFjCSnHUJ2GCpheBNA9ixGqfw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EBikdgKU8oWRp111sN3hDdQydcAuwRUmEAo+h1intg5a8TVi4pBuhLOhwPmiGZG/Su9VJWI/x96Mb3qt59fHQRQn+3OeXXA60tRpPEcf5U4iZmFlZHl6eKjfWHDMtcaaiSP77Wo4//Nhr4HWawMR6h5gZoCk3Rcd4dG2uceGEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VW3nH2J3cz6J6CP;
	Fri,  3 May 2024 16:26:59 +0800 (CST)
Received: from lhrpeml100005.china.huawei.com (unknown [7.191.160.25])
	by mail.maildlp.com (Postfix) with ESMTPS id DEE711402CB;
	Fri,  3 May 2024 16:29:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100005.china.huawei.com (7.191.160.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 3 May 2024 09:29:48 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039;
 Fri, 3 May 2024 09:29:48 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>, Jonathan Cameron
	<jic23@kernel.org>, INV Git Commit <INV.git-commit@tdk.com>
CC: "lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] iio: invensense: fix timestamp glitches when switching
 frequency
Thread-Topic: [PATCH] iio: invensense: fix timestamp glitches when switching
 frequency
Thread-Index: AQHal8cA/LSTQTeVgE2UWtBJHidp67F9m3+AgARZC4CAAa2sgIABba4AgAAn8eA=
Date: Fri, 3 May 2024 08:29:48 +0000
Message-ID: <50a78176849048edad5a5fa5deb60fb9@huawei.com>
References: <20240426094835.138389-1-inv.git-commit@tdk.com>
	<20240428141349.116ad03c@jic23-huawei> <20240501083733.207c27a5@jic23-huawei>
 <FR3P281MB175720998BDD67CC2A157A82CE182@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <FR3P281MB1757C8536898C39A30BEFD96CE1F2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB1757C8536898C39A30BEFD96CE1F2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Please send a fixup patch or a replacement for the original fix.

Given I messed up the pull request anyway I can apply it on top, or squash =
with relevant fix
before sending a revised pull request.

Jonathan




-----Original Message-----
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=20
Sent: 03 May 2024 08:04
To: Jonathan Cameron <jic23@kernel.org>; INV Git Commit <INV.git-commit@tdk=
.com>
Cc: lars@metafoo.de; linux-iio@vger.kernel.org; stable@vger.kernel.org
Subject: Re: [PATCH] iio: invensense: fix timestamp glitches when switching=
 frequency

Hello Jonathan,

I see that this fix has now been pulled.

Do I need to create a new fixes patch that fix this patch porting? inv_icm4=
2600 is currently broken now inside the current IIO tree.

Thanks for your help.

Best regards,
JB

________________________________________
From:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Sent:=A0Thursday, May 2, 2024 11:15
To:=A0Jonathan Cameron <jic23@kernel.org>; INV Git Commit <INV.git-commit@t=
dk.com>
Cc:=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.org>
Subject:=A0Re: [PATCH] iio: invensense: fix timestamp glitches when switchi=
ng frequency
=A0
This Message Is From an External Sender
This message came from outside your organization.
=A0
Hello Jonathan,

beware that your porting of the patch "iio: invensense: fix timestamp glitc=
hes..." is not correct inside togreg and testing branches.

Inside file drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c, you must ke=
ep the sensor_state structures declaration and use them to get the iio_priv=
 structure.

You need to keep the following declarations in inv_icm42600_buffer fifo_par=
se and hwfifo_flush functions:
struct inv_icm42600_sensor_state *gyro_st =3D iio_priv(st->indio_gyro); str=
uct inv_icm42600_sensor_state *accel_st =3D iio_priv(st->indio_accel);

And you need to replace
ts =3D iio_priv(st->indio_gyro) by ts =3D &gyro_st->ts; ts =3D iio_priv(st-=
>indio_accel) by ts =3D &accel_st->ts;

Correct diff should be something like:
=20
@@ -512,20 +510,20 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm4260=
0_state *st)
                return 0;
=20
        /* handle gyroscope timestamp and FIFO data parsing */
-       ts =3D &gyro_st->ts;
-       inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.to=
tal,
-                                       st->fifo.nb.gyro, st->timestamp.gyr=
o);
        if (st->fifo.nb.gyro > 0) {
+               ts =3D &gyro_st->ts;
+               inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
+                                               st->timestamp.gyro);
                ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);
                if (ret)
                        return ret;
        }
=20
        /* handle accelerometer timestamp and FIFO data parsing */
-       ts =3D &accel_st->ts;
-       inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.to=
tal,
-                                       st->fifo.nb.accel, st->timestamp.ac=
cel);
        if (st->fifo.nb.accel > 0) {
+               ts =3D iio_priv(st->indio_accel);
+               inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
+                                               st->timestamp.accel);
                ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);
                if (ret)
                        return ret;

@@ -554,20 +550,16 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42=
600_state *st,
                return 0;
=20
        if (st->fifo.nb.gyro > 0) {
-               ts =3D &gyro_st->ts;
-               inv_sensors_timestamp_interrupt(ts, st->fifo.period,
-                                               st->fifo.nb.total, st->fifo=
.nb.gyro,
-                                               gyro_ts);
+               ts =3D &gyro_st->ts;
+               inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,=20
+ gyro_ts);
                ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);
                if (ret)
                        return ret;
        }
=20
        if (st->fifo.nb.accel > 0) {
-               ts =3D &accel_st->ts;
-               inv_sensors_timestamp_interrupt(ts, st->fifo.period,
-                                               st->fifo.nb.total, st->fifo=
.nb.accel,
-                                               accel_ts);
+               ts =3D &accel_st->ts;
+               inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,=20
+ accel_ts);
                ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);
                if (ret)
                        return ret;


Thanks for fixing this,
JB

________________________________________
From:=A0Jonathan Cameron <jic23@kernel.org>
Sent:=A0Wednesday, May 1, 2024 09:37
To:=A0INV Git Commit <INV.git-commit@tdk.com>
Cc:=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.org>; Jean-=
Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Subject:=A0Re: [PATCH] iio: invensense: fix timestamp glitches when switchi=
ng frequency
=A0
This Message Is From an External Sender
This message came from outside your organization.
=A0
On Sun, 28 Apr 2024 14:13:49 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 26 Apr 2024 09:48:35 +0000
> inv.git-commit@tdk.com wrote:
>=20
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >=20
> > When a sensor is running and there is a FIFO frequency change due to=20
> > another sensor turned on/off, there are glitches on timestamp. Fix=20
> > that by using only interrupt timestamp when there is the=20
> > corresponding sensor data in the FIFO.
> >=20
> > Delete FIFO period handling and simplify internal functions.
> >=20
> > Update integration inside inv_mpu6050 and inv_icm42600 drivers.
> >=20
> > Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic)
> > CC: stable@vger.kernel.org
> > Signed-off-by: Jean-Baptiste Maneyrol=20
> > <jean-baptiste.maneyrol@tdk.com>
>=20
> Whilst I don't fully follow the logic here, the new code is simpler=20
> and seems reasonable.  Getting my head around this will probably take=20
> longer than it's worth :(
>=20
> Hence applied to the fixes-togreg branch of iio.git.
This made a bit of a mess wrt to some new part additions that went in via t=
he togreg tree.

Given timing I'm going to pull the fixes on top of that tree so this will n=
eed a manual backport. Please take a look at iio.git togreg to check I didn=
't mess anything up.

Jonathan

>=20
> Jonathan
>=20
> > ---
> >  .../inv_sensors/inv_sensors_timestamp.c       | 24 +++++++++----------
> >  .../imu/inv_icm42600/inv_icm42600_buffer.c    | 20 +++++++---------
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  2 +-
> >  .../linux/iio/common/inv_sensors_timestamp.h  |  3 +--
> >  4 files changed, 21 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c=20
> > b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > index 3b0f9598a7c7..5f3ba77da740 100644
> > --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > @@ -70,13 +70,13 @@ int inv_sensors_timestamp_update_odr(struct=20
> > inv_sensors_timestamp *ts,  } =20
> > EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr,=20
> > IIO_INV_SENSORS_TIMESTAMP);
> >=20
> > -static bool inv_validate_period(struct inv_sensors_timestamp *ts,=20
> > uint32_t period, uint32_t mult)
> > +static bool inv_validate_period(struct inv_sensors_timestamp *ts,=20
> > +uint32_t period)
> >  {
> >  	uint32_t period_min, period_max;
> >=20
> >  	/* check that period is acceptable */
> > -	period_min =3D ts->min_period * mult;
> > -	period_max =3D ts->max_period * mult;
> > +	period_min =3D ts->min_period * ts->mult;
> > +	period_max =3D ts->max_period * ts->mult;
> >  	if (period > period_min && period < period_max)
> >  		return true;
> >  	else
> > @@ -84,15 +84,15 @@ static bool inv_validate_period(struct=20
> > inv_sensors_timestamp *ts, uint32_t perio  }
> >=20
> >  static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
> > -				    uint32_t mult, uint32_t period)
> > +				   uint32_t period)
> >  {
> >  	uint32_t new_chip_period;
> >=20
> > -	if (!inv_validate_period(ts, period, mult))
> > +	if (!inv_validate_period(ts, period))
> >  		return false;
> >=20
> >  	/* update chip internal period estimation */
> > -	new_chip_period =3D period / mult;
> > +	new_chip_period =3D period / ts->mult;
> >  	inv_update_acc(&ts->chip_period, new_chip_period);
> >  	ts->period =3D ts->mult * ts->chip_period.val;
> >=20
> > @@ -120,16 +120,14 @@ static void inv_align_timestamp_it(struct=20
> > inv_sensors_timestamp *ts)  }
> >=20
> >  void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
> > -				      uint32_t fifo_period, size_t fifo_nb,
> > -				      size_t sensor_nb, int64_t timestamp)
> > +				     size_t sample_nb, int64_t timestamp)
> >  {
> >  	struct inv_sensors_timestamp_interval *it;
> >  	int64_t delta, interval;
> > -	const uint32_t fifo_mult =3D fifo_period / ts->chip.clock_period;
> >  	uint32_t period;
> >  	bool valid =3D false;
> >=20
> > -	if (fifo_nb =3D=3D 0)
> > +	if (sample_nb =3D=3D 0)
> >  		return;
> >=20
> >  	/* update interrupt timestamp and compute chip and sensor periods=20
> > */ @@ -139,14 +137,14 @@ void inv_sensors_timestamp_interrupt(struct in=
v_sensors_timestamp *ts,
> >  	delta =3D it->up - it->lo;
> >  	if (it->lo !=3D 0) {
> >  		/* compute period: delta time divided by number of samples */
> > -		period =3D div_s64(delta, fifo_nb);
> > -		valid =3D inv_update_chip_period(ts, fifo_mult, period);
> > +		period =3D div_s64(delta, sample_nb);
> > +		valid =3D inv_update_chip_period(ts, period);
> >  	}
> >=20
> >  	/* no previous data, compute theoritical value from interrupt */
> >  	if (ts->timestamp =3D=3D 0) {
> >  		/* elapsed time: sensor period * sensor samples number */
> > -		interval =3D (int64_t)ts->period * (int64_t)sensor_nb;
> > +		interval =3D (int64_t)ts->period * (int64_t)sample_nb;
> >  		ts->timestamp =3D it->up - interval;
> >  		return;
> >  	}
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=20
> > b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> > index b52f328fd26c..9cde9a9337ad 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> > @@ -509,20 +509,20 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm=
42600_state *st)
> >  		return 0;
> >=20
> >  	/* handle gyroscope timestamp and FIFO data parsing */
> > -	ts =3D iio_priv(st->indio_gyro);
> > -	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.tota=
l,
> > -					st->fifo.nb.gyro, st->timestamp.gyro);
> >  	if (st->fifo.nb.gyro > 0) {
> > +		ts =3D iio_priv(st->indio_gyro);
> > +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
> > +						st->timestamp.gyro);
> >  		ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);
> >  		if (ret)
> >  			return ret;
> >  	}
> >=20
> >  	/* handle accelerometer timestamp and FIFO data parsing */
> > -	ts =3D iio_priv(st->indio_accel);
> > -	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.tota=
l,
> > -					st->fifo.nb.accel, st->timestamp.accel);
> >  	if (st->fifo.nb.accel > 0) {
> > +		ts =3D iio_priv(st->indio_accel);
> > +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
> > +						st->timestamp.accel);
> >  		ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);
> >  		if (ret)
> >  			return ret;
> > @@ -550,9 +550,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct=20
> > inv_icm42600_state *st,
> >=20
> >  	if (st->fifo.nb.gyro > 0) {
> >  		ts =3D iio_priv(st->indio_gyro);
> > -		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
> > -						st->fifo.nb.total, st->fifo.nb.gyro,
> > -						gyro_ts);
> > +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
> >  		ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);
> >  		if (ret)
> >  			return ret;
> > @@ -560,9 +558,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct=20
> > inv_icm42600_state *st,
> >=20
> >  	if (st->fifo.nb.accel > 0) {
> >  		ts =3D iio_priv(st->indio_accel);
> > -		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
> > -						st->fifo.nb.total, st->fifo.nb.accel,
> > -						accel_ts);
> > +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
> >  		ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);
> >  		if (ret)
> >  			return ret;
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=20
> > b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > index 86465226f7e1..0dc0f22a5582 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > @@ -100,7 +100,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
> >  		goto end_session;
> >  	/* Each FIFO data contains all sensors, so same number for FIFO and s=
ensor data */
> >  	fifo_period =3D NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->c=
hip_config.divider);
> > -	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, =
pf->timestamp);
> > +	inv_sensors_timestamp_interrupt(&st->timestamp, nb,=20
> > +pf->timestamp);
> >  	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb,=20
> > 0);
> >=20
> >  	/* clear internal data buffer for avoiding kernel data leak */=20
> > diff --git a/include/linux/iio/common/inv_sensors_timestamp.h=20
> > b/include/linux/iio/common/inv_sensors_timestamp.h
> > index a47d304d1ba7..8d506f1e9df2 100644
> > --- a/include/linux/iio/common/inv_sensors_timestamp.h
> > +++ b/include/linux/iio/common/inv_sensors_timestamp.h
> > @@ -71,8 +71,7 @@ int inv_sensors_timestamp_update_odr(struct inv_senso=
rs_timestamp *ts,
> >  				     uint32_t period, bool fifo);
> >=20
> >  void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
> > -				     uint32_t fifo_period, size_t fifo_nb,
> > -				     size_t sensor_nb, int64_t timestamp);
> > +				     size_t sample_nb, int64_t timestamp);
> >=20
> >  static inline int64_t inv_sensors_timestamp_pop(struct=20
> > inv_sensors_timestamp *ts)  {
> > --
> > 2.34.1
> >  =20
>=20
>=20




