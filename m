Return-Path: <linux-iio+bounces-23897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4CB4A63E
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 10:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F24E7A41F0
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26AC1AA1D2;
	Tue,  9 Sep 2025 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="TiDsnbUf";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="TiDsnbUf"
X-Original-To: linux-iio@vger.kernel.org
Received: from h4.cmg1.smtp.forpsi.com (h4.cmg1.smtp.forpsi.com [185.129.138.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38403275112
	for <linux-iio@vger.kernel.org>; Tue,  9 Sep 2025 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408354; cv=none; b=TR9ONt/jNmFcv4NjY3OxxcZo/uiAgwK/ZrV3NjcOHr4vx2/UyXRyT1Xs8tCAsFDgXI3XUeConxDx5pIEno5nN471qB8mxro0RHql0KfstvUuHvOPKF1wlxMWl6RrgJbqgA5FK9SxGCwrjeegGtH38hthUma6lA8WCXyyprG7nOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408354; c=relaxed/simple;
	bh=mZihvwBr7fR1a9HrhTmgjFlKaHvxCTPWQOKITOBrcyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iZtl6u1HvIuLIZ4sPEXZGZYn+H03/ZrAZ9x6IqykA+fuGcfg/LpL+KKUe5kwI+kmD7s3StBOlHsnAZ71ApW69tdlIiJt9sd64tQqLoFbFzJA3X6ccnNYMbfCmUUU4WqjR4MybSoaGjMNXcuLV+z/2CJWh801FfeOtSmp26OONBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=TiDsnbUf; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=TiDsnbUf; arc=none smtp.client-ip=185.129.138.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Received: from lt-aval.kyiv.ciklum.net ([85.248.43.180])
	by cmgsmtp with ESMTPSA
	id vu8pufLhfx9qovu9HuwPiH; Tue, 09 Sep 2025 10:56:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1757408184; bh=GlD2SlE9yoxd2ksFTCgBjcaCo+vjN0C+Gv7eogyzH3A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TiDsnbUfNzawxbe0H4HXz0L3ZNpiLkH4DLZyBTFT/gfsHkexyG+4tUT48y5GClzgY
	 ceJTaCX/gOzlJVDKXM0zTZ1d2eHXvBj5UHn8VDKnZyBivrIPsj1CBksguDcjy5wyiH
	 v6nHmacrF5fScxS/aUNlGGnB/NNwaNflKGXgzrOXjA2OsES/dNfQiZWeWnMsIwgD2w
	 HkvpLREg8fAZVTUTHXGGMh4p0kWG02innEWNbLZ3MtHdbWIcYpDbSk02PEi/25tBM+
	 IDNGH5i6W9hYSGVL1ObZCibD2XciqsZQ8uoR2kzbHUoMt/p9UmRa7us+x9r13eYuce
	 NP3/U1x/5diYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1757408184; bh=GlD2SlE9yoxd2ksFTCgBjcaCo+vjN0C+Gv7eogyzH3A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TiDsnbUfNzawxbe0H4HXz0L3ZNpiLkH4DLZyBTFT/gfsHkexyG+4tUT48y5GClzgY
	 ceJTaCX/gOzlJVDKXM0zTZ1d2eHXvBj5UHn8VDKnZyBivrIPsj1CBksguDcjy5wyiH
	 v6nHmacrF5fScxS/aUNlGGnB/NNwaNflKGXgzrOXjA2OsES/dNfQiZWeWnMsIwgD2w
	 HkvpLREg8fAZVTUTHXGGMh4p0kWG02innEWNbLZ3MtHdbWIcYpDbSk02PEi/25tBM+
	 IDNGH5i6W9hYSGVL1ObZCibD2XciqsZQ8uoR2kzbHUoMt/p9UmRa7us+x9r13eYuce
	 NP3/U1x/5diYQ==
From: Andrej Valek <andrej.v@skyrain.eu>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Valek Andrej <andrej.v@skyrain.eu>,
	Kessler Markus <markus.kessler@hilti.com>
Subject: [PATCH] drivers: iio: accel: fix ADX355 startup race condition
Date: Tue,  9 Sep 2025 10:55:28 +0200
Message-Id: <20250909085528.68966-1-andrej.v@skyrain.eu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLy/am1gnv8MfJ7bmFaiO2BfcQ2wiHRpAic7T5tEqizEVWnAqHb0ndcfM0yFYA2sPH/aUHQA//2trK8mWOFB4eH9cd+cOj2mBiSN5OCkDNvO2IhLeeFa
 AZLpfTiLA81qThbswOTsH3ZR/wR5Qbc+GOh4smGhk9m0/BmGtyJnr2PRX9etxyVGVsXdtG6EcQa4H3GEtt2nQevMf12GnZ22cK/KL4DxGtP47+Qw3ak1Xd9G
 gF/UF25Q8C4CyX2AdxihRmlgZB7mcflPZR1SLpcSjJTOp1WE5iQqzoTKgE6fGnE58nKrHiAxu+n86ukyeUYPhs2oQWcTH3VlEPa5hH+xFUsTAIaP4gwn+baY
 NAvJu/zS3QSN6D0eGHmSuXBT5+10JYwgTIPhKUi1XJuE8reyv7o=

From: Valek Andrej <andrej.v@skyrain.eu>

There is an race-condition where device is not full working after SW reset.
Therefore it's necessary to wait some time after reset and verify shadow
registers values by reading and comparing the values before/after reset.
This mechanism is described in datasheet at least from revision D.

Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
---
 drivers/iio/accel/adxl355_core.c | 48 ++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 2e00fd51b4d51..5386cd4766def 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -56,6 +56,8 @@
 #define  ADXL355_POWER_CTL_DRDY_MSK	BIT(2)
 #define ADXL355_SELF_TEST_REG		0x2E
 #define ADXL355_RESET_REG		0x2F
+#define ADXL355_BASE_ADDR_SHADOW_REG	0x50
+#define ADXL355_SHADOW_REG_COUNT	5
 
 #define ADXL355_DEVID_AD_VAL		0xAD
 #define ADXL355_DEVID_MST_VAL		0x1D
@@ -294,6 +296,9 @@ static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
 static int adxl355_setup(struct adxl355_data *data)
 {
 	unsigned int regval;
+	u8 shadow_regs[ADXL355_SHADOW_REG_COUNT];
+	bool shadow_regs_valid = false;
+	int retries = 5; /* retries for reading shadow registers */
 	int ret;
 
 	ret = regmap_read(data->regmap, ADXL355_DEVID_AD_REG, &regval);
@@ -321,14 +326,47 @@ static int adxl355_setup(struct adxl355_data *data)
 	if (regval != ADXL355_PARTID_VAL)
 		dev_warn(data->dev, "Invalid DEV ID 0x%02x\n", regval);
 
-	/*
-	 * Perform a software reset to make sure the device is in a consistent
-	 * state after start-up.
-	 */
-	ret = regmap_write(data->regmap, ADXL355_RESET_REG, ADXL355_RESET_CODE);
+	/* Read shadow registers to be compared after reset */
+	ret = regmap_bulk_read(data->regmap,
+			       ADXL355_BASE_ADDR_SHADOW_REG,
+			       shadow_regs, ADXL355_SHADOW_REG_COUNT);
 	if (ret)
 		return ret;
 
+	/* Do software reset and check validity of the shadow registers */
+	while (!shadow_regs_valid && (retries > 0)) {
+		/*
+		 * Perform a software reset to make sure the device is in a consistent
+		 * state after start-up.
+		 */
+		ret = regmap_write(data->regmap, ADXL355_RESET_REG, ADXL355_RESET_CODE);
+		if (ret)
+			return ret;
+
+		/* Wait at least 5ms after software reset */
+		usleep_range(5000, 10000);
+
+		/* Read shadow registers for comparison */
+		ret = regmap_bulk_read(data->regmap,
+				       ADXL355_BASE_ADDR_SHADOW_REG,
+				       data->buffer.buf, ADXL355_SHADOW_REG_COUNT);
+		if (ret)
+			return ret;
+
+		/* Check if shadow registers have expected values */
+		shadow_regs_valid = !memcmp(shadow_regs, data->buffer.buf,
+					    ADXL355_SHADOW_REG_COUNT);
+		if (!shadow_regs_valid) {
+			retries--;
+			dev_warn(data->dev, "Shadow registers mismatch, retrying...\n");
+		}
+	}
+
+	if (!shadow_regs_valid) {
+		dev_err(data->dev, "Invalid shadow registers values\n");
+		return -EIO;
+	}
+
 	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
 				 ADXL355_POWER_CTL_DRDY_MSK,
 				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK, 1));
-- 
2.34.1


