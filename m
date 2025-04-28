Return-Path: <linux-iio+bounces-18765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C037AA9ED37
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 11:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4D01884B4D
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 09:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18DC21CFEC;
	Mon, 28 Apr 2025 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa+v02s8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E026D200138;
	Mon, 28 Apr 2025 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745833819; cv=none; b=tL0QxZONKUhfIB/L3LgnirnbzNv6uc9iW+1EK9fNHP5LmIzxwzS6SyuslfzKBgzGq3rVrPn3YJyO9Tw1ldyPdcA1l00pBFv6RG8HxOfVJn2UVtDgD6KP4Z9rcJbQLn4GlB7idK+ogBwXR+ej/HxOVaCe4YbouKDAqGFri3wmn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745833819; c=relaxed/simple;
	bh=yiI0t3KzyC8xZVvbZpTX7rWg2qi61wN9oJC5TUMtQ4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpVw8iUSaXrBUbNt3nBDsix8K92hacr10TrOksZMQh66TDTgyctYN9ZYtptHLD6RHzApxYI4t0y89gYp0cr2Lum5lNDQyghMFY3TO7ioH4QKh7YZrEob952JwBoIk9jlDXarjzTO1NYv8Z+amdsJth2R6A/6Q24/rJbYG+DAcCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa+v02s8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso5696524a12.3;
        Mon, 28 Apr 2025 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745833816; x=1746438616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzNOPJFHfsN0QAsxHoXogR9GK+LlwG788CqeZ5YVfJg=;
        b=Aa+v02s8k47BunStIr5siI/d/jNFtK3P6aazjZ2elzXO0cU3TmQLaNbYKh872GHjvJ
         sUMrysQ/T7SlD1TmO57aj3on4Ds1VbAS6/1ZRc/BxYLzLEYYGNJRDmdsrXK60LJLAyUG
         9mmwsKPuIroRl5FCRVSrnS9jYDGOtAxwy4DWisnAyhd9vd5cnNf+KVssmGLo1/U8Jn/t
         VEHSNrwSKWV/Fpf6ZuR84aEvKJuXwyuUMPkN5LlRDE8ZmPnlBasJGFMElT89P/ROF77V
         4gDiP555OqjVVmHYKmciBFMsiENkFnApWnt04psR0i/IcLvyU1wJDrlpgvdUB/QOUnWK
         dZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745833816; x=1746438616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzNOPJFHfsN0QAsxHoXogR9GK+LlwG788CqeZ5YVfJg=;
        b=b1jt5Xh/pIBVdeFCs2WnhrwaZxaTnlZaoCekXlZk6nz8gY5fnULxPGbC56Y1w2qp/L
         reaZrEqU9Tt/AeOwWqi+MsG1si/mQWadD4rI3iXCRq6pNfppfXh3TUdz2Q6kzhj9yUL6
         CMW+dKcfPR60i0zR8rozLKCLuWtcYzzCMJKpsJTU/ZsIPZiVtkC3Sn4QscyIS8yb041Z
         yWT4Bsq7qOVA7RY7TkJ8356ZVDj0uo1DSsE026nU6e6xuir5r0+fTrJA6xfXIXgZbZXk
         Jup5/NeWvvYVyaoIbFS0+ChzwSu7gT5npLuPGuE++3Szk0WWzy/zTQdcAk5qbUziPZEs
         RhbA==
X-Forwarded-Encrypted: i=1; AJvYcCWmo0BBvcA4PLVGkH/05vJoPQRlSiTkkdkjm+s1bTyQvxeFumRZwxy3qab814z8CUWC1eKCLZr2Q8749+xC@vger.kernel.org, AJvYcCWnwLqa9FnItC0vKraABoMgw7NZJ+NaxMj059jpAyALg1OhyXNfKuR0UKrTp2qmFGw2QwR3M5pqt9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcVFvZn3xV2gWao7jfBhpuB4XV+nZh+LCqE16UxLAJYJciED/e
	dXWY42KgKKWw8y0P49fSCGoeHj87tycMT7PsaEftzsypmkm1vEX83VFadlKBl7rRBlysh7Y863J
	1LSPKlbl7/O7xdmnUhhHFUYir8KU=
X-Gm-Gg: ASbGncs03MYu7WGhLzLnOwon+L+Rcszq0awSIpr8+KpZS7E109sDbdVH0cG2rinexnA
	nY6e9mfJGwPW7UCN9NyIUWVNJrlcJ5+aWcS80vptRUU+VybcA1Pvalqn/ia4GxJRhWWkNaG/+mp
	YWMt5Mo+aCHrAM/JiLStuFNhcc
X-Google-Smtp-Source: AGHT+IG11ycFE2PkB61nFfebKSoqYyj5h8DU2gxlG9BQR8BD84DpNf0Wwl+tL1HVqWS1Vod5bJXy2iyXDrvW3yz3bw8=
X-Received: by 2002:a17:906:6a21:b0:ac6:d142:2c64 with SMTP id
 a640c23a62f3a-ace710c6b96mr990313266b.18.1745833816006; Mon, 28 Apr 2025
 02:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <59106e24332743a7f9eb0b13ad6a2f5595ab485a.1745823530.git.mazziesaccount@gmail.com>
 <CAHp75VcUcrj-BLp9QDsYMDY_SeQS76LDGge5vVqrx-MVwukP0w@mail.gmail.com> <4085fd58-c92c-406b-842b-ecda2fb3c895@gmail.com>
In-Reply-To: <4085fd58-c92c-406b-842b-ecda2fb3c895@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Apr 2025 12:49:39 +0300
X-Gm-Features: ATxdqUG23fvKHI445lKjGfN9VwwQ5k8wrBoZmew1lv4mNnMDTqG5MCm1Cojhs54
Message-ID: <CAHp75VdAEefH5Vgk5BZz8vGDXyu0EmEy3hwoeRDJsKmkjaQW9w@mail.gmail.com>
Subject: Re: [PATCH] iio: ti-adc128s052: Drop variable vref
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 12:45=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On 28/04/2025 10:08, Andy Shevchenko wrote:
> > On Mon, Apr 28, 2025 at 10:02=E2=80=AFAM Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote:

...

> >> +       int vref_mv;
> >
> > vref_mV please. And yes, I know historical and other reasons for them
> > all being small, but let's try to be more scientific in these crazy
> > days.
>
> Sorry Andy but I see zero reason to use capital letters here. In my
> opinion, this is perfectly clear as it is. Capital letters in variables
> are ugly (to me) and absolutely not needed to explain the meaning.

And I see zero reason to not use the correct scientific unitis there.
Note, that regulator framework and some other drivers are using that
and I consider this is the correct way to go.

...

> > Or actually a time to introduce MILLIVOLT_PER_VOLT in units.h ?
>
> I really fail to see the benefit. Do you think we should add
> MILLIx_PER_x for each unit we can imagine/use?
>
> That doesn't really scale or make sense to me. We have MILLI. It does
> not really matter if it is volts, amps, ohms or horse heads - it's still
> 1000. It just gets cumbersome to search the headers to see if we have
> some fancy define for unit we have at our hands.

In some contexts this gives the understanding of the units and how big
the value is. Even with some defined constants it's not possible to
describe in their names everything that this definition adds. I do see
a benefit of it.

--=20
With Best Regards,
Andy Shevchenko

