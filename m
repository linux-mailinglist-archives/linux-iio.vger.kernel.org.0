Return-Path: <linux-iio+bounces-18096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59498A889AF
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 19:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF741898438
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6EC289372;
	Mon, 14 Apr 2025 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbxuNxJA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B915C23D28C;
	Mon, 14 Apr 2025 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651322; cv=none; b=JXpjbRV0rRB3BQ2rQWWrtRh4WT4qFVJucsPg7geWLO5LVFX7mPvgpSs6AYINCT3cV94vGLT6zqNcHWotdoOZ5T4Z+KK4BnjgmsVy79BUt1DdTUux14C4os5Syv/NKK3jq1gAZpf4n9KPfUQC21PqyR1wR+H/TX8NKPdPFqydkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651322; c=relaxed/simple;
	bh=gJgT0qrecLMzwnzdXiMBAhrh8hbJvLs/ROx2YqYfSmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbW0mak62dSdJFD5Zzmn9XsduA9/+zslt7zbncrxKSiGChN0tSg3bvIX1RsaXeigQ35648Agi/wd2Zy5QEuHOBzRanvi1raK5z3wM35c++WPGiubrbSxtwluWWfYNXqxJunDsaTgTrX/TmY7kCLZm5jydlc7BcU2gCaA5pRlV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbxuNxJA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abbb12bea54so913141266b.0;
        Mon, 14 Apr 2025 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744651319; x=1745256119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUEA8pywsL8vY7oJIHJ8TdBZH9QlbHYCO4W71W5N3vo=;
        b=bbxuNxJAGo/PZz3brVUdRgiEwVfpQVAkIy2UttPS+RoOmoOq0y0anRAVoJif6xmyMr
         multwFQRHNCi88e84kgVdh6vVZV84qGF3kjRfy6tfpQ49iCeS6Dd7e1cjXyWzCLVUfB6
         HYDrS78H+hevtn7CY2nxEoO2fcd+fY3aSriXUboASjhaugS71cM+ihBivcHPt+NJOu20
         +BSU4RABxsYL80ZocXjxQdGktq6vH06F/Jhu8TwTRbO+hbTmQdNnFXZsNcMjXvkPlQp5
         TdcHm81KmHmbEVhwEofMhsncpv6iG1Bml5xFWnPhL2NPJyo6XAUYJCGCJewNRhl/TWBZ
         zgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744651319; x=1745256119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUEA8pywsL8vY7oJIHJ8TdBZH9QlbHYCO4W71W5N3vo=;
        b=J+kBVt6lSrS7VfTqedO+qi+RMivcx5udKeGTmL0PsXUV63JLapGNA9v5sbnvm+1hFA
         U1WXmbF7ce/bqPDz43Lrj0yKm5Xj+TFrz4x2u1i/nWarZJ44nQxfpoLUAtNrXom8lT+1
         1qp8gi6TE24rVw12DRV6tn0+jH/ii79PFdzJahDDvBvaNy1SYMqHtavOnC5Yvclw56eY
         UFxBHaMaX6eTTKjug9OLUHjYj9Fb5oQNa0Urn/OfFa00xqF3B/kBNmPf7wzyZwWB3INT
         2/eCbU5kQgdsBqM3Aqc1LtjYKrpjeThTeV8M+Wl+tU9cWnQnLwMmc7dYhHOFVQjL2PED
         SJVg==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZCf2lSTwVlREiRb7x7hcJbL3rVDnl/UxUFSKA2IMbBi19yuDOQyeCM9jhIZaJ2DUZ70jA0OSjUI4@vger.kernel.org, AJvYcCWs0FhiNkIs7AghXZTToPx3EX/0XWffYxwR/uQRpHZ6IWZiNEpPIJaR14Dwf0x6nvjOOvXuiWRwCprk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz979CEgUowm6lCa6aH97agJXOztsoeetElUOCyOBhsZcmXGqQI
	+oDA4yxvEKeIzQZM+F2KOg4L4SzBcmgmuyOsGPVYZJoE1Oi7yYlk2nqN2BxnES3njMQMz9dSy0U
	cdZa0Da81vbrSLa/NZ2lLKWxRELM=
X-Gm-Gg: ASbGncvpxc66qEGTwVQ9988IIwSUiFOYmahB+HDpSGGixwQYpuhpys/f10o9wE3IX1y
	hjeP3RXuov9oT5iR+/SjQEmAttWodnnRtoDwGZkp1pZE1UUtmVVoIYIkXTbaY8mMiJtszA483gE
	Wt6NYjvEnT7VXCfAFQDihpcg==
X-Google-Smtp-Source: AGHT+IHBpvvtSFgiAORqhcujhn7TqejWSBy+Cnaku323HHIyY3ursXQw4Rtz2ozfIvIF0zvF2a0AlGf3m09O3UecLv4=
X-Received: by 2002:a17:906:80c7:b0:acb:893:8c40 with SMTP id
 a640c23a62f3a-acb08938d38mr199884366b.19.1744651318757; Mon, 14 Apr 2025
 10:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409024311.19466-1-gye976@gmail.com> <20250409024311.19466-5-gye976@gmail.com>
 <CAHp75VfMHdw-6vrELbjjD3T323uDz7U9wRP5YSk2jZ26wBuLTQ@mail.gmail.com> <CAKbEznsVxexdrXX72G-tCUHjznx6na1h8MrCFPKrHd27GXht8A@mail.gmail.com>
In-Reply-To: <CAKbEznsVxexdrXX72G-tCUHjznx6na1h8MrCFPKrHd27GXht8A@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Apr 2025 20:21:22 +0300
X-Gm-Features: ATxdqUGiVarrwRMChuG8fuKSNeFGp1L83JXj5Yb3sfJZQ0h1yMSyTfQjXA_OkFE
Message-ID: <CAHp75VeU5sERbVz-4OxkJNC-pjT3B5AvfAMj09LXd6v4MdeDeg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: gyeyoung <gye976@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 6:49=E2=80=AFPM gyeyoung <gye976@gmail.com> wrote:

...

> > > +#include <linux/kernel.h>
> >
> > No usual driver has a business to include the  kernel.h. Just follow
> > the IWYU principle and make sure what you include is what you use
> > here.
>
> I thought "linux/kernel.h" was a globally essential header.

Not at all, it's a big mess which no driver should use.
And on top of that (to any header) you should not use 'proxy' headers.
It's a bad style and practice with the real consequences as build time
and headache for the others who want to clean up header dependencies
in the future.

...

> > > +       /*
> > > +        * serdev receive buffer.
> > > +        * When data is received from the MH-Z19B,
> > > +        * the 'mhz19b_receive_buf' callback function is called and f=
ills this buffer.
> > > +        */
> > > +       char buf[9];
> >
> > Should it be DMA-safe?
>
> I'm not sure if I understood your point correctly,
> This code isn't DMA-safe. I'm currently understanding why DMA-safe is nec=
essary.
> (but actually other drivers implementing 'serdev ops' use non-DMA-safe bu=
ffers.)
> I will verify this part and then send the next patch.

Because some of the UART drivers may enable DMA by default if it's
available and your code won't work on them, right? But double check if
serdev makes it DMA-safe before use.

...

> > > +       case MHZ19B_ABC_LOGIC_CMD: {
> > > +               bool enable =3D *((bool *)arg);
> >
> > Oh, no. The boolean type is a tricky one and here you probably break
> > all the possible implementation defined behaviours esp. on bigendian
> > systems.
>
> > > +               uint16_t ppm =3D *((uint16_t *)arg);
> >
> > Do you guarantee the alignment?
>
> So far, the arg has been the address of a u16 type stack variable, so
> there was no error.
> But I'll edit this by referring to the alignment documentation.

Easier to use the proper accessor, i.e. one of get_unaligned*() calls here.

...

> > Also why do you have ' < 0' parts? Please, double check that you use
> > this form of the errorcheck if and only if the callee may return a
> > positive value.
>
> Yes, this function returns either a positive value(0 ~ 2000),
> depending on the cmd argument.
> So 'if (ret < 0)' is more appropriate than 'if (ret)' in this case.

I see, so make sure that only those that may return positive values
will have the  < 0 filter, and others (that return 0 or negative error
code) use the regular form.

...

> > > +static const struct attribute_group mhz19b_attr_group =3D {
> > > +       .attrs =3D mhz19b_attrs,
> > > +};
> >
> > ATTRIBUTE_GROUP() ?
>
> I looked into the API and found only ATTRIBUTE_GROUPS(),
> But using ATTRIBUTE_GROUPS() requires the attribute_group value to be
> declared as an array ending with a NULL entry. Would this be OK?
> then i'll use ATTRIBUTE_GROUPS().

Indeed, only if you use that array, otherwise the original code is OK.

...

> > > +       for (int i =3D 0; i < len; i++)
> >
> > Why signed?
>
> Would it be better to declare 'i' as 'size_t' to match the type of 'len'?
> then I'll change 'int i' to 'size_t i'.

It will be consistent.

--=20
With Best Regards,
Andy Shevchenko

