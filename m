Return-Path: <linux-iio+bounces-20739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA2BADCA0B
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 13:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9C217581A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8FD2DF3F0;
	Tue, 17 Jun 2025 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEkTWDgK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848ED2DF3E5;
	Tue, 17 Jun 2025 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161315; cv=none; b=fkUHK3h/+SOD+CXKVQ+LbLLoHH2cGivuplaQSLg2CBxVIFtEnB7TrBnm2ehAm7f1hseExz0QzIIw+pLTSqoNxGfCBYl6C7R79OgPFzYaCsTHvPLwYstI86bu1nCpSUgAKLDSudOeeKFWnJURh85zO3FkJVx0y6O/1LVts0ShccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161315; c=relaxed/simple;
	bh=1mdzfzKY2H5RvEK9/I1kxmjAzNzCY7/xCZXh85LBGB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxgbYU+XyHrVFYFCgiNgUXkBce9lNwyzJLhIVzlpru/umPFFy5GiGv0EuAY++DHN3Asc30UX0W1v11W5KNJnXpLv6zZ07xQ2pFaEMTp2zLRt83fTMdY6rRoRJumlTkmoDu8b8rmQl7zdbVcGycxMm1Q0Rw7tdOzQrrPt9lNnrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEkTWDgK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad88d77314bso1241475066b.1;
        Tue, 17 Jun 2025 04:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750161312; x=1750766112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5Oyc6Nb5eleQJDRHBvWia2WFxGzJ8AhQsoAb9pIQzw=;
        b=NEkTWDgKTZ0pYOJAjnUOTStCbWC8MrqQWVimioPXkYKXEvQNjGWQPIHf0U7hI3I+dQ
         JiuF7zLmqY0uzx8Q6CSlD7u1tITtOLK0xA8cK1MHi2jiP+ebAVcQeARzc8dtcRgGhZ9x
         Slt3/2MPSRrButbQU1WeIuFWY03PSfwZGSLRWKGANyBqcXWPgGIHBkOaP0U0mSPooKZ5
         riXOWSi2fHsRFBDcfPaBuxL6bgESs9LUV7Jw+h04Hbs6tetDEt4p10xzXg97lNBc45hg
         aQGgxsJ4M3m772vkzNHSdnemGU7zWb1Fg2YNrHmViuen+upoIiDIjBCYHP76jG73a28E
         HFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750161312; x=1750766112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5Oyc6Nb5eleQJDRHBvWia2WFxGzJ8AhQsoAb9pIQzw=;
        b=q6bkeD6hf15IlQl1Npb0M6Z5/Clmhlo2qAjCtTkxh7/VB9bKMM+uWo/9ApcyBG8lQw
         OQ8DP/+pUu6YXB6NQfpX5y2GeWF9LHrPxJITGWg9OB14A5r7CrRkK58WgiOE9isaI8ev
         w0lQaD/00Qp8YdSsq/z7SIvcQzycxd7X9l/up9BzByuUvawWl4FHuRDTbVNAjgwXiaIs
         PsJNrsjbKLhid+39RQXM1VjDVnJBw4BLlI8s+UNfw2TjQUcq6KeHob3WPjFKSeS2rvk7
         Hd5gLJSAQaYjDdPMuQzYt0jFFBcaAbplH8rFZws9P5vmUrN+XD8OaBCCzSZS1LblS03X
         xhKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU71Zf3iK+yOvz3afxjwafCiOr9HkRHLrIpW6ET8d7PoABIRwRkWwUHlnJ96/JVdx+scY9O+TVf084=@vger.kernel.org, AJvYcCVIY3tragJ1fqTum7BJjBKLCWOiiNP6Ol+E1xBIfFF2yzfChDQGjZMhf1yO6cv/DkLBEC9L1PcqlpxO@vger.kernel.org, AJvYcCXmRdXTTstQkhm+doXcpCwfpq6I6j2pgQ4jJ+10p+LFTRuRLsM7dE0bInjIhkdtttiAwrTGhDAzCWONLBEF@vger.kernel.org
X-Gm-Message-State: AOJu0YxE44cJKXjl+PIhRZ15+WPKmuJPL6FBLKomTQBdU+z3dRrkjMTQ
	FdBVO1ONt77BEgaRI8Ho4pDFSJyksDRtLHvCF4IrnegZ+AIGFEKLDBP6gsUHEnJLh7NVlDoPA8z
	zrlTxlvfB7q9lDcup8JwkctTl8fwKe5I=
X-Gm-Gg: ASbGncuPfkpqjDJ3C7rv70X+Pg+pvFoWyiAzwwQQn0UwdvhYlbnDh6+lodjnWcUhITP
	7u0xBtYQhzzxenU0WNuFX9eXebx9yNdw/IH4Knnc0hGpUH/bdiYlBT80h+dU80s2bXudbKofZIA
	cyBqyzb6I1/fA4X/onAUhK791yQovFi5XYn2Uga6DijY981A==
X-Google-Smtp-Source: AGHT+IE6ecDP+jSmXMWWxoAXtXPEY1Y64xRVJKCLhMyqxuvRkxxX5n8x3JBcxUdDDseal6dmwhL67NBQE9f9wzc0CiQ=
X-Received: by 2002:a17:907:1ca2:b0:add:fa4e:8a61 with SMTP id
 a640c23a62f3a-adfad53d2cdmr1362691666b.38.1750161311622; Tue, 17 Jun 2025
 04:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615222258.117771-1-l.rubusch@gmail.com> <20250615222258.117771-6-l.rubusch@gmail.com>
 <CAHp75VdWtY6nxFFTucoCRiq+tM5caL5N1yp_15=FSAZ7Vyk_7Q@mail.gmail.com> <CAFXKEHYzaCCNbZo47AUHFEyS=HBFZnVNEHeQG+4VA2jhhT+yEw@mail.gmail.com>
In-Reply-To: <CAFXKEHYzaCCNbZo47AUHFEyS=HBFZnVNEHeQG+4VA2jhhT+yEw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 17 Jun 2025 14:54:35 +0300
X-Gm-Features: AX0GCFvqVsLjg7NVzpiLV7joBeHOpKz_dSx-5s5g22mcanhHrTnZaIYNIG97mW4
Message-ID: <CAHp75VeDj1sE55_PdR6=QHAT-Nv0fwv3kss=7oeh8isdmOMoOw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] iio: accel: adxl313: add inactivity sensing
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 1:10=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.com=
> wrote:
> On Mon, Jun 16, 2025 at 12:59=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jun 16, 2025 at 1:23=E2=80=AFAM Lothar Rubusch <l.rubusch@gmail=
.com> wrote:

[...]

> > > +       switch (info) {
> > > +       case IIO_EV_INFO_VALUE:
> > > +               switch (dir) {
> > > +               case IIO_EV_DIR_RISING:
> > > +                       ret =3D regmap_read(data->regmap,
> > > +                                         adxl313_act_thresh_reg[ADXL=
313_ACTIVITY],
> > > +                                         &act_threshold);
> > > +                       if (ret)
> > > +                               return ret;
> > > +                       *val =3D act_threshold * 15625;
> > > +                       *val2 =3D MICRO;
> > > +                       return IIO_VAL_FRACTIONAL;
> > > +               case IIO_EV_DIR_FALLING:
> > > +                       ret =3D regmap_read(data->regmap,
> > > +                                         adxl313_act_thresh_reg[ADXL=
313_INACTIVITY],
> > > +                                         &inact_threshold);
> > > +                       if (ret)
> > > +                               return ret;
> >
> > > +                       *val =3D inact_threshold * 15625;
> > > +                       *val2 =3D MICRO;
> > > +                       return IIO_VAL_FRACTIONAL;
> > > +               default:
> > > +                       return -EINVAL;
> > > +               }
> > > +       case IIO_EV_INFO_PERIOD:
> > >                 ret =3D regmap_read(data->regmap,
> > > -                                 adxl313_act_thresh_reg[ADXL313_ACTI=
VITY],
> > > -                                 &act_threshold);
> > > +                                 ADXL313_REG_TIME_INACT,
> > > +                                 &inact_time_s);
> > >                 if (ret)
> > >                         return ret;
> > > -               *val =3D act_threshold * 15625;
> > > -               *val2 =3D MICRO;
> > > -               return IIO_VAL_FRACTIONAL;
> > > +               *val =3D inact_time_s;
> > > +               return IIO_VAL_INT;
> > >         default:
> > >                 return -EINVAL;
> > >         }
> >
> > I still don't get what's wrong with helpers for nested switches?
> > Instead of doing ping-pong with so many lines (due to indentation
> > changes), just create a helper from the beginning. In this case this
> > will look more like
> >
> >   if (nfo =3D=3D IIO_EV_INFO_VALUE)
> >     return my_cool_helper_for_THIS_case(...);
> >
> > Note, I admit that not all the cases may be done like this, but just
> > look at this again and perhaps something can be optimised.
>
> First, about helpers dealing with nested switches. The resulting
> structure then is like
>
> switch (type) {
> case IIO_EV_TYPE_MAG:
>     switch (info) {
>     case IIO_EV_INFO_VALUE:
>         switch (dir) {
>         case IIO_EV_DIR_RISING:  // activity
>             ....
>         case IIO_EV_DIR_FALLING: // inactivity
>             ....
>         }
>         case IIO_EV_INFO_PERIOD:
>             ...
>     }
> case IIO_EV_TYPE_MAG_ADAPTIVE:
>       // same as above, again for _AC events
>  ...
> }
>
> Actually I'm using a helper for nested switches. But currently I'm
> adding it quite late, when I have cases for ACTIVITY, INACTIVITY and
> ACTIVITY_AC and INACTIVITY_AC, since this results in code duplication.
> The resulting structure the looks as follows.
>
> helper_mag(...)
> {
>     switch (info) {
>     case IIO_EV_INFO_VALUE:
>         switch (dir) {
>         case IIO_EV_DIR_RISING:  // activity
>             ....
>         case IIO_EV_DIR_FALLING: // inactivity
>             ....
>         }
>         case IIO_EV_INFO_PERIOD:
>             ...
>     }
> }
>
> switch (type) {
> case IIO_EV_TYPE_MAG:
>     helper_mag(...);
> case IIO_EV_TYPE_MAG_ADAPTIVE:
>         // same as above, again for _AC events
>     helper_mag(...);
> }
>
> Is this reasonable? For the v6 now, I plan on introducing this helper
> when adding INACTIVITY sensing, having ACTIVITY already in place. This
> is, because INACTIVITY as distinguishable type is still not available,
> but would be needed as function argument as well. Does this make
> sense? Or, should I start with the helper right at the beginning? Is
> it ok to have once a nested switch in the helper?

Yes, that's what even would propose here, is to make a helper with the
current code (if it's not empty) and then fill it with the content. In
any case try and see.

The (end) idea is to have only one level of the switch-case per
function in this case and use helpers for the inner ones:

foo()
{
  if (...)
    return -EINVAL;
  switch (dir) {
  case BAZ:
    ...
    break;
  }
}

switch (type) {
case FOO:
  return _do_foo();
}

> Second question is about the adxl313_read_event_config() functions,
> I'd like to have here 0 or 1 in regular cases (<0 for error). Is it ok
> if I adjust the functions slightly to guarantee this? Currently it
> generally returns >0 in cases of "true" which is correct. But this is
> most of the times 1, in some cases can be 8 or something. I just like
> it to be uniform for testing (which is not a valid argumentation). Is
> this legitimate?

If this is an ABI, better to unify this to have the same meaning of
each of the returned values independently on the functions, if this is
just an internal, who cares? However, there is, of course, a corner
case if MSB is set and you will return a (positive) value as an error
code. So, just look at the functions and decide which path you take.

--=20
With Best Regards,
Andy Shevchenko

