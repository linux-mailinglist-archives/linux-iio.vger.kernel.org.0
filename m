Return-Path: <linux-iio+bounces-22697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB02B25714
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 00:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC0B880BA0
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 22:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6686D2D8767;
	Wed, 13 Aug 2025 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JxF2Rj91"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8252FB99E;
	Wed, 13 Aug 2025 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125929; cv=none; b=BuYFV66mqd2VhnTWJlRzwGKG76HpS0UDVuFQaW+rrN9Fj/M3qd6EaA+qvEhzmltxpFerbQMMpboNQ5VvJc+zR4aDSKdjN5IfVISP4g2gSAfjFi15AdlSJQ9Rk/CUglFazCx38UmMjzcjAzz+AN8y174Cu7lXC/OhYjwoU/AYIg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125929; c=relaxed/simple;
	bh=W20HcqOXg0qKPxqTGiHh/tVgm+XAhbXH3JsZF1X8xMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRioLD5dDiCwRY26Cunw2uT1d/tYw6xSMXg1k0amkrl4o9Gwli2ikEybZUnT2hWxoLCtrPNslFHKylzEkltw5QCVRV3kVXdDIewbgxmPe8txQrDnYHhqukG5mMmJXQP5OuPgrnhyAOQtpRtyJHCsPicGvOYDeqm2lWqk3+EHqZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JxF2Rj91; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DMwgOR2248373;
	Wed, 13 Aug 2025 17:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755125922;
	bh=GI/YkJoC9wpyKDlsanGM1Km2OKDRvTtOETyJUBio3zU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JxF2Rj91p0kISM3Mhdqt4ghWp0fgt85AAuyJpQuyPWzsrCldQWKUP452h+FiCb0XS
	 gyXj2HnWDdNRwLcxQBTREG9GLXPdtMBKqaRtcxcH/Q+IR+l48YbcPVgzhmSemc6gUj
	 PqPxdhsH3bYf+y31Wc0TDIGhpJdHMQOVtWkFK7MI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DMwgVC714031
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 17:58:42 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 17:58:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 17:58:41 -0500
Received: from lelvem-mr05.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DMwfwa2683333;
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
Subject: [PATCH 2/6] iio: health: afe4403: Use devm_regulator_get_enable() helper
Date: Wed, 13 Aug 2025 17:58:36 -0500
Message-ID: <20250813225840.576305-2-afd@ti.com>
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

This takes care of both getting and enabling the regulator in one
function, it also handles the devm action, so remove that. Also
do not disable the regulator on suspend, this will be handled for
us. We now do not need to track the regulator at all, so drop it
from the device struct.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/iio/health/afe4403.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 99bf1bcbea40d..f9759f855c534 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -61,7 +61,6 @@ static const struct reg_field afe4403_reg_fields[] = {
  * @spi: SPI device handle
  * @regmap: Register map of the device
  * @fields: Register fields of the device
- * @regulator: Pointer to the regulator for the IC
  * @trig: IIO trigger for this device
  * @irq: ADC_RDY line interrupt number
  * @buffer: Used to construct data layout to push into IIO buffer.
@@ -70,7 +69,6 @@ struct afe4403_data {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
-	struct regulator *regulator;
 	struct iio_trigger *trig;
 	int irq;
 	/* Ensure suitable alignment for timestamp */
@@ -343,13 +341,6 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static void afe4403_regulator_disable(void *data)
-{
-	struct regulator *regulator = data;
-
-	regulator_disable(regulator);
-}
-
 #define AFE4403_TIMING_PAIRS			\
 	{ AFE440X_LED2STC,	0x000050 },	\
 	{ AFE440X_LED2ENDC,	0x0003e7 },	\
@@ -424,12 +415,6 @@ static int afe4403_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = regulator_disable(afe->regulator);
-	if (ret) {
-		dev_err(dev, "Unable to disable regulator\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -439,12 +424,6 @@ static int afe4403_resume(struct device *dev)
 	struct afe4403_data *afe = iio_priv(indio_dev);
 	int ret;
 
-	ret = regulator_enable(afe->regulator);
-	if (ret) {
-		dev_err(dev, "Unable to enable regulator\n");
-		return ret;
-	}
-
 	ret = regmap_clear_bits(afe->regmap, AFE440X_CONTROL2,
 				AFE440X_CONTROL2_PDN_AFE);
 	if (ret)
@@ -488,21 +467,11 @@ static int afe4403_probe(struct spi_device *spi)
 		}
 	}
 
-	afe->regulator = devm_regulator_get(dev, "tx_sup");
-	if (IS_ERR(afe->regulator))
-		return dev_err_probe(dev, PTR_ERR(afe->regulator),
-				     "Unable to get regulator\n");
-
-	ret = regulator_enable(afe->regulator);
+	ret = devm_regulator_get_enable(dev, "tx_sup");
 	if (ret) {
 		dev_err(dev, "Unable to enable regulator\n");
 		return ret;
 	}
-	ret = devm_add_action_or_reset(dev, afe4403_regulator_disable, afe->regulator);
-	if (ret) {
-		dev_err(dev, "Unable to add regulator disable action\n");
-		return ret;
-	}
 
 	ret = regmap_write(afe->regmap, AFE440X_CONTROL0,
 			   AFE440X_CONTROL0_SW_RESET);
-- 
2.39.2


