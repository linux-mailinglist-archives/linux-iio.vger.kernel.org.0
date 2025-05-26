Return-Path: <linux-iio+bounces-19955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C7AC448F
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 22:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8698169666
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453761E32DB;
	Mon, 26 May 2025 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd7sQbpK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1E1A23A6;
	Mon, 26 May 2025 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748292315; cv=none; b=GxHRBqLjbcUuRcc5peFPLmADaujC0uVOf/q7QZZvevH5XIwFwDXkfYjUYpJ34mZZpoCx4BOOzzXl5fTEUlCU5O4gMozQv0MhP/h95ctaSK/+gm9hYRoJ0lU/SvyCQXp7lZ6JHFF5zzRQPxkz+n/XekBn1x0GyIJPjP/vbCsmHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748292315; c=relaxed/simple;
	bh=8XlFPKAgRZu8iNf7wu/BNssYGbs3cVElibPBDElcwUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoTOxQYKPAeNEack0ecsxWpTIGvedSKgThZVRAMTDQA/ov6gQ9XXwLIXzCphe6zi+0Y18p8M8eFwf1C0+USt++f7GN+8CDS/gAJaqtUHNVM8C7GY5NcsUwGtQhb9RsXlimJDnQMFnyS0SFmMJx/6GmcDpnRVbkDGqrY/SqRg4Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd7sQbpK; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7db5b0ddb1so139592276.2;
        Mon, 26 May 2025 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748292312; x=1748897112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rqf564IOkfuJ6413mTRFf6vGhtbkwIX3nVlwVv5RmSQ=;
        b=gd7sQbpKACMcly2FkJKdWqcF8eAohKD8pghxCtrLuZ4aSEOhmEA/Xv6VixN/83nJGz
         2fYAdVeZ11Y2TNvtxy9POd2BKHVKtywSXReiwQUDyY0X5rSSUmXYgrQdI3L2zjvZ0bhb
         MbrjctrHG/U34c4mdlExXf+KxChmF6a/A3PLfsVIgRloWqrwqa+7HBMpdgJB+/syzvWb
         3zYhYLFd4Kl4dlkXvycX3ZROZ/xnJC5WZ82Tf5sGW3S46GtIFMhqT4kVJ7XOlEXvPAsc
         EgsOUEK8+2P+8za8dBXdIYG2gXEFm7cvw4KPVPDHUoGpXUJJKSw1DWTkb/+EBU85gVqh
         VNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748292312; x=1748897112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rqf564IOkfuJ6413mTRFf6vGhtbkwIX3nVlwVv5RmSQ=;
        b=Hm9TAcnzwiXhwgBTcSxV9wEnzE6Nfu8nmDDc9OabE2dUExoJz2wUshHXlBqjyvBpcY
         XS5xlC4Rb2km729SmQjoCZbkEUX0fi4Z6k9jgqfd2EQ35gL+UnivDPdFsmlS4m6HO4kC
         OuHYNWj6qCI5bOjq3LO2JlkmJuur/vSheGuqUyIYCi+hB46RKyfkDcWzgUFLvBTQ9X8u
         I1CIEXtrVWKQM85LWINosdLyfTyGk681TKN2Km2UTar734QTPcLuOVSnpiOjV+HWiG/z
         aQse6NgZ9YwSrFfZYpH51KJ33xcZJcEqH2QQwQeBJqthkIoToOJ4LTNrC3pd8U47bZg2
         nlaA==
X-Forwarded-Encrypted: i=1; AJvYcCW09K8Rrf5kwmBm3qHRsN8vGADGMtSpuBDCNyU5QWURZOtFAgCJIqc44TmiEt1gglATA7Pc8SJYJblnBppO@vger.kernel.org, AJvYcCWaGCL/bDsZfopShcObuyGgUPgjrPoGOLdvRRegJn1a0ANfmWpb+flz4loErG+/sea52PEDvREWjWSi@vger.kernel.org, AJvYcCXWH2OZfaRJX5X2JFIjPptUkLh/M78NjCTEr5NYV/v5Kv6h/2Y0Hy6C0IpalILC2goncNcCKgZk0Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcnLESfn2GSh86iSnBRIbmdMvfEf0EfieAGHRvLXWg3NR7gQqb
	VVomWObgeBU/uquAUYGgVWXMWESsX2eS/I2hJaEO0vBtEGD0jAB7vxkxliUhypSYJtl+sgrPg13
	1FQPyUOAErkLJMRmnS6uM3sguHh1MbFCCM98j
X-Gm-Gg: ASbGncvuAFdYSw95NDaMYQVmikBJlp72DlReqlRQG0aXNlpLaMemz0Hq1arTQm3EvL4
	w+PFPbVJbEFHjyvxr6tOemLwPXFg1QhOgAJACCEWh3pXV0A2Ca8A8b2biWOutwhCX/r6kuATic+
	jJAOp9VNxHzu+NvKnenAC9QS4oBZnallHoLWfUamZD22I=
X-Google-Smtp-Source: AGHT+IGdBy5zw4tTzbnTdoJ6ppl77oUzVRKJu8Q+Tu2nce+ksoqH7+b9/m0gtrRcpaYpMh/JI1/29vanzAd5xvFReh8=
X-Received: by 2002:a05:690c:4d03:b0:70e:4745:33d4 with SMTP id
 00721157ae682-70e474534d2mr39344047b3.7.1748292312213; Mon, 26 May 2025
 13:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523223523.35218-1-l.rubusch@gmail.com> <20250523223523.35218-5-l.rubusch@gmail.com>
 <20250525132216.0bbc7067@jic23-huawei>
In-Reply-To: <20250525132216.0bbc7067@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 26 May 2025 22:44:35 +0200
X-Gm-Features: AX0GCFuNL-6WiLGB2hsMgCme7HXIhsANbBf-3eOD4wpjLlWpAt_OeqCzXs3Td90
Message-ID: <CAFXKEHa5pK_wc+JJR1EWtJt=Z5Dwj-+rKD9+W-sEMn7uxFNvcg@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] iio: accel: adxl313: make use of regmap cache
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 25, 2025 at 2:22=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 23 May 2025 22:35:15 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Setup regmap cache to cache register configuration. This is a preparato=
ry
> > step for follow up patches, to allow easy acces to the cached
> > configuration.
>
> I think this stands on it's own given registers like the calibbias
> are already both written and read from.  So I'd generalize the justificat=
ion
> to simply reducing unnecessary bus traffic.
>

I (think I) need regmap cache especially for activity / inactivity.
For instance, using cached settings should make it easier to verify
what was enabled when evaluating incomming interrupts. I will rework
the commit message here.

Best,
L

> Jonathan
>
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl313.h      |  2 ++
> >  drivers/iio/accel/adxl313_core.c | 17 +++++++++++++++++
> >  drivers/iio/accel/adxl313_i2c.c  |  6 ++++++
> >  drivers/iio/accel/adxl313_spi.c  |  6 ++++++
> >  4 files changed, 31 insertions(+)
> >
> > diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> > index 72f624af4686..fc937bdf83b6 100644
> > --- a/drivers/iio/accel/adxl313.h
> > +++ b/drivers/iio/accel/adxl313.h
> > @@ -54,6 +54,8 @@ extern const struct regmap_access_table adxl312_writa=
ble_regs_table;
> >  extern const struct regmap_access_table adxl313_writable_regs_table;
> >  extern const struct regmap_access_table adxl314_writable_regs_table;
> >
> > +bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg);
> > +
> >  enum adxl313_device_type {
> >       ADXL312,
> >       ADXL313,
> > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl3=
13_core.c
> > index 06a771bb4726..0c893c286017 100644
> > --- a/drivers/iio/accel/adxl313_core.c
> > +++ b/drivers/iio/accel/adxl313_core.c
> > @@ -46,6 +46,23 @@ const struct regmap_access_table adxl314_readable_re=
gs_table =3D {
> >  };
> >  EXPORT_SYMBOL_NS_GPL(adxl314_readable_regs_table, IIO_ADXL313);
> >
> > +bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
> > +{
> > +     switch (reg) {
> > +     case ADXL313_REG_DATA_AXIS(0):
> > +     case ADXL313_REG_DATA_AXIS(1):
> > +     case ADXL313_REG_DATA_AXIS(2):
> > +     case ADXL313_REG_DATA_AXIS(3):
> > +     case ADXL313_REG_DATA_AXIS(4):
> > +     case ADXL313_REG_DATA_AXIS(5):
> > +     case ADXL313_REG_FIFO_STATUS:
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
> > +
> >  static int adxl312_check_id(struct device *dev,
> >                           struct adxl313_data *data)
> >  {
> > diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl31=
3_i2c.c
> > index a4cf0cf2c5aa..e8636e8ab14f 100644
> > --- a/drivers/iio/accel/adxl313_i2c.c
> > +++ b/drivers/iio/accel/adxl313_i2c.c
> > @@ -21,6 +21,8 @@ static const struct regmap_config adxl31x_i2c_regmap_=
config[] =3D {
> >               .rd_table       =3D &adxl312_readable_regs_table,
> >               .wr_table       =3D &adxl312_writable_regs_table,
> >               .max_register   =3D 0x39,
> > +             .volatile_reg   =3D adxl313_is_volatile_reg,
> > +             .cache_type     =3D REGCACHE_MAPLE,
> >       },
> >       [ADXL313] =3D {
> >               .reg_bits       =3D 8,
> > @@ -28,6 +30,8 @@ static const struct regmap_config adxl31x_i2c_regmap_=
config[] =3D {
> >               .rd_table       =3D &adxl313_readable_regs_table,
> >               .wr_table       =3D &adxl313_writable_regs_table,
> >               .max_register   =3D 0x39,
> > +             .volatile_reg   =3D adxl313_is_volatile_reg,
> > +             .cache_type     =3D REGCACHE_MAPLE,
> >       },
> >       [ADXL314] =3D {
> >               .reg_bits       =3D 8,
> > @@ -35,6 +39,8 @@ static const struct regmap_config adxl31x_i2c_regmap_=
config[] =3D {
> >               .rd_table       =3D &adxl314_readable_regs_table,
> >               .wr_table       =3D &adxl314_writable_regs_table,
> >               .max_register   =3D 0x39,
> > +             .volatile_reg   =3D adxl313_is_volatile_reg,
> > +             .cache_type     =3D REGCACHE_MAPLE,
> >       },
> >  };
> >
> > diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl31=
3_spi.c
> > index 9a16b40bff34..68e323e81aeb 100644
> > --- a/drivers/iio/accel/adxl313_spi.c
> > +++ b/drivers/iio/accel/adxl313_spi.c
> > @@ -24,6 +24,8 @@ static const struct regmap_config adxl31x_spi_regmap_=
config[] =3D {
> >               .max_register   =3D 0x39,
> >               /* Setting bits 7 and 6 enables multiple-byte read */
> >               .read_flag_mask =3D BIT(7) | BIT(6),
> > +             .volatile_reg   =3D adxl313_is_volatile_reg,
> > +             .cache_type     =3D REGCACHE_MAPLE,
> >       },
> >       [ADXL313] =3D {
> >               .reg_bits       =3D 8,
> > @@ -33,6 +35,8 @@ static const struct regmap_config adxl31x_spi_regmap_=
config[] =3D {
> >               .max_register   =3D 0x39,
> >               /* Setting bits 7 and 6 enables multiple-byte read */
> >               .read_flag_mask =3D BIT(7) | BIT(6),
> > +             .volatile_reg   =3D adxl313_is_volatile_reg,
> > +             .cache_type     =3D REGCACHE_MAPLE,
> >       },
> >       [ADXL314] =3D {
> >               .reg_bits       =3D 8,
> > @@ -42,6 +46,8 @@ static const struct regmap_config adxl31x_spi_regmap_=
config[] =3D {
> >               .max_register   =3D 0x39,
> >               /* Setting bits 7 and 6 enables multiple-byte read */
> >               .read_flag_mask =3D BIT(7) | BIT(6),
> > +             .volatile_reg   =3D adxl313_is_volatile_reg,
> > +             .cache_type     =3D REGCACHE_MAPLE,
> >       },
> >  };
> >
>

