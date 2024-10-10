Return-Path: <linux-iio+bounces-10423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F114999424
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D43E1C264F4
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AAB1EABCD;
	Thu, 10 Oct 2024 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ2WLATE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22EC1E9088;
	Thu, 10 Oct 2024 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594051; cv=none; b=hSXM+Iou5yE+sybq/CsywpZqGDTTCS0bflT1ZjPEt1YHoJkQJMBv0HYNlwoWCXD5WcE3Ji/N8gD/G6K1QDTwGBrYZkwi1RZDT1dl3SbruQo7iID9obnMYAEq3WttQcVnuKrqEZN5zSZBVzMUB4Ox+2oV3jJWDHBVDwMh9qaCCzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594051; c=relaxed/simple;
	bh=/QcZtdu0B5tC/4wrcWlkpa4Yk5YtewNe0aUFngHHM5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAXy70nXahpru7SWTagQ2mQUQBP6BS9WLvU7neitZZVxsF34UljGJghOL/a7WgJqp5xduLqdCVX02NMuS5myhLDWW9XkhnavvDpXpUTaINL95jEaE5HfGjq/PTDOSNbHEjMmx65TF0Wu9fuLhnNJdDcfwpvaEApPK3PKLjkyD7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ2WLATE; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso1418752a12.0;
        Thu, 10 Oct 2024 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594048; x=1729198848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17TNCJpfLHjZg4gW7h+TPW4DXAtGpJiZu8iIf6mJ2M0=;
        b=DJ2WLATEZ/uhAnnOaRuMO2aKQxMXW3+QRE7zbYrC2bVBeQjvdvsP3Vrfgwd36UiMlL
         RAiES7EHlgPGPpKMvg3s8O1xd1Zh6WgtqtCBMOLUuUkLQnwiNwOszPS3avzueTpNG8kk
         TGD7K7fqz1z6y2xOESdHc+FxIymY1yihGs5PFkfYXRk2VmJzHXTe+meo4g6g4ZKdf0FS
         +EaaDXFTd8vsldHrp3yWLPPNzlQ1O5w0RMTuhWU9mhYfG6Dt0k3Dnr009WOlgfzZ0wb1
         nGIOrqVB7S2Q7oa1ptADSDP7in6n8MsmZFw92xvj+xx+8vGPHuNmMEv1l6TF28s4abRH
         +JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594048; x=1729198848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17TNCJpfLHjZg4gW7h+TPW4DXAtGpJiZu8iIf6mJ2M0=;
        b=NqxO4mvQdq6NeJQn/7/wVsC3syzPfvo5RNTuqeHkXBexwZEE+Cyhr8kYPAfFHKDUPo
         SJF8RfuY/PYpFHeJtXyZrYs/zVi7tWSABj6Q8mGOEsk3zaep2Cem9ViM45cJ0Cu19+Y4
         NnpHl/PzDgz4HbJIxblQWu4tMhPc/Dq9eWlkiOYZJuIcy5x0DA1hxqVCK3oEImx2bTK5
         7GtZEdl/qZBPcoIELuxVi9V174z2P/vwzF7dt5rTt77aLLhkKRTesiAh7f1wR2eWCrZ1
         +dd4WKXb3qxmKB8aTAHeV2aug8ESCRt184/4q8bHfYlTXTG/4VKo+RJVPs6NuPUBvIDb
         yJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCUumAONpRMYOEnLFkzJSqSYnNj08vEeVOrlPxtFCFFZW5tA2volD9559JGIs25uIOcSVxGQrOegyTH7@vger.kernel.org, AJvYcCWwuVffjxacdK02K/qDldqctFBS3wweTzim56/HPCf+4P7mbTlfN5m2gdHfxgcJhOEkX09TPu3Hgz0x@vger.kernel.org, AJvYcCXDGhUk/1yZ4Qjom3NWRrVloYUcAjYcAt7NVi0WS0qNYVCcP4fQxII9dUqpIjuW6NksUUOPp6J9a9kUIgMb@vger.kernel.org
X-Gm-Message-State: AOJu0YxiR+xKg+s+EWpeDLqAKvSot+55HUL2ki4JnM3W/9xQPqJ/QjXO
	+XUF3y1e5JirqMjXQgfjJ7LyG2W8qXislVUhwZ66+431fm68SRJd
X-Google-Smtp-Source: AGHT+IGbHawTCqdN6NOMErufah9hSa6SJzwiswtAFtT2XrVu/3U9FN6Y3CJRXid66ABX/frGJtJ0DA==
X-Received: by 2002:a17:907:6e9f:b0:a99:5171:7a44 with SMTP id a640c23a62f3a-a99a13e32b2mr289544566b.31.1728594048280;
        Thu, 10 Oct 2024 14:00:48 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:47 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/13] iio: chemical: bme680: add regulators
Date: Thu, 10 Oct 2024 23:00:24 +0200
Message-ID: <20241010210030.33309-8-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010210030.33309-1-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasileios Amoiridis <vassilisamir@gmail.com>

Add support for the regulators described in the dt-binding.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index dedb7edaf43d..a2039b966f20 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -15,6 +15,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -100,6 +101,12 @@ enum bme680_op_mode {
 	BME680_FORCED,
 };
 
+static const char *const bme680_supply_names[] = {
+	"vdd", "vddio"
+};
+
+#define BME680_NUM_SUPPLIES ARRAY_SIZE(bme680_supply_names)
+
 struct bme680_data {
 	struct regmap *regmap;
 	struct bme680_calib bme680;
@@ -110,6 +117,8 @@ struct bme680_data {
 	u16 heater_dur;
 	u16 heater_temp;
 
+	struct regulator_bulk_data supplies[BME680_NUM_SUPPLIES];
+
 	union {
 		u8 buf[3];
 		unsigned int check;
@@ -857,6 +866,13 @@ static const struct iio_info bme680_info = {
 	.attrs = &bme680_attribute_group,
 };
 
+static void bme680_regulators_disable(void *data)
+{
+	struct regulator_bulk_data *supplies = data;
+
+	regulator_bulk_disable(BME680_NUM_SUPPLIES, supplies);
+}
+
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name)
 {
@@ -885,6 +901,20 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	data->heater_temp = 320; /* degree Celsius */
 	data->heater_dur = 150;  /* milliseconds */
 
+	regulator_bulk_set_supply_names(data->supplies, bme680_supply_names,
+					BME680_NUM_SUPPLIES);
+	ret = devm_regulator_bulk_get(dev, BME680_NUM_SUPPLIES, data->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
+
+	ret = regulator_bulk_enable(BME680_NUM_SUPPLIES, data->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable regulators\n");
+
+	devm_add_action_or_reset(dev, bme680_regulators_disable, data->supplies);
+
+	fsleep(BME680_STARTUP_TIME_US);
+
 	ret = regmap_write(regmap, BME680_REG_SOFT_RESET, BME680_CMD_SOFTRESET);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to reset chip\n");
-- 
2.43.0


