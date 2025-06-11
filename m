Return-Path: <linux-iio+bounces-20442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C409EAD59BF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E6B3A9A9D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694DA1A071C;
	Wed, 11 Jun 2025 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAdY3x31"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175F18C002;
	Wed, 11 Jun 2025 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654415; cv=none; b=QfMvk2PQPtugtSpZWxVEJ3tiHWSdMh2U9b00Jqf5vYByZp6XwGZG+tsfkFKK74CBg2P8IjypLu4jkqSnBbpmSf9X2UsQh4kMv7Pv0RN1JN0nOc8vzpNiqDPTHyjyTkvd1YTU/YJNreUHnYMQuqmP30UCjMgnRhH6sBobYgE/NRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654415; c=relaxed/simple;
	bh=jPhJqp12YmPheYt5k7tMyxHFPWQAYjyoax+vbBjRYCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2+MWH2uRuIWTIlF6LpSKBf9h/zgFpugsh5EMmrGk261s0k4umWMTu8B4HLJoVgM4gLjdSTh4BR+VK5iHH9sxgb3yiTTXkxq405VnEC4x5BG2nZdoS4JzjKx7w0z1b/KMLtZPXn9Xmli0FVnvIFgIUNVMBr9mDvex2alLF/EBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAdY3x31; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7111c6b0f1dso697777b3.1;
        Wed, 11 Jun 2025 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749654412; x=1750259212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLHvyD7wJsO2e0WWywcAFLyk62IHbmBBYHcPAMpcN1g=;
        b=HAdY3x31SQhNmmV/wsGABbzMvYmZwn2iWrEHDnz5nq0rT3tR+4HB2bdtR53h/xEWme
         9ys5KXIquTB+SV5NtzO0iQSbnZpZAWmnoHiqjm3nM4/OAD01ttFJtEr65oAgSfQxdamX
         roHml8YCTtPMMgixiAzflkMfXayy7EBsIi1t6WdEbvo7mFes+TQt7HYMXlpc68SP22vn
         v66zR5oJGyI/joxv6h/s+5+6/K6gqraLlx1EAPcfO6I/hJFhxHmIodYJ2kUW9L3MPoeJ
         FQ4hHuv2HQCUf5MJ6Vo5/bIpcXjWQQ8dl98s552bcqmMBAZC/173LRm4Nx2fqzLITiBf
         Celg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654412; x=1750259212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLHvyD7wJsO2e0WWywcAFLyk62IHbmBBYHcPAMpcN1g=;
        b=L3M0QgM2pzQA0plwsQcPHdDj2C2B1NiuE6i22SncNS7EoEubb2iGtKw2b3C1qrsXe+
         u9rWzaovnWKdZDX+wNFhdtZJKCiwKm2YrTnzCSU7a7JkrnZyd2mSswv1p0L8mFVd/BK7
         xPt53YHrwLZa8HXIHMN8hKRXokilD1uiblWW2e8aQgYOoiJ/3u+ySy6w5tBICcIQ0MLb
         C7VRtlcfvGFtx0LgaISEYL9Ootwdvkdhz+139B5oZVyMw99IvhKybMbOV22acCLYCGGD
         VSQ4RUaiEMVehOjnUQ7lLeGegPhyRlWVd74ij3DLpkw0XEaFy1ouGir9b5PIXfPXk3KC
         Jedw==
X-Forwarded-Encrypted: i=1; AJvYcCUtIdg8XqDcuH1sbDPyZd18mshWOF7NvGyVPUUOO1A5KLyugVvkyE8LttyrM6Hy553TcR/jwmyJAZXYQJxE@vger.kernel.org, AJvYcCVEJURIB0I4B3Y20pmYwXhiNs+e2OZrXJH4DGVpxLwjfGLEgCwCIfX++t0VyuqoWTxGcoFTctU4Gto=@vger.kernel.org, AJvYcCWvbq7UZNhzLk5VEsJAMff6Q6aZpcek3GlCogXMojUgYRKW0ZDKTbrxpmZgQcLOyJf8q6UOmdIn6Rz6@vger.kernel.org
X-Gm-Message-State: AOJu0YzzV2c1w8NF5lI3UYfrnN8q0CL4cDIZrozkTS2JHEpPCqc8+TKr
	MB+OcXWMK90kNg5/e7y1HzS6MLpS2iZXg+9Fu2Wa52R+/y3DbTB60MqiNP7E3TLtI7vf6X1pCEf
	Mr8vAM3l7XpllLYkZ3RkQunZFEA1LpRc=
X-Gm-Gg: ASbGnct72ws7iNRAlBpBgqPoMNLwV2DBeeARVK9s2tMnkOu1lAcuGDqpKEr6impVXaA
	AAylJlWoHCiGh0bj/eNAsGjVi5ap4ODH/j6f08SeUkUPCnWkp7hJlmke7R7JluIbELY5/4pJclq
	GZy8BwiyzOLdEWhuWkE1bDRfIDuq1UqyTJVfdv/FHQCJs=
X-Google-Smtp-Source: AGHT+IFbQLnI2vz/oiNY1COQzxJhUVbqRGawrm/dMsYImtWVEPaoOknPmYCUXamI/DvWQoEzlduGx7o3Evn447cPeTs=
X-Received: by 2002:a05:690c:6:b0:70e:2b16:da55 with SMTP id
 00721157ae682-71140b0e06fmr20437497b3.8.1749654412061; Wed, 11 Jun 2025
 08:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-8-l.rubusch@gmail.com>
 <20250608170819.3de87f4e@jic23-huawei>
In-Reply-To: <20250608170819.3de87f4e@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 11 Jun 2025 17:06:16 +0200
X-Gm-Features: AX0GCFuTVi7RxGRPJfn0Gv9q-EHUvv0Eu_vNbspgREgDzgdXDG7ZneTmwMGfrBk
Message-ID: <CAFXKEHaRupFmFQ9ixTT_3p_XaoorJP=y4asYjw3dSMpxXhbOwQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] iio: accel: adxl313: add activity sensing
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	bagasdotme@gmail.com, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 6:08=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sun,  1 Jun 2025 17:21:35 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add possibilities to set a threshold for activity sensing. Extend the
> > interrupt handler to process activity interrupts. Provide functions to =
set
> > the activity threshold and to enable/disable activity sensing. Further =
add
> > a fake channel for having x, y and z axis anded on the iio channel.
> >
> > This is a preparatory patch. Some of the definitions and functions are
> > supposed to be extended for inactivity later on.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> Hi Lothar,
>
> My main question from this read through is whether we need to be quite
> so careful on disabling measurement when configuring events.  It is rathe=
r
> unusual if that is necessary and I'm not sure that's what the datasheet
> is implying with the vague bit of advice.
>
> >  static const unsigned long adxl313_scan_masks[] =3D {
> > @@ -297,6 +331,68 @@ static int adxl313_read_freq_avail(struct iio_dev =
*indio_dev,
> >       }
> >  }
> >
> > +static int adxl313_is_act_inact_en(struct adxl313_data *data,
> > +                                enum adxl313_activity_type type)
> > +{
> > +     unsigned int axis_ctrl;
> > +     unsigned int regval;
> > +     int axis_en, int_en, ret;
> > +
> > +     ret =3D regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axi=
s_ctrl);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Check if axis for activity are enabled */
> > +     if (type !=3D ADXL313_ACTIVITY)
>
> As below - only one value possible, so don't check it.
>
> > +             return 0;
> > +
> > +     axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> > +
> > +     /* The axis are enabled, now check if specific interrupt is enabl=
ed */
> > +     ret =3D regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval=
);
> > +     if (ret)
> > +             return ret;
> > +
> > +     int_en =3D adxl313_act_int_reg[type] & regval;
> > +
> > +     return axis_en && int_en;
> > +}
> > +
> > +static int adxl313_set_act_inact_en(struct adxl313_data *data,
> > +                                 enum adxl313_activity_type type,
> > +                                 bool cmd_en)
> > +{
> > +     unsigned int axis_ctrl;
> > +     unsigned int threshold;
> > +     int ret;
> > +
> > +     if (type !=3D ADXL313_ACTIVITY)
>
> As the enum only has one value you can drop this check.
> Obviously it's dropped in next patch anyway but better to never
> introduce it.
>
> > +             return 0;
> > +
> > +     axis_ctrl =3D ADXL313_ACT_XYZ_EN;
> > +
> > +     ret =3D adxl313_set_measure_en(data, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CT=
L,
> > +                              axis_ctrl, cmd_en);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_read(data->regmap, adxl313_act_thresh_reg[type], &=
threshold);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
> > +                              adxl313_act_int_reg[type],
> > +                              cmd_en && threshold);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return adxl313_set_measure_en(data, true);
> > +}
> > +
> >  static int adxl313_read_raw(struct iio_dev *indio_dev,
> >                           struct iio_chan_spec const *chan,
> >                           int *val, int *val2, long mask)
> > @@ -370,6 +466,113 @@ static int adxl313_write_raw(struct iio_dev *indi=
o_dev,
> >       }
> >  }
>
> > +
> > +static int adxl313_read_event_value(struct iio_dev *indio_dev,
> > +                                 const struct iio_chan_spec *chan,
> > +                                 enum iio_event_type type,
> > +                                 enum iio_event_direction dir,
> > +                                 enum iio_event_info info,
> > +                                 int *val, int *val2)
> > +{
> > +     struct adxl313_data *data =3D iio_priv(indio_dev);
> > +     unsigned int act_threshold;
> > +     int ret;
> > +
> > +     /* Measurement stays enabled, reading from regmap cache */
>
> If it isn't safe to read whilst measurements are in progress (as opposed
> to maybe getting a small variation in timing) then this seems more
> fragile than I'd like (to future code changes for example).
>
> Might need an explicit check on it being cached regcache_reg_cached()
> for example though that is very rarely used which makes me dubious
> about using it here.
>
>
> > +
> > +     if (type !=3D IIO_EV_TYPE_MAG)
> > +             return -EINVAL;
> > +
> > +     if (info !=3D IIO_EV_INFO_VALUE)
> > +             return -EINVAL;
> > +
> > +     switch (dir) {
> > +     case IIO_EV_DIR_RISING:
> > +             ret =3D regmap_read(data->regmap,
> > +                               adxl313_act_thresh_reg[ADXL313_ACTIVITY=
],
> > +                               &act_threshold);
> > +             if (ret)
> > +                     return ret;
> > +             *val =3D act_threshold * 15625;
> > +             *val2 =3D MICRO;
> > +             return IIO_VAL_FRACTIONAL;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int adxl313_write_event_value(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir,
> > +                                  enum iio_event_info info,
> > +                                  int val, int val2)
> > +{
> > +     struct adxl313_data *data =3D iio_priv(indio_dev);
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     ret =3D adxl313_set_measure_en(data, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (type !=3D IIO_EV_TYPE_MAG)
> > +             return -EINVAL;
> > +
> > +     if (info !=3D IIO_EV_INFO_VALUE)
> > +             return -EINVAL;
> > +
> > +     /* Scale factor 15.625 mg/LSB */
> > +     regval =3D DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> > +     switch (dir) {
> > +     case IIO_EV_DIR_RISING:
> > +             ret =3D regmap_write(data->regmap,
> > +                                adxl313_act_thresh_reg[ADXL313_ACTIVIT=
Y],
> > +                                regval);
>
> I'm surprised this can only be set with measurement disabled.
> Maybe a spec reference.   It's common to tweak event values as events
> come in and we generally don't have to stop data flow whilst we do.
>
> There are a few specific bits where the datasheet suggests updating
> them has unwanted side effects in measurement mode.  + there is a general
> suggestion to do configuration before enabling measurement mode.
> I don't see anything saying it is a problem for this register.
>

AFAIK there is no issue, nor a big side effect. Changing config
registers might lead to initially wrong measurements. Just the first
measurements might be wrong. I guess this could be a problem if the
sensor had more features and, say, any kind of threshold for some
event then triggered an event wrongly. In case of the ADXL313, there
should not be such a risk. It's then rather about initial wrong
measurements. (Exception: changing the FIFO modes, where turning to
standby is explicitely recommended).

Unfortunately, I could not recall the exact page in the datasheet, but
it matched pretty much my observation also with the ADXL345. So, I'll
give it a try and remove turning off measurement for the
write_event_config()


> > +             if (ret)
> > +                     return ret;
> > +             return adxl313_set_measure_en(data, true);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> >  static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned i=
nt value)
> >  {
> >       struct adxl313_data *data =3D iio_priv(indio_dev);
> > @@ -502,19 +705,32 @@ static int adxl313_fifo_push(struct iio_dev *indi=
o_dev, int samples)
> >
> >  static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
>
> Ah. This does not also have events.  Still it's a mix, so maybe
> adxl313_handle_interrupts() or something like that.

I also could break it up into:
- handle interrupt source register events
- drain fifo watermark samples
?

> >  {
> > +     s64 ts =3D iio_get_time_ns(indio_dev);
> >       struct adxl313_data *data =3D iio_priv(indio_dev);
> >       int samples;
> > +     int ret =3D -ENOENT;
> > +
> > +     if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
> > +             ret =3D iio_push_event(indio_dev,
> > +                                  IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > +                                                     IIO_MOD_X_OR_Y_OR=
_Z,
> > +                                                     IIO_EV_TYPE_MAG,
> > +                                                     IIO_EV_DIR_RISING=
),
> > +                                  ts);
> > +             if (ret)
> > +                     return ret;
> > +     }
> >
> >       if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
> >               samples =3D adxl313_get_samples(data);
> >               if (samples < 0)
> >                       return samples;
> >
> > -             return adxl313_fifo_push(indio_dev, samples);
> > +             ret =3D adxl313_fifo_push(indio_dev, samples);
> >       }
> >
> >       /* Return error if no event data was pushed to the IIO channel. *=
/
> > -     return -ENOENT;
> > +     return ret;
> This handling works, but as Andy observed maybe the comment is now confus=
ing
> given ret is mostly not an error.  Perhaps put that where ret is declared
> instead, or use a separate mask check at the start to quickly
> error out if no bits that we handle are set.
> >  }

Yes. Andy also pointed out here. I already developed a feeling for
"something's smelly" with this code, but cannot really think of a
better approach. Actually it works, and for me it is somehow logical.
Probably there are better ways to solve this situation in a cleaner
way?

