Return-Path: <linux-iio+bounces-22409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C87EB1DE92
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 22:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A9174927
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 20:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3FF236A8B;
	Thu,  7 Aug 2025 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I77duRBP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC31FDD;
	Thu,  7 Aug 2025 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600277; cv=none; b=RZUvE2dTe5Dc84tSEutkYkUnu3ARJswyx5eUU0Jl6nTjPQQSlbxf5VY+mJIiMbSz5B3uzqB/qsYFzZ9W8M3/zW67Av4jetVGJcUDMiILHwKXp10AVdegI1UumT6k9X4yqnI2VjqN/B9kgs3NR65jG65+5DTGioPpoAGs9cmlBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600277; c=relaxed/simple;
	bh=kFntyPq0cN3CI+Xpu6OpDtjtOs3WJznk29JJdkTyCig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdQJJ4HytMcErkNl71VJPqkVuY6vwp2gS8vip00C/XBch3BjQ+MwhoEojjeVFT8AKffsenyP6VjR4T6ehRTU0QgPZVHWltuBo2wGDmHC2Z8UeLb8twx/HwQmoFLCU5JCMd+p2ogj00SXVgxlLW6zMhtQB0i3r76AwGVHxIojRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I77duRBP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af968aa2de4so283974266b.1;
        Thu, 07 Aug 2025 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754600274; x=1755205074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glSeLZ1T641GhR6eubMihAIYJ30XvQrSaCL7IFv3rF4=;
        b=I77duRBPNHk/hxBTyOqSGOuXTJ6Ww/zBGAGwbtYzv4VNvgdHmRdHvREStkG7GgyIaa
         vHWOajJ5YdHhtEz5wWJllbipFLdKFlzturWBtG3r9d7lZxP5TMUKrcWohW54nogFptrg
         TDNz6imwMtyFOBf/M7QJqdCdTFVof3QVTWp8CKBRUfoEpMq+Kl41kHD6PHv0Vo+4QIzg
         l8gdqxFW7owZNV7kwCoci3yFDhGySe1HcQJLRb+Jal3qLnAFc8ys7krpj0S6QlJDORrb
         XKWeNetK7nIvB6fWJ0/HCn6/1sQZ5gwa/BUq2G/zvUu+sf2X3NtShfLkWJmlVlWxCtX3
         6VNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754600274; x=1755205074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glSeLZ1T641GhR6eubMihAIYJ30XvQrSaCL7IFv3rF4=;
        b=pTGLbZAn0bpYAaxVViys/Jsg58of94Bu60ayemSZoB7vZMrdmeHwiITEF4T94AMMgA
         GioXaT90fapOSwNyAdSl6+aRIVC3cUbpIvcrwyHT/fOxeo8QLWxikoLkJO89VcmV6Xxv
         FCqIj9tOCN73yZoRKjfrApBpo7XWm0lGoMVwRSCyftyyruePCU8GCwYveRANUyGmXjLb
         1AWqZHlHMNq5Jqy9kzvjLBg1kFxyKuWz7rv8bhgomKTr48B7/OtWfyBVIxSVP41GVAvb
         vSPdt2DBCwKj6Nx3aRTBvsno7JA0FFitrO7QCQ2z0f7RmLVlHdS5fGWgCLcAZPacZJQ9
         YzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXPNcci8i/FGArY4XAEwzVgEXsBCALwHpPkf+3JhmzVa6S2WSwuR9/jC64IvuC2ziTWubComCupRkM@vger.kernel.org, AJvYcCX5td2hBb/L0mtnivgnpOmRda06yp9KVn7l0w06jbhJMz1TBnqaUfgY4HjovtyxGd06UJs4wp2T1Bki@vger.kernel.org, AJvYcCXBFISr6g7fIEMC/6q4ftcz2FcYA64yx0zRlNVthGzPqCBO2HNxBNEp7B3srRaw3+XKRQwrV6sj3NhFicBd@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIph/MnYdp4zY3IBLl6YBAc0xmQqxX85919KZHoMlhqinXz/z
	IUtPRr9wUTFwpIGl7J58cEjUbPfRSsT7Za4k498AeFkXKExcjjjH19gHGAkONUiSUs6ZBpAL6NR
	sRnMTvioTkgDE60Vq7S0E4kZzX34OMtg=
X-Gm-Gg: ASbGncsLpRqM1A7yfJjJp/EpSrqSJn9WQDXqW8AcB7bZ4oDpcTNwhtR6Cp1dYejDR4Y
	idkP9oDMDKHnrHc3c0aXSBpbWYcReGMCY5rRb2wzBe1ETmVtlW9CroyQV0eQHMlHBf4iCnatEAl
	lDEG1BCfp2CEqxMeR4rmbT4TQooj+nHUnipbJbF2ArcfjZgdjtG4s9e5k1QGjiQ9P8aO0nYm7R8
	67RbuBWceoGrzufBWughIoj8oxRN5YmY5wYxeLZlw==
X-Google-Smtp-Source: AGHT+IFoAOXCDV1q45wJf+trPVAmwc616p+yc8qDSsN/Cv4UN+rh9HhQy67+VFobtn905rsyRTZziniOTe7XTTO/HfI=
X-Received: by 2002:a17:906:730a:b0:af9:c31c:eeca with SMTP id
 a640c23a62f3a-af9c6546458mr33381566b.48.1754600273666; Thu, 07 Aug 2025
 13:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com> <20250807-tlv493d-sensor-v6_16-rc5-v3-1-b80d2cb41232@gmail.com>
In-Reply-To: <20250807-tlv493d-sensor-v6_16-rc5-v3-1-b80d2cb41232@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 22:57:16 +0200
X-Gm-Features: Ac12FXwmEWjXXavhCNgyK3y3_Ob3LyDo4AU76VvPTkplTx8sWFIjz0wYfOS55oQ
Message-ID: <CAHp75VeKPr=3H_wOvcesqj4OsrqN7zwRFFk3ys3O012JpQtxrQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 4:57=E2=80=AFAM Dixit Parmar <dixitparmar19@gmail.co=
m> wrote:
>
> The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> applications includes joysticks, control elements (white goods,
> multifunction knops), or electric meters (anti tampering) and any
> other application that requires accurate angular measurements at
> low power consumptions.
>
> The Sensor is configured over I2C, and as part of Sensor measurement
> data it provides 3-Axis magnetic fields and temperature core measurement.
>
> The driver supports raw value read and buffered input via external trigge=
r
> to allow streaming values with the same sensing timestamp.
>
> While the sensor has an interrupt pin multiplexed with an I2C SCL pin.
> But for bus configurations interrupt(INT) is not recommended, unless timi=
ng
> constraints between I2C data transfers and interrupt pulses are monitored
> and aligned.
>
> The Sensor's I2C register map and mode information is described in produc=
t
> User Manual [1].

...

> +       help
> +         Say Y here to add support for the Infineon TLV493D-A1B6 Low-
> +         Power 3D Megnetic Sensor.

Megnetic?

> +         This driver can also be compiled as a module.
> +         To compile this driver as a module, choose M here: the module
> +         will be called tlv493d.

...

> +#define TLV493D_RD_REG_BX      0x00
> +#define TLV493D_RD_REG_BY      0x01
> +#define TLV493D_RD_REG_BZ      0x02
> +#define TLV493D_RD_REG_TEMP    0x03
> +#define TLV493D_RD_REG_BX2     0x04
> +#define TLV493D_RD_REG_BZ2     0x05
> +#define TLV493D_RD_REG_TEMP2   0x06
> +#define TLV493D_RD_REG_RES1    0x07
> +#define TLV493D_RD_REG_RES2    0x08
> +#define TLV493D_RD_REG_RES3    0x09
> +#define TLV493D_RD_REG_MAX     0x0a

+ blank line

> +#define TLV493D_WR_REG_RES     0x00

I would name it _RES0 in analogue with the _RES2 below.

> +#define TLV493D_WR_REG_MODE1   0x01
> +#define TLV493D_WR_REG_RES2    0x02
> +#define TLV493D_WR_REG_MODE2   0x03
> +#define TLV493D_WR_REG_MAX     0x04

...

> +enum tlv493d_channels {
> +       TLV493D_AXIS_X =3D 0,

Why assignment? Is this HW defined value? Then you must assign all of
them explicitly to make code robust to changes.

> +       TLV493D_AXIS_Y,
> +       TLV493D_AXIS_Z,
> +       TLV493D_TEMPERATURE
> +};
> +
> +enum tlv493d_op_mode {
> +       TLV493D_OP_MODE_POWERDOWN =3D 0,

Ditto.

> +       TLV493D_OP_MODE_FAST,
> +       TLV493D_OP_MODE_LOWPOWER,
> +       TLV493D_OP_MODE_ULTRA_LOWPOWER,
> +       TLV493D_OP_MODE_MASTERCONTROLLED
> +};

...

> +struct tlv493d_data {
> +       struct device *dev;
> +       struct i2c_client *client;

Why do you need both?

> +       /* protects from simultaneous sensor access and register readings=
 */
> +       struct mutex lock;
> +       enum tlv493d_op_mode mode;

> +       u8 wr_regs[TLV493D_WR_REG_MAX];
> +};

...

> +       data->wr_regs[TLV493D_WR_REG_MODE1] |=3D mode1_cfg;
> +       data->wr_regs[TLV493D_WR_REG_MODE2] |=3D mode2_cfg;

No mask for the existing values in the respective wr_regs? Wouldn't
you need to use FIELD_MODIFY() instead?

...

> +static s16 tlv493d_get_channel_data(u8 *b, enum tlv493d_channels ch)
> +{
> +       u16 val =3D 0;

I would move the default assignment to the 'default' case. This makes
the intention clearer.

> +       switch (ch) {
> +       case TLV493D_AXIS_X:
> +               val =3D FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493D_RD=
_REG_BX]) << 4 |
> +                       FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_R=
D_REG_BX2]) >> 4;
> +               break;
> +       case TLV493D_AXIS_Y:
> +               val =3D FIELD_GET(TLV493D_BY_MAG_Y_AXIS_MSB, b[TLV493D_RD=
_REG_BY]) << 4 |
> +                       FIELD_GET(TLV493D_BX2_MAG_Y_AXIS_LSB, b[TLV493D_R=
D_REG_BX2]);
> +               break;
> +       case TLV493D_AXIS_Z:
> +               val =3D FIELD_GET(TLV493D_BZ_MAG_Z_AXIS_MSB, b[TLV493D_RD=
_REG_BZ]) << 4 |
> +                       FIELD_GET(TLV493D_BZ2_MAG_Z_AXIS_LSB, b[TLV493D_R=
D_REG_BZ2]);
> +               break;
> +       case TLV493D_TEMPERATURE:
> +               val =3D FIELD_GET(TLV493D_TEMP_TEMP_MSB, b[TLV493D_RD_REG=
_TEMP]) << 8 |
> +                       FIELD_GET(TLV493D_TEMP2_TEMP_LSB, b[TLV493D_RD_RE=
G_TEMP2]);
> +               break;
> +       }
> +
> +       return sign_extend32(val, 11);
> +}

...

> +static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *x, s=
16 *y,
> +                               s16 *z, s16 *t)
> +{
> +       u8 buff[7] =3D {};
> +       int err, ret;
> +       u32 sleep_us =3D tlv493d_sample_rate_us[data->mode];
> +
> +       guard(mutex)(&data->lock);

No include for this API.

> +       ret =3D pm_runtime_resume_and_get(data->dev);
> +       if (ret < 0)
> +               return ret;
> +
> +       /*
> +        * Poll until data is valid,
> +        * For a valid data TLV493D_TEMP_CHANNEL bit of TLV493D_RD_REG_TE=
MP should be set to 0.
> +        * The sampling time depends on the sensor mode. poll 3x the time=
 of the sampling time.
> +        */
> +       ret =3D read_poll_timeout(i2c_master_recv, err, err ||
> +                       FIELD_GET(TLV493D_TEMP_CHANNEL, buff[TLV493D_RD_R=
EG_TEMP]) =3D=3D 0,
> +                       sleep_us, (3 * sleep_us), false, data->client, bu=
ff,

Redundant parentheses.

> +                       ARRAY_SIZE(buff));

Missing include for this macro.

> +       if (ret) {
> +               dev_err(data->dev, "i2c read poll timeout, error:%d\n", r=
et);
> +               goto out;
> +       }
> +       if (err < 0) {
> +               dev_err(data->dev, "i2c read data failed, error:%d\n", er=
r);
> +               ret =3D err;
> +               goto out;
> +       }
> +
> +       *x =3D tlv493d_get_channel_data(buff, TLV493D_AXIS_X);
> +       *y =3D tlv493d_get_channel_data(buff, TLV493D_AXIS_Y);
> +       *z =3D tlv493d_get_channel_data(buff, TLV493D_AXIS_Z);
> +       *t =3D tlv493d_get_channel_data(buff, TLV493D_TEMPERATURE);
> +
> +out:

Labels are better made when they define what they are going to perform.

out_put_autosuspend:

> +       pm_runtime_put_autosuspend(data->dev);
> +       return ret;
> +}

...

> +       ret =3D tlv493d_set_operating_mode(data, data->mode);
> +       if (ret < 0) {

Is ' < 0' part required here?

> +               dev_err(data->dev, "failed to set operating mode\n");
> +               return ret;
> +       }
> +
> +       return 0;

If not, these all lines can be transformed to just

  return ret;

> +}

...

> +static irqreturn_t tlv493d_trigger_handler(int irq, void *ptr)
> +{
> +       struct iio_poll_func *pf =3D ptr;
> +       struct iio_dev *indio_dev =3D pf->indio_dev;
> +       struct tlv493d_data *data =3D iio_priv(indio_dev);
> +
> +       struct {
> +               s16 channels[3];
> +               s16 temperature;
> +               aligned_s64 timestamp;
> +       } scan;

> +

No blank lines in the definition block.

> +       s16 x, y, z, t;
> +       int ret;
> +
> +       ret =3D tlv493d_get_measurements(data, &x, &y, &z, &t);
> +       if (ret) {
> +               dev_err(data->dev, "failed to read sensor data\n");
> +               goto trig_out;
> +       }
> +
> +       scan.channels[0] =3D x;
> +       scan.channels[1] =3D y;
> +       scan.channels[2] =3D z;
> +       scan.temperature =3D t;
> +       iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +                               pf->timestamp);
> +trig_out:

Make sure you use a consistent pattern for labels.

out_trigger_notify:

> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}

...

> +       data->dev =3D dev;
> +       data->client =3D client;

Choose one of them, the other can be derived.

...

> +               return dev_err_probe(dev, ret, "failed to initialize\n");

Missing include for this API.

...

> +static const struct i2c_device_id tlv493d_id[] =3D {
> +       { "tlv493d" },
> +       { }
> +};

> +static const struct of_device_id tlv493d_of_match[] =3D {
> +       { .compatible =3D "infineon,tlv493d-a1b6", },

Inner comma is redundant.

> +       { }
> +};

Missing include for both of the ID tables.

...

> +static struct i2c_driver tlv493d_driver =3D {
> +       .driver =3D {
> +               .name =3D "tlv493d",
> +               .of_match_table =3D tlv493d_of_match,

> +               .pm =3D pm_ptr(&tlv493d_pm_ops),

Missing include for this macro I believe.

> +       },
> +       .probe =3D tlv493d_probe,
> +       .id_table =3D tlv493d_id,
> +};

> +

Remove this blank line.

> +module_i2c_driver(tlv493d_driver);

--=20
With Best Regards,
Andy Shevchenko

