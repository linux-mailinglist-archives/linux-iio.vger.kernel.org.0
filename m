Return-Path: <linux-iio+bounces-14853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968AEA24D6D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 11:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1326C1631A2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 10:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BBD1D5CDD;
	Sun,  2 Feb 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuWhJ7Zk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB582FC23;
	Sun,  2 Feb 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738490819; cv=none; b=GNa5t4WB1RZAHNLfv2n01oJBhJwg1kPSO7WPKRo36ddYHMwRKSaS2LscU0j3sxVw8s0Wkgjt4zJDXPYO6kdNPQRFIpB+oXQxsba8KczsJTlmEalF2JvcNtFOIOTA9VhupT8icfqR0nt9hoRqkoX6V6Oh2DYRm710Xnowwp2Ukkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738490819; c=relaxed/simple;
	bh=4Lc9RmLDAbYF4kkewDG5T9yLyCSqx1Psz5qGLxfm5Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHOcLW7XpvDn/WvHTSFJ2+IuRJZTL+eLr1P+M9pplSLaAHbZGnlCMllvK6d0GMUyLqI2COxeMxUSvrarHJYwNG6gSNHORfEb1wXEWb5z0X+01WOm7f8IaTTUX3Tit41VbMAmbHKqcd8+3XC2nxbwOGbTlmGKmPDJXU86ERsa7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuWhJ7Zk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaecf50578eso689714266b.2;
        Sun, 02 Feb 2025 02:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738490816; x=1739095616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9eZ/0dk/F51+IlX4ChMtLpWjOxnMp8WZ++jOtUzjCk=;
        b=AuWhJ7ZkGGn0UW4K3/0oVQf1kZrdc/XGtVUt3oiutZ0tmRap4k3dpOeFAdHIH4lWDU
         epRf5LW6esNmtHr3RL1EF6pjs//TpCnDW9ymnDBsx95EFzOVpAabb4cJtAzsvoAX4TQ/
         MljOuGFB5yYLgAu3XuRJT+KLIMy1R2GJss+DRd4Bi2HsLF6iEuFuFbSwBNT7YlsMoqts
         dCbdDa5uvEvwFIlJptaL+zoAj11DJKyGueoPsnr7exfwxtvVuRzvg/XFTvswdLeeu82n
         EkgyVILbyXQa/SUk8ePdctz3AmabV84Faz82bVvLbzhCoAbxnlWa2xnplHk3/n97EYPb
         aylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738490816; x=1739095616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9eZ/0dk/F51+IlX4ChMtLpWjOxnMp8WZ++jOtUzjCk=;
        b=rdy3TOLr0rYDfmfLBtUcC6J+aDl53nRzwC3Q8Ntc5yvOlK4fT61L2GtnBrHvTVgi1w
         v/cihFTbkTdVZJUpNlMb9GcuKoCkqBj4TeuULTziwD9M9n5GKb1FeHktAGopGRVFcTL3
         LmUpO/FvMh+WAfqpFsxE9X385P1fXBvCFxg+F1k++LA9AUPEsJAh88S4c9ZtblfkzGax
         AaNSUB65j46pA3dyFWdmzBsGPd9zwl7A7r1rF4j/V0wFOuxFsruFJv6GAMWqN8eWwwwB
         XznC0ZHE1bkyFHvW/8QDNPYX8PyU+PTMlEfkDEyUPCKuhxcSzJ+Co0/sooulzuX/d90K
         2M8A==
X-Forwarded-Encrypted: i=1; AJvYcCUcAN49ye7mpBXQws4fugQ95bcA4MWunbvQLD1jfqeMbq+Xixih9qnS4tMOELFxyaVspP7c2fSe3CEunQT2@vger.kernel.org, AJvYcCVQKlLExa9kh9V42Z2qWJnfCFDmTBkDI/W5OHYbrIkUpi3fzaZH6yHp2DmrVOAkRMwy6bkIwLye4/Dr@vger.kernel.org, AJvYcCWe0Ryg4kNgaIFluCGklv1J8jgewq7rtCaJBh1//+IGE/Tu9CQY6dwVgEe0vZJ/m8h0W+YTMYXZhjFV@vger.kernel.org, AJvYcCXFg/ryOlDA0J1tAlw0vpQ6ITMtZcNd2NphlPAGh17/Krx7lbNsgUnqiwqO9o8VKyEPVoUhfQcXza+G@vger.kernel.org, AJvYcCXL3FUIavXIsNfue1H3IwDtBGWm1AdVqG7odpZqYnW89d8Z9B0koFgzf5s/V1wDUfIydWs/sBU3@vger.kernel.org, AJvYcCXbMXfLXAo/yIdbcMcGtmc0i9Aq2YrNOWUeZjGSDps8DZ3RlPMEnKmsTgdr028rKCNU1OwAjgrLcMWwmrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5o3oFQOGW1aTB0Ndfdeca2BIIcjIcEMIH4LRkms0wDzbXtIbw
	MoszIZTZTqjlM2HzVWF+mtESjnuvTY5nOROIiVQN7FyAe/4DQGyK6O9O6sBxepZvN1n7r90W9fN
	rbsP+3A4oZNAsAYjUPYHTjyRLk+k=
X-Gm-Gg: ASbGncs0Rxhtnbu06GKezNpt130PbmmBCyqlXRholm8Fo94r+g039hSnSVFasK9n/1s
	/qUj9emthzkOCAeyK7fsNPc2pqC4gmgnDf7ki9Mv6nY5v+lAkGY6fSm3dN+g4hQtTa2Dl5b33
X-Google-Smtp-Source: AGHT+IG0wgCm6rScVgdh7ldT74nISv2x1RULgwNTbS7+ud7IN3fLokwjmQgWGRLHgTUHU4CmxVCsVeR0NUhgmA5cLkQ=
X-Received: by 2002:a17:907:c20a:b0:aa6:7b34:c1a8 with SMTP id
 a640c23a62f3a-ab6cfe29c5fmr2041673966b.55.1738490815666; Sun, 02 Feb 2025
 02:06:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com> <20250131-gpio-set-array-helper-v1-1-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-1-991c8ccb4d6e@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Feb 2025 12:06:19 +0200
X-Gm-Features: AWEUYZlrR1Eyf2sDO98qHNboDjvCKSIueyg3JRzZHEx-ArKJqfo7ClDNOGf2xy4
Message-ID: <CAHp75Vcx+7v3pq4T0q9+8zOHqAZ=FRrCRfhD8j9LAp4pkXzxNw@mail.gmail.com>
Subject: Re: [PATCH 01/13] gpiolib: add gpiods_set_array_value_cansleep()
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

On Fri, Jan 31, 2025 at 10:24=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Add a new gpiods_set_array_value_cansleep() helper function with fewer
> parameters than gpiod_set_array_value_cansleep().
>
> Calling gpiod_set_array_value_cansleep() can get quite verbose. In many
> cases, the first arguments all come from the same struct gpio_descs, so
> having a separate function where we can just pass that cuts down on the
> boilerplate.

...

> +static inline int gpiods_set_array_value_cansleep(struct gpio_descs *des=
cs,
> +                                                 unsigned long *value_bi=
tmap)

My proposal was to make this gpiod_set_many_value_cansleep(), but I'm
not pretending it's the best choice.

> +{
> +       return gpiod_set_array_value_cansleep(descs->ndescs, descs->desc,
> +                                             descs->info, value_bitmap);
> +}

I don't remember seeing the _bitmap suffix in other GPIO APIs, perhaps
just drop it?

--=20
With Best Regards,
Andy Shevchenko

