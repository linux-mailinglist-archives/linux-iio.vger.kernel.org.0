Return-Path: <linux-iio+bounces-20449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1BFAD5AD0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A741885087
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1201D130E;
	Wed, 11 Jun 2025 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDpVTmX0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A61B0412;
	Wed, 11 Jun 2025 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656248; cv=none; b=PBe6a1VZ0mxrZ6VTdittKI42HikrsEQWPgBHwN1DQ7broOQWj7TXAsnxuouLkJ4f71bTrloogNEPoIQR3YJyvgGK2l6aJvF8XwSQZwHc+wWw4F++8nGcCHjOZmPPvgBrkPzDSfPAb+205PNab9OhO+wtgVPGuJUftF3VBXmV3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656248; c=relaxed/simple;
	bh=zydGsoJ/S/NJH8WtNAq5YLFgUzXRJ6uRpo4oan+dE5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d27tCiXKWKBY5F/Nyzpd9g4UoJ0sH0MiHUPOesXmJXDbO6MHeAjtbOj10Bcl9Dsa1qvZKwYZmQ5r4GoKGfHFXYlHiVRyLyRf4LtFXTDj0ycJEYGMqcs96wbIvpADIk0hC6SbcMxToYsdB065SKrHjPHs1+sLMoATsG3Y6dei6nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDpVTmX0; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-706e7babc4eso700157b3.2;
        Wed, 11 Jun 2025 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749656246; x=1750261046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hju1JohcrRegQpVLjL1i+5W7BjQrb1wxNIxsFn7asag=;
        b=jDpVTmX0+Tn3TG74BlVaQw2XhuKajuU5qva7LkPBMB+8HS+lOzkMoOC4r+PpfDAFwP
         jB7lfLM9uq08dk22sWDoUHYcxn+VNfoijhwtAZdD+HfDoWj7UJE09qh4BvVOu2B9kP3F
         TCqiqxYcxkBu/ZJwyc7lcNP4qzmYgyCWh5bNcRJ+L8UYabvG1xrutM62904FnhIt1xkC
         jDvq6WN7IUcshINmkKJQEcsF1zb4oncwrz/qRJKQOe7h6PYcawnYjv/k1APzTYdcsMhI
         sTHmz1pqRXWi9zHEuQbqMdO6F7d/3be9uKPQmCwvn5grDwKN5lj14euRRKaUBdfI12FV
         rpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749656246; x=1750261046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hju1JohcrRegQpVLjL1i+5W7BjQrb1wxNIxsFn7asag=;
        b=grgGh8VJwzwHh7IB5S7KR4tW7L/jomuiCUSm121g4dKjvAUIzDNzjDrUh/Us3X/wRL
         7go9HdW/VOUVULzgWjh3IFO6d9JZLh3XU/wYKA0kw2eNLah6lQDAqnbsn57Uv1J0NkdP
         v+wipcWm8Bbr5AokTtrlwfhMpK79CgL6XQKJo2gFy8LFySa+qz6LjYZJ+Uga1/MDz/rc
         d7AwY4diRUiUHir+tT4YcJxP9HVpcOQJFFNVo17AvoAn3zJXVxJbWpnO10tjDvbiOGum
         SJ5+d1prHlqueCZL+1/nty3RIhBnxO24UY4HVcsUtEeI1vCQ/y+FLmX1jdwK/XowWQp9
         1XfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPnDhpdUOcXfSWCKWDtisb6tYab7RVJEF5c7nNkWErw4aaHDnhD6u6Wm0Jzz96NbzxbxKdg5oeppaQvMe9@vger.kernel.org, AJvYcCWy/vGwsT4BdoRWJJc20ebvsfdXPTwBcTpKC5IvaWWVe5XCnoKhpslVMz4xoEpX1+ZHOs0km3rhkBLg@vger.kernel.org, AJvYcCX+RbN8NiWe8yNiErbCmvARsXiW/NKT7qVudU9YJE1he8wKJOsJAbczcKyOHBTI5CeD7AUKzn6OmP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwYzD0OncYmgA0Bypz585sdb/QFcrcHTBN0EwnlDcysw/C0Rz
	tytDyCrVWHYAHOmI4CwfjBlilgPch4NeSpFoHYkEsoGsPUJpssrlxwmsU8QV7vJn2sOrZERDCc6
	NowiD1KIN4aGen9hJ3R9e6KVpbCCFnZq8PA==
X-Gm-Gg: ASbGnctzfstlmKuTYMRjdGEVFb8cr0fHXhjxCjRwC6Ppqp+SzvGf4vApYgRhw1XXbKN
	Cao13V4JJg3Jc2Mumm0IDHrcimThdfK+qdv+KeET9ucZ25CpfT+pgS59WoDjufGZaLA6Bsy8F3S
	faNKz95L5gu+steyKQSshabxiAEbQjErvvqQyrOFjgpp97KKYjoNZ74w==
X-Google-Smtp-Source: AGHT+IGeMZl5mUz14ekaIyfrS7U2592WmIdqit7bIWdFFD45YhUdnMs7zWOw2JShIWrSV+j10DNVlMgWixfip3MlpYw=
X-Received: by 2002:a05:690c:45c1:b0:70e:4cdc:6e51 with SMTP id
 00721157ae682-711409ee0f4mr24751957b3.1.1749656245706; Wed, 11 Jun 2025
 08:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-9-l.rubusch@gmail.com>
 <CAHp75Vd=mzfVN_UBUHAkTyj2Ap_tz76AB0LtKEz28pR=WmNzog@mail.gmail.com>
In-Reply-To: <CAHp75Vd=mzfVN_UBUHAkTyj2Ap_tz76AB0LtKEz28pR=WmNzog@mail.gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 11 Jun 2025 17:36:49 +0200
X-Gm-Features: AX0GCFtIOlDEzKGW5nVeQK78ZYYesN_faqmntukiAD9GLJCKsmN4Zdvpv_ZvDus
Message-ID: <CAFXKEHYP6o5vzsSP24SLUSs+Tu2Oqm=oVf71xy8EKKD5hoCQqg@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] iio: accel: adxl313: add inactivity sensing
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 9:46=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Jun 1, 2025 at 8:22=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.co=
m> wrote:
> >
> > Extend the interrupt handler to process interrupts as inactivity events=
.
> > Add functions to set threshold and period registers for inactivity. Add
> > functions to enable / disable inactivity. Extend the fake iio channel t=
o
>
> IIO
>
> > deal with inactivity events on x, y and z combined with AND.
>
> ...
>
> > +static int adxl313_set_inact_time_s(struct adxl313_data *data,
> > +                                   unsigned int val_s)
> > +{
> > +       unsigned int max_boundary =3D 255;
>
> This is unclear how it's defined. What is the limit behind? Size of a
> bit field? Decimal value from the datasheet?
>
> The forms of (BIT(8) - 1) or GENMASK(7, 0) may be better depending on
> the answers to the above questions.
>
> > +       unsigned int val =3D min(val_s, max_boundary);
> > +
> > +       return regmap_write(data->regmap, ADXL313_REG_TIME_INACT, val);
> > +}
>
> ...
>
> > -       axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> > +       if (type =3D=3D ADXL313_ACTIVITY)
> > +               axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> > +       else
> > +               axis_en =3D FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl);
>
> Even with this change my previous comment stays.
>
> ...
>
> > +       en =3D cmd_en && threshold;
> > +       if (type =3D=3D ADXL313_INACTIVITY) {
> > +               ret =3D regmap_read(data->regmap, ADXL313_REG_TIME_INAC=
T, &inact_time_s);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               en =3D en && inact_time_s;
> > +       }
>
> ...
>
> > -       if (info !=3D IIO_EV_INFO_VALUE)
> > -               return -EINVAL;
> > -
> > -       /* Scale factor 15.625 mg/LSB */
> > -       regval =3D DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> > -       switch (dir) {
> > -       case IIO_EV_DIR_RISING:
> > -               ret =3D regmap_write(data->regmap,
> > -                                  adxl313_act_thresh_reg[ADXL313_ACTIV=
ITY],
> > -                                  regval);
>
> Hmm... This was added by the previous patches, right? Why can't it be
> done as a switch case to begin with? I remember one of the previous
> versions had some nested switch-cases, perhaps you need to rethink on
> how to split the code between functions to avoid too much nesting (add
> some helper functions?).

The point here is, as I mentioned in the other mail:
Initially, I wanted to build up the final switch/case struct i.e.
going by MAG/MAG_ADAPTIVE, then INFO_VALUE -> RISING / FALLING and
PERIOD.

This will distinguish properties for four different types of events,
of course it then also will use separate functions. As I uderstood
your review, why starting with switch/case, do
if (!MAG event) then, return right away. I implemented that as I
understood. For further switch/case-ing, I did the same.
Now, patch by patch, it grows. Thus the if-not-back-out lines will be
moved out and replaced by switch/case. Worse, with every level switch
case, all existing code needs indention, thus reading through the
patches show (too) many changes.

How can I improve to help you reviewing this or make the feedback more
useful for me? Or is my approach wrong? I'd like to start with the
switch case right away, then just add up what comes in with every
other patch. If so, you'd only see the changes, since the final
structure of this is already clear, because very similar to all
iio/accel drivers at least (as you probably know better than me).

>
> > +       switch (info) {
> > +       case IIO_EV_INFO_VALUE:
> > +               /* Scale factor 15.625 mg/LSB */
> > +               regval =3D DIV_ROUND_CLOSEST(MICRO * val + val2, 15625)=
;
> > +               switch (dir) {
> > +               case IIO_EV_DIR_RISING:
> > +                       ret =3D regmap_write(data->regmap,
> > +                                          adxl313_act_thresh_reg[ADXL3=
13_ACTIVITY],
> > +                                          regval);
> > +                       if (ret)
> > +                               return ret;
> > +                       return adxl313_set_measure_en(data, true);
> > +               case IIO_EV_DIR_FALLING:
> > +                       ret =3D regmap_write(data->regmap,
> > +                                          adxl313_act_thresh_reg[ADXL3=
13_INACTIVITY],
> > +                                          regval);
> > +                       if (ret)
> > +                               return ret;
> > +                       return adxl313_set_measure_en(data, true);
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +       case IIO_EV_INFO_PERIOD:
> > +               ret =3D adxl313_set_inact_time_s(data, val);
> >                 if (ret)
> >                         return ret;
> >                 return adxl313_set_measure_en(data, true);
>
> --
> With Best Regards,
> Andy Shevchenko

