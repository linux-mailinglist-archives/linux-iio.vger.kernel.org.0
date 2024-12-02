Return-Path: <linux-iio+bounces-12970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C529E0BFC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 20:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D2E282DE1
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49981DE8A3;
	Mon,  2 Dec 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUHBn+EM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20BD1DE4DB;
	Mon,  2 Dec 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167429; cv=none; b=tfJx8Fjii7vmP4rAzJ+fg7fHD9mSwg00rGdJspa6j9oEHxbwQ9MNqKoNqf8gvQUeyFRhiHQerD8jyb/NQ8yDLh6lNQXp/FPkKJ+VbmGsOtEQ9RQHtbskO+Qv0WGs0qlgA0Viqr5YJlrN4QLGc1MXrHrXbJFBFS5ep5zvzO6V+fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167429; c=relaxed/simple;
	bh=LGpOYwn/A6DItljnyHwEHtZ8L2kk+buAoFuZMTNJ7+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P25KLxX9ucxzfhrfUuTw5/njaLBn1sF4D5ehUuO6PFMdT3+kbeQsBBkOnekjCjRvWXAO5VyQyfySS9ojwwlqAM5YTRSjxqLVFS5ImK5mHVELZMNxHNTolsKoZ7S3D5C2Dokd8c+UAcuZ4bNwTZYZ1DrMOWmCK+8iRIRWTZga7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUHBn+EM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385eed29d17so1108670f8f.0;
        Mon, 02 Dec 2024 11:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733167426; x=1733772226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQmnrJMqai/D1JfzNaB/OfDbbM4m/TnF3WL4Zhy+n3U=;
        b=fUHBn+EMAsH5PtEornSzicO4jGEaWQH4KYRBWm1L86ALhyoiHuLtqqPzRKanumPRxt
         wmm1QecS5yyO2IG36UqxoPZKwqyxNDdd02DZTppiuhJtwDvtTFjQ8QZm3LhzPHt1lMPQ
         0hpI67FI3juZo3n0u08G9N3Pi4cP97+87/nEaH+scSpaH52WYV4V0kbUoIOhaXXqExRe
         TaLoKTrFU2+uD4bWb5SCrm2UGYoJS0gc9Jrd6vuEhl5HHQmaDaUQPmqSD81QdaGSI2I7
         FjxoK1f7j6rBwHY7fH0TIGQulrRXRFxHbgVrYzb4QHtUMVpDn6zmAM/T/Z+EzvjFRRuu
         R4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167426; x=1733772226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQmnrJMqai/D1JfzNaB/OfDbbM4m/TnF3WL4Zhy+n3U=;
        b=ntCeRaxVR1709sS61it5IEvdNDk93UOwpU4JMJhRRZu/I8j56w1jqfg2iwoexmZULt
         oTHA9PdBCcV2Bxqji9BmktTxcHbVH8wM8j2uEwg7U1yyeSXU3Chva7/sQq26fZu6kN/b
         2Eq47nIo7i9t4fpC+qsYB8q4gBf71LByvNzGn764qzvaR0xWQfHm7hXOFwtZ7bDBpeMP
         xim9yG1noZKUwPDPIpRYphgXlNRQ0cm71x65rf+n8EvIHglCMQmBncrbDopD+Ze8naQj
         Ud8CeH+UiYRkqg+HbJ3JvgjJitZVZpCnI/0pEjjgMwnBR1nvQ5rmQEM3Cq0mK9UP4et8
         J4PA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4Q01uTEEzXmMdkVRrFs3dv6wBPnLB6wDZPzrquMfsnUH5QvnIb8V5ufbGAZqUZL780rXCJZB9p2k@vger.kernel.org, AJvYcCXH+pTwG8chd1cEqLL6N5pin9lcpaMA+mpEfrP0LCCAI96Dub4PBJe+qYaJj3KlfzWAEMX7rDk0EN95@vger.kernel.org, AJvYcCXQJZchUHst9zrWasfowScjZukQ13y7RMdZx4uNAxEPZfDkJEQfQniXjrGFWbbO0Dgf9nyQFJrDT3BkAU9F@vger.kernel.org
X-Gm-Message-State: AOJu0YxBaUZ/JLKdqyDKoqKfmpUlSQYYrU3NqzD7rSQMkTirSJZW6gp6
	kCy8ngFbiPyvjX/FGJj6Nsnw5U8u4+m2RHeZhm/4AM/5r54nn8Wk
X-Gm-Gg: ASbGncvmag7e7cY6ZyOvF5oNR40S1DS/KFCg4etJUf+yV477egEEomzMY2mPN/ciRh7
	XIm0W3htCiB0kewL4fDgskBcjxWb36jzZv7JzSiafme/gEl5xnwbFcE79lCRjydX/Gb8rQSTz/u
	cR2l8JdNWTeFd/Ub4Q7cJzcDwj4dZ/PKX2l3jYsstA+WnYdIcFcohzeNQb2GaVi3WjMqCQJZDc0
	hAo42c0gVgvd/tgY1SsKrIqJUPmXcw6WiQhJjav/Zv9xgZpIb0j4omL7bAM8MI=
X-Google-Smtp-Source: AGHT+IG+Cj1JhF/m9hEu1dFvEehljL8+YQo8VLZ7DyQr5N+ReMpTQns9gyqtXESxtxLGjNbc/HWXNA==
X-Received: by 2002:a5d:64ee:0:b0:385:f677:859b with SMTP id ffacd0b85a97d-385f67789a8mr2801759f8f.10.1733167425952;
        Mon, 02 Dec 2024 11:23:45 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385faec0c9dsm832609f8f.20.2024.12.02.11.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:23:45 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] iio: chemical: bme680: add regulators
Date: Mon,  2 Dec 2024 20:23:40 +0100
Message-ID: <20241202192341.33187-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202192341.33187-1-vassilisamir@gmail.com>
References: <20241202192341.33187-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the regulators described in the dt-binding.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 9783953e64e0..bcf84c0a1a59 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -15,6 +15,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -111,6 +112,8 @@ enum bme680_scan {
 	BME680_GAS,
 };
 
+static const char *const bme680_supply_names[] = { "vdd", "vddio" };
+
 struct bme680_data {
 	struct regmap *regmap;
 	struct bme680_calib bme680;
@@ -1114,6 +1117,14 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	data->heater_dur = 150;  /* milliseconds */
 	data->preheat_curr_mA = 0;
 
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(bme680_supply_names),
+					     bme680_supply_names);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get and enable supplies.\n");
+
+	fsleep(BME680_STARTUP_TIME_US);
+
 	ret = regmap_write(regmap, BME680_REG_SOFT_RESET, BME680_CMD_SOFTRESET);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to reset chip\n");
-- 
2.43.0


