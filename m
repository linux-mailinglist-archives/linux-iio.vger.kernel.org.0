Return-Path: <linux-iio+bounces-13929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA4CA020EA
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 09:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9887D7A27C3
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD0E1D88AC;
	Mon,  6 Jan 2025 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITQkVlwO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D21D7E4C;
	Mon,  6 Jan 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152464; cv=none; b=of9a7fgNKutZzdDXunGq5SKEk46EhNFHAmmETrVbrFDCQIFJpHe0JOYpP/u6gPUTc17+JKOYThIVwNo5ww3bvl4fXYSEYazcMimXSQtVgD+/Ux+3XKAN04Zv4DlGxREsNNxHcybOlS6e+XmdiB+HgPepPPC+9a1+W+VvzR6Y4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152464; c=relaxed/simple;
	bh=V0adRuLzZDrp/Ma7E0IgajjRnXjGmAPEmc6czEyzmWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYPAwHzgvENWQ+sOkQ/LiARGq7NnLLEn2QXcg9A5vg6XT2k+8CMrqZLckThdzqmtdGcGyUGmoUnnYOyGuE76uLQc9S+ikRoqyxoQ+rXJRWm95TRKx0WS7vpadFAjnVpfgy70Q4B0w/BPSj2aurKcyWOQs9Yc4LoHbvATDItknNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITQkVlwO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaeef97ff02so1703561566b.1;
        Mon, 06 Jan 2025 00:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736152459; x=1736757259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6Iqc+FrugHzndLCcnM8oV6bZ74gcy663YR8GYG/Rrs=;
        b=ITQkVlwOnVffCUxSsRE6aA2C6WJeHoEysDm2sObw43i9+1mWGrIiFnjz0Mh2iEJpim
         UM6VxbvOzyJcWKa9+nnWzkD9zIeJu5Thl/7wGR/SuzaB/vfvdZgd5O39GDY/+l/TiZG+
         ODhx80tnmQieFwoBXRJShkC3TAKikA0H5kzN4KGlEzAF1Y5VRLbVw4knApnLwZ/Xz9Pq
         J/tnDZYYIBpdthYd/rDqCOjsu/yiVmxDMnEnHqZ7SfpjFZxhvh2rgfgnY0FSGmIWzKcc
         nS70E4kadi04r6xaAXP90lEjfJUlf3wM+tt+17iEQ6SZYMCi6CZlR8EC/EeCzuzZ6pY6
         BsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736152459; x=1736757259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6Iqc+FrugHzndLCcnM8oV6bZ74gcy663YR8GYG/Rrs=;
        b=oL5ZUc8kLC/sMRfX1s4fInnabuApKXbK8FnT/R0tBbmg+cqoiu2/Q4CyIQ+lqI4bwg
         U31mEforbLwygtKhM+1h+Te/ixAzW/cvTN2GGpmh67JObFhRXHFQdjpXSbuI7E9NZFx8
         f1UZt+OC4gGn0lX35Qy450rR3MfwE1pCadMWpsr5waqV+I8cZicr2rAUHBSx6ix2nVnR
         YJLw1SE/viCMBUDaozXoKvvUcEQIJBfRvoMYOQoFE9qzmTFj8oZMD19Si5qEop+qEtwP
         jC54yS+B5D0/btvCmSe/SRcysyOSdpABqmqrFo8/aOZSphyA1sTfbIdbDn+KfEOLu+am
         FJJA==
X-Forwarded-Encrypted: i=1; AJvYcCU8vST1wxTSUhozWsKNHV/50jheT32i9hE+7CihVDmnKshvnCCbhbowf7nFhwUDXYX5EXNdjrrt8iuM/fHE@vger.kernel.org, AJvYcCVH4PhMOhON4jmfidye4yzGBXzGM7u3yL3ODoP+Kw+Nd+V+0QUB2oqLk5BEURlYBZ8XFb16GMxwEmEu@vger.kernel.org, AJvYcCVsmY90lKhKK/786kUg6GeUBd6Wl9y/OTPkwzA4X1r5uFxKOuh6nyyADdX8LZUgJrSU2b/pUnYU//KY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzagas7ZAoeF2Qg6AvCkdo5kF6sFtzj1lHqkswV5Q8TH/Ed0TqI
	C+bnQJy5N4uLre0Bjg0LSCkz5wR279oslRnU7BsSeUxycvE+Ppsw9udLX4fbOrEJn0r9LGck3YB
	4GfDyv230FJlB8EVTPSYseiFuerU=
X-Gm-Gg: ASbGnctc/jknwXcnuhfzk2rVQn33V6+likJwUNNkNu0abNwTjPK2L68OhFUATiLe5QD
	otI7a/dIvOBG3Q8l2UMsI5GsGRWyuDAEF/47qCQ==
X-Google-Smtp-Source: AGHT+IGp7BEDxRfRuegbN8MbOX/1vnSMSGgv/2tSy7FbVW1HLiJ0B96htNX1pHjWCg+E/mOQyFe0YrTM0d3KOGVo8zM=
X-Received: by 2002:a17:907:6ea6:b0:aa6:8bb4:503b with SMTP id
 a640c23a62f3a-aac345f3545mr5881487266b.55.1736152459190; Mon, 06 Jan 2025
 00:34:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226055313.2841977-1-j2anfernee@gmail.com>
 <20241226055313.2841977-3-j2anfernee@gmail.com> <Z26aMVayh-EdYA8n@smile.fi.intel.com>
In-Reply-To: <Z26aMVayh-EdYA8n@smile.fi.intel.com>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Mon, 6 Jan 2025 16:33:42 +0800
Message-ID: <CA+4VgcK4apNKWXhWvViPU6JfyXu9ZTQ7-TBauTaYUHnp0j1s-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: add Nuvoton NCT7201 ADC driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	javier.carrasco.cruz@gmail.com, marcelo.schmitt@analog.com, 
	olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com, 
	matteomartelli3@gmail.com, alisadariana@gmail.com, gstols@baylibre.com, 
	thomas.bonnefille@bootlin.com, herve.codina@bootlin.com, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Andy,

Thanks for your comments.

Andy Shevchenko <andriy.shevchenko@linux.intel.com> =E6=96=BC 2024=E5=B9=B4=
12=E6=9C=8827=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:14=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On Thu, Dec 26, 2024 at 01:53:13PM +0800, Eason Yang wrote:
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
>
> ...
>
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             err =3D regmap_read(chip->regmap16, NCT7201_REG_VIN(chan-=
>address), &value);
> > +             if (err < 0)
> > +                     return err;
> > +             volt =3D value;
>
> > +             *val =3D volt >> 3;
>
> I am not sure I understand this. If it's a shifted field, you rather
> should fix it by using FIELD_*() macros from bitfield.h, otherwise
> it's even more confusing.
>

+ #define NCT7201_REG_VIN_MASK                GENMASK(15, 3)

- *val =3D volt >> 3;
+ *val =3D FIELD_GET(NCT7201_REG_VIN_MASK, volt);

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
>
> ...
>
> > +     *val =3D volt >> 3;
>
> Ditto.
>
>
> ...
>
> > +     v1 =3D val >> 5;
> > +     v2 =3D FIELD_PREP(NCT7201_REG_VIN_LIMIT_LSB_MASK, val) << 3;
>
> Ditto.
>

The VIN reading supports Byte read (One Byte) and Word read (Two
Byte), the same as the VIN writing.
We don't need to separate 13-bit val into two bytes.
We can use 16-bit regmap to write val with right shift 3 bit to
replace write 8-bit regmap register twice.

> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (info =3D=3D IIO_EV_INFO_VALUE) {
> > +             guard(mutex)(&chip->access_lock);
> > +             if (dir =3D=3D IIO_EV_DIR_FALLING) {
> > +                     regmap_write(chip->regmap, NCT7201_REG_VIN_LOW_LI=
MIT(chan->address), v1);
> > +                     regmap_write(chip->regmap, NCT7201_REG_VIN_LOW_LI=
MIT_LSB(chan->address), v2);
> > +             } else {
> > +                     regmap_write(chip->regmap, NCT7201_REG_VIN_HIGH_L=
IMIT(chan->address), v1);
> > +                     regmap_write(chip->regmap, NCT7201_REG_VIN_HIGH_L=
IMIT_LSB(chan->address), v2);
> > +             }

    if (dir =3D=3D IIO_EV_DIR_FALLING)
-         regmap_write(chip->regmap,
NCT7201_REG_VIN_LOW_LIMIT(chan->address), v1);
-         regmap_write(chip->regmap,
NCT7201_REG_VIN_LOW_LIMIT_LSB(chan->address), v2);
+        regmap_write(chip->regmap16,
NCT7201_REG_VIN_LOW_LIMIT(chan->address),
FIELD_PREP(NCT7201_REG_VIN_MASK, val));
    else
-         regmap_write(chip->regmap,
NCT7201_REG_VIN_HIGH_LIMIT(chan->address), v1);
-         regmap_write(chip->regmap,
NCT7201_REG_VIN_HIGH_LIMIT_LSB(chan->address), v2);
+        regmap_write(chip->regmap16,
NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
FIELD_PREP(NCT7201_REG_VIN_MASK, val));

>
> This needs a comment why regmap_bulk_write() can't be used.
>

We can't use regmap_bulk_write() since the chip limit.
regmap_bulk_write(chip->regmap, ..., ..., 2) ,
the first byte is well written, but the second byte don't changed.

> > +     }
>
> ...
>
> > +static int nct7201_init_chip(struct nct7201_chip_info *chip)
> > +{
> > +     u8 data[2];
> > +     unsigned int value;
> > +     int err;
> > +
> > +     regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
> > +                  NCT7201_BIT_CONFIGURATION_RESET);
>
> No error check?
>

As David Lechner mentioned,
Better would be `return dev_err_probe()`. But it is very rare for
regmap_write() to fail so usually we don't print an error message
for these.

So we would remove print an error message for all remap_write.

> > +     /*
> > +      * After about 25 msecs, the device should be ready and then
> > +      * the Power Up bit will be set to 1. If not, wait for it.
> > +      */
> > +     mdelay(25);
> > +     err =3D regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value=
);
> > +     if (err < 0)
> > +             return err;
> > +     if (!(value & NCT7201_BIT_PWR_UP))
> > +             return dev_err_probe(&chip->client->dev, -EIO, "failed to=
 power up after reset\n");
> > +
> > +     /* Enable Channel */
> > +     guard(mutex)(&chip->access_lock);
> > +     regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> > +                  NCT7201_REG_CHANNEL_ENABLE_1_MASK);
> > +     if (chip->num_vin_channels =3D=3D 12)
> > +             regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_2,
> > +                          NCT7201_REG_CHANNEL_ENABLE_2_MASK);
> > +
> > +     err =3D regmap_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1, &=
value);
> > +     if (err < 0)
> > +             return err;
> > +     data[0] =3D value;
> > +
> > +     err =3D regmap_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_2, &=
value);
> > +     if (err < 0)
> > +             return err;
> > +     data[1] =3D value;
> > +
> > +     value =3D get_unaligned_le16(data);
> > +     chip->vin_mask =3D value;
> > +
> > +     /* Start monitoring if needed */
> > +     err =3D regmap_read(chip->regmap, NCT7201_REG_CONFIGURATION, &val=
ue);
> > +     if (err < 0) {
>
> > +             dev_err_probe(&chip->client->dev, -EIO, "Failed to read R=
EG_CONFIGURATION\n");
> > +             return value;
>
> You already used
>
>         return dev_err_probe(...);
>
> above, why here it's different? You want return something in addition to =
the
> error code? Why?
>

It should use
return dev_err_probe(&chip->client->dev, -EIO, "Failed to read
REG_CONFIGURATION\n");

> > +     }
> > +
> > +     value |=3D NCT7201_BIT_CONFIGURATION_START;
> > +     regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION, value);
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +static const struct regmap_config nct7201_regmap8_config =3D {
> > +     .name =3D "vin-data-read-byte",
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D 0xff,
> > +};
> > +
> > +static const struct regmap_config nct7201_regmap16_config =3D {
> > +     .name =3D "vin-data-read-word",
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 16,
> > +     .max_register =3D 0xff,
> > +};
>
> I don't see how these configurations will prevent, e.g., debugfs to acces=
s
> 16-bit registers via 8-bit IO and vice versa.
>

Read VIN info can use word read or byte read, and other registers
should use byte read.

The design is that VIN info registers are used 16-bit debugfs to access and
other registers are used 8-bit debugfs to access.

We need to probe 8-bit regmap and 16-bit regmap,
but I have no idea how to prevent 8-bit IO to access 16-bit registers
and vice versa.

> --
> With Best Regards,
> Andy Shevchenko
>
>

