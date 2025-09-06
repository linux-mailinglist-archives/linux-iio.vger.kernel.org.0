Return-Path: <linux-iio+bounces-23825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B71AB46A38
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 10:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA927A789C
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 08:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429B286D78;
	Sat,  6 Sep 2025 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axHZB+Lh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3BF21255E;
	Sat,  6 Sep 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757148026; cv=none; b=V6JjI2YmTbMiV6DJp3cGeGHwMq5SotUYgYtY3dRXB+YF7EIZ+qhdgPmmK9jmdcqJ2plEv5rrwRTY+zYkWog0B5ggYJwlKbXS4eHr+5wdDbC/9oirPRO2YyDAdgMcegCIJAtyeBuRi8vkOrGBG9fwgakuGidZUVAnG6OgKT/fQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757148026; c=relaxed/simple;
	bh=b133S+TwQlLip+QPEs/eWM0e0o3T8ZFTgF1KFEdexSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJTg2y2xgmLPaSD1jQiOBUl3T3euLOAXIwTagVPFU6gDns6K7P/Q/x5e7oC3dNfBcQ5Es/QrFovuPN364OUMmulRPhbOCiAES5snS8rkfZYHp1O5TZTssDIHRqr2YC8CCQhH9D0M3hIRIffQVh0XmM2+p7D7s7egEN1jTuuq1tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axHZB+Lh; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-31d6e39817fso3657918fac.3;
        Sat, 06 Sep 2025 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757148024; x=1757752824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6zcrkB9U6/000QLKETBKflXNAKeQYo2+KvMj3l626w=;
        b=axHZB+LhwE7X1uT9hjk3CZAxUl6It+2i5/ZLjtK3vzOXlxgOEyCdY/1bWkbx2IXmdv
         lmmcI1o3EK3eBZu8Fu4q1E/hQIJjMJXMEQKzUcOuVwH/XGstK3qOoRFAkfzvv68HirCC
         gTF+3zxUCXbydywFD+VhBCf7ROfg83LPM1E6KECDG/32lEGxDdEYATudsD1GnKW5YiAz
         /0nWRZuG2SMN7yNsLue56J2iJAe4SyrCfCpfIIdhFjZuQ1gNxJG5yf0cvXR8lqlcw1Hg
         ZvyOxi4dmQUzviviOzQctUMbg45ezxDrqhP03lnY7xOsOBr/ar6gFSnvqybpFgAop5jl
         Z7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757148024; x=1757752824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6zcrkB9U6/000QLKETBKflXNAKeQYo2+KvMj3l626w=;
        b=o/iYgfPNiNfsEc+DhPRgJO3Y7dXwshdZrnzn6wmms2KoyeN2pxDN4vw6edHXwRbNUK
         Qy+FGi5Ovmkk2GsrhiYSrn8FY9a13mQ488WXExGarMYnm3fwqQLdgA4ZLbwHCmz6JjDK
         3bSV9G/nLD8III8yzTOaHOFxHp87pjvpSufvpFs1OJQKPJLYw0k3luuUbkjm9hcaqM4Z
         1cMxgCZT+LqXZB2mq/RejPpi9jpLx9feGvxs4MqDlcN2SIA+eBxYAYB+aXwE8WVIpOLt
         JTYQybIoWWyT6ejW0f+Zo1xnKLe2JANw2VZ4UIa/M1vQIndlmbe4SHccHKX5kYjR6b+A
         rgBA==
X-Forwarded-Encrypted: i=1; AJvYcCUC7p5JZ8lv7OlPHcKegVxurQsGUeo6/HleKDTz0qB19ZM1odvnxP4Qg/XMaNgRelEGuvIY+lJeuy625ijH@vger.kernel.org, AJvYcCWbJemvjwQ2Y/TJJVAX6wuDK1IW79IIpNYeUPy9KrKxw8aDJ2KSdKr5lmP7msls7tOkfEqHDoWmbyC4@vger.kernel.org, AJvYcCWt4/6g9JDul/TAIRO46hlVxTqR8/88JFu1f+B1vElJcEOaY9fkxm7RUUn/Pja5nkgexR2R/bl8OBk6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/GlZ1OnNdJRRoWy1/FYgXq8sxKo4zabP8r9SO/DfGEfdGXBp2
	PgVYRehsqtjfK5B1/wUFEcq345ifFuR+X82mQAjB5ov1QaVsS795hhC55NX3E/5y525F7DRrcUi
	QA0h9RdVUcl5RaGReA4/WGT6Y6WCUekI=
X-Gm-Gg: ASbGncsA9eXs3xc8Zx2KGaOklFDaIWJOwOFmn2Ywcnjk+y8hkmPh5DodugvU22GIjeq
	nDxVmnZ8jr1vAv0+5H/GwtcXpPrd+e7QEenhhme8r0oblno0jgAEnodtR96Su2DeZF+NE7e4lav
	Z1ipQ4NXob2WsgE5rYA1ixeEcDyVnVG6HGQ6JlOHRwS+Sj9+P7W6cMEpTWvnc3NvRmsWTq07yql
	AyM0Xegjg5AkbmfdNOMHd5jbjfbTCYV8oEsmaEa8g==
X-Google-Smtp-Source: AGHT+IFnRo64RN6JfeTb4PlycS4ttFmvS9oDsGoS1p8XclqswoX1FwICEsLKXBD7hVtDpBWBAxfvfyy0F/1jo7BVqr0=
X-Received: by 2002:a05:6870:700a:b0:296:5928:7a42 with SMTP id
 586e51a60fabf-322632a26d4mr675281fac.22.1757148023694; Sat, 06 Sep 2025
 01:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-tlv493d-sensor-v6_16-rc5-v5-0-746e73bc6c11@gmail.com>
 <20250829-tlv493d-sensor-v6_16-rc5-v5-1-746e73bc6c11@gmail.com> <20250830171905.28274239@jic23-huawei>
In-Reply-To: <20250830171905.28274239@jic23-huawei>
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Sat, 6 Sep 2025 14:10:12 +0530
X-Gm-Features: Ac12FXxklNeQ5wHOT7hCe99VcGtR4voIenZ27B3f9mlJZY2nNurJS2--KoPOw2M
Message-ID: <CAFmh=S13Rg26u6pQvZPzcmVmV+2ALgWB19h3WYMPArWcUq5_AA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the clarification and review David and Jonathan. I have
covered the inputs in v6 and floated.

On Sat, Aug 30, 2025 at 9:49=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 29 Aug 2025 08:23:42 +0530
> Dixit Parmar <dixitparmar19@gmail.com> wrote:
>
> > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> > applications includes joysticks, control elements (white goods,
> > multifunction knops), or electric meters (anti tampering) and any
> > other application that requires accurate angular measurements at
> > low power consumptions.
> >
> > The Sensor is configured over I2C, and as part of Sensor measurement
> > data it provides 3-Axis magnetic fields and temperature core measuremen=
t.
> >
> > The driver supports raw value read and buffered input via external trig=
ger
> > to allow streaming values with the same sensing timestamp.
> >
> > While the sensor has an interrupt pin multiplexed with an I2C SCL pin.
> > But for bus configurations interrupt(INT) is not recommended, unless ti=
ming
> > constraints between I2C data transfers and interrupt pulses are monitor=
ed
> > and aligned.
> >
> > The Sensor's I2C register map and mode information is described in prod=
uct
> > User Manual [1].
> >
> > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/i=
nfineon-tlv493d-a1b6-datasheet-en.pdf
> > Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-U=
serManual-v01_03-EN.pdf [1]
> > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
>
> Hi Dixit,
>
> A few trivial formatting related things inline.  I'd just have tweaked th=
ese
> whilst applying but we need to have a v6 for the dt-binding/maintainers s=
tuff
> anyway so please tidy these up as well.
>
> Thanks,
>
> Jonathan
>
>
> > diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetomet=
er/Makefile
> > index 9297723a97d8..dfe970fcacb8 100644
> > --- a/drivers/iio/magnetometer/Makefile
> > +++ b/drivers/iio/magnetometer/Makefile
> > @@ -23,6 +23,8 @@ st_magn-$(CONFIG_IIO_BUFFER) +=3D st_magn_buffer.o
> >  obj-$(CONFIG_IIO_ST_MAGN_I2C_3AXIS) +=3D st_magn_i2c.o
> >  obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) +=3D st_magn_spi.o
> >
> > +obj-$(CONFIG_INFINEON_TLV493D)               +=3D tlv493d.o
> > +
> >  obj-$(CONFIG_SENSORS_HMC5843)                +=3D hmc5843_core.o
> >  obj-$(CONFIG_SENSORS_HMC5843_I2C)    +=3D hmc5843_i2c.o
> >  obj-$(CONFIG_SENSORS_HMC5843_SPI)    +=3D hmc5843_spi.o
> > diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetome=
ter/tlv493d.c
> > new file mode 100644
> > index 000000000000..b723eaac1d9e
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/tlv493d.c
> > @@ -0,0 +1,533 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/**
>
> This isn't kernel doc format. Headers descriptions like this normally are=
n't
> so /* not /** is appropriate. I haven't checked but I'd expect the kernel=
-doc
> script to have warned about that if run on this file
>
> > + * Driver for the Infineon TLV493D Low-Power 3D Magnetic Sensor
> > + *
> > + * Copyright (C) 2025 Dixit Parmar <dixitparmar19@gmail.com>
> > + */
> > +/*
> > + * Different mode has different measurement sampling time, this time i=
s
> > + * used in deriving the sleep and timeout while reading the data from
> > + * sensor in polling.
> > + * Power-down mode: No measurement.
> > + * Fast mode: Freq:3.3 KHz. Measurement time:305 usec.
> > + * Low-power mode: Freq:100 Hz. Measurement time:10 msec.
> > + * Ultra low-power mode: Freq:10 Hz. Measurement time:100 msec.
> > + * Master controlled mode: Freq:3.3 Khz. Measurement time:305 usec.
> > + */
> > +static const u32 tlv493d_sample_rate_us[] =3D {
> > +     [TLV493D_OP_MODE_POWERDOWN] =3D 0,
> > +     [TLV493D_OP_MODE_FAST] =3D 305,
> > +     [TLV493D_OP_MODE_LOWPOWER] =3D 10 * USEC_PER_MSEC,
> > +     [TLV493D_OP_MODE_ULTRA_LOWPOWER] =3D 100 * USEC_PER_MSEC,
> > +     [TLV493D_OP_MODE_MASTERCONTROLLED] =3D 305,
> > +};
> > +
> > +static int tlv493d_write_all_regs(struct tlv493d_data *data)
> > +{
> > +     int ret;
> > +     struct device *dev =3D &data->client->dev;
> > +
> > +     ret =3D i2c_master_send(data->client, data->wr_regs, ARRAY_SIZE(d=
ata->wr_regs));
> > +     if (ret < 0) {
> > +             dev_err(dev, "i2c write registers failed, error: %d\n", r=
et);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
>
>
> > +static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *x,=
 s16 *y,
> > +                                 s16 *z, s16 *t)
> > +{
> > +     u8 buff[7] =3D {};
> > +     int err, ret;
> > +     struct device *dev =3D &data->client->dev;
> > +     u32 sleep_us =3D tlv493d_sample_rate_us[data->mode];
> > +
> > +     guard(mutex)(&data->lock);
> > +
> > +     ret =3D pm_runtime_resume_and_get(dev);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /*
> > +      * Poll until data is valid,
>
> . rather than , given next line is a new sentence.
>
> > +      * For a valid data TLV493D_TEMP_CHANNEL bit of TLV493D_RD_REG_TE=
MP
> > +      * should be set to 0. The sampling time depends on the sensor mo=
de.
> > +      * Poll 3x the time of the sampling time.
> > +      */
> > +     ret =3D read_poll_timeout(i2c_master_recv, err,
> > +                     err || !FIELD_GET(TLV493D_TEMP_CHANNEL,
> > +                     buff[TLV493D_RD_REG_TEMP]),
>
> If you are going to split the FIELD_GET between parameters you must
> align the second line of parameters after the (  otherwise this is
> unnecessarily hard to read.
>
>         ret =3D read_poll_timeout(i2c_master_recv, err,
>                 err || !FIELD_GET(TLV493D_TEMP_CHANNEL, buff[TLV493D_RD_R=
EG_TEMP]),
>                 sleep_us, 3 * sleep_us, false, data->client, buff,
>                 ARRAY_SIZE(buff));
>
> Is a better way to format this.  Once we aren't aligning with the opening
> bracket of read_poll_timeout because of the very long line, a single tab =
of
> indent of the second line is enough.  Don't worry about going a little ov=
er 80 chars
> here as it really hurts readability to split that FIELD_PREP() up.
>
>
> > +     if (ret) {
> > +             dev_err(dev, "i2c read poll timeout, error:%d\n", ret);
> > +             goto out_put_autosuspend;
> > +     }
> > +     if (err < 0) {
> > +             dev_err(dev, "i2c read data failed, error:%d\n", err);
> > +             ret =3D err;
> > +             goto out_put_autosuspend;
> > +     }
> > +
> > +     *x =3D tlv493d_get_channel_data(buff, TLV493D_AXIS_X);
> > +     *y =3D tlv493d_get_channel_data(buff, TLV493D_AXIS_Y);
> > +     *z =3D tlv493d_get_channel_data(buff, TLV493D_AXIS_Z);
> > +     *t =3D tlv493d_get_channel_data(buff, TLV493D_TEMPERATURE);
> > +
> > +out_put_autosuspend:
> > +     pm_runtime_put_autosuspend(dev);
> > +     return ret;
> > +}
>
>
> > +static int tlv493d_read_raw(struct iio_dev *indio_dev,
> > +                     const struct iio_chan_spec *chan, int *val,
> > +                     int *val2, long mask)
> > +{
> > +     struct tlv493d_data *data =3D iio_priv(indio_dev);
> > +     s16 x, y, z, t;
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret =3D tlv493d_get_measurements(data, &x, &y, &z, &t);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             /* Return raw values for requested channel */
>
> Not return in the C meaning of it, and that comment doesn't
> really add anything, so I'd just drop it.
>
> > +             switch (chan->address) {
> > +             case TLV493D_AXIS_X:
> > +                     *val =3D x;
> > +                     return IIO_VAL_INT;
> > +             case TLV493D_AXIS_Y:
> > +                     *val =3D y;
> > +                     return IIO_VAL_INT;
> > +             case TLV493D_AXIS_Z:
> > +                     *val =3D z;
> > +                     return IIO_VAL_INT;
> > +             case TLV493D_TEMPERATURE:
> > +                     *val =3D t;
> > +                     return IIO_VAL_INT;
> > +             default:
> > +                     return -EINVAL;
> > +             }
>
>
> > +static int tlv493d_probe(struct i2c_client *client)
> > +{
>
> > +     indio_dev->info =3D &tlv493d_info;
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->name =3D client->name;
> > +     indio_dev->channels =3D tlv493d_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(tlv493d_channels);
> > +     indio_dev->available_scan_masks =3D tlv493d_scan_masks;
> > +
> > +     ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> > +                             iio_pollfunc_store_time,
> > +                             tlv493d_trigger_handler,
> > +                             NULL);
>
> If you align later lines of parameters with the start of the 1st
> paramater, e.g. after the ( then this is still under 80 chars.
>
> Given that is generally the preferred style where possible (in IIO
> anyway) please do that here.
>
> Jonathan

