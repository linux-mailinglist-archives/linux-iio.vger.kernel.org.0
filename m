Return-Path: <linux-iio+bounces-15541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3038A36097
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 15:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1231895644
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE71226656C;
	Fri, 14 Feb 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMvbPIiq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDDC86346;
	Fri, 14 Feb 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543746; cv=none; b=s/Dzm/H8+dWf8gGn3UbFIv3LNKAQURvptlPo5zWHpJSi66GiJjYgSV7qDLBMohWV0uLpFBV+DJxXQ/tZg1q+dvjmfWxSWgB5uXBKStqqlEjAXCzA2joS8+1cOoAu8divm9+9AOEUZNamOjxb2NMIzvBbFxF05S+i6abmwm3FDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543746; c=relaxed/simple;
	bh=I9TvN3GHsWgFRWoiVsp3AGhFWp0rf5GhN/XQoJge3J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQjud53a0ylLvY5f+dQg0cI9M5TpODAaPEf7X44tuKlEirpxBQgIisvDCbrxjxtEpXcI5dGcxfPP2wmDrj3PS8SQNu6oS8Uro51cMYTaJnLXHoepXtfdPoyj5lR6Gp5M+MiV//QyWGomAfJ9s1Exhgvvk+fLvBgZ612xMa0NPlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMvbPIiq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7e1286126so376001166b.0;
        Fri, 14 Feb 2025 06:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543742; x=1740148542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N53k3Mv7p8S+u3QWaaS2dkskmcl5RUICb2LIij7Obo=;
        b=MMvbPIiq0Cnf9IW7NptdpQddfRbeRSgbfooQmtWLFyUxqy97fQjvSyJUNgfWi1qweZ
         aw1mcMMEyOOH6hNZb8kTjhF/xCfu++FlTKuRe3X/vUOvCzuBH15gFLSRSbBOxsK1g6Cy
         9uoiDiUbIDjj6UFNS6s6u0Sx6V4H8MhHbjkhdiH61Ee5QBiy84vh4otHVxgGqgQdRjOX
         iwxD/JcDFVJGGe+5galovQ1o6RQd3vJtlz+I4t5h5LsFAlRDDvG9vVGYFu4JblyunWwm
         YddEfZMV7s6cMWHtfR1ZdiZVIrzZfp5eInjymJr7tkff4XQqh1KYjraXisBEVgJt7IH+
         /uDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543742; x=1740148542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0N53k3Mv7p8S+u3QWaaS2dkskmcl5RUICb2LIij7Obo=;
        b=EjeT5qcJg4D2gSYFrHb1Cw5PnZ8j5NVmv0LTDs8ADZj8pNDIrQkcJU61wfOOSJ5JqG
         HZjTkXF7MYOKG22jrEIsPwp7ziCiqBw8/WlnnUqQWJ10WJ6m/6y1c9Uj4BnUX/P90ZWd
         63SifEpICjZHF6JLap93wwd2tLUryl58jd/IgE2ncyDuEyai8klRkeNx2DEkyeXXyWhi
         1PvtqSTRD/7WEmX0ZyaP+HIjI2sW5Fn73IxU7nxTbq3eS1XOER5tKa8PQNNTesWTWwpH
         dS6mUSjzJ/x8Fv2CCWkI5690Yi/mntgH/AgaR+3qBHYYHyQFz6pGNwKB2SbxLPu4nv47
         nWiA==
X-Forwarded-Encrypted: i=1; AJvYcCVVb91wMttq9rl/Wg1C/5zy7XytunXrrrA0MrMjlidE07Z8umYNq3znFCOZsa9epAqwjbw1gyucwTNv@vger.kernel.org, AJvYcCWA+SkDFPxwagaDeuQK7cLJj39kGjgSyOoujk8QzGu/6LuBiNOmiuOt/hjUBZM9kiQ8r/F+2xOyuiosryYz@vger.kernel.org, AJvYcCWdBrxmnqkXIuwwo7PxcKhvg0W+hrq8JSlyoks+iEMjHWAsKypC+dUso49C5a0k3SZ7fENABD45bKgS@vger.kernel.org, AJvYcCWgmn+dn6ccI/4sRT4mRopXpVX4FhMcDk2N+LDVoRD3qxHJCY3UDi0bJUpy6uemq5RWfleOEEnx94A1@vger.kernel.org, AJvYcCWieTdzY2eAW2O5kfIrVvkqu7BOUl3GbMgsbCUSBUlubi5YJQ2t8+U3nKake4pBiv5bb0yvUSqu@vger.kernel.org, AJvYcCWmD8QPeaV9mO2msquY3l8Y4bbra1aMfbpuqeym1ZHxNmx0D4PAgMnYQJFm/vr4FT+lzr+Q8Va2GbN92Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPDs6wkrIMJpniBSB/7ddfyj77R4bh11GHtKsKMA+4C3I1Ay+
	V3fc/3aHL2mfwux5LljYCHdy7f4Q2ClRWx2YQFU/V7JtZqQZ3GfiluL6LeZk685FX1aOGFkXB9A
	lv8xYFJjMNLkKEwKqufH2934oufo=
X-Gm-Gg: ASbGncsmFq8S8UUhaqFJn0V/TocE9g5db4TJ229LU+AP/grsLRj1ktXZX8sq2Lzgr61
	OHXOTglixmadS7MMRqUQO1Y1BdRqgaDb2m02Vd3rAF9zVhnensLQgpajefY5MN4x/nbt6l80ymd
	U=
X-Google-Smtp-Source: AGHT+IHxLwa+LdK+RIXBQ61ufPDBdw4TCe0dzmGVWhQ+eDRL2W7fpPEWqmtiDOs8fU5xo2LozSswPlPXUTchqM8RUgI=
X-Received: by 2002:a17:907:7251:b0:ab6:d7c5:124 with SMTP id
 a640c23a62f3a-ab7f347db92mr1285351166b.43.1739543741827; Fri, 14 Feb 2025
 06:35:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com> <173952845012.57797.11986673064009251713.b4-ty@linaro.org>
In-Reply-To: <173952845012.57797.11986673064009251713.b4-ty@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 14 Feb 2025 16:35:04 +0200
X-Gm-Features: AWEUYZkvU1c5l4b-twNM_d1j1Z5Bjc4iuI1xUAHGQWgComsx2eFjxZsFC8qZig0
Message-ID: <CAHp75VcjAFEdaDQAMXVMO96uxwz5byWZvybhq2fdL9ur4WP3rg@mail.gmail.com>
Subject: Re: (subset) [PATCH v3 00/15] gpiolib: add gpiod_multi_set_value_cansleep
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
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

On Fri, Feb 14, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> On Mon, 10 Feb 2025 16:33:26 -0600, David Lechner wrote:
> > This series was inspired by some minor annoyance I have experienced a
> > few times in recent reviews.

...

> [07/15] iio: adc: ad7606: use gpiod_multi_set_value_cansleep
>         commit: 8203bc81f025a3fb084357a3d8a6eb3053bc613a
> [08/15] iio: amplifiers: hmc425a: use gpiod_multi_set_value_cansleep
>         commit: e18d359b0a132eb6619836d1bf701f5b3b53299b
> [09/15] iio: resolver: ad2s1210: use gpiod_multi_set_value_cansleep
>         commit: 7920df29f0dd3aae3acd8a7115d5a25414eed68f
> [10/15] iio: resolver: ad2s1210: use bitmap_write
>         commit: a67e45055ea90048372066811da7c7fe2d91f9aa

FWIW, Jonathan usually takes care of patch queue on weekends.
But whatever, it's not my business after all :-)

--=20
With Best Regards,
Andy Shevchenko

