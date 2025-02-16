Return-Path: <linux-iio+bounces-15576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51235A37544
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E8F3AE800
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC41990D8;
	Sun, 16 Feb 2025 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="u86vVIsY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDD87EF09
	for <linux-iio@vger.kernel.org>; Sun, 16 Feb 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739721319; cv=none; b=CuQ0azKYo2ZxWHJHadXqSgHsdMWKogje07OR5Vi8uXl2TAx7N5pyTK08UUxJhJjnYkXZ+0R73XQ5ijZ42Z+nteQ0/Y0ygHgN4DX0u/kN3GG9ciWwwYzwUFDIYlJ1ytAShhvoNp3948g/J4lcGy8EgCbWLYUV3FvzOfwArx7qvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739721319; c=relaxed/simple;
	bh=fmKJhAkPeYFVEblE7yGmDKB1vPuz4ognRbo9aIWQDQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7Qwp2hlJRhm1854swfXyF4GF7vS+c15BWgPR7qZkOjCk3TVyavqLj3V//knc78q1VjgoepeAfaL6fm3lZCszSx0wxKTpAhx6F5JEZRX/3uyFgpSqQrB25w/8xY4Nhg1zfdZaRdDrk7Cwc+VmjqSByIAsKLrfMicJ3hZSZat/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=u86vVIsY; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-543d8badc30so4280184e87.0
        for <linux-iio@vger.kernel.org>; Sun, 16 Feb 2025 07:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739721316; x=1740326116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkW3Uzq4pFyxE3zKB7NeWEe8NL5/OGKMv8Mar8FWkgQ=;
        b=u86vVIsYDx9zfwa3/ZhSypq++5AbM/V257JopekX0hLcIC4BYNt3Kl8zNNr905sUjs
         8C5IE/Gajx0Jr3Drzdn2hD+qxpej2YX30QNNItS/bJpK1D5zVstdlfNDcKygOYlgnuJ9
         DRmMJoHs2oecxWqG6llTcp0vuJ8p67FHjJxyQ9U95z9btpw3eylcbftbZ9eamtOpDdh4
         pHEsgIhZsqegEAN9IX/Ulo5IM3vvJ7ML8aTumKDzoRWg0OfkpipXYoWKTX2oTInxEg/+
         bxKpn9UdzEUEGYblJLRKdD7jx5iQdZ1QAGHRp3IFJun4+tX91uWR2HL+Us2YaolE0fun
         ShKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739721316; x=1740326116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkW3Uzq4pFyxE3zKB7NeWEe8NL5/OGKMv8Mar8FWkgQ=;
        b=Blm7/4jVXHNuQkMgi5Xhm0RSA5C0CoH9CsE4+2mnwc+wDXr8k9qw2c8IvBLL4q2REJ
         7ojCIyDRv3dno2UK5DGwKyf2mu2h6fKF8Xr+Yin3kPabwyAjnm09cGq9DCYxF2bna85S
         230QcHTgQVyIyANY0waMjiq85C/ooCTstFUJaCtOOOoPa5mKL+pqRn13oIAC8k48ekAa
         l2+WnjlW/CBilzom6ICoIp6FjuCZRFxCjffQ86rHt791tEogtfIP63IR+SSjUpcDB79x
         fLQ2VLy4r1zqNh9BaW7IYF7q15Qrz3q2C+4a1CeCLykZp5N78Mgl2VWxcg/OT9btRrOA
         plXg==
X-Forwarded-Encrypted: i=1; AJvYcCWSynhG5W3BlmN+wQoYi6pDdt7nUhShlG9lov8QV65kd8R3uBjO7SiwARzfqz49sFF9YesdWWT+X9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFTeVUA9/oQONuP5So+UrZQloX4OeG/Hitl4ByEiHF0Ezg2pn
	b0ceqVKby4m4SW+6PWczywIytWvzgSSPX4339QeJsFFQ65VRW73l6xSg4M6BRZmMAf1lUJ3ZzWx
	jtTz7Q7S5q0PH3tTnhvxJfEdig2LvLY0CkoJqbw==
X-Gm-Gg: ASbGncvQOJ8PYtOnXVjkbGXHPUGU7STk+1rnUJpjTdM2HUiSWu0XDxPS4crhf0D+SJs
	yjy+jEJYNRJGcsTesahpr6pjmPkAXP9tmW26UWLt36ze9RROO8djsd7YeMJ62zp+pic3WdjjcNE
	fd+asxpTti3sBt1AfrlcrerO2t6+Rt
X-Google-Smtp-Source: AGHT+IG2BEfJtto7vZKlWMr7rwzaPz49+FDMar4oAHkHlYmVolmXyGHpWwSYEsdEq+L5tztvS5LmTmktUkAulacIOqw=
X-Received: by 2002:a05:6512:3dab:b0:545:d72:95e5 with SMTP id
 2adb3069b0e04-5452fe2e42cmr2095090e87.7.1739721315922; Sun, 16 Feb 2025
 07:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <173952845012.57797.11986673064009251713.b4-ty@linaro.org>
 <CAHp75VcjAFEdaDQAMXVMO96uxwz5byWZvybhq2fdL9ur4WP3rg@mail.gmail.com>
 <CAMRc=MefPRs-REL=OpuUFJe=MVbmeqqodp+wCxLCE8CQqdL4gQ@mail.gmail.com> <20250216142313.743af564@jic23-huawei>
In-Reply-To: <20250216142313.743af564@jic23-huawei>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 16 Feb 2025 16:55:04 +0100
X-Gm-Features: AWEUYZm8mDhVubH4-WZdsHqF8a_56E8frsslpTDc00yv0WTOnH25v97UXrDvKPg
Message-ID: <CAMRc=Meq639NMz6TuOw=xQ_A8VDwA5OXoXU47JNt7x0C7jDtGQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v3 00/15] gpiolib: add gpiod_multi_set_value_cansleep
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, David Lechner <dlechner@baylibre.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 3:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 14 Feb 2025 15:37:48 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > On Fri, Feb 14, 2025 at 3:35=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Fri, Feb 14, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brgl@bg=
dev.pl> wrote:
> > > > On Mon, 10 Feb 2025 16:33:26 -0600, David Lechner wrote:
> > > > > This series was inspired by some minor annoyance I have experienc=
ed a
> > > > > few times in recent reviews.
> > >
> > > ...
> > >
> > > > [07/15] iio: adc: ad7606: use gpiod_multi_set_value_cansleep
> > > >         commit: 8203bc81f025a3fb084357a3d8a6eb3053bc613a
> > > > [08/15] iio: amplifiers: hmc425a: use gpiod_multi_set_value_canslee=
p
> > > >         commit: e18d359b0a132eb6619836d1bf701f5b3b53299b
> > > > [09/15] iio: resolver: ad2s1210: use gpiod_multi_set_value_cansleep
> > > >         commit: 7920df29f0dd3aae3acd8a7115d5a25414eed68f
> > > > [10/15] iio: resolver: ad2s1210: use bitmap_write
> > > >         commit: a67e45055ea90048372066811da7c7fe2d91f9aa
> > >
> > > FWIW, Jonathan usually takes care of patch queue on weekends.
> > > But whatever, it's not my business after all :-)
> > >
> >
> > Too many conflicting suggestions. I just picked up all Acked patches. =
=C2=AF\_(=E3=83=84)_/=C2=AF
>
> Resolution of any issues 'should' be easy enough. Let's keep an eye on ho=
w
> it goes as other series hit Linux next.  Might be a little work to be don=
e there
> and by Linus in next merge window.
>
> Jonathan
>

I'm totally fine with removing the iio commits from my queue if you
prefer to take them.

Bartosz

