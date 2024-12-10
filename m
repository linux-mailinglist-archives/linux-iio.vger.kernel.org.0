Return-Path: <linux-iio+bounces-13298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5B09EA7F4
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 06:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F40166BF7
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 05:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2083822618F;
	Tue, 10 Dec 2024 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjBIyyFU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185BBA3D;
	Tue, 10 Dec 2024 05:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733809140; cv=none; b=aVdvlAMO9yUD8j3MziBvhK4ySMT3gd0B1crXoM9/ZCR78DvBc7tF9VE2/IOhYG5CJy54YeRPzVfuUuW0hXsIc9aOO62cJrE46oUM3eAd3GQO/CiIJkyb53broO/L76+//PW+tV8GBd/8A1nmwGIY/3jJYSq/Y2TTkoHMR5N8Uj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733809140; c=relaxed/simple;
	bh=+30GziBq91ZQdlbFsnb7myAMsNb+p5jhGWV+c7Fz+O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiiWrBKHDLG6YlQrtBZ95QotwuwiLAiEsCP9yhyQ2ZW0srZvRiorvWEqIHPCOtCs4S7dDbafv67GCELBf21wyEjkKNeM83Oh8osCB40S2VoOAAq62r7R08bk1ixfA57V1FWPGr6uApJfRTY3yTbLye7bzfzDwF4umEUbGUOYZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjBIyyFU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa69107179cso292304966b.0;
        Mon, 09 Dec 2024 21:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733809137; x=1734413937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0Sd2Zpia9p4I/P5QdOCIki3q8PzF5alQXfg+WQOIIw=;
        b=PjBIyyFUivFxgq0IcUtVXEgjpsu7rk7GiqrUtYvLhru0inxhSgn9qK1PwiCEteX6Fg
         q9nXQkZF43JtvsrvJE3mRKHy0QbYZXaMCn7FpAzu6jPXhMgTppUqqcFBTaGb+uHxA9Aa
         PIcoimoFhOpCGurFszQl82oD9L5HVlo4NMDjhynkG/CGViszYmLymvSNgYd3addGy6zt
         vSYQMAW+H90D+0IkTBEu2P2EaLK/O/GoeXUNPltD7RxP6CzueJ+lwLJ+cIpbUkqqA1rr
         8MSMOH0qkrIsQiRqlUlHKnczzYuRHp3ZrJeFZKv8bJbXCXoHEb7wrJLsXRxYs0utd1Gr
         B6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733809137; x=1734413937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0Sd2Zpia9p4I/P5QdOCIki3q8PzF5alQXfg+WQOIIw=;
        b=dmTHdAXKk9MCiJPT/a/E51eZz+cu6KxQ4D0OzPKIEuviUcVKCzJ1u5vpF9sTdecZ6c
         RGWvgyWxXv7AfoqvGMklK1jf28A+fQaMDlyP9X0HWLCKC8rv8iWdplm5vNRnj/ENgPLU
         Xa0XdvaxZJmOhlytBc9GnhaC1tjVIXvPJQ/cJgO/wRCAZgrpuSnux3hisolIXO+6PUe0
         u9AnaRD25YEAmEjv82zeu7flRIVzgM/PeOuM/1nsiH7YA9egvW7XPO4ku5rZggBdP4ew
         +gWJJjeKMOHM7cnl9XVfBbWAW/g0zJ+aTx4hFTDC6nW0Vjg7XEcpt8kkCOB9RR3g7DPO
         b+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUT/F1pTP+EFvmTqK4BW6IVoOYWfGG8lmhqFF77sl2WrpdeMT7Hs3C0DCeIwIrAuwKCXZN5XgCAJHJh@vger.kernel.org, AJvYcCUwkkFrf36t+IylxLvZE/zguBRfhn9ZVRRJ8d37byyrUkY33g5pvWXwqORongXyqCOhMgfOgnyh+iQI@vger.kernel.org, AJvYcCUwu2WuZvaaOCCd4mehE6V4tPoKQpbdcbwgCKLAYEa6ZKWmf140HcsJpgtuC6Io9f0zJC9hd96Vm/xCvaSB@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQFSd1ZItdRHRtnZsFEEOoiCjm2VVURg8JC8S6z9lgei1OuwS
	itgZld9Nlm/vjCT7RJYDpjQOZMCYV0/Zr1grxGUHh+7nM4xiFYs+caDnRHKLeGMKQHjlvI+z5wG
	rk0ns2h5K9wWUhBcE4pTpkoVpJumPhczFflI=
X-Gm-Gg: ASbGncsIVhmtL96dHm0ej8FHZ4sdIpJOTNupIL4p0bOqG6/6bHYjjt+4BXc+wr2qLzP
	tkkIRo/wxbDZnbOS0NyHwmc7c1WZTRzXjHw4=
X-Google-Smtp-Source: AGHT+IFWbXXbBezRYu2d1fSrlQAyQx6qXKQ3cBECIyITs7BFiWP0aspN3Q/SDYVvcQ/SU/o5GUBIsTMaCpt6LiptpYg=
X-Received: by 2002:a17:906:2922:b0:aa6:8edf:bca5 with SMTP id
 a640c23a62f3a-aa69cd4639dmr307534666b.19.1733809137091; Mon, 09 Dec 2024
 21:38:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-3-j2anfernee@gmail.com> <20241208172236.18441e64@jic23-huawei>
In-Reply-To: <20241208172236.18441e64@jic23-huawei>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Tue, 10 Dec 2024 13:38:20 +0800
Message-ID: <CA+4Vgc+veFb6hCP4A7mPH_uiUCnmbsa=guWySRekYj660osQyg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com, 
	andriy.shevchenko@linux.intel.com, marcelo.schmitt@analog.com, 
	olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com, 
	matteomartelli3@gmail.com, alisadariana@gmail.com, gstols@baylibre.com, 
	thomas.bonnefille@bootlin.com, ramona.nechita@analog.com, 
	mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jonathan Cameron,

Thanks for your comment.

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2024=E5=B9=B412=E6=9C=889=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=881:22=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue,  3 Dec 2024 17:15:40 +0800
> Eason Yang <j2anfernee@gmail.com> wrote:
>
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
> > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> Hi Eason,
>
> Given you have some good reviews already I only took a very quick glance
> through.  A few things inline
>
> Jonathan
>
> > diff --git a/drivers/iio/adc/nct720x.c b/drivers/iio/adc/nct720x.c
> > new file mode 100644
> > index 000000000000..b28b5f4d7d70
> > --- /dev/null
> > +++ b/drivers/iio/adc/nct720x.c
>
> > +
> > +static int nct720x_write_event_value(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir,
> > +                                  enum iio_event_info info,
> > +                                  int val, int val2)
> > +{
> > +     struct nct720x_chip_info *chip =3D iio_priv(indio_dev);
> > +     int index, err =3D 0;
> > +     long v1, v2, volt;
> > +
> > +     index =3D nct720x_chan_to_index[chan->address];
> > +     volt =3D (val * NCT720X_IN_SCALING_FACTOR) / NCT720X_IN_SCALING;
> > +     v1 =3D volt >> 5;
> > +     v2 =3D (volt & REG_VIN_LIMIT_LSB_MASK) << 3;
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (info =3D=3D IIO_EV_INFO_VALUE) {
> > +             if (dir =3D=3D IIO_EV_DIR_FALLING) {
> > +                     guard(mutex)(&chip->access_lock);
>
> Might as well move this up one level as it is called in both legs.
>

I would remove guard(mutex) up one level.

> > +                     err =3D regmap_write(chip->regmap, REG_VIN_LOW_LI=
MIT[index], v1);
> > +                     if (err < 0)
> > +                             dev_err(&indio_dev->dev, "Failed to write=
 REG_VIN%d_LOW_LIMIT\n",
> > +                                     index + 1);
> > +
> > +                     err =3D regmap_write(chip->regmap, REG_VIN_LOW_LI=
MIT_LSB[index], v2);
> > +                     if (err < 0)
> > +                             dev_err(&indio_dev->dev, "Failed to write=
 REG_VIN%d_LOW_LIMIT_LSB\n",
> > +                                     index + 1);
> > +
> > +             } else {
> > +                     guard(mutex)(&chip->access_lock);
> > +                     err =3D regmap_write(chip->regmap, REG_VIN_HIGH_L=
IMIT[index], v1);
> > +                     if (err < 0)
> > +                             dev_err(&indio_dev->dev, "Failed to write=
 REG_VIN%d_HIGH_LIMIT\n",
> > +                                     index + 1);
> > +
> > +                     err =3D regmap_write(chip->regmap, REG_VIN_HIGH_L=
IMIT_LSB[index], v2);
> > +                     if (err < 0)
> > +                             dev_err(&indio_dev->dev, "Failed to write=
 REG_VIN%d_HIGH_LIMIT_LSB\n",
> > +                                     index + 1);
> > +             }
> > +     }
> > +     return err;
> > +}
>
> > +
> > +static const struct iio_info nct720x_info =3D {
> > +     .read_raw =3D nct720x_read_raw,
> > +     .read_event_config =3D nct720x_read_event_config,
> > +     .write_event_config =3D nct720x_write_event_config,
> > +     .read_event_value =3D nct720x_read_event_value,
> > +     .write_event_value =3D nct720x_write_event_value,
>
> Given you are supporting with and without interrupts, should probably pic=
k between
> versions of this that have the event config part and one that doesn't.
>

Sorry, could you give some examples for us to refer.

> > +};
> > +
> > +static const struct nct720x_adc_model_data nct7201_model_data =3D {
> > +     .model_name =3D "nct7201",
> > +     .channels =3D nct7201_channels,
> > +     .num_channels =3D ARRAY_SIZE(nct7201_channels),
> > +     .vin_max =3D 8,
> > +};
> > +
> > +static const struct nct720x_adc_model_data nct7202_model_data =3D {
> > +     .model_name =3D "nct7202",
> > +     .channels =3D nct7202_channels,
> > +     .num_channels =3D ARRAY_SIZE(nct7202_channels),
> > +     .vin_max =3D 12,
> > +};
> > +
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
> > +     if (err < 0)
> > +             return err;
> > +     data[0] =3D (u8)value;
> > +
> > +     err  =3D regmap_read(chip->regmap, REG_CHANNEL_ENABLE_2, &value);
> > +     if (err < 0)
> > +             return err;
>
> Here I think you can use a bulk read as the registers are next to each ot=
her.
>

Generally, registers with 8 bits support Byte format, and registers
with more than 8 bits support Word format.
If transmission a Word command to a register that supports Byte
format, the second byte will get 0xFF.
Here, if we use regmap_bulk_read(), we would get first byte correct
and second byte is wrong 0xff.
I use i2ctransfer to demo it.
root@evb-npcm845:~# i2ctransfer -f -y 5 w1@0x1d 0x13 r1
0xff
root@evb-npcm845:~# i2ctransfer -f -y 5 w1@0x1d 0x14 r1
0x0f



> > +     data[1] =3D (u8)value;
> > +
> > +     value =3D get_unaligned_le16(data);
> > +     chip->vin_mask =3D value;
> > +
> > +     /* Start monitoring if needed */
> > +     err =3D regmap_read(chip->regmap, REG_CONFIGURATION, &value);
> > +     if (err < 0) {
> > +             dev_err(&chip->client->dev, "Failed to read REG_CONFIGURA=
TION\n");
> > +             return value;
> > +     }
> > +
> > +     value |=3D BIT_CONFIGURATION_START;
> > +     err =3D regmap_write(chip->regmap, REG_CONFIGURATION, value);
> > +     if (err < 0) {
> > +             dev_err(&chip->client->dev, "Failed to write REG_CONFIGUR=
ATION\n");
> > +             return err;
> > +     }
> > +
> > +     return 0;
> > +}

