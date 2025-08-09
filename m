Return-Path: <linux-iio+bounces-22490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C6B1F4A1
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 14:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 930D67A73E1
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF81299931;
	Sat,  9 Aug 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCmum7rV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E33299923;
	Sat,  9 Aug 2025 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754743480; cv=none; b=ir9TwmW0tksYJ0mwN7K7tYJSnBCCc2sHln/6NfvIl9B/TcIZDHth13oFYKtho00didYNl3ebF2Nj0oRKWyHXWmA+E56Mc6y4Y0dzgGbFsnL8hrLvvNunZAhsC6QI8YROTOO+gsMvB5AL3YVpyAEdTjF9G0GEyyNSwMHe+NkFIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754743480; c=relaxed/simple;
	bh=tzyFwPoVrbQtm0oQpjzUdcgJoybOby/pb7hHtDvzY5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJXg9pJzyK5H9cmDyoE1ayz2qXGsLGYBAJk/rFMYUnPW/uz5pZfxQFz8bygXtqosnqFsp/mxBp1zE0vs0+VLvHmsanXiYPUeWXW2kbOpqvEztMFFkWQaq8nnPtCAZiUxRAcYYYicQ1SmeDQu8SqPFetxl0peBBALjJEDKjba/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCmum7rV; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af66d49daffso521929066b.1;
        Sat, 09 Aug 2025 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754743477; x=1755348277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6h45unfRzdLulWF0UQZuDRZ85InPy2XX8h39ymx+8A=;
        b=KCmum7rVZ/WhvWEegqnA+919G+D2K+bnSSYmWVIA2DV+y8PrFjDwvCi0hlGLPIJrm8
         6zJFzYq5/28g5FTVTHmoVVSLr8FTW3x0VGHUYTxUvnsWf90AdhVjySwu9K0pYNwL6w3u
         pemY9reM0ocqxyNkKcu/m7SlfEiqo72f4ZUZsmFc+kzTVL771feiOO1893X7P9xvJH1B
         X0rBaqQYjzIIPdVatEq6UooSWREOTC3G3XE4jIOVqgmZM8gN6nK57sqWFasb3h8qYuZR
         +EZVjT94GWgydVKfl7fhxg2B7B6I/9QaNtMpYSeXCc3I2/35IeE2pYHND47SdVN4xlkW
         pk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754743477; x=1755348277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6h45unfRzdLulWF0UQZuDRZ85InPy2XX8h39ymx+8A=;
        b=nLTBDMMpPSXQGokxxdp3t7VF7h8VWB7Jjyhk0qrgomUXhyXr2Ki7+u55ZZPkEJ/C4N
         Dt5GcZDo20lSnzRWkrMGS8ZfEzOw+4W4v7b22uTtrSdvPj6hve3mhxwjkia7Kt40IzFC
         Q4X7FVL6g5pjqKK7Zd+01jQe7GUjrhu1lBUfDklTJhwK/Bj1/nJRzpzivrc9Q+Wz9WX9
         8Vogi38/+sjeBVhdiCtBFoCcA9uedyePUzRLwImcmkWozqfx+NKOcJJPky79N7KJ92hT
         yrPHnO9j9FamdNzIg6ZiAFFzbsWw9+w4I3IVpbHVIsaGg1nB4XS9Um1+YWoa7F6o0CPT
         DGSA==
X-Forwarded-Encrypted: i=1; AJvYcCUNQ+9pKe+V+/KxqgSY312H8peVrh5gy4d8Wa3/h6rfpHksbul5NxPUJLoNhZ5GifK1A1e70UpTcsjH@vger.kernel.org, AJvYcCVG3LeutkBXnPkzlZ5rwgsWm4IHopbTPe4KNg8s7BrkJ9A9a47Qd+3B7zB5v74t+M4YKnVmrSYpVHgY@vger.kernel.org, AJvYcCXxvBHpzGgzh3MguEKNrJ2YSC2dSbWf+W8rPk+IAsQN3mClAn57sjsUl+ssBc30WB7RwXalnVVKtPxMwClH@vger.kernel.org
X-Gm-Message-State: AOJu0YyNamczn1qoObSgsMjnqw2IKkXfkZfBobPVKvdo4SIaTX4JXXcK
	aS2gbt9L4cz8rqe4RO/kz6QMVTw+30w0ft5m6oozf59Z8k+rf47ziOnpVz5Th5vV3lFzePbVY1W
	JaUgFfTb43blGg6GoKWXIbxqL76PZAHE=
X-Gm-Gg: ASbGncv5mFBqHoAmiJMntAHAd7j9UtGAPrWwS7NIzLWYdwJCq2b/r74ZIvui0fMu4T6
	bmybOTFGVHeH/yCDqbJkDftXFgvwWT7v+0mdoZhvCYYI9JSIqEII9jBBEVEzjABsx2GnyEXMvIS
	OVrmYu45/2moyYYUHU5SlzvKf3mrdhWUHD4RZ6N/6R/e+VaupR8/Rd/pbqC/8BgUn7VQsCL+aVc
	vzoR+HzqtnYhat2vPk4
X-Google-Smtp-Source: AGHT+IEFJwYzDVLRjJyDbNuH0A++9uPf8qNguz2dWFX9HPyCijeNdJgc1Tm7BErBJb4gcwrXWbqgNZL1Gflris4JFOY=
X-Received: by 2002:a17:907:3d0f:b0:ae6:a8c1:c633 with SMTP id
 a640c23a62f3a-af9c64f9025mr545609166b.34.1754743477181; Sat, 09 Aug 2025
 05:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com>
 <20250807-tlv493d-sensor-v6_16-rc5-v3-1-b80d2cb41232@gmail.com>
 <CAHp75VeKPr=3H_wOvcesqj4OsrqN7zwRFFk3ys3O012JpQtxrQ@mail.gmail.com> <aJcw8icGvsDzFGpJ@dixit>
In-Reply-To: <aJcw8icGvsDzFGpJ@dixit>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 9 Aug 2025 14:44:00 +0200
X-Gm-Features: Ac12FXwLxlNr-kkWXBfXxTRubWRtjfn6p4MnW8ZE2EZLQJ0nUiB1Ob7Xvkag5H8
Message-ID: <CAHp75Vc7Jftvmgb0EgnYmiKtT2TTYb2uQGNgaqm7hvkFWpJ9cg@mail.gmail.com>
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

On Sat, Aug 9, 2025 at 1:29=E2=80=AFPM Dixit Parmar <dixitparmar19@gmail.co=
m> wrote:
> On Thu, Aug 07, 2025 at 10:57:16PM +0200, Andy Shevchenko wrote:
> > On Thu, Aug 7, 2025 at 4:57=E2=80=AFAM Dixit Parmar <dixitparmar19@gmai=
l.com> wrote:

...

> > > +enum tlv493d_channels {
> > > +       TLV493D_AXIS_X =3D 0,
> >
> > Why assignment? Is this HW defined value? Then you must assign all of
> > them explicitly to make code robust to changes.
> >
> No, this is not HW defined value, these are used for iio channel and
> some internall indexing. Most of the driver I referred had this enum
> having assigned to 0 which i think gives clear intention and better
> understanding. either I can keep as it is assuming its good for
> readabilty or keep it unassigned. What do you suggest?

Read C standard?
If it's only driver specific things and not related to HW, assigning
to any value makes no sense, The only requirement here they should be
unique and that's what enum does.

> > > +       TLV493D_AXIS_Y,
> > > +       TLV493D_AXIS_Z,
> > > +       TLV493D_TEMPERATURE
> > > +};
> > > +
> > > +enum tlv493d_op_mode {
> > > +       TLV493D_OP_MODE_POWERDOWN =3D 0,
> >
> > Ditto.
> >
> Same as above. Just different usecase as this is driver specific enums.

Same as above.

> > > +       TLV493D_OP_MODE_FAST,
> > > +       TLV493D_OP_MODE_LOWPOWER,
> > > +       TLV493D_OP_MODE_ULTRA_LOWPOWER,
> > > +       TLV493D_OP_MODE_MASTERCONTROLLED
> > > +};

...

> > > +       data->wr_regs[TLV493D_WR_REG_MODE1] |=3D mode1_cfg;
> > > +       data->wr_regs[TLV493D_WR_REG_MODE2] |=3D mode2_cfg;
> >
> > No mask for the existing values in the respective wr_regs? Wouldn't
> > you need to use FIELD_MODIFY() instead?
> >
> I believe, we are doing OR op with the value created using FIELD_PREP,
> so it should not interefere with the existing non-masked values.

I am talking about existing values in the array.

> However, as FIELD_MODIFY is there, I should utilize it.

...

> > > +static s16 tlv493d_get_channel_data(u8 *b, enum tlv493d_channels ch)
> > > +{
> > > +       u16 val =3D 0;
> >
> > I would move the default assignment to the 'default' case. This makes
> > the intention clearer.
> >
> As per the suggestion on privious version of the patch, we are having
> ch datatype as enum and as suggested, with enum as swicth-case, it
> should not have default case. so I think this initialisation to 0 at the
> beginning should be fine.

It will make no sense. Please, remove it. and perhaps the compiler
won't warn, otherwise the default case will be needed.

> > > +       switch (ch) {
> > > +       case TLV493D_AXIS_X:
> > > +               val =3D FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493=
D_RD_REG_BX]) << 4 |
> > > +                       FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV49=
3D_RD_REG_BX2]) >> 4;
> > > +               break;
> > > +       case TLV493D_AXIS_Y:
> > > +               val =3D FIELD_GET(TLV493D_BY_MAG_Y_AXIS_MSB, b[TLV493=
D_RD_REG_BY]) << 4 |
> > > +                       FIELD_GET(TLV493D_BX2_MAG_Y_AXIS_LSB, b[TLV49=
3D_RD_REG_BX2]);
> > > +               break;
> > > +       case TLV493D_AXIS_Z:
> > > +               val =3D FIELD_GET(TLV493D_BZ_MAG_Z_AXIS_MSB, b[TLV493=
D_RD_REG_BZ]) << 4 |
> > > +                       FIELD_GET(TLV493D_BZ2_MAG_Z_AXIS_LSB, b[TLV49=
3D_RD_REG_BZ2]);
> > > +               break;
> > > +       case TLV493D_TEMPERATURE:
> > > +               val =3D FIELD_GET(TLV493D_TEMP_TEMP_MSB, b[TLV493D_RD=
_REG_TEMP]) << 8 |
> > > +                       FIELD_GET(TLV493D_TEMP2_TEMP_LSB, b[TLV493D_R=
D_REG_TEMP2]);
> > > +               break;
> > > +       }
> > > +
> > > +       return sign_extend32(val, 11);
> > > +}

...

> > > +       guard(mutex)(&data->lock);
> >
> > No include for this API.
> >
> General question for all the include related suggestions, all the
> required headers are being included by one of the included header(i2c.h,
> iio.h etc), in such case, is it necessary to have specific include for
> given API mentioned in source file? Will it not make it more clumsy
> in terms of repeatative header includes? I understand having all the
> includes mentioned in given source file makes it clear to understand the
> dependency the driver is having. Just want to undertand it bit more as
> learning.

It's called the IWYU principle.
Read more about it here: https://include-what-you-use.org/

...

> > > +       ret =3D read_poll_timeout(i2c_master_recv, err, err ||
> > > +                       FIELD_GET(TLV493D_TEMP_CHANNEL, buff[TLV493D_=
RD_REG_TEMP]) =3D=3D 0,
> > > +                       sleep_us, (3 * sleep_us), false, data->client=
, buff,
> >
> > Redundant parentheses.
> >
> For (3 * sleep_us)?

Yes.

> > > +                       ARRAY_SIZE(buff));

...

> > > +out:
> >
> > Labels are better made when they define what they are going to perform.
> >
> > out_put_autosuspend:
> >
> Does it mean it should have whatever is being skipped in the flow?

I don't understand the question. They should answer the question:
"What will happen if I goto $LABEL?"

> > > +       pm_runtime_put_autosuspend(data->dev);
> > > +       return ret;

...

> > > +       data->dev =3D dev;
> > > +       data->client =3D client;
> >
> > Choose one of them, the other can be derived.
> >
> ACK.

Many of the comments were being aimply ignored. Are they ACKed or
what? The rule of thumb is to completely remove the pieces you fully
agree with, this will reduce churn in the emails and make a reviewer
happier.

...

> > Missing include for both of the ID tables.
> The ID tables are defined mod_devicetable.h in which intern gets
> included in i2c.h and i2c.h is already included in this driver file,
> should I explicitely include mod_devicetable.h here?

See above, follow IWYU.

...

> > > +static struct i2c_driver tlv493d_driver =3D {
> > > +       .driver =3D {
> > > +               .name =3D "tlv493d",
> > > +               .of_match_table =3D tlv493d_of_match,
> >
> > > +               .pm =3D pm_ptr(&tlv493d_pm_ops),
> >
> > Missing include for this macro I believe.
> >
> No I guess. DEFINE_RUNTIME_DEV_PM_OPS is part of pm_runtime.h and its
> already included.

And how is it related to my comment _here_ in the code?

> > > +       },
> > > +       .probe =3D tlv493d_probe,
> > > +       .id_table =3D tlv493d_id,
> > > +};

--=20
With Best Regards,
Andy Shevchenko

