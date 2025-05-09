Return-Path: <linux-iio+bounces-19400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E5BAB1B77
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 19:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B914C336D
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48AD2397BF;
	Fri,  9 May 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c27bYTAD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7E20ADE6
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810942; cv=none; b=TC0RH8deXD5W/IPyr154T2+5aYXLk9jYU1Lj8cRJQMy3U4I47pbpwOrWy5pfz5Dl5MCiyjnxuW9jIQE9KNV8rN+dRDRADDBRZ8W85f9FCzwAmvjC1gz5L0I4DNGlN5crq7X2BfumMMmx5QkI1dJvLWBit17KjbRkDXO6hreTO0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810942; c=relaxed/simple;
	bh=w28ykw+6k/phLxv7FX6pgCNeMmcADcfDjNvlKjx48BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmLaf/Uej0WcanCUJBE7B0b9xyaIrZG70Zd0A3Rm1ealgYHtBFJriN1QWHY15do2NRC7KIIynRcp4IAIWQ6ua21ichCZSUblc1vw16zSdLGSzAb8aC08EkPttN6x58D8hnyOSLyG6GMXmvcyctpibn4lVHgK1MWmeb3GzTBNj44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c27bYTAD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a1d8c0966fso1132604f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746810939; x=1747415739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzSgLSsf4G+YF4NlzwpWGrJAkDYXgAgf1kCXd2Ju9kM=;
        b=c27bYTADiV2xOAfSAZUDshDqwCihljPLH/HJx3VSoaAihMdeHROvcILcixEg++3yqm
         Y9197SSfnnZtssy+r4NSUcCIfSsoldP4bsi6SkJw2IPLFVP+8sJgxGTEeuXXu38Q5A2S
         cn/3SQvA9XDpV1Ha/BY8nRRPNOvU9m6XzptkTJlb4Yh05Yocujlv0iwOQxOPhqWQAwNZ
         zQw+EntV88AKGU6YMub9tG4HhdFnIBWxSitTMjl0G/izjLiQbFqEbrZ6YdVsiqEtZQBf
         arMrc9q9l5AW6BJrw5gzTZee5Zxg+paWFHQ4Hx+0etffqqm9ThUeDFp5YT9vGJAPFZV4
         VqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810939; x=1747415739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzSgLSsf4G+YF4NlzwpWGrJAkDYXgAgf1kCXd2Ju9kM=;
        b=TZt9jZf6XXKWtqfTh5EJhqhwufV6wcDFJddeE3s+Z+jdC7pjOUI/uH9DClANesoMxG
         9srcUd6n4LPSU/yUcRQNZWIDx+mXpM0eTbLpLChS1gUyhdaC4KRbqZiihjYIJ54eFNHy
         lboYq5uL8d5aTjpcXxnvIQ+SYbNB3Zpl7yi+ehsHBHMdPsPL4u1qGpw3mAmf92z6MRwI
         Ba5zSvw6xSB+tJYXw9YuJiVkNoJZBvcRMkdeJ3DyPSS4qcf2NeEE11QMzFqBFa6f55Yp
         nRdZVA4UmD+UuPRrH6m/+r18+tKNA53ogXY800WICvAHAZXPoJU+PrbNc3RPe3WMkGmy
         tq1A==
X-Forwarded-Encrypted: i=1; AJvYcCUiO98DaJcSZGovd//d8xoyjz8hBDnVjQJlILcJmGlj0YJwjhTQTAfsehoS52VIJt8xETwav4ON020=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4RcxobNk+SVqVBu8/ITobJua3BCnViBC75vwXDGzQ/fZtl4Kl
	cIJP/omx4vqleceeneIBSPG20Uxxn0PkY1cO/IfQP4Fb4spPyGsv
X-Gm-Gg: ASbGncsfhxrFGdMv6TiyIHaOVM49AXlPDOzaNCEy42hCQriPdZFk11e/GF1lyTiq1jp
	Tsi+Ve7VDbrZI9Ks2hHjkp0g2PUp/s3Z9f1gNad4DGFBZuaYP+mY2MsxUX5YmXQ2vz9NDoaPFff
	9UPDoGJjHiy9sPSzOjvbP8l2fl+6b1m3mK95+UIOl3e9vSdY6qEduiVFkJeFDIo1tHhZQH7wg9e
	YspIRymJ1Bh5CfxnkJXubVNElLV0SscnhoLJFcUlTG2E3QyFAYnATy8GbwRJYO+8Csa9UVk9FmA
	BavRtdECKmY/ZN8bIJkcScNPdX/JN8o+2BXvUN15hdP9+WqIIorh+MFW0Ql9
X-Google-Smtp-Source: AGHT+IFR+XApa1AeJJbDQK1YJF+jIlZ0CGE7i7MlCaYUb06iHjtFgZGXEeoZrKDSpvriWWFM2Lpx2A==
X-Received: by 2002:a05:6000:4287:b0:3a0:b4a0:371b with SMTP id ffacd0b85a97d-3a0b99077b8mr7069996f8f.11.1746810938749;
        Fri, 09 May 2025 10:15:38 -0700 (PDT)
Received: from localhost.localdomain ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d77e4ec3sm21509835e9.1.2025.05.09.10.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:15:37 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>,
	Denis Benato <benato.denis96@gmail.com>,
	Justin Weiss <justin@justinweiss.com>
Subject: [PATCH 1/2] iio: bmi270: suspend and resume triggering on relevant pm operations
Date: Fri,  9 May 2025 19:15:25 +0200
Message-ID: <20250509171526.7842-2-benato.denis96@gmail.com>
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
Tested-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/bmi270.h      |  2 ++
 drivers/iio/imu/bmi270/bmi270_core.c | 21 +++++++++++++++++++++
 drivers/iio/imu/bmi270/bmi270_i2c.c  |  1 +
 drivers/iio/imu/bmi270/bmi270_spi.c  |  1 +
 4 files changed, 25 insertions(+)

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
index 2e4469f30d53..31fd1730a3d3 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -982,6 +982,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->available_scan_masks = bmi270_avail_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi270_info;
+	dev_set_drvdata(data->dev, indio_dev);
 
 	ret = bmi270_trigger_probe(data, indio_dev);
 	if (ret)
@@ -997,6 +998,26 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
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
+	RUNTIME_PM_OPS(bmi270_core_runtime_suspend,
+		       bmi270_core_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_NS_GPL(bmi270_core_pm_ops, "IIO_BMI270");
+
 MODULE_AUTHOR("Alex Lanzano");
 MODULE_DESCRIPTION("BMI270 driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index 44699ab58909..a6e357b97d31 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -52,6 +52,7 @@ static const struct of_device_id bmi270_of_match[] = {
 static struct i2c_driver bmi270_i2c_driver = {
 	.driver = {
 		.name = "bmi270_i2c",
+		.pm = pm_ptr(&bmi270_core_pm_ops),
 		.acpi_match_table = bmi270_acpi_match,
 		.of_match_table = bmi270_of_match,
 	},
diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
index 88a77aba5e4f..b25171413531 100644
--- a/drivers/iio/imu/bmi270/bmi270_spi.c
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -79,6 +79,7 @@ static const struct of_device_id bmi270_of_match[] = {
 static struct spi_driver bmi270_spi_driver = {
 	.driver = {
 		.name = "bmi270",
+		.pm = pm_ptr(&bmi270_core_pm_ops),
 		.of_match_table = bmi270_of_match,
 	},
 	.probe = bmi270_spi_probe,
-- 
2.49.0


