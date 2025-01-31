Return-Path: <linux-iio+bounces-14779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4563A243CB
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 21:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B96188A90D
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 20:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC271F3FD1;
	Fri, 31 Jan 2025 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ueZMN8Jw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6779F1F3D38
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355091; cv=none; b=AMxTzL7xvLpCEywaDzymK3l6ITc3I97oXnLUlG0LcvUPXeFJvFeMQkEvuTsfOOhF7LPtMK3poei0KA2T9Q3mqYwt6AJ1KzkMwmsFntHSLkYL1aenDvgYlkI6cyAVljQ5Hccm98OFimVN2NKkgrii3RMxfKYjALB8Pf1TZY6hWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355091; c=relaxed/simple;
	bh=oe7N+J9cytrMnLNUSaM/Omiuuu90wAztekXP99d069k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ruy+VY6o/V1QDnmTj5/KNZaicOuKgc/gwisQ3OOSLNJSvle/lyevBcDue3vbsjE//fmV3Q+g/cN2KqJilvFAXO2zocQGq1nK27PQKYlbjyIWK+usb48aVG2Lu8osu5wCwI37dm55tn4rdqanrX55S7/r0Xvudr6wjEAffJe80uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ueZMN8Jw; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2a0206590a7so1322860fac.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 12:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355088; x=1738959888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VExoELcV8x0LQmV6C7xp1BlVeCvht+mgfIMccHi3FPY=;
        b=ueZMN8Jwvfxq+NQV2mO6jeS6cQV/cLFNjN5CTUYEa6sBTQguN+LLIxjtEH66QaMmTv
         XaCz6U/OOKgomm2+nMFBh3Jq0MDvqnML+yfPSg+9kiIMSTzypHAweQ1bYTTu+3SJrcDL
         vZylBg681V64dP87Wuzi78d0D7c2GNNuGOdiHWrZAluukTm3GzBeMn2N9Ghv2m+O3Hbm
         ZKkFmBJjdgeHQCcdgi54aa/LExPrwHyI+pTx+2dIovWscRu/P8n7+X/MXpEQENZjzJy3
         cr4AVI8IM5sgwc+kmRMXyAXLwJS2HVPbD2CEKjvnhbEYUC/k4CnpdgzfO9JddltaCvwo
         Jh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355088; x=1738959888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VExoELcV8x0LQmV6C7xp1BlVeCvht+mgfIMccHi3FPY=;
        b=Ftt4P4m7WGA/DG4bPX15OXqt93GiPrE/KAFuYrvoNCSBJsPykAjFy/ysvt+F36j6K2
         qVndCv4yH3BD9jb14i/9VP/4LkFY1aipj+v1qPj0sF/aFJihQGiNjfKwDbOjT6PeUFbu
         5FhBy4d28PVb8WbR9y+NUo5ynLznBvqSGEM2MBiQO4ToMk4p1QEi40Rbqy253t3R4mGV
         KSnxu9St66ddO6t4Hzexle+1gYi6yVNkudfznW4K0tW1ouJ8vrd6ICU+mFG1G0paXmnO
         xrbvhgBGnzJOV7DQ2uoIxJBaSyZGta6oaW9RnwQ4Z63KzMZK/n1QCg9yGKW92GRQdqvE
         XEPw==
X-Forwarded-Encrypted: i=1; AJvYcCW/+LmgT7ENngluYn1timVDyP8kLLv+DFmOTv5kpkNIsJ9rINTjSSKV9LumIf/QtR5/45LY9x0Qf08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpkjjHEAuX18tx+V1/cEJSChN+vS4n76EXI/tCa70a0jU1Ha4
	ltLUBGubIa9pGkauNlNEejX5auzISF8daKRe3do+Oc+jKqmAAJCDXw3nKTykATU=
X-Gm-Gg: ASbGncsfp+eJ7rCEHr2vg7Q2a7qheZXPHtXieTfOt1FJjDkIf4NvLL4kzCRuEcQgeX0
	M1lYjfU0FJ5aqZL+A9xlfKI/GekaNgh7SfeCMVX5OhvBMTEJaOQvaNBTAFDYW59dzfU6Ww2avV1
	LoQh4FOSw7WT2pEEcJuMWntQeJEDMjfECl4pHfCcG+/Gizej/9C1uTURvZILv0r3vRf/OxfhraS
	3s5sJAtrC3egwYpC0CS6HfzUkM0KDST04+4pEhsbswJRmDmm4tKqbF/YpBjEEv+zLVoPGgsV3/q
	HcoKxsmFs49fkUv5YPzHU9xyk889i45DhIHwt3CNjxSGMK4=
X-Google-Smtp-Source: AGHT+IG48amD1C5d4QahkI7FJNfsOoMi2CtgfNG8+gnzn0CcyJBNzM/PkTQMiDNqV/T79ZK3cKZLjg==
X-Received: by 2002:a05:6871:a012:b0:29e:5297:a2a7 with SMTP id 586e51a60fabf-2b32f3ca389mr8811438fac.30.1738355088436;
        Fri, 31 Jan 2025 12:24:48 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:24:47 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:41 -0600
Subject: [PATCH 01/13] gpiolib: add gpiods_set_array_value_cansleep()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-1-991c8ccb4d6e@baylibre.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
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
 linux-sound@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a new gpiods_set_array_value_cansleep() helper function with fewer
parameters than gpiod_set_array_value_cansleep().

Calling gpiod_set_array_value_cansleep() can get quite verbose. In many
cases, the first arguments all come from the same struct gpio_descs, so
having a separate function where we can just pass that cuts down on the
boilerplate.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/gpio/consumer.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index db2dfbae8edbd12059826183b1c0f73c7a58ff40..1c9bb3cb1ee80fe52aabf5bd24b1d128eff2bc99 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -655,4 +655,11 @@ static inline void gpiod_unexport(struct gpio_desc *desc)
 
 #endif /* CONFIG_GPIOLIB && CONFIG_GPIO_SYSFS */
 
+static inline int gpiods_set_array_value_cansleep(struct gpio_descs *descs,
+						  unsigned long *value_bitmap)
+{
+	return gpiod_set_array_value_cansleep(descs->ndescs, descs->desc,
+					      descs->info, value_bitmap);
+}
+
 #endif

-- 
2.43.0


