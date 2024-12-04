Return-Path: <linux-iio+bounces-13070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AEB9E319B
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 03:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6739D286823
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 02:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCDC44C94;
	Wed,  4 Dec 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJevhHZa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71988A35;
	Wed,  4 Dec 2024 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280660; cv=none; b=UWLngxhKpkdurJNY0wYTpH2dwY1b0BHbYmFp3EdGGUd5yEVUxIpOJj0LKI5F0EjH83YvDPuiCaPouTQWhtJEP9vi25ueY4rEti8f9CiyjCdKIj2A21VDlZh+T91SohMUnDCBtedjcHwOHlzCk04v4DZ43ipasoHm1v7l17tdmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280660; c=relaxed/simple;
	bh=ORWjnGbYVHgyrcIbN3UUybC8lKHSO+0fpsMbhKLYt0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZHMdFF2bo8JRdQHIcTKW2mu/SnIDl5CVjz/ftXOYZEa9c3c0U8PTBmSCDmTZ8mbuIn4hlfUmrlCaeX7av7LibN0uM5amzO9NFPwYyB1EFS/J77v2tehpMHTCNqGRt15rkphzogKjaKHzzOTQhVFOAnragS6ZiHniKFDhc/e5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJevhHZa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso416721366b.2;
        Tue, 03 Dec 2024 18:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733280656; x=1733885456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Go1X/RYv0QTjpHuCtlSISS5YmqQc1fYAjKY83yYHEjw=;
        b=OJevhHZaLYo1SLyGhd6DtCa+ibKEG1K0fA6UaHQV/NDihjBlNUFQRvdHICymL4USoM
         PkZ6GHVsqLhvxCuVs9Uvww+4/nhKWDJVs+RvoOK15kS4tqO+58Gj8WixJ5gEKIZyRxgT
         78mZeRG3twY/mE5DdoSTXVkZkMGmcjfECa44NJ5U03XciwaZ/Lxl2+/aQ9jF8j8+ttha
         bmAwiLu4DhswnM/OQ0tJl82SsCqwZhgZM2R0nkRj8OxtAHtpB83xHcF4h1NwcJCkti/e
         v3uFJopJ3+FhnN3cKFtYY6dQ+W+Z3aLKKAoAXkoBovBAxe4NFcyDe/qrX8+/qqwM6l6z
         ohzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280656; x=1733885456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Go1X/RYv0QTjpHuCtlSISS5YmqQc1fYAjKY83yYHEjw=;
        b=BSYJVjMXhUg3z0/uPOT2kJKn+2gCgfWC8AH2Zxi14OxtVXJYCR1kFeP4LsDXkgndjF
         +FhunVSVUToCqlnmyZvnyGmFY3FSuIiOqPKnCJKYGRJP9Teeq4+Lslf2cPcphLD4F6vM
         aHhTqcAAVUAhlPiIyhEHgh33hTK76v81N855u2qyqOVqyYJBS4ASW2og4zW15Vr6AqLt
         a0XE2lGhaZWLxivuwxMsWdZf9EAC4FOmn/vrAgCVWKcDWkoV4PPGvcEVM4YG1BMKOYl3
         BIgVE0EX4SLNZC4aFqqEcAdoJRhOMiWHmOvhIokBwfctoL8Du3XGq1jSdKEKCck9EIPn
         hlYw==
X-Forwarded-Encrypted: i=1; AJvYcCVlJ98Al5Fh0Z10q77A2em1AXu4Ywo2+8RbKyNQ1QpwJ/oV8H9A04gCPe4ay4TaI8K0+OO5+lTe7x1/@vger.kernel.org, AJvYcCW0p94SS7SNENOP0wYLp+qan3ROEr9IpX0dzSnEIhVTHbER6pr9C7bv2Dw5fRUpcj8aLwaBkpfifA2jZgP6@vger.kernel.org, AJvYcCWuFY9ZFA2miKB1WCOkRed8wRR6hzvsnbdStfZ2he7ocrG43zSA5neia0YfrHga2aqYX0YsCsdu4Cps@vger.kernel.org
X-Gm-Message-State: AOJu0YxD0W/VpwEB813U4HtH5t2IMsv6sY7jQheZbw4h4W0EDFCsj/UA
	L8fq291UMF1BUgZor6epQMK/2TZBehjDWBYADy4g8sXXr5o3vFf6jNJ+4be9qLAD/Dw/dazup/T
	ga1PaXIwG6KFPWbsLtE+DT3lTdOU=
X-Gm-Gg: ASbGncvtxeBHFT6lMniOM6XopC5yzbBybo561ueaG9cpW09K2prSpqzQ/9sewkxOFHZ
	DYxjo9GgFznhXXJe/y+YMFehXwO3PQC0=
X-Google-Smtp-Source: AGHT+IHaLjMHmrrv+IFQa94ZMat+AU+eENz3ifiyI34SZkPqM7LtoN3ACTsdYRV5aIOVqAM4BxQ4tczaOrWKlBn4+io=
X-Received: by 2002:a17:906:31cd:b0:aa5:f39a:ae61 with SMTP id
 a640c23a62f3a-aa6018d88bbmr275896566b.48.1733280655218; Tue, 03 Dec 2024
 18:50:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106023916.440767-1-j2anfernee@gmail.com> <20241106023916.440767-3-j2anfernee@gmail.com>
 <20241109143714.70f68cd8@jic23-huawei>
In-Reply-To: <20241109143714.70f68cd8@jic23-huawei>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Wed, 4 Dec 2024 10:50:18 +0800
Message-ID: <CA+4VgcL8t9OW0u54zkh5+N=i0xAB9zv0Vs-m076UqyRt+Co9CA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: add Nuvoton NCT720x ADC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com, 
	andy@kernel.org, marcelo.schmitt@analog.com, olivier.moysan@foss.st.com, 
	mitrutzceclan@gmail.com, matteomartelli3@gmail.com, alisadariana@gmail.com, 
	joao.goncalves@toradex.com, marius.cristea@microchip.com, 
	mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jonathan Cameron,

Thank you for your comment.

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=889=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8810:37=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed,  6 Nov 2024 10:39:16 +0800
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
> You've gotten some good review already so I may well repeat stuff plus
> will only take a fairly superficial look at this version.
>
>
> > diff --git a/drivers/iio/adc/nct720x.c b/drivers/iio/adc/nct720x.c
> > new file mode 100644
> > index 000000000000..e589479fd06e
> > --- /dev/null
> > +++ b/drivers/iio/adc/nct720x.c
>
> > +
> > +/* List of supported devices */
> > +enum nct720x_chips {
> > +     nct7201, nct7202
> This should be replaced by chip specific information structures.
> That ends up a lot more extensible than using an enum and fixing up
> what happens in all code paths on a per enum value basis.
>

We would pass a pointer to the data structure not id to describe the
particular variant.

> > +};
> > +
> > +struct nct720x_chip_info {
> > +     struct i2c_client       *client;
> > +     enum nct720x_chips      type;
> > +     struct mutex            access_lock;    /* for multi-byte read an=
d write operations */
> > +     int vin_max;                            /* number of VIN channels=
 */
> > +     u32 vin_mask;
> > +     bool use_read_byte_vin;
> > +};
>
> > +#define NCT720X_VOLTAGE_CHANNEL(chan, addr)                          \
> > +     {                                                               \
> > +             .type =3D IIO_VOLTAGE,                                   =
 \
> > +             .indexed =3D 1,                                          =
 \
> > +             .channel =3D chan,                                       =
 \
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),    =
 \
> > +             .address =3D addr,                                       =
 \
> > +             .event_spec =3D nct720x_events,                          =
 \
> > +             .num_event_specs =3D ARRAY_SIZE(nct720x_events),         =
 \
> > +     }
> > +
> > +#define NCT720X_VOLTAGE_CHANNEL_DIFF(chan1, chan2, addr)             \
> > +     {                                                               \
> > +             .type =3D IIO_VOLTAGE,                                   =
 \
> > +             .indexed =3D 1,                                          =
 \
> > +             .channel =3D (chan1),                                    =
 \
> > +             .channel2 =3D (chan2),                                   =
 \
> > +             .differential =3D 1,                                     =
 \
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),    =
 \
> See below - should be _RAW and _SCALE not _PROCESSED.

We would use _RAW and _SCALE to instead of _PROCESSED.

> > +             .address =3D addr,                                       =
 \
> > +             .event_spec =3D nct720x_events,                          =
 \
> > +             .num_event_specs =3D ARRAY_SIZE(nct720x_events),         =
 \
> > +     }
> > +
> > +static const struct iio_chan_spec nct720x_channels[] =3D {
> > +     NCT720X_VOLTAGE_CHANNEL(1, 1),
> > +     NCT720X_VOLTAGE_CHANNEL(2, 2),
> > +     NCT720X_VOLTAGE_CHANNEL(3, 3),
> > +     NCT720X_VOLTAGE_CHANNEL(4, 4),
> > +     NCT720X_VOLTAGE_CHANNEL(5, 5),
> > +     NCT720X_VOLTAGE_CHANNEL(6, 6),
> > +     NCT720X_VOLTAGE_CHANNEL(7, 7),
> > +     NCT720X_VOLTAGE_CHANNEL(8, 8),
> > +     NCT720X_VOLTAGE_CHANNEL(9, 9),
> > +     NCT720X_VOLTAGE_CHANNEL(10, 10),
> > +     NCT720X_VOLTAGE_CHANNEL(11, 11),
> > +     NCT720X_VOLTAGE_CHANNEL(12, 12),
> > +     NCT720X_VOLTAGE_CHANNEL_DIFF(1, 2, 1),
> > +     NCT720X_VOLTAGE_CHANNEL_DIFF(3, 4, 3),
> > +     NCT720X_VOLTAGE_CHANNEL_DIFF(5, 6, 5),
> > +     NCT720X_VOLTAGE_CHANNEL_DIFF(7, 8, 7),
> > +     NCT720X_VOLTAGE_CHANNEL_DIFF(9, 10, 9),
> > +     NCT720X_VOLTAGE_CHANNEL_DIFF(11, 12, 11),
> > +};
> > +
> > +/* Read 1-byte register. Returns unsigned byte data or -ERRNO on error=
. */
> > +static int nct720x_read_reg(struct nct720x_chip_info *chip, u8 reg)
> > +{
> > +     struct i2c_client *client =3D chip->client;
> > +
> > +     return i2c_smbus_read_byte_data(client, reg);
> > +}
> > +
> > +/* Read 1-byte register. Returns unsigned word data or -ERRNO on error=
. */
> > +static int nct720x_read_word_swapped_reg(struct nct720x_chip_info *chi=
p, u8 reg)
> > +{
> > +     struct i2c_client *client =3D chip->client;
> > +
> > +     return i2c_smbus_read_word_swapped(client, reg);
>
> Don't provide these wrappers as they don't add anything useful.
> Make the calls directly inline.
>

We would remove this function and use regmap to instead of i2c API.

> > +}
> > +
> > +/*
> > + * Read 2-byte register. Returns register in big-endian format or
> > + * -ERRNO on error.
> > + */
> > +static int nct720x_read_reg16(struct nct720x_chip_info *chip, u8 reg)
> > +{
> > +     struct i2c_client *client =3D chip->client;
> > +     int ret, low;
> > +
> > +     mutex_lock(&chip->access_lock);
> guard()
>

Got it.

> > +     ret =3D i2c_smbus_read_byte_data(client, reg);
> > +     if (ret >=3D 0) {
> > +             low =3D ret;
> > +             ret =3D i2c_smbus_read_byte_data(client, reg + 1);
> > +             if (ret >=3D 0)
> > +                     ret =3D low | (ret << 8);
>                 if (ret < 0)
>                         return ret;
>
>                         reg =3D get_unaligned_le16()
> on an appropriate u8 data[2]; ideally filled by a bulk regmap read.
>
We would use regmap read.
>
> > +     }
> > +
> > +     mutex_unlock(&chip->access_lock);
> > +     return ret;
> > +}
> > +
> > +/* Write 1-byte register. Returns 0 or -ERRNO on error. */
> > +static int nct720x_write_reg(struct nct720x_chip_info *chip, u8 reg, u=
8 val)
> > +{
> > +     struct i2c_client *client =3D chip->client;
> > +     int err;
> > +
> > +     err =3D i2c_smbus_write_byte_data(client, reg, val);
> > +     /* wait for write command to be finished */
> If this is needed, provide a datasheet reference. It is very ususual to
> see a significant delay needed.

Chip RD do the simulation, we need  delay 25 msec in reset register
for registers ready to access.
And I2c write is not needed to delay.
These information would add into datasheet afterwards.

> > +     mdelay(10);
> > +
> > +     return err;
> > +}
> > +
> > +static int nct720x_read_raw(struct iio_dev *indio_dev,
> > +                         struct iio_chan_spec const *chan,
> > +                         int *val, int *val2, long mask)
> > +{
> > +     int index =3D nct720x_chan_to_index[chan->address];
> > +     int v1, v2, volt, err;
> > +     struct nct720x_chip_info *chip =3D iio_priv(indio_dev);
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_PROCESSED:
> > +             mutex_lock(&chip->access_lock);
> > +             if (chip->use_read_byte_vin) {
>
> Ah.  So resolution doesn't change, you are controlling the i2c acceses?
>
> That should come from the i2c controller capabilities, not DT for this
> device.
>
>
>
The use_read_byte_vin was discussed in dt-binding commit,
We would use read word first and remove read-vin-data-size property.

> > +                     /*
> > +                      * MNTVIN Low Byte together with MNTVIN High Byte
> > +                      * forms the 13-bit count value. If MNTVIN High
> > +                      * Byte readout is read successively, the
> > +                      * NCT7201/NCT7202 will latch the MNTVIN Low Byte
> > +                      * for next read.
> > +                      */
> > +                     v1 =3D nct720x_read_reg(chip, REG_VIN[index]);
> > +                     if (v1 < 0) {
> > +                             err =3D v1;
> > +                             goto abort;
> > +                     }
> > +
> > +                     v2 =3D nct720x_read_reg(chip, REG_VOLT_LOW_BYTE);
> > +                     if (v2 < 0) {
> > +                             err =3D v2;
> > +                             goto abort;
> > +                     }
> > +                     volt =3D (v1 << 8) | v2;  /* Convert back to 16-b=
it value */
> > +             } else {
> > +                     /* NCT7201/NCT7202 also supports read word-size d=
ata */
> > +                     volt =3D nct720x_read_word_swapped_reg(chip, REG_=
VIN[index]);
> > +             }
> > +
> > +             /* Voltage(V) =3D 13bitCountValue * 0.0004995 */
> Present this as _RAW and provide _SCALE to userspace to be able to do thi=
s
> maths.  Very unusual for an ADC driver to provided processed channels. No=
rmally
> only occurs it there is something non linear going on.

Yes, we would use _RAW and _SCALE to instead of _PROCESSED.
>
>
> > +             volt =3D (volt >> 3) * NCT720X_IN_SCALING;
> > +             *val =3D volt / 10000;
> > +             mutex_unlock(&chip->access_lock);
> > +             return IIO_VAL_INT;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +abort:
> > +     mutex_unlock(&chip->access_lock);
> > +     return err;
> > +}
> > +
> > +static int nct720x_read_event_value(struct iio_dev *indio_dev,
> > +                                 const struct iio_chan_spec *chan,
> > +                                 enum iio_event_type type,
> > +                                 enum iio_event_direction dir,
> > +                                 enum iio_event_info info,
> > +                                 int *val, int *val2)
> > +{
> > +     struct nct720x_chip_info *chip =3D iio_priv(indio_dev);
> > +     int v1, v2, err;
> > +     int volt =3D 0;
> > +     int index =3D nct720x_chan_to_index[chan->address];
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (info =3D=3D IIO_EV_INFO_VALUE) {
> As below - flip logic.
>
> > +             if (dir =3D=3D IIO_EV_DIR_FALLING) {
> > +                     if (chip->use_read_byte_vin) {
> > +                             /*
> > +                              * Low limit VIN Low Byte together with L=
ow limit VIN High Byte
> > +                                forms the 13-bit count value
> > +                              */
> > +                             mutex_lock(&chip->access_lock);
> > +                             v1 =3D nct720x_read_reg(chip, REG_VIN_LOW=
_LIMIT[index]);
> > +                             if (v1 < 0) {
> > +                                     err =3D v1;
> > +                                     goto abort;
> > +                             }
> > +
> > +                             v2 =3D nct720x_read_reg(chip, REG_VIN_LOW=
_LIMIT_LSB[index]);
> > +                             if (v2 < 0) {
> > +                                     err =3D v2;
> > +                                     goto abort;
> > +                             }
> > +                             mutex_unlock(&chip->access_lock);
> > +                             volt =3D (v1 << 8) | v2;  /* Convert back=
 to 16-bit value */
>
> rather see this as a get_unaligned_le16 on an array of u8.
> In some cases that ends up quite a bit cheaper and it also documents what=
 is going on.
>

We would use get_unaligned_le16 to convert the array of u8.

> > +                     } else {
> > +                             /* NCT7201/NCT7202 also supports read wor=
d-size data */
> > +                             volt =3D nct720x_read_word_swapped_reg(ch=
ip,
> > +                                     REG_VIN_LOW_LIMIT[index]);
> > +                     }
> > +             } else {
> > +                     if (chip->use_read_byte_vin) {
> > +                             /*
> > +                              * High limit VIN Low Byte together with =
high limit VIN High Byte
> > +                              * forms the 13-bit count value
> > +                              */
> > +                             mutex_lock(&chip->access_lock);
> > +                             v1 =3D nct720x_read_reg(chip, REG_VIN_HIG=
H_LIMIT[index]);
> > +                             if (v1 < 0) {
> > +                                     err =3D v1;
> > +                                     goto abort;
> > +                             }
> > +
> > +                             v2 =3D nct720x_read_reg(chip, REG_VIN_HIG=
H_LIMIT_LSB[index]);
> > +                             if (v2 < 0) {
> > +                                     err =3D v2;
> > +                                     goto abort;
> > +                             }
> > +                             mutex_unlock(&chip->access_lock);
> > +                             volt =3D (v1 << 8) | v2;  /* Convert back=
 to 16-bit value */
> > +                     } else {
> > +                             /* NCT7201/NCT7202 also supports read wor=
d-size data */
> > +                             volt =3D nct720x_read_word_swapped_reg(ch=
ip,
> > +                                     REG_VIN_HIGH_LIMIT[index]);
> > +                     }
> > +             }
> > +     }
> > +     /* Voltage(V) =3D 13bitCountValue * 0.0004995 */
> > +     volt =3D (volt >> 3) * NCT720X_IN_SCALING;
> > +     *val =3D volt / 10000;
> > +
> > +     return IIO_VAL_INT;
> > +abort:
> > +     mutex_unlock(&chip->access_lock);
> guard() in appropriate places.
> Again, the lock and unlock should ideally be in same scope.
>

We would put guard(mutex) in appropriate places.

> > +     return err;
> > +}
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
> > +     volt =3D (val * 10000) / NCT720X_IN_SCALING;
> > +     v1 =3D volt >> 5;
> > +     v2 =3D (volt & 0x1f) << 3;
> Some explanatory comments for this would be good.
>

/* Voltage(V) =3D 13bitCountValue * 0.0004995 */
volt =3D (val * NCT720X_IN_SCALING_FACTOR) / NCT720X_IN_SCALING;
v1 =3D volt >> 5;
v2 =3D (volt & REG_VIN_LIMIT_LSB_MASK) << 3;

> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (info =3D=3D IIO_EV_INFO_VALUE) {
> Flip logic.
>         if (info !=3D IIO_EV_INFO_VALUE)
>                 return -EINVAL;
>
>         if (dir =3D=3D IIO_EVE_DIR_FALLING) etc
>
> > +             if (dir =3D=3D IIO_EV_DIR_FALLING) {
> > +                     mutex_lock(&chip->access_lock);
> This is badly nested.  Mutex lock and unlock should be in same scope.
> So I'd pull mutex_lock() out of this if stack and use guard(mutex) instea=
d.
> That way you can just return on error.
>

We would put guard(mutex) in appropriate places.

> > +                     err =3D nct720x_write_reg(chip, REG_VIN_LOW_LIMIT=
[index], v1);
> > +                     if (err < 0) {
> > +                             pr_err("Failed to write REG_VIN%d_LOW_LIM=
IT\n", index + 1);
> > +                             goto abort;
> > +                     }
> > +
> > +                     err =3D nct720x_write_reg(chip, REG_VIN_LOW_LIMIT=
_LSB[index], v2);
> > +                     if (err < 0) {
> > +                             pr_err("Failed to write REG_VIN%d_LOW_LIM=
IT_LSB\n", index + 1);
> > +                             goto abort;
> > +                     }
> > +             } else {
> > +                     mutex_lock(&chip->access_lock);
> > +                     err =3D nct720x_write_reg(chip, REG_VIN_HIGH_LIMI=
T[index], v1);
> > +                     if (err < 0) {
> > +                             pr_err("Failed to write REG_VIN%d_HIGH_LI=
MIT\n", index + 1);
> > +                             goto abort;
> > +                     }
> > +
> > +                     err =3D nct720x_write_reg(chip, REG_VIN_HIGH_LIMI=
T_LSB[index], v2);
> > +                     if (err < 0) {
> > +                             pr_err("Failed to write REG_VIN%d_HIGH_LI=
MIT_LSB\n", index + 1);
> > +                             goto abort;
> > +                     }
> > +             }
> > +     }
> > +abort:
> > +     mutex_unlock(&chip->access_lock);
> > +     return err;
> > +}
>
> > +
> > +static int nct720x_write_event_config(struct iio_dev *indio_dev,
> > +                                   const struct iio_chan_spec *chan,
> > +                                   enum iio_event_type type,
> > +                                   enum iio_event_direction dir,
> > +                                   int state)
> > +{
> > +     int err =3D 0;
> > +     struct nct720x_chip_info *chip =3D iio_priv(indio_dev);
> > +     int index =3D nct720x_chan_to_index[chan->address];
> > +     unsigned int mask;
> > +
> > +     mask =3D BIT(index);
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (!state && (chip->vin_mask & mask))
> > +             chip->vin_mask &=3D ~mask;
> > +     else if (state && !(chip->vin_mask & mask))
> > +             chip->vin_mask |=3D mask;
> > +
> > +     mutex_lock(&chip->access_lock);
> guard(mutex)(&chip->access_lock);
>

We would put guard(mutex) in appropriate places.

> > +
> > +     err =3D nct720x_write_reg(chip, REG_CHANNEL_ENABLE_1, chip->vin_m=
ask & 0xff);
> > +     if (err < 0) {
> > +             pr_err("Failed to write REG_CHANNEL_ENABLE_1\n");
> > +             goto abort;
>                 dev_err()
>                 return err;
>
> > +     }
> > +
> > +     if (chip->type =3D=3D nct7202) {
>
> Gain, base this on a chip_info flag.
>
We would  pass a pointer to the data structure and not use chip->type anymo=
re.

> > +             err =3D nct720x_write_reg(chip, REG_CHANNEL_ENABLE_2, chi=
p->vin_mask >> 8);
> > +             if (err < 0) {
> > +                     pr_err("Failed to write REG_CHANNEL_ENABLE_2\n");
> > +                     goto abort;
> Same as above.

Use dev_err

> > +             }
> > +     }
> > +abort:
> > +     mutex_unlock(&chip->access_lock);
> > +     return err;
> > +}
> > +
> > +static int nct720x_detect(struct i2c_client *client,
> > +                       struct i2c_board_info *info)
> > +{
> > +     struct i2c_adapter *adapter =3D client->adapter;
> > +
> > +     if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> > +                                  I2C_FUNC_SMBUS_WORD_DATA))
> > +             return -ENODEV;
> > +
> > +     /* Determine the chip type. */
> > +     if (i2c_smbus_read_byte_data(client, REG_VENDOR_ID) !=3D NUVOTON_=
ID ||
> > +         i2c_smbus_read_byte_data(client, REG_CHIP_ID) !=3D NCT720X_ID=
 ||
> > +         i2c_smbus_read_byte_data(client, REG_DEVICE_ID) !=3D NCT720X_=
DEVICE_ID)
> > +             return -ENODEV;
> > +
> > +     strscpy(info->type, "nct720x", I2C_NAME_SIZE);
> as below. It's unusual to find a detect in an IIO driver because the firm=
ware
> normally tells us what is there.

We would  pass a pointer to the data structure to obtain the name  and
not use chip->type anymore.

> > +
> > +     return 0;
> > +}
> > +
> > +static const struct iio_info nct720x_info =3D {
> > +     .read_raw =3D &nct720x_read_raw,
> > +     .read_event_config =3D &nct720x_read_event_config,
> > +     .write_event_config =3D &nct720x_write_event_config,
> > +     .read_event_value =3D &nct720x_read_event_value,
> > +     .write_event_value =3D &nct720x_write_event_value,
> > +};
> > +
> > +static const struct i2c_device_id nct720x_id[];
> > +
> > +static int nct720x_init_chip(struct nct720x_chip_info *chip)
> > +{
> > +     int value =3D 0;
> > +     int err =3D 0;
> > +
> > +     /* Initial reset */
> Maybe ignore datasheet naming and call that CONFIGURATION_INIT CONFIGURAT=
ION_RESET
> at which point he comment is unneeded.
>

Understand  it.

> > +     err =3D nct720x_write_reg(chip, REG_CONFIGURATION, CONFIGURATION_=
INIT);
> > +     if (err) {
> > +             pr_err("Failed to write REG_CONFIGURATION\n");
> > +             return err;
> > +     }
> > +
> > +     /* Enable Channel */
> > +     err =3D nct720x_write_reg(chip, REG_CHANNEL_ENABLE_1, 0xff);
> What does 0xFF represent?  I guess all channels.  If so maybe need
> to build with GENMASK so it is obvious this is enabling 8 channels.
>

Use GENMASK(7, 0) and declare it.
#define  REG_CHANNEL_ENABLE_1_MASK GENMASK(7, 0)

> > +     if (err) {
> > +             pr_err("Failed to write REG_CHANNEL_ENABLE_1\n");
> > +             return err;
> > +     }
> > +
> > +     if (chip->type =3D=3D nct7202) {
>
> Make this 'data' in the chip_info structure.  Probably a flat to say
> there is a REG_CHANNEL_ENABLE_2.  That chip->type wants to go away infavo=
ur
> of chip->chip_info.X flags.
>
>

We would  pass a pointer to the data structure to describe the
particular variant.

> > +             err =3D nct720x_write_reg(chip, REG_CHANNEL_ENABLE_2, 0xf=
);
> > +             if (err) {
> > +                     pr_err("Failed to write REG_CHANNEL_ENABLE_2\n");
> > +                     return err;
> > +             }
> > +     }
> > +
> > +     value =3D nct720x_read_reg16(chip, REG_CHANNEL_ENABLE_1);
> > +     if (value < 0)
> > +             return value;
> > +     chip->vin_mask =3D value;
> > +
> > +     /* Start monitoring if needed */
> > +     value =3D nct720x_read_reg(chip, REG_CONFIGURATION);
>
> Using regmap would let you simple do a single bit write in one call
> Definitely look at whether there is anything stopping  you using that
> helpful infrastructure.
>

We take some effort to convert regmap API to instead of I2C API

> > +     if (value < 0) {
> > +             pr_err("Failed to read REG_CONFIGURATION\n");
> > +             return value;
> > +     }
> > +
> > +     value |=3D CONFIGURATION_START;
> > +     err =3D nct720x_write_reg(chip, REG_CONFIGURATION, value);
> > +     if (err < 0) {
> > +             pr_err("Failed to write REG_CONFIGURATION\n");
>
> dev_err() if not called only from probe, return dev_err_probe() if only c=
alled
> from probe()
>
>
Yes, use dev_err_probe() in probe function.

> > +             return err;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int nct720x_probe(struct i2c_client *client)
> > +{
> > +     const struct i2c_device_id *id =3D i2c_client_get_device_id(clien=
t);
> > +     struct nct720x_chip_info *chip;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
> > +     u32 tmp;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +     chip =3D iio_priv(indio_dev);
> > +
> > +     if (client->dev.of_node)
> > +             chip->type =3D (enum nct720x_chips)device_get_match_data(=
&client->dev);
> > +     else
> > +             chip->type =3D i2c_match_id(nct720x_id, client)->driver_d=
ata;
>
> i2c_get_match_data() but careful with zeros... It is much better to use t=
hat with
> an actual pointer.
>
>

We would pass a pointer to the data structure and i2c_get_match_data()
to get info

> > +
> > +     chip->vin_max =3D (chip->type =3D=3D nct7201) ? NCT7201_VIN_MAX :=
 NCT7202_VIN_MAX;
> > +
> > +     ret =3D of_property_read_u32(client->dev.of_node, "read-vin-data-=
size", &tmp);
> As in dt binding. If we keep this (I'm doubtful that it makes sense) defi=
ne a default
> so that the property doesn't need to be provided.  16 would be the most o=
bvious choice.
> Then just don't check the error value when reading the property. That is.
>
>         tmp =3D 16;
>         of_property_read_u32();
>
>
>

We already remove read-vin-data-size property and use word read for VIN dat=
a.

> > +     if (ret < 0) {
> > +             pr_err("read-vin-data-size property not found\n");
> > +             return ret;
> > +     }
> > +
> > +     if (tmp =3D=3D 8) {
> > +             chip->use_read_byte_vin =3D true;
> > +     } else if (tmp =3D=3D 16) {
> > +             chip->use_read_byte_vin =3D false;
> > +     } else {
> > +             pr_err("invalid read-vin-data-size (%d)\n", tmp);
> > +             return -EINVAL;
> > +     }
> > +
> > +     mutex_init(&chip->access_lock);
> For new code prefer
>         ret =3D devm_mutex_init()
>         if (ret)
>                 return ret;
>

Understand it.

> It only helps in weird debug cases but also costs us very little to suppo=
rt those.
> > +
> > +     /* this is only used for device removal purposes */
> > +     i2c_set_clientdata(client, indio_dev);
> Won't be needed after the change below.
>

Understand it.

> > +
> > +     chip->client =3D client;
> > +
> > +     ret =3D nct720x_init_chip(chip);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     indio_dev->name =3D id->name;
> Put the name in the chip_info structure.  id->name is a complex thing
> when other firmwares come into play, so better to just hard code the stri=
ngs
> somewhere so we always know what we are getting.
>

We would  pass a pointer to the data structure to obtain the name

> > +     indio_dev->channels =3D nct720x_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(nct720x_channels);
> > +     indio_dev->info =3D &nct720x_info;
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +     iio_device_register(indio_dev);
>         return devm_iio_device_register();
>
> Then you can drop the remove callback.
>

Understand it.

> > +
> > +     return 0;
> > +}
> > +
> > +static void nct720x_remove(struct i2c_client *client)
>
> Don't use wildcards even within the driver. Just name everything
> after one supported part.
> nct7202_remove() etc.
>
>

Remove the nct7202_remove()

> > +{
> > +     struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > +
> > +     iio_device_unregister(indio_dev);
> > +}
> > +
> > +static const unsigned short nct720x_address_list[] =3D {
> > +     0x1d, 0x1e, 0x35, 0x36, I2C_CLIENT_END
> > +};
> > +
> > +static const struct i2c_device_id nct720x_id[] =3D {
> > +     { "nct7201", nct7201 },
> > +     { "nct7202", nct7202 },
> > +     {}
>         { }
>
> I'm trying to slowly standardise on this formatting in IIO
> so keen not to introduce more cases.  It's an arbitrary choice
> but I went with the space.
>

Rewite the data structure as below,
static const struct nct720x_adc_model_data nct7201_model_data =3D {
.model_name =3D "nct7201",
.channels =3D nct7201_channels,
.num_channels =3D ARRAY_SIZE(nct7201_channels),
.vin_max =3D 8,
};

static const struct nct720x_adc_model_data nct7202_model_data =3D {
.model_name =3D "nct7202",
.channels =3D nct7202_channels,
.num_channels =3D ARRAY_SIZE(nct7202_channels),
.vin_max =3D 12,
};

static const struct i2c_device_id nct720x_id[] =3D {
{ "nct7201", (kernel_ulong_t)&nct7201_model_data },
{ "nct7202", (kernel_ulong_t)&nct7202_model_data },
{ }
};

> > +};
> > +MODULE_DEVICE_TABLE(i2c, nct720x_id);
> > +
> > +static const struct of_device_id nct720x_of_match[] =3D {
> > +     {
> > +             .compatible =3D "nuvoton,nct7201",
> > +             .data =3D (void *)nct7201
> > +     },
> > +     {
> > +             .compatible =3D "nuvoton,nct7202",
> > +             .data =3D (void *)nct7202
> Use a pointer to a chip_info structure with all the chip specific
> stuff encoded as data.  That is both more extensible and removes some
> ambiguities around whether zero is an error or not.
>

Rewrite as below,
static const struct of_device_id nct720x_of_match[] =3D {
{
.compatible =3D "nuvoton,nct7201",
.data =3D &nct7201_model_data,
},
{
.compatible =3D "nuvoton,nct7202",
.data =3D &nct7202_model_data,
},
{ }
};

> > +     },
> > +     { },
> No trailing comma

Understand it.

> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, nct720x_of_match);
> > +
> > +static struct i2c_driver nct720x_driver =3D {
> > +     .driver =3D {
> > +             .name   =3D "nct720x",
> > +             .of_match_table =3D nct720x_of_match,
> > +     },
> > +     .probe =3D nct720x_probe,
> > +     .remove =3D nct720x_remove,
> > +     .id_table =3D nct720x_id,
> > +     .detect =3D nct720x_detect,
>
> Do you need detect?  That's kind of ancient infrastructure that I thought
> no one used any more (same for the address list).
>

We would remove detect and address list.

> > +     .address_list =3D nct720x_address_list,
> > +};
> > +
> > +module_i2c_driver(nct720x_driver);
> > +
> > +MODULE_AUTHOR("Eason Yang <YHYANG2@nuvoton.com>");
> > +MODULE_DESCRIPTION("Nuvoton NCT720x voltage monitor driver");
> > +MODULE_LICENSE("GPL");
>

