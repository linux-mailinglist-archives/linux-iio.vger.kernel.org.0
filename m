Return-Path: <linux-iio+bounces-15321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B1EA30498
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 08:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6735B3A3A56
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 07:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0591EDA0A;
	Tue, 11 Feb 2025 07:36:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE11EB186;
	Tue, 11 Feb 2025 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739259370; cv=none; b=UfuqLro+YyLiqu7kncg72Abz4wn1+2wJQEzE571MjKp/bsgyYQ0Oi/JJJXMoMIpYrY0MKqH+bq1ZCRm1o7sEjul/de1TcO9964UXWxNHauoPmklFR6qCkNX9YpHwa6UbYj5Kq+4g630ukf0zIhAXWjTzDHZHc8EnyKUEa+CPcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739259370; c=relaxed/simple;
	bh=ca9qHkrngL3pZjIQUsPXDFnGS5wTD5NqFcVTg825OqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACm9WPqY4cWJoigST/Gns/UtFyxeGOcz0AQ0gyBdDQj0BTbO9zP5ynckw4YsZ6vo5+IBBixVLDOtuEnE2aN+lgbVYYGsra5TZJlE1PW+uRKLstuIGgway+rWOtS25291KbmBuBLUWlp3Mb0uY+lCP9v+KdwW+Yb0YHY9itg2964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-866f0d69843so2839387241.3;
        Mon, 10 Feb 2025 23:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739259364; x=1739864164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4rL6fRpPDW3WWAnvPDGJsUVffkkAT6CPBcGQAburtc=;
        b=IjCQCuDLwRcOSFOLv2XBVUPIC7LM7UPQ2rt9+biA3Eq9/BU1SFLzTFzVWoTsJ8Auaa
         09EfbP5mdx0BCZWT1aydakQyOmxGbOiZcNEC0yyH7KKrCUi1ZVR7WudYSAe+AVGrpd+l
         gjSBjYkHv6MHJGQBrCE+e94DV8yRpyGM6zGvRERya34RL/9cDvSmfEJ4xrTi8yqgyMiP
         V3/gA9Nd9078zDqLm60FC7p3r9RXu1auF4urVmiaGWfEFiJUoXdtbU0g3OHfs3vBNB8o
         JDHi6CobSYnSQ7UjX7FHo7LD+yrXQrDy0PSlBbz+ABjCUhkx8WGlcO83IyrlD1daJS9G
         2Teg==
X-Forwarded-Encrypted: i=1; AJvYcCUu2s9tK68BWK66zYL+zJh0M5SsPqEdzmHn30Y7FWyI2ka8ULSBmXWDNOZlW0ydiJDCcPhCQgaF37d2wYBC@vger.kernel.org, AJvYcCV4nMmbydhW60EY8ivDbl+4MaVajgnbTVGrlTae2VWjIYbc2Q11gB2Yo3I658QBMRpyvuNkC3r/ogKj@vger.kernel.org, AJvYcCVmB7yfD0rMA7UysIiF64ma0X2nIXE5gLwd20nAQrOWinW7Y06Iw/UdinxRp3Ihba4X7o5fqusA@vger.kernel.org, AJvYcCWdwuab1uXU4rVW1R59AiqpyHjvmxa+EB0lVovXslfIe1LGt7/d2H8zJzja3PUyFN2jGblmMrq/UmXNTZs=@vger.kernel.org, AJvYcCX8NZb3kS42V6UpVR8cNg6nvYx0tRNRMZCKk6jUAO9dHtLWk9u9rAjXhfUq9tM3LTuTChvpI4wsK2fp@vger.kernel.org, AJvYcCXgx3xBK2mtkA8G6cIV/l1pIZIRT5TjsunMr8XdRp4yatTC/KhyivlcVmWE+KWhu9f75hZPvx4uyOEf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx88uvnu4sYV79zRyfMdM3lyM/X4jJZp3UgYWc07+xMbpVYrkEx
	rtMJv1Hr/eDffDzdwoXnxwhVSkXKTMEUBU2feHmpyAg9z3ykScQ9En06YrbE
X-Gm-Gg: ASbGnctsyU7at4vXDHYGb0+TEGT2uguqgFm26YaTBmVSi0MVZsaCjeiOOMip2rCHHUz
	3TutCLaHkFs8sX8kRvrepCKDmOoAqjaQS1WqVTcLdJkbfFHcNApmyLsBUC+xMwN+ANDhceX8zwP
	2+nIdrX09N3v5rf2iHMoysDfhM2DObtuCfqMnRs+ti5aFLl4ya9olQYuRiIwYWNTxZFjKWcPsuN
	gmJUjHSR2xEi9Uy6poJ8avXc/0eSQonHdzkgRocuOWpgL9RQy1IqxBcCw0X5oauow2W4gnUnyri
	h6jcZ+c2r3605fWgCQIewAZCSjSe1XgWPFIvTpJGienAFZ+Kx1cJ7Y+UEA==
X-Google-Smtp-Source: AGHT+IH64OMvNI//DHpqIhBXMfnM3nyG8byXREG186/r6xJVCGhlgNO0z9wcmRT5dF5guMFstYW10w==
X-Received: by 2002:a05:6102:2ad2:b0:4bb:dc3c:1b71 with SMTP id ada2fe7eead31-4bbdc3c2999mr2831244137.13.1739259363945;
        Mon, 10 Feb 2025 23:36:03 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bbbebc1fa0sm891895137.15.2025.02.10.23.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 23:36:02 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5203e0d0139so1197419e0c.1;
        Mon, 10 Feb 2025 23:36:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+kKNVvHLE2TTHJH5UfWbOsVz9muNHonu5dCRZzdFKsKUyZr5FAbq7AEe9UcURNu6pveFMYGLnNZho@vger.kernel.org, AJvYcCUcwtAIrcYbnU91dowQJWRxG/47CVPCU5f9nddEkXwaIwCggJVxhL9CUQm+K4Y038GUWe/1XQQNRLA4@vger.kernel.org, AJvYcCUjf+3CsH2Z2UZr5HFghS8YMRUx1GWrjica4Rg5ddFCIPf4woAie+G7Pg6d2Lh9s88bZVh//mQdyUkjK5I=@vger.kernel.org, AJvYcCVVHf3ee+qZhIBFB/drNez6MsADke/1F+Qax3Oyb6PQ3+AfCeF9Isn7CQDKr6AL+qPxzcb6Ui6Q/Ev3@vger.kernel.org, AJvYcCWDmpd2eZQ0DV0Rq+wdnMMSw+NVxYSoRIEfC8NFz5aMgBtFwAkZ7J6gLCcZHU1lFO57KJlwDWx2@vger.kernel.org, AJvYcCX49hiBd4gA6pGNwslE80tPwtcXHY2VBRxyj6Lysa1xo9ORhQWfwHCYCJyKUjMmxHqEEl7vX+X94BoM2Hvp@vger.kernel.org
X-Received: by 2002:a05:6122:1d44:b0:520:61ee:c7f9 with SMTP id
 71dfb90a1353d-52061eecb62mr56803e0c.7.1739259362582; Mon, 10 Feb 2025
 23:36:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com> <20250210-gpio-set-array-helper-v3-1-d6a673674da8@baylibre.com>
In-Reply-To: <20250210-gpio-set-array-helper-v3-1-d6a673674da8@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Feb 2025 08:35:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXFXbzeus6yzeBsjOvTsD+AOLKjyRySCYo4YkjSZByZAQ@mail.gmail.com>
X-Gm-Features: AWEUYZkcG2r9GXDExtVTd3MXygmVQFQr3aQqn2D5K57fCGs7Av6ow06VQ5r6ees
Message-ID: <CAMuHMdXFXbzeus6yzeBsjOvTsD+AOLKjyRySCYo4YkjSZByZAQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] gpiolib: add gpiod_multi_set_value_cansleep()
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

On Mon, 10 Feb 2025 at 23:37, David Lechner <dlechner@baylibre.com> wrote:
> Add a new gpiod_multi_set_value_cansleep() helper function with fewer
> parameters than gpiod_set_array_value_cansleep().
>
> Calling gpiod_set_array_value_cansleep() can get quite verbose. In many
> cases, the first arguments all come from the same struct gpio_descs, so
> having a separate function where we can just pass that cuts down on the
> boilerplate.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

