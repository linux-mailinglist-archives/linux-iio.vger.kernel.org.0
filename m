Return-Path: <linux-iio+bounces-9259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA9F970046
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 08:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49361F22E15
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 06:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E28131BAF;
	Sat,  7 Sep 2024 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kscSvAXT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C8632C8E
	for <linux-iio@vger.kernel.org>; Sat,  7 Sep 2024 06:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725688939; cv=none; b=mKH1dR/6WxkryrDZcnTVhqzp40rH4Iqk1f8ZAH5tK79FsyDXDwY9Wcdok7szBM8VQSQCkT+eqepD4hesZ1DaJZYAchLwGuAZB0cMZu0ZZ3foQHCpe9B3lgJPzF/B6brz7I6fpI/RgtE8KlmX+wKDXggJPgygGp30Bm7jRgW19hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725688939; c=relaxed/simple;
	bh=gCJQRHFQWzZCSA7ViFOApE9uxWz3pWkpFUh99uxElj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlrzJAbEwJxm1EzLIV3Ablp+SAcyPHqnep0x/n5VV8BJKS41Tx4eDwg8JVPckoKURPwcHQXXG1tLITY+eGBvIh2jhHXRcKMAQbwK0EyEv6CVY+lZPH3XT9rPNoVZzXJv3NEXVaDXG7sB3who+TS2Kgxv7VlJ7VS1NoGe9Aswa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kscSvAXT; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-848769482c9so748350241.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Sep 2024 23:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725688934; x=1726293734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqKxGsSIpyMF5dG/cuFV/eVECnocWhugdJBi+rgl0p4=;
        b=kscSvAXTKkB7mpVKvbsbEcgIsPuS2rR2oLdWH7GWb958irNbcfWtgWCxeC4mneoJ4O
         0o2gpRIQ5FBiZa1FrsBbCds96fOq3wZM2bxI4COYqZhn2D+asyia/rDm8ujGcBtzZiyP
         O12QrMZJ6ND0TLabPTn8teFCtSzrXGmTIcYJ1kE1EPDQ1jHSOCALdRf3FgK5dysQyfMh
         TLKf5SpvgwXisBUjSwsgNvxvTI2O8IqA/cDc8HlMhTQPKB8O3UoLRXYOf76R0CVrlSct
         grTVR7yBQ4aq+Ie2oy8YN+ln+w8vKisKH4cKDZ5mnZq2Mqj+s1MbObJCPnuA4+LOnSfW
         d4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725688934; x=1726293734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqKxGsSIpyMF5dG/cuFV/eVECnocWhugdJBi+rgl0p4=;
        b=d2/jCQz/HDTSoud/jJ8ROiSxWfgWw31U7lUrcGo7Kdy2bU3zRWV3RNTSt83aQwv7xp
         /AnVJr4eqv0DPXMN76TL5kFMPi64J93lp77svCyfVQj0rRdS1WZv10Bz7zdOe9oFKUZ1
         pb3N4fKkXsPgxwtajDjZk0s/ZGBvsOwDJ61d1gZ0UzDl8sJlZA/AxOL3FvzMtePm+W/s
         7RIjgfVw3dYtRj4hCky8GJkd3xI9+7kkAxWY8Of5mjJjPOjxO2fJXGhnZEkiTT4vdbep
         xPqoZv+/a1S2i4szTPOAxzbL575UssrSmL/kVaKrM1eosud+tZ+ikkHBVCrkz4koqeRI
         fOjg==
X-Gm-Message-State: AOJu0Yy/KYgm73q97ChgG/I0AqWI4UVYVcUaca6tPy/KGf2xaLoOxBfL
	Bh5VfIcBLWPLfoKQkX6XQX0jmHyXExmWQnGeK0UidSh9cco80yuEbXN+OnQPoenJZfe3kmUhSTD
	SlhN/wgM8gHLJEdn7O2C2vDjBYImek2ZPqfwZ/A==
X-Google-Smtp-Source: AGHT+IEPAdp7WYkf4jLuapmpOJPEuhABK6EX4tw+ie0hManH4kAr51y6592hBqyIDrbpO7en+iC52u+uE3VLxZl0lPg=
X-Received: by 2002:a05:6102:440b:b0:493:b9ae:3208 with SMTP id
 ada2fe7eead31-49bedcd01b1mr1083738137.24.1725688933703; Fri, 06 Sep 2024
 23:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905082404.119022-1-aardelean@baylibre.com>
 <20240905082404.119022-9-aardelean@baylibre.com> <2bf78e47-909a-45c0-bebb-6a8d38cdef7c@baylibre.com>
 <CA+GgBR9=unTe5WVq0G2zowbL9FnLfCwoAuZp=7VD=xZOt9Gn5w@mail.gmail.com>
In-Reply-To: <CA+GgBR9=unTe5WVq0G2zowbL9FnLfCwoAuZp=7VD=xZOt9Gn5w@mail.gmail.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Sat, 7 Sep 2024 09:02:02 +0300
Message-ID: <CA+GgBR-XuP6_pKpDp=t98utpnBP2i1snaz1fN2S-1yxsE+ouXQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] iio: adc: ad7606: add support for AD7606C-{16,18} parts
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 8:34=E2=80=AFAM Alexandru Ardelean
<aardelean@baylibre.com> wrote:
>
> On Fri, Sep 6, 2024 at 2:30=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
> >
> > On 9/5/24 3:24 AM, Alexandru Ardelean wrote:
> > > The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
> > > The main difference between AD7606C-16 & AD7606C-18 is the precision =
in
> > > bits (16 vs 18).
> > > Because of that, some scales need to be defined for the 18-bit varian=
ts, as
> > > they need to be computed against 2**18 (vs 2**16 for the 16 bit-varia=
nts).
> > >
> > > Because the AD7606C-16,18 also supports bipolar & differential channe=
ls,
> > > for SW-mode, the default range of 10 V or =C2=B110V should be set at =
probe.
> > > On reset, the default range (in the registers) is set to value 0x3 wh=
ich
> > > corresponds to '=C2=B110 V single-ended range', regardless of bipolar=
 or
> > > differential configuration.
> > >
> > > Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B=
.
> > >
> > > The AD7606C-18 variant offers 18-bit precision. Because of this, the
> > > requirement to use this chip is that the SPI controller supports padd=
ing
> > > of 18-bit sequences to 32-bit arrays.
> > >
> > > Datasheet links:
> > >   https://www.analog.com/media/en/technical-documentation/data-sheets=
/ad7606c-16.pdf
> > >   https://www.analog.com/media/en/technical-documentation/data-sheets=
/ad7606c-18.pdf
> > >
> > > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> > > ---
> > >  drivers/iio/adc/ad7606.c     | 266 +++++++++++++++++++++++++++++++--=
--
> > >  drivers/iio/adc/ad7606.h     |  17 ++-
> > >  drivers/iio/adc/ad7606_spi.c |  55 ++++++++
> > >  3 files changed, 309 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > > index 4c3fbb28f790..999c4411859e 100644
> > > --- a/drivers/iio/adc/ad7606.c
> > > +++ b/drivers/iio/adc/ad7606.c
> > > @@ -28,14 +28,44 @@
> > >
> > >  #include "ad7606.h"
> > >
> > > +typedef void (*ad7606c_chan_setup_cb_t)(struct ad7606_state *st, int=
 ch,
> > > +                                     bool bipolar, bool differential=
);
> > > +
> > >  /*
> > >   * Scales are computed as 5000/32768 and 10000/32768 respectively,
> > >   * so that when applied to the raw values they provide mV values
> > >   */
> > > -static const unsigned int ad7606_scale_avail[2] =3D {
> > > +static const unsigned int ad7606_16bit_hw_scale_avail[2] =3D {
> > >       152588, 305176
> > >  };
> > >
> > > +static const unsigned int ad7606_18bit_hw_scale_avail[2] =3D {
> > > +     38147, 76294
> > > +};
> > > +
> > > +static const unsigned int ad7606c_16_scale_single_ended_unipolar_ava=
il[3] =3D {
> > > +     76294, 152588, 190735,
> > > +};
> > > +
> > > +static const unsigned int ad7606c_16_scale_single_ended_bipolar_avai=
l[5] =3D {
> > > +     76294, 152588, 190735, 305176, 381470
> > > +};
> > > +
> > > +static const unsigned int ad7606c_16_scale_differential_bipolar_avai=
l[4] =3D {
> > > +     152588, 305176, 381470, 610352
> > > +};
> > > +
> > > +static const unsigned int ad7606c_18_scale_single_ended_unipolar_ava=
il[3] =3D {
> > > +     19073, 38147, 47684
> > > +};
> > > +
> > > +static const unsigned int ad7606c_18_scale_single_ended_bipolar_avai=
l[5] =3D {
> > > +     19073, 38147, 47684, 76294, 95367
> > > +};
> > > +
> > > +static const unsigned int ad7606c_18_scale_differential_bipolar_avai=
l[4] =3D {
> > > +     38147, 76294, 95367, 152588
> > > +};
> > >
> > >  static const unsigned int ad7616_sw_scale_avail[3] =3D {
> > >       76293, 152588, 305176
> > > @@ -82,11 +112,19 @@ static int ad7606_reg_access(struct iio_dev *ind=
io_dev,
> > >       }
> > >  }
> > >
> > > -static int ad7606_read_samples(struct ad7606_state *st)
> > > +static int ad7606_read_samples(struct ad7606_state *st, bool sign_ex=
tend_samples)
> > >  {
> > > +     unsigned int storagebits =3D st->chip_info->channels[1].scan_ty=
pe.storagebits;
> >
> > Why [1]? Sure, they are all the same, but [0] would seem less arbitrary=
.
>
> [0] is the timestamp channel.
>
>
> >
> > >       unsigned int num =3D st->chip_info->num_channels - 1;
> > > -     u16 *data =3D st->data;
> > > -     int ret;
> > > +     u32 *data32 =3D st->data.d32;
> > > +     u16 *data16 =3D st->data.d16;
> > > +     void *data;
> > > +     int i, ret;
> > > +
> > > +     if (storagebits > 16)
> > > +             data =3D data32;
> > > +     else
> > > +             data =3D data16;
> > >
> > >       /*
> > >        * The frstdata signal is set to high while and after reading t=
he sample
> > > @@ -108,11 +146,25 @@ static int ad7606_read_samples(struct ad7606_st=
ate *st)
> > >                       return -EIO;
> > >               }
> > >
> > > -             data++;
> > > +             if (storagebits > 16)
> > > +                     data32++;
> > > +             else
> > > +                     data16++;
> > >               num--;
> > >       }
> > >
> > > -     return st->bops->read_block(st->dev, num, data);
> > > +     ret =3D st->bops->read_block(st->dev, num, data);
> >
> > Since data++ was removed, this looks broken now as well as the
> > other read_block() not visible in the diff.
> >
> > Maybe better to drop data32 and data16, keep the change of data
> > to void*, and change data++ to data +=3D BITS_TO_BYTES(storagebits)?
> >
> > Although, all of this might be moot since it looks like this
> > needs to be rebased on [1].
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/comm=
it/?h=3Dfixes-togreg&id=3D90826e08468ba7fb35d8b39645b22d9e80004afe
>
> Oh.
> Omitted that patch.
> I forgot that fixes-togreg has a different cadence in another branch.
>
> >
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (storagebits =3D=3D 16 || !sign_extend_samples)
> > > +             return 0;
> > > +
> > > +     /* For 18 bit samples, we need to sign-extend samples to 32 bit=
s */
> > > +     for (i =3D 0; i < num; i++)
> > > +             data32[i] =3D sign_extend32(data32[i], 17);> +
> > > +     return 0;
> > >  }
> > >
> > >  static irqreturn_t ad7606_trigger_handler(int irq, void *p)
> > > @@ -124,11 +176,11 @@ static irqreturn_t ad7606_trigger_handler(int i=
rq, void *p)
> > >
> > >       guard(mutex)(&st->lock);
> > >
> > > -     ret =3D ad7606_read_samples(st);
> > > +     ret =3D ad7606_read_samples(st, true);
> >
> > Shouldn't the sign_extend parameter depend on if the data is unipolar o=
r bipolar?
>
> [c1]
> Sign-extension is only needed for 18-bit samples.
> 16-bit samples are already properly sign(ed), but to 16-bits.
>
> It's a slight performance improvement, that may look quirky here.
> The idea here, is that for ad7606_scan_direct() we only need to
> sign-extend 1 sample of the 8 samples we get.
> And we need to sign-extend it to 32 bits regardless of it being 16-bit
> or 18-bit.
>
> In ad7606_trigger_handler(), the 16-bit samples were pushed as-is.
> Which means that we need to sign-extend the samples at least for
> 18-bits (as it is a new part)
> The question now becomes if we should sign-extend to 32-bits, 16-bit
> samples in ad7606_trigger_handler(), as that may break some ABI.
>
> >
> > >       if (ret)
> > >               goto error_ret;
> > >
> > > -     iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> > > +     iio_push_to_buffers_with_timestamp(indio_dev, st->data.d16,
> > >                                          iio_get_time_ns(indio_dev));
> > >  error_ret:
> > >       iio_trigger_notify_done(indio_dev->trig);
> > > @@ -142,6 +194,7 @@ static int ad7606_scan_direct(struct iio_dev *ind=
io_dev, unsigned int ch,
> > >                             int *val)
> > >  {
> > >       struct ad7606_state *st =3D iio_priv(indio_dev);
> > > +     unsigned int storagebits =3D st->chip_info->channels[1].scan_ty=
pe.storagebits;
> > >       int ret;
> > >
> > >       gpiod_set_value(st->gpio_convst, 1);
> > > @@ -152,9 +205,13 @@ static int ad7606_scan_direct(struct iio_dev *in=
dio_dev, unsigned int ch,
> > >               goto error_ret;
> > >       }
> > >
> > > -     ret =3D ad7606_read_samples(st);
> > > -     if (ret =3D=3D 0)
> > > -             *val =3D sign_extend32(st->data[ch], 15);
> > > +     ret =3D ad7606_read_samples(st, false);
> >
> > Why not let ad7606_read_samples() do the sign extending since
> > it can do that now?
>
> Related to comment [c1]
>
> >
> > > +     if (ret =3D=3D 0) {
> > > +             if (storagebits > 16)
> > > +                     *val =3D sign_extend32(st->data.d32[ch], 17);
> > > +             else
> > > +                     *val =3D sign_extend32(st->data.d16[ch], 15);
> > > +     }
> > >
> > >  error_ret:
> > >       gpiod_set_value(st->gpio_convst, 0);
> > > @@ -267,7 +324,7 @@ static int ad7606_write_raw(struct iio_dev *indio=
_dev,
> > >                       ch =3D chan->address;
> > >               cs =3D &st->chan_scales[ch];
> > >               i =3D find_closest(val2, cs->scale_avail, cs->num_scale=
s);
> > > -             ret =3D st->write_scale(indio_dev, ch, i);
> > > +             ret =3D st->write_scale(indio_dev, ch, i + cs->reg_offs=
et);
> > >               if (ret < 0)
> > >                       return ret;
> > >               cs->range =3D i;
> > > @@ -350,6 +407,18 @@ static const struct iio_chan_spec ad7606_channel=
s_16bit[] =3D {
> > >       AD7606_CHANNEL(7, 16),
> > >  };
> > >
> > > +static const struct iio_chan_spec ad7606_channels_18bit[] =3D {
> > > +     IIO_CHAN_SOFT_TIMESTAMP(8),
> > > +     AD7606_CHANNEL(0, 18),
> > > +     AD7606_CHANNEL(1, 18),
> > > +     AD7606_CHANNEL(2, 18),
> > > +     AD7606_CHANNEL(3, 18),
> > > +     AD7606_CHANNEL(4, 18),
> > > +     AD7606_CHANNEL(5, 18),
> > > +     AD7606_CHANNEL(6, 18),
> > > +     AD7606_CHANNEL(7, 18),
> > > +};
> > > +
> > >  /*
> > >   * The current assumption that this driver makes for AD7616, is that=
 it's
> > >   * working in Hardware Mode with Serial, Burst and Sequencer modes a=
ctivated.
> > > @@ -410,6 +479,18 @@ static const struct ad7606_chip_info ad7606_chip=
_info_tbl[] =3D {
> > >               .oversampling_avail =3D ad7606_oversampling_avail,
> > >               .oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_av=
ail),
> > >       },
> > > +     [ID_AD7606C_16] =3D {
> > > +             .channels =3D ad7606_channels_16bit,
> > > +             .num_channels =3D 9,
> >
> > Could be nice to have a cleanup patch before this to convert others to
> > use ARRAY_SIZE(), then use ARRAY_SIZE(ad7606_channels_16bit) here
> > instead of 9.
>
> Ack.

I'll need to revert this to a NACK.

"ad7606_channels{_16bit}" has 9 elements.
But for some ADC variants, only 7 are used.
So, num_channels is specified as 7 there, and references this same array.
Which also explains why the timestamp channel is the first.

>
> >
> > > +             .oversampling_avail =3D ad7606_oversampling_avail,
> > > +             .oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_av=
ail),
> > > +     },
> > > +     [ID_AD7606C_18] =3D {
> > > +             .channels =3D ad7606_channels_18bit,
> > > +             .num_channels =3D 9,

Continuing here: I could make it ARRAY_SIZE(ad7606_channels_18bit),
but that would make it less consistent with the other "num_channels"
styles.
And maybe there will be a 4 or 6 channel 18 bit part later.

> > > +             .oversampling_avail =3D ad7606_oversampling_avail,
> > > +             .oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_av=
ail),
> > > +     },
> > >       [ID_AD7616] =3D {
> > >               .channels =3D ad7616_channels,
> > >               .num_channels =3D 17,
> > > @@ -581,7 +662,122 @@ static const struct iio_trigger_ops ad7606_trig=
ger_ops =3D {
> > >       .validate_device =3D iio_trigger_validate_own_device,
> > >  };
> > >
> > > -static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
> > > +static void ad7606c_18_chan_setup(struct ad7606_state *st, int ch,
> > > +                               bool bipolar, bool differential)
> > > +{
> > > +     struct ad7606_chan_scale *cs =3D &st->chan_scales[ch];
> > > +
> > > +     if (differential) {
> > > +             cs->scale_avail =3D
> > > +                     ad7606c_18_scale_differential_bipolar_avail;
> > > +             cs->num_scales =3D
> > > +                     ARRAY_SIZE(ad7606c_18_scale_differential_bipola=
r_avail);
> > > +             /* Bipolar differential ranges start at 8 (b1000) */
> > > +             cs->reg_offset =3D 8;
> > > +             cs->range =3D 1;
> > > +     } else if (bipolar) {
> > > +             cs->scale_avail =3D
> > > +                     ad7606c_18_scale_single_ended_bipolar_avail;
> > > +             cs->num_scales =3D
> > > +                     ARRAY_SIZE(ad7606c_18_scale_single_ended_bipola=
r_avail);
> >
> > I guess cs->reg_offset is 0 for this one?
>
> Yes.
> I will make it explicit.
>
> >
> > > +             cs->range =3D 3;
> > > +     } else {
> > > +             cs->scale_avail =3D
> > > +                     ad7606c_18_scale_single_ended_unipolar_avail;
> > > +             cs->num_scales =3D
> > > +                     ARRAY_SIZE(ad7606c_18_scale_single_ended_unipol=
ar_avail);
> > > +             /* Unipolar single-ended ranges start at 5 (b0101) */
> > > +             cs->reg_offset =3D 5;
> > > +             cs->range =3D 1;
> > > +     }
> > > +}
> > > +
> > > +static void ad7606c_16_chan_setup(struct ad7606_state *st, int ch,
> > > +                               bool bipolar, bool differential)
> > > +{
> > > +     struct ad7606_chan_scale *cs =3D &st->chan_scales[ch];
> > > +
> > > +     if (differential) {
> > > +             cs->scale_avail =3D
> > > +                     ad7606c_16_scale_differential_bipolar_avail;
> > > +             cs->num_scales =3D
> > > +                     ARRAY_SIZE(ad7606c_16_scale_differential_bipola=
r_avail);
> > > +             /* Bipolar differential ranges start at 8 (b1000) */
> > > +             cs->reg_offset =3D 8;
> > > +             cs->range =3D 1;
> > > +     } else if (bipolar) {
> > > +             cs->scale_avail =3D
> > > +                     ad7606c_16_scale_single_ended_bipolar_avail;
> > > +             cs->num_scales =3D
> > > +                     ARRAY_SIZE(ad7606c_16_scale_single_ended_bipola=
r_avail);
> > > +             cs->range =3D 3;
> > > +     } else {
> > > +             cs->scale_avail =3D
> > > +                     ad7606c_16_scale_single_ended_unipolar_avail;
> > > +             cs->num_scales =3D
> > > +                     ARRAY_SIZE(ad7606c_16_scale_single_ended_unipol=
ar_avail);
> > > +             /* Unipolar single-ended ranges start at 5 (b0101) */
> > > +             cs->reg_offset =3D 5;
> > > +             cs->range =3D 1;
> > > +     }
> > > +}
> > > +
> > > +static int ad7606c_sw_mode_setup_channels(struct iio_dev *indio_dev,
> > > +                                       ad7606c_chan_setup_cb_t chan_=
setup_cb)
> > > +{
> > > +     unsigned int num_channels =3D indio_dev->num_channels - 1;
> > > +     struct ad7606_state *st =3D iio_priv(indio_dev);
> > > +     bool chan_configured[AD760X_MAX_CHANNELS] =3D {};
> > > +     struct device *dev =3D st->dev;
> > > +     int ret;
> > > +     u32 ch;
> > > +
> > > +     /* We need to hook this first */
> >
> > Comment would be more useful if it said why.
>
> Ack.
> Will add.
>
> >
> > > +     ret =3D st->bops->sw_mode_config(indio_dev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     device_for_each_child_node_scoped(dev, child) {
> > > +             bool bipolar, differential;
> > > +             u32 pins[2];
> > > +
> > > +             ret =3D fwnode_property_read_u32(child, "reg", &ch);
> > > +             if (ret)
> > > +                     continue;
> > > +
> > > +             /* channel number (here) is from 1 to num_channels */
> > > +             if (ch =3D=3D 0 || ch > num_channels) {
> > > +                     dev_warn(st->dev,
> > > +                              "Invalid channel number (ignoring): %d=
\n", ch);
> > > +                     continue;
> > > +             }
> > > +
> > > +             bipolar =3D fwnode_property_present(child, "bipolar");
> >
> > IIRC, fwnode_property_read_bool() is preferred for bool/flag properties=
.
>
> Ack.
>
> >
> > > +
> > > +             ret =3D fwnode_property_read_u32_array(child, "diff-cha=
nnels",
> > > +                                                  pins, ARRAY_SIZE(p=
ins));
> > > +             /* Channel is differential, if pins are the same as 're=
g' */
> > > +             if (ret =3D=3D 0 && pins[0] =3D=3D ch && pins[1] =3D=3D=
 ch)
> > > +                     differential =3D true;
> > > +             else
> > > +                     differential =3D false;
> >
> > Would probably better to error on bad pin numbers rather than default t=
o
> > not differential.
>
> No strong preference from my side.
> Will implement failure/error case.
>
> >
> > > +
> > > +             ch--;
> > > +
> > > +             chan_setup_cb(st, ch, bipolar, differential);
> > > +             chan_configured[ch] =3D true;
> > > +     }
> > > +
> > > +     /* Apply default configuration to unconfigured (via DT) channel=
s */
> > > +     for (ch =3D 0; ch < num_channels; ch++) {
> > > +             if (!chan_configured[ch])
> > > +                     chan_setup_cb(st, ch, false, false);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int ad7606_sw_mode_setup(struct iio_dev *indio_dev, unsigned =
int id)
> > >  {
> > >       unsigned int num_channels =3D indio_dev->num_channels - 1;
> > >       struct ad7606_state *st =3D iio_priv(indio_dev);
> > > @@ -596,17 +792,30 @@ static int ad7606_sw_mode_setup(struct iio_dev =
*indio_dev)
> > >
> > >       indio_dev->info =3D &ad7606_info_sw_mode;
> > >
> > > -     /* Scale of 0.076293 is only available in sw mode */
> > > -     /* After reset, in software mode, =C2=B110 V is set by default =
*/
> > > -     for (ch =3D 0; ch < num_channels; ch++) {
> > > -             struct ad7606_chan_scale *cs =3D &st->chan_scales[ch];
> > > +     switch (id) {
> > > +     case ID_AD7606C_18:
> > > +             ret =3D ad7606c_sw_mode_setup_channels(indio_dev,
> > > +                                                  ad7606c_18_chan_se=
tup);
> > > +             break;
> > > +     case ID_AD7606C_16:
> > > +             ret =3D ad7606c_sw_mode_setup_channels(indio_dev,
> > > +                                                  ad7606c_16_chan_se=
tup);
> > > +             break;
> > > +     default:
> > > +             /* Scale of 0.076293 is only available in sw mode */
> > > +             /* After reset, in software mode, =C2=B110 V is set by =
default */
> > > +             for (ch =3D 0; ch < num_channels; ch++) {
> > > +                     struct ad7606_chan_scale *cs =3D &st->chan_scal=
es[ch];
> > > +
> > > +                     cs->scale_avail =3D ad7616_sw_scale_avail;
> > > +                     cs->num_scales =3D ARRAY_SIZE(ad7616_sw_scale_a=
vail);
> > > +                     cs->range =3D 2;
> > > +             }
> > >
> > > -             cs->scale_avail =3D ad7616_sw_scale_avail;
> > > -             cs->num_scales =3D ARRAY_SIZE(ad7616_sw_scale_avail);
> > > -             cs->range =3D 2;
> > > +             ret =3D st->bops->sw_mode_config(indio_dev);
> > > +             break;
> > >       }
> > >
> > > -     ret =3D st->bops->sw_mode_config(indio_dev);
> > >       if (ret)
> > >               return ret;
> > >
> > > @@ -655,9 +864,16 @@ int ad7606_probe(struct device *dev, int irq, vo=
id __iomem *base_address,
> > >       st->oversampling =3D 1;
> > >
> > >       cs =3D &st->chan_scales[0];
> > > -     cs->range =3D 0;
> > > -     cs->scale_avail =3D ad7606_scale_avail;
> > > -     cs->num_scales =3D ARRAY_SIZE(ad7606_scale_avail);
> > > +     switch (id) {
> > > +     case ID_AD7606C_18:
> > > +             cs->scale_avail =3D ad7606_18bit_hw_scale_avail;
> > > +             cs->num_scales =3D ARRAY_SIZE(ad7606_18bit_hw_scale_ava=
il);
> > > +             break;
> > > +     default:
> > > +             cs->scale_avail =3D ad7606_16bit_hw_scale_avail;
> > > +             cs->num_scales =3D ARRAY_SIZE(ad7606_16bit_hw_scale_ava=
il);
> > > +             break;
> > > +     }
> > >
> > >       ret =3D devm_regulator_get_enable(dev, "avcc");
> > >       if (ret)
> > > @@ -706,7 +922,7 @@ int ad7606_probe(struct device *dev, int irq, voi=
d __iomem *base_address,
> > >       st->write_scale =3D ad7606_write_scale_hw;
> > >       st->write_os =3D ad7606_write_os_hw;
> > >
> > > -     ret =3D ad7606_sw_mode_setup(indio_dev);
> > > +     ret =3D ad7606_sw_mode_setup(indio_dev, id);
> > >       if (ret)
> > >               return ret;
> > >
> > > diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> > > index 2113ad460c0f..6b0897aa2dc7 100644
> > > --- a/drivers/iio/adc/ad7606.h
> > > +++ b/drivers/iio/adc/ad7606.h
> > > @@ -22,7 +22,7 @@
> > >               .scan_type =3D {                                  \
> > >                       .sign =3D 's',                            \
> > >                       .realbits =3D (bits),                     \
> > > -                     .storagebits =3D (bits),                  \
> > > +                     .storagebits =3D (bits) > 16 ? 32 : 16,   \
> > >                       .endianness =3D IIO_CPU,                  \
> > >               },                                              \
> > >  }
> > > @@ -45,7 +45,7 @@
> > >               .scan_type =3D {                                  \
> > >                       .sign =3D 's',                            \
> > >                       .realbits =3D (bits),                     \
> > > -                     .storagebits =3D (bits),                  \
> > > +                     .storagebits =3D (bits) > 16 ? 32 : 16,   \
> > >                       .endianness =3D IIO_CPU,                  \
> > >               },                                              \
> > >  }
> > > @@ -88,6 +88,8 @@ struct ad7606_chip_info {
> > >   *                   such that it can be read via the 'read_avail' h=
ook
> > >   * @num_scales               number of elements stored in the scale_=
avail array
> > >   * @range            voltage range selection, selects which scale to=
 apply
> > > + * @reg_offset               offset for the register value, to be ap=
plied when
> > > + *                   writing the value of 'range' to the register va=
lue
> > >   */
> > >  struct ad7606_chan_scale {
> > >  #define AD760X_MAX_SCALE_SHOW                (AD760X_MAX_CHANNELS * =
2)
> > > @@ -95,6 +97,7 @@ struct ad7606_chan_scale {
> > >       int                             scale_avail_show[AD760X_MAX_SCA=
LE_SHOW];
> > >       unsigned int                    num_scales;
> > >       unsigned int                    range;
> > > +     unsigned int                    reg_offset;
> > >  };
> > >
> > >  /**
> > > @@ -151,9 +154,13 @@ struct ad7606_state {
> > >       /*
> > >        * DMA (thus cache coherency maintenance) may require the
> > >        * transfer buffers to live in their own cache lines.
> > > -      * 16 * 16-bit samples + 64-bit timestamp
> > > +      * 16 * 16-bit samples + 64-bit timestamp - for AD7616
> > > +      * 8 * 32-bit samples + 64-bit timestamp - for AD7616C-18 (and =
similar)
> > >        */
> > > -     unsigned short                  data[20] __aligned(IIO_DMA_MINA=
LIGN);
> > > +     union {
> > > +             unsigned short d16[20];
> > > +             unsigned int d32[10];
> > > +     } data __aligned(IIO_DMA_MINALIGN);
> > >       __be16                          d16[2];
> > >  };
> > >
> > > @@ -192,6 +199,8 @@ enum ad7606_supported_device_ids {
> > >       ID_AD7606_6,
> > >       ID_AD7606_4,
> > >       ID_AD7606B,
> > > +     ID_AD7606C_16,
> > > +     ID_AD7606C_18,
> > >       ID_AD7616,
> > >  };
> > >
> > > diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_sp=
i.c
> > > index e00f58a6a0e9..b8d630ad156d 100644
> > > --- a/drivers/iio/adc/ad7606_spi.c
> > > +++ b/drivers/iio/adc/ad7606_spi.c
> > > @@ -77,6 +77,18 @@ static const struct iio_chan_spec ad7606b_sw_chann=
els[] =3D {
> > >       AD7606_SW_CHANNEL(7, 16),
> > >  };
> > >
> > > +static const struct iio_chan_spec ad7606c_18_sw_channels[] =3D {
> > > +     IIO_CHAN_SOFT_TIMESTAMP(8),
> > > +     AD7606_SW_CHANNEL(0, 18),
> > > +     AD7606_SW_CHANNEL(1, 18),
> > > +     AD7606_SW_CHANNEL(2, 18),
> > > +     AD7606_SW_CHANNEL(3, 18),
> > > +     AD7606_SW_CHANNEL(4, 18),
> > > +     AD7606_SW_CHANNEL(5, 18),
> > > +     AD7606_SW_CHANNEL(6, 18),
> > > +     AD7606_SW_CHANNEL(7, 18),
> > > +};
> > > +
> > >  static const unsigned int ad7606B_oversampling_avail[9] =3D {
> > >       1, 2, 4, 8, 16, 32, 64, 128, 256
> > >  };
> > > @@ -120,6 +132,19 @@ static int ad7606_spi_read_block(struct device *=
dev,
> > >       return 0;
> > >  }
> > >
> > > +static int ad7606_spi_read_block18to32(struct device *dev,
> > > +                                    int count, void *buf)
> > > +{
> > > +     struct spi_device *spi =3D to_spi_device(dev);
> > > +     struct spi_transfer xfer =3D {
> > > +             .bits_per_word =3D 18,
> > > +             .len =3D count,
> >
> > Isn't count the number of words? .len needs to be the number
> > of bytes, so 4 * count.
>
> Oh.
> Hmm, I need to check.
> I assumed .len is the count of elements, not of bytes.
>
> >
> > > +             .rx_buf =3D buf,
> > > +     };
> > > +
> > > +     return spi_sync_transfer(spi, &xfer, 1);
> > > +}
> > > +
> > >  static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int=
 addr)
> > >  {
> > >       struct spi_device *spi =3D to_spi_device(st->dev);
> > > @@ -283,6 +308,19 @@ static int ad7606B_sw_mode_config(struct iio_dev=
 *indio_dev)
> > >       return 0;
> > >  }
> > >
> > > +static int ad7606c_18_sw_mode_config(struct iio_dev *indio_dev)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret =3D ad7606B_sw_mode_config(indio_dev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     indio_dev->channels =3D ad7606c_18_sw_channels;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static const struct ad7606_bus_ops ad7606_spi_bops =3D {
> > >       .read_block =3D ad7606_spi_read_block,
> > >  };
> > > @@ -305,6 +343,15 @@ static const struct ad7606_bus_ops ad7606B_spi_b=
ops =3D {
> > >       .sw_mode_config =3D ad7606B_sw_mode_config,
> > >  };
> > >
> > > +static const struct ad7606_bus_ops ad7606c_18_spi_bops =3D {
> > > +     .read_block =3D ad7606_spi_read_block18to32,
> > > +     .reg_read =3D ad7606_spi_reg_read,
> > > +     .reg_write =3D ad7606_spi_reg_write,
> > > +     .write_mask =3D ad7606_spi_write_mask,
> > > +     .rd_wr_cmd =3D ad7606B_spi_rd_wr_cmd,
> > > +     .sw_mode_config =3D ad7606c_18_sw_mode_config,
> > > +};
> > > +
> > >  static int ad7606_spi_probe(struct spi_device *spi)
> > >  {
> > >       const struct spi_device_id *id =3D spi_get_device_id(spi);
> > > @@ -315,8 +362,12 @@ static int ad7606_spi_probe(struct spi_device *s=
pi)
> > >               bops =3D &ad7616_spi_bops;
> > >               break;
> > >       case ID_AD7606B:
> > > +     case ID_AD7606C_16:
> > >               bops =3D &ad7606B_spi_bops;
> > >               break;
> > > +     case ID_AD7606C_18:
> > > +             bops =3D &ad7606c_18_spi_bops;
> > > +             break;
> > >       default:
> > >               bops =3D &ad7606_spi_bops;
> > >               break;
> > > @@ -333,6 +384,8 @@ static const struct spi_device_id ad7606_id_table=
[] =3D {
> > >       { "ad7606-6", ID_AD7606_6 },
> > >       { "ad7606-8", ID_AD7606_8 },
> > >       { "ad7606b",  ID_AD7606B },
> > > +     { "ad7606c-16",  ID_AD7606C_16 },
> > > +     { "ad7606c-18",  ID_AD7606C_18 },
> > >       { "ad7616",   ID_AD7616 },
> > >       { }
> > >  };
> > > @@ -344,6 +397,8 @@ static const struct of_device_id ad7606_of_match[=
] =3D {
> > >       { .compatible =3D "adi,ad7606-6" },
> > >       { .compatible =3D "adi,ad7606-8" },
> > >       { .compatible =3D "adi,ad7606b" },
> > > +     { .compatible =3D "adi,ad7606c-16" },
> > > +     { .compatible =3D "adi,ad7606c-18" },
> > >       { .compatible =3D "adi,ad7616" },
> > >       { }
> > >  };
> >

