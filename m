Return-Path: <linux-iio+bounces-15306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5AEA2FD55
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 23:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D488169085
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 22:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3525C6E4;
	Mon, 10 Feb 2025 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TLOvJjDN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75E25A331
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227068; cv=none; b=nATG9LqcXS82mvGgtV54r5OTBjzHgvvHAAM3zuMSHjh3i0iqZoMXEMTCQkzqNIUh2CcMTvNHKyLm3MSWm8W+yaPLm/5HKKJusgolKoQIYP2ThtkJz+WQXx+qvgrgqoLGOVlTp6FYI7b64J2sR5NPZi79lUUtNIgs1AxPL860LhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227068; c=relaxed/simple;
	bh=h4/JkT/aieYSqhfnM9UnuUTJJW8FA5AwmbHA2f2Z3qI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KY3quj6QvsFSC0BMo/R0xaQTlzep3Isn0BKNOccfZ8fTVaddCMpSuCNY2g+vFAJ+Lfb6tNovC/hq7EgHavqe8DnFZtX3rO2CbzPbwnogqh5E9tUent8ko/xsMPIwr3kXbNkc8c7IM/u2Jzp4tYibof7oNTmd1M0MCL5hk/Li+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TLOvJjDN; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f3ac204922so1247697b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 14:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227065; x=1739831865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXB+byZeKAp4YicbFdNdAOrg4x68Xt2NQ79nnhRrJVU=;
        b=TLOvJjDNBxarUBELg7go/ZxX0zU+xs39riDy84aC4j2XbIyhm1pT74p/AGm39IqyRZ
         bknIVVrQU2LwEzznw9FCg4/I6+7S/onqBEXzcpR65VT172DkSyNa4b6zuoHcZwRcLORR
         yooOMj/CxF7agVXCqEErNuJBbNcNcreGO1y0qaCMTXz0qQzT3w7uMQD+kc2Q5ty9Dzm/
         3zF3qLHrKWV/Srh+kAZopRBiRZo7Nk9kUIIJ8dS4T6VUnaNj25a1ZNm3dcZ2WGQw+O5a
         qAtRg4iru5kNYEqyRzgAT3OoX/SGWZ5VwNlTo6iGuKGRzWMV5R4ptInabd4QfOB9yJqD
         zbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227065; x=1739831865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXB+byZeKAp4YicbFdNdAOrg4x68Xt2NQ79nnhRrJVU=;
        b=sa0iUMCISAmMwnZpnfvwGZ3nqhJch3zzrWCT2yvoIaA4sxh77+SELGRqm0CxqbkUoP
         G/KCiPd0dJnO5Za72jJIFR6JTKaF2UNIBJ+Y+n0cHaLzuYvsMvK0ox/KHQd+IL89dGOB
         cyGPCOayf2jDmapm/6HZ97H799DNFANRytfqKfGaWKk+TfAVDUMkb9Aw4pe05yRa96qe
         oYXwyPG8ABnFEHXKUo/0Oq0ZTTU17j2RnXeMQpIjGeGPonDYb14DIdKm7xBVNhsk+5AU
         EeDr+9z4GtEcJowNWQEEfldC/KLMS7iNF6Q1BZWcF+39DcdZMru+WQfjU/Rgwy+OJYcE
         sUjg==
X-Forwarded-Encrypted: i=1; AJvYcCUOuqy5Ei1gsTf7Kh3AMLEoA9droDR4JlS383CiVVA82BHU21Ki0d7a4wY0S8jgryWVTl8FgtWdn5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6KtalRe8UbVby721bvS4zp2D/8cRMmQ69E/lwFzBK3NZbz0L
	AZr7ylmZmpk8haX7PdVUEYsnWGEBIF4JOy9jqHBhsc5BLmXgHyVc39KdKrTAG+U=
X-Gm-Gg: ASbGncvIyVSSyJeLGNtn350jlWHYhpM0Vy2rVw5W1fsDG/h2KhMzTyrL+F6mNrYy0sY
	gRc+KVmttqrImb5n9sdwgrkStKm7o5YLOHCeaJGWlACVgiTDZFpHl4VrvKtaoQmCf9dPMZFChce
	krbR1UvT+B99/lIRehbnxpOCnc5qZscQRJoa/O6QypEtxYoWH4ANIhMly7IiDYc5OWHlJnwfOzN
	gyFYz7FyLaH3xyFyxKIcbCZPUmTyAL4Nd9QbU1DkioarxMDEXVmolQ+IBnDaCqmv4Y/zaHgjc9A
	ASM4SfhR67zHb+uJhBt9Qzbfm26jF0fFIGvG/aczQvb+neA=
X-Google-Smtp-Source: AGHT+IHioMIxu9VGnzXizdV46F3qMiFjs48WUo2oHZz5JGkXBH5C7gXq210bMR9McIstDGpa5KGthg==
X-Received: by 2002:a05:6808:319a:b0:3f3:c1e0:c466 with SMTP id 5614622812f47-3f3c1e0c4edmr1094523b6e.5.1739227064928;
        Mon, 10 Feb 2025 14:37:44 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:37:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:31 -0600
Subject: [PATCH v3 05/15] bus: ts-nbus: use bitmap_get_value8()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-5-d6a673674da8@baylibre.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
In-Reply-To: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
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
 linux-sound@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Use bitmap_get_value8() instead of accessing the bitmap directly.

Accessing the bitmap directly is not considered good practice. We now
have a helper function that can be used instead, so let's use it.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/bus/ts-nbus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index b4c9308caf0647a3261071d9527fffce77784af2..beac67f3b820377f8bb1fc4f4ee77e15ee240834 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -10,6 +10,7 @@
  * TS-4600 SoM.
  */
 
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
@@ -107,7 +108,7 @@ static void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
 {
 	DECLARE_BITMAP(values, 8);
 
-	values[0] = 0;
+	bitmap_set_value8(values, byte, 0);
 
 	gpiod_multi_set_value_cansleep(ts_nbus->data, values);
 	gpiod_set_value_cansleep(ts_nbus->csn, 0);
@@ -151,7 +152,7 @@ static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
 {
 	DECLARE_BITMAP(values, 8);
 
-	values[0] = byte;
+	bitmap_set_value8(values, byte, 8);
 
 	gpiod_multi_set_value_cansleep(ts_nbus->data, values);
 }

-- 
2.43.0


