Return-Path: <linux-iio+bounces-19961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9D4AC495A
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 09:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84CE3B59FC
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 07:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0A61A0BD6;
	Tue, 27 May 2025 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyHh+gGt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F8242D69;
	Tue, 27 May 2025 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748331158; cv=none; b=OyCRmKhzne/67HKlvj9nKFh/L/8PW3qBoiSYJ57gN1gSgrDkhxMopSlQ3OSQAJuL1G4qcwcnUCaeA9J28FO8/j1+1g/qjnXnXAar1oo1znRVByBGiadvFHsq3gC/i1g/irVEJPhXnVzZBbagch+YipYJsaA7xICddb5uG5alIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748331158; c=relaxed/simple;
	bh=hwMtFQ3vyBYKQrjLYWXwXv3raeZGbhalFujW0+EAdQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbxKk9H6YadtpOQk9lR4Bfro6uZfYKXVfiWiXdm7UR+AxLoRXAzI/RbwPqR0pD9hpHJcNMeUrxdxv8NUlr+gmdpWhJV85bOSuLtlYevFnPAYE1ILSY/kx/xWJBtqjtWTcF53sLxz3vMvRzbM9szpa/DqfWEHASyRGhbPWBK4nac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyHh+gGt; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e7dc768cb71so41243276.1;
        Tue, 27 May 2025 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748331154; x=1748935954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiUrJQO7WnWxynngGL8ocS1YBgT0dGbacj7jtDADJ1c=;
        b=EyHh+gGtTMzJYJHWOfVKvkRF00smQW14N8RayO/015UrVhQqQrgI5ARzVP0RvykrR3
         o1uNzoRCtp+B41LpfKPbLUJT9ICeD3jn0De2VbHWAwSDBDyDFCA87dkF7BVpiwRitt26
         8Jh1LLLiIFAgGdrsyEaLKfsQlDYA8R68FTo0si2ISCKnOdg7o7f7TCKGNXziNOzTRFkK
         jY5lJdLcqZd2x9nslUhelveVaeGeChXAaK54zgm9q4jHsxo+cw35VtRa2OJswyQc3Tb7
         pj7e6O1qUNbKWOXziO3jRqEvGWD7ii0eiyFXR0HcOfbS1ESO51CTY+xMvi4aAZnt+zK4
         QH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748331154; x=1748935954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiUrJQO7WnWxynngGL8ocS1YBgT0dGbacj7jtDADJ1c=;
        b=NwT0sD/axJohcXDjzy+4Cx/67KhbKzuts5WbZB1lSJqafN2xkf9TEBnhdopH465Ok1
         zMw1tX6nBUJi4+wpZNwBrD8sKGKLUKm7Oislmq0ik2eY2kDFN53SrStSi3IrB5NDOGuz
         xX0XH6BsUPN9DcFKZBeBRHmppeYSqjm1GzzOCrJmbYnxP77W44gjTiMqHm2KKRI0fIi0
         uVGy3gIx64WG1yZSWI6fAkur3uMShmPHBrWQ3m7Q+En8cVy5v0+artSU2QaoAxI/MojP
         F5oGz5EJ/JPKsIhoG1H9exLD4rum6Fs5/VvU/fZ6mRxGkwLZsdp/BSdf405Ngxr+hljB
         BFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs4Z4sKKtWPwxCZ7x+uVG+LXlc/wKOhNCSKd70uvJiIGdl5oeKsQ01KmQgqQim/sUs10ry/tszjGk=@vger.kernel.org, AJvYcCWqU/uZCKMCg5MtbheO8hpsZCQDHZxtlC76VeVlEj3Rs/dXrkyyW6JwbKlYhSapCV3wwj+tFe6UWS6jS6r5@vger.kernel.org
X-Gm-Message-State: AOJu0YzyKVvU/4gf9Qf95BWKhAMpygbqd5+u2yQ0/zTnGy1VIpGBny0m
	VTgz8lSONs7K4yvsMD2/RhPnuBI2z6rrszSrdtI5r0kCG0mFuhUtSuuF5YvQMydHyevWpojp6ZS
	Z4z3QQPP+y+gHsPZrDtWT4jGix04Fb0U=
X-Gm-Gg: ASbGncshmRr3WugwzYLh6o0xqyXy096rsHNTi9y/GwYzirurC1T/WFiSvzAVN6PTT5i
	9E7L/UCwVWKs3G8H++XJaRFEkxXnbjLa8xXVUdUEkIMM2NA1tl7X3WC0hd6rXtqs6nilGm3GY9/
	GSSBpAQxyofbhQYSRgzUvPfu3lv/GOaL6qLbmXJDWz60A=
X-Google-Smtp-Source: AGHT+IGXUkjpwr4/s4EIAfVWWVbCBuxjAEHL6AVKmlKaYyYHGM3vot9kkX6ZwMuKN9BLCZX4+Ys/vTA0o0XT/vb/ybk=
X-Received: by 2002:a05:690c:387:b0:70e:cbd:da27 with SMTP id
 00721157ae682-70e2da6c996mr61993507b3.6.1748331153868; Tue, 27 May 2025
 00:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510224405.17910-1-l.rubusch@gmail.com> <20250510224405.17910-7-l.rubusch@gmail.com>
 <20250525181902.72178be9@jic23-huawei>
In-Reply-To: <20250525181902.72178be9@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 27 May 2025 09:31:57 +0200
X-Gm-Features: AX0GCFs5tzF9DpqDvw4uIjKImHo_0GOKa4pxBPZD5hm5sAmzqO9fREn9sS1dVBk
Message-ID: <CAFXKEHY3aWk8+M9DhV--_2Z2G8L7jFCZvjuPB5xLrf_LwEF8AQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] iio: accel: adxl345: add freefall feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 7:19=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 10 May 2025 22:44:04 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the freefall detection of the sensor together with a threshold and
> > time parameter. A freefall magnitude event is detected if the measuring
> > signal falls below the threshold.
> >
> > Introduce a freefall threshold stored in regmap cache, and a freefall
> > time, having the scaled time value stored as a member variable in the
> > state instance.
> >
> > The generated IIO event is a magnitude event on x&y&z and thus identica=
l
> > to what inactivity (with DC-coupling default) would generate. Thus a
> > separate set of sysfs handles are setup to configure and enable freefal=
l
> > events.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Hi Lothar,
>
> Up until here all looked good to me but the custom ABI in here
> would need documenting in Documentation/ABI/testing/sysfs-bus-iio* and
> runs into the normal problem with custom ABI. It's basically pointless
> because no generic code will use it.  Current code assume freefall
> is a standard magnitude falling threshold on X&Y&Z.
>
> So it doesn't provide a solution for inactivity DC and freefall effective=
ly
> being the same type of detection with different timing parameters.
>
> The only thing I have come up with that is at least close to standard
> ABI in this annoying corner case is to use an additional fake channel
> with it's own controls as in_accel1_X&Y&Z_*
> We can use label to indicate to a user that it is meant for freefall but
> labels are also effectively custom ABI (though ABI that is easy to just
> pass through to a user interface) so that's not great.  Also, so far
> the concept of multiple 'fake' channels isn't a thing so userspace is
> unlikely to cope with that well either.
>
> The decision way back to not have multiple events of one type on a given
> channel has bitten us a few times before, but this is a little unusual
> in that it's not just stacked threshold like you get on hwmon chips where
> people don't want to keep changing thresholds when warning levels are
> passed because of that temporal element. Those can be dealt with via
> more sophisticated userspace code.
>
> No comments below. I haven't looked closely given this fundamental
> ABI difference.
>
> Maybe best bet is mere everything other than freefall detection and
> basically kick this into the long grass until we figure out a solution th=
at
> can sit in the normal ABI without breaking old software (which a change
> to a new free fall interface would unfortunately do.)
>
> Sorry not to have a better idea :(
>

No problem, this answer was already expected. I will exclude freefall
from the current patch set.

Note, at the moment you still did not go through activity, inactivity
and link bit. Pls, don't apply them now. While working on the adxl313,
I found that the ADXL345 implementation still needs a small fix.
Aside, I'd like to use my new regmap favorite regmap_assign_bits()
here, too. Anyway I'd appreciate feedback on the current
activity/inactivity patches, though.

The "freefall inactivity dilemma" is a bit annoying for actually two
reasons. First, it does not feel well to surrender in front of two
simple events as such. Second, it's not just about dropping freefall,
but also leaves another question aside. Activity/inactivity are now
linked when both are enabled - shouldn't there be a way to allow for
activity / inactivity un-linked? I mean, just as events and not
coupled to auto-sleep? Actually this feels a bit like
MAG_EV_REFERENCED having MAG_EV_STATECHANGE or INFO_STATECHANGE. And
this smells probably too much like custom API... Just kidding, but I
just wanted to mention it, and like to shift this question also to a
separate patch set.

Some freefall idea: Practically given, a freefall is an inactivity MAG
event with low inactivity time, and inactivity is an inactivity MAG
event with larger inactivity time.
After reasoning a bit more, I can think of some exclusive
implementation based on the threshold times [this is nothing new, I
think you mentioned something into this direction already?]. Unsure if
this is possible, I may try this here and in case present it
separately: Say, if inactivity time obtained by sysfs is greater than
x seconds, a freefall event will be set up. If smaller, an inactivity
event will be set up. If freefall is enabled (and, in case, activity),
both will remain unlinked. If inactivity and activity are enabled,
i.e. the larger inactivity time setting - both events will be linked
with autosleep.

Best,
L

> Jonathan
>
>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 226 +++++++++++++++++++++++++++++++
> >  1 file changed, 226 insertions(+)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index c6f75d6b0db9..c35a5727852c 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -193,6 +193,7 @@ struct adxl345_state {
> >       u32 tap_duration_us;
> >       u32 tap_latent_us;
> >       u32 tap_window_us;
> > +     u32 ff_time_ms;
> >
> >       __le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(I=
IO_DMA_MINALIGN);
> >  };
> > @@ -825,6 +826,63 @@ static int adxl345_set_tap_latent(struct adxl345_s=
tate *st, u32 val_int,
> >       return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fra=
ct_us);
> >  }
> >
> > +/* free-fall */
> > +
> > +static int adxl345_is_ff_en(struct adxl345_state *st, bool *en)
> > +{
> > +     int ret;
> > +     unsigned int regval;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> > +     if (ret)
> > +             return ret;
> > +
> > +     *en =3D FIELD_GET(ADXL345_INT_FREE_FALL, regval) > 0;
> > +
> > +     return 0;
> > +}
> > +
> > +static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
> > +{
> > +     unsigned int regval, ff_threshold;
> > +     bool en;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_thresh=
old);
> > +     if (ret)
> > +             return ret;
> > +
> > +     en =3D cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
> > +
> > +     regval =3D en ? ADXL345_INT_FREE_FALL : 0x00;
> > +
> > +     return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> > +                               ADXL345_INT_FREE_FALL, regval);
> > +}
> > +
> > +static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
> > +                            u32 val_fract_us)
> > +{
> > +     unsigned int regval;
> > +     int val_ms;
> > +
> > +     /*
> > +      * max value is 255 * 5000 us =3D 1.275000 seconds
> > +      *
> > +      * Note: the scaling is similar to the scaling in the ADXL380
> > +      */
> > +     if (1000000 * val_int + val_fract_us > 1275000)
> > +             return -EINVAL;
> > +
> > +     val_ms =3D val_int * 1000 + DIV_ROUND_UP(val_fract_us, 1000);
> > +     st->ff_time_ms =3D val_ms;
> > +
> > +     regval =3D DIV_ROUND_CLOSEST(val_ms, 5);
> > +
> > +     /* Values between 100ms and 350ms (0x14 to 0x46) are recommended.=
 */
> > +     return regmap_write(st->regmap, ADXL345_REG_TIME_FF, min(regval, =
0xff));
> > +}
> > +
> >  static int adxl345_find_odr(struct adxl345_state *st, int val,
> >                           int val2, enum adxl345_odr *odr)
> >  {
> > @@ -1689,6 +1747,17 @@ static int adxl345_push_event(struct iio_dev *in=
dio_dev, int int_stat,
> >                       return ret;
> >       }
> >
> > +     if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
> > +             ret =3D iio_push_event(indio_dev,
> > +                                  IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > +                                                     IIO_MOD_X_AND_Y_A=
ND_Z,
> > +                                                     IIO_EV_TYPE_MAG,
> > +                                                     IIO_EV_DIR_FALLIN=
G),
> > +                                  ts);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
> >               samples =3D adxl345_get_samples(st);
> >               if (samples < 0)
> > @@ -1763,7 +1832,156 @@ static irqreturn_t adxl345_irq_handler(int irq,=
 void *p)
> >       return IRQ_HANDLED;
> >  }
> >
> > +/* free-fall sysfs */
> > +
> > +static ssize_t in_accel_mag_freefall_en_show(struct device *dev,
> > +                                          struct device_attribute *att=
r,
> > +                                          char *buf)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     bool en;
> > +     int val, ret;
> > +
> > +     ret =3D adxl345_is_ff_en(st, &en);
> > +     if (ret)
> > +             return ret;
> > +
> > +     val =3D en ? 1 : 0;
> > +
> > +     return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> > +}
> > +
> > +static ssize_t in_accel_mag_freefall_en_store(struct device *dev,
> > +                                           struct device_attribute *at=
tr,
> > +                                           const char *buf, size_t len=
)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     int val, ret;
> > +
> > +     ret =3D kstrtoint(buf, 0, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D adxl345_set_measure_en(st, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D adxl345_set_ff_en(st, val > 0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D adxl345_set_measure_en(st, true);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return len;
> > +}
> > +static IIO_DEVICE_ATTR_RW(in_accel_mag_freefall_en, 0);
> > +
> > +static ssize_t in_accel_mag_freefall_value_show(struct device *dev,
> > +                                             struct device_attribute *=
attr,
> > +                                             char *buf)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     unsigned int val;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> > +}
> > +
> > +static ssize_t in_accel_mag_freefall_value_store(struct device *dev,
> > +                                              struct device_attribute =
*attr,
> > +                                              const char *buf, size_t =
len)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     int val, ret;
> > +
> > +     ret =3D kstrtoint(buf, 0, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (val < 0 || val > 255)
> > +             return -EINVAL;
> > +
> > +     ret =3D adxl345_set_measure_en(st, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_write(st->regmap, ADXL345_REG_THRESH_FF, val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D adxl345_set_measure_en(st, true);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return len;
> > +}
> > +static IIO_DEVICE_ATTR_RW(in_accel_mag_freefall_value, 0);
> > +
> > +static ssize_t in_accel_mag_freefall_period_show(struct device *dev,
> > +                                              struct device_attribute =
*attr,
> > +                                              char *buf)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     int vals[2];
> > +
> > +     vals[0] =3D st->ff_time_ms;
> > +     vals[1] =3D 1000;
> > +
> > +     return iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, vals);
> > +}
> > +
> > +static ssize_t in_accel_mag_freefall_period_store(struct device *dev,
> > +                                               struct device_attribute=
 *attr,
> > +                                               const char *buf, size_t=
 len)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     int val_int, val_fract_us, ret;
> > +
> > +     ret =3D iio_str_to_fixpoint(buf, 100000, &val_int, &val_fract_us)=
;
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D adxl345_set_measure_en(st, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D adxl345_set_ff_time(st, val_int, val_fract_us);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D adxl345_set_measure_en(st, true);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return len;
> > +}
> > +static IIO_DEVICE_ATTR_RW(in_accel_mag_freefall_period, 0);
> > +
> > +static struct attribute *adxl345_event_attrs[] =3D {
> > +     &iio_dev_attr_in_accel_mag_freefall_en.dev_attr.attr,
> > +     &iio_dev_attr_in_accel_mag_freefall_value.dev_attr.attr,
> > +     &iio_dev_attr_in_accel_mag_freefall_period.dev_attr.attr,
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group adxl345_event_attrs_group =3D {
> > +     .attrs =3D adxl345_event_attrs,
> > +};
> > +
> >  static const struct iio_info adxl345_info =3D {
> > +     .event_attrs    =3D &adxl345_event_attrs_group,
> >       .read_raw       =3D adxl345_read_raw,
> >       .write_raw      =3D adxl345_write_raw,
> >       .read_avail     =3D adxl345_read_avail,
> > @@ -1806,6 +2024,7 @@ int adxl345_core_probe(struct device *dev, struct=
 regmap *regmap,
> >                                        ADXL345_DATA_FORMAT_FULL_RES |
> >                                        ADXL345_DATA_FORMAT_SELF_TEST);
> >       unsigned int tap_threshold;
> > +     unsigned int ff_threshold;
> >       int ret;
> >
> >       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> > @@ -1825,6 +2044,9 @@ int adxl345_core_probe(struct device *dev, struct=
 regmap *regmap,
> >       st->tap_window_us =3D 64;                 /*   64 [0x40] -> .080 =
   */
> >       st->tap_latent_us =3D 16;                 /*   16 [0x10] -> .020 =
   */
> >
> > +     ff_threshold =3D 8;                       /*    8 [0x08]         =
   */
> > +     st->ff_time_ms =3D 32;                    /*   32 [0x20] -> 0.16 =
   */
> > +
> >       indio_dev->name =3D st->info->name;
> >       indio_dev->info =3D &adxl345_info;
> >       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > @@ -1936,6 +2158,10 @@ int adxl345_core_probe(struct device *dev, struc=
t regmap *regmap,
> >               if (ret)
> >                       return ret;
> >
> > +             ret =3D regmap_write(st->regmap, ADXL345_REG_THRESH_FF, f=
f_threshold);
> > +             if (ret)
> > +                     return ret;
> > +
> >               /* FIFO_STREAM mode is going to be activated later */
> >               ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl=
345_buffer_ops);
> >               if (ret)
>

