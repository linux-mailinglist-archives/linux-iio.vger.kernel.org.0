Return-Path: <linux-iio+bounces-19401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 521B6AB1B78
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 19:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D561BA70B7
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17196239E7A;
	Fri,  9 May 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9UvBTY7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2500E23958D
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810943; cv=none; b=TFWU9+solCHauZ8DHeBOvhiads2e59M6Q3odweKQpGKs6iSLduwN2ifJDAUymVT+NWZqkVcWuxHHamZS0T10mmz/nhgHBKIhg5hWCCwNsXdxZGCd+Es2y7XO5WIkOeTRM8kacdi3w/BFRXrSCBF2eVHiTUxdxBWaQ1piyVGixdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810943; c=relaxed/simple;
	bh=7MesCFuuCDIugA/QvkpY6/eommREk9sCCve39WoOmB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDiPgVxgxx0fc5EcsaeLatxfZzL5C4q3kw7vXU6/nhTEzjricsGTvHP8LT98Tfyaa8qoWbU7vwhp+hmmDjt26ytSEoKjzUIg8xI90HkJ8y8QMHCJ6NeTWPglf9gBsw/YLqweknUXt8uw25MtsPIwBSvdubryeXOo6oWcoSD4xuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9UvBTY7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso15561375e9.3
        for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746810940; x=1747415740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VE6naNkeBC4XbEQJsqMlL3UOV5cvMmOJpBltLHRjfRc=;
        b=H9UvBTY79wcEiWoBYsCpxfa3WkU199aGgyJZPWKBUn97wGLQh6/DpQPe63q574y67R
         F/+akG+5maYpb0PNQuyRUVyg7iDQ9LimVj/Z8W6wNrPYMcgN7N+YnAuicLGBbIrQhqMM
         VM/DCcj92FOjMavE/2HtoRNURvpZmmC8rmam8U3XP4SLVxmrl9FyrvId02gp8ZnMcHC1
         vicgdRx0Tr331M0CJOucTU/i9WUoR6D6l2QqL2LfOzfReLxsXAmOTYWK9n6CJVchoebj
         uZFcCJJ8nftBUuCbQRuM3oL8C9Uvpj93AfTS+Gp6OWg/aIQebkL1zpszDaeiXRJWeYFG
         EAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810940; x=1747415740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VE6naNkeBC4XbEQJsqMlL3UOV5cvMmOJpBltLHRjfRc=;
        b=uS5PwiHrCKQvqbh4OoR/iw6Atbww3ox9QzvT5uOy76LebTg6rnKCg1dSApM1gYYiz6
         FVnD1wOT4Y7QKCq0bC0IJDBewPAO/CdFVNeRVn+I1yyVK6gdogYAERDGhaT07mQBI33B
         rKiY6ioSzUOkxzaBmWZhiB1o4gbamTWYjuncBJWGKN2WqKoJ+XUOFvuB2k120waR7eHV
         CYWbIRZn0T+k9C6UQSE9on2ohs1mQpmioSIZS8n7QYlcdZ4sGz3K+/RefCT8ksV2x9V9
         CDjnGsrclopzXybH3YBIYoWwhc6+CxeBVbVHuO5VtJbW+V+g3vFlevYZshdSng33Jr+2
         1Cyg==
X-Forwarded-Encrypted: i=1; AJvYcCWKUip8F6Ic4eHJQ8QXImYQH3F7CIn5LkYfUalZqLXrpyyY9fiL9FV9JaSvSocSvs/twavGf+Mt/wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvtVJfv/IkAtbZG1VUd/wAC/dOLsBiKr1oStQe0xNPAwXwvUjN
	BQeLSkcDYzvrIOdPVwnyAJk1YeGzX3NEAuPIVmQcn3vVOJ4nAwaG
X-Gm-Gg: ASbGncsjxolI/FNth1bEYU/huTMAOkNF1uCLlR9p1MQb0qUWfjaZR/NPkC4Ijv1UsKs
	wVDS5MgjsU5HIsG0LQfBdPKKCpxZpFa3RQX21uTNlmOSfhpWppwUXlwRA+ZrY5FXUS3zCd4LNyP
	H8BQdUp5WxZUm0R6oAJydFjlai6KRfECju055NMrwbk7I0QcMa0EkVyhyxd4hcInH3YRltsgcxk
	UlWXpHFPH787YgOnsGo9mCSBKxHQnk9DndlWyhcdBYXbuh14CccR0E2WzLsOekFWaRhd+CIqt1U
	YSdOpwyGMaIYmZl+YNnGnj0AG3pjX3OA0TfwrylJ9k1t3wxq0BGB1fn7D3YM
X-Google-Smtp-Source: AGHT+IHMeNWUjkqZsVEnJmQ62DVw/kyH7XooK7AYQ0UdS4XELihqc3wLuJMzQpzwL0142INNrnVWNQ==
X-Received: by 2002:a05:600c:154b:b0:441:ac58:ead5 with SMTP id 5b1f17b1804b1-442d6ddd0afmr45041095e9.31.1746810940128;
        Fri, 09 May 2025 10:15:40 -0700 (PDT)
Received: from localhost.localdomain ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d77e4ec3sm21509835e9.1.2025.05.09.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:15:39 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH 2/2] iio: bmi160: suspend and resume triggering on relevant pm operations
Date: Fri,  9 May 2025 19:15:26 +0200
Message-ID: <20250509171526.7842-3-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509171526.7842-1-benato.denis96@gmail.com>
References: <20250509171526.7842-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent triggers from stop working after the device has entered sleep:
use iio_device_suspend_triggering and iio_device_resume_triggering helpers.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
 drivers/iio/imu/bmi160/bmi160.h      |  2 ++
 drivers/iio/imu/bmi160/bmi160_core.c | 20 ++++++++++++++++++++
 drivers/iio/imu/bmi160/bmi160_i2c.c  |  1 +
 drivers/iio/imu/bmi160/bmi160_spi.c  |  1 +
 4 files changed, 24 insertions(+)

diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
index 32c2ea2d7112..ffbe8205e703 100644
--- a/drivers/iio/imu/bmi160/bmi160.h
+++ b/drivers/iio/imu/bmi160/bmi160.h
@@ -28,4 +28,6 @@ int bmi160_enable_irq(struct regmap *regmap, bool enable);
 
 int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type);
 
+extern const struct dev_pm_ops bmi160_core_pm_ops;
+
 #endif  /* BMI160_H_ */
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 0423ef6f9571..6233155f1112 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -890,6 +890,26 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 }
 EXPORT_SYMBOL_NS_GPL(bmi160_core_probe, "IIO_BMI160");
 
+static int bmi160_core_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	return iio_device_suspend_triggering(indio_dev);
+}
+
+static int bmi160_core_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	return iio_device_resume_triggering(indio_dev);
+}
+
+const struct dev_pm_ops bmi160_core_pm_ops = {
+	RUNTIME_PM_OPS(bmi160_core_runtime_suspend,
+		       bmi160_core_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_NS_GPL(bmi160_core_pm_ops, "IIO_BMI160");
+
 MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
 MODULE_DESCRIPTION("Bosch BMI160 driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 9fa3a19a8977..732191c799dd 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -69,6 +69,7 @@ MODULE_DEVICE_TABLE(of, bmi160_of_match);
 static struct i2c_driver bmi160_i2c_driver = {
 	.driver = {
 		.name			= "bmi160_i2c",
+		.pm			= pm_ptr(&bmi160_core_pm_ops),
 		.acpi_match_table	= bmi160_acpi_match,
 		.of_match_table		= bmi160_of_match,
 	},
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index ebb586904215..8addcf5891ae 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -61,6 +61,7 @@ static struct spi_driver bmi160_spi_driver = {
 		.acpi_match_table	= bmi160_acpi_match,
 		.of_match_table		= bmi160_of_match,
 		.name			= "bmi160_spi",
+		.pm			= pm_ptr(&bmi160_core_pm_ops),
 	},
 };
 module_spi_driver(bmi160_spi_driver);
-- 
2.49.0


