Return-Path: <linux-iio+bounces-14902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32563A25702
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 11:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C931646B2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58D201001;
	Mon,  3 Feb 2025 10:35:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05570809;
	Mon,  3 Feb 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578914; cv=none; b=ZElGguAm6kuy6q9M2/zZGdzQfsegW5dXj9JJtX6JssddIgsLFRlmtRx+19frl8RUzmHwJPSDuqeUxKwf02DEVkbT4vNdfK5eKR+nOJKwhKHpS1MipoLjN9+5Z+eG/g6AJAx4AKmVlyB4TNEUEY9HFMDInkS2t0qM6eeMtIyRoSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578914; c=relaxed/simple;
	bh=AK2uoyiSfbpWYakho0+pQvcUkhYnOwVgTgDzvA4Ut7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWbG1G9rokjd49A5vophdThyAcNu8s9wAtgEu3pkVVYOhsDDw6hjyEXoz6dTl6XchSUWqzdpyfgjTWvNRGkEi6iualRgnpIDtJT2/7oNIUOEdAcoUq4IaQgLKWnL9YdnE6739GjhZRYU9detfQ2RktXjY4pUVFYC+In88RIzjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5188c6f260cso1328844e0c.1;
        Mon, 03 Feb 2025 02:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738578909; x=1739183709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ex5bLUHao4DryQAa7tTpAvsACQHE+cn8GK6177LmD9Y=;
        b=mI3KPFXhZCXNV32tgisx8QxdUz+CwXF5ew8I2/PjsE0jJLwghcLLYamPDd7g5xuRNP
         ZN+x/kQGvtVovH3uHJ4YmVMwt1O//DhafrdCA81oRePHmrBKNSj2Jt3pOHvsPIqrxTLz
         uxNvJ0xu4WZunRMF8RuaGjtX7pge34q/JJLabRYTL32YNR2qFCi+MlVsjWt94dLbkEMa
         bzO25wY6BB7bCOz+Qab8SNjnzfThn4O5WTcNXEFZ+tmrWffhkdgqEXV6m71bHxPZ5ErK
         3nuwRbNKJq0TFtkgFuetyr/ezPrCxh0vUsmEgwmtMup5vebIDMGTRlF0Xyvrjp+lQ6DP
         vWNg==
X-Forwarded-Encrypted: i=1; AJvYcCVs6mEKj14frbhd7rCl0zw5e6fHLTRMAd0poeo3HDtTarScUbo27h0IkAU6j5jdri4QGn96kKrqJPYijFs=@vger.kernel.org, AJvYcCWyH44ZkySMruK0GpJf1rQLYKF1ZA3uvNc5pxovGzRRenMzIAZzbv4K7IVT63cUYCufYUu5d0MT9c2y@vger.kernel.org, AJvYcCX/zmyo0W9jgowFuND6FdIn/q0Vt93jDPQ/S/i1vaEzlBbUimERwqPd8y/xuZdIpPOT8SzkDy8xYttXpmT/@vger.kernel.org, AJvYcCXbFc5rcbtap1sxEqhlIzwIlXyAFS85kSOD1kvOKO7GD8V4akZYvF7NeOX7lKe1GgLGC3Oqf3sgZXx6@vger.kernel.org, AJvYcCXdf9YCIV5fInJJZheMWN2zXNpp5RmEP2iU2JfBY2dMm5VKU66AaMnHpPDug0NVQzHrfYL2OODE8tIV@vger.kernel.org, AJvYcCXdo/Po2oHOhiS5Riwd8OX7A1pjEfSBTVXhE+xa7P34XYBY4H5NDmLUSqVo5wU3+sQV1lb8uH+A@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6c6Z/wkrHidUPm3A6dQjr+1Jp5JIu2r+Y7cvrirLkg5lvzg7S
	gohZcgND6rAbbuSpW7UkVfopVVRq02l5Eo7GTPXNQ5KWTXSOdnzSVgnKiHvI
X-Gm-Gg: ASbGncsPF6KBTwWe3RAApl81tzWCBLabV3+x5irYokFBXlAK4ejR1IbDK2i01IwNkvk
	yQ1WOaTUj0WRBKCPAM4KdKR50hNCvh1QuoNo5ImaaOEjXEWObM/uefjf2UZmC1MOpgdIZjIksno
	p+B5ihNzcSvvGiwqJi4R2ZIeipTHxDp7V7HJmXvX3JINlI4hnOvHgpIhFKt4W4IAxshCM5cAX0l
	5tUEABSh9QtBJs9hrhg2ENWXSjVYg8f5cmR1MIaJdG/cfCX693wAip0N89vdFn+8q7sgt00WL8P
	2Kw9ebnuN07y0Y/NIE8MHbN0mYsMBG4G++bGP6/QapLpjouHXZMIHw==
X-Google-Smtp-Source: AGHT+IFc5l+TS5A7gS2dkrU7MXjkcKpiNTFzUnTOezrhIF6ttrfFxqCg1G5Q1mEn+evdk5L/86w8Kw==
X-Received: by 2002:a05:6122:32cb:b0:516:2833:1b8d with SMTP id 71dfb90a1353d-51e9e55db69mr15401856e0c.11.1738578909171;
        Mon, 03 Feb 2025 02:35:09 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8669407cc41sm1610151241.8.2025.02.03.02.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 02:35:08 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4afe70b41a8so1216459137.3;
        Mon, 03 Feb 2025 02:35:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2iJJM3DgEbTgEI215hZ+zA0zXs/7wTK4JFA6x0i9B65MiWUnsTut7ykyPXU9NoczVW61CRGLcGK9f@vger.kernel.org, AJvYcCVMc6z0S44ZBF5pFt3wC+IgyG+5LWmVdTwYBQDEg9rKMtWnyLJ4oYWVrSq/YJ2dXihAYTgsAaAmuaNAfPFy@vger.kernel.org, AJvYcCW4wsWax6fZtJNKLt/1N4EtHO6AL+FEzGdoZ5Pf1T5TOGCcY8y5VRPzVCbOerdTNtO6bIi1Ftl8maM3@vger.kernel.org, AJvYcCWBnkJA8JqerdbS/VRaMzW1Zs2YQZRAeuefbiJLrld9nvpo0p/Nzqh25QsEeLzbnsslf3tzJ5+inEc9@vger.kernel.org, AJvYcCWUN9eTw5Vlg3uAtR8wH5MM8ll7Kcb4pjQ/dDWekzuk80BV0AuvLFYaeoLQqighyyRg8EpoOzcCjI+UTYs=@vger.kernel.org, AJvYcCXRaRk9XhJLt/4MKOZ+Sq7LqfIGSNsopARanr8ip2L6pMQWTQG3Lt8zg6Ix4jvZ/HYdnJWfD3N/@vger.kernel.org
X-Received: by 2002:a05:6102:3f8d:b0:4b2:45a3:59f1 with SMTP id
 ada2fe7eead31-4b9a4f1043bmr8045813137.9.1738578907367; Mon, 03 Feb 2025
 02:35:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com> <20250131-gpio-set-array-helper-v1-2-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-2-991c8ccb4d6e@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Feb 2025 11:34:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVqNiquGdEs16GMTA6DPCko=TX84XWJygAorTnQk=+PUA@mail.gmail.com>
X-Gm-Features: AWEUYZkAG6WZPJcFCeHPNpLZ6MfE7XgXc80j9HTRJ_H6G27t4lJaJg262FoSJlY
Message-ID: <CAMuHMdVqNiquGdEs16GMTA6DPCko=TX84XWJygAorTnQk=+PUA@mail.gmail.com>
Subject: Re: [PATCH 02/13] auxdisplay: seg-led-gpio: use gpiods_set_array_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David,

Thanks for your patch!

On Fri, 31 Jan 2025 at 21:24, David Lechner <dlechner@baylibre.com> wrote:
> Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
> gpiods_set_array_value_cansleep().
  ^^^^^^
  gpiod

Am I really the first to notice you got this wrong in each and every patch? ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

