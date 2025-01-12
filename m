Return-Path: <linux-iio+bounces-14255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC754A0AB93
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 19:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4721887311
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 18:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17D21C173F;
	Sun, 12 Jan 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIS8cRec"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0241BBBD0;
	Sun, 12 Jan 2025 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736707881; cv=none; b=mw/zmzvCu/EpHEGOqB6/feQqdDJ4blMufpm8onQkr6W0qeBuUQPEOS0pKJIHGqEPUdiw4HKgFggdXk3CM8MmPYvv+DfxKgdS68omoAK/d9/MJdXNJ2Drn5aDAU7zUre2WW+747ti17CPScdDm2abhDnxT1y8aItTuqGy051+FL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736707881; c=relaxed/simple;
	bh=nW1xOJgx/maF6zds5R/gE42v83OiB/la64m0d4MTKvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pq3hO8pUEW8llexnR+JXd2YA561lqbvViYnob+sI/TfFPPUqbecqwvKkyRQzOzsRzXpOMiGcmup0pDbih9LmVl0jTo3vEBuTRPGCObxvVTaotSs/UkRU6ZmjvHC+cE63gy5XZmoGv/8RLfwXpD9U0ntl1++QL05QZy/B7/kR7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIS8cRec; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso5891368a12.0;
        Sun, 12 Jan 2025 10:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736707878; x=1737312678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AbSnZip8z0teI7Mj7+s6i/vDWdXTuqCdWGmHL9sRXY=;
        b=HIS8cRecf3XepAouz7PVcln2G99wnKLmp5YkezAL28AISBe4RU5xMhKUcEH0LgiO2J
         5Uhs9LGDLKejW2wXumYZLkzuhxvE0HRRU6UGAkiqkkODZWrzsiNrAN/S6sTn1mJyqXUX
         b3VNPdN7DRTt6fwGFkKWtesQ+/01AGRKd2w9JqMvMigJeOgrCVNGHptGJsM9PP/Ioln5
         NehC9cg+ecfbTfVnNSfvL9xLgK4bexctZ4fScmrnsO8NRSOhwKTkCJiRi5eAEIIZg+Q2
         BpGhNhENjenKBg08m+cft2XPsQdL4YtEhvERl/fcOZvrKGHP5KraAHfgPw+vMbvFeFaK
         +27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736707878; x=1737312678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AbSnZip8z0teI7Mj7+s6i/vDWdXTuqCdWGmHL9sRXY=;
        b=JO71+ouDnwx8+jj6YCicLTjKOMeYZYqnwbaO+PLOcc2TYRm/3zqFeDkYJRosiukrBu
         IBWsEH5n0acWnjaQNT799ltPP0b73yVCV2xiDq5AU0Xbq6DswTU1bl7NdH01lDy4amMb
         ii/G0LaVV9aduMBEKfhBvofFZyLEEj8YcOO1kw9Jxs7EwPbR5x7SuPFJ4e/2g4Y7F22Y
         ET+amDRkWs40dd/HqQwKPbuoP4VZjMM9taKgtZMPDpr4YOzIpY5KbCWvAyyjk7MVckoA
         xQsbXl8CXVtcSriH5rN7oZPRc2nif0Umjcsqj5uDUzgI9LA9R5Ip77egJjL/BP8Th6rX
         lGrg==
X-Forwarded-Encrypted: i=1; AJvYcCXCC0wTNL/PTKN7K3DQjlNjZ/coOWk3Amoa6QKo4Q8m4JHEVBFqotHTj9hkghvU7Clg0XWAdisVRJ/Md+SG@vger.kernel.org, AJvYcCXT3/iCxqVH8ladkSJhJVwtUDbOPGQ3JTOYChLsWM+HdU9JWB/+q33Zv2hIexXHe0YOtgdq6Lo1d+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtEUlns8z0dJy+dG9WRtxQATQXxtf7qhuCNDiwPFDtnCGzAT8
	Tnnn4WU32/TyDdPInM2gUHv4buD1TP1jFbM6RZRDtiXvjOHch1Z3nei/zKjo+sCcxGM1FrDpg3P
	3QnrnN8l4Tnmh4MZD0ylG6Zxi+PE/cI67
X-Gm-Gg: ASbGnctvlx66Orrly28hS8+1UNiqI9365G0/jGHf2NqZevZNMnLznu7d/d+0Yu8lYyr
	mUy1XY/Zx9VkjCZaoV9l+bCIz9lPuQIjtHpm2RQ==
X-Google-Smtp-Source: AGHT+IFbWWbG59RJ7hVlW+SO+cPfuEr1HUEzGK1y2wEhDlLuj/sbE6yQVedjw58El1uCrinPOrLCiFq1Tp4u0kThGW4=
X-Received: by 2002:a17:907:c03:b0:aae:8308:b9f9 with SMTP id
 a640c23a62f3a-ab2ab6c1ae0mr1599790166b.13.1736707877909; Sun, 12 Jan 2025
 10:51:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
 <20241224-veml3235_scale-v2-3-2e1286846c77@gmail.com> <Z4PdP1ZWkd_YgzJF@surfacebook.localdomain>
 <D7082ZE34NTT.DHC0Y5220527@gmail.com> <CAHp75Vd5LdP7+ndresVv5STN2zrC3S5puDhcACyEk7MbLA0hgA@mail.gmail.com>
 <D708DGNQA4MO.1DD0OCM1TOHS2@gmail.com>
In-Reply-To: <D708DGNQA4MO.1DD0OCM1TOHS2@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 20:50:41 +0200
X-Gm-Features: AbW1kvYS4ipz7_gmCZ-wtuZtfXztMwi9E5gA4H3TyjaW3lzc_10ERnyPQn0fNZw
Message-ID: <CAHp75Ven01nuqM=PXpPN+XHi1r8AS=j7kRM16KtvAr1kZbjvfQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: light: veml3235: extend regmap to add cache
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 6:21=E2=80=AFPM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
> On Sun Jan 12, 2025 at 5:11 PM CET, Andy Shevchenko wrote:
> > On Sun, Jan 12, 2025 at 6:07=E2=80=AFPM Javier Carrasco
> > <javier.carrasco.cruz@gmail.com> wrote:
> > > On Sun Jan 12, 2025 at 4:18 PM CET, Andy Shevchenko wrote:
> > > > Tue, Dec 24, 2024 at 11:59:02AM +0100, Javier Carrasco kirjoitti:
> > > > > The configuration and ID registers are not volatile and are not a=
ffected
> > > > > by read operations (i.e. not precious), making them suitable to b=
e
> > > > > cached in order to reduce the number of accesses to the device.

...

> > > > > +   .cache_type =3D REGCACHE_RBTREE,
> > > >
> > > > Any specific reason why this is NOT a maple tree?
> > >
> > > I followed the most common approach in IIO (52 RBTREE vs 2 MAPLE),
> >
> > But it's historical and can't be taken as an argument.
> >
> > > assuming that the "low-end systems" comment for the different REGCACH=
E_*
> > > applies well to the typical systems that will make use of this driver=
,
> > > and many others under IIO. I considered that *possible* performance
> > > advantage for low-end systems above other considerations, like the
> > > general rule about using maple tree.
> >
> > https://elixir.bootlin.com/linux/v6.13-rc3/source/include/linux/regmap.=
h#L58
> >
> > "Any new caches
> >  * should usually use the maple tree cache unless they specifically
> >  * require that there are never any allocations at runtime and can't
> >  * provide defaults in which case they should use the flat cache."
> >
> > Can you reconsider?
>
> That was exactly the comment I referenced, actually the part about
> low-end systems that appears right after what you highlighted.
>
> I have nothing against switching to MAPLE, if that is preferred even if
> the main user of this driver will be a low-end system. I think that IIO
> is a typical subsystem that addresses needs for very low-end systems
> that are sometimes slightly more powerful than a microcontroller, but on
> the other hand I am by no means an expert, and if MAPLE is the way to go
> here as well, I will send a follow-up patch for it.

Ah, I see now. Okay, I leave it then to Jonathan as I am okay with any
choice as long as it's understood and justified.


--=20
With Best Regards,
Andy Shevchenko

