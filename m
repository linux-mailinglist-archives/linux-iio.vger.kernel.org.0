Return-Path: <linux-iio+bounces-13299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F96B9EA818
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 06:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F6F167C7B
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 05:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED0226163;
	Tue, 10 Dec 2024 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCmIVSvm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8581A94D;
	Tue, 10 Dec 2024 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733809685; cv=none; b=sYecn/7vmLUYavAawY1JVjbWd6i50cWz1sqD0n+Vj4unOswkbAU2aGTsD4g2+ZN0tqOHrM0Sf+2W5rldTuzi+PSAQh3hCwHXuRxfoc9DcbVsSJkv8Wluk8k3KMtNgQT2kVUKXvUqeM2p1t7TtS25bRei3zLNEkyhy9SAPBTS4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733809685; c=relaxed/simple;
	bh=GdY5CD5D2SCO3qQkEnX2c2ffr2BYL2Wrg8YzEaZsqdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAbeoIr4+zAXItDo1Up82cgZ59b+UqC0fFr1cZNHpH77Ck27HH++MLaUmsycqNAHAyikAT7Nugvi0Mf9MMrMTarA83r2SMM6QlM1YkyUJYC1jbYzdPf6FIcxIqhwD9lSGCkguMd3ux1rb6jX4HseUo4jDm5Ul31Rks7kNK+JtP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCmIVSvm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa69107179cso293319466b.0;
        Mon, 09 Dec 2024 21:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733809682; x=1734414482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4226V4dvsflUch3sPAntJSiBKK05yf29rkTyIJUYaiA=;
        b=LCmIVSvm2bYZh2+7HYsShkreKdeZmERai502sgVTeJmQyHEkbmhCAj2KWkrTCybD25
         y3ftO5ktmZ28CVcmey4L/ri9Gu58+n2LsCuQRl6kiH8P17IUxdA1KqiVnM0/t/hCRmss
         AwXaB+9g5WnDVahOAIFF1oWvNJZsJu+es+L1N6+2kn4gaW3kCagy2guNMR1QAfnqpd0U
         N3kPQN1xI4g7UwAc5yfU74WiGsC3e8SdqAh/yqc8fr6iNXlEJqLoDprYlBdhKGE7++zD
         dzpBGF1WnGYlEjXblpbXQan1G/PqDtJTB4rkjdEZHybu6FwJdB1H9FcKvb+IjT0vs+Vz
         8nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733809682; x=1734414482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4226V4dvsflUch3sPAntJSiBKK05yf29rkTyIJUYaiA=;
        b=EHg34hLrelNO9yi2TCJYkn1cjV4vKkpX/vCexJukkteqJFFNwdlKZtoRKhcdz9EiRB
         4ofrTJsK9buonF8JHZLhz8iA0WezX+apS+3gD446nKIQ70Fl2MEzIoetFxSuWCA9Ij5j
         wi01gY6+koxUL1It1zqJyjT2NP6D6U7r58aNNv+tBT8Wc78rqXqbxSmSK1JKu4PnvC5H
         6wWQk6sVzErlwe1i/ZWfmGoIlVHMhTKfalHROcMEtrV+ux06YuoIxqoChZfcKT/djxXU
         Aes+l0t7RG+4252MZe4kTvcBoWwb6C6k1oN44mUWYskmqoS+t3CryMxQbiQhz2DgqBqY
         Zw1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPNx+TJ7BA7xFKCYxCY48Njt9+5Hs55qnSv2mmocc4IR5ZWQCOnIXDciBBOm8XWG2Z6vaYUD6jp7bMxh4V@vger.kernel.org, AJvYcCVQSYoUEnEmc8tbLW/LKBI94AgFPxkQRZBbkzwYbDo5Xm2TZFsMbp42yQmmgrI5NgwtFrBjsSrAWfh/@vger.kernel.org, AJvYcCVW3BxdkHTOhp6RoBMPd7u7hI5vMtt/4MsK2qirSDttsHzQ2Q2/CQkitTkfX3Sc91PvcW6I1q7cFDpd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53URymgyQ5Ddp+jPp9VgfeuCeO/Bqi3xst1JOT25yhwZbkBXx
	qxX7+CYNqW2wO7FUkwOg/a6RmVQ/63itDOXvEklgm58g5tSiUd9MusiaC0sh3vZUaHtx057ReRv
	TTUd3vaP7heSlFk/REDSyvxxyQGA=
X-Gm-Gg: ASbGncujLvW6DzdBuAXDONSGudb8cfUcAKoKqLx9acaDoy/GZtnWK0niEwXvxeclXqP
	1W59I5vjsSRiDSRRKM+YHq/6++NqNDUO3clY=
X-Google-Smtp-Source: AGHT+IFCOSybOJKaSFqqrUKS7MOG9TiOm1tfqYGtieeRYvY2auzWawwNhq6nCddmGluDJ7XdTOEY8uMx0vXqWO9xfAs=
X-Received: by 2002:a17:906:2189:b0:aa6:4eab:872d with SMTP id
 a640c23a62f3a-aa69cd5dca3mr280418766b.34.1733809681782; Mon, 09 Dec 2024
 21:48:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-3-j2anfernee@gmail.com> <20241208172236.18441e64@jic23-huawei>
 <CA+4Vgc+veFb6hCP4A7mPH_uiUCnmbsa=guWySRekYj660osQyg@mail.gmail.com>
In-Reply-To: <CA+4Vgc+veFb6hCP4A7mPH_uiUCnmbsa=guWySRekYj660osQyg@mail.gmail.com>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Tue, 10 Dec 2024 13:47:25 +0800
Message-ID: <CA+4VgcLDQrTcTFjr7MYGtMYpqhzm0gym=zzkt33JGRHFkCXGVg@mail.gmail.com>
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

Sorry the above mail is not finished and just sent it.
I would explain why we can't use bulk read sequential bytes in our chips.

Yu-Hsian Yang <j2anfernee@gmail.com> =E6=96=BC 2024=E5=B9=B412=E6=9C=8810=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=881:38=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Dear Jonathan Cameron,
>
> Thanks for your comment.
>
> Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2024=E5=B9=B412=E6=9C=889=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=881:22=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Tue,  3 Dec 2024 17:15:40 +0800
> > Eason Yang <j2anfernee@gmail.com> wrote:
> >
> > > Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> > >
> > > NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and u=
p to
> > > 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins =
for
> > > independent alarm signals, and the all threshold values could be set =
for
> > > system protection without any timing delay. It also supports reset in=
put
> > > RSTIN# to recover system from a fault condition.
> > >
> > > Currently, only single-edge mode conversion and threshold events supp=
ort.
> > >
> > > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> > Hi Eason,
> >
> > Given you have some good reviews already I only took a very quick glanc=
e
> > through.  A few things inline
> >
> > Jonathan
> >
> > > diff --git a/drivers/iio/adc/nct720x.c b/drivers/iio/adc/nct720x.c
> > > new file mode 100644
> > > index 000000000000..b28b5f4d7d70
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/nct720x.c
> >
> > > +
> > > +static int nct720x_write_event_value(struct iio_dev *indio_dev,
> > > +                                  const struct iio_chan_spec *chan,
> > > +                                  enum iio_event_type type,
> > > +                                  enum iio_event_direction dir,
> > > +                                  enum iio_event_info info,
> > > +                                  int val, int val2)
> > > +{
> > > +     struct nct720x_chip_info *chip =3D iio_priv(indio_dev);
> > > +     int index, err =3D 0;
> > > +     long v1, v2, volt;
> > > +
> > > +     index =3D nct720x_chan_to_index[chan->address];
> > > +     volt =3D (val * NCT720X_IN_SCALING_FACTOR) / NCT720X_IN_SCALING=
;
> > > +     v1 =3D volt >> 5;
> > > +     v2 =3D (volt & REG_VIN_LIMIT_LSB_MASK) << 3;
> > > +
> > > +     if (chan->type !=3D IIO_VOLTAGE)
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     if (info =3D=3D IIO_EV_INFO_VALUE) {
> > > +             if (dir =3D=3D IIO_EV_DIR_FALLING) {
> > > +                     guard(mutex)(&chip->access_lock);
> >
> > Might as well move this up one level as it is called in both legs.
> >
>
> I would remove guard(mutex) up one level.
>
> > > +                     err =3D regmap_write(chip->regmap, REG_VIN_LOW_=
LIMIT[index], v1);
> > > +                     if (err < 0)
> > > +                             dev_err(&indio_dev->dev, "Failed to wri=
te REG_VIN%d_LOW_LIMIT\n",
> > > +                                     index + 1);
> > > +
> > > +                     err =3D regmap_write(chip->regmap, REG_VIN_LOW_=
LIMIT_LSB[index], v2);
> > > +                     if (err < 0)
> > > +                             dev_err(&indio_dev->dev, "Failed to wri=
te REG_VIN%d_LOW_LIMIT_LSB\n",
> > > +                                     index + 1);
> > > +
> > > +             } else {
> > > +                     guard(mutex)(&chip->access_lock);
> > > +                     err =3D regmap_write(chip->regmap, REG_VIN_HIGH=
_LIMIT[index], v1);
> > > +                     if (err < 0)
> > > +                             dev_err(&indio_dev->dev, "Failed to wri=
te REG_VIN%d_HIGH_LIMIT\n",
> > > +                                     index + 1);
> > > +
> > > +                     err =3D regmap_write(chip->regmap, REG_VIN_HIGH=
_LIMIT_LSB[index], v2);
> > > +                     if (err < 0)
> > > +                             dev_err(&indio_dev->dev, "Failed to wri=
te REG_VIN%d_HIGH_LIMIT_LSB\n",
> > > +                                     index + 1);
> > > +             }
> > > +     }
> > > +     return err;
> > > +}
> >
> > > +
> > > +static const struct iio_info nct720x_info =3D {
> > > +     .read_raw =3D nct720x_read_raw,
> > > +     .read_event_config =3D nct720x_read_event_config,
> > > +     .write_event_config =3D nct720x_write_event_config,
> > > +     .read_event_value =3D nct720x_read_event_value,
> > > +     .write_event_value =3D nct720x_write_event_value,
> >
> > Given you are supporting with and without interrupts, should probably p=
ick between
> > versions of this that have the event config part and one that doesn't.
> >
>
> Sorry, could you give some examples for us to refer.
>
> > > +};
> > > +
> > > +static const struct nct720x_adc_model_data nct7201_model_data =3D {
> > > +     .model_name =3D "nct7201",
> > > +     .channels =3D nct7201_channels,
> > > +     .num_channels =3D ARRAY_SIZE(nct7201_channels),
> > > +     .vin_max =3D 8,
> > > +};
> > > +
> > > +static const struct nct720x_adc_model_data nct7202_model_data =3D {
> > > +     .model_name =3D "nct7202",
> > > +     .channels =3D nct7202_channels,
> > > +     .num_channels =3D ARRAY_SIZE(nct7202_channels),
> > > +     .vin_max =3D 12,
> > > +};
> > > +
> > > +static int nct720x_init_chip(struct nct720x_chip_info *chip)
> > > +{
> > > +     u8 data[2];
> > > +     unsigned int value;
> > > +     int err;
> > > +
> > > +     err =3D regmap_write(chip->regmap, REG_CONFIGURATION, BIT_CONFI=
GURATION_RESET);
> > > +     if (err) {
> > > +             dev_err(&chip->client->dev, "Failed to write REG_CONFIG=
URATION\n");
> > > +             return err;
> > > +     }
> > > +
> > > +     /*
> > > +      * After about 25 msecs, the device should be ready and then
> > > +      * the Power Up bit will be set to 1. If not, wait for it.
> > > +      */
> > > +     mdelay(25);
> > > +     err  =3D regmap_read(chip->regmap, REG_BUSY_STATUS, &value);
> > > +     if (err < 0)
> > > +             return err;
> > > +     if (!(value & BIT_PWR_UP))
> > > +             return err;
> > > +
> > > +     /* Enable Channel */
> > > +     err =3D regmap_write(chip->regmap, REG_CHANNEL_ENABLE_1, REG_CH=
ANNEL_ENABLE_1_MASK);
> > > +     if (err) {
> > > +             dev_err(&chip->client->dev, "Failed to write REG_CHANNE=
L_ENABLE_1\n");
> > > +             return err;
> > > +     }
> > > +
> > > +     if (chip->vin_max =3D=3D 12) {
> > > +             err =3D regmap_write(chip->regmap, REG_CHANNEL_ENABLE_2=
, REG_CHANNEL_ENABLE_2_MASK);
> > > +             if (err) {
> > > +                     dev_err(&chip->client->dev, "Failed to write RE=
G_CHANNEL_ENABLE_2\n");
> > > +                     return err;
> > > +             }
> > > +     }
> > > +
> > > +     guard(mutex)(&chip->access_lock);
> > > +     err  =3D regmap_read(chip->regmap, REG_CHANNEL_ENABLE_1, &value=
);
> > > +     if (err < 0)
> > > +             return err;
> > > +     data[0] =3D (u8)value;
> > > +
> > > +     err  =3D regmap_read(chip->regmap, REG_CHANNEL_ENABLE_2, &value=
);
> > > +     if (err < 0)
> > > +             return err;
> >
> > Here I think you can use a bulk read as the registers are next to each =
other.
> >
>
Generally, registers with 8 bits support Byte format, and registers
with more than 8 bits support Word format.
If transmission a Word command to a register that supports Byte
format, the second byte will get 0xFF.
Here, if we use regmap_bulk_read(), we would get first byte correct
and second byte is wrong 0xff.

I use i2ctransfer command to demo it.
root@evb-npcm845:~# i2ctransfer -f -y 5 w1@0x1d 0x13 r1
0xff
root@evb-npcm845:~# i2ctransfer -f -y 5 w1@0x1d 0x14 r1
0x0f

root@evb-npcm845:~# i2ctransfer -f -y 5 w1@0x1d 0x13 r2
0xff 0xff
And if we read four bytes, you can see the first and third byte as we wante=
d.
root@evb-npcm845:~# i2ctransfer -f -y 5 w1@0x1d 0x13 r4
0xff 0xff 0x0f 0xff

so we can't use bulk read directly since it would get a second byte 0xff.
The safe method is to  use read byte twice.

>
> > > +     data[1] =3D (u8)value;
> > > +
> > > +     value =3D get_unaligned_le16(data);
> > > +     chip->vin_mask =3D value;
> > > +
> > > +     /* Start monitoring if needed */
> > > +     err =3D regmap_read(chip->regmap, REG_CONFIGURATION, &value);
> > > +     if (err < 0) {
> > > +             dev_err(&chip->client->dev, "Failed to read REG_CONFIGU=
RATION\n");
> > > +             return value;
> > > +     }
> > > +
> > > +     value |=3D BIT_CONFIGURATION_START;
> > > +     err =3D regmap_write(chip->regmap, REG_CONFIGURATION, value);
> > > +     if (err < 0) {
> > > +             dev_err(&chip->client->dev, "Failed to write REG_CONFIG=
URATION\n");
> > > +             return err;
> > > +     }
> > > +
> > > +     return 0;
> > > +}

