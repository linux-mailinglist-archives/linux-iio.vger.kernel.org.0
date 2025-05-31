Return-Path: <linux-iio+bounces-20068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D47AC9B90
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD46E9E6FC8
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 15:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DC023C8C5;
	Sat, 31 May 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy3F6lDL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D287238D32;
	Sat, 31 May 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748706005; cv=none; b=s4Tx+znh5JheVf8tPUVWcr44jfHd3uPUDXRmqcVlxU+jMxKcCJhFoq2Dis1Y4vJZMv8SlomajCM9wLXsLsCc63YcdZFpmo4aUREGNngzP6RTRTNWL0vnW9PSQOH0KVySDALx8AknHReymvEqJZgFKZbKNzh5DTHmwwKbXAnHiO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748706005; c=relaxed/simple;
	bh=Q740V4g6+YWYiMOROFQ5FZm71j0aeRFIn3JtF8HgRVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfZw+HAP55MwHD9lAZXuoag3zT4kLe3wNoYaz0NO0wZvD90fgs4XBp/S1EsL/VSOmueWfCyj9aRE1xSyQMplZeF+NKOt9SvGVf3nxKHtb2lfn3p5Pvt9cwvwY57ProfuZzBgByT8EJqKQQznoRyDzsz9PcCqB1PBcRjI0S7FJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy3F6lDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8284C4CEE3;
	Sat, 31 May 2025 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748706005;
	bh=Q740V4g6+YWYiMOROFQ5FZm71j0aeRFIn3JtF8HgRVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sy3F6lDLumf2YdjzTKWgOSxceKoYYizMbxkmsUAavtHqf0NPRsR9uOSsbVhU5rpy7
	 aIJZDl6Htq8j1Xr1QnBBHh0EV4wXkWNy8bmQ5Jj1un8L2zYIbCsWsBFZ/ebkLO7XJq
	 Kj9yDkTaQawHzlKSHPDjiz5O0pLLZQYIWzoZfXud+AvyjB+Z8qlAxxbFZNPPviNsSj
	 z9CAGEuERJUyyj1t6+HTcQFU/XKaC4Td8FkwkWPJgIQnC1P894ZiisnA0qcYKRkz1Z
	 bpQmtRxFpaG4NaeBot6FvKrxfORQOgQgOT8wQvWC6Ta4p6pzmqpJlLPxxngqWVC4wL
	 e1K2SusySnAmg==
Date: Sat, 31 May 2025 16:39:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v8 6/7] iio: accel: adxl345: add freefall feature
Message-ID: <20250531163958.211467a5@jic23-huawei>
In-Reply-To: <CAFXKEHY3aWk8+M9DhV--_2Z2G8L7jFCZvjuPB5xLrf_LwEF8AQ@mail.gmail.com>
References: <20250510224405.17910-1-l.rubusch@gmail.com>
	<20250510224405.17910-7-l.rubusch@gmail.com>
	<20250525181902.72178be9@jic23-huawei>
	<CAFXKEHY3aWk8+M9DhV--_2Z2G8L7jFCZvjuPB5xLrf_LwEF8AQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 May 2025 09:31:57 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sun, May 25, 2025 at 7:19=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sat, 10 May 2025 22:44:04 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add the freefall detection of the sensor together with a threshold and
> > > time parameter. A freefall magnitude event is detected if the measuri=
ng
> > > signal falls below the threshold.
> > >
> > > Introduce a freefall threshold stored in regmap cache, and a freefall
> > > time, having the scaled time value stored as a member variable in the
> > > state instance.
> > >
> > > The generated IIO event is a magnitude event on x&y&z and thus identi=
cal
> > > to what inactivity (with DC-coupling default) would generate. Thus a
> > > separate set of sysfs handles are setup to configure and enable freef=
all
> > > events.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > Hi Lothar,
> >
> > Up until here all looked good to me but the custom ABI in here
> > would need documenting in Documentation/ABI/testing/sysfs-bus-iio* and
> > runs into the normal problem with custom ABI. It's basically pointless
> > because no generic code will use it.  Current code assume freefall
> > is a standard magnitude falling threshold on X&Y&Z.
> >
> > So it doesn't provide a solution for inactivity DC and freefall effecti=
vely
> > being the same type of detection with different timing parameters.
> >
> > The only thing I have come up with that is at least close to standard
> > ABI in this annoying corner case is to use an additional fake channel
> > with it's own controls as in_accel1_X&Y&Z_*
> > We can use label to indicate to a user that it is meant for freefall but
> > labels are also effectively custom ABI (though ABI that is easy to just
> > pass through to a user interface) so that's not great.  Also, so far
> > the concept of multiple 'fake' channels isn't a thing so userspace is
> > unlikely to cope with that well either.
> >
> > The decision way back to not have multiple events of one type on a given
> > channel has bitten us a few times before, but this is a little unusual
> > in that it's not just stacked threshold like you get on hwmon chips whe=
re
> > people don't want to keep changing thresholds when warning levels are
> > passed because of that temporal element. Those can be dealt with via
> > more sophisticated userspace code.
> >
> > No comments below. I haven't looked closely given this fundamental
> > ABI difference.
> >
> > Maybe best bet is mere everything other than freefall detection and
> > basically kick this into the long grass until we figure out a solution =
that
> > can sit in the normal ABI without breaking old software (which a change
> > to a new free fall interface would unfortunately do.)
> >
> > Sorry not to have a better idea :(
> > =20
>=20
> No problem, this answer was already expected. I will exclude freefall
> from the current patch set.
>=20
> Note, at the moment you still did not go through activity, inactivity
> and link bit. Pls, don't apply them now. While working on the adxl313,
> I found that the ADXL345 implementation still needs a small fix.
> Aside, I'd like to use my new regmap favorite regmap_assign_bits()
> here, too. Anyway I'd appreciate feedback on the current
> activity/inactivity patches, though.

I did look through them but had nothing useful to say as they looked
good to me.  I'll probably take a final look when you post the version
with the changes you mention though.

>=20
> The "freefall inactivity dilemma" is a bit annoying for actually two
> reasons. First, it does not feel well to surrender in front of two
> simple events as such. Second, it's not just about dropping freefall,
> but also leaves another question aside. Activity/inactivity are now
> linked when both are enabled - shouldn't there be a way to allow for
> activity / inactivity un-linked? I mean, just as events and not
> coupled to auto-sleep? Actually this feels a bit like
> MAG_EV_REFERENCED having MAG_EV_STATECHANGE or INFO_STATECHANGE. And
> this smells probably too much like custom API... Just kidding, but I
> just wanted to mention it, and like to shift this question also to a
> separate patch set.

(As you know) custom ABI is a pain for this and the only thing we have
that is close is hysteresis.  If they were both on the same channel
boolean operation (say both were x&y&z) then we could just use that
with the hysteresis value being the difference between the two thresholds.
With one being x&y&z and the other x|y|z we can't really do this.

It might be possible to define a coupling ABI / chaining of events
style thing that would allow us to define this cleanly but it is likely
that would get complex to understand and we'd need to fully understand
the use cases across a range of devices to try and figure out the commonali=
ty.

The autosleep is kind of separate again from the link. That falls into
the common problem area of power saving functionality. There is a silly lev=
el
of complexity in what different devices do in the way of power saving
tricks so we either map them to something else (e.g. whatever
mode suits the sampling frequency) or try to make best attempt to auto
adjust them in the driver.  Maybe here we should disable autosleep
if buffered mode is in use (on basis user is asking for consistent
data) and otherwise enable it because lower sampling frequency is
probably fine for monitoring.  Ultimately we do have the option of
per event sampling frequencies in_accel_x&y&z_mag_rising_sampling_frequency
that could be used to control the frequency at which we check for
activity to be either the sleep mode mode or the normal one.
That's not a common bit of ABI but is there for the case of
devices that have a monitor mode but no dataready type signal
so the frequency is only relevant for events.
Note that the only documented version of that bit of the ABI today
is the one that applies to all events.

/sys/bus/iio/devices/iio:deviceX/events/sampling_frequency

I'd not be against adding per event versions as they are consistent
with the existing ABI.  The quirk around what they mean are a bit
non-obvious as we define per channel sampling_frequency differently
from sampling_frequency when it comes to effective overall rates.
How that applies to events will need specific documentation.

See docs for /sys/bus/iio/devices/iio:deviceX/in_voltageY_sampling_frequency
for the info on that wrinkle of the existing ABI.=20

That's not really a problem if we only define one of these though
as no periods to add :)

>=20
> Some freefall idea: Practically given, a freefall is an inactivity MAG
> event with low inactivity time, and inactivity is an inactivity MAG
> event with larger inactivity time.

For this device yes that's the case for DC coupling anyway.  Worth
keeping in mind that other sensors use entirely different things
for 'activity' detection.

> After reasoning a bit more, I can think of some exclusive
> implementation based on the threshold times [this is nothing new, I
> think you mentioned something into this direction already?]. Unsure if
> this is possible, I may try this here and in case present it
> separately: Say, if inactivity time obtained by sysfs is greater than
> x seconds, a freefall event will be set up. If smaller, an inactivity
> event will be set up. If freefall is enabled (and, in case, activity),
> both will remain unlinked. If inactivity and activity are enabled,
> i.e. the larger inactivity time setting - both events will be linked
> with autosleep.

That could definitely be done and I think makes reasonable sense.
If someone wants freefall detection they are unlikely to set a long
period (as the device will hit the ground!)

The link thing and autosleep is kind of us trying to do the right
thing for what we guess the user wants so that is fine too.

Jonathan

>=20
> Best,
> L
>=20
> > Jonathan
> >
> > =20
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 226 +++++++++++++++++++++++++++++=
++
> > >  1 file changed, 226 insertions(+)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index c6f75d6b0db9..c35a5727852c 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -193,6 +193,7 @@ struct adxl345_state {
> > >       u32 tap_duration_us;
> > >       u32 tap_latent_us;
> > >       u32 tap_window_us;
> > > +     u32 ff_time_ms;
> > >
> > >       __le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned=
(IIO_DMA_MINALIGN);
> > >  };
> > > @@ -825,6 +826,63 @@ static int adxl345_set_tap_latent(struct adxl345=
_state *st, u32 val_int,
> > >       return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_f=
ract_us);
> > >  }
> > >
> > > +/* free-fall */
> > > +
> > > +static int adxl345_is_ff_en(struct adxl345_state *st, bool *en)
> > > +{
> > > +     int ret;
> > > +     unsigned int regval;
> > > +
> > > +     ret =3D regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval=
);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     *en =3D FIELD_GET(ADXL345_INT_FREE_FALL, regval) > 0;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
> > > +{
> > > +     unsigned int regval, ff_threshold;
> > > +     bool en;
> > > +     int ret;
> > > +
> > > +     ret =3D regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_thre=
shold);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     en =3D cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
> > > +
> > > +     regval =3D en ? ADXL345_INT_FREE_FALL : 0x00;
> > > +
> > > +     return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> > > +                               ADXL345_INT_FREE_FALL, regval);
> > > +}
> > > +
> > > +static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
> > > +                            u32 val_fract_us)
> > > +{
> > > +     unsigned int regval;
> > > +     int val_ms;
> > > +
> > > +     /*
> > > +      * max value is 255 * 5000 us =3D 1.275000 seconds
> > > +      *
> > > +      * Note: the scaling is similar to the scaling in the ADXL380
> > > +      */
> > > +     if (1000000 * val_int + val_fract_us > 1275000)
> > > +             return -EINVAL;
> > > +
> > > +     val_ms =3D val_int * 1000 + DIV_ROUND_UP(val_fract_us, 1000);
> > > +     st->ff_time_ms =3D val_ms;
> > > +
> > > +     regval =3D DIV_ROUND_CLOSEST(val_ms, 5);
> > > +
> > > +     /* Values between 100ms and 350ms (0x14 to 0x46) are recommende=
d. */
> > > +     return regmap_write(st->regmap, ADXL345_REG_TIME_FF, min(regval=
, 0xff));
> > > +}
> > > +
> > >  static int adxl345_find_odr(struct adxl345_state *st, int val,
> > >                           int val2, enum adxl345_odr *odr)
> > >  {
> > > @@ -1689,6 +1747,17 @@ static int adxl345_push_event(struct iio_dev *=
indio_dev, int int_stat,
> > >                       return ret;
> > >       }
> > >
> > > +     if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
> > > +             ret =3D iio_push_event(indio_dev,
> > > +                                  IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > > +                                                     IIO_MOD_X_AND_Y=
_AND_Z,
> > > +                                                     IIO_EV_TYPE_MAG,
> > > +                                                     IIO_EV_DIR_FALL=
ING),
> > > +                                  ts);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > >       if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
> > >               samples =3D adxl345_get_samples(st);
> > >               if (samples < 0)
> > > @@ -1763,7 +1832,156 @@ static irqreturn_t adxl345_irq_handler(int ir=
q, void *p)
> > >       return IRQ_HANDLED;
> > >  }
> > >
> > > +/* free-fall sysfs */
> > > +
> > > +static ssize_t in_accel_mag_freefall_en_show(struct device *dev,
> > > +                                          struct device_attribute *a=
ttr,
> > > +                                          char *buf)
> > > +{
> > > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > > +     bool en;
> > > +     int val, ret;
> > > +
> > > +     ret =3D adxl345_is_ff_en(st, &en);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     val =3D en ? 1 : 0;
> > > +
> > > +     return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> > > +}
> > > +
> > > +static ssize_t in_accel_mag_freefall_en_store(struct device *dev,
> > > +                                           struct device_attribute *=
attr,
> > > +                                           const char *buf, size_t l=
en)
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
> > > +     ret =3D adxl345_set_ff_en(st, val > 0);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D adxl345_set_measure_en(st, true);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return len;
> > > +}
> > > +static IIO_DEVICE_ATTR_RW(in_accel_mag_freefall_en, 0);
> > > +
> > > +static ssize_t in_accel_mag_freefall_value_show(struct device *dev,
> > > +                                             struct device_attribute=
 *attr,
> > > +                                             char *buf)
> > > +{
> > > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > > +     unsigned int val;
> > > +     int ret;
> > > +
> > > +     ret =3D regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &val);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> > > +}
> > > +
> > > +static ssize_t in_accel_mag_freefall_value_store(struct device *dev,
> > > +                                              struct device_attribut=
e *attr,
> > > +                                              const char *buf, size_=
t len)
> > > +{
> > > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > > +     int val, ret;
> > > +
> > > +     ret =3D kstrtoint(buf, 0, &val);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (val < 0 || val > 255)
> > > +             return -EINVAL;
> > > +
> > > +     ret =3D adxl345_set_measure_en(st, false);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D regmap_write(st->regmap, ADXL345_REG_THRESH_FF, val);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D adxl345_set_measure_en(st, true);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return len;
> > > +}
> > > +static IIO_DEVICE_ATTR_RW(in_accel_mag_freefall_value, 0);
> > > +
> > > +static ssize_t in_accel_mag_freefall_period_show(struct device *dev,
> > > +                                              struct device_attribut=
e *attr,
> > > +                                              char *buf)
> > > +{
> > > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > > +     int vals[2];
> > > +
> > > +     vals[0] =3D st->ff_time_ms;
> > > +     vals[1] =3D 1000;
> > > +
> > > +     return iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, vals);
> > > +}
> > > +
> > > +static ssize_t in_accel_mag_freefall_period_store(struct device *dev,
> > > +                                               struct device_attribu=
te *attr,
> > > +                                               const char *buf, size=
_t len)
> > > +{
> > > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > > +     int val_int, val_fract_us, ret;
> > > +
> > > +     ret =3D iio_str_to_fixpoint(buf, 100000, &val_int, &val_fract_u=
s);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D adxl345_set_measure_en(st, false);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D adxl345_set_ff_time(st, val_int, val_fract_us);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D adxl345_set_measure_en(st, true);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return len;
> > > +}
> > > +static IIO_DEVICE_ATTR_RW(in_accel_mag_freefall_period, 0);
> > > +
> > > +static struct attribute *adxl345_event_attrs[] =3D {
> > > +     &iio_dev_attr_in_accel_mag_freefall_en.dev_attr.attr,
> > > +     &iio_dev_attr_in_accel_mag_freefall_value.dev_attr.attr,
> > > +     &iio_dev_attr_in_accel_mag_freefall_period.dev_attr.attr,
> > > +     NULL
> > > +};
> > > +
> > > +static const struct attribute_group adxl345_event_attrs_group =3D {
> > > +     .attrs =3D adxl345_event_attrs,
> > > +};
> > > +
> > >  static const struct iio_info adxl345_info =3D {
> > > +     .event_attrs    =3D &adxl345_event_attrs_group,
> > >       .read_raw       =3D adxl345_read_raw,
> > >       .write_raw      =3D adxl345_write_raw,
> > >       .read_avail     =3D adxl345_read_avail,
> > > @@ -1806,6 +2024,7 @@ int adxl345_core_probe(struct device *dev, stru=
ct regmap *regmap,
> > >                                        ADXL345_DATA_FORMAT_FULL_RES |
> > >                                        ADXL345_DATA_FORMAT_SELF_TEST);
> > >       unsigned int tap_threshold;
> > > +     unsigned int ff_threshold;
> > >       int ret;
> > >
> > >       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> > > @@ -1825,6 +2044,9 @@ int adxl345_core_probe(struct device *dev, stru=
ct regmap *regmap,
> > >       st->tap_window_us =3D 64;                 /*   64 [0x40] -> .08=
0    */
> > >       st->tap_latent_us =3D 16;                 /*   16 [0x10] -> .02=
0    */
> > >
> > > +     ff_threshold =3D 8;                       /*    8 [0x08]       =
     */
> > > +     st->ff_time_ms =3D 32;                    /*   32 [0x20] -> 0.1=
6    */
> > > +
> > >       indio_dev->name =3D st->info->name;
> > >       indio_dev->info =3D &adxl345_info;
> > >       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > @@ -1936,6 +2158,10 @@ int adxl345_core_probe(struct device *dev, str=
uct regmap *regmap,
> > >               if (ret)
> > >                       return ret;
> > >
> > > +             ret =3D regmap_write(st->regmap, ADXL345_REG_THRESH_FF,=
 ff_threshold);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > >               /* FIFO_STREAM mode is going to be activated later */
> > >               ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev, &ad=
xl345_buffer_ops);
> > >               if (ret) =20
> > =20


