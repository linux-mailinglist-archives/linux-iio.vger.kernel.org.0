Return-Path: <linux-iio+bounces-22631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E64B5B22E9E
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 19:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC981A2585E
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 17:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD792FD1C1;
	Tue, 12 Aug 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naKSE7Wj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17082FD1B6;
	Tue, 12 Aug 2025 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018596; cv=none; b=E5T9dYd9eIoF84rpw7WE7ysh2hjkyOds4DfC/9pWNYHG6wi6OiHaXPg0w/FFl7+05thE9lvp/j7vhIuofEGJTFyJyVKeGFnqeD2J9kpavb/RPeih6SbG+nz7TFJDI/ao4hu4Oeah5/YHpLFa8J9YUABynwxg+TaYOLMPHRnD3V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018596; c=relaxed/simple;
	bh=IqcVlKobCq588xENs4uppJQybncqhnqWvF/okPMFi9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WwB73MymVtTTaMR1x51MkZ03fvNfygeMMl/2lD62XBaixtjcvyLzy0+Sz5nCEGbfFjtOrqE1AOaOkOzon/icwnQmHJZnJfaHlLD/G2M5O7D3l2rn6eu3pec9UCDroPC9rQstzzsWRPhyE1hgGiJh5XSpGFybO3PBlGcvNvtvjDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naKSE7Wj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6154655c8aeso7946087a12.3;
        Tue, 12 Aug 2025 10:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018593; x=1755623393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vX0TuGQonU3UOEkHT336V9Rsbi3kkwvkQnEgGTeWBb8=;
        b=naKSE7WjGvA7c6wMPicNPhWG+GTk+cg7+czw5r9a8vWVi1mKL9nLGGfrONYF2nvj1G
         SEmqoD2TP1f5Un7voh2wzjdBAJZ+x/BkxXfRyOA46Y93B/9wVb4iAEoOiroD7g7Ytyfa
         V67oQpRkJbjo9pRD6ZScdi747ey1+rSpw5NgUkSmttTFTGixJ2p9Ic76iGIeA9fL4jW0
         16hYCzV1yThgMGWSQsu3W4YKhqe1u9tC3RndgEgd6pf4TFh7t8jCQ/NAb04Bn0Qkwp4J
         N01GNnlIvqZSL3xd3xrvNEPIRVjTd3+mxeEZbTQm0uml8RhjjNb3nN87e6d5++RJJ7qf
         mWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018593; x=1755623393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX0TuGQonU3UOEkHT336V9Rsbi3kkwvkQnEgGTeWBb8=;
        b=b7d8d60o41YuRqy5/0Rlr3ZT0UQP/pcu+zOwf2s0/mmJqxt9sABg559Irf0VFK/jFG
         luhaKxjUDUD7qpW6Q8/WxFJviGGARc5Ayd8cRoZYFOzV1k620PXxM5U5/LmZO7SA1FKq
         TVbVTLeyCxNFZ5tY8fYxp6rXXWaoFI91ZiLT3VLM22go4biNjTjCUTZp3JvGL+DWTAhH
         ec20ebGm9VllZD/0V+8jhuow5CKfekxTROM3WQYvoyFyTOTyMiokfn7uF8Lx+jNhb0EO
         xVqAVqFRkWq1LZiEJbhDnYZKIo1c84yI4TxXf7ZbSaCEQRwJjQwJ/lY4u1QpotJnAqmQ
         oQfg==
X-Forwarded-Encrypted: i=1; AJvYcCUYCEFH+Dja19HpY9yizolKZZnrBKkF8sg0JVEg6kDkIa86nZDDvpSjoTV3o7S5abIkmi+PEIx5JxHPAdU5@vger.kernel.org, AJvYcCUtShmZwvTNzFUJsgaN7YTqnGgK3wamqLYdiBXeUvWJcmdlD0uccwFOo8PpaiXAfQ8U6IPMeIiGvg2D@vger.kernel.org, AJvYcCWTqnf3uQD4E5xV95a+GDKdDfrVXNLLMau+3JG8uh5aOmw8yYOjWeUmSoIHS64L83BnwZVlghHavpPO@vger.kernel.org
X-Gm-Message-State: AOJu0YxoR4zHu9u56uHkgSL44MQOEi4AuTK05QovsJLfXKytIVXRLyEZ
	OPyM9sHn+PTRtOAIEkSpFRhO32jd6UKkOPZwCjA70KM+2uqJTMEvLIz7AIPE5B2aIlM=
X-Gm-Gg: ASbGncsd4yEax+3dgKsWaz2vtxN8LJvoLPwM0pvhvao4MH2FajwKKyh+FCxQ7DhMMHc
	JylLBu7tW4w7as3qz469818WhLpHJq9R1JgyznBLdpYbt64K1ejy2pGP1hIfLfF4XMY0puVwTso
	EHUNnPC1Lfx6WUZg94kVYxPKzJsjxkGgduKnsDKj3U41A80wLlCkrg1vmWiGHzInsk42T9ihAHG
	lfoVjvmPj+Llr1x1szh0Ip5OauxCnA5NgVvohpdJ/3xRhY2ZO+utYOXMtwIf2e1A5QgJjeb51gV
	rvzri0MfreU7RrUcbrGZ2z7lAUAHJq4wMVsWVp5gYaqFPqjLlK03ew9KCfbdz47JLjW5aFSAN0S
	JMvfCRGHiega64AJeVt4ROYQH+Z3r
X-Google-Smtp-Source: AGHT+IGujNqMN2xzvVE8FBhpzCSU0HBFQjBoPP/HvcJJScIyp8gPrHUaAOMhLferaWK0d6ngpBTzow==
X-Received: by 2002:a05:6402:510c:b0:615:6482:7498 with SMTP id 4fb4d7f45d1cf-61867833a2amr422488a12.31.1755018592633;
        Tue, 12 Aug 2025 10:09:52 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911451csm20060302a12.60.2025.08.12.10.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:09:51 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Tue, 12 Aug 2025 19:04:11 +0200
Subject: [PATCH 2/3] iio: adc: ltc2497: add support for LTC2495
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-ltc2495-v1-2-7bf4c6feec2e@gmail.com>
References: <20250812-ltc2495-v1-0-7bf4c6feec2e@gmail.com>
In-Reply-To: <20250812-ltc2495-v1-0-7bf4c6feec2e@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755018589; l=3693;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=IqcVlKobCq588xENs4uppJQybncqhnqWvF/okPMFi9Q=;
 b=KIX6i3ugIuT8joLUld2oEZkkMM9KrjCJWhezNctQLLeR2KHki4TtxAOef/tBch6Cu+9utw+mh
 NFiarAIBkNQAeknK+jXobaGm3qXIBGlbnKv5+nHmTWv8YDPSKbEYgJY
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

This updates the LTC2497 driver to also support the LTC2495.

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
 drivers/iio/adc/ltc2497-core.c | 20 +++++++++-----------
 drivers/iio/adc/ltc2497.c      |  7 +++++++
 drivers/iio/adc/ltc2497.h      |  4 +---
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 2dc5c704426949a4ec62c42591d6c2c40ffb79cc..400f4fe5af30e8e16b75506726235f10f2a4237f 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -15,9 +15,12 @@
 
 #include "ltc2497.h"
 
-#define LTC2497_SGL			BIT(4)
-#define LTC2497_DIFF			0
-#define LTC2497_SIGN			BIT(3)
+#define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
+#define LTC2497_CONVERSION_TIME_MS	150ULL
+
+#define LTC2497_SGL	BIT(4)
+#define LTC2497_DIFF	0
+#define LTC2497_SIGN	BIT(3)
 
 static int ltc2497core_wait_conv(struct ltc2497core_driverdata *ddata)
 {
@@ -26,20 +29,15 @@ static int ltc2497core_wait_conv(struct ltc2497core_driverdata *ddata)
 	time_elapsed = ktime_ms_delta(ktime_get(), ddata->time_prev);
 
 	if (time_elapsed < LTC2497_CONVERSION_TIME_MS) {
-		/* delay if conversion time not passed
-		 * since last read or write
-		 */
-		if (msleep_interruptible(
-		    LTC2497_CONVERSION_TIME_MS - time_elapsed))
+		/* delay if conversion time not passed since last read or write */
+		if (msleep_interruptible(LTC2497_CONVERSION_TIME_MS - time_elapsed))
 			return -ERESTARTSYS;
 
 		return 0;
 	}
 
 	if (time_elapsed - LTC2497_CONVERSION_TIME_MS <= 0) {
-		/* We're in automatic mode -
-		 * so the last reading is still not outdated
-		 */
+		/* We're in automatic mode - so the last reading is still not outdated */
 		return 0;
 	}
 
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index eb9d521e86e54def0493ea0e81f63b37900c56a5..8f4665547b5b0d32084599f8557c40102c37a4ce 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -19,6 +19,7 @@
 #include "ltc2497.h"
 
 enum ltc2497_chip_type {
+	TYPE_LTC2495,
 	TYPE_LTC2497,
 	TYPE_LTC2499,
 };
@@ -131,6 +132,10 @@ static void ltc2497_remove(struct i2c_client *client)
 }
 
 static const struct ltc2497_chip_info ltc2497_info[] = {
+	[TYPE_LTC2495] = {
+		.resolution = 16,
+		.name = "ltc2495",
+	},
 	[TYPE_LTC2497] = {
 		.resolution = 16,
 		.name = NULL,
@@ -142,6 +147,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 };
 
 static const struct i2c_device_id ltc2497_id[] = {
+	{ "ltc2495", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2495] },
 	{ "ltc2497", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
 	{ "ltc2499", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2499] },
 	{ }
@@ -149,6 +155,7 @@ static const struct i2c_device_id ltc2497_id[] = {
 MODULE_DEVICE_TABLE(i2c, ltc2497_id);
 
 static const struct of_device_id ltc2497_of_match[] = {
+	{ .compatible = "lltc,ltc2495", .data = &ltc2497_info[TYPE_LTC2495] },
 	{ .compatible = "lltc,ltc2497", .data = &ltc2497_info[TYPE_LTC2497] },
 	{ .compatible = "lltc,ltc2499", .data = &ltc2497_info[TYPE_LTC2499] },
 	{ }
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 64e81c95a3dd05911b6717c09ac0560c9f47f304..f2139f260c3fe4e8772c6db9c46331de775dcd5c 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -1,8 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
-#define LTC2497_ENABLE			0xA0
-#define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
-#define LTC2497_CONVERSION_TIME_MS	150ULL
+#define LTC2497_ENABLE	0xA0
 
 struct ltc2497_chip_info {
 	u32 resolution;

-- 
2.43.0


