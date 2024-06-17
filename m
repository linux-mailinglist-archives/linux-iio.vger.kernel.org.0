Return-Path: <linux-iio+bounces-6374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C242490B270
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F021F22488
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832F71CB33B;
	Mon, 17 Jun 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uPhcUNEQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11001CB311
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632235; cv=none; b=KOEpSrH3EStaFYdV4aj5FKQiqoNW8vHmuwWQGX0m3qlN9Ak6BsHATsdx3ECkhlal7Q5MqtNzV7z6QuS5vZRmXJLuIlU6qhPwc+bZXCUS4kxEo4NpE99SKydGCn/nfyYNFL5KXHKeekveBIl0+Fvamwnp7P1DWD4RpI7QNqTEDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632235; c=relaxed/simple;
	bh=vYvxwaeOXd9WIOr0jyiodES08IYnBg0cNG1tIcDEAbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/yRpjH5PVgcGd8/GdxJoXJIVr8n3wqfTdgevukKmNH1gg9StOUQ7XX4YN5zlEsJ9CqYiwAHs8KXmQlyZYzX3OIg8m598IItxcrMlSEkBxL8iCrM8V3QwRQ+kmVR1/lD1H1tGtIvoW3v3hWF9lXtWnPLh7SuP6APgNaMfIy6SFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uPhcUNEQ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b97a071c92so2082934eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632232; x=1719237032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPhEFIEI65Agzd+gTNE/8pf9Wc0auEQHD6gWw+Mp2Us=;
        b=uPhcUNEQpZaL7TjxVfRpIlBjUf8o16RoIf9j7grR+rzfj0Ati5+Wf0Hj5CFtxKt3Ku
         ISyeqRUkxzFRi8pN2b0qzoQiSakDEziYgMUL+kiNeHorGjI8J4tQsVlk7g2ooJqznZhC
         VCh2ac+6IlBy4EOC9IFjQxLh8qTJ8Rlcv2snvx4N5scMVKCvLfCS6WnGSohkNKcYtB9h
         HaPDX4dzhDNB4079IvhWREg6qX0LsnB/UzHJbTrsudgA0XsOw6KIApx9+R4zmr39vtWO
         sB4ENfOZGYoUsUBMy+8FWIUCL8hweB/YaXVvGCDVUfEAP81segP5ebk69xnZR4h6Mopz
         pdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632232; x=1719237032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPhEFIEI65Agzd+gTNE/8pf9Wc0auEQHD6gWw+Mp2Us=;
        b=pnW6SmBsIYImwUsT0Z1kjNhnC0HuR2YiX/Yh+g/KBz4BLseoBgXx+H7whvMJhHSxhT
         cfjO5aRA1QkbocFq5cUwTokeKlKUZtUOj/l1Snw3Wjlh89H1RqeYcYEIoom991jjz+KJ
         40xF5pW0PUv6AcwpWv32/kMSOx702EhudOuMi2ouC3jTC6ZYmnS72ECiidZexcJA/lIG
         drqk+RfK1okudthHEdJ2ywl0tH66rVZjUI9IkAxCE3RubY3TmmXwl2XjRAHiJ8U3rMkh
         W5sIn6w66G7tLq4rwDqm1m0WC3MB8axXj0r+J0jWtVa4pB+sMEtdl6SJLi6pEOeGF32r
         ahgA==
X-Gm-Message-State: AOJu0Yy2c0FJdX7p2bpbcwbtWNXNq9JfQ6V2FIV/Y8q+ha0hJAbz8H2E
	JzmhNGqXi4kHmNq+mfc6ULHqZ8pymtKQakIbbPtjFi6oyMGBmiRIbkuda0jBt2c=
X-Google-Smtp-Source: AGHT+IESOlQlf6WzweXkTkf8MrnVQGCcG3xC67OqCrm+RTbQElgJSgw2YCA/KexywnTT/s9UGGqyWA==
X-Received: by 2002:a05:6870:c1d4:b0:24f:dd11:4486 with SMTP id 586e51a60fabf-25842ba209bmr11672904fac.36.1718632232087;
        Mon, 17 Jun 2024 06:50:32 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:31 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:02 -0400
Subject: [PATCH v3 22/41] iio: gyro: mpu3050-core: make use of
 regmap_clear_bits(), regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-22-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
In-Reply-To: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Saravanan Sekar <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.13.0

Instead of using regmap_update_bits() and passing the mask twice, use
regmap_set_bits().

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/gyro/mpu3050-core.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index a791ba3a693a..ff1c81553045 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -197,8 +197,8 @@ static int mpu3050_start_sampling(struct mpu3050 *mpu3050)
 	int i;
 
 	/* Reset */
-	ret = regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
-				 MPU3050_PWR_MGM_RESET, MPU3050_PWR_MGM_RESET);
+	ret = regmap_set_bits(mpu3050->map, MPU3050_PWR_MGM,
+			      MPU3050_PWR_MGM_RESET);
 	if (ret)
 		return ret;
 
@@ -513,12 +513,8 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 				 "FIFO overflow! Emptying and resetting FIFO\n");
 			fifo_overflow = true;
 			/* Reset and enable the FIFO */
-			ret = regmap_update_bits(mpu3050->map,
-						 MPU3050_USR_CTRL,
-						 MPU3050_USR_CTRL_FIFO_EN |
-						 MPU3050_USR_CTRL_FIFO_RST,
-						 MPU3050_USR_CTRL_FIFO_EN |
-						 MPU3050_USR_CTRL_FIFO_RST);
+			ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
+					      MPU3050_USR_CTRL_FIFO_EN | MPU3050_USR_CTRL_FIFO_RST);
 			if (ret) {
 				dev_info(mpu3050->dev, "error resetting FIFO\n");
 				goto out_trigger_unlock;
@@ -799,10 +795,8 @@ static int mpu3050_hw_init(struct mpu3050 *mpu3050)
 	u64 otp;
 
 	/* Reset */
-	ret = regmap_update_bits(mpu3050->map,
-				 MPU3050_PWR_MGM,
-				 MPU3050_PWR_MGM_RESET,
-				 MPU3050_PWR_MGM_RESET);
+	ret = regmap_set_bits(mpu3050->map, MPU3050_PWR_MGM,
+			      MPU3050_PWR_MGM_RESET);
 	if (ret)
 		return ret;
 
@@ -872,8 +866,8 @@ static int mpu3050_power_up(struct mpu3050 *mpu3050)
 	msleep(200);
 
 	/* Take device out of sleep mode */
-	ret = regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
-				 MPU3050_PWR_MGM_SLEEP, 0);
+	ret = regmap_clear_bits(mpu3050->map, MPU3050_PWR_MGM,
+				MPU3050_PWR_MGM_SLEEP);
 	if (ret) {
 		regulator_bulk_disable(ARRAY_SIZE(mpu3050->regs), mpu3050->regs);
 		dev_err(mpu3050->dev, "error setting power mode\n");
@@ -895,8 +889,8 @@ static int mpu3050_power_down(struct mpu3050 *mpu3050)
 	 * then we would be wasting power unless we go to sleep mode
 	 * first.
 	 */
-	ret = regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
-				 MPU3050_PWR_MGM_SLEEP, MPU3050_PWR_MGM_SLEEP);
+	ret = regmap_set_bits(mpu3050->map, MPU3050_PWR_MGM,
+			      MPU3050_PWR_MGM_SLEEP);
 	if (ret)
 		dev_err(mpu3050->dev, "error putting to sleep\n");
 
@@ -997,11 +991,8 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 			return ret;
 
 		/* Reset and enable the FIFO */
-		ret = regmap_update_bits(mpu3050->map, MPU3050_USR_CTRL,
-					 MPU3050_USR_CTRL_FIFO_EN |
-					 MPU3050_USR_CTRL_FIFO_RST,
-					 MPU3050_USR_CTRL_FIFO_EN |
-					 MPU3050_USR_CTRL_FIFO_RST);
+		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
+				      MPU3050_USR_CTRL_FIFO_EN | MPU3050_USR_CTRL_FIFO_RST);
 		if (ret)
 			return ret;
 

-- 
2.45.2


