Return-Path: <linux-iio+bounces-18482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46258A95A3F
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 02:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B713B2A4E
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC813D8B2;
	Tue, 22 Apr 2025 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1f1SDhI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07414386D
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745282497; cv=none; b=gnCc+8AVVykga3aXxDk3wmo8rYNOPQRpjC99Y0F92/MXyvQz787zP+6HDzBXCqE0Bj5RYYWaAYkrj+cVoo7SlsMrWqpqUtAia2ukOXn3eb+0WErbBGZC8h8PJvXrOdZssHc+i3VEvNQ1sIlbm5basKGp6uGMlV3rLrFTxJTpCG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745282497; c=relaxed/simple;
	bh=tpos57Fn9fSAPqnV/5RnsHzxHvYgPIivXAYxZa04Eho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rrgq9FTswqKQvVFu+XMgKHPenm3HSe2NWFQqurcWrEUtcNnuXpxOUW6Ni1molmbf9XcdnWy103hmn0gCtco9N/MmoSECbBJRa3+jiE6ohOBCFTa9u6NMBLxxiOrlCzBn87kSJZNDYwwQ7NcPg9TUpnJt/rcWCA8N6znS4qhxUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1f1SDhI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f5bef591d6so7750264a12.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 17:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745282493; x=1745887293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lWfQBdrRNFvfuDk7Q42zxP6NxmYYnx5RC5z+IyivPo=;
        b=T1f1SDhIL1k1EzpW/4ERnoxwiCVhaJYk7eqwlKHrHWt847b8pSyQqSrOCL7Pup6JgZ
         kuYJM+EiAXHZsM3dz7JkU7CttloeN4KHCMOcVgr6U6hE3w7zMpQUKbnb6IzKGWvAyg8+
         7SELExy7GjWfG1iUN9+3fr+nExKJDM5EKkeTYdkSthvNdxMoAsZEZa+WOsP2Vd9lKrB+
         R0veNIAMnoiZnfgnTiQud7Q/3vKfcv/n09kjhpAsygb4IOv8//axQyCkHUQ0IEdJoSIi
         AlqU6abiK4qSmNPbXn3+ux69UUf4uIgRhrZgbE2sC0P5KIcOSa5T89GwDxynMAUr3/C9
         dXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745282493; x=1745887293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lWfQBdrRNFvfuDk7Q42zxP6NxmYYnx5RC5z+IyivPo=;
        b=nFy0cXhvZC2Lg/bk/2UJOM702nUc4vAfxWKShKkrhMqg8H+vpUJHoRWyuvTwc3FNGS
         ANtCba3A12oA/sru+w+430h4g9NVZ/Q/yTzz5DcxOvsbKqa+4wz3BM2PbBLGdvqVJ/3o
         H3nM1xZVGdW8wWq51qJ4HNI5cVkXWIhXQReDNVtKpg5bop9QXchpAm32kj4cZs/IDtPK
         P3AWOF+ajBNe0O0oR32afVLGhE0vJEr1qQLhdSYQg0lhXHt4Xd5sHgHT6vI15Ut7oIVb
         rWlXionDpS5/x/MyiiDrZjDo1/a/p+Lyy4F7Fbx3a84A62Xa1j7oeZtR2p440n8qdDqn
         5JOg==
X-Forwarded-Encrypted: i=1; AJvYcCWJqiIa14+vARrqRLU2eaqWW3Sritl6QGj209A7PSCkYc2PlTCOytrc0BS9XVrx5Z2fOJ8iptxiLHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxMRvpAGTwvU8pcYBLTcKQQ+P0gA8+/23o1XehlbjvxvsBoAHR
	TEcoPSg2/i1EUYvUKTDA92QllynhJzUblVk0Xz7EHXll2PUnPmXBige+ELYEvYNDdY4CM/m/sLP
	Jg0JwXCFgwFi7MZkXCjZhRVNm5+w=
X-Gm-Gg: ASbGncvUA1HBEaUYuEehD5Pbx6268+63g3uANoSzMu8ndn1WLUx5GxxDNFz4R39nwch
	KIq/HZzlQPrzSkIiOOpWjsUaQuEXitLRj+vBOX22vdedZtv/InsFrEKig1j5jOa9ev47vKcCSw+
	1jCLQjqcTyWSUaIULFC/fvK0jTzSP4rh3M6UFYX0tSz24lJ70NR3Y=
X-Google-Smtp-Source: AGHT+IFrD7x/AQKL5xAx1oXbR8jK0tLOTUQ9GyJSCCyKZzkJ5gjWFG4YORr1k+gMc5w308+JEhCovjPFKsK+KbYYITM=
X-Received: by 2002:a17:907:d7cb:b0:ac7:f348:b8bc with SMTP id
 a640c23a62f3a-acb74e7f708mr1244505366b.61.1745282492612; Mon, 21 Apr 2025
 17:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419232128.35759-1-nattanferreira58@gmail.com> <aAU8ZczOnIIOcCOC@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aAU8ZczOnIIOcCOC@debian-BULLSEYE-live-builder-AMD64>
From: Nattan Ferreira <nattanferreira58@gmail.com>
Date: Mon, 21 Apr 2025 21:41:21 -0300
X-Gm-Features: ATxdqUENvaEtDmzZ7fQDS7mmbhoeWA2bURP7HAEnBI2veRYXal5Hae1LLBkuwrc
Message-ID: <CAKj1jXqFpZO1ShriB-FScdQjZED+2GL1jf8zsjXnuU8D8Ae6tg@mail.gmail.com>
Subject: Re: [PATCH] iio: light: apds9306: Refactor threshold get/set
 functions to
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: subhajit.ghosh@tweaklogic.com, jic23@kernel.org, 
	lucasantonio.santos@usp.br, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Marcelo,
thank you for the feedback.

>  Not sure it's worth extracting the event direction comparison into that =
separate function. Even though there is less code repetition, we now have a=
n extra comparison to handle get_thresh_reg() return.
I understand your point. The main goal was to reduce code duplication
and perhaps improve readability and maintainability, but I agree that
it introduces a small trade-off with the additional return check.

>  Even though these functions are declared static, it's common pattern in =
IIO that driver functions start with the name of the driver. So, it would b=
e more conventional to call it apds9306_get_thresh_reg().
Got it. I=E2=80=99ll rename the helper function to follow the IIO driver
naming convention.

I understand the blank line problems and I'll correct them.

I=E2=80=99ll send a v2 soon with all these adjustments.

Thanks again for your feedback!

Best regards,
Nattan


On Sun, Apr 20, 2025 at 3:25=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Hello Nattan, Lucas,
>
> Not sure it's worth extrancting the event direction comparison into that
> separate function. Even though there is less code repetition, we now have=
 an
> extra comparison to handle get_thresh_reg() return. Despite of that, see
> comments below.
>
> On 04/19, nattan wrote:
> > From: Nattan Ferreira <nattanferreira58@gmail.com>
> >
> > Refactor the apds9306_event_thresh_get and apds9306_event_thresh_set fu=
nctions
> > to use a helper function (get_thresh_reg) for obtaining the correct reg=
ister
> Wrap commit description to 75 columns.
>
> > based on the direction of the event. This improves code readability,
> > minimize the number of lines  and maintains consistency in accessing
> > threshold registers.
> >
> > Signed-off-by: Nattan Ferreira <nattanferreira58@gmail.com>
> > Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
> > Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>
> > ---
> >  drivers/iio/light/apds9306.c | 38 ++++++++++++++++++++----------------
> >  1 file changed, 21 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.=
c
> > index 69a0d609c..8e1cdaeb0 100644
> > --- a/drivers/iio/light/apds9306.c
> > +++ b/drivers/iio/light/apds9306.c
> > @@ -6,7 +6,6 @@
> >   *
> >   * Copyright (C) 2024 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> >   */
> > -
> This doesn't seem to have any relation with the intent of the patch.
> Drop this unrelated change.
>
> >  #include <linux/bits.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/delay.h>
> > @@ -744,20 +743,28 @@ static int apds9306_event_period_set(struct apds9=
306_data *data, int val)
> >       return regmap_field_write(rf->int_persist_val, val);
> >  }
> >
> > -static int apds9306_event_thresh_get(struct apds9306_data *data, int d=
ir,
> > -                                  int *val)
> > +static int get_thresh_reg(int dir)
> Even though these functions are declared static, it's common patter in II=
O
> that driver functions start with the name of the driver. So, it would be =
more
> conventional to call it apds9306_get_thresh_reg().
>
> >  {
> > -     int var, ret;
> > -     u8 buff[3];
> > -
> >       if (dir =3D=3D IIO_EV_DIR_RISING)
> > -             var =3D APDS9306_ALS_THRES_UP_0_REG;
> > +             return  APDS9306_ALS_THRES_UP_0_REG;
> >       else if (dir =3D=3D IIO_EV_DIR_FALLING)
> > -             var =3D APDS9306_ALS_THRES_LOW_0_REG;
> > +             return APDS9306_ALS_THRES_LOW_0_REG;
> >       else
> >               return -EINVAL;
> > +}
> > +
> > +static int apds9306_event_thresh_get(struct apds9306_data *data, int d=
ir,
> > +                                  int *val)
> > +{
> > +     int reg, ret;
> > +     u8 buff[3];
> > +
> > +     reg =3D get_thresh_reg(dir);
> >
> > -     ret =3D regmap_bulk_read(data->regmap, var, buff, sizeof(buff));
> There is now a blank line between function call (apds9306_get_thresh_reg(=
)) and
> the return check, which is unusual in IIO. Drop the blank line between th=
ose
>         reg =3D get_thresh_reg(dir);
>         if (reg =3D=3D -EINVAL)
> ...
>
> > +     if (reg =3D=3D -EINVAL)
> > +             return reg;
> > +
> > +     ret =3D regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
> >       if (ret)
> >               return ret;
> >
> > @@ -769,22 +776,19 @@ static int apds9306_event_thresh_get(struct apds9=
306_data *data, int dir,
> >  static int apds9306_event_thresh_set(struct apds9306_data *data, int d=
ir,
> >                                    int val)
> >  {
> > -     int var;
> > +     int reg;
> >       u8 buff[3];
> Add a blank line between local variable declarations and rest of function=
 code.
> > +     reg =3D get_thresh_reg(dir);
> >
> Another blank line between function call and return check to be dropped h=
ere.
>
> > -     if (dir =3D=3D IIO_EV_DIR_RISING)
> > -             var =3D APDS9306_ALS_THRES_UP_0_REG;
> > -     else if (dir =3D=3D IIO_EV_DIR_FALLING)
> > -             var =3D APDS9306_ALS_THRES_LOW_0_REG;
> > -     else
> > -             return -EINVAL;
> > +     if (reg =3D=3D -EINVAL)
> > +             return reg;
> >
>
> Regards,
> Marcelo

