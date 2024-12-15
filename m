Return-Path: <linux-iio+bounces-13483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EC99F2305
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 10:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6955518868B8
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE314A4D1;
	Sun, 15 Dec 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejXzFaYb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE34EBE;
	Sun, 15 Dec 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734255710; cv=none; b=O7Rjz1uCB8nwVSsBGIUvLxkzKs926awrdq7wu4bQl6oJpdc6epIpXSmg0J8vstTjQIPigKYfDwIPUEbK/fBh5P4H8yttFP5NtgRk8r2CGEuffb4jyXEY27MNKi9gn5O8d4j5RDtxAYY9KErgg+kIeXugbOd7IVmxCfEgj07FvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734255710; c=relaxed/simple;
	bh=ePbSdZsRFiXqhNGHuSmR6Lslncho2ls6gSK5kjpaKPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7yZtOncGmsV4MHx5oZitqWW+MXzMGjUPd9qPUZC5DI7P1gaSdClG/aN+PS49FfC7WkDRxd7S2hum8I8RWCHo7fx9Nzo3b85eAtGA3/fxPE6+tUnP1U063d9Ig6R+vpLLl9sL7N7hUSobYb60qVqQi9QxVN+mC45LQ7b6RyEWK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejXzFaYb; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6eed30536acso2381577b3.1;
        Sun, 15 Dec 2024 01:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734255708; x=1734860508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6/6+IunBBs1SWisZWZM0JmMebIt2yjPR7LbVi4W908=;
        b=ejXzFaYb5prXUJIxSbr8wgD3/8GliCzvOy6oai/wtfwvDoavOV1fB58zFJK4HWRnNl
         sQK3cyIHIGrgQepd+/XcDvm4Gx5UgcDdb9NOFwZ1Z7HPDfvfe/TV6vr5zLjgfPsD/2tW
         Z2owu1mi7HqPoyPbX02AxrbFXWwA8kgCyHksfi0gciDbRCfn9qOJdknenM+woSbGUO9x
         2V6Pt3njbPnzOctlk5dzXtJVkP48sIaRWmHY3WwjSPYFOKSx/1GAsX/Swy2vtk/FN1aa
         ge71Zxv1z7sxwOkxcOmcYjIUn+yLCCkChhzzdarhme3oLDtYgd4ryzJJJkH2yG6El73n
         g62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734255708; x=1734860508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6/6+IunBBs1SWisZWZM0JmMebIt2yjPR7LbVi4W908=;
        b=XFrvPrae+es7ZbFAkRON4hG1wqhzCqs3J8qBHO7o5mLg49C/aoCJsizfR74FQXH2iu
         EHgafP8oRimBwD3vkD8YzpAAl8asNXNm6yrMkyStkJu6/WG0hvBYgsPEt7W6VnQFpuZr
         60tDrpzxwBwxRler2wA4gBrnPirpIML3qzCIqIJ3QLEvwr6S6Y8TzRzD+iDnP8sa3bTF
         Q+lfqrJaWb2MsmWhAhuTALdB3KkNegIIZYvqEdDCQZcAzuvZes/334F6YX0yVS4rUFoK
         BZgr0VSHitHQ7Qu29yospiSekARXw0/R8N3vpNc0fjDGE/sZoBH35fIgj1ODEHPugSOn
         SOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSd5gPVojBlzvNpyMeb2R1VKJzJyuDMXVhtXWLcukSI1PhGoa8QgcuDxYF7Rc+TEAw8BIK6ywApnnV@vger.kernel.org, AJvYcCX1/LD3b3Gj3thWF8H9S2D7MEoi2GPUSfE5D6dEQNYPW6iej0+Mq1oFcuiJwOlCieF72tq7AMTOSnX2@vger.kernel.org, AJvYcCXyyQf20kAMI74G8NyM8YozvJTCGBuolkChN8zsbYmA1ZnISNyFI7KOrj8jbqHfP1G8GfvpLjcIohgBuo9j@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4LUJRMnQ7mA1JWvjicmSkh2bgatXFmLw7mm+eYGd2MZKagbvu
	A9nVtLsnpULRPg/NKDZ3n9r2OrteIGP3ohVF/8PohPkFFmWkRxElkJq4iBV4MT6ONbj8/Y0fqYj
	AmGp4I0UILyIo5wzcidZtS0gOGz0=
X-Gm-Gg: ASbGnctMkFmCcX7U/viSuapYmlXovuRmcuGRMb7VGIOTI6rcXsXQs/i1QhJjA0fHITI
	Wqw5AcKBJMVNgT0uITwm6z6S0aI0O+/Nzs2c/fQ==
X-Google-Smtp-Source: AGHT+IFXZK0uLrnVPvZOazyEcoVczU6YFWv+84oNq4z+ofBIWMkP7pxXq5dEiQFaIEvZ+ujr+vpGotVtAUfJVOGqZQY=
X-Received: by 2002:a05:690c:80a:b0:6f1:4f61:d0d1 with SMTP id
 00721157ae682-6f279ad9fa0mr27223637b3.2.1734255708057; Sun, 15 Dec 2024
 01:41:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213211909.40896-1-l.rubusch@gmail.com> <20241213211909.40896-2-l.rubusch@gmail.com>
 <20241214120227.56b885fa@jic23-huawei>
In-Reply-To: <20241214120227.56b885fa@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 15 Dec 2024 10:41:12 +0100
Message-ID: <CAFXKEHamiip3fVp1HNX4DZSzNnc7bMOQNg1RKsY45NbFymzr7g@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] iio: accel: adxl345: add function to switch
 measuring mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 1:02=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 13 Dec 2024 21:19:03 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Replace the powerup / powerdown functions by a generic function to put
> > the sensor in STANDBY, or MEASURE mode. When configuring the FIFO for
> > several features of the accelerometer, it is recommended to put
> > measuring in STANDBY mode.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Mostly in the interests of trimming down the queue of patches in flight
> and because this one has been fine for a few versions without significant
> comment.
>
> Applied this patch to the togreg branch of iio.git and pushed out initial=
ly
> as testing to let 0-day take a look.
>

Question here: you applied this patch now to the iio branch. Now,
Christophe Jaillet pointed still something out that could be improved,
the function could be shortened to, e.g.

+static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
+{
+     unsigned int val =3D en ? ADXL345_POWER_CTL_MEASURE :
ADXL345_POWER_CTL_STANDBY;
+
+     return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
+}

Should I present an improved patch? Or, in case this was urgent, would
it require an additional patch/fix? What would be the way to deal with
such fixes immediately after "applied"?

Best,
L

> Thanks
>
> Jonathan
>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 42 +++++++++++++++++++++++---------
> >  1 file changed, 30 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 88df9547b..b48bc838c 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -138,6 +138,34 @@ static int adxl345_write_raw_get_fmt(struct iio_de=
v *indio_dev,
> >       }
> >  }
> >
> > +/**
> > + * adxl345_set_measure_en() - Enable and disable measuring.
> > + *
> > + * @st: The device data.
> > + * @en: Enable measurements, else standby mode.
> > + *
> > + * For lowest power operation, standby mode can be used. In standby mo=
de,
> > + * current consumption is supposed to be reduced to 0.1uA (typical). I=
n this
> > + * mode no measurements are made. Placing the device into standby mode
> > + * preserves the contents of FIFO.
> > + *
> > + * Return: Returns 0 if successful, or a negative error value.
> > + */
> > +static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
> > +{
> > +     unsigned int val =3D 0;
> > +
> > +     val =3D (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STAN=
DBY;
> > +     return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> > +}
> > +
> > +static void adxl345_powerdown(void *ptr)
> > +{
> > +     struct adxl345_state *st =3D ptr;
> > +
> > +     adxl345_set_measure_en(st, false);
> > +}
> > +
> >  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> >  "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 10=
0 200 400 800 1600 3200"
> >  );
> > @@ -158,16 +186,6 @@ static const struct iio_info adxl345_info =3D {
> >       .write_raw_get_fmt      =3D adxl345_write_raw_get_fmt,
> >  };
> >
> > -static int adxl345_powerup(void *regmap)
> > -{
> > -     return regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_=
CTL_MEASURE);
> > -}
> > -
> > -static void adxl345_powerdown(void *regmap)
> > -{
> > -     regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STA=
NDBY);
> > -}
> > -
> >  /**
> >   * adxl345_core_probe() - Probe and setup for the accelerometer.
> >   * @dev:     Driver model representation of the device
> > @@ -237,11 +255,11 @@ int adxl345_core_probe(struct device *dev, struct=
 regmap *regmap,
> >                                    regval, ADXL345_DEVID);
> >
> >       /* Enable measurement mode */
> > -     ret =3D adxl345_powerup(st->regmap);
> > +     ret =3D adxl345_set_measure_en(st, true);
> >       if (ret < 0)
> >               return dev_err_probe(dev, ret, "Failed to enable measurem=
ent mode\n");
> >
> > -     ret =3D devm_add_action_or_reset(dev, adxl345_powerdown, st->regm=
ap);
> > +     ret =3D devm_add_action_or_reset(dev, adxl345_powerdown, st);
> >       if (ret < 0)
> >               return ret;
> >
>

