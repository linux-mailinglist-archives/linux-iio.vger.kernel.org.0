Return-Path: <linux-iio+bounces-23921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F99B51038
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 10:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BB0461339
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 08:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA1431077A;
	Wed, 10 Sep 2025 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="NL14pc/X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98C30F924;
	Wed, 10 Sep 2025 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491095; cv=none; b=Q7dOF7BsyAtRv8aQAgpoMAB/bmt768S0JK/ptD+2QfcPQyT6JE1VdbOmwHiERX32rx5MI0uIMkAh2Ho/k3z6tAYk9v4agZFgJed+OFfh+FCa1a12WM44LODpewGXoyBZ6cGlVFAq8yUt6MtTbxeEs3TmGenlN7Qwp1jzU/G2kOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491095; c=relaxed/simple;
	bh=GfiWXyX7LPifOUfYn9+ZkSeq0DR2UY+Z/0jCplTp0Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MA8EGtRP847JyYOFCmxCU3GvNJ9j6b5LBzJ7K/pR1oYjT012TyrLE8TRYt+pNFZQn09jLNVkO6z2KxraAnczFM5ggpNIZ1n80PWlvc0LMvq6Tv4hYuBvK2amQTtAJCfEhCzmu+EytSvQHt0AVviwMdQMYBspWBk2DOt7TrqDkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=NL14pc/X; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id B621C173BF2;
	Wed, 10 Sep 2025 10:58:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8p82y0f5BUKpqRAfpnZdMPA1+ijprn7JFqFj01MehI=;
	b=NL14pc/XUxhLQU+CpvyA7+EVpsKWGUcZabNboFPz9iOv1GeTCdrfs9YUbsOJ5YOGk8oLEa
	Qi/HXgsfRSXNnCwCEpkrl8HNmPvALUqvJ+c7fmhs4eHuBwUOHOLlz9fXaDCn93XYIQV15v
	LWYj7lnPb+C6G5qF4SGFS01nIiLflC2Pvpy1Cq2E+7EGRNjrO9OKqaczx+te+3eB5sDkl+
	6w44HM0i/vxxLh2YeffaxaUZ8VnaDFkqkayRPfaWgVFasnzNyFlbcqRjof+Nd3J+wM7Xol
	SjsajWxQ9AfRCViCQXGGEdv7j5SdtVSNq4olfjyoZsz2R2Z6P0nzXzxjGkBqrg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 10 Sep 2025 10:57:15 +0300
Subject: [PATCH v2 10/14] iio: accel: bma220: add i2c watchdog feature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-bma220_improvements-v2-10-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
In-Reply-To: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=GfiWXyX7LPifOUfYn9+ZkSeq0DR2UY+Z/0jCplTp0Pk=;
 b=kA0DAAgBzyaZmYROfzAByyZiAGjBL4egSduQZnS2wnOn7+U3gLWpmiYM7eN8AGlx82rY/aESi
 okCMwQAAQgAHRYhBNgKf8F2FRk17D5fqc8mmZmETn8wBQJowS+HAAoJEM8mmZmETn8wYF4QAIeE
 v0wJrqFF8kM9NdHaEmHKGr2jXK0LnmM+2yjJ8yREzHwNowPEdkT1wD49xv8K2S8qSzQ6rxqa2ua
 SpFK2/XPxhm5lY3z0A2yjfwoPe8oWTKXcEkyZf4rhiCro/RSIQ0be3g0IE3ksod+0FXphkD9V5u
 2sfKfQA8codPtRPYcsjsCJpeC54f1XVuzNqynoEuWS3C2Zc3SfTtdKusnwViVg8kUkuwyXkfg31
 xDyHOefNUPqkb9/vtd/U3cB1pwkep7LdPWxvQrk7a4b+IS/rpDgG7r39Ju07dZWjpbAAA9jaIJF
 ZJvoZO5/BPFRUIf8d/WhzXJ6LE3bgaY+AgWJJhSTVwwkt6nut+5CqpWfcNvn3OaIaa+YAWvwRCu
 UbD+Q7bITQGWN5apbjDuweply+wnrvYW7VCKJREk234rKL5nyKrp5e9gNHv8jbBM/tLolabYWn3
 Kxqal8RUW5dvkXNJHgF441uiA7V812rpRD95vY+NlmT3e47Tcvm1CJYWUDm6RUhjlve1IuJp7A6
 +RYKwthHzfgiKvbfYaYj988+SUWDOu3CeifPxZtSfPexvo4pTlOCGI8A8BHbZAbGUP5mfDQ7OmF
 zVrhYyzOOYZ919MvX32FR4SG8uM0LSsviIBRoOdQO9Tfzi0vESCJYNdnTr3q5hAGg28w/76K/I1
 z8dB+
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Sometimes the sensor gets stuck and enters a condition in which it pulls
SDA low, thus making the entire i2c bus unusable.
This problem is mitigated by activating a 1ms watchdog implemented in
the sensor.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
ChangeLog:
- hardcode 1ms timer watchdog to any i2c-based sensor instead of
  configuring a dt-based property
- rename bma220_wdt() to bma220_set_wdt()
---
 drivers/iio/accel/bma220_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 191074d8618ea2638f69283781b8677921876681..b619f5a0bf713b4d386a5d4fc1d919e144798f02 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -10,6 +10,7 @@
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -359,6 +360,11 @@ static int bma220_power(struct bma220_data *data, bool up)
 	return -EBUSY;
 }
 
+static int bma220_set_wdt(struct bma220_data *data, const u8 val)
+{
+	return regmap_update_bits(data->regmap, BMA220_REG_WDT, BMA220_WDT_MASK,
+				  FIELD_PREP(BMA220_WDT_MASK, val));
+}
 
 static int bma220_init(struct bma220_data *data)
 {
@@ -390,6 +396,13 @@ static int bma220_init(struct bma220_data *data)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to soft reset chip\n");
 
+	if (i2c_verify_client(dev)) {
+		ret = bma220_set_wdt(data, BMA220_WDT_1MS);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to set i2c watchdog\n");
+	}
+
 	return 0;
 }
 

-- 
2.49.1


