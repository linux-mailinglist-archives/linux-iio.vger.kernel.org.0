Return-Path: <linux-iio+bounces-15885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F313A3E300
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 18:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1F217C6A1
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3AE2139C4;
	Thu, 20 Feb 2025 17:47:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF86213E64;
	Thu, 20 Feb 2025 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073674; cv=none; b=DnkgUdcYOtTGnWFXo92R3RDHUKoox+ji+9Rj+i1OWtVp9RcV58FegFJww9ND0rSxYTCTpCkD4aU8LWH4yW9sAuytFk9K+40tF4tgTXe7QEkI3NVG2fTOWI/g2ZgfUlVI9FQKayRi/EEoVZ2efLaP2aML/NLeVsBVjMifoLQuC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073674; c=relaxed/simple;
	bh=kMQJ57kA5Yur3dI+lzKDp2c8T/y2nrCq0BoU1i+qdrw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fV3GmNS4+A9bCtUrHml37zfdN1vqSLkAIhui+xhMWtyWQZPwB1qGMjQznjzluc6Oyc/OYUhkkaO8CY2xzbCCHjbUbN4vEnrVr7NC/eefWPt12zXa8sZzZLnTKGNNhMkxkUsiYE8VF6r0S1pYJw+8bUGqIwnELRq6pxvU/5Q2Tvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzLKG2Hd5z6HJfV;
	Fri, 21 Feb 2025 01:46:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DFCD140257;
	Fri, 21 Feb 2025 01:47:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 18:47:48 +0100
Date: Thu, 20 Feb 2025 17:47:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eraretuya@gmail.com>
Subject: Re: [PATCH v2 07/14] iio: accel: adxl345: add double tap suppress
 bit
Message-ID: <20250220174747.0000157a@huawei.com>
In-Reply-To: <CAFXKEHY+ozW=r17fdvKYhyWDKkddZxptp5kFKdD9k4mwjutPbQ@mail.gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-8-l.rubusch@gmail.com>
	<20250216172845.2fe98ea1@jic23-huawei>
	<CAFXKEHY+ozW=r17fdvKYhyWDKkddZxptp5kFKdD9k4mwjutPbQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 23:29:46 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Dear Jonathan, find my answer down below.
>=20
> On Sun, Feb 16, 2025 at 6:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Mon, 10 Feb 2025 11:01:12 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add the suppress bit feature to the double tap feature.
> > >
> > > Any tap event is defined by a rising signal edge above threshold, i.e.
> > > duration time starts counting; and the falling edge under threshold
> > > within duration time, i.e. then the tap event is issued. This means
> > > duration is used individually for each tap event.
> > >
> > > For double tap detection after a single tap, a latency time needs to =
be
> > > specified. Usually tap events, i.e. spikes above and returning below
> > > threshold will be ignored within latency. After latency, the window
> > > time starts counting for a second tap detection which has to happen
> > > within a duration time.
> > >
> > > If the suppress bit is not set, spikes within latency time are ignore=
d.
> > > Setting the suppress bit will invalidate the double tap function. The
> > > sensor will thus be able to save the window time for double tap
> > > detection, and follow a more strict definition of what signal qualifi=
es
> > > for a double tap. =20
> >
> > Silly question.  Is there a reason this function would ever be
> > turned off?   Seems like a sensible heuristic that would not stop
> > genuine double taps being detected.  Maybe we just always leave it on?
> >
> > Sometimes the best ABI is the one that doesn't exist as userspace
> > can't use it wrong.
> >
> > Jonathan
> > =20
>=20
> hehehe..  you already mentioned this point, I guess. At least I tried
> to put my understanding of it into the lengthy comment of the patch.
> Well, patches with lengthy comments.... this seems to go into the same
> direction as the wisdom of better limiting userspace interfaces in
> general ;)
>=20
> TBH you have probably seen far more sensors than me, as I'm doing this
> just as hobbyist to learn and for fun. I only can provide my
> understanding of the particular datasheet.
> I think, to set or not to set this bit changes little. It influences a
> bit how restrictive the latency period is handled at detection.
> Doubletaps are detected with or without having the "suppress" bit set.
> If set, AFAIK it could be harder to detect doubletaps. So to speak,
> you could reduce "noise" in double tapping (?), or if one receives too
> many double taps...(?) perhaps,  ..eh.. legal reasons?! Personally,
> I'd liked to play with this sensor a bit, and I found it then useful
> to have some kind of knob to change a bit and see what happens without
> really messing things up.
> As I'm not too familiar with the accelerometer scene and such kind of
> "power user settings". I'm unsure if there are typical usecases here.
> I would agree that usually one would leave that in one  setting,
> turned on or off (unless he/she enters in obsession with double taps).
>=20
> Perhaps I'll change this patch so that it's always set or not set (to
> bring it initially into a defined state), but no sysfs is around.
> Let's see. If you think I'd better just drop it entirly, let me know
> then.
I think default to always set.  We can revisit the ABI question later
if turns out to have be something people change in practice!

Jonathan

>=20
> Best,
> L
>=20
> > =20
> > >
> > > This brings in a new ABI functionality.
> > > ---
> > > Q: Perhaps there is already some IIO ABI for it? If not, please let me
> > > know which ABI documentation to extend. There will be a documentation
> > > patch also later in this series.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 82 ++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 82 insertions(+)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index cf35a8f9f432..b6966fee3e3d 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -34,6 +34,7 @@
> > >  #define ADXL345_INT2                 1
> > >
> > >  #define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> > > +#define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> > >
> > >  enum adxl345_axis {
> > >       ADXL345_Z_EN =3D BIT(0),
> > > @@ -81,6 +82,7 @@ struct adxl345_state {
> > >       u32 tap_duration_us;
> > >       u32 tap_latent_us;
> > >       u32 tap_window_us;
> > > +     bool tap_suppressed;
> > >
> > >       __le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned=
(IIO_DMA_MINALIGN);
> > >  };
> > > @@ -243,6 +245,31 @@ static int adxl345_set_doubletap_en(struct adxl3=
45_state *st, bool en)
> > >       return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
> > >  }
> > >
> > > +static int adxl345_is_suppressed_en(struct adxl345_state *st, bool *=
en)
> > > +{
> > > +     *en =3D st->tap_suppressed;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int adxl345_set_suppressed_en(struct adxl345_state *st, bool =
en)
> > > +{
> > > +     unsigned long regval =3D 0;
> > > +     int ret;
> > > +
> > > +     en ? __set_bit(ilog2(ADXL345_TAP_SUPPRESS), &regval)
> > > +             : __clear_bit(ilog2(ADXL345_TAP_SUPPRESS), &regval);
> > > +
> > > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
> > > +                              ADXL345_REG_TAP_SUPPRESS_MSK, regval);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     st->tap_suppressed =3D en;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static int adxl345_set_tap_threshold(struct adxl345_state *st, u8 va=
l)
> > >  {
> > >       int ret;
> > > @@ -616,6 +643,60 @@ static int adxl345_write_raw_get_fmt(struct iio_=
dev *indio_dev,
> > >       }
> > >  }
> > >
> > > +static ssize_t in_accel_gesture_doubletap_suppressed_en_show(struct =
device *dev,
> > > +                                                          struct dev=
ice_attribute *attr,
> > > +                                                          char *buf)
> > > +{
> > > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > > +     bool en;
> > > +     int val, ret;
> > > +
> > > +     ret =3D adxl345_is_suppressed_en(st, &en);
> > > +     if (ret)
> > > +             return ret;
> > > +     val =3D en ? 1 : 0;
> > > +
> > > +     return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> > > +}
> > > +
> > > +static ssize_t in_accel_gesture_doubletap_suppressed_en_store(struct=
 device *dev,
> > > +                                                           struct de=
vice_attribute *attr,
> > > +                                                           const cha=
r *buf, size_t len)
> > > +{
> > > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > > +     int val, ret;
> > > +
> > > +     ret =3D kstrtoint(buf, 0, &val);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D adxl345_set_measure_en(st, false);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D adxl345_set_suppressed_en(st, val > 0);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D  adxl345_set_measure_en(st, true);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return len;
> > > +}
> > > +static IIO_DEVICE_ATTR_RW(in_accel_gesture_doubletap_suppressed_en, =
0);
> > > +
> > > +static struct attribute *adxl345_event_attrs[] =3D {
> > > +     &iio_dev_attr_in_accel_gesture_doubletap_suppressed_en.dev_attr=
.attr,
> > > +     NULL
> > > +};
> > > +
> > > +static const struct attribute_group adxl345_event_attrs_group =3D {
> > > +     .attrs =3D adxl345_event_attrs,
> > > +};
> > > +
> > >  static void adxl345_powerdown(void *ptr)
> > >  {
> > >       struct adxl345_state *st =3D ptr;
> > > @@ -899,6 +980,7 @@ static irqreturn_t adxl345_irq_handler(int irq, v=
oid *p)
> > >
> > >  static const struct iio_info adxl345_info =3D {
> > >       .attrs          =3D &adxl345_attrs_group,
> > > +     .event_attrs    =3D &adxl345_event_attrs_group,
> > >       .read_raw       =3D adxl345_read_raw,
> > >       .write_raw      =3D adxl345_write_raw,
> > >       .write_raw_get_fmt      =3D adxl345_write_raw_get_fmt, =20
> > =20
>=20


