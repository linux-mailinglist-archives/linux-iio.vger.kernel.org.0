Return-Path: <linux-iio+bounces-15301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E529EA2FD39
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 23:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A915E3A55AE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 22:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB0C253F06;
	Mon, 10 Feb 2025 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dNxvM1PT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7778253343
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227053; cv=none; b=WrSdVkM5sLihxF2mhzrLNZsz3yXLlpJJ8nTN5QqV3ywDK6Zl9RpPmW/wXibUTNT/UJEXyd98kpFp8rKpEMUeQeT/Uv2vzd/Or9ZjHKqY7pyPjj+mCUTdloGPOE7NBJ4qtoYLOZK5Tk3Bbm0j/Bspb/KREyT5VxBgjyKAi+OGbgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227053; c=relaxed/simple;
	bh=afEXr0Ym345b+01JWvSTXXjtaEwJ8nYEblSojlE39NE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iEjw80/Ksr6MqU6SOt0Qp9HU/8GRl/FJVpvJQ1VJx03WXINCmtUDIQ0kPluJ0ijLRLuDM5IXDdzkDaJHQjr6damDCgfbmySvUJd/NRQc7sdIj27o4fL1nYPMi0v5O9gmbKVQAcMMMycgFpNYCx3f89plMrg3Wyi3mo4F2p/K+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dNxvM1PT; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f3ba3d0433so594074b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 14:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227050; x=1739831850; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab4LJ9OfN5R35QeUwpcAeHgQPVCquBOJeARRwrwUU60=;
        b=dNxvM1PTOikhj0bgd5gWpulEoUseM6YcLRSKCSZEzbP2S5Y+OWKJYP5ZZPl44zLIvX
         aUe910QjwwjJgQv5A4TouSJ8bzjuEn+b1mdVk6VJKO0QlqL8b5pzqv6fVowCEa1KtQTt
         z4k8TtljAtU7Pg6PmrQAjmrPMGUcx478O/sXboCOOZI3s9zHbWkIz8oMPvvd0u06JDFS
         Zb4AcpG2f3hKWhfFJZDOGdkzsbLOGq8eXVbPAX7++k49MRIStGtCfRvZj92Tx8BA4qeI
         FtZatXQVjv6SMloLyLMKsUDzSYv+jr/a+am0PPirSbGBPuEmJof3Pon3ZIEis+em24fL
         CORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227050; x=1739831850;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab4LJ9OfN5R35QeUwpcAeHgQPVCquBOJeARRwrwUU60=;
        b=aEF7Nnaq4A/3MCR7ux1tExOqPT6QioCqiT6/wqRmp6Wp9BOMA3z1p7YJJxCsbIwVdx
         tyxWljblBQAIfvj2PsjlMtqfnaOw28B2gPy5Svr91vBeyQnJVClE1umzDlHY2r/b/1pi
         psABzkXPXVsWDM5DaYTn1MAGV4dT8Whpv4nb+cGIXtyjGyIR40wQzGYgTBETXVL5BPLy
         cQAAUbnBNvDt9bkI8+a0iPGZmwUugExdBe3zkwhP+O7UKmftuSgRqTKF5A5jvD5jCzdi
         0g+g/ECpzTsFWr5XzmoKOSsOikxthoRjC557YDBdz7w+gSUXz6iy/qtrqRYD5gL71D4U
         68qw==
X-Forwarded-Encrypted: i=1; AJvYcCUgselLHtxDQGN0Fn43spLy9JondZuyOPKjXDE0WqnJsyW2JZ4l6H7Djlg6NjP+Hh3A+DGl4r92Nl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgajBX92GguUrsAkx6CXDChxMZk0nSsCznNAX3IRU7mNg/vb+
	o+B66tByb7xTZ/qvUgSrxkmMeiCtEQGda/xMSImf/0cwWcC0bupWI+rsttaQP78=
X-Gm-Gg: ASbGncsRfNBeBa+sJEbWV2w+ggwcTQobAp7Fmz/g4CnMODnY/pms6hHaifOQNEFRY8b
	T1nQC7yZXeKnZFiWbL3FHO6UpKaLW9LJk6dlXoog3Hr5PFHiloeNOOsFsFTTBxMMOjl6tPKuOVF
	xqXaRbD5tilE7Eqy2RRrpgpoHETVJ0Ug6N72n7MXugSblEGJ7M1WAv2rPJB5FM/2TJ80zD8qvRJ
	z5xXDX2AeiKpoJ8PtZNfZlY3QtVjM44HTpZ5OTB360jIdtt/b5nWT29dKMYueRYADMn6yg2DO1i
	asrse2oOQB802R9W/jY0W93RZBXg18rB/Hq2VVXSoT9q7w8=
X-Google-Smtp-Source: AGHT+IFEgA0pJb7eJnXxFcDkmebwOZge9kDnXmYCEiBKRqgUBP3v1eLeI1sEGHGrzyQ56T+MANckEg==
X-Received: by 2002:a05:6808:18a3:b0:3f3:bf98:c4b1 with SMTP id 5614622812f47-3f3bf98c976mr1193202b6e.33.1739227049851;
        Mon, 10 Feb 2025 14:37:29 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:37:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 00/15] gpiolib: add gpiod_multi_set_value_cansleep
Date: Mon, 10 Feb 2025 16:33:26 -0600
Message-Id: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZ+qmcC/4XNywrCMBCF4VeRrB3JpVdXvoe4SNJpG6hNmZRgK
 X13024EQVz+B+ablQUkh4FdTysjjC44P6ZQ5xOzvR47BNekZpLLnAsloJuch4AzaCK9QI/DhAS
 mybSSlSp5o1i6nQhb9zrc+yN178LsaTneRLGv/8QogENdC1tZa7KmwJvRy+AM4cX6J9vRKD+Q5
 MUvSCZI2LzlWdWWtVVf0LZtb7b5zjgGAQAA
X-Change-ID: 20250131-gpio-set-array-helper-bd4a328370d3
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, 
 netdev@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-sound@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2

This series was inspired by some minor annoyance I have experienced a
few times in recent reviews.

Calling gpiod_set_array_value_cansleep() can be quite verbose due to
having so many parameters. In most cases, we already have a struct
gpio_descs that contains the first 3 parameters so we end up with 3 (or
often even 6) pointer indirections at each call site. Also, people have
a tendency to want to hard-code the first argument instead of using
struct gpio_descs.ndescs, often without checking that ndescs >= the
hard-coded value.

So I'm proposing that we add a gpiod_multi_set_value_cansleep()
function that is a wrapper around gpiod_set_array_value_cansleep()
that has struct gpio_descs as the first parameter to make it a bit
easier to read the code and avoid the hard-coding temptation.

I've just done gpiod_multi_set_value_cansleep() for now since there
were over 10 callers of this one. There aren't as many callers of
the get and atomic variants, but we can add those too if this seems
like a useful thing to do.

Maintainers, if you prefer to have this go through the gpio tree, please
give your Acked-by:. Several maintainers have also requested an
immutable branch, so I expect that will be made available. And if there
is anything leftover after the next kernel release, I will resend it.

---
Changes in v3:
- Added IS_ERR_OR_NULL() check to gpiod_multi_set_value_cansleep()
- Added new patches to clean up accessing bitmap directly (ts-nbus, ad2s1210).
- Added function prefix for max3191x.
- Removed unnecessary braces in ad7606 patch.
- Picked up additional trailers.
- Link to v2: https://lore.kernel.org/r/20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com

Changes in v2:
- Renamed new function from gpiods_multi_set_value_cansleep() to
  gpiod_multi_set_value_cansleep()
- Fixed typo in name of replaced function in all commit messages.
- Picked up trailers.
- Link to v1: https://lore.kernel.org/r/20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com

---
David Lechner (15):
      gpiolib: add gpiod_multi_set_value_cansleep()
      auxdisplay: seg-led-gpio: use gpiod_multi_set_value_cansleep
      bus: ts-nbus: validate ts,data-gpios array size
      bus: ts-nbus: use gpiod_multi_set_value_cansleep
      bus: ts-nbus: use bitmap_get_value8()
      gpio: max3191x: use gpiod_multi_set_value_cansleep
      iio: adc: ad7606: use gpiod_multi_set_value_cansleep
      iio: amplifiers: hmc425a: use gpiod_multi_set_value_cansleep
      iio: resolver: ad2s1210: use gpiod_multi_set_value_cansleep
      iio: resolver: ad2s1210: use bitmap_write
      mmc: pwrseq_simple: use gpiod_multi_set_value_cansleep
      mux: gpio: use gpiod_multi_set_value_cansleep
      net: mdio: mux-gpio: use gpiod_multi_set_value_cansleep
      phy: mapphone-mdm6600: use gpiod_multi_set_value_cansleep
      ASoC: adau1701: use gpiod_multi_set_value_cansleep

 drivers/auxdisplay/seg-led-gpio.c           |  3 +--
 drivers/bus/ts-nbus.c                       | 15 +++++++++------
 drivers/gpio/gpio-max3191x.c                | 18 +++++++-----------
 drivers/iio/adc/ad7606.c                    |  3 +--
 drivers/iio/adc/ad7606_spi.c                |  7 +++----
 drivers/iio/amplifiers/hmc425a.c            |  3 +--
 drivers/iio/resolver/ad2s1210.c             | 13 +++++--------
 drivers/mmc/core/pwrseq_simple.c            |  3 +--
 drivers/mux/gpio.c                          |  4 +---
 drivers/net/mdio/mdio-mux-gpio.c            |  3 +--
 drivers/phy/motorola/phy-mapphone-mdm6600.c |  4 +---
 include/linux/gpio/consumer.h               | 11 +++++++++++
 sound/soc/codecs/adau1701.c                 |  4 +---
 13 files changed, 43 insertions(+), 48 deletions(-)
---
base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
change-id: 20250131-gpio-set-array-helper-bd4a328370d3

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


