Return-Path: <linux-iio+bounces-22698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E08B25719
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 00:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66507880A64
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 22:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2702C2FE053;
	Wed, 13 Aug 2025 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p2sPgbiW"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78A2FB98D;
	Wed, 13 Aug 2025 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125929; cv=none; b=N0dKZkK9q7v7vrUFNBer3fk3adPEKmhqgwZYaZio1oHvqB2vZuZdNcRq0qGND5hccer3k3+7Q4GJ7ZpmrFxaDdtrBX4bw0xaqyUQPiVezOQunVp9ubuKXnbQt/6tURqB/MF8lNDHnMSaA31H/vij0t9TdXW5e78usTLyuHZr/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125929; c=relaxed/simple;
	bh=VcZBIdcjzMxjTL3snw5jmRRRO5DhaqnjK4yu/tUYq0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxW5mY+c/VQN+BwoOkKoUmIYbfl1GG3d8JITA3/CUhUyynjOmCz8fxY7JQ3ScquM+YKLfps9CSR2KfiAO7Czy3F4pt6OVuJerC2g9Pkhxkj/GNeqF/8XBuWtT3fc5gz3mehnZfod1VUwuDzowJWppjaa4JXX7JE3uTCxMLJFCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p2sPgbiW; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DMwhlJ1798737;
	Wed, 13 Aug 2025 17:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755125923;
	bh=IbUI2n2kGj3kC/eXNndXcoiUOnopCoF1AnB4pJ6MbP8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=p2sPgbiWvzctpdWgc1lcyKqv5oRnWLMbT2jcRJJMrWzN0PGg3AsHukrZMs6TYpik4
	 tHvPI97LmDwszoY+sFrc4E91lTBY8HH2qYkPdI6SxY2BPyP7R6SEHT0tfOWB2jWcp3
	 7D+hYfEJ5ANoe0p0huHT67p9F93yMB/4dwKQPYm4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DMwgg4390337
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 17:58:43 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 17:58:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 17:58:42 -0500
Received: from lelvem-mr05.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DMwfwd2683333;
	Wed, 13 Aug 2025 17:58:42 -0500
From: Andrew Davis <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 5/6] iio: health: afe4404: Use devm_regulator_get_enable() helper
Date: Wed, 13 Aug 2025 17:58:39 -0500
Message-ID: <20250813225840.576305-5-afd@ti.com>
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
 drivers/iio/health/afe4404.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 29e030943f599..19dd821155dd4 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -79,7 +79,6 @@ static const struct reg_field afe4404_reg_fields[] = {
  * struct afe4404_data - AFE4404 device instance data
  * @regmap: Register map of the device
  * @fields: Register fields of the device
- * @regulator: Pointer to the regulator for the IC
  * @trig: IIO trigger for this device
  * @irq: ADC_RDY line interrupt number
  * @buffer: Used to construct a scan to push to the iio buffer.
@@ -87,7 +86,6 @@ static const struct reg_field afe4404_reg_fields[] = {
 struct afe4404_data {
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
-	struct regulator *regulator;
 	struct iio_trigger *trig;
 	int irq;
 	s32 buffer[10] __aligned(8);
@@ -346,13 +344,6 @@ static irqreturn_t afe4404_trigger_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static void afe4404_regulator_disable(void *data)
-{
-	struct regulator *regulator = data;
-
-	regulator_disable(regulator);
-}
-
 /* Default timings from data-sheet */
 #define AFE4404_TIMING_PAIRS			\
 	{ AFE440X_PRPCOUNT,	39999	},	\
@@ -432,12 +423,6 @@ static int afe4404_suspend(struct device *dev)
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
 
@@ -447,12 +432,6 @@ static int afe4404_resume(struct device *dev)
 	struct afe4404_data *afe = iio_priv(indio_dev);
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
@@ -495,17 +474,7 @@ static int afe4404_probe(struct i2c_client *client)
 		}
 	}
 
-	afe->regulator = devm_regulator_get(dev, "tx_sup");
-	if (IS_ERR(afe->regulator))
-		return dev_err_probe(dev, PTR_ERR(afe->regulator),
-				     "Unable to get regulator\n");
-
-	ret = regulator_enable(afe->regulator);
-	if (ret) {
-		dev_err(dev, "Unable to enable regulator\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(dev, afe4404_regulator_disable, afe->regulator);
+	ret = devm_regulator_get_enable(dev, "tx_sup");
 	if (ret) {
 		dev_err(dev, "Unable to enable regulator\n");
 		return ret;
-- 
2.39.2


