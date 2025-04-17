Return-Path: <linux-iio+bounces-18199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D64A9224D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 18:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53CF16E0D2
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B8325484F;
	Thu, 17 Apr 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgeHBa3r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB95347B4;
	Thu, 17 Apr 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906243; cv=none; b=U94IRt4VQYk/VHaNRXhw04uXnEtTr7n6aXr56UN2fOlJO8w877QlecASKVIKqf623Os2FrYK4MExY9mjHHbEzEX8IlOOFIe6F4E6ReaESJjgJKbrPtG7ZUpEOtm6Qtz+dp0jaEeSAC0pYp+sRrwAu2EJV/C3qTD0+LT+v6z3wpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906243; c=relaxed/simple;
	bh=HkAdHd8gpS42Z7HDfjzr3JCk7eoCi2Sb1S8krTF/8pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwlC53OAPCANddMo0ekL1PGxMzVmRi0YxS3NsH4b2PdwwFMbTvctJLqvq3CcIE8/mO05dwx0HvXVBACc3a1tOEIB5zmaX65wb7/1KoMzsNR9zPDE2xvO3+C8xB2tfCn/pSa0AWaojYxLJoYjhDnFUsruu/MHBf5C5KWXpjA7jrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgeHBa3r; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-acb415dd8faso148543466b.2;
        Thu, 17 Apr 2025 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744906240; x=1745511040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbPve1uvYPOzo7umjR855m+N4T3daG9Z1kh0/VM2qUA=;
        b=dgeHBa3r5nHmuGuoPCGPu7mhUgq+rtDDDdqphxS3eWFvPSs9Z1E8PokATEUnKssLhL
         3HX9cFErFCp5eKKzpWjPYLDAHFPPJqkDBhSljCUzoqDUKq6jGeU2xdaMs4KT+s8BVAHg
         Ns68s48DTgSQR0PHPY34GfvvxN6F07eLOAYo/PebUhL05X8pe0AmTDFNN51TVhGGKU8P
         2b37l9gMguslxRvqWKe/lNj5M+1WguaL7fqTNYSJVi4XaxNHRgY3YHtvn9RB8SMvjfAy
         bf4tZpem1h3CBCNyDD4ZJDjWMATSKGz0J4bZ6hNh8Maem2C7czDGyf6rGf1oO8Qwg9yM
         OYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744906240; x=1745511040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbPve1uvYPOzo7umjR855m+N4T3daG9Z1kh0/VM2qUA=;
        b=Jy8gaNrJxbQflNcZLHt+yQtoq1E2VAZJSLrgbqKfrUmzurtThaudFqrthWdVAC2gqx
         odmRU5y/rMuJUOhcmaC8QORb3i4cx2RglUPFexamUap5qk23mMaRis5JOPOYufmSFgdC
         WIwyeg2yxTPwba9Q7rc37/Sw5/km+aH5eMAEoXubCZfrWxG0QPXK4kByUYAzMCu//MKw
         3g76HfNw22qhIbilrA0BqpDhtDlbHloatsah7Mow96W5IVPAi/YPzlAmL+nsjLCTaCmR
         Go767VVaaZTJzuscCWhJimoTqOyFcf9qgk53AXCggNNh31qCD9XhpseOJlw8MAS0O9bc
         jXRg==
X-Forwarded-Encrypted: i=1; AJvYcCX7m0MBurc0FI1GgbgPfPBud2brGxxxe/QwSxhpxo1pf/DqT0Iaw4Y3iv7ZNBFTrpA1rxXa/wh4OLg=@vger.kernel.org, AJvYcCXgDEu+qdZQ5DqPSjpeV2h/dW3Z+pWsVuudLHvfolCd28mbdxd45bNmNJEMUVDQ9YOq/YkBKZtKIlOphZuX@vger.kernel.org
X-Gm-Message-State: AOJu0YzRsdToBmsyNFuFyLY0vRc7tWFD/YEdENFFr2LRFeOBCgdt1vR3
	z62cQPT5KLiq/BRGnoINKyRQtV6CtBaO//eH0la74bbM/nrKLguEhFSBQUQEZ4hCjgf8zUQVkhn
	Oy03ueJacDK1kGNLvNvg7N0YNJiE=
X-Gm-Gg: ASbGncvfyrealMFBlxdRlWqIT9MMftVNEuuh0m8Bib6ffbfBlV9qcp3UFttDAXIOTph
	bB/UKvl8kwhM9CXRcGrQweA6HL+I9uU8+49x9hg0lLQZQg7DDIVO6pplY/HSQSebfKw3kOgQqnb
	xMrs6uUKpgHCgr2wpBBz71fptv
X-Google-Smtp-Source: AGHT+IFoGx7J9uYtzFyupfPUt8X32SjyduVEB58JftV7nr+5ZGIrPbnKu7I7scjxL3eiTU2jZ/pKfKkaTV7WedmdHLU=
X-Received: by 2002:a17:906:f5a9:b0:ac2:cf0b:b809 with SMTP id
 a640c23a62f3a-acb429ed4d2mr702253466b.31.1744906239458; Thu, 17 Apr 2025
 09:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-losd-3-inv-icm42600-add-wom-support-v2-0-de94dfb92b7e@tdk.com>
 <20250415-losd-3-inv-icm42600-add-wom-support-v2-1-de94dfb92b7e@tdk.com>
 <CAHp75VdZDovPuRqQMpP=TkjeBr9AgRssPFJfmsjnXC=wUXxFHg@mail.gmail.com> <FR3P281MB17570E56798219E17F8C0814CEBC2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB17570E56798219E17F8C0814CEBC2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 17 Apr 2025 19:10:03 +0300
X-Gm-Features: ATxdqUHBRj8Mee1rXojwcphqLoRKp5e4YGtOJLfRaG7565FqHXoTW72eOrKA1PM
Message-ID: <CAHp75VeUYyjZqLsxS8BQn0K9uRGCibKsNTgrCdf58ukCrMgSsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: imu: inv_icm42600: add WoM support
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 5:25=E2=80=AFPM Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > On Tue, Apr 15, 2025 at 5:47=E2=80=AFPM Jean-Baptiste Maneyrol via B4 R=
elay
> > <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

...

> > > +       /* 1000/256mg per LSB converted in m/s=C2=B2 in micro (100000=
0) */
> >
> > That 1000000 is redundant, just properly spell the units.
>
> I will use um/s=C2=B2

FWIW, you may even use a Greek MU letter, kernel is UTF-8 compatible :-)
=CE=BCm/s=C2=B2

...

> > > +       /* limit value to 8 bits and prevent 0 */
> > > +       return min(255, max(1, value));
> >
> > Reinvention of the clamp() ?
>
> It was a copy-paste of an older driver, at the time clamp was not here.
> I will replace by clamp, it is much more readable.

For the curious, read this https://lwn.net/Articles/983965/.
The min(max()) may have really unexpected side effects :-)

...

> > > +       if (sleep_ms)
> >
> > Do you need this check?
>
> We need this check in the case sleep_ms is 0. It will happen if accel is
> already on. msleep(0) was usually doing a sleep before. I don't know if i=
t
> is still the case.

I'm wondering if it's documented anywhere, do we need to update /
improve a documentation?

> > > +               msleep(sleep_ms);

--=20
With Best Regards,
Andy Shevchenko

