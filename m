Return-Path: <linux-iio+bounces-19901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E0AC3528
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBB717388D
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE161F4CBD;
	Sun, 25 May 2025 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIbWO3iZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BEAC2FA;
	Sun, 25 May 2025 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748183153; cv=none; b=LgWh0+nklfMdTXi//KrA898Fpv6E/5wbe5GvOmXdPltsFFQgEMnTlIP1f9+7jxqyA8IyXGexM85hLQQLHsxlboJuP57Lg0phjB2DpoYVRli2cUzxWosvIvpfiIIHlsdhW75TRcyINRgqkauiRH4r3ihw85uH5Z6d2LW9DM84cZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748183153; c=relaxed/simple;
	bh=v0ScHWT8kD+5Vyv8yaaBUBqSGa/0f0yEZwqlZx1YeuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpD8hpZx5AhvwSexDEerSkwGhQ6CH0MTFyuBUYycMoHhqqRAyyhrJqFkI03B87fsCfKSZL5qaIcJPXZa9Y53GKOTcqX7D58rbQl/9+ey89pht/wJ38pKz+7LDaaKV0BwKX+Jekwh0YAdDH9TjiCOxuRfPyTnYV4WHb0Hywo673U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIbWO3iZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf848528aso15589555e9.2;
        Sun, 25 May 2025 07:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748183150; x=1748787950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx9R95kDmSrYu/nHqrKcq25Bn21rCCoLuMXJXn2I0WA=;
        b=XIbWO3iZ2s+RnnbyYoq9emwdt3bg4cHfmvxCUfb+dwf+MzYJtfxtkWGdZTyfnAYckF
         tX49tpXk6eZ0f1eZyhV8qlZqOYDhVK+rzmWUpS5TMnHO4AEb9XBfEzGSIoQUfZqKBZcB
         ZmlmGpmpEhSfbgf8rfjz0Z4Ru7YX8UquZK0prVH5z6nKHsQKUd2AiItPx8Vl3Dc5roi8
         mdrX/FdZCtXIlGcOlQHet7Pp7JgNGl2labsjTl3s2oASZRA5Vnys7qIdg9MkSM5RkjnP
         Oe7+AWy8SWCjb0imQZ97jJJem/krSnVeh4L5PVZsKIF/OpGW6m+3z629w89OvWOFVUO0
         hTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748183150; x=1748787950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yx9R95kDmSrYu/nHqrKcq25Bn21rCCoLuMXJXn2I0WA=;
        b=QVU3pBynewyn1mEcuyb8Dptr7SP4DqL9MM1Cv+781Nl2AbYdW0qGNrQ2pvYKqEt3Cu
         QqFGhllH6KtONx3AzOcxe5dAbiXGGfDpsPgFx8bPs3ClcHw4fdz2tIlqbN9Qba4ct9Fp
         BXMmgGlHd/sLsCHo/2PHk02HShJfrYAA3mku295k4UZo56cBphQ8Bl5z3Nzb5/sJ9SL6
         lfJuW3IxUV6WZTubUhX1QZ+1LW6QuMVYvnMWbO+kBBM6Pf4a5mP0LBnqYWjmA92KNpzv
         3hl/0bIR0G1ujQKJRTmsUuJFOEdJRg/MSGuxSh2fx1zDIEuEIFxoXcFYM+jfjxMKZw+N
         yMWg==
X-Forwarded-Encrypted: i=1; AJvYcCVWhmZ5LmehYxUyGHVVRHSN1+KwrhhAEJ1lv+s9hWoknztkOqSdvSgv6r5tI40To8FRg1ugvkQYdJs=@vger.kernel.org, AJvYcCWIEnybmfpCHgDJIvgJQnJmNoVDm4oZA0tIDBd8v6h9H2DW21fCJOs5rE9WJyV1ulaG8UbqSr20/BnDSva9@vger.kernel.org
X-Gm-Message-State: AOJu0YzzY1A/gpcAXrnU3Kwp9prNg+8gdZzVK5+VquiWNUzWFwzvxAXy
	btQyvFf8ZKaw5y0CfMAMDSfRx0YiAdtHNaDMTZONONWLFMsnCe9dZeWL
X-Gm-Gg: ASbGncv9w67e8tu8/bUhCA8mbLuH0tBYEzyS8y1RnPmLOvxhexlhG64mH9Kzj2x/MM/
	E6d8pZhYGYfl5QsB+1ocENO5hbmraGfmyNk+DVEkFGsMVrWbCE35sV+p1Ow98GA45quGFlYPMyi
	IHnmkjw+Xd+V6cJnOjVp3jI5E3wnvodDkBvEa6pOS0PtnuXRRf39pHQD/S7Fwat0i00RNQGgMST
	EOkXTfdX7LO1lPdNGAQJSB7TGz8yqr32GSVrZrpnBsTiba6rooEYj5g8mWuO2m5jzLyg2heiW8R
	mAQ2j2HWgPP7i9CI8sFocnDijaG5HKmyFNeX6pH5eWXgSmf4c/ECx+Z8v5Zmp9BwtNLr+LVGWUm
	U+r+rjg==
X-Google-Smtp-Source: AGHT+IFCuPLHO8q1MPXOI6zJif3PbJxzDkaHPeRKQ5dauAolLwT7If0m1vxsBoBQTzyQANztgTtyGA==
X-Received: by 2002:a05:600c:a13:b0:440:6852:5b31 with SMTP id 5b1f17b1804b1-44c91dd151amr64206065e9.10.1748183149506;
        Sun, 25 May 2025 07:25:49 -0700 (PDT)
Received: from localhost.localdomain ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb8c92d9sm216428135e9.2.2025.05.25.07.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 07:25:49 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	Justin Weiss <justin@justinweiss.com>
Subject: [PATCH v2 1/2] iio: bmi270: suspend and resume triggering on relevant pm operations
Date: Sun, 25 May 2025 16:25:29 +0200
Message-ID: <20250525142530.71955-2-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250525142530.71955-1-benato.denis96@gmail.com>
References: <20250525142530.71955-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent triggers from stop working after the device has entered sleep:
use iio_device_suspend_triggering and iio_device_resume_triggering helpers.

Closes: https://lore.kernel.org/all/31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Tested-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/bmi270.h      |  2 ++
 drivers/iio/imu/bmi270/bmi270_core.c | 20 ++++++++++++++++++++
 drivers/iio/imu/bmi270/bmi270_i2c.c  |  2 ++
 drivers/iio/imu/bmi270/bmi270_spi.c  |  2 ++
 4 files changed, 26 insertions(+)

diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
index d94525f6aee8..a6c4204032fc 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -20,4 +20,6 @@ struct device;
 int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 		      const struct bmi270_chip_info *chip_info);
 
+extern const struct dev_pm_ops bmi270_core_pm_ops;
+
 #endif  /* BMI270_H_ */
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 2e4469f30d53..b54658f972ad 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -982,6 +982,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->available_scan_masks = bmi270_avail_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi270_info;
+	dev_set_drvdata(data->dev, indio_dev);
 
 	ret = bmi270_trigger_probe(data, indio_dev);
 	if (ret)
@@ -997,6 +998,25 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 }
 EXPORT_SYMBOL_NS_GPL(bmi270_core_probe, "IIO_BMI270");
 
+static int bmi270_core_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	return iio_device_suspend_triggering(indio_dev);
+}
+
+static int bmi270_core_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	return iio_device_resume_triggering(indio_dev);
+}
+
+const struct dev_pm_ops bmi270_core_pm_ops = {
+	RUNTIME_PM_OPS(bmi270_core_runtime_suspend, bmi270_core_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_NS_GPL(bmi270_core_pm_ops, "IIO_BMI270");
+
 MODULE_AUTHOR("Alex Lanzano");
 MODULE_DESCRIPTION("BMI270 driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index 44699ab58909..c77839b03a96 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -4,6 +4,7 @@
 #include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 
 #include "bmi270.h"
@@ -52,6 +53,7 @@ static const struct of_device_id bmi270_of_match[] = {
 static struct i2c_driver bmi270_i2c_driver = {
 	.driver = {
 		.name = "bmi270_i2c",
+		.pm = pm_ptr(&bmi270_core_pm_ops),
 		.acpi_match_table = bmi270_acpi_match,
 		.of_match_table = bmi270_of_match,
 	},
diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
index 88a77aba5e4f..19dd7734f9d0 100644
--- a/drivers/iio/imu/bmi270/bmi270_spi.c
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -3,6 +3,7 @@
 #include <linux/iio/iio.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
@@ -79,6 +80,7 @@ static const struct of_device_id bmi270_of_match[] = {
 static struct spi_driver bmi270_spi_driver = {
 	.driver = {
 		.name = "bmi270",
+		.pm = pm_ptr(&bmi270_core_pm_ops),
 		.of_match_table = bmi270_of_match,
 	},
 	.probe = bmi270_spi_probe,
-- 
2.49.0


