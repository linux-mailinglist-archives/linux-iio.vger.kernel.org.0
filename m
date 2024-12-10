Return-Path: <linux-iio+bounces-13316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F319EB8A7
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 18:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9414F281FBF
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E5A1F2385;
	Tue, 10 Dec 2024 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly8mDFP4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E31B4220;
	Tue, 10 Dec 2024 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853024; cv=none; b=bW5f8KVIHCxfBMH0/30WUlUfUckFHu5LQO4q6ovPKcJhyhhYMs5RvWMB+ZjyT6PAqocTv2XZg+72vY6+lsne1w6seFJOidm7C1U5/wRLU7XweyhPJlpolRTEZ6HvevAtTL3cgHUQTtKy0IyfOLlcl6ZIBnaiveEDfyC6r1Lpr80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853024; c=relaxed/simple;
	bh=7vTkwIQXZT5QT9ZHSuseGV3gEM9zZq4Sz/Phju4nRyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnoXLbiJXRXWO4ZC1qYzkES28bCByxYwQQa04ZHDXoLcezKDiQEsnTsc7zuTAlqHQa60Dr1Mihp8r8xocj2G6PU8FjzcuTnBmFqtcTBMa3W11WhmQ1CYX1SZNVFJ3/HJ8f6lq+/a22QLJCM3CQQl/6ARXASbIX+yeo94hQJBIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly8mDFP4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ef95ad9064so2539117b3.2;
        Tue, 10 Dec 2024 09:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733853021; x=1734457821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLbWVKTQ8/rFg0yCwbeNU+FV507QZWBZJPr5pJawDUw=;
        b=Ly8mDFP4Yf70FOF/O3HfbaWwlgYhqb941NSR4ayeD42zcRezYDVMUmslfIOKGDt4YH
         ebSLGmpBzkhAyJRAslvsv4MnW9aQjxtajYjSfK8jwu4b6ZfkLmHfCeP4FGeTzeIV6skq
         0GphJQYoeDyWGcDJoKy/mcoEQs7nfNy84ROz0VRbBPgHoczVdz0SWYMAsm4pGJN9m8Ex
         bSxeaiUswCO5NT3sEa2ukrJkEC5vk1WJWqK+dvLH4lPfDTffIpU/nZc2Ns4jCIaAtIRG
         CxSfNBQl5eQHsJ2V+Tlm4oMrgMxGy/Z9UqJ80P3nIz9o6fli7/NjX36ttDVTSeC2D6C4
         lrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853021; x=1734457821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLbWVKTQ8/rFg0yCwbeNU+FV507QZWBZJPr5pJawDUw=;
        b=pKa7hs2THMza86rFWf65sZjVIiM4PWzXFWODxsTFyrpnV3kFcLB+RC8t6y+I5QjXiB
         +8v0xNGfjUO+f2CDd0Fmwn4V+zDmEzPoy/5/EqtGIaSvpiW5kRbPK2jXvKbpf+EvP62Y
         2BvSxIQ7y/2J4Piu0mqEFdjK4LCRvNPa8UwZ6z0dZDgxyDAo7X5S0UsFDRgqNv/sIqxJ
         kTZQ+TIhpsSjs0eRpJwAUqGnmMhvReCSoIoIZy5znj/WLAI+V8k4RrjITM0hSXejNzOR
         2iT47bhmoEr+cI5lVblMV9wajS2sPEWL5+dRtkr9B6XffU0v6wkeCDVq2GAqFRg9OEMe
         WiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnrZugrSOJwzH7asJbjE3DCId1IfsL7j3DxUZ80xi4qrwGwP2CkOVIJTvqB85OWA7chVeEpAokqr2A@vger.kernel.org, AJvYcCVzbRKj9Lh//hHqRvJWGbgv1+irIUM2OomsC4HgjEWmT1/PQrJWy0ReVd2qhGsxKvToxbm2/WMy2g+t@vger.kernel.org, AJvYcCWn31XxAdF57KPPosrAzjQESznJ0ittywSQjNWLsa73KXvYqVK1R323BeMShCx3gIez/MFSs3pF9FW9jtG8@vger.kernel.org
X-Gm-Message-State: AOJu0YytXvgUdzgV82JUt+3ThwmY022x2/3T3tWpQ1VDqUhstmXijqLk
	kqQP03CoebVbp0C8cFrFS0Vg+ltx9r+Pj17xVm85CKEOm16/zaQ7OLEoVmDkflqYvvEdBR/PecW
	x4EQC7qGBrtWzk9bAmbDCnRzxuyY=
X-Gm-Gg: ASbGncugn+mkUB+NpYtg2b3gsM7OygZzGUGM0lPgE5Tc/uYpXMKoSG5y9W216yzW4Sg
	KIgLBqSZRgEA9ccIUjoQ68c11XQ03RmsTX8U=
X-Google-Smtp-Source: AGHT+IF/9mYG/lYevIKCWOwIf4rXGPYEsSstWyTBvNb9hulsYECN5/TsyPzeRBtUOX0YyFWqxkRoLjcWWqoDs3JRNUw=
X-Received: by 2002:a05:690c:3505:b0:6ef:5754:49e5 with SMTP id
 00721157ae682-6f147f6aab0mr283697b3.2.1733853021569; Tue, 10 Dec 2024
 09:50:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205171343.308963-1-l.rubusch@gmail.com> <20241205171343.308963-5-l.rubusch@gmail.com>
 <20241208134220.0a8b84f5@jic23-huawei>
In-Reply-To: <20241208134220.0a8b84f5@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 10 Dec 2024 18:49:45 +0100
Message-ID: <CAFXKEHY4LWm9iJnZ---Zixf9GT6u_Ebk-=sDsrqTjGSR4KCM2g@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] iio: accel: adxl345: add function to switch
 measuring mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 2:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu,  5 Dec 2024 17:13:37 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Replace the powerup / powerdown functions by a generic function to put
> > the sensor in STANDBY, or MEASURE mode. When configuring the FIFO for
> > several features of the accelerometer, it is recommended to put
> > measuring in STANDBY mode.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Hi Lothar,
>
> One trivial comment inline.
>
> Jonathan
>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 44 ++++++++++++++++++++++----------
> >  1 file changed, 31 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 98ff37271f1..1d020b0d79c 100644
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
> > @@ -236,13 +254,13 @@ int adxl345_core_probe(struct device *dev, struct=
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
> > -             return ret;
> > +             return dev_err_probe(dev, ret, "Failed to add action or r=
eset\n");
> You will never see that message, though arguably that's an implementation=
 detail.
>
> The only error that devm_add_action_or_reset() returns is -ENOMEM;
> dev_err_probe() doesn't print on -ENOMEM because enough screaming occurs =
at
> other layers.
>
> I normally don't bother commenting on this one if it's introduced as one =
of
> many messages, but here you are adding just this one so I have commented.

Thank you so much. I highly appreciate all the time you spend on
reviewing and giving
feedback!! For me there is no hurry with this driver. I'd prefer to go
a bit more picky
feedback, according to your patience. Hopefully, I will learn for
future patches. Already
when I take a look on the way from v1 of just this driver. Awesome!

>
> >
> >       return devm_iio_device_register(dev, indio_dev);
> >  }
>

