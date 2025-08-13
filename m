Return-Path: <linux-iio+bounces-22699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12003B2571C
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 00:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DA2624617
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 22:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D43530E82E;
	Wed, 13 Aug 2025 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IJiKsKSE"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0172C0F6C;
	Wed, 13 Aug 2025 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125930; cv=none; b=dF+M3q33iM4R2P8J7vmj3RTE75sm/etUfsdoxYQnFvDZsoNld/jXH+6eCZVvqeXzhrxfBZc+TkRpNpvCOb9JccX2l0js3tRrH/A4n4bTvmMPxlaVjxMyrtpORaAfxt0TPmkp8Uu12fmdpr7JKxhN2SxIKHnp1SR9N6y7weXhtp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125930; c=relaxed/simple;
	bh=vpM7V4RN7a/lWD4lP5JQhPPg8msvwIhJd92FdQhUvGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIq0xEVHsKQKaN0eVyKN6nA4bSgSVXhf/UbFb6N8YfQzgTULZmAyYk78CIix1xi69xyoJNPvB5chnbbygd3OZCr2EXPvLjzojbaK4ZsA7znqUwBlOZTZGFC17KpM/mxw7K9U91MR5ji28SyGWr0IIq9DIEnArYT67EjTHl050IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IJiKsKSE; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DMwgYT1798733;
	Wed, 13 Aug 2025 17:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755125922;
	bh=8JyvMcs2y0h0qyZtcEcDmMsAYyMLSb4/wpH1a1AB+7I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=IJiKsKSE3kheLNprZYw0Ac+SoIUf+yUbv5g/iWATVWfbQ2bd2XCz1MC060z0hqKJ8
	 n21IXmpA8zcKpLeqwMPiReP58o/cGwj3iZE3oqmcWwbDmnT3+RtjO6byz95qvp387Q
	 FnwmMlzkK9NS2CfRwM0bofaRYxtvw7KwiIsSCQVM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DMwgP31399600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 17:58:42 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 17:58:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 17:58:41 -0500
Received: from lelvem-mr05.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DMwfwb2683333;
	Wed, 13 Aug 2025 17:58:41 -0500
From: Andrew Davis <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 3/6] iio: health: afe4403: Use dev_err_probe() helper
Date: Wed, 13 Aug 2025 17:58:37 -0500
Message-ID: <20250813225840.576305-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250813225840.576305-1-afd@ti.com>
References: <20250813225840.576305-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This checks for EPROBE_DEFER and allows us to print out the error code
while return it directly saving some lines of code.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/iio/health/afe4403.c | 62 +++++++++++++-----------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index f9759f855c534..56953730c2bed 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -453,39 +453,31 @@ static int afe4403_probe(struct spi_device *spi)
 	afe->irq = spi->irq;
 
 	afe->regmap = devm_regmap_init_spi(spi, &afe4403_regmap_config);
-	if (IS_ERR(afe->regmap)) {
-		dev_err(dev, "Unable to allocate register map\n");
-		return PTR_ERR(afe->regmap);
-	}
+	if (IS_ERR(afe->regmap))
+		return dev_err_probe(dev, PTR_ERR(afe->regmap),
+				     "Unable to allocate register map\n");
 
 	for (i = 0; i < F_MAX_FIELDS; i++) {
 		afe->fields[i] = devm_regmap_field_alloc(dev, afe->regmap,
 							 afe4403_reg_fields[i]);
-		if (IS_ERR(afe->fields[i])) {
-			dev_err(dev, "Unable to allocate regmap fields\n");
-			return PTR_ERR(afe->fields[i]);
-		}
+		if (IS_ERR(afe->fields[i]))
+			return dev_err_probe(dev, PTR_ERR(afe->fields[i]),
+					     "Unable to allocate regmap fields\n");
 	}
 
 	ret = devm_regulator_get_enable(dev, "tx_sup");
-	if (ret) {
-		dev_err(dev, "Unable to enable regulator\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to enable regulator\n");
 
 	ret = regmap_write(afe->regmap, AFE440X_CONTROL0,
 			   AFE440X_CONTROL0_SW_RESET);
-	if (ret) {
-		dev_err(dev, "Unable to reset device\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to reset device\n");
 
 	ret = regmap_multi_reg_write(afe->regmap, afe4403_reg_sequences,
 				     ARRAY_SIZE(afe4403_reg_sequences));
-	if (ret) {
-		dev_err(dev, "Unable to set register defaults\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to set register defaults\n");
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = afe4403_channels;
@@ -498,43 +490,33 @@ static int afe4403_probe(struct spi_device *spi)
 						   "%s-dev%d",
 						   indio_dev->name,
 						   iio_device_id(indio_dev));
-		if (!afe->trig) {
-			dev_err(dev, "Unable to allocate IIO trigger\n");
-			return -ENOMEM;
-		}
+		if (!afe->trig)
+			return dev_err_probe(dev, -ENOMEM, "Unable to allocate IIO trigger\n");
 
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 
 		ret = devm_iio_trigger_register(dev, afe->trig);
-		if (ret) {
-			dev_err(dev, "Unable to register IIO trigger\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "Unable to register IIO trigger\n");
 
 		ret = devm_request_threaded_irq(dev, afe->irq,
 						iio_trigger_generic_data_rdy_poll,
 						NULL, IRQF_ONESHOT,
 						AFE4403_DRIVER_NAME,
 						afe->trig);
-		if (ret) {
-			dev_err(dev, "Unable to request IRQ\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "Unable to request IRQ\n");
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
 					      afe4403_trigger_handler, NULL);
-	if (ret) {
-		dev_err(dev, "Unable to setup buffer\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to setup buffer\n");
 
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret) {
-		dev_err(dev, "Unable to register IIO device\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to register IIO device\n");
 
 	return 0;
 }
-- 
2.39.2


