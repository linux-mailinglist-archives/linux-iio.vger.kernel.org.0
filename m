Return-Path: <linux-iio+bounces-15429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1096AA32283
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 10:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE35E1638EC
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A95820C486;
	Wed, 12 Feb 2025 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1bY7ylZ7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDE20B7F8
	for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353019; cv=none; b=MhrLKYZzgfbcFuJglJp1I5rYx3573PzzFC+ba4dnphqFJYlPPNjR/ahvtlC+oL6D1pnwvkOEK0veohgZrgzgdN+hi+dqNvKVRejJKG6a5n5ThqA4RQAc0tXsaM0z3ev6cSgzfQPJ6PYGF0OX8B0pPdVGVJFVbVO/GrvTzs47gJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353019; c=relaxed/simple;
	bh=7KT0FF/FzIbIE6w2ehfIcEyeGHIB5NZeS2fUmYmWmwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0t78fda63BKLBuqvTfENIL5KKuNmw1lcASZoMk4538UkIQ8wuh5GfqnVfsNhssO2L7+7V6/s3UCh6x8UyB1A0EBVhN71iJfGI8a5gDuveZwZv3hpb8OXCD8yXslf25KLxbIKGQ2N4x718H2jSXjcbqWhGWhY5oP/q0LbnzTlDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1bY7ylZ7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-439307d83f0so26397015e9.3
        for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 01:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739353016; x=1739957816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRhZaB3W6faFlCbku+LscU579s6QSzZfyLaHX9G8q1c=;
        b=1bY7ylZ78sEe+qzdUjM2zmGfl1QOFXMRsX6hXdSa68HPLuyAOu9iJXDh0S+L6QuX6e
         NGG0J80Xki52AuIezFQssR0b3LYZRjmc7w2Mi+gjGrz5fFn4u9aYZ9BEBvvJl2YQVLzm
         34JyT8vew1VSBU9l4TeMWsrWJoOSZqen1K0wrXR5UVDzay1x1nMCl2fgAkqD0yTgz+6l
         rvVXrBNSuIMhJtFa8EvuqyyKbBN1JrdwVZDhRpe+gGQDpssIr6uTkd3BnUVVRgbzh/6k
         JwBUSbRHO5tJlDdyhhgPLpTIFpDVbsOizKfSb9nUArzef29+F7UPKxezK8ze/Pok4iI8
         CHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739353016; x=1739957816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRhZaB3W6faFlCbku+LscU579s6QSzZfyLaHX9G8q1c=;
        b=j6qBCJ7T/noLrlEIf08RHIVVzHSFGZK+w6g7wOp+y1/gCdQkR5chv8j8yyYZhfGZI2
         pCuZSOE4NpPRpkw6B2hggLX8SZoMNPxJPbSrvoCAVmBj7whOD9Avkhlk32mV3wvVCjC/
         nJCHpjv20EGNrMbpKAT8d0FMOfHF8vtnQsUdEzH1Nv1pTvJnaTobcLjRLdKo1GFtNp+O
         JGZEc79v1bO8lQCWIwP2m+DUfuinxyKsv3YW3nFkcF+M8JfAs6lM8oebYJzDDB5zx5nC
         hgB2oeH6enr8eMlJlDyEIG6XGpEhe33qjsnJ0wj1DZQMV9bE6vvqFUVRPkTyFknrUaa4
         OcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmbSh8tIjMUaZbo/GShKkG20+YsuAkwH+fT6MrcWvKnDAMpMebtJpghRMsK/UkuHP/zBV4fblt4+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPtUvnIySqPEywV9IN2NlFtLBWSIO56azu+ki4MIITa1z8aFd3
	RtaQFINJx+srImHumEVStbTmM0aJJTYYUDi3RMq7RgGvUwNThbSkIk1Z5cN2ZM4=
X-Gm-Gg: ASbGnct6l20o3utzYozds8BwICD0xjwEQZtfAY6QvpUhvSsAZPvgSlhF1PgwMjp1pqe
	h6HpIlzbYqEpOX9we6UuDZ2Qj8TJxOuKlOleHdOJYHvXHYKkMCca4VBpzwleTQIRvWOigqpIX/h
	J7Tw3QvWAnAdyDVEs9O79uKHza/NH0W7VKey6nEZpA646BWOEsXtgIW5BX5Ns1wKXv7ojpynUkG
	xHaFUVfgQJOsAcMBzSZT03itSsaoF5EIPgWeTBOrlDMqMHa/JDtO6lX/sP0AWTJe1BsccL6mrzH
	XIHAngYLOcC9fsI=
X-Google-Smtp-Source: AGHT+IFQnul0kNzls6ThIvi1z7bQ429pLFDaGlT/FcOXJm3pTEnq6re0+Qc4O8V8syw5sWV5sK78UQ==
X-Received: by 2002:a05:6000:188b:b0:38d:b34a:679 with SMTP id ffacd0b85a97d-38dea2cefc8mr1824460f8f.37.1739353016217;
        Wed, 12 Feb 2025 01:36:56 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:521c:13af:4882:344c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a078448sm14132935e9.34.2025.02.12.01.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:36:55 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	David Lechner <dlechner@baylibre.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: (subset) [PATCH v3 00/15] gpiolib: add gpiod_multi_set_value_cansleep
Date: Wed, 12 Feb 2025 10:36:53 +0100
Message-ID: <173935301204.11039.10193374588878813157.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 10 Feb 2025 16:33:26 -0600, David Lechner wrote:
> This series was inspired by some minor annoyance I have experienced a
> few times in recent reviews.
> 
> Calling gpiod_set_array_value_cansleep() can be quite verbose due to
> having so many parameters. In most cases, we already have a struct
> gpio_descs that contains the first 3 parameters so we end up with 3 (or
> often even 6) pointer indirections at each call site. Also, people have
> a tendency to want to hard-code the first argument instead of using
> struct gpio_descs.ndescs, often without checking that ndescs >= the
> hard-coded value.
> 
> [...]

Applied, thanks!

[06/15] gpio: max3191x: use gpiod_multi_set_value_cansleep
        commit: eb2e9c308d2882d9d364af048eb3d8336d41c4bb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

