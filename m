Return-Path: <linux-iio+bounces-23079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66539B2EFEE
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 09:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACF93B9B0A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C493B28031D;
	Thu, 21 Aug 2025 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E10EehIu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB64690;
	Thu, 21 Aug 2025 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762103; cv=none; b=eTAXOP2HY8Ypbi2fnGXEg1FOfkZunYJYnhtrbBvR1ajotP4OzugX8mxX8VpQ/9vgAFoKCdjKlk5bSXweSVmTVA3hvCXrjblm5Z/ISkELgQci6h+I0vMdeRw7jsdbOnonTelIdjFRhT8Xum0YtXtQZhcewUAFr7coxXbRJP8n1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762103; c=relaxed/simple;
	bh=kPrcHdkc/3j6mEtJqp6XmZ7ZekHXYjAyIttUc51h7/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdjjQSTPB8xcZwcoIqsjJco+M1NyrrFTyUCjWdBHsJUzsRA5sNUtVL6jrVecNXJYN2Z4+HIiKwONKHZLqCwXCb3ZWSaOgQEcfxcqnC0TF59solP50ve6oqUC6n8ZmTOfP4nTDVJQ7pVYs4UFIcq5PZkVWxVnMOcjW/5dIHLeZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E10EehIu; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b7532f3so1144934a12.2;
        Thu, 21 Aug 2025 00:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755762100; x=1756366900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIZhMIR98sN11ESgeJLOLyQsEESU4OFFo5q5jHVEOWw=;
        b=E10EehIuI+t5Eszr2SqDYcXVpvJuU2pGjBJp8QrEqM+dYJ7ryeybOHeV7IGt02FJ3x
         Q+feDy2MWl7rnJArrbOuo17zklcD4vIItrfKcEXw8fQZGooOqkA+X5iOf9qZ+phNyk0v
         Ooo561QdPqQJQvzrwb4FvTC8FpanCYEFpPvGp9B0jFRSFJhZYF8HbdADha0CPMlEXZ+c
         LiMZ8M3Bl2zvrPrD2S5Zlyd/43k12BAJlqwaXzcpQHYgSZg+KJpQi7HzTBEAUFwGltFd
         m62sFBq2C+P5HD9peSulvO5jXjx0sWqd8nJioptCpvRsF1UZySXeVYAvdcBXerUqJut0
         3XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755762100; x=1756366900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIZhMIR98sN11ESgeJLOLyQsEESU4OFFo5q5jHVEOWw=;
        b=Ss+n2jNqwnk5thNtLmUh2oM2BdAYgtPBr/bO3ufacahghOio2ejyGx6V7XG0xV1inr
         QxtiFvi8iablEguhvGGFOJOvoFPbIrzpunWseT2JYHliVeyg1j4PnqeO+/3RWs8bm+fL
         gGHzkxQ8F1IYrkeSYqCX1Flu0YJaZ8iy06GOA0IxGRpB5GMdnedrdRDKJEVKEelWeH1z
         Unya/OIgtK82q/D4q/MSuGd//x6fIA14fTI2fnNqkTCqbvDQOQulUJV9IgATQs0i8Ugo
         ENFPfleo8VeUi8MABr9Bey1s3nDsKx9gTHM+O/ooWTFo3z2jS4OjrglugUBpw1Gl5n/Z
         NxeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVidJDQu11PsFWRsPaomHSabQKGKw4fmj7PzAYHYsV+D8eLJ0dkDOQkD8N5BHaHfvDNawR65CmH64xQh/U8@vger.kernel.org, AJvYcCWfZd/usTxE+EbwxQqBxW+57lQUjYlz3E4CG5chlsNuz6WUlP2WrNFY606r+dFLWKHR8ZPnmG1C6Jv+@vger.kernel.org, AJvYcCXOSqQQH4BiigAv5joGoj/gov6HlSfd6Auy6tDlYI5tOhJQFGBWqluJ4hJ/AAug9g8HeykWYGkVOdMs@vger.kernel.org
X-Gm-Message-State: AOJu0YzVG+664vezUmofG0BA3EpEo9yQSoo8BIvNNg8rOVHW6ey8QKMk
	h44yMx+InDdCLNBePUVgdhscOViof1dnyNeRVkpm3eZM9XwncRpVT/oSTSalzNgrCGNBWpi6fhK
	pAFvRCkjQJNus0gmpCs549d1OV+QMtTo=
X-Gm-Gg: ASbGncsx4wpbc4FIL3lW5LIikm+zQhH3balhxXSp8IFV5ekKm7T0MjepUhyHemTWOnP
	/CEMNv6RUlDGK53gSa+mM88nmS4X3a14i8WSAvY8qaoPyRnlwYylBK8Jc20uNAox0IqUkW8szmE
	9y1UZbVoM6ACSg18uLiOzPFJ8ZWAryU9b6QvdGz3BToHRkN2Alg0IWOYYLIOVkqEwx4A2I0QFxP
	nZAzqJkrg==
X-Google-Smtp-Source: AGHT+IGWrfnL2SF9aG13X/8PLv4wY0UjJxCUOu5WcsnQ/IYf2m8xwQLk9znhMWW+p4PGneh9sBL6NNAwfLOYS8k/ngk=
X-Received: by 2002:a17:907:9814:b0:af2:b9b5:1c06 with SMTP id
 a640c23a62f3a-afe079d37a9mr127119666b.14.1755762099776; Thu, 21 Aug 2025
 00:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
 <20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
 <aKXW5pGiN18DyIZ7@smile.fi.intel.com> <aKaMPMnGRyvKqTny@dixit>
In-Reply-To: <aKaMPMnGRyvKqTny@dixit>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Aug 2025 10:41:03 +0300
X-Gm-Features: Ac12FXz4IG57-fSP6z8NGcm7Oz5k2l0xepeyfpOthmM1oC4nqwZJWP_9DzbV7KQ
Message-ID: <CAHp75Vdw5X1Y057fpGjdvVGwKq0x0UBdm8py+m+55RbzXi1PJw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 6:02=E2=80=AFAM Dixit Parmar <dixitparmar19@gmail.c=
om> wrote:
> On Wed, Aug 20, 2025 at 05:08:38PM +0300, Andy Shevchenko wrote:

...

> > >  st_magn-$(CONFIG_IIO_BUFFER) +=3D st_magn_buffer.o
> > >  obj-$(CONFIG_IIO_ST_MAGN_I2C_3AXIS) +=3D st_magn_i2c.o
> > >  obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) +=3D st_magn_spi.o
> > >
> > > +obj-$(CONFIG_INFINEON_TLV493D)             +=3D tlv493d.o
> > > +
> > >  obj-$(CONFIG_SENSORS_HMC5843)              +=3D hmc5843_core.o
> > >  obj-$(CONFIG_SENSORS_HMC5843_I2C)  +=3D hmc5843_i2c.o
> > >  obj-$(CONFIG_SENSORS_HMC5843_SPI)  +=3D hmc5843_spi.o
> >
> > I haven't got the ordering rules here and in Kconfig. Can it be alphabe=
tical?
> From what I can see, the order is alphabetical based on the CONFIG option=
 in the
> Makefile and Kconfig, and I kept CONFIG_INFINEO_TLV493D after CONFIG_IIO_=
ST*.
> Isn't it in correct order? or my understanding is incorrect?

I dunno, The file name there is with the vendor prefix, in many cases
the configuration option is with vendor prefix as well, but the file.

...

> > > +   switch (ch) {
> > > +   case TLV493D_AXIS_X:
> > > +           val =3D FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493D_RD=
_REG_BX]) << 4 |
> > > +                   FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_R=
D_REG_BX2]) >> 4;
> >
> > Wrong indentation, make both 'F':s to be in the same column.
> To have 'F' in the same column, it will need spaces after tab (I think it=
s not
> advisable to mix spaces and tabs).

No, mixing tabs and spaces basically means spaces inside TABs or
before TABs. The TABS followed by solely spaces is okay and the
correct way to indent.

> With just tabs the second FIELD_GET will be
> align to 'v' of val. What will be the correct indentation?

...

> > > +static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *=
x, s16 *y,
> > > +                           s16 *z, s16 *t)
> >
> > Indentation issue. Please, check fully the code for such issues.
> I followed the single tab after default as suggested. At which column the=
 s16 *z should be align to?

s16 starts with the same column as struct.

...

> > > +   ret =3D read_poll_timeout(i2c_master_recv, err, err ||
> > > +                   FIELD_GET(TLV493D_TEMP_CHANNEL, buff[TLV493D_RD_R=
EG_TEMP]) =3D=3D 0,
> >
> > Please, resplit logically, i.e leave the condition on the single line.
> > Also to make it shorter you can use '!' instead of ' =3D=3D 0'.
> Having both conditions in same line will go out of 80 char length limit, =
even with !.
> Is it fine?

In _this_ case yes. I expect something like this to see

   ret =3D read_poll_timeout(i2c_master_recv, err,
                   err || !FIELD_GET(TLV493D_TEMP_CHANNEL,
buff[TLV493D_RD_REG_TEMP]),

...

> > Just wondering if you have tested for negative coordinates, does it pro=
pagate
> > correctly?
> Yes I have validated, it reports correct negative coordinate values.

OK!

> > > +   iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> > > +                           pf->timestamp);
> >
> > Interestingly that you have used 100 limit and suddenly don't do it her=
e
> > and maybe elsewhere. Why inconsistent style? Please, go through the who=
le
> > file and make sure the style is consistent in all of the aspects:
> > - C style used
> > - comments style (one-line and multi-line)
> > - indentation
> > - etc.
> I tried to follow 80 limit(except few places where it was just on border =
or not
> clear to read). I belive the standard is to use 80 limit(correct me if I =
referred
> wrong place) and I will recheck to meet that.

There are two standards, the old and strict one -- 80 characters, and
this subsystem _tries_ to follow it and relaxed with 100 limit.
The exceptions are possible when it affects readability.

--
With Best Regards,
Andy Shevchenko

