Return-Path: <linux-iio+bounces-21768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386B3B0AE04
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 06:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0836E7BA940
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 04:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471991FBEB6;
	Sat, 19 Jul 2025 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfJjV7vA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BED01E520B
	for <linux-iio@vger.kernel.org>; Sat, 19 Jul 2025 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752900014; cv=none; b=OB4eMX3bkxO1ZGk3S4PWIX6s5Ct3md+grTZiTDeoe3YtT02Ti5l2nvtYMAanRXjko9wsYWq0ioI5qB+IfgxJFV3eAAiGU3lipZDW6srFnOW2czuFt7hvKqRCX0yBlfI3HLs547NK3/D5f3+S2j7AizmwJ1278XmWA5+HZJEfzB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752900014; c=relaxed/simple;
	bh=JWQpy8X82m/JStzsP0rk6dzkdEcCfivwpHQuJwzmN5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnWEgv5l6Dpd+QjR6cZW1DYr41GrZz5o6SHBVed3WkFWDk5y4Uuu1WykS4pxQ6OoIjbqbdS8bO9oheEXLSSILB5xSs0/4crWZlzBTZnlwGIK3mfryjRpTYYnl3GoNH6dCeztPYxL4zio+bWS+GeEBtQmPznNMCfUOHhJGaF0dm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfJjV7vA; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-886c8de5d90so1390587241.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Jul 2025 21:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752900011; x=1753504811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ax75U152bwiZG3aw8FVC8Y3ue2q9AR8hk8SGP4CHnVI=;
        b=ZfJjV7vAvcgoTk03xSKexW5jjjP2R/OqLvyNXMTNWtvSIMBycfo2ksskQJWPKK+hID
         0SEH2vf7aiWQxAHcefLhrJY671WsbaA/+6nYUYpmuogMHLMAUSl3dzSY6j9TmLxufMsW
         rve8La6vigUmMwu2ZcB0C01p60JSNP9kFMJy+2h3Y3M8J0cLhSypvne3xb7dTMlJ4kyU
         WivZf8NMwEbYlKdSedUY/m0aRH6bTcmKMPYhCiuJfMWxyq1g9GfnN3P6+7hblPq6I98q
         GMNQ1Nqyj5c3M+hZg2EsXqhVHTXFqz1nc+Gt7rvFPX7YmCSYTETxn944CJpI1I37gKAh
         Z3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752900011; x=1753504811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ax75U152bwiZG3aw8FVC8Y3ue2q9AR8hk8SGP4CHnVI=;
        b=lbns3/0G4dRjHtF1ZHai8Dh4g/uVc35FtOuhdNbIY4ZmjP3zKwKOgBhNmL621PpX5/
         Awk7eS4cJl3qjn62HUwixsO8C+RlEfozSvGf0ZOOu2eSmtkYEoO1d4mzsBi8O6gCURAr
         xm9b2+iMBJvkLOf3tQxu8jP+wIUwc2/xJD6M5dlGaXykg1C/GewRA4u5taP+VMPNN3vl
         8lJK70Vxl5RMLSRLQDDWuL1BTqyGafuYse8kPBPfegJuwF5wMbcAs4Nj5EQE3h647YVW
         g0f00DXOmV4KG9RI0IxpFo/N/XxSU7TirecPxNoRKhgkTGS7oG1ggXvQqNCrlA6ZEWmY
         X93A==
X-Gm-Message-State: AOJu0YypJ/9wRFUz2JTnMZK3YuD/BhYMqk9GJow7h72zSPgZxzRw6Ier
	e5xeGl8VJzWBU4AKnp85J9QH9hy6LtQZ1EtAUZ8q1d41wzNhVOEn4nchfibgf94exik=
X-Gm-Gg: ASbGncumndV+ERMUOgduMg9XitYkmtaUgRSNwdM+yIOrz6DyPt9AekGfAa8IXWOjrjT
	vgCJ+VSFuJ0zEYpDicR7fJlMuNWkos1M0HaFN8BYldCGiyge9Ccz/NsFafYyeHNvHVk2rcKHOgc
	A4DxfM+B9e4WgXS6J9lu1+CEUTMd1deh0P4Wijsjb91Dk7GsTPf1E1KgoD5RJvKa7qyGcjRwyzP
	HS3eckZ0lXkO6P/14mcNyL4fiJQBj/pg+yEIAwLUR/WYWMnAP+me/v9l0HpYWxT5U5huETa9FlR
	e1n9wD07k2d0fHYjK4Yhl7ZZMp88oZwKQ45b87DJ+3tN9d4fmGB5kpcZIDirWSAnIRf5gd+r6Cj
	y0qbgcR7+omx9OAHIxxs0hBjpAdvdQRwnyNE=
X-Google-Smtp-Source: AGHT+IEamk4mSICtzhoGWd/ysJXUkrXUSeaxI8UgE5HnAD8dHt5lXoFvk1E9pWpTzqQl/TK9L6rICA==
X-Received: by 2002:a05:6102:290c:b0:4e6:a338:a421 with SMTP id ada2fe7eead31-4f955ad58c5mr6749920137.6.1752900006309;
        Fri, 18 Jul 2025 21:40:06 -0700 (PDT)
Received: from alkaleus ([168.0.235.31])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4f9ad0ec8a4sm1005623137.25.2025.07.18.21.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 21:40:05 -0700 (PDT)
From: Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>
Subject: [PATCH] backlight: lm3630a: Use scoped iterator to simplify error handling
Date: Sat, 19 Jul 2025 01:21:02 -0300
Message-ID: <20250719042641.134628-5-andreluizrodriguescastro@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This avoids the need to manually call fwnode_handle_put() in error paths.
Prevents potential memory leaks if future error paths forget the cleanup.

Signed-off-by: Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>
---
 drivers/video/backlight/lm3630a_bl.c | 121 +++++++++++++--------------
 1 file changed, 56 insertions(+), 65 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 37651c2b9393..35a13bd38133 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -16,29 +16,29 @@
 #include <linux/pwm.h>
 #include <linux/platform_data/lm3630a_bl.h>
 
-#define REG_CTRL	0x00
-#define REG_BOOST	0x02
-#define REG_CONFIG	0x01
-#define REG_BRT_A	0x03
-#define REG_BRT_B	0x04
-#define REG_I_A		0x05
-#define REG_I_B		0x06
-#define REG_INT_STATUS	0x09
-#define REG_INT_EN	0x0A
-#define REG_FAULT	0x0B
-#define REG_PWM_OUTLOW	0x12
-#define REG_PWM_OUTHIGH	0x13
-#define REG_FILTER_STRENGTH	0x50
-#define REG_MAX		0x50
-
-#define INT_DEBOUNCE_MSEC	10
-
-#define LM3630A_BANK_0		0
-#define LM3630A_BANK_1		1
-
-#define LM3630A_NUM_SINKS	2
-#define LM3630A_SINK_0		0
-#define LM3630A_SINK_1		1
+#define REG_CTRL 0x00
+#define REG_BOOST 0x02
+#define REG_CONFIG 0x01
+#define REG_BRT_A 0x03
+#define REG_BRT_B 0x04
+#define REG_I_A 0x05
+#define REG_I_B 0x06
+#define REG_INT_STATUS 0x09
+#define REG_INT_EN 0x0A
+#define REG_FAULT 0x0B
+#define REG_PWM_OUTLOW 0x12
+#define REG_PWM_OUTHIGH 0x13
+#define REG_FILTER_STRENGTH 0x50
+#define REG_MAX 0x50
+
+#define INT_DEBOUNCE_MSEC 10
+
+#define LM3630A_BANK_0 0
+#define LM3630A_BANK_1 1
+
+#define LM3630A_NUM_SINKS 2
+#define LM3630A_SINK_0 0
+#define LM3630A_SINK_1 1
 
 
@@ -479,12 +473,10 @@ static int lm3630a_parse_node(struct lm3630a_chip *pchip,
 			      struct lm3630a_platform_data *pdata)
 {
 	int ret = -ENODEV, seen_led_sources = 0;
-	struct fwnode_handle *node;
 
-	device_for_each_child_node(pchip->dev, node) {
+	device_for_each_child_node_scoped(pchip->dev, node) {
 		ret = lm3630a_parse_bank(pdata, node, &seen_led_sources);
 		if (ret) {
-			fwnode_handle_put(node);
 			return ret;
 		}
 	}




 MODULE_DEVICE_TABLE(i2c, lm3630a_id);
 
 static const struct of_device_id lm3630a_match_table[] = {
-	{ .compatible = "ti,lm3630a", },
-	{ },
+	{
+		.compatible = "ti,lm3630a",
+	},
+	{},
 };
 
 MODULE_DEVICE_TABLE(of, lm3630a_match_table);
-- 
2.50.1


