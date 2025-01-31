Return-Path: <linux-iio+bounces-14788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3E5A24400
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 21:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6193A92A5
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 20:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CE81F7900;
	Fri, 31 Jan 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wlI+CUIC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F8A1F76B7
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355114; cv=none; b=RbRz9ca9ttysB32RMZwF7rfPkadaOmNfOGy6UP4xb+MVNkVSFp1NKwZq72YBWyOWCp8TEw9vxJiMAlizaUprlWEN7GaLl1TQGxCS7jMk64bOiQyBtwh1tGWGXfcm6FX1h+rCjUXwmH104U4ysHbEltfcfQ8vw57Uw53hjDTx6rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355114; c=relaxed/simple;
	bh=9CicIm6xDarlbk67AANQJSF1s3m5MgjSBlIRcxjc/Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xsvyt3YaYG0qRRx6pHsL/tampxyXLV+nq8X8nv7OX2pLhYdkuDASm/nDefU+3StTx34pHQTxdIgHtGpaFs5/A9Il1NlGuhSfCjZ0gVgHVkhKHQu3uap47aR2gDf4RPVdver4y6qsD8nFv9DBu/k9Ou6EMo1cwfjRQcc/h4x5gwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wlI+CUIC; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29f88004a92so1298206fac.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 12:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355112; x=1738959912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8dlq+1FyobpCXd9TkKRwFwRft57r9IiORFW/g/tAaA=;
        b=wlI+CUICXgXZ59m2jPFbdGv2J3EAl6YkI5OUi/o+5HQFg88HspRlr0dr1Ize9/zZhX
         vgbpaxsjqQ/QqRq1yjMqvW9qbxX33uCRK4wTRB91evDI5+FGRFEuBDaMCqG/MQZpJC3/
         bCWmxqxUDHoywe7tnFcOdgK2yuwPKsY+vyODObT6GFruCueLz/oc+ccc/9kSiZ+XWO8E
         8hdmqDBq4XpUmELiwQFDfZpCjeeFhJdOkm6M20lOsf8VzfgOqD5FaKNCKmDUeS++Fdp6
         Xq3mCVUjEVhfX7aQ5E0CD3QkC7ZwhZ9xffOXr1M0hlZ8bVJXGwPCZbNeTgRpOff8wAZW
         z6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355112; x=1738959912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8dlq+1FyobpCXd9TkKRwFwRft57r9IiORFW/g/tAaA=;
        b=gg4KtYbl+8L7F/bW7im/s05CxWmUMZXtQscvmntsW43OYPYvUXojMiZJFMSbs+IZ8F
         583QT1YJLZ9zQ5J9Jdia0XW+JiyZcxhs0eZIHFxi/zqha1EE0mgujNVjnx6UvViCDToN
         3rmn9rNKnRjfBMPKIJ+ClSoQrHAkLechOEUnIS0eeLVl5znTYR4ELrvK44002+mjWa6o
         vMAgLzxVFsyYowzHZ9nNpKhcUnwO/QyshLF0uOxrcnWrbHCJCYMKaFNvmyCOCp0fvKPr
         T9WR3VT51iye95FfTV0XASxznJJMJwPoZyVafGkTfjJSDMQ5kX/qMGWRVDyN2w489cMd
         Q5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWlZ1nmt4zCTZ7SDNZBfs9Pk+goEwl9F88JdCbffyuX5BpMKCgwZbaT/nis7KXK3o4IBbOABs0m7VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9+kIFQsknXnbz2SxwTaTj1GFZUFX+b43K8XY5QvEzo1lkQFj
	eSf3WgbuVzDmw37kWx1ZUWCYpbSYcPbab4mTmLR2hu0/nTfKdhd8s9Ry5ZAjX2Q=
X-Gm-Gg: ASbGncua+AnpuOPUV7GIiIcLopdR3RLgVtmP/hM6bLuisyDWkkiSgYPeUMZ/PLUMYaa
	6gsJ+oEkIIMcoENRT2p8V/30+Ztv+I3fLJP848B2yp3Rhezo+wD7t7BXP6oXBzmtCOkH2AleTOH
	qp+7bxL6LKStBgSMCZiJhMOu31sKv9PXlFXup3BAYfKYScYNJzXJCj6xrhBtMqWpjhE6/QYc+re
	ndP4vB8Y2Pi26m0PLEYEkMlVuIFutWpkxAINC0irQoFpGyfGX+t2HjcJg2AJatom8EI6fMrm8DG
	IzbyXPRk1juzBFN2ssiZkLDb8tpzAVIZnDrsn2M4/97y0zs=
X-Google-Smtp-Source: AGHT+IEOPFpYcNvsoJvtChI72uu39YNNI5XV7tV2UH+PWhk+hEwEt/BHCYYItie+9RSXj9400mKLXw==
X-Received: by 2002:a05:6871:2106:b0:29e:2caf:8cc with SMTP id 586e51a60fabf-2b32f30c9fcmr7202349fac.37.1738355112453;
        Fri, 31 Jan 2025 12:25:12 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:25:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:50 -0600
Subject: [PATCH 10/13] mux: gpio: use gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-10-991c8ccb4d6e@baylibre.com>
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

Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
gpiods_set_array_value_cansleep().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mux/gpio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index cc5f2c1861d4a22d984bcd37efb98dd3561ee765..fdfb3407543dc3c2563750b013754ceb3390e39a 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -28,9 +28,7 @@ static int mux_gpio_set(struct mux_control *mux, int state)
 
 	bitmap_from_arr32(values, &value, BITS_PER_TYPE(value));
 
-	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
-				       mux_gpio->gpios->desc,
-				       mux_gpio->gpios->info, values);
+	gpiods_set_array_value_cansleep(mux_gpio->gpios, values);
 
 	return 0;
 }

-- 
2.43.0


