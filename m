Return-Path: <linux-iio+bounces-12792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729409DBC84
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 20:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CCA1648E2
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 19:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EB51C2DA2;
	Thu, 28 Nov 2024 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItLE2QfS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0131319D06A;
	Thu, 28 Nov 2024 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822382; cv=none; b=byFL2BmaKOU/kNQBJ+L2xpj1aQdQFAkSQPIHFJUAsYguy3Y0zQrE6Gpa6mjIAzfUaYrrvBH4K+Akbyn8iYiG3BnLdy7SRdlMxGTHtv9h6cXwRzIQIa7P0X/kuxCaPLlseFB9kvxXfeNpnBPHt6O5E5QmoxQ/2QAsRu4XJFGxTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822382; c=relaxed/simple;
	bh=Em3eOUCdZSAgYZdSmbQ4yY7NDzuoHHztEdqJMLF/G9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsHcsePFvHQSmvhknNfjRlZM6IuA1D8dpwVt5MfH0V0Enud2cPyjzTC4b6d28XzyXvwKFNfXk3xHEAtXbBIEm4mY6SIjZTVUpytI2H1jh8uR5w1VWbR80Kcv1iOlP7pfR7O5l3zmunOcjzeLu7Ek1mzx7olQFj664FqrCn7/xzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItLE2QfS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-382376fcc4fso783314f8f.2;
        Thu, 28 Nov 2024 11:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732822379; x=1733427179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xazBXG9O0RzHhvZuaT6MI9gIc1q0aq5PO0WnsSqCZUY=;
        b=ItLE2QfSZfYbF3F7LAY95mjE4o2uGSt7/ibMxRZvwSPk7JZpZ0kGTadd/9m3xqK1tZ
         6gYLF2ULut8nLUTd3OLdFrmBFZe6hbkgz4nlwhSaKWubf3Z39Hwc2vpTCz2RCwkoaGFI
         dsjYx5roCJvzvE3uxBTAVyX3Iuop3bMustNQ6f8qrNgoKrTz4t8rfEUeMkS9i0caBxKF
         cltBQZ4/VA3YRzhUTaRMpev1mC8ZCzhD9F6sZ0bydomB8tA2hk6V/wQr5dxY5DN6osvR
         8NY2I0II7PoZDA2EnjQ28ATGK6GzI2JntDhb2pkLW3CLtt+41gUmaH2m5gUFXSSxqCDr
         +ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732822379; x=1733427179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xazBXG9O0RzHhvZuaT6MI9gIc1q0aq5PO0WnsSqCZUY=;
        b=CjYJu7vgFw5Xbfk9Ej5TqyHDBF5dAHcau8vnH+hvo7Mfptir9FrnIjpNzCV6ADz8B2
         ToXyx+c0TS8dVuo/QBzTG5laCCoGfHSsTfuOFZjMlRq3yw+lFOPotHMCb5GmJQ2f9JFE
         0ZHR5AaotMtUL8SiOeY3cud6+wXzrd7ARjKPZXYeHXSKdbLvu88L5SZ6cAN0TH12Dcmt
         gjnsvdbZ0QIcD+ORyFgrrb3iMmLkmV9wIqb14YIOeaxv27aUnkTwi2Q8pmsTiHmoHQAd
         joklCOgDJELF//UE4P3/rzbh2Nip8K36lL8S8VMLHiLF3ebOweR08Zuw4dgY6UUoZ2N0
         Y0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ27/0DEW01LcogLmy4IQ448WC51PjwZ75s/ete8MoZFujf31lMy+CJpk2r1O9mPCObPMWHVjeHqZG@vger.kernel.org, AJvYcCWckwfSjPxg+f4P3IIbDi4rjl0Fk9gFea5DqcyjCKk8ZWI2n/Dq9Qk7gNuIWQ2UO/mgWwvH9JG+QUaH@vger.kernel.org, AJvYcCWiWkgxNcZaRwmSMDvO12Rg2cp+95XhbBZC216QUgAZvoeHeskfMN+B2lDurdNV7PTyKncZ/guBYZDNd7o3@vger.kernel.org
X-Gm-Message-State: AOJu0YxdHxceiG6MR2wayXclxNo6SqZRIaAoPSm25chNMPNrZkl/qi4K
	GAbKiz/oQHc3ybMfYyItm/i3KqegUhbbC732nGgmb34lV/Z4NspRgGWFwTz+
X-Gm-Gg: ASbGncs6yEuoXJHxtqoU/TBLMKtt3TxJXpr+g/q8XqW7F87Nj5lu6bMb71i/Lk46kOa
	vVDEruTkZ5bb9mRgodn9XWlD8lh6f6MI+O4/8OS+/GmbE6hblVknClvKTZHu+nFEwW1/elxZRG+
	ijAx0C9847cD6T4VvagkeDxuXPcq+p9t4oB7VaLDh3F2Iw6KAJQg7T1Cd87VgSHhsGWOFeXVnGR
	mQSUJ/tF6QssMs4U5WQotEgBS8Dt6jKewEKkxC3ClpKo8A0qgMnSAGrcLmFVII=
X-Google-Smtp-Source: AGHT+IHr3KYxmbetmJvxOLVRdv7z2jTX64gnhA3Eb1SNKUsOy/5TD09bctTe2y8wBVywyIc3RHdbhw==
X-Received: by 2002:a05:6000:186f:b0:382:319f:3abd with SMTP id ffacd0b85a97d-385c6edd338mr7501714f8f.36.1732822379251;
        Thu, 28 Nov 2024 11:32:59 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:a8c6:c7bb:87d7:66dd])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434b0dbe40csm30557855e9.10.2024.11.28.11.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 11:32:58 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] iio: chemical: bme680: add regulators
Date: Thu, 28 Nov 2024 20:32:45 +0100
Message-ID: <20241128193246.24572-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128193246.24572-1-vassilisamir@gmail.com>
References: <20241128193246.24572-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the regulators described in the dt-binding.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 9783953e64e0..186e0a6cc2d7 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -15,6 +15,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -111,6 +112,10 @@ enum bme680_scan {
 	BME680_GAS,
 };
 
+static const char *const bme680_supply_names[] = { "vdd", "vddio" };
+
+#define BME680_NUM_SUPPLIES ARRAY_SIZE(bme680_supply_names)
+
 struct bme680_data {
 	struct regmap *regmap;
 	struct bme680_calib bme680;
@@ -1114,6 +1119,14 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	data->heater_dur = 150;  /* milliseconds */
 	data->preheat_curr_mA = 0;
 
+	ret = devm_regulator_bulk_get_enable(dev, BME680_NUM_SUPPLIES,
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


