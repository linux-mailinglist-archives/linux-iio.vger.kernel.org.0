Return-Path: <linux-iio+bounces-7938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF9A93D391
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 14:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318EB1F23D1B
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BA117BB19;
	Fri, 26 Jul 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKjjDiNQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F3917B511;
	Fri, 26 Jul 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998531; cv=none; b=mk/w8LNLRaPXkf0VF790mPuDxAA5nxJobLCmz/hs7NNmDGZUaqRQU8+fFlRIC1QSuesOhOK+x2sAaO2QAEy0/hlaDGWfgJxgnzlScHoz1qY33jlqMV2L8IGnAajT3lAEv+68Cssh/b08/1aVohsDj31B5/g9LD+diuewf3ynsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998531; c=relaxed/simple;
	bh=LHCzqSXWzph1gwZ2es/1LUEFrpamFL6O1ZRKAKn8/cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4ufoQwO/C4/VOgjrZqB+CRFBsn/riPASBWea+62y/L2kNwMCXXborBsPRspFe8z/wgna6K2XWj2XLM/4e/wbKIq5Q3Q56YOaNY3DId5Zirq+PnAwbpvCZWwnmJ+74gFcxxKuYa8Av6XFgzlRNSJbM+GWowU4/8iED9QlUL/dwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKjjDiNQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f01993090so1841642e87.2;
        Fri, 26 Jul 2024 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721998527; x=1722603327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VgcYP0mvzLXqK0mAr76XmwDrqyZOFzNL0pvF4cRfTo=;
        b=kKjjDiNQc0Q0H0x/GP48iwlf0Iv5RvpTsyhxL+dnL3TMP9CJfPPe0Va1QtikbzB0zt
         QMSqpq5K66L8R8+pXecxdAAd9AWRvFjrlcxw8gdkHPdOPJ0HLZbF6cFimK+eDK1l4vtN
         tuArveq5cvHTzofwWimtdq8VPfCmfUGAcvj4y1Gd5gQL5QZx41HcOqToWRl12iuI3dEm
         0M9jIKOj0YkdRhrT11aA1szWRADEUkn1VQFXaNXQH4121qBj8L6fwh1GxcrrFEG0dA3R
         oQLWoFMKn15Nc8818P0S2RjeGnu2e9OtgotKoKWiiXT0Po4vnhjHj0bHzRbbocQCc72J
         YavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721998527; x=1722603327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VgcYP0mvzLXqK0mAr76XmwDrqyZOFzNL0pvF4cRfTo=;
        b=jFWBxn0o2jtRjCWH0BZl10Nh8LlASdW/v6QDQzRDnNZEN0XkoQO0yP7fZHt1ATva06
         A182bIslFwo348oZFAFRENQMUOpn93tPn8ED7d1/ZF3TqqMSOQ09MEwP8ojATeaSYS+9
         CNtDyxcIe8GRXlChx/EyYgG48InThkG6cQlpKr69Vo3470DVsiO7y9MdpYovXeKu82x8
         /D/ChnEyOZawdjwgX6K6hxu6EU4EePXxR/7E3Faj7ReqGYD2KOBRjCWamvDFv0BtwohQ
         Ng3Igxs5WZYIW9v+yr/tZRuUBbwTy4VcmgCgvEJBEEjRAyRy/t+gUM3eo65WFYGw/oD5
         nrnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU337rYl0wyy+oHrsFQ9RpMvzo2SzPo9Z/sYIvynBvWioLp7VAPGHNOfnwpPYlfgUvW96uqLd/cwp9ODlrp0yXu85xHzyeTQXavleNeX9uAa8hj+PNHLVkjTVz426J3fBElLmN4h0Ft
X-Gm-Message-State: AOJu0YxV3ICtSMb6ZqxUrWtGYd19ZN2x8Ipoj3S1I9PriYIF3WzUM3de
	vFaRQF1xpTlJk7/ZD+SF3HDxS1tENBJX6hxhtF2miU5cLI2NXWjSglmClLL43fJpKN1qPJU8t+9
	mOInVo6UqSW9/RqQW8rep8Zx+ij4=
X-Google-Smtp-Source: AGHT+IG+AkFqiJIFxaai1NyQzunmBgGC4rWZdzKjNWHB2zFDgZK1oCaANo21NzbRb0wDQnK3wS+VhHjEPrUOlzneDmM=
X-Received: by 2002:a05:6512:158b:b0:52c:df9d:7cbe with SMTP id
 2adb3069b0e04-52fd6084327mr3098543e87.39.1721998526541; Fri, 26 Jul 2024
 05:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718104947.7384-1-abhashkumarjha123@gmail.com> <20240720165554.5fd16ca0@jic23-huawei>
In-Reply-To: <20240720165554.5fd16ca0@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Fri, 26 Jul 2024 18:25:14 +0530
Message-ID: <CAG=0RqL1GxCKdzDzUjqECEsfQmunCwnv+g_5cqM1fcfBsg+P0w@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add configurable gain, resolution and
 ALS reading
To: Jonathan Cameron <jic23@kernel.org>
Cc: anshulusr@gmail.com, linux-iio@vger.kernel.org, lars@metafoo.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 9:26=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 18 Jul 2024 16:19:45 +0530
> Abhash Jha <abhashkumarjha123@gmail.com> wrote:
>
> >  1) Add support for configuring the gain and resolution(integration tim=
e)
> >     for the sensor.
> >  2) Add a channel for ALS and provide support for reading the raw and
> >     scale values.
> >  3) Add automatic mode switching between UVS and ALS based on the
> >     channel type.
> >  4) Calculate 'counts_per_uvi' based on the current gain and integratio=
n
> >     time.
>
> Hi Abhash,
>
> When a patch lists more than one thing, key thing to think is
> "maybe this should be multiple patches?"
>
> Here at very least separate resolution / gain into one or two patches
> and the new channel support into another.
> Probably yet another patch for point 4,
>
> Various other comments inline.
>
> Jonathan
>
> >
> > Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
> > ---
> >  drivers/iio/light/ltr390.c | 256 ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 238 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> > index fff1e8990..56f3c74ae 100644
> > --- a/drivers/iio/light/ltr390.c
> > +++ b/drivers/iio/light/ltr390.c
> > @@ -25,19 +25,33 @@
> >  #include <linux/regmap.h>
> >
> >  #include <linux/iio/iio.h>
> > -
> > +#include <linux/iio/sysfs.h>
>
> >  #include <asm/unaligned.h>
> >
> >  #define LTR390_MAIN_CTRL      0x00
> >  #define LTR390_PART_ID             0x06
> >  #define LTR390_UVS_DATA            0x10
> >
> > +#define LTR390_ALS_DATA       0x0D
> > +#define LTR390_ALS_UVS_GAIN   0x05
> > +#define LTR390_ALS_UVS_MEAS_RATE 0x04
> > +#define LTR390_INT_CFG           0x19
> If these are register addresses put them in numeric order so
> it is easy to compare with a datasheet table
>
> > +
> >  #define LTR390_SW_RESET            BIT(4)
> >  #define LTR390_UVS_MODE            BIT(3)
> >  #define LTR390_SENSOR_ENABLE  BIT(1)
> >
> >  #define LTR390_PART_NUMBER_ID 0xb
> >
> > +#define LTR390_ALS_UVS_GAIN_MASK 0x07
> > +#define LTR390_ALS_UVS_INT_TIME_MASK 0x70
> > +#define LTR390_ALS_UVS_INT_TIME_MASK_SHIFT 4
>
> Used FIELD_GET() and FIELD_PREP() then you never
> need a separate SHIFT defintion.
>
> > +
> > +#define LTR390_SET_ALS_MODE 1
> > +#define LTR390_SET_UVS_MODE 2
>
> If these are being use to pick options and not writen to hw
> use an enum.  I don't think we care what value they take.
>
>
> > +
> > +#define LTR390_FRACTIONAL_PRECISION 100
> > +
> >  /*
> >   * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 c=
ounts of
> >   * the sensor are equal to 1 UV Index [Datasheet Page#8].
> > @@ -60,6 +74,9 @@ struct ltr390_data {
> >       struct i2c_client *client;
> >       /* Protects device from simulataneous reads */
> >       struct mutex lock;
> > +     int mode;
> > +     int gain;
> > +     int int_time_us;
> >  };
> >
> >  static const struct regmap_config ltr390_regmap_config =3D {
> > @@ -87,36 +104,232 @@ static int ltr390_register_read(struct ltr390_dat=
a *data, u8 register_address)
> >       return get_unaligned_le24(recieve_buffer);
> >  }
> >
> > +
> one blank line is neough.
>
> > +static int ltr390_set_mode(struct ltr390_data *data, int mode)
> As suggested above, use an enum for mode. Give than a type name and you
> can use that here.
>
> > +{
> > +     if (data->mode =3D=3D mode)
> > +             return 0;
> > +
> > +     if (mode =3D=3D LTR390_SET_ALS_MODE) {
> > +             regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_=
UVS_MODE);
> > +             data->mode =3D LTR390_SET_ALS_MODE;
> > +     } else if (mode =3D=3D LTR390_SET_UVS_MODE) {
> > +             regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UV=
S_MODE);
> > +             data->mode =3D LTR390_SET_UVS_MODE;
> Drop this out of the if / else stack and use
>         data->mode =3D mode;
> A switch statement may be more appropriate here even if it's a few more l=
ines of
> code.
>
> > +     } else {
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ltr390_counts_per_uvi(struct ltr390_data *data)
> > +{
> > +     int orig_gain =3D 18;
> > +     int orig_int_time =3D 400;
> > +     int divisor =3D orig_gain * orig_int_time;
> > +     int gain =3D data->gain;
> > +
> > +     int int_time_ms =3D DIV_ROUND_CLOSEST(data->int_time_us, 1000);
> > +     int uvi =3D DIV_ROUND_CLOSEST(2300*gain*int_time_ms, divisor);
>
> Spaces around *
>
> > +
> > +     return uvi;
> > +}
> > +
> >  static int ltr390_read_raw(struct iio_dev *iio_device,
> >                          struct iio_chan_spec const *chan, int *val,
> >                          int *val2, long mask)
> >  {
> > -     int ret;
> >       struct ltr390_data *data =3D iio_priv(iio_device);
> > +     int ret;
> Don't move code unless there is a strong reason. Fine to
> tidy this sort of thing up, but not in a patch doing anything else
> as it becomes noise.
>
> >
> Almost certainly need locking here as concurrent accesses to sysfs
> files will result in mode changing whilst the read has not yet happened.
>
> >       switch (mask) {
> >       case IIO_CHAN_INFO_RAW:
> > -             ret =3D ltr390_register_read(data, LTR390_UVS_DATA);
> > -             if (ret < 0)
> > -                     return ret;
> > +             switch (chan->type) {
> > +             case IIO_UVINDEX:
> > +                     ret =3D ltr390_set_mode(data, LTR390_SET_UVS_MODE=
);
> > +                     if (ret < 0)
> > +                             return ret;
> > +
> > +                 ret =3D ltr390_register_read(data, LTR390_UVS_DATA);
> Fix the alignment - looks like mix of spaces and tabs.
> scripts/checkpatch.pl would have pointed that out.
>
> > +                     if (ret < 0)
> > +                             return ret;
> > +
> > +                     break;
> > +
> > +             case IIO_INTENSITY:
> > +                     ret =3D ltr390_set_mode(data, LTR390_SET_ALS_MODE=
);
> > +                     if (ret < 0)
> > +                             return ret;
> > +
> > +                     ret =3D ltr390_register_read(data, LTR390_ALS_DAT=
A);
> > +                     if (ret < 0)
> > +                             return ret;
> > +                     break;
> > +
> > +             default:
> > +                     ret =3D -EINVAL;
> return here. Otherwise you overwrite the value below.
>
> > +             }
> > +
> >               *val =3D ret;
> > -             return IIO_VAL_INT;
> > +             ret =3D IIO_VAL_INT;
> return here and drop the break.
> It is much simpler to follow code if it doesn't unnecessarily not
> return in cases like this as we have to scroll down to see if anything el=
se
> happens.
>
> > +             break;
> > +
> >       case IIO_CHAN_INFO_SCALE:
> > -             *val =3D LTR390_WINDOW_FACTOR;
> > -             *val2 =3D LTR390_COUNTS_PER_UVI;
> > -             return IIO_VAL_FRACTIONAL;
> > +             mutex_lock(&data->lock);
> Add appropriate scope using {} and use
> guard(mutex)(&data->lock) as then in error paths you can
> return without unlocking...
> > +
> > +             switch (chan->type) {
> > +             case IIO_UVINDEX:
> > +                     ret =3D ltr390_set_mode(data, LTR390_SET_UVS_MODE=
);
> > +                     if (ret < 0)
> mutex held. Result is deadlock.  Above scoped unlocking avoids that witho=
ut
> needing to make sure you unlock in all paths.
>
>
> > +                             return ret;
> > +
> > +                     *val =3D LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL=
_PRECISION;
> > +                     *val2 =3D ltr390_counts_per_uvi(data);
> > +                     ret =3D IIO_VAL_FRACTIONAL;
> return here.
>
> > +                     break;
> > +
> > +             case IIO_INTENSITY:
> > +                     ret =3D ltr390_set_mode(data, LTR390_SET_ALS_MODE=
);
> > +                     if (ret < 0)
> > +                             return ret;
> > +
> > +                     *val =3D LTR390_WINDOW_FACTOR;
> > +                     *val2 =3D data->gain;
> > +
> > +                     ret =3D IIO_VAL_FRACTIONAL;
> > +                     break;
> return here.
> > +
> > +             default:
> > +                     ret =3D -EINVAL;
> return here.
> > +             }
> > +
> > +             mutex_unlock(&data->lock);
> With guard() change above, not needed.
> But close scope here with }
> > +             break;
> > +
> > +     case IIO_CHAN_INFO_INT_TIME:
> > +             mutex_lock(&data->lock);
> Given all paths other than invalid ones need the lock, maybe just take
> it outside of the switch statement - still use guard() though to avoid
> need to manually unlock.
>
> > +             *val =3D data->int_time_us;
> > +             mutex_unlock(&data->lock);
> > +             ret =3D IIO_VAL_INT;
> > +             break;
> > +
> >       default:
> > -             return -EINVAL;
> > +             ret =3D -EINVAL;
> >       }
> > +
> > +     return ret;
> This is a bad change as now I need to read to end of function in all
> code paths.  Some code styles insist on single exit points, but
> the kernel style does not. (not worth a long discussion of why the
> two common styles came about). Keep those early returns.
>
>
> >  }
> >
> > -static const struct iio_info ltr390_info =3D {
> > -     .read_raw =3D ltr390_read_raw,
> > +/* integration time in us */
> > +static const int ltr390_int_time_map_us[] =3D {400000, 200000, 100000,=
 50000, 25000, 12500};
> > +static const int ltr390_gain_map[] =3D {1, 3, 6, 9, 18};
> > +
> > +static IIO_CONST_ATTR_INT_TIME_AVAIL("400000 200000 100000 50000 25000=
 12500");
> Please use read_avail() callback and the appropriate mask to provide this=
.
> That enables it to be used from in kernel consumers and enforces the
> ABI without a reviewer having to check what you have aligns.
>
> > +static IIO_CONST_ATTR(gain_available, "1 3 6 9 18");
> Given we don't have a 'gain' control, what is the available applying to?
>
The gain gets controlled by writing to the iio_info_scale attribute,
we write one of the above available values.
So that we can scale the raw ALS and UVI values. I could use
read_avail() for this too for the IIO_INFO_SCALE channel. Should I do
that?
Can you elaborate more on your comment?

> > +
> > +static struct attribute *ltr390_attributes[] =3D {
> > +     &iio_const_attr_integration_time_available.dev_attr.attr,
> > +     &iio_const_attr_gain_available.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group ltr390_attribute_group =3D {
> > +     .attrs =3D ltr390_attributes,
> >  };
> >
> > -static const struct iio_chan_spec ltr390_channel =3D {
> > +static const struct iio_chan_spec ltr390_channels[] =3D {
> > +     /* UV sensor */
> > +     {
> >       .type =3D IIO_UVINDEX,
> > -     .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INF=
O_SCALE)
> > +     .scan_index =3D 0,
> > +     .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INF=
O_SCALE),
> > +     .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME)
> Fix style.
>         {
>                 .type =3D ...
>
> > +     },
> > +     /* ALS sensor */
> > +     {
> > +     .type =3D IIO_INTENSITY,
> > +     .scan_index =3D 1,
> > +     .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INF=
O_SCALE),
> > +     .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME)
> > +     },
> > +};
> > +
> > +static int ltr390_set_gain(struct ltr390_data *data, int val)
> > +{
> > +     int ret, idx;
> > +
> > +     for (idx =3D 0; idx < ARRAY_SIZE(ltr390_gain_map); idx++) {
> > +             if (ltr390_gain_map[idx] =3D=3D val) {
> > +                     mutex_lock(&data->lock);
> guard here.
> > +                     ret =3D regmap_update_bits(data->regmap,
> > +                                             LTR390_ALS_UVS_GAIN,
> > +                                             LTR390_ALS_UVS_GAIN_MASK,=
 idx);
> > +                     if (!ret)
>                         if (ret)
>                                 return ret;
> prefer to keep error paths as the out of line ones as if you review
> a lot of code, predictability helps review quickly.
>
> > +                             data->gain =3D ltr390_gain_map[idx];
> > +
> > +                     mutex_unlock(&data->lock);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ltr390_set_int_time(struct ltr390_data *data, int val)
> > +{
> > +     int ret, idx;
> > +
> > +     for (idx =3D 0; idx < ARRAY_SIZE(ltr390_int_time_map_us); idx++) =
{
> > +             if (ltr390_int_time_map_us[idx] =3D=3D val) {
> flip logic to reduce indent.
>                 if (ltr390_int_time_map_us[idx] !=3D val)
>                         continue;
>
>                 guard(mutex)...
>
> > +                     mutex_lock(&data->lock);
> > +                     ret =3D regmap_update_bits(data->regmap,
> > +                                             LTR390_ALS_UVS_MEAS_RATE,
> > +                                             LTR390_ALS_UVS_INT_TIME_M=
ASK,
> > +                                             idx<<LTR390_ALS_UVS_INT_T=
IME_MASK_SHIFT);
> spaces around <<
> Though FIELD_PREP() probably better solution.
>
> > +                     if (!ret)
> As in previous funciton.
> > +                             data->int_time_us =3D ltr390_int_time_map=
_us[idx];
> > +
> > +                     mutex_unlock(&data->lock);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan=
_spec const *chan,
> > +                             int val, int val2, long mask)
> > +{
> > +     struct ltr390_data *data =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SCALE:
> > +             if (val2 !=3D 0)
> > +                     ret =3D -EINVAL;
> > +
> > +             ret =3D ltr390_set_gain(data, val);
> > +             break;
> > +
> > +     case IIO_CHAN_INFO_INT_TIME:
> > +             if (val2 !=3D 0)
> > +                     ret =3D -EINVAL;
> > +
> > +             ret =3D ltr390_set_int_time(data, val);
> > +             break;
> > +
> > +     default:
> > +             ret =3D -EINVAL;
> > +     }
> > +
> > +     return ret;
> Use early returns.
>
> > +}
> > +
> > +static const struct iio_info ltr390_info =3D {
> > +     .attrs =3D &ltr390_attribute_group,
> > +     .read_raw =3D ltr390_read_raw,
> > +     .write_raw =3D ltr390_write_raw,
> >  };
> >
> >  static int ltr390_probe(struct i2c_client *client)
> > @@ -139,11 +352,18 @@ static int ltr390_probe(struct i2c_client *client=
)
> >                                    "regmap initialization failed\n");
> >
> >       data->client =3D client;
> > +     /* default value of int time from pg: 15 of the datasheet */
> I'd spell out integration in the comment.
>
> > +     data->int_time_us =3D 100000;
> > +     /* default value of gain from pg: 16 of the datasheet */
> > +     data->gain =3D 3;
> > +     /* default mode for ltr390 is ALS mode */
> > +     data->mode =3D LTR390_SET_ALS_MODE;
> > +
> >       mutex_init(&data->lock);
> >
> >       indio_dev->info =3D &ltr390_info;
> > -     indio_dev->channels =3D &ltr390_channel;
> > -     indio_dev->num_channels =3D 1;
> > +     indio_dev->channels =3D ltr390_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(ltr390_channels);
> >       indio_dev->name =3D "ltr390";
> >
> >       ret =3D regmap_read(data->regmap, LTR390_PART_ID, &part_number);
> > @@ -161,8 +381,7 @@ static int ltr390_probe(struct i2c_client *client)
> >       /* Wait for the registers to reset before proceeding */
> >       usleep_range(1000, 2000);
> >
> > -     ret =3D regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
> > -                           LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
> > +     ret =3D regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SE=
NSOR_ENABLE);
> >       if (ret)
> >               return dev_err_probe(dev, ret, "failed to enable the sens=
or\n");
> >
> > @@ -189,6 +408,7 @@ static struct i2c_driver ltr390_driver =3D {
> >       .probe =3D ltr390_probe,
> >       .id_table =3D ltr390_id,
> >  };
> > +
> Lack of space is intentional to keep the macro closely coupled to what
> it applies to.
>
> >  module_i2c_driver(ltr390_driver);
> >
> >  MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
>
ACK. Will do the necessary changes and send V2 after splitting it into
4 patches (replying again because I missed replying with CC last time)

