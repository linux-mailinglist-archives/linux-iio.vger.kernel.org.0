Return-Path: <linux-iio+bounces-20430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5CDAD5781
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6AA17DCB7
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD91280A5B;
	Wed, 11 Jun 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5FspoOz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF61E487;
	Wed, 11 Jun 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649745; cv=none; b=WTUeyj+yLNJZprSUEFTPdr524nEvvsODjlffxtgvBJqHLpdwD7HqAZmpvU5NGtz166g7JhmeAblwHBC3BMDJFo39rzjg6CQw1ZeFk/SPra/xJbeO3FFkaZHoXc5ioCMsizRj+6BVBHsTv7TqJorv1sBNi2plLYYAl3v/3lR2TA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649745; c=relaxed/simple;
	bh=sQbaweY0frk2luiX3/n3rJGLVgftGMYmUJmjH9Ph3Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJEmzt7hG4ccDNuV4NhKIqhpxvOZyFfcO6F9nyLN72JlIOuWx0PiIUD8rzMoMK3qrmpHQNiPhrPFAqDgWsXA4pN7HXCwO1FZLZAL48vKsCRu5llgYmH3pmMXOqw3JkwgoHjoshNLNi8tSeSkKFNZyFjOwHG/H4YYZlM9WdGN+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5FspoOz; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70c9fabeffdso672397b3.1;
        Wed, 11 Jun 2025 06:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649742; x=1750254542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRZVjmnICFpQvhZEBlWNB0AvSNBklwqbPtIWM3ToCw0=;
        b=H5FspoOz7AMqG3U4zAaU9SnFhHL3+IWkGptD0sNZL9wTIGkvpBcS79vf5/2TDCa0PH
         g0wX7ib0Ffm1eTlpTm/h+1XYMquukIpAxtXvGLROketHg3tFng/pP8NJ4n8czLjGI8sY
         AG5g0ovuxcmp0NwXZCiVgQFjNVO2kXsry1MKwPqObWIrdkUpL7VhqUiQdIvUB8y8Ddof
         hx1j4hJqo5VeUvRN+IplF7bECs4ZDfsr4pCsRm1dUjb6gLsMf9rpthgbLFTQzbQP5MoC
         a/IGXdEdTwP1ptNXwXn8+JeMOMSuMolHUzUEks1t+h1w1wJMfyoAbp3CjXMZbHQAWnMs
         N1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649742; x=1750254542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRZVjmnICFpQvhZEBlWNB0AvSNBklwqbPtIWM3ToCw0=;
        b=NlBLddKawQABMvV3/yNezmlURAEQbrd9lN5iLO1PCNrqpmRXCAvLBJfjL4sD0VXxLO
         ICOGDm5hjN3iBdeDoIbsvPEIb3q1cSa2sunF/SNmfmU3+h4TnHZv0K5D7P0Vajo6671j
         r0WwekZRDHyp3igXnanXSoHSLeUmlWRxgHwMPRsClF381As54D81EBzhKr4rdyJi/kfA
         SO9FO8B+Cyh1N5RlcqGary0z6n0lVjukhGTC6wVDJ6dq8xYQLEhSdcaNiXpameh97dYO
         9HXN/FH/a2IUAE8dfEcc+WUFw21upiNPwbekDbzdBjYezrFcmS1Rh2DoWgLtaDu0eKwo
         VEVw==
X-Forwarded-Encrypted: i=1; AJvYcCWDmzn5UPnT/CMaJb8rSBLsGcXVRPyNBkf8GY6DpVv4HpXEopcxYE1MZw9mZm7VgRw0qhlYh2IoxEw=@vger.kernel.org, AJvYcCWGzjZFcQ+b8MEnaPPVyYo/PjBzQs7bA3eYEsz3cpfhSWXXYB3wDYF1CP6SLT6dZ70iNnXnUIYgB1mR@vger.kernel.org, AJvYcCX2Q5BuwqVE9QaZCFcImItoECLfqpGIPDqDiim0AEbA32rptjY1Lhf029za88T0GCIEpZg8Oi+UWg0yQt1w@vger.kernel.org
X-Gm-Message-State: AOJu0YzyXrmaa29B10LGDO0MJZ+Ti2FuNnr/BXvludw7IfzOZFnt9R3z
	Ja82GAzQkAHaR4XvQAkNKy7y1zuCoJF2T/u7/A7qI8F52qR4urSEIiV2XXamA3IrbZ0uEsqZV1p
	JhG/8Ov3XoNb/9RgDeoXHEY3NtOfpHPobfRV3
X-Gm-Gg: ASbGncu9qY+cvNrcEAP9sjlW2HWsbOFzV6pOtzH0w5YJbrQ5QBdOL2Fp1B+nl0AE083
	Ksx2DhBNlcgNMvKp66dV+9Dh5utcG4ZwQtJwTRJXNQHRHxr03jnzcSF2MQ5EtcrPmpX4KRiZejn
	oKix/Ouuh+mfIgCYPj31jW91IokqFlQEEvu7XLPsiBW6wFbJFkIeD/vw==
X-Google-Smtp-Source: AGHT+IGuEpto+YUufrvRYMCTEh35xKfud8fxXFD/RtUDT9o/btM9zC88aUf81wJBM65HLlv67bi2SwBKNqIo4g4Jn3o=
X-Received: by 2002:a05:690c:688f:b0:70e:7613:e31b with SMTP id
 00721157ae682-711409edfadmr22715767b3.2.1749649742251; Wed, 11 Jun 2025
 06:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-4-l.rubusch@gmail.com>
 <20250608162215.0d1789d0@jic23-huawei> <20250608163812.4a1a93df@jic23-huawei>
In-Reply-To: <20250608163812.4a1a93df@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 11 Jun 2025 15:48:25 +0200
X-Gm-Features: AX0GCFuu-cTelHNADDn6x7Lu3Hn9Ovb_GhhOGWmahwK8_xRWE0dzFakjViNfJlw
Message-ID: <CAFXKEHY5SmtTrxy-8AWxGNqkPUAZjitgYDg2pR7acTAt-tFWdQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] iio: accel: adxl313: make use of regmap cache
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	bagasdotme@gmail.com, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 5:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sun, 8 Jun 2025 16:22:15 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Sun,  1 Jun 2025 17:21:31 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> >
> > > Setup regmap cache to cache register configuration. This is a prepara=
tory
> > > step for follow up patches. Using cached settings will help at inerru=
pt
> > > handling, to generate activity and inactivity events.
> >
> > The regmap cache will reduce traffic to the device for things like read=
ing
> > back sampling frequency, so no need to justify this patch with 'future'
> > stuff.  Justify it with current.   I've applied with the description of
> > simply
> >
> > "Setup regmap cache to cache register configuration, reducing bus traff=
ic
> > for repeated accesses to non volatile registers."
> >
> Dropped again.  The is_volatile should include all volatile registers
> not just ones we happen to be using so far.
>

I see among the patches, REG_INT_SOURCE is added later. For a v5 then
I'll prepare a patch which sets up all registers - including
REG_INT_SOURCE right away. Correct?

Then it should be added the following line:
bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
{
    switch (reg) {
    case ADXL313_REG_DATA_AXIS(0):
    case ADXL313_REG_DATA_AXIS(1):
    case ADXL313_REG_DATA_AXIS(2):
    case ADXL313_REG_DATA_AXIS(3):
    case ADXL313_REG_DATA_AXIS(4):
    case ADXL313_REG_DATA_AXIS(5):
    case ADXL313_REG_FIFO_STATUS:
+    case ADXL313_REG_INT_SOURCE:
        return true;
    default:
        return false;
    }
}

> You added debug accesses in previous patch which will not take the volati=
le
> nature into account unless the register is in that switch statement.

This is not quite clear to me. What am I missing here?

When I try to find iio drivers using "debugfs" and having a
"volatile_reg" called specification (using either ranges or by a
function), I could only identify the following drivers:
./drivers/iio/accel/msa311.c
./drivers/iio/adc/ad7380.c
./drivers/iio/adc/ina2xx-adc.c
./drivers/iio/imu/bno055/bno055.c
./drivers/iio/light/gp2ap020a00f.c

I tried to find if there is a special declaration of debug registers
in the volatile_reg list, but could not find any.

Most interesting here was:
./drivers/iio/adc/ad7380.c

It seems to claim a kind of a "direct" access specifier. Should I use
similar calls to `iio_device_claim_direct()` and
`iio_device_release_direct()` here?

 999
1000 static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev,
u32 reg,
1001                                      u32 writeval, u32 *readval)
1002 {
1003         struct ad7380_state *st =3D iio_priv(indio_dev);
1004         int ret;
1005
1006         if (!iio_device_claim_direct(indio_dev))
1007                 return -EBUSY;
1008
1009         if (readval)
1010                 ret =3D regmap_read(st->regmap, reg, readval);
1011         else
1012                 ret =3D regmap_write(st->regmap, reg, writeval);
1013
1014         iio_device_release_direct(indio_dev);
1015
1016         return ret;
1017 }
1018

>
> Put the all in from the start.
>

I guess, in the ADXL313 I'm doing the same approach as for the
ADXL345. If it's wrong / incomplete here, it will need to be fixed in
the ADXL345 as well. Or did I understand something wrong?

> Jonathan
>
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl313.h      |  2 ++
> > >  drivers/iio/accel/adxl313_core.c | 17 +++++++++++++++++
> > >  drivers/iio/accel/adxl313_i2c.c  |  6 ++++++
> > >  drivers/iio/accel/adxl313_spi.c  |  6 ++++++
> > >  4 files changed, 31 insertions(+)
> > >
> > > diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.=
h
> > > index 72f624af4686..fc937bdf83b6 100644
> > > --- a/drivers/iio/accel/adxl313.h
> > > +++ b/drivers/iio/accel/adxl313.h
> > > @@ -54,6 +54,8 @@ extern const struct regmap_access_table adxl312_wri=
table_regs_table;
> > >  extern const struct regmap_access_table adxl313_writable_regs_table;
> > >  extern const struct regmap_access_table adxl314_writable_regs_table;
> > >
> > > +bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg);
> > > +
> > >  enum adxl313_device_type {
> > >     ADXL312,
> > >     ADXL313,
> > > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adx=
l313_core.c
> > > index 06a771bb4726..0c893c286017 100644
> > > --- a/drivers/iio/accel/adxl313_core.c
> > > +++ b/drivers/iio/accel/adxl313_core.c
> > > @@ -46,6 +46,23 @@ const struct regmap_access_table adxl314_readable_=
regs_table =3D {
> > >  };
> > >  EXPORT_SYMBOL_NS_GPL(adxl314_readable_regs_table, IIO_ADXL313);
> > >
> > > +bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
> > > +{
> > > +   switch (reg) {
> > > +   case ADXL313_REG_DATA_AXIS(0):
> > > +   case ADXL313_REG_DATA_AXIS(1):
> > > +   case ADXL313_REG_DATA_AXIS(2):
> > > +   case ADXL313_REG_DATA_AXIS(3):
> > > +   case ADXL313_REG_DATA_AXIS(4):
> > > +   case ADXL313_REG_DATA_AXIS(5):
> > > +   case ADXL313_REG_FIFO_STATUS:
> > > +           return true;
> > > +   default:
> > > +           return false;
> > > +   }
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
> > > +
> > >  static int adxl312_check_id(struct device *dev,
> > >                         struct adxl313_data *data)
> > >  {
> > > diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl=
313_i2c.c
> > > index a4cf0cf2c5aa..e8636e8ab14f 100644
> > > --- a/drivers/iio/accel/adxl313_i2c.c
> > > +++ b/drivers/iio/accel/adxl313_i2c.c
> > > @@ -21,6 +21,8 @@ static const struct regmap_config adxl31x_i2c_regma=
p_config[] =3D {
> > >             .rd_table       =3D &adxl312_readable_regs_table,
> > >             .wr_table       =3D &adxl312_writable_regs_table,
> > >             .max_register   =3D 0x39,
> > > +           .volatile_reg   =3D adxl313_is_volatile_reg,
> > > +           .cache_type     =3D REGCACHE_MAPLE,
> > >     },
> > >     [ADXL313] =3D {
> > >             .reg_bits       =3D 8,
> > > @@ -28,6 +30,8 @@ static const struct regmap_config adxl31x_i2c_regma=
p_config[] =3D {
> > >             .rd_table       =3D &adxl313_readable_regs_table,
> > >             .wr_table       =3D &adxl313_writable_regs_table,
> > >             .max_register   =3D 0x39,
> > > +           .volatile_reg   =3D adxl313_is_volatile_reg,
> > > +           .cache_type     =3D REGCACHE_MAPLE,
> > >     },
> > >     [ADXL314] =3D {
> > >             .reg_bits       =3D 8,
> > > @@ -35,6 +39,8 @@ static const struct regmap_config adxl31x_i2c_regma=
p_config[] =3D {
> > >             .rd_table       =3D &adxl314_readable_regs_table,
> > >             .wr_table       =3D &adxl314_writable_regs_table,
> > >             .max_register   =3D 0x39,
> > > +           .volatile_reg   =3D adxl313_is_volatile_reg,
> > > +           .cache_type     =3D REGCACHE_MAPLE,
> > >     },
> > >  };
> > >
> > > diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl=
313_spi.c
> > > index 9a16b40bff34..68e323e81aeb 100644
> > > --- a/drivers/iio/accel/adxl313_spi.c
> > > +++ b/drivers/iio/accel/adxl313_spi.c
> > > @@ -24,6 +24,8 @@ static const struct regmap_config adxl31x_spi_regma=
p_config[] =3D {
> > >             .max_register   =3D 0x39,
> > >             /* Setting bits 7 and 6 enables multiple-byte read */
> > >             .read_flag_mask =3D BIT(7) | BIT(6),
> > > +           .volatile_reg   =3D adxl313_is_volatile_reg,
> > > +           .cache_type     =3D REGCACHE_MAPLE,
> > >     },
> > >     [ADXL313] =3D {
> > >             .reg_bits       =3D 8,
> > > @@ -33,6 +35,8 @@ static const struct regmap_config adxl31x_spi_regma=
p_config[] =3D {
> > >             .max_register   =3D 0x39,
> > >             /* Setting bits 7 and 6 enables multiple-byte read */
> > >             .read_flag_mask =3D BIT(7) | BIT(6),
> > > +           .volatile_reg   =3D adxl313_is_volatile_reg,
> > > +           .cache_type     =3D REGCACHE_MAPLE,
> > >     },
> > >     [ADXL314] =3D {
> > >             .reg_bits       =3D 8,
> > > @@ -42,6 +46,8 @@ static const struct regmap_config adxl31x_spi_regma=
p_config[] =3D {
> > >             .max_register   =3D 0x39,
> > >             /* Setting bits 7 and 6 enables multiple-byte read */
> > >             .read_flag_mask =3D BIT(7) | BIT(6),
> > > +           .volatile_reg   =3D adxl313_is_volatile_reg,
> > > +           .cache_type     =3D REGCACHE_MAPLE,
> > >     },
> > >  };
> > >
> >
>

