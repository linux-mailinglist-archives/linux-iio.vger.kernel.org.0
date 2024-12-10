Return-Path: <linux-iio+bounces-13300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A859EA86B
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 07:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2AE288C7E
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 06:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75E228C92;
	Tue, 10 Dec 2024 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9pIqFyX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F366E1D7996;
	Tue, 10 Dec 2024 06:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810410; cv=none; b=kc7lg9iZuU65sHCu5fS7ZAbWpDsMmhfdDUnstBz5qAqd8remNnNX/tC0/swT5FjLC1fJ09cD8zD98yt4YMmCgYj377nKAGClypM91JSg4SiFM9M/rdWwhFn0JlvahqjeMhH4eTgETOaZyosilbzjwD0MkhwTb0tLaZe6/rxUPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810410; c=relaxed/simple;
	bh=+y46efwCxXKvi4GVh+qsBB0d3u+jYVP9StzrgJkrVlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdLUjV7o/FTivpTQ69vf2lSH5lCjVVQizAnYCA3J6ahnhzZG5Lw7KZ9khJ5pAbgXrI/BX3hLIZX5jYgnT1QqgUKkLY4WfPiWQOBZ+EKtbTB08VLt6/Nu37If6V8cIx4BsEKqDiB4gFSow6wdg8X1AlRbLLtt/Le4UaZjdY2C68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9pIqFyX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso738324266b.1;
        Mon, 09 Dec 2024 22:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733810407; x=1734415207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHbfjlgRpKE4dLapuGcw54S0zICUfY0cv7/zCV0JyFQ=;
        b=X9pIqFyXCTP7hkCTDbR7HU02q2Il5mdAep3NFiAQOSGtW6zcTyEhIFgFmu/6M+wBmD
         wGZWoZDUGgkff9n5WkhFuZhv1NcEfViTjBCBQCF6I8HAX9obQN/pNkpfvmCcPXs2MMAS
         l3tOnOSyvwKs3TG7I2TXgo6+AQkycIXOFSZgdAfv8Er/RwVDE+P7BXDclO0fjfEevJ5G
         9xpKASb8OvIE9/S7BaXc6WPuIqiZrVRzqWxUTuBOk4aOqDlfsor8JGeJLPEbOhhczqe5
         T8ggyruxUHJBc5ns+++j9KK+BIx4cgeXX0u4YGeXtoJj/yGRNpl3b4GzFcG45taVeDg+
         3GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733810407; x=1734415207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHbfjlgRpKE4dLapuGcw54S0zICUfY0cv7/zCV0JyFQ=;
        b=QuYL01HIpWU6o855L5MaCHvVRW+UTIkdiLgtB9mxvskXkZtzDGvsqKCUwdL54Ly3ur
         CdZQUaqkqo+vypu0PyKRWjhRX+A/F62/3IUAScl7QpdDZkqmAv4l3i4UrsRkLBe59qnJ
         yL1zR20oNRsP9+viUvnHS1s+0JpygrV98Os8QaBI77lDmy7EZlKFyie9LNs+8k8Cv/C7
         VJAwEpcwT4gZnwooUyk58M0trEflCuM+gYMbteUkALsV+5/ci/8rDAFZOIpCGQOfmpAb
         Tf5P6D6zXeV9Wk6TUEXlWB2FYJuk4kznDpnvm4Q95W7cNLkkJ7VUizfeFTxE5pezlJ1r
         caNA==
X-Forwarded-Encrypted: i=1; AJvYcCVCQ0Yd2mDL/CLjYAlMZv8JI8JWwM9DG0wyXpjpYGxxNwsw7BgGCiPZYptJS/v/OF20ZnU2i0GPGHCd@vger.kernel.org, AJvYcCVo+3MoGvTfoMXpICzxdgNPuevR0U/KuD22PHWo4BPB92CuLAaYUl81zF1UBy0qtZL0Ft8NtCSyMcLJ@vger.kernel.org, AJvYcCXyNTlJo+faoOe3iPtym0RhGumbGSq41C5EhC9SlHnFY8E5DV7os2IrTfD0j+gL1n/xbkOkm+cNtStzKerR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3JZZSeXNfYn1yww6jCy3RLI+qdyglDg70JNptFjBQp3eVgCjg
	STXzstnkKbVLC9o+7VJbg/jgLhDxK0A0d4Nq5HmlFQlAPGZi/cTIUOMhhTzCYkiVd0gMmZKfmkA
	/aHM2mpA0UGE1xskiA7hSwcN124A=
X-Gm-Gg: ASbGncsPE8eMTH4SVELxBaYzY14Y7JfffGgk/2w9KPMk5d4l4J3ixRr7CIBLp2uFEeC
	9J42MYL1QoWkFrenX/njgu5YqyO9lPsaIKTA=
X-Google-Smtp-Source: AGHT+IFWw58hMimyh4Z7NYDAgrffb/Ls9djAuX/kCx7M+n51illwZCJy8tjDQ7j38hrrnuyyN4N1D5kcTq9R34TcjOM=
X-Received: by 2002:a17:907:9507:b0:aa6:9372:cac7 with SMTP id
 a640c23a62f3a-aa69372ce49mr382580066b.31.1733810406863; Mon, 09 Dec 2024
 22:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-3-j2anfernee@gmail.com> <b5b43427-d0d7-43d5-bf8a-02a966ac25d3@wanadoo.fr>
In-Reply-To: <b5b43427-d0d7-43d5-bf8a-02a966ac25d3@wanadoo.fr>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Tue, 10 Dec 2024 13:59:30 +0800
Message-ID: <CA+4VgcK3FDdnLA_Z_xgikKd6diq3Tcfh2uDahnsKzEE0LBU=Jg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	javier.carrasco.cruz@gmail.com, andriy.shevchenko@linux.intel.com, 
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com, 
	mitrutzceclan@gmail.com, tgamblin@baylibre.com, matteomartelli3@gmail.com, 
	alisadariana@gmail.com, gstols@baylibre.com, thomas.bonnefille@bootlin.com, 
	ramona.nechita@analog.com, mike.looijmans@topic.nl, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Christophe JAILLET,

Thanks for your comment.

Christophe JAILLET <christophe.jaillet@wanadoo.fr> =E6=96=BC 2024=E5=B9=B41=
2=E6=9C=889=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=881:47=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Le 03/12/2024 =C3=A0 10:15, Eason Yang a =C3=A9crit :
> > Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> >
> > NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up =
to
> > 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins fo=
r
> > independent alarm signals, and the all threshold values could be set fo=
r
> > system protection without any timing delay. It also supports reset inpu=
t
> > RSTIN# to recover system from a fault condition.
> >
> > Currently, only single-edge mode conversion and threshold events suppor=
t.
> >
> > Signed-off-by: Eason Yang <j2anfernee-Re5JQEeQqe8AvxtiuMwx3w@public.gma=
ne.org>
> > ---
>
> ...
>
> > +static const u8 REG_VIN_HIGH_LIMIT_LSB[VIN_MAX] =3D {
> > +     0x40, 0x42, 0x44, 0x46, 0x48, 0x4A, 0x4C, 0x4E,
> > +     0x50, 0x52, 0x54, 0x56,
> > +};
> > +static const u8 REG_VIN_LOW_LIMIT_LSB[VIN_MAX] =3D {
> > +     0x41, 0x43, 0x45, 0x47, 0x49, 0x4B, 0x4D, 0x4F,
> > +     0x51, 0x53, 0x55, 0x57,
> > +};
> > +static u8 nct720x_chan_to_index[] =3D {
>
> const as well here?
>
> > +     0 /* Not used */, 0, 1, 2, 3, 4, 5, 6,
> > +     7, 8, 9, 10, 11,
> > +};
>

Yes, it should add const here,
Finally we would remove nct720x_chan_to_index tables.
We would just store this value in the address field.

> ...
>
> > +static int nct720x_read_raw(struct iio_dev *indio_dev,
> > +                         struct iio_chan_spec const *chan,
> > +                         int *val, int *val2, long mask)
> > +{
> > +     int index =3D nct720x_chan_to_index[chan->address];
> > +     u16 volt;
> > +     unsigned int value;
> > +     int err;
> > +     struct nct720x_chip_info *chip =3D iio_priv(indio_dev);
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     guard(mutex)(&chip->access_lock);
>
> The IIO_CHAN_INFO_SCALE case does not seem to need the lock. Would it
> make sense to move it only in the IIO_CHAN_INFO_RAW case?
>

Remove guard(mutex) here.

> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             err =3D regmap_read(chip->regmap16, REG_VIN[index], &valu=
e);
> > +             if (err < 0)
> > +                     return err;
> > +             volt =3D (u16)value;
> > +             *val =3D volt >> 3;
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             /* From the datasheet, we have to multiply by 0.0004995 *=
/
> > +             *val =3D 0;
> > +             *val2 =3D 499500;
> > +             return IIO_VAL_INT_PLUS_NANO;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
>
> ...
>
> > +static int nct720x_write_event_config(struct iio_dev *indio_dev,
> > +                                   const struct iio_chan_spec *chan,
> > +                                   enum iio_event_type type,
> > +                                   enum iio_event_direction dir,
> > +                                   bool state)
> > +{
> > +     int err =3D 0;
>
> Harmless but useless initialisation.
>

We would remove unused err variables.
Since it is very rare for regmap_write() to fail so usually we don't
print an error message for these.

> > +     struct nct720x_chip_info *chip =3D iio_priv(indio_dev);
> > +     int index =3D nct720x_chan_to_index[chan->address];
> > +     unsigned int mask;
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
>
> ...
>
> > +static int nct720x_init_chip(struct nct720x_chip_info *chip)
> > +{
> > +     u8 data[2];
> > +     unsigned int value;
> > +     int err;
> > +
> > +     err =3D regmap_write(chip->regmap, REG_CONFIGURATION, BIT_CONFIGU=
RATION_RESET);
> > +     if (err) {
> > +             dev_err(&chip->client->dev, "Failed to write REG_CONFIGUR=
ATION\n");
> > +             return err;
> > +     }
> > +
> > +     /*
> > +      * After about 25 msecs, the device should be ready and then
> > +      * the Power Up bit will be set to 1. If not, wait for it.
> > +      */
> > +     mdelay(25);
> > +     err  =3D regmap_read(chip->regmap, REG_BUSY_STATUS, &value);
>
> double space after err.
>

Okay.

> > +     if (err < 0)
> > +             return err;
> > +     if (!(value & BIT_PWR_UP))
> > +             return err;
> > +
> > +     /* Enable Channel */
> > +     err =3D regmap_write(chip->regmap, REG_CHANNEL_ENABLE_1, REG_CHAN=
NEL_ENABLE_1_MASK);
> > +     if (err) {
> > +             dev_err(&chip->client->dev, "Failed to write REG_CHANNEL_=
ENABLE_1\n");
> > +             return err;
> > +     }
> > +
> > +     if (chip->vin_max =3D=3D 12) {
> > +             err =3D regmap_write(chip->regmap, REG_CHANNEL_ENABLE_2, =
REG_CHANNEL_ENABLE_2_MASK);
> > +             if (err) {
> > +                     dev_err(&chip->client->dev, "Failed to write REG_=
CHANNEL_ENABLE_2\n");
> > +                     return err;
> > +             }
> > +     }
> > +
> > +     guard(mutex)(&chip->access_lock);
> > +     err  =3D regmap_read(chip->regmap, REG_CHANNEL_ENABLE_1, &value);
>
> double space after err.
>

Okay.

> > +     if (err < 0)
> > +             return err;
> > +     data[0] =3D (u8)value;
> > +
> > +     err  =3D regmap_read(chip->regmap, REG_CHANNEL_ENABLE_2, &value);
>
> double space after err.
>

Okay.

> > +     if (err < 0)
> > +             return err;
> > +     data[1] =3D (u8)value;
> > +
> > +     value =3D get_unaligned_le16(data);
> > +     chip->vin_mask =3D value;
> > +
> > +     /* Start monitoring if needed */
>
> ...
>
> CJ

