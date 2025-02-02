Return-Path: <linux-iio+bounces-14856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6746A24D7C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 11:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF5F3A53C0
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 10:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D11D6199;
	Sun,  2 Feb 2025 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk9BeCIS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168781D5AD4;
	Sun,  2 Feb 2025 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738491164; cv=none; b=SHgul8EL6RJB7RB2Mu+PnlvHSuahntSLnbpOXrualXB1lnHlInANT6Zh4gfaW7wAeZ6Y9+QV7vtsWUPFrUW9jN0aks5b2P9mEZbWSpjqVvN37MlZcRphqwzFl/qiEXTTuB7DhW1h2Get1w96CqaAH6Dt1lS80JahZO6PS6WRej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738491164; c=relaxed/simple;
	bh=70nPdjuobHc/PXuI1KvOzNlVhsxf9gRZUPTqVq9bsuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgSlQGMrmh/gCUty0si6q9G/flyV1acP/D9NdRBubUR68kcjGO4IM4M5cUcMhEiR2V63f2qYcXxOjjhqd5Gc0jH7RHACtEfUXezdG8cF5a4yUu/Zzg+zzWmO8VrLnG0RndCt1kgQ3f6XhafWFtiMT7J3FjjsIBarNAcKbVyYtA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk9BeCIS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so7352986a12.2;
        Sun, 02 Feb 2025 02:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738491161; x=1739095961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB/AiG9y0x5w5gVBo3BQww2hhGOeQt+VRohTT+h2GbI=;
        b=Hk9BeCISrBeIe7Bgr9yzFGUjEUihr4s9Ika8hRTcX4Cu4zLGONxMaAyJLE7AlH+XaZ
         qeVfUqtxDu6pTOKDGwyoLEHHCS5EXkv5L760gBMj1Go1msUPMBy4HnArXD7VhGs2Uq0K
         iHdAAwyJNt+DrHLYqF6Y3ZsMjdqckva95+empms/J5rVYwWJbq2O9BCb7ulxHjsXAcDE
         ZzuO3PZNQYCWso4C2xQ0zr531YjzuyuvL5dcN02Z/P3Z5h2fMn51h3jHcQW/PRUKFJt8
         dHwckFr0idImtIVTlcwkDmwYjxi+037nXOQ5jsMNhtMwj4fP0idjEw5ysBO4safRelDA
         5Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738491161; x=1739095961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB/AiG9y0x5w5gVBo3BQww2hhGOeQt+VRohTT+h2GbI=;
        b=IF6U/epyBNX6XetMPij6SjEWMx0FgGjo0N+DJu2/klFqUm1A00D7sikFFGf4BYaIDY
         2Crc03WgSIsP9YaaKRIZ/WpqwiJ/9JrfVs68l5ops9Jr+DpHQYaVUSShhEKS6wfZ/n69
         MWoQWSObXonKVvZe2wSEOztZVBxLoDdk8hvweFBQuFXwTytaiGA6fphpjXdc8VFS/aWs
         g0ynhWU4zO0J9pb9BsVuEdv9BPvNv0IYxFkidcI/mEfuB2IaPh6Qb878787Z4FvW7rQ7
         qyXVW4eMK4Fwad3x4ErH3UsgyUyaBCO9hxTxmXGMYpNh5J9Pfoh1G8CamTSM7GC6LVS9
         s4ig==
X-Forwarded-Encrypted: i=1; AJvYcCVIC6/XPD+91elsS7gpC+mRObLP1729DQiwhqUxz1BJr9m2Yl8sKCjERxRAoYaxCzqTcFtYT0iLyq0S@vger.kernel.org, AJvYcCVpAFEsZCJSsgtdQfsALW1O49DaLqFSEtS7tVM61eyWiqJmV413Y6+VHPNyYGxO0tSTgIujmXpJ@vger.kernel.org, AJvYcCVuf4wmLnUVWoid50ukvOSTgC58dD2UatMwQmswbs3eUI+DnmvhBvxiteIsSyYGNFHBao2myHJxqp2q@vger.kernel.org, AJvYcCVuv4lwBDPxLXhGtBJWNFUwhIh8I+UbVBWeHKhSDYndx46M24dZvlyUR6SE4+u7/9MfztbND9SjuXuPD9E=@vger.kernel.org, AJvYcCWYMr4gN9NCeaMscSEWt/KGlwJps+/iXi/0AW5V+2yPh88VT8RWZsLrh8SdzfrODU0B3cghECwgY8JtJaz1@vger.kernel.org, AJvYcCX54uRs83R0rm2lVBqEQzjarXICnT9QNxFdtFH5Ry23ISvltxgLbASO0Dkkp3J0fhxjGCWBPqB5vqwq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Vr7YL8Io3op+8nLQgq2xaKVzzyuyNjZT++JpdhwNJCkBJ4sn
	lhNoGa10OE/I8I+EAyEE3F1JH7Xzyd2ALYx5tn+P8E6sIWr+U2YUeFKr0/OafP6g38EFL2r6Y+3
	fVoWqHZpz0LIbl6LTMdbExTQhZ8k=
X-Gm-Gg: ASbGncsE1UxmHJbFh03IWJGKI9wbSYN2ofcd+KrJ7tI8SMGvIu5GVIMaaSTdoVgG519
	MOIKc8qX8hgIeNLG9z3tOUquR3HooTuwu5dvtIjY5h0CXi2JdMbqHTwicT+OMVGcE3V/8eDEg
X-Google-Smtp-Source: AGHT+IGG+HQvgoBX4n3TX0lDB77z/NOr/BgNCu0WqFPo+F7Br1H/dIMjl1k/3zE4qQQe3coAnvUBbxyB35wiyagHcAY=
X-Received: by 2002:a17:907:60c8:b0:ab6:dbe0:d658 with SMTP id
 a640c23a62f3a-ab6dbe0d90amr1814137866b.31.1738491161033; Sun, 02 Feb 2025
 02:12:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com> <20250131-gpio-set-array-helper-v1-5-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-5-991c8ccb4d6e@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Feb 2025 12:12:04 +0200
X-Gm-Features: AWEUYZlz623rfKFdMFDa-EMU54ZrAWLn0adYcJkUjXYf7NvnTZiflFWMhQpjMxg
Message-ID: <CAHp75VczkbpF4sufxUEJdYMGHsY33TYyrDnnGTV+XTC59+QKFQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] gpio: max3191x: use gpiods_set_array_value_cansleep
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

On Fri, Jan 31, 2025 at 10:25=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
> gpiods_set_array_value_cansleep().

...

> -static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
> -                                                 struct gpio_desc **desc=
,
> -                                                 struct gpio_array *info=
,
> +static void gpiod_set_array_single_value_cansleep(struct gpio_descs *des=
cs,
>                                                   int value)

This name puts its feet to the GPIO territory. Since you are changing
it, can you make sure it has a local namespace and not GPIO one?

--=20
With Best Regards,
Andy Shevchenko

