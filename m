Return-Path: <linux-iio+bounces-20248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A5AACF78C
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 20:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BA116DE73
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E1227AC4D;
	Thu,  5 Jun 2025 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YysEkiHh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347DB27A46A
	for <linux-iio@vger.kernel.org>; Thu,  5 Jun 2025 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149769; cv=none; b=Am8Ds/0z7LcKiU0xzH16Ohc/5oclAZHL09+AETA8RxJiZDCEtt8rFb9ghJlGPR4BPv+ZQrOXWA/VEeHxc00hXonbfhfEVcGDWx2lUUXuzgSHOb78N91XUzMWdK3MK80PIse5tohUSKPjDCzc7OZHzXNWc2yBhWeoDl70oCp1BJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149769; c=relaxed/simple;
	bh=LXX+QoLltE0IRV8HzRO85U3b8JAuikJHq7Hdvjyxbxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGAqrHdrc6J8eBJUTyYa+HwYcDgWXDNeqyibv854M99aMD6qe+g0lBfiim2os1zJKnovFJb9eJxfIklo5WAJOUETAwEzSvBqspNr6uzDpc9ynL8pH+fcaMEql6jNVSUoJ97F2SM5FzmxQgni50P1ZH8Un0NfSP2aC62XdNaebIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YysEkiHh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-604b9c53f6fso2686197a12.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Jun 2025 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749149755; x=1749754555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlHE3WYJWkRMZAcLKAkqXydmZUXuN9/77yCuUgcz3qE=;
        b=YysEkiHhJt1cI2UZWHnSgHnOrbKOPzfZeZDJyoP2gH/AuATJIDmUqLE1noLuxYXArq
         ZAjg1TOLsauaWgTFOnfz0MqV7ABABfGE+r93NGWwjP6C93Oie56q/8ochQm1Fj/DaupX
         jogEQ/qcDeOdEziliCa5xZ1Ow6/0Coshl5fg/X2INWZqYvMJoYTYhKx2iL8HjwlQu/JE
         t7s+8RpDeIkH9uMRCh4svWPEBmVV/s0pG/dGnFpJ465ay4Es0iU7Q0jJBhNCRA/KTUph
         F+SL4YvyrvrpqXhr6jVtYhNtjSc75dLvREjAIIAsotNYHHZm8mJzeYSlpuPF6uDTwDLs
         g8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749149755; x=1749754555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlHE3WYJWkRMZAcLKAkqXydmZUXuN9/77yCuUgcz3qE=;
        b=R82BPLj84E7t5WIhhbU2beU9OC9qKunApB9JCYcjuyKDiPvBr/ONK4JohE89pzSKlF
         ucnZP2uBrJ1+RlTlRr5F01PBaiUr2GeJDbyPsamLGpepjmDpurOqAIiPwg8KsGA08jsR
         jn/DXyCb2Q9C9emnZ54rRGsxsZLD2Gaq5ZET5m9bv20MU6Zq08Na5DaripAkf4ptrWl2
         oNZ1t16L86hwmM2x7neTwu6DS2E0fLiFhIWF/WR5TGBw70p5M3tPIZSeiA9MV8pamV2I
         9G/331w5XkQdoKwODaSbQXvcsPUbV4Dhd07r3Uxw3gkSvwSrdE4rcHgU129VxVYJo/Cz
         NwCg==
X-Forwarded-Encrypted: i=1; AJvYcCV5JfdbHXblalALvDh64maEvfekh7ButPNzKmBmyJiGY1JYotWVoMQibMJ1nGiehRjo7MJzKRuzVG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFx1NsIx1Sofcqxl9uwcYlnMyDytvJo6ZyUdRu3ThqyThpkMz5
	hZqMDk5BoLumRt+CkHj4a6J2XIOh5P3poXoT9ozSG/wM9BkcOHgDSwyClAjVgmExT1QjYvBa3SI
	zSG38jIi4if+Udyts307HcxKzc8LNT8c=
X-Gm-Gg: ASbGncvA+TbHMq02fFdYaHpQr8MENjKdGUtt6qkzVoT0VKLvHxBLdo3Mziw8CbP/goi
	K+EMli1WD6s5v2A8uOuyUqO1dF30d7ohrPiBEFjoljh5KOx/kNwuSJ1SawviTDtN/hzzCz5MbSI
	2lGqopFNugD4emcm58iJN120Nb9H4TnCbpUVgo3QKozg==
X-Google-Smtp-Source: AGHT+IHTPsgdyBarJS0oL5q6/yZbutoxwAHNUqesHV6WXaRWPuItK44ABbkhFZSa7x6deeVAX4fy+pio2vxkjvZH1s0=
X-Received: by 2002:a17:907:1c95:b0:ad8:9f9d:b139 with SMTP id
 a640c23a62f3a-ade1a8ec826mr39352366b.5.1749149755229; Thu, 05 Jun 2025
 11:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526235906.6598-1-nattanferreira58@gmail.com> <20250531182344.2c3a370e@jic23-huawei>
In-Reply-To: <20250531182344.2c3a370e@jic23-huawei>
From: Nattan Ferreira <nattanferreira58@gmail.com>
Date: Thu, 5 Jun 2025 15:55:43 -0300
X-Gm-Features: AX0GCFt_Fmz2-yS5HZnSRy-lEbXhEW6KsZLlS0-dpeKN4cwhSbbInxetg8liL8k
Message-ID: <CAKj1jXoKJn_Pk=uAd1ouTO_4ho=kkZf_2dm7j-XPV-=1kY6cbw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: apds9306: Refactor threshold get/set
 functions to use helper
To: Jonathan Cameron <jic23@kernel.org>
Cc: subhajit.ghosh@tweaklogic.com, Lucas Antonio <lucasantonio.santos@usp.br>, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

I accidentally sent the v4 patch with the v3 description. Please
kindly disregard this patch.

I will send the corrected v4 shortly with the proper description.

Thank you for your understanding.

Best regards,
Nattan Ferreira

On Sat, May 31, 2025 at 2:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 26 May 2025 20:59:06 -0300
> nattan <nattanferreira58@gmail.com> wrote:
>
> > From: Nattan Ferreira <nattanferreira58@gmail.com>
> >
> > Refactor the apds9306_event_thresh_get and apds9306_event_thresh_set
> > functions to use a helper function (apds9306_get_thresh_reg) for obtain=
ing the
> > correct register based on the direction of the event. This improves cod=
e
> > readability and maintains consistency
> > in accessing threshold registers.
> >
> > Signed-off-by: Nattan Ferreira <nattanferreira58@gmail.com>
> > Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
> > Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>
> > ---
> Change log?
>
> Also this seems to be the second v3.
>
> >  drivers/iio/light/apds9306.c | 36 ++++++++++++++++++++----------------
> >  1 file changed, 20 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.=
c
> > index 69a0d609c..9216d4974 100644
> > --- a/drivers/iio/light/apds9306.c
> > +++ b/drivers/iio/light/apds9306.c
> > @@ -744,20 +744,27 @@ static int apds9306_event_period_set(struct apds9=
306_data *data, int val)
> >       return regmap_field_write(rf->int_persist_val, val);
> >  }
> >
> > -static int apds9306_event_thresh_get(struct apds9306_data *data, int d=
ir,
> > -                                  int *val)
> > +static int apds9306_get_thresh_reg(int dir)
> >  {
> > -     int var, ret;
> > -     u8 buff[3];
> > -
> >       if (dir =3D=3D IIO_EV_DIR_RISING)
> > -             var =3D APDS9306_ALS_THRES_UP_0_REG;
> > +             return APDS9306_ALS_THRES_UP_0_REG;
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
> >
> > -     ret =3D regmap_bulk_read(data->regmap, var, buff, sizeof(buff));
> > +     reg =3D apds9306_get_thresh_reg(dir);
> > +     if (reg < 0)
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
> >
> > -     if (dir =3D=3D IIO_EV_DIR_RISING)
> > -             var =3D APDS9306_ALS_THRES_UP_0_REG;
> > -     else if (dir =3D=3D IIO_EV_DIR_FALLING)
> > -             var =3D APDS9306_ALS_THRES_LOW_0_REG;
> > -     else
> > -             return -EINVAL;
> > +     reg =3D apds9306_get_thresh_reg(dir);
> > +     if (reg < 0)
> > +             return reg;
> >
> >       if (!in_range(val, 0, APDS9306_ALS_THRES_VAL_MAX))
> >               return -EINVAL;
> >
> >       put_unaligned_le24(val, buff);
> >
> > -     return regmap_bulk_write(data->regmap, var, buff, sizeof(buff));
> > +     return regmap_bulk_write(data->regmap, reg, buff, sizeof(buff));
> >  }
> >
> >  static int apds9306_event_thresh_adaptive_get(struct apds9306_data *da=
ta, int *val)
>

