Return-Path: <linux-iio+bounces-18281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A2CA93C25
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 19:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35017A573F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F002AE8C;
	Fri, 18 Apr 2025 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euNER91e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0672218AD4;
	Fri, 18 Apr 2025 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997918; cv=none; b=GlkhnxY+LA7h8QkYFPHnRGWuOo0pXPuh0/7wgWgjXWsT2Ky+1eCptMTdPfnsJ8NESZTnzCJNeeAEHXOyYkgZOpG6g7oaH++1cCgTS4/sPtp2fJ7NGOB0rw+3unNQCjVbuuUT0xmNeIXzgqxQKc8TPIyYWU98ixOVMJ3zT69Vue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997918; c=relaxed/simple;
	bh=xb2G2VO1M1xfUb0LCy2IJ1UrQitw5bZu9jE/Qrd9Xu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpOr+iINdIeqKQM1kVoThj4aX5Xl05QGAzKiuRSw2V7maldbSe+Yhc9BySFdSqX9nNLIt3lalOUFujCyRVACmfDDmwIh+YyxOybLALuQEt3Gdx3N3D2EQKav6fq53x7M6D6EV9VIICtTDLByFYM1soOMY8QzCNXF9G/oey9QQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euNER91e; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4774d68c670so13387341cf.0;
        Fri, 18 Apr 2025 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744997915; x=1745602715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki8ACZJISOIbjJS/GasgcMmF3ePfgYfym/hjjZ80/W0=;
        b=euNER91e1Gg5lpm90aj9e/SMgl/p2a/tWx89sFA1JpmV5CubAH2mzPH7vNSL6XqPBH
         wZxiierLHUlX6LHHHr72c2NKvhW1a9IPGA5f58WBa6LA0T/g7IRfNI7zpko4Bbg7bylq
         LCs31syiCvT1FxawECgTgRbZgtQ9+Sj4DAAkMpsDDiAdt4zmlj/wEi6cGYPx3pkLME/h
         GMBiMabrz/t5kOdCSUteINd+bTt+Z8yIeufFPJt04L2Vjenikeds+a03CUZa3vEV9NtG
         Bu22qsL8Mda9pjx1oj+ujZgGdV7cJPHAKoQQL7Nwzc2YABMcBC8SCd/mz5zs4BmxWtEE
         nTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744997915; x=1745602715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki8ACZJISOIbjJS/GasgcMmF3ePfgYfym/hjjZ80/W0=;
        b=NsFxpfGoy4JlgLqX6sgPo/laxfFZ0VrdLcAiu5nLMiQ+w4fiQYnvvRiC/Ly7K8+maD
         /WhPttiQSHxJTUfLNZKhpIAaaxQ0di1KDN5KMXQ56ul0pVXplJKq4fdJ66ISrxnlMnLB
         UXQJgtCt6tMBzHvlYEDVif/KphRVW3P4v23AexyoH7+M8/j9TKfR0M7itwv4WK/J48Hp
         MvC17z4o5F60SEk7Qikhz0WVvGZqGJHSQX5ugU+uxXKlN0wbNYKM2h6pqaq2RwirrqNV
         NowpX3IJQ8LIPRoUwTrSYOc2LUG7oKO0jqb6BKxihp7JtMd743FQput80IcAkdO/vVtB
         rfEw==
X-Forwarded-Encrypted: i=1; AJvYcCWVQ0/cgXm4G0r3zpVF+MPqg13GkkEiel1zCuWCHbaJCTEWwivdG/IkEoet5S6JxJvSt6gPWzbBp2fbDjin@vger.kernel.org, AJvYcCXe+9SZTc+d/rTwkgMkgT3UGt4e8FOmX7hPG3r93KxKxp6ZZ6dGO//9DrVKv8JL3xTx/f14cQQ4IV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqLHhwl4uTeuvcTjnfsOte4zOa6ExbKS56qShL6Iw5Qhow6ejC
	bMXEK98ASR/zXohGa4yN57SJUpNybjT+qt3RpQZW/A/w4B9aEu3fLrZ+DuvB7wR4daIf4meAAb3
	F7+mRgJ8D9NBssfjVrF5krwSFRCo=
X-Gm-Gg: ASbGnctdWdZ0w3oPqJD9SNsZb0W0IJaOIA9KTSunhUYNU5qJ2Lzs0UFtWzXLiSRk2JV
	2Q2JhdVTUd5QQJG7y414eXtdj//c/ZQKuoXocIZuK6KXBFWxjfMJ/40ID7bXlCfW2YOIhRqBg6a
	kw1elwRfmbnhLfArrQEV4m+MDraqagWf665JTVygGi/ON94xZa1/KE
X-Google-Smtp-Source: AGHT+IGGjHKCjDEZMmSyR53rv7oRObionPa3GQZ+n0O87mJ/ObRuEobUJbchFdd8U7yEiltYlhwfH36qnsflWc3KJdc=
X-Received: by 2002:a05:622a:1a12:b0:476:a967:b247 with SMTP id
 d75a77b69052e-47aec4ccc58mr55176681cf.47.1744997915428; Fri, 18 Apr 2025
 10:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415222652.545026-1-gshahrouzi@gmail.com> <20250418165012.53c9bb85@jic23-huawei>
In-Reply-To: <20250418165012.53c9bb85@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Fri, 18 Apr 2025 13:38:24 -0400
X-Gm-Features: ATxdqUEoSHSECR3LAgcFScpgkJmwDfqANFifuTo82ewMJWl8EgbXtME3-PccdqU
Message-ID: <CAKUZ0zJ5ZCmkJOESYpbp=a6odgLyt4Qxt_0cucsHk7FCYqoumw@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: adis16203: Fix single-axis representation and
 CALIBBIAS handling
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, skhan@linuxfoundation.org, 
	kernelmentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 11:50=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Tue, 15 Apr 2025 18:26:52 -0400
> Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
>
> > The ADIS16203 is a single-axis 360 degree inclinometer. The previous
> > driver code incorrectly represented this by defining separate X and Y
> > inclination channels based on the two different output format registers
> > (0x0C for 0-360 deg, 0x0E for +/-180 deg). This violated IIO convention=
s
> > and misrepresented the hardware's single angle output. The 'Fixme'
> > comment on the original Y channel definition indicated this known issue=
.
> >
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
> > Not sure to put a fixes tag here or not because the driver used to be
> > spread out across multiple files until it was whittled down to one file
> > using a common interface for similar devices.
>
> No fixes tag for this one is the right choice. It is a complex bit of
> ABI abuse.
Got it.
>
> > ---
> >  drivers/staging/iio/accel/adis16203.c | 52 ++++++++++++++++-----------
> >  1 file changed, 31 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/ii=
o/accel/adis16203.c
> > index c1c73308800c5..73288121bf0bd 100644
> > --- a/drivers/staging/iio/accel/adis16203.c
> > +++ b/drivers/staging/iio/accel/adis16203.c
> > @@ -28,11 +28,11 @@
> >  /* Output, temperature */
> >  #define ADIS16203_TEMP_OUT       0x0A
> >
> > -/* Output, x-axis inclination */
> > -#define ADIS16203_XINCL_OUT      0x0C
> > +/* Output, 360 deg format */
> > +#define ADIS16203_INCL_OUT       0x0C
> >
> > -/* Output, y-axis inclination */
> > -#define ADIS16203_YINCL_OUT      0x0E
> > +/* Output, +/-180 deg format */
> > +#define ADIS16203_INCL_180_OUT   0x0E
> >
> >  /* Incline null calibration */
> >  #define ADIS16203_INCL_NULL      0x18
> > @@ -128,8 +128,7 @@
> >  #define ADIS16203_ERROR_ACTIVE          BIT(14)
> >
> >  enum adis16203_scan {
> > -      ADIS16203_SCAN_INCLI_X,
> > -      ADIS16203_SCAN_INCLI_Y,
> > +      ADIS16203_SCAN_INCLI,
> >        ADIS16203_SCAN_SUPPLY,
> >        ADIS16203_SCAN_AUX_ADC,
> >        ADIS16203_SCAN_TEMP,
> > @@ -137,10 +136,6 @@ enum adis16203_scan {
> >
> >  #define DRIVER_NAME          "adis16203"
> >
> > -static const u8 adis16203_addresses[] =3D {
> > -     [ADIS16203_SCAN_INCLI_X] =3D ADIS16203_INCL_NULL,
> > -};
> > -
> >  static int adis16203_write_raw(struct iio_dev *indio_dev,
> >                              struct iio_chan_spec const *chan,
> >                              int val,
> > @@ -148,10 +143,15 @@ static int adis16203_write_raw(struct iio_dev *in=
dio_dev,
> >                              long mask)
> >  {
> >       struct adis *st =3D iio_priv(indio_dev);
> > -     /* currently only one writable parameter which keeps this simple =
*/
> > -     u8 addr =3D adis16203_addresses[chan->scan_index];
> >
> > -     return adis_write_reg_16(st, addr, val & 0x3FFF);
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             if (chan->scan_index !=3D ADIS16203_SCAN_INCLI)
> > +                     return -EINVAL;
> > +             return adis_write_reg_16(st, ADIS16203_INCL_NULL, val & 0=
x3FFF);
>
> I would check for out of range before you get here rather than masking.
> Clearly the old code just masked, but we can do better given you are refa=
ctoring
> it.  If an invalid setting is requested best thing is normally to just re=
turn
> an error so userspace can see it was ignored.
Got it. Added these changes to V2.
>
>
> > +     default:
> > +             return -EINVAL;
> > +     }
> >  }
> >
> >  static int adis16203_read_raw(struct iio_dev *indio_dev,
> > @@ -161,7 +161,6 @@ static int adis16203_read_raw(struct iio_dev *indio=
_dev,
> >  {
> >       struct adis *st =3D iio_priv(indio_dev);
> >       int ret;
> > -     u8 addr;
> >       s16 val16;
> >
> >       switch (mask) {
> > @@ -194,8 +193,9 @@ static int adis16203_read_raw(struct iio_dev *indio=
_dev,
> >               *val =3D 25000 / -470 - 1278; /* 25 C =3D 1278 */
> >               return IIO_VAL_INT;
> >       case IIO_CHAN_INFO_CALIBBIAS:
> > -             addr =3D adis16203_addresses[chan->scan_index];
> > -             ret =3D adis_read_reg_16(st, addr, &val16);
> > +             if (chan->scan_index !=3D ADIS16203_SCAN_INCLI)
> > +                     return -EINVAL;
> > +             ret =3D adis_read_reg_16(st, ADIS16203_INCL_NULL, &val16)=
;
> >               if (ret)
> >                       return ret;
> >               *val =3D sign_extend32(val16, 13);
> > @@ -206,13 +206,23 @@ static int adis16203_read_raw(struct iio_dev *ind=
io_dev,
> >  }
> >
> >  static const struct iio_chan_spec adis16203_channels[] =3D {
> > +     {
> > +             .type =3D IIO_INCLI,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                     BIT(IIO_CHAN_INFO_SCALE) |
> > +                                     BIT(IIO_CHAN_INFO_CALIBBIAS),
> > +             .address =3D ADIS16203_INCL_180_OUT,
> > +             .scan_index =3D ADIS16203_SCAN_INCLI,
> > +             .scan_type =3D {
> > +                     .sign =3D 's',
> > +                     .realbits =3D 14,
> > +                     .storagebits =3D 16,
> > +                     .shift =3D 0,
>
> No need for setting shift to 0 explicitly.  It will happen anyway and
> a shift of 0 is a fairly natural default.
Got it. Added to V2.
>
> > +                     .endianness =3D IIO_CPU,
> > +             },
> > +     },
> >       ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, =
12),
> >       ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 1=
2),
> > -     ADIS_INCLI_CHAN(X, ADIS16203_XINCL_OUT, ADIS16203_SCAN_INCLI_X,
> > -                     BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> > -     /* Fixme: Not what it appears to be - see data sheet */
> > -     ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y,
> > -                     0, 0, 14),
> Why the ordering change?  I don't think it matters in practice, but easie=
r to
> review of we keep that ordering the same as then no need to think about i=
t at
> all!
You're right, maintaining the original order simplifies reviewing this
specific functional change. I have restored the original relative
order of the channels in v2.
My initial thought process for moving the inclinometer channel was to
place the device's primary function first in the list, but I agree
that separating functional changes (like this patch) from
organizational changes (like reordering) is better practice. Any
reordering can be proposed separately.
>
> Jonathan
>
> >       ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
> >       IIO_CHAN_SOFT_TIMESTAMP(5),
> >  };
>

