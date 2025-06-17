Return-Path: <linux-iio+bounces-20738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6364FADC79C
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 12:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025BF169937
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBD6293B7E;
	Tue, 17 Jun 2025 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU2YaZLi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B31C54AF;
	Tue, 17 Jun 2025 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155045; cv=none; b=teXFVuv5Lj8WnlzP5V8l57l7EJsv8K7opqBginZ615xM9KDQlMEUmF2aehNjDpFTh7AXwdfHuERcFwN/v7KYLGujKMls4riijb+QA8w8KhGP5SyxsfNJMjUA08W6CGGoFyTIVJSYolcOOm+oVctrgXoGI96VRvPd6UMUgzUHU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155045; c=relaxed/simple;
	bh=Oh6JNsGfOd/rf477makqU9ZFTzq4ZnDOsis1RpQYgrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aytgTJAQPQuht0nAI7rzFIaPE780YnlrXucsRbbU6Dabt33dJxPT8krwXEIOf9yIugahunz22FvfrwmRx7IagdZ9N3zpi19HBhmx6fbKXR2Pnbdbs2u7gJThGrktRf/OsG0oF4NpE7nMZ/671DJV8W9amB+YF/z34wnwCiqUV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU2YaZLi; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70b684670e7so7232457b3.2;
        Tue, 17 Jun 2025 03:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750155043; x=1750759843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZGKO5x6XdddWXc4g4w2O+8ZmZY2wX1dN9F6EdAgivM=;
        b=HU2YaZLilVvURVqcaxBVyKJix+A7Vs556V0a3OUpRi9jYQXwnCsx5GObJ11vMubULE
         dkvvFCyS7T70f3S0RzN2hQ8mAjK6WCMwwflgOX8FLJPJuQJ/uQSzmliU4LWNE/FqWH+1
         0tw5szsX7td2QJj1hVUtTnTBpHy6s4yjfuiFBENilWfOXX9or2zTMHeL1s3tm5Lazzsm
         MpZikNj66oA7YakUOYtl3UUneSfLnoaMlI0CqS5HcFu1shMlX8rWqoZ7GaHQ+QBGnqxw
         IdCKrEJeD7RtkDcvJwzfvG5tl88t6i1llqzPw0XO8s7dvBNP5Vi+v3Q1Dx6TqVlQ1zew
         IJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750155043; x=1750759843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZGKO5x6XdddWXc4g4w2O+8ZmZY2wX1dN9F6EdAgivM=;
        b=f887LeSYQ7TGrDE6+zNn7mCCFmlI0Sn3lUnUI0PQuVS+/rq2GlDMGTaH4HAbjd+tAI
         Z9vAgFhfOLJIuOxGt7AlaMSkY7DSb+EqQNqdcga28klkrHeHPdUCcDK30lzmJP5fBWh4
         6QpEbpp20IujApnilwLfpFhRY5vYjcYyoM0dejsP0wzJ9Uf36c4t97FmEOHl64Lwvp7F
         N+cG/Ecmp2F39srFkP2UW8DwOH8SO7dTmxlBn6Th0VtBv/F5tXxL5CBGFsdel8NXwbyI
         7HIKwksUBTO+0YO15LV3dH1WJl2ZMnvhysl0071Cbh5yxRaWbGqLFYiQGpQdiKMRovhL
         c9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUFP2+hF5UH7/zgrMaAFWH7pS//OVgWIHBwV6q9csKpQ0+Ej0mfdTLHUInCRI8gsYG74IeBiJqilzw=@vger.kernel.org, AJvYcCUYMjfBipHb7DVyHvcHFQ9D5wX71weOU29j0x7oDEZo1i5Vh//zIZOts7rfiTEb07idfYOhpUnupt6ZsONc@vger.kernel.org, AJvYcCWY9TlOpQO4p4uuKMO48VUi1OBeFuqQd9BHmV9S8SMIfsxrz8z3KPoyqrefdT3cL56pbp8CUmJe8mbh@vger.kernel.org
X-Gm-Message-State: AOJu0YyafvtHLK5+EbcT31FH+6LiM4Mz8XFLCllUEPu1m18xQzRqpQoU
	tCh6tbUvOW37CILeDiOcn+Lz9yRBWqfWx4zDEvoWjNMJU2W5Wf2s49m+H6RjdMSv/DbKZX6R5Ls
	OxP2+Obwp3S0pDuitn0OeU6WoNIgA9qA=
X-Gm-Gg: ASbGnctlmnn1b/CpHjF4o4J6TpIUo9ZEL6U6A3efKrX0yWmKYWjwKU8wUP9a33YzpU2
	cUjrGvX6yoHifdvc7sMFJcghDFcn3wQR/ulVbB4rankBkh/j3dOZJyyfQNPHmm6727k5Ld72Etg
	XYSL3Tw0qz5s1wm/mO+B5CZwsI3Z2xOIm61SZGEIaAEVE=
X-Google-Smtp-Source: AGHT+IEZc/AD0J55tXg6Ukf+xfhMse7bT2H6yEGuPuIv70h5Zk70N7ADYKHwKH4z9Lquuw4Es/z0zbRFpS3teMLDhv4=
X-Received: by 2002:a05:690c:690a:b0:70e:7613:e310 with SMTP id
 00721157ae682-7117536d4f7mr81090447b3.2.1750155042733; Tue, 17 Jun 2025
 03:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615222258.117771-1-l.rubusch@gmail.com> <20250615222258.117771-6-l.rubusch@gmail.com>
 <CAHp75VdWtY6nxFFTucoCRiq+tM5caL5N1yp_15=FSAZ7Vyk_7Q@mail.gmail.com>
In-Reply-To: <CAHp75VdWtY6nxFFTucoCRiq+tM5caL5N1yp_15=FSAZ7Vyk_7Q@mail.gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 17 Jun 2025 12:10:07 +0200
X-Gm-Features: AX0GCFsOTPqZtdkeHmR1IdSRpCW1YzD0FgmIWYUbxJbhg65j8g4GAiiQdgHV56c
Message-ID: <CAFXKEHYzaCCNbZo47AUHFEyS=HBFZnVNEHeQG+4VA2jhhT+yEw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] iio: accel: adxl313: add inactivity sensing
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy / Hi Jonathan,

Two questions down below.

On Mon, Jun 16, 2025 at 12:59=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 16, 2025 at 1:23=E2=80=AFAM Lothar Rubusch <l.rubusch@gmail.c=
om> wrote:
> >
[...]
> > +       switch (info) {
> > +       case IIO_EV_INFO_VALUE:
> > +               switch (dir) {
> > +               case IIO_EV_DIR_RISING:
> > +                       ret =3D regmap_read(data->regmap,
> > +                                         adxl313_act_thresh_reg[ADXL31=
3_ACTIVITY],
> > +                                         &act_threshold);
> > +                       if (ret)
> > +                               return ret;
> > +                       *val =3D act_threshold * 15625;
> > +                       *val2 =3D MICRO;
> > +                       return IIO_VAL_FRACTIONAL;
> > +               case IIO_EV_DIR_FALLING:
> > +                       ret =3D regmap_read(data->regmap,
> > +                                         adxl313_act_thresh_reg[ADXL31=
3_INACTIVITY],
> > +                                         &inact_threshold);
> > +                       if (ret)
> > +                               return ret;
>
> > +                       *val =3D inact_threshold * 15625;
> > +                       *val2 =3D MICRO;
> > +                       return IIO_VAL_FRACTIONAL;
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +       case IIO_EV_INFO_PERIOD:
> >                 ret =3D regmap_read(data->regmap,
> > -                                 adxl313_act_thresh_reg[ADXL313_ACTIVI=
TY],
> > -                                 &act_threshold);
> > +                                 ADXL313_REG_TIME_INACT,
> > +                                 &inact_time_s);
> >                 if (ret)
> >                         return ret;
> > -               *val =3D act_threshold * 15625;
> > -               *val2 =3D MICRO;
> > -               return IIO_VAL_FRACTIONAL;
> > +               *val =3D inact_time_s;
> > +               return IIO_VAL_INT;
> >         default:
> >                 return -EINVAL;
> >         }
>
> I still don't get what's wrong with helpers for nested switches?
> Instead of doing ping-pong with so many lines (due to indentation
> changes), just create a helper from the beginning. In this case this
> will look more like
>
>
>   if (nfo =3D=3D IIO_EV_INFO_VALUE)
>     return my_cool_helper_for_THIS_case(...);
>
> Note, I admit that not all the cases may be done like this, but just
> look at this again and perhaps something can be optimised.
>

First, about helpers dealing with nested switches. The resulting
structure then is like

switch (type) {
case IIO_EV_TYPE_MAG:
    switch (info) {
    case IIO_EV_INFO_VALUE:
        switch (dir) {
        case IIO_EV_DIR_RISING:  // activity
            ....
        case IIO_EV_DIR_FALLING: // inactivity
            ....
        }
        case IIO_EV_INFO_PERIOD:
            ...
    }
case IIO_EV_TYPE_MAG_ADAPTIVE:
      // same as above, again for _AC events
 ...
}

Actually I'm using a helper for nested switches. But currently I'm
adding it quite late, when I have cases for ACTIVITY, INACTIVITY and
ACTIVITY_AC and INACTIVITY_AC, since this results in code duplication.
The resulting structure the looks as follows.

helper_mag(...)
{
    switch (info) {
    case IIO_EV_INFO_VALUE:
        switch (dir) {
        case IIO_EV_DIR_RISING:  // activity
            ....
        case IIO_EV_DIR_FALLING: // inactivity
            ....
        }
        case IIO_EV_INFO_PERIOD:
            ...
    }
}

switch (type) {
case IIO_EV_TYPE_MAG:
    helper_mag(...);
case IIO_EV_TYPE_MAG_ADAPTIVE:
        // same as above, again for _AC events
    helper_mag(...);
}

Is this reasonable? For the v6 now, I plan on introducing this helper
when adding INACTIVITY sensing, having ACTIVITY already in place. This
is, because INACTIVITY as distinguishable type is still not available,
but would be needed as function argument as well. Does this make
sense? Or, should I start with the helper right at the beginning? Is
it ok to have once a nested switch in the helper?

Second question is about the adxl313_read_event_config() functions,
I'd like to have here 0 or 1 in regular cases (<0 for error). Is it ok
if I adjust the functions slightly to guarantee this? Currently it
generally returns >0 in cases of "true" which is correct. But this is
most of the times 1, in some cases can be 8 or something. I just like
it to be uniform for testing (which is not a valid argumentation). Is
this legitimate?

Best,
L

> --
> With Best Regards,
> Andy Shevchenko

