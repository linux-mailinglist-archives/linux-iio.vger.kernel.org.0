Return-Path: <linux-iio+bounces-15110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCDAA2C249
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 13:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09B23A85FD
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D30B1DFDA2;
	Fri,  7 Feb 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCGPztX/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367021DE89A;
	Fri,  7 Feb 2025 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930443; cv=none; b=BoAStyfuukijzEbk1rLAFiMrfv7gbGKj2qRWoeYhpPx9/PjIPbzinJiMQBN3klt2yl0mY+uJMamzpDBe/uVkGunkdCnu6hjfCr7AcGpBYCYhEuv4xXhaynLBxHABDyDHdcrQsWu5ZakXLWtAeOKStahq2EDBnOSVt+q0sD6/NoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930443; c=relaxed/simple;
	bh=/W9c9p++17eMgUahRKE4oI34+Q3vrWjGJDtabku3InI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HV95zm60ca3/ZlShqVnqe/GrS9CDa3uNPm4KxJgv9bq+0tu4olN3PZ8pHrOTvCKUnZxHLTz5ungJuWUN09VslcjifTOS0G3ULM8P9OWYa7WkbNLBTd9XQDVTmnZkZfsB35fRLY/0RMcSCY14PCOep5n7u4V0+AlAo81s6cmlyjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCGPztX/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab6fb1851d4so403975266b.0;
        Fri, 07 Feb 2025 04:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930439; x=1739535239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF6gElV2cDQ91CKc9Ejq8GVQ8GLozgvPR2NnTRy0mAE=;
        b=HCGPztX/4M3sm635Ol+QH2dLGwK+QtCo7bKR9JPm+nvtjwZ9iF/g+JaVPb8X0C79zj
         GGeept7HST07ESbYq2vkIlQijmlNmLRICvCQauFM8LXvLL75X5e81hpZpU4ts/DbEv/W
         7NJeobejZSEDy6uIhLFgIakV2kHL8+YQU49xL3mVR5y9MEXtuHn7m5PdoaiOMkf5AQxR
         7odlSRT/cFChXK6VWZucgD4IovzbRNB/LUsqOASe4K415SAWTy0B/Z+4wEneDi8ZtrXx
         YraLTJpKybMRHKMxQjhJzVpqOckiK/pUE7CHS4wn1lIYvxEtkJUIgipVeaH2m6CGVH2p
         nZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930439; x=1739535239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF6gElV2cDQ91CKc9Ejq8GVQ8GLozgvPR2NnTRy0mAE=;
        b=iIZ3V19X6G7ypgdBSfek/RiXbKNBnpAP5bqIA2F84NhPbwqkaIsMgTtJxdPXf762IC
         zn/ylyJoT0S3bjboWRdUo9qN8o/D6yVz4gAutZ9l+EOaluV3kZOi3kAa1T6aq2jf0i0W
         SaNbM32xGB9Q58KTaODVlZHtc95dqMtywWisQM2e9AGIxz3UT9r71LOtCf/umlX789Kb
         x7nDJJYdJCE/PpfKSZSdCZAHxezXB4sMZwpW8qPMtnnc1dW5TDnRorga5E3cZyZu9ONd
         YmZNyFszAzaT4Rw/9AIJXzTvh+C7h1r6k6Q3oYUk3xkVWELU/WxYIjU8MgEO6rJ6V+sr
         EKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0v1onIj4YNEC7zrJrnIOWflIg/KP8V9BPkJw7wZWK8xAx9/cpAu9fQ6L2f29sIdKNozAXwB6iXiYU@vger.kernel.org, AJvYcCUUW0+X6oFRl+0XKRvC3J6se5kb/1Hlb5XHWtg7+ksGtJ30yd9OHg4KWttnRgRoYWjeBg9p5OMpx+ddAco=@vger.kernel.org, AJvYcCUbsyfgvCrXA8/gP4QF7g/t4szZwZqvZF7vwFirFrX+4eiTdcHYpY+4yaDQW83+EzkJciMc2cLkpTKP@vger.kernel.org, AJvYcCUkVvD+6+T2pgGb8mTCbL/UCM0jRmAUtk0s9uPt/CBCDAhNm0eVsh4dYwKF5AvIKHVM/7rOmR6B6AVJzXp1@vger.kernel.org, AJvYcCVDKIVv51i9gk3PRfhvUSIkwcBHFyHkn60nMTcIp7/FncXL/QYiyi7ncMbN68KiV45z6SEk4wClNz3u@vger.kernel.org, AJvYcCXtNz329S2emB6ibud/wAJKa2/VB+touivPQ481TjLHRMPgKcC3bq7F0CKMZv55UYaoL1KyeonR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0uLi8f3aHOOrtdnSIer6yeGbyTY86T6die/baBODtCA7dvPox
	FaLYV7UHv0DBJJfAX2stfX94pFi6lu2Hp3bcia/yrSzuclMuEHQMm5sdQOkfE9qaXahAs/corUm
	GiU1vYnR4bFqxSplXXSigSGaqpyM=
X-Gm-Gg: ASbGncsT0DFTtRdfyZUoM/F26IRJXJioQ0S5pGhntI3dIpvg8dimhkzs/1DYewSYD2X
	xoFatAa5tq1tXtbZFqDaU9ELd9RjdTdM2uABBYYuuwndovE9MkIoDAXxeb3haSk07SqRNS3hfJC
	s=
X-Google-Smtp-Source: AGHT+IEcQ5RnwktITKDyFNQPm/ZlJAT6Jq4e+AddpJ4slMbkkGXOrIfWiA+9GZp7vOfbRBsKaL82KDhPv8+MGVLOCTU=
X-Received: by 2002:a17:907:2ce3:b0:ab6:f4eb:91aa with SMTP id
 a640c23a62f3a-ab76e896c0cmr758141266b.10.1738930439333; Fri, 07 Feb 2025
 04:13:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com> <20250206-gpio-set-array-helper-v2-6-1c5f048f79c3@baylibre.com>
In-Reply-To: <20250206-gpio-set-array-helper-v2-6-1c5f048f79c3@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Feb 2025 14:13:23 +0200
X-Gm-Features: AWEUYZnW5RxxBc3bDqX_OpBL8hmNResFkWKqXoGA9bw_WE1ro5fEYdWUTUuFnFw
Message-ID: <CAHp75Vfb7EgHkHtqm4b0QnG=uWwszpWwFe8MLDPRSifKtQFAcA@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] iio: adc: ad7606: use gpiod_multi_set_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 12:48=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
> gpiod_set_array_value().
>
> These are not called in an atomic context, so changing to the cansleep
> variant is fine.

...

>         if (st->gpio_os) {
> -               gpiod_set_array_value(st->gpio_os->ndescs,
> -                                     st->gpio_os->desc, st->gpio_os->inf=
o, os);
> +               gpiod_multi_set_value_cansleep(st->gpio_os, os);
>         }

Now I do not see any justification to leave {}.

--=20
With Best Regards,
Andy Shevchenko

