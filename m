Return-Path: <linux-iio+bounces-4657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FC98B6676
	for <lists+linux-iio@lfdr.de>; Tue, 30 Apr 2024 01:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0971C21E4D
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 23:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C29C19DF4A;
	Mon, 29 Apr 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OnHNl+55"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C4199E8B
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434038; cv=none; b=iPWSleWx6Buu5DsSc6kfzy3zd45M+MByuCo1qD+xPvFBh9FR8DaLCnRsNZ4lemV53yPxxPmiaxZbzdM4hbAYEMNo7RM/7JZdE5hKW3z2pqvDqM0eyBgh74jtmK6HgS1a1Bgf8EL8ndkILmLAimQURE6UGURupufSqtHLOWmoArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434038; c=relaxed/simple;
	bh=9vMzN7GknLhBK91OqN5FGd7OXYyaUfOO8wINrzGG+oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4GD+l3LV7WnWuETj8yPT/zveNU3XDLzN+hUsszHlJzZ2uD/4MrL/qpc8NViHvzqHgZVrfPzQKlytKMOs0qTe9kBOdLQK583XPwOVYsIcuRWxf8bm53865xtsb8CyVd616UpIa/lfNRSkG2syHS2xQwOTcoRn6ScYmK/D/Akszw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OnHNl+55; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea2375d8d0so4172198a34.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 16:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714434035; x=1715038835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0CekvxTmvga6LetnTaTS9D84AmKilMVxsoFH3MiYrM=;
        b=OnHNl+551AFCEQRJL0v+SJ/Cb6yUA3AiYq6YFTJTZjoP6d+jX1JTo1hyU0aAW5nwma
         2H3mw+CcMSleydbQaDDxBpnETPN/4rTisJScMOZU9k94IvbfnwzLUnFddOeJhdSPmicH
         2mxfu0hmXYiXsH88t2T9jI61BOvR6i55SufZnB1QrIB5FIxzdosDuffF161YjVOs8wUq
         hkVmMzl/zt/ysCwcHbv5YKlduevuPeYAiPaYvdKIWFhQIkoADAlgfmXi4aoMpD7KbXr8
         8IdMyoOCrpFCnIjfu0+1AG9ihEB9kADlPQ6O0NKcc6F9vR4da56XwKEx8tSBuFxGBPgO
         FHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434035; x=1715038835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0CekvxTmvga6LetnTaTS9D84AmKilMVxsoFH3MiYrM=;
        b=d6wYNXHZqzwSFyP4slCz18I5jULYqBcExAW0QRspiX5QUr7+9Au2Pp+w06hR62a69X
         /I8EPmpZL8zd1DkPsTkmPMsOoStylAEzD+c9W4k6ZLM0wU3B2mfBAYVVdoCeamT5v8yd
         ClAdFWfsmfHIra8fYkmImL3xk9r8cF6X6l7CVv8JtXShgd9J9dCkDV9LHFyePonEwOuI
         gwQJUi/gSGEVT3RfIz272Oy52dbyve1jQ7wvUrQme1cKFxKJp6m0Qw09C7279H+prk2i
         hFsnWUyuvv5U42L3KDlJeBuhYo9VVJmU1Bt2GrHTc8Qab/0mu9Lbp2+IV2WMe147X58N
         Samw==
X-Forwarded-Encrypted: i=1; AJvYcCXYljwkyEAV05CIXcwmrc3fuPjbpJsE7aY1eTZnfnJKejnKzMyj4u+x7MJ3Pljn9M5rdWPdtnd5mZo6Eo05ryE0+1rNP/zyFo7F
X-Gm-Message-State: AOJu0YyORSbgWyfBJNyEN5eQNC0p98GvgR+RngasSgyQCcEuP2b6JT1R
	B52JU+JYM9SJ9HZjiRFp5G18K0lA2fQKnGsAdiIik3Q4DPwQ0U9dhIyO0+N7NK8=
X-Google-Smtp-Source: AGHT+IG3ocOUnX8fvHwyLMD+MT8XyRnapUIMPk5vg9h/GD5BQU/zEJPB811dMM2382JKTXmv4mcYHA==
X-Received: by 2002:a05:6871:7aa:b0:23a:980f:1fb8 with SMTP id o42-20020a05687107aa00b0023a980f1fb8mr13141585oap.53.1714434035037;
        Mon, 29 Apr 2024 16:40:35 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id hp22-20020a0568709a9600b0023b58aa20afsm2144508oab.25.2024.04.29.16.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 16:40:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-input@vger.kernel.org
Subject: [PATCH v2 1/7] regulator: devres: add API for reference voltage supplies
Date: Mon, 29 Apr 2024 18:40:09 -0500
Message-ID: <20240429-regulator-get-enable-get-votlage-v2-1-b1f11ab766c1@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
References: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

A common use case for regulators is to supply a reference voltage to an
analog input or output device. This adds a new devres API to get,
enable, and get the voltage in a single call. This allows eliminating
boilerplate code in drivers that use reference supplies in this way.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* removed dev_err_probe() on error return
* dropped optional version of the function since there is no more
  difference after dev_err_probe() is removed
* renamed function to devm_regulator_get_enable_read_voltage()
* added unwinding on error paths
---
 Documentation/driver-api/driver-model/devres.rst |  1 +
 drivers/regulator/devres.c                       | 59 ++++++++++++++++++++++++
 include/linux/regulator/consumer.h               |  7 +++
 3 files changed, 67 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 7be8b8dd5f00..18caebad7376 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -433,6 +433,7 @@ REGULATOR
   devm_regulator_bulk_put()
   devm_regulator_get()
   devm_regulator_get_enable()
+  devm_regulator_get_enable_read_voltage()
   devm_regulator_get_enable_optional()
   devm_regulator_get_exclusive()
   devm_regulator_get_optional()
diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 90bb0d178885..4f290b9b559b 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -145,6 +145,65 @@ struct regulator *devm_regulator_get_optional(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_get_optional);
 
+/**
+ * devm_regulator_get_enable_read_voltage - Resource managed regulator get and
+ *                                          enable that returns the voltage
+ * @dev: device to supply
+ * @id:  supply name or regulator ID.
+ *
+ * Get and enable regulator for duration of the device life-time.
+ * regulator_disable() and regulator_put() are automatically called on driver
+ * detach. See regulator_get_optional(), regulator_enable(), and
+ * regulator_get_voltage() for more information.
+ *
+ * This is a convenience function for supplies that provide a reference voltage
+ * where the consumer driver just needs to know the voltage and keep the
+ * regulator enabled.
+ *
+ * In cases where the supply is not strictly required, callers can check for
+ * -ENODEV error and handle it accordingly.
+ *
+ * Returns: voltage in microvolts on success, or an error code on failure.
+ */
+int devm_regulator_get_enable_read_voltage(struct device *dev, const char *id)
+{
+	struct regulator *r;
+	int ret;
+
+	/*
+	 * Since we need a real voltage, we use devm_regulator_get_optional()
+	 * rather than getting a dummy regulator with devm_regulator_get() and
+	 * then letting regulator_get_voltage() fail with -EINVAL. This way, the
+	 * caller can handle the -ENODEV error code if needed instead of the
+	 * ambiguous -EINVAL.
+	 */
+	r = devm_regulator_get_optional(dev, id);
+	if (IS_ERR(r))
+		return PTR_ERR(r);
+
+	ret = regulator_enable(r);
+	if (ret)
+		goto err_regulator_put;
+
+	ret = devm_add_action_or_reset(dev, regulator_action_disable, r);
+	if (ret)
+		goto err_regulator_put;
+
+	ret = regulator_get_voltage(r);
+	if (ret < 0)
+		goto err_release_action;
+
+	return 0;
+
+err_release_action:
+	devm_release_action(dev, regulator_action_disable, r);
+err_regulator_put:
+	devm_regulator_put(r);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_regulator_get_enable_read_voltage);
+
 static int devm_regulator_match(struct device *dev, void *res, void *data)
 {
 	struct regulator **r = res;
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index ed180ca419da..59d0b9a79e6e 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -164,6 +164,7 @@ struct regulator *__must_check devm_regulator_get_optional(struct device *dev,
 							   const char *id);
 int devm_regulator_get_enable(struct device *dev, const char *id);
 int devm_regulator_get_enable_optional(struct device *dev, const char *id);
+int devm_regulator_get_enable_read_voltage(struct device *dev, const char *id);
 void regulator_put(struct regulator *regulator);
 void devm_regulator_put(struct regulator *regulator);
 
@@ -329,6 +330,12 @@ static inline int devm_regulator_get_enable_optional(struct device *dev,
 	return 0;
 }
 
+static inline int devm_regulator_get_enable_read_voltage(struct device *dev,
+							 const char *id)
+{
+	return -ENODEV;
+}
+
 static inline struct regulator *__must_check
 regulator_get_optional(struct device *dev, const char *id)
 {

-- 
2.43.2


