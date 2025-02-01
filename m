Return-Path: <linux-iio+bounces-14849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FFDA24BA3
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 20:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC753A60AB
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 19:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020921CCEE9;
	Sat,  1 Feb 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgZkeeM8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19051182;
	Sat,  1 Feb 2025 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738439275; cv=none; b=U8SPU8tuSnN2dltBlNy+dHd1qIKQ2hJZPOb/1aCUsUBj+aDKEBhyrsU3gvr6yVU2CAgyE9hqHcW8NtX4lNLxt7TaaYYPyOV5V4ESc/xrt7enQoiBgi58hW39NaqfhMTGXNyxMB7zjCtIFe5NGqMazrd2AWpTAy+xcqFGD5U1XAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738439275; c=relaxed/simple;
	bh=9Y2iEwJwFkc2B9GqWgu70tRdf2FM2JE7y2skPhWMyUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGYPT+jn6zbHpKLMoMOkgp64Pk690hv3sLiLe0a8HdhOq2jjBFYGyvU+ICVygn36seOPO76zj9dE+mYzqW7zjfKAuV2Xna6o1zsKpmsd42NB26OoJCSh7B1E1unB2cf1XC8kci3PQ7xTVQjn5eXk7N4mFcLDp/yLv0BzpdYV/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgZkeeM8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so552715966b.2;
        Sat, 01 Feb 2025 11:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738439272; x=1739044072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y2iEwJwFkc2B9GqWgu70tRdf2FM2JE7y2skPhWMyUI=;
        b=kgZkeeM87mX6Mf2pfULm61xqqA/7Mpt2WpfSLdgliX7jv929FIGy9XcvQSkmqggo+o
         V0mTxrUzqE9VCoK2J//uWnAoCp9URoykvxioYbYVAqc/yOFvNkRuI45U7mybsQObFX1W
         32rSjDsL4EqFCpnpgRtKDWtcal8SVbw08dghCTQ9EPpC8xz9fGrfMNYGn+BpmMHhIYrA
         ZHGSpIv7eszw08j7OGd57k+dQxjAkuE+adZXSrQnAS+NasT22eqLA9blk6Y8PZYk6dIH
         2t/qBGfZLxdZtcI+FbyQJf5CA/kVlJO+yHQUAsRMrcbYNLxFe+93mkoUnQfa/flmUbmh
         rprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738439272; x=1739044072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Y2iEwJwFkc2B9GqWgu70tRdf2FM2JE7y2skPhWMyUI=;
        b=U+8Utbf0bEewgXUiQape6DbV53561aqX7q/dpdwenVjO6OpLAU+CbW5KjM6kc6zJ9e
         V9Lb6+ol0WRNP1MnjhB9Nxatg+cdmMiqewBfqmaMaiQMO04Y2yWfisGKGEXUZLCI6rdv
         gnyL3X7nvwKdvNsC3zc9EIzURvD29e4zujcG4d0VFxj79Ts2wJmoGzGca6M+WCGvUW3o
         D4uUINlEkwkiLgf+HFJshRBNlYXWt1/+FrpAA8lqr6lIlc60x1HRTL3LdLZkGYWfjgas
         EIsLD/Z9nd+K0GN4S0fEh4OqL61oiBHsbQyc6e13gm+nlIDLg5rWau0uDkIrTZIM4ytu
         tYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGzcCoaYwpuLEDVJn60XfLev9iVmXI0GPMAKk2SiI39U+sa9QA3KDUgh8hi2nUYTfRrXm/qgLEAU89@vger.kernel.org, AJvYcCVUPSHmM+viAJfdf+2zfFvckmXCtNi8BL05CO57e458O9dbNJ47gqqdiQarbfaSrLoFcAdeTwIyEsFgtdR+@vger.kernel.org, AJvYcCVq/73iec3EvLeTetGgWbOwX8DdgzDp31f2acrLLWKocJZc+z6C20/VgH+s0gzrXBCIxGzu+Cj5@vger.kernel.org, AJvYcCW8YReOQv97v0de2vOb92INj45gMIiwBzid2rj91+F7TalpJqjuuYbbc7xpeCop2IDFtl89+NBN4NmYVaI=@vger.kernel.org, AJvYcCX+F6yEy2eVRQeMsI3jml43OxfVnIrgC9HNzD7fQ06SMtnz+Bc7ri9Th/ighq/lgTvP2i8TNlxBE8NW@vger.kernel.org, AJvYcCX78KjuWMklep9OudMGRCYnNIZ/TKP84/6zkLf6jtcOKLO4OiPeCpqvYMwuV3ghcPRhe3UxsASusM9+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxet1V60WgTsN0xL8zhKpDOhWP3M2ANICPp6pKEe+78jgFyp60g
	3R50r4F8DLJ9BzA2O3uXAbbkyzwNJ0AjR2PWrBtAq/4dDVXyn6IZ1AOEGFc0SVZEAmg/+xmzZcM
	mDjuD7IR0xRxU9LNfA8hcdE8JpMQ=
X-Gm-Gg: ASbGncsJSKj9/hpursdPBUVpgICOqHtuZamdVucV/dlxI6u+vJHfg+sV/pgb4hn5dNI
	DxumlTmjVJUJsy/++MWmsF5g3jU6Ks7B0oK+YkoU0nwM3wWyWpY/iuvjEHfLKHWt9UJ2nztkD
X-Google-Smtp-Source: AGHT+IERpw1g5M8zApVrYpVEyiqFZwYlR+EKeXU2Shhx2R7/TSFd//bZA6HHTfe0pDB1mxJjnTIivwCXlr0P6UlEOUg=
X-Received: by 2002:a17:907:da0:b0:ab6:8537:60d6 with SMTP id
 a640c23a62f3a-ab6cfcc2e89mr2048306966b.7.1738439271988; Sat, 01 Feb 2025
 11:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
 <CAMRc=MdwQL8dWU5zF5fp+KUbC2RA2Q264by8HGXMg2k1rxhsTA@mail.gmail.com>
 <9931433b-5cde-4819-ac96-eea4f1f0f1f2@baylibre.com> <CAMRc=McEdcDs01BAKN5vg9POg_xxJBY1k8bfgiDN60C1-e_jow@mail.gmail.com>
 <072be5a9-e0fb-4073-85b3-4a8efcafae09@baylibre.com> <CAMRc=Meq_Gfhcjzx0vCL0JPzfnOcijFgB6AuqtsqgGn1eOTMVg@mail.gmail.com>
In-Reply-To: <CAMRc=Meq_Gfhcjzx0vCL0JPzfnOcijFgB6AuqtsqgGn1eOTMVg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 1 Feb 2025 21:47:15 +0200
X-Gm-Features: AWEUYZnwTIj9KEDy9rRdO0tPB3DfcugGi6Loe0pNH7j-w_mg25ltYxBcKQtk_8k
Message-ID: <CAHp75Ve+iwrm8dx49+6C7xFJgTQrh3XumKVzKvnYY=00J-j43A@mail.gmail.com>
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: David Lechner <dlechner@baylibre.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 6:22=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
> On Sat, Feb 1, 2025 at 5:17=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
> > On 2/1/25 10:14 AM, Bartosz Golaszewski wrote:
> > > On Sat, Feb 1, 2025 at 5:09=E2=80=AFPM David Lechner <dlechner@baylib=
re.com> wrote:
> > >> On 2/1/25 4:36 AM, Bartosz Golaszewski wrote:

...

> > >>> This looks good to me except for one thing: the function prefix. I =
would
> > >>> really appreciate it if we could stay within the existing gpiod_ na=
mespace and
> > >>> not add a new one in the form of gpiods_.
> > >>>
> > >>> Maybe: gpiod_multiple_set_ or gpiod_collected_set...?
> > >>
> > >> I was waiting for someone to complain about the naming. ;-)
> > >>
> > >> I was going for as short as possible, but OK, the most obvious prefi=
x to me
> > >> would be `gpio_descs_...` (to match the first parameter). Any object=
ions to
> > >> that?
> > >
> > > Yes, objection! As far as any exported interfaces go: in my book
> > > "gpio_" is the prefix for legacy symbols we want to go away and
> > > "gpiod_" is the prefix for current, descriptor-based API. Anything
> > > else is a no-go. I prefer a longer name that starts with gpiod_ over
> > > anything that's shorter but doesn't.
> >
> > Oops, that was a typo. I meant to write gpiod_descs_.
>
> Eh... the D in gpioD already stands for "GPIO Descriptor" but if
> there's no better option in your opinion than I guess I can live with
> that.

gpiod_set_many_value_cansleep() ?

--=20
With Best Regards,
Andy Shevchenko

