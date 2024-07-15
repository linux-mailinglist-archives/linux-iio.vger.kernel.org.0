Return-Path: <linux-iio+bounces-7626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD04931A51
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 20:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBDE1F22061
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B5973440;
	Mon, 15 Jul 2024 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="wddb+px4"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CA17BA4
	for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2024 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068312; cv=none; b=DuXnXqh+iE8zHtCI2p9N5IhDHefh4aUbRcGVGbw2M92np438idZY6TLYN4hCWKEu195KL1iwy8eLn/eFAwYC8k8slq9zFqEpE7F4cjYXm7Q0fF+is+ltdq7SheFgbYtcoCA/8eNkZMuRi9e0/rvAa+q5GBpgjjZmXiCA5QgKDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068312; c=relaxed/simple;
	bh=KXSHF2+C99GV1LdJQzfUE+zfRxbd65PoAoxwEGL2y+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Izrt047876O2qWZgW49c2KyQqlglmcitguK9/YaGQxjBRi4gEXR2RnFjQe5gaRt5OAWD4Jl4c42N+h8bT51jLOTTsGXItJ26YEwoDsuTnCEueuvB2DQygW57q72zGZklXxu8BQ1Zsf7mDyGfnpZr+PQC1YT8hR3utohA1WzhVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=wddb+px4; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3766488855;
	Mon, 15 Jul 2024 20:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721068309;
	bh=WXPc9M16AAbmrKOwgxAeooHEdh/Erv71yPITv8D14lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wddb+px4xEux5+L2FzbtRZFv9+ZnhF+4+D7ZFvnkFeuMFvxT3DXZHEUKnKTa8KSI0
	 njhqNSZIO5vPlz53CR1r4XPkCNWMHCBdBUSFCilv654gI6Gc7f5Pxp8Q4qPRd+nTP8
	 xXCrQJilJyIdikb3uQGEQUqcm5+/deJ8dux4QamjbUHJBpcF9bFILRwGogibgfenRL
	 2RjcDATIgKf0sgaLCoC5wKM77/iGLI2qmQi93vDob2g0BaVoP5EbqaDR8yBTItJ+Y9
	 klzq7agqLsepT7Wn7C9D/UPDu3pWJ/9DwnWgvs/2u+JN2QOvaBUq7Lqs/YK2PqGmkr
	 2z8Rv7nZfZeGw==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] iio: light: noa1305: Use static table lookup of scale values
Date: Mon, 15 Jul 2024 20:28:57 +0200
Message-ID: <20240715183120.143417-3-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715183120.143417-1-marex@denx.de>
References: <20240715183120.143417-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Move scale values into a static table, perform look up of those
scale values in noa1305_scale() simply by using the integration
time register content as an index, because the integration time
register content directly maps to the table values.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/light/noa1305.c | 51 +++++++++++--------------------------
 1 file changed, 15 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index a7e4c68bea09e..202a5c1bbf798 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -29,6 +29,7 @@
 #define   NOA1305_INTEGR_TIME_25MS	0x05
 #define   NOA1305_INTEGR_TIME_12_5MS	0x06
 #define   NOA1305_INTEGR_TIME_6_25MS	0x07
+#define   NOA1305_INTEGR_TIME_MASK	0x07
 #define NOA1305_REG_INT_SELECT		0x3
 #define   NOA1305_INT_SEL_ACTIVE_HIGH	0x01
 #define   NOA1305_INT_SEL_ACTIVE_LOW	0x02
@@ -43,6 +44,17 @@
 #define NOA1305_DEVICE_ID	0x0519
 #define NOA1305_DRIVER_NAME	"noa1305"
 
+static int noa1305_scale_available[] = {
+	100, 8 * 77,		/* 800 ms */
+	100, 4 * 77,		/* 400 ms */
+	100, 2 * 77,		/* 200 ms */
+	100, 1 * 77,		/* 100 ms */
+	1000, 5 * 77,		/* 50 ms */
+	10000, 25 * 77,		/* 25 ms */
+	100000, 125 * 77,	/* 12.5 ms */
+	1000000, 625 * 77,	/* 6.25 ms */
+};
+
 struct noa1305_priv {
 	struct i2c_client *client;
 	struct regmap *regmap;
@@ -78,42 +90,9 @@ static int noa1305_scale(struct noa1305_priv *priv, int *val, int *val2)
 	 * Integration Constant = 7.7
 	 * Integration Time in Seconds
 	 */
-	switch (data) {
-	case NOA1305_INTEGR_TIME_800MS:
-		*val = 100;
-		*val2 = 77 * 8;
-		break;
-	case NOA1305_INTEGR_TIME_400MS:
-		*val = 100;
-		*val2 = 77 * 4;
-		break;
-	case NOA1305_INTEGR_TIME_200MS:
-		*val = 100;
-		*val2 = 77 * 2;
-		break;
-	case NOA1305_INTEGR_TIME_100MS:
-		*val = 100;
-		*val2 = 77;
-		break;
-	case NOA1305_INTEGR_TIME_50MS:
-		*val = 1000;
-		*val2 = 77 * 5;
-		break;
-	case NOA1305_INTEGR_TIME_25MS:
-		*val = 10000;
-		*val2 = 77 * 25;
-		break;
-	case NOA1305_INTEGR_TIME_12_5MS:
-		*val = 100000;
-		*val2 = 77 * 125;
-		break;
-	case NOA1305_INTEGR_TIME_6_25MS:
-		*val = 1000000;
-		*val2 = 77 * 625;
-		break;
-	default:
-		return -EINVAL;
-	}
+	data &= NOA1305_INTEGR_TIME_MASK;
+	*val = noa1305_scale_available[2 * data + 0];
+	*val2 = noa1305_scale_available[2 * data + 1];
 
 	return IIO_VAL_FRACTIONAL;
 }
-- 
2.43.0


