Return-Path: <linux-iio+bounces-24074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B9B561F2
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7254F16573B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA52F6183;
	Sat, 13 Sep 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="kZcA4Jm8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE552F49EA;
	Sat, 13 Sep 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778019; cv=none; b=gSADSWfZq/uB39dR+6wDYPDgMO/KhNzJ8IwLlFTxa/jQQIyqj3J1E2I2cnmO1pqxnu5qgGUK3BZ8zegQJeJfWqDNZgvfBx6KSRwnrTqH4v4YrAvfjuoJexvbkm273h2ZtCf7pV2PDop02F6kCnRoU8FTWMGkNuiLMxmaHgo9gPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778019; c=relaxed/simple;
	bh=P1ByNktlzb54OkAYWKnM+yrvmPUsH4ig/ZXROc/N450=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CX2OHmDnF6R0skHmK/l9YmUGB+pqu+mAazLzkrsNg7XA530tZJ9kgoKugbXxJ2OKrpz+RMLWZtjFteJJLyXWZVfE6y/zLb/gWFCmRdyU4iv1Ubi2zZLDj8VFpnYcEYq7oLHWgq6PgsNhXtahaWSaNyRbJdlvY5qGo7rbB4QuPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=kZcA4Jm8; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 74DD2173BF6;
	Sat, 13 Sep 2025 18:40:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47m/qPFJBR+lEXOa3oWH8mAKCAHufuCZWnCFTKXj2tY=;
	b=kZcA4Jm8OU1UtmOJl6bfadVorD0glycGVk9D4HEKFtK7+UhCeKUeeNZ/U+U7xul3Xy8z62
	0SItrcSD+htBCDCNic1uOu+3rsqbCMKwRavBTeksv4nbYHRjJ0CHevl6op1Iv/C7fZOTbV
	5IuTSxC418BKRakMcH6gjqa8KiRY7/TkXmN9mQ+n4Osk1u5wVA5nZCXSouqmtl8wyIn3I9
	MuVGf1HT1/6QvYfx4WukzQWNC1sX8kfGujzdU4zvDil6Blqvj9bAMNHuNf+JXt89lFkQU5
	VpTxzKHOvwYQL6fSbtJJrnUz50RGCqjd4NbYRavKm/H0TtIzdn26BWnJupQ0lA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:35 +0300
Subject: [PATCH v3 14/18] iio: accel: bma220: add i2c watchdog feature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-14-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=P1ByNktlzb54OkAYWKnM+yrvmPUsH4ig/ZXROc/N450=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBSd1nrYwVwGQ4EK7GcRQ7VDPRKfUPbr4QUs
 1R9AQDT6TeJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUgAKCRDPJpmZhE5/
 ME9ND/9KgcNxAF3coHUrGrQEO27j4vPYfMfZuik7Fz6pJotxYEeuy5Z0UgBI6L8EOGTAskjje1W
 Q3Vpl1EbbhEIFIFkkg8UEIxYUW0HfuOfh0rk08BqHUgCI3YSBHpb8yol+uSUWZ1Or2YsgsgFeuX
 yRYHaqlBYZLUFSjoSfLpfxrmtJ+ra7Q6Dj0ZajQuruaHrHWRJ4t2ZyKb3IaU2HopLS5Dhpu1/ht
 ZgoMwrWKvidtl78+s63BHBexHOUEuXx5tNwRH43fQ/a+kIP2aP+y5o5dKR5GrNJK4uSFg8YjcJ/
 RKMM01iFnpyqAq1apnOv1KQo5dhzK2ZF7CLSq/SHnGbfTDy18cM0RYFOXNJsmf4P7xm16/9RtLJ
 /sWK6UcZDho37CbID/fc+IuZA2rh8/OmmZkHgaSvemr479aYV0s0XYzq6q4TSDv8RY7zps8UfM6
 KzIPmM06CgDKf1aiT8Z5fMRtb7ysRHzbjMqMb4iJQ8lMnTAdTGd8Ilh2KpvQTa6ffN2NbpmAM2V
 eHlSt1FDMh98iAvEH7sNKhKrCvbNpyBLurR7p4uF7dc8PTk50NIkJhYXU9gYwNAbbP1FuAAULgO
 0ZZYLO7FyiOy2J8y98KfEoCby9cUIkAkA/Wdo5zIi1Fw2b1R2Mo9kx+1/3W425t5GOPfIesCwwg
 Xgc4OYF+8W162Og==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Sometimes the sensor gets stuck and enters a condition in which it pulls
SDA low, thus making the entire i2c bus unusable.
This problem is mitigated by activating a 1ms watchdog implemented in
the sensor.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2
- hardcode 1ms timer watchdog to any i2c-based sensor instead of
  configuring a dt-based property
- rename bma220_wdt() to bma220_set_wdt()
v2->v3 no change
---
 drivers/iio/accel/bma220_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 5eef47151501119ab792aab6a511938a16c1ade1..425a8b981e141aa496351f29df0597c989aa4a0a 100644
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
@@ -358,6 +359,12 @@ static int bma220_power(struct bma220_data *data, bool up)
 	return -EBUSY;
 }
 
+static int bma220_set_wdt(struct bma220_data *data, const u8 val)
+{
+	return regmap_update_bits(data->regmap, BMA220_REG_WDT, BMA220_WDT_MASK,
+				  FIELD_PREP(BMA220_WDT_MASK, val));
+}
+
 static int bma220_init(struct bma220_data *data)
 {
 	int ret;
@@ -388,6 +395,13 @@ static int bma220_init(struct bma220_data *data)
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


