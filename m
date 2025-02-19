Return-Path: <linux-iio+bounces-15796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1806AA3C346
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 16:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEDA1189B9F5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445421F4167;
	Wed, 19 Feb 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwjf7v7P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B771DE3DB;
	Wed, 19 Feb 2025 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978010; cv=none; b=A73BEtmI0WtJXtiYP0EMpix2uMEVyGoX9bsj4g1um1fHSLm9lGCH7sgsbPTIl5QP3/qpOsiKg3ZDXiBPzk2kLXjDBvyyPd1m6IVlGfOwyPrraAuHWtu7thRZdEJVXNAOH4g21qEyDDccKrjIdV7m66icUf8+LGKdow3IwH+P/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978010; c=relaxed/simple;
	bh=heG+JSCrMhZza5YuqnAywconlxDmO02WZfs3lNmw9Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIlB5xS2L0D2IFXKeIHVu+J6kvKGXqX/zaB7eDp90xKR1Fyc7fBkIqUuKtw9uD7pkagD+fyZ8H9vmtTbeXpv53xfR1AQ5TWa/6I22+2Tl8A2OCvrNseWZAVBvWJV/5XQjJ4H3JLSeWXjTcaJKEbnBeXykGdJA64qVVz0uADXSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lwjf7v7P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so6184195e9.0;
        Wed, 19 Feb 2025 07:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739978006; x=1740582806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drt0+j9GwUEYRUPa0Msh+AZlxPlFbPJs9VWQL5t8VpM=;
        b=Lwjf7v7PdDf4mMOlt8lMlilhGB5p6pDB0ILCE48LPI0R/ZV+dQ/W1rqfk2hacCUagI
         o/Jdc1Bv50fkT4BYH7PiixWoNad9VzMCO/Q7TwyHFvPR1+4PLkszCBDPRb4fdYoFrMTj
         aOWYHI8W6uafgN51U2yk3JUaOAR1pyFuyy9C7m8TBYTcG/A96OXN1aQcLiJC/52b4rz2
         ysXu/DO0wxB4I010RJ8KhPDjA5FjX+RdVUvqaSxFOrYxTMPjuJ7nzs6lxmyZLFiiIhtx
         70sPMmUdHKkslqItYql0UVanOehjbHhx4Bu5f1tMvt/GsNCHJnkLoTuLlWY8xY62Dwxo
         6dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739978006; x=1740582806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drt0+j9GwUEYRUPa0Msh+AZlxPlFbPJs9VWQL5t8VpM=;
        b=WuLjwOoYQzN6/trbiteqy88sPNV4H4DQx61bBn7aYxTaYtoDv0mXz2D2GgmqMISxmE
         QjPpUpb2nmTzFkJz12EESETvctg8nkLoNip5D5vOTk24GdBOTeDAAUFH5t5sb/86VBWB
         UMfMc978ZAxELWIZn0DedtxjG2UYwBw1eaxAEbO1Ngx7mB0cjN5oc5uLjj/emFbggqwz
         kdmE4/6eFFQGLKGutS6zyWDt3sF4PdVe34wDRyX6yBWJyy0jEDGp8G7QnvSNi0yZ+5+a
         peLfXi9pNnbvsZG6fx85yyIqllbThttOo4YqZsrUe/dDItkbKK5UfOWN8bpP3rxR2ZkN
         UV6w==
X-Forwarded-Encrypted: i=1; AJvYcCVxbz+iIqb2Wz/h2fyMvsBGIVBJwJBr4FRP7B3ozsf+QBqOE2mwRuS0G0HwBzKZhEhnHAnf5f08aZ7G@vger.kernel.org, AJvYcCW6JhEA7w6VYTcuLzlXl41xdJl6V7IluLtwMmFGO71u4rUuEwA6dl/TXtTQiLcmR7FLcAKL+M73jafR@vger.kernel.org, AJvYcCW6VqydYS4MnuTX5ZVAauN8ug8ZMLG07Y12KjKCyj2Hv2G+DHqllTT/xBUDhiqfaBi1giOXlqTnXMDCtmA=@vger.kernel.org, AJvYcCWTBkHIJmi33EqNs3OkJEN1kmSvqDXTpjO8FPZ3IX3JCuED2kpS5jFNXqaqxdfPFxF/h3KkjZxyAzq9bLyu@vger.kernel.org, AJvYcCXA7cZOt8zMS77X+iuH9QqyEVllPLn0C0S94YyTayuyKuaE/BdUO+4lbj6N1/M+i9hDoNF2x1Yfy+o1EA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmN6/V+lh440R0pyJ2GfV/xHfOX85W2wH2PFj+/3/JPvW8hI7
	YO6cfSiWjMzCTZOnOPSkUXRHlr/0HqLjR+qJtetHPTasRh6JauGfHnDsbK1a5T/0r/IFA2RqCcP
	8QZXUc/C2EpCPuOGGa8oLQmarSc8=
X-Gm-Gg: ASbGncsQs+W51MTGRYpxhKM25kwYAi590rRcLChepQe6R2/InIdEYnTmf64sakETWRi
	y9/5vBZBHiyzN+2b6zufYEgh/j4PLAlPFV2H4HAwScThrsjFFgSVJWTQdMx214KMiMh1+zF9lGw
	==
X-Google-Smtp-Source: AGHT+IGZjyYv7inH5rGul4/nFCxLPjiYnaafDWPgkEdRu9+5PeRR1GZ+8z1ALgaPlmJj0wiSt+tzaqhh5lN+rJfpqVs=
X-Received: by 2002:a05:6000:1fa1:b0:38d:c6b8:9fe1 with SMTP id
 ffacd0b85a97d-38f57ea1cfcmr3735864f8f.24.1739978006290; Wed, 19 Feb 2025
 07:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218132702.114669-1-clamor95@gmail.com> <20250218132702.114669-3-clamor95@gmail.com>
 <Z7XqKcOUt5niXzpv@smile.fi.intel.com> <CAPVz0n1_WQyOHhtEVAh53uhEUhZvqqZSEJh6XALtSrVfkMSLYw@mail.gmail.com>
 <Z7XzgfHcjyK_UZKv@smile.fi.intel.com>
In-Reply-To: <Z7XzgfHcjyK_UZKv@smile.fi.intel.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 19 Feb 2025 17:13:15 +0200
X-Gm-Features: AWEUYZkkApm2pdMCm-ce2W0NUEFkWtCs86nFAeRIR60gASygQyZJcvz4RbQHc2Q
Message-ID: <CAPVz0n2WwAOb1UU7J7aDTdhXXCaAZkCpYjW_nc_CBRgkGWdEOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mfd: lm3533: convert to use OF
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 19 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 17:07 Andy=
 Shevchenko
<andriy.shevchenko@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 19, 2025 at 04:36:38PM +0200, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 19 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:27 =
Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > On Tue, Feb 18, 2025 at 03:27:00PM +0200, Svyatoslav Ryhel wrote:
> > > > Remove platform data and fully relay on OF and device tree
> > > > parsing and binding devices.
> > >
> > > Thanks for following the advice, but the problem with this change as =
it does
> > > too much at once. It should be split to a few simpler ones.
> > > On top of that, this removes MFD participation from the driver but le=
aves it
> > > under MFD realm. Moreover, looking briefly at the code it looks like =
it open
> > > codes the parts of MFD. The latter needs a very goo justification whi=
ch commit
> > > message is missing.
>
> ...
>
> > Splitting this into a set of commits would be nearly impossible,
>
> I don't buy this.
> One patch can introduce device property support.
> Another one removes the old platform data interface.
>
> So, at bare minimum there will be two patches. (Besides the advice to hav=
e
> two more.)
>
> > original driver does not relay on OF, it relays on platform data.
>
> And?..
>
> > Ripping out platform data will leave behind a broken useless driver.
>
> Hmm... This cna be the case if and only if we have the user in kernel.
> Is this the case?
>
> > So it has to be done simultaneously.
>
> Nope.
>
> > MFD part is removed since MFD cells binding is unconditional, while
> > the device supports any amount of children grater then one. For
> > example, my  device uses only backlight at bank A, while all other
> > subdevices are not present and used. This patch switches to dynamic
> > bind of children.
>
> MFD does the same. Please, take your time and get familiar with how MFD w=
orks.
>

It does not. I have tried. If mfd cell binding is missing, driver will
complain and fail.

> ...
>
> > > > +     device_property_read_string(&pdev->dev, "linux,default-trigge=
r",
> > > > +                                 &led->cdev.default_trigger);
> > >
> > > One prerequisite patch you probably want is an introduction of
> > >
> > >         struct device *dev =3D &pdev->dev;
> > >
> > > in the respective ->probe() implementations. This, in particular, mak=
es the
> > > above lines shorter and fit one line.
> >
> > This is not a scope of this patchset. Original driver uses &pdev->dev
>
> Indirectly it is. The change you are proposing tries to continue using th=
is
> construction with making needlessly longer.
>
> ...
>
> > > > +             if (!strcmp(comatible, "ti,lm3533-als"))
> > > > +                     lm3533->have_als =3D 1;
> > >
> > > If you end up having this, it's not the best what we can do. OF ID ta=
bles have
> > > a driver_data field exactly for the cases like this.
> >
> > This is required by core driver to handle some attributes and is here
> > solely not to touch those in this patch.
>
> What does this mean?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Let this driver rot for now, I might return to it. At some point

