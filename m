Return-Path: <linux-iio+bounces-25045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEDCBD7E45
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 09:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0C618A33B2
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 07:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AE030E0F5;
	Tue, 14 Oct 2025 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="FDweZJPA";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="FDweZJPA"
X-Original-To: linux-iio@vger.kernel.org
Received: from h4.cmg2.smtp.forpsi.com (h4.cmg2.smtp.forpsi.com [185.129.138.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D92C2D94AF
	for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426950; cv=none; b=HSzgiUCgWTnr4cpLpb8FATCiZSU3gs9aQfQn8/uyYSr8uSlD4RlKYZ4kAGIPJ5UMM5mJ0blxf5z429/24rqM1uTm/g98rYxlkpfAu/3bEMqvIAqwjKY7SCVMfjvkbGDW3ZaXRSDdP/IO7DEL42nZNsUOdO2+l9+DBT7d3PWE3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426950; c=relaxed/simple;
	bh=VnIyPwHOpp4Q7mXbC3YyimW8+6mS5nNt5r/rtS3lOjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZArHTt+Jc4wyoOZyXZJP8JWYKv9Ii6DEmi+QYNPu7cVLx5eDx+R3xypji3yMa+norOU85Ys5A/7Mm7KJzmJYWzTZZcpAQGR8KtRO/wLnzA2eWh2Y4qy5rehcd0xGj99Tc7uRGDl96Ka098sUDWgUN1MSBcW5H+32CUhIFbHQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=FDweZJPA; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=FDweZJPA; arc=none smtp.client-ip=185.129.138.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Received: from lt-aval.kyiv.ciklum.net ([85.248.43.180])
	by cmgsmtp with ESMTPSA
	id 8ZFHvLGmgC4IT8ZFgva5Ar; Tue, 14 Oct 2025 09:15:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1760426121; bh=Sxwk39GJaNKLRcjAwcIXv9US6NPqFEs9btMqurX/izU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=FDweZJPApyLMx0SzIE5HtWHbvpGGfB5bAdphwAtUp7HwdS8YiT+3iRYPTBxyYS040
	 EYs/BNDodL4YvlXJ0G6kFGKiLFb0eUQTHCcyqGXBt01zcJAUNAE3OD+A9/49aiT8Zs
	 zfxOdJGZrWrxRRkfHTGseqxmy74Etzc0izpoPjtEK3uGv1Y8FqGk07vHZP86WbkPRN
	 SUQ6rh16wl9//r65hWHC6xafj0O4JD4SLhdFC9/KAOBecSaLQuOfxqnNIyVOtF7SkQ
	 tSXdfiyg5Htt/JiOTu17G/hRC67RPJeQpVhbGL82h72P+ZWMzAWod5QOX/QOw2iWe/
	 gcOswXIxsKi6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1760426121; bh=Sxwk39GJaNKLRcjAwcIXv9US6NPqFEs9btMqurX/izU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=FDweZJPApyLMx0SzIE5HtWHbvpGGfB5bAdphwAtUp7HwdS8YiT+3iRYPTBxyYS040
	 EYs/BNDodL4YvlXJ0G6kFGKiLFb0eUQTHCcyqGXBt01zcJAUNAE3OD+A9/49aiT8Zs
	 zfxOdJGZrWrxRRkfHTGseqxmy74Etzc0izpoPjtEK3uGv1Y8FqGk07vHZP86WbkPRN
	 SUQ6rh16wl9//r65hWHC6xafj0O4JD4SLhdFC9/KAOBecSaLQuOfxqnNIyVOtF7SkQ
	 tSXdfiyg5Htt/JiOTu17G/hRC67RPJeQpVhbGL82h72P+ZWMzAWod5QOX/QOw2iWe/
	 gcOswXIxsKi6w==
From: Andrej Valek <andrej.v@skyrain.eu>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Valek Andrej <andrej.v@skyrain.eu>,
	Kessler Markus <markus.kessler@hilti.com>
Subject: [PATCH v4] iio: accel: fix ADXL355 startup race condition
Date: Tue, 14 Oct 2025 09:13:44 +0200
Message-Id: <20251014071344.151914-1-andrej.v@skyrain.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006095812.102230-1-andrej.v@skyrain.eu>
References: <20251006095812.102230-1-andrej.v@skyrain.eu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJJOjbdiLtLIsnE+njnEZf3Bb4w0gop5tromsg6jK+PGLF/WAg1BuHmJ5dhpPuf+n4uU1lgwbieCnOlxFsCFbXbqlrSZ8RtirKod9zLQsSjICUCLzCua
 I1dReaaW1Zb+tUQFS53qXaaqci0xSDlr1Z0pnw1nYRT+SMKz+AWjwX6ERJHtnqpoRyxlAF084wRFMWR2YJetg6g+jxMrgM1A4LdqahiXZuZpE5geYWRFOOJV
 330nL0CKO3BuwuQ2me9wsu+Y/N37H1P2/m3j4p0eiZ9hAVNN1TiLsP0xOtLMW0Yh1vQxgLZzwvV0Lgzid9KtxXsrb4wR6y8U/uWYC5X9A6DRd062ruH7N/gU
 keiVhNO3+VJfwcZiLgjBQfAtsGt8V4lCyUw/NVZrto2z6d5n5fxiodH7MpwfVKOJM5554g+/zk4av0zRAWzDmjLccfvRchqfR1fK9uiLbAqVH+/B1KkxAKYj
 yCpIVBbEYtX+SOqq

From: Valek Andrej <andrej.v@skyrain.eu>

There is an race-condition where device is not full working after SW reset.
Therefore it's necessary to wait some time after reset and verify shadow
registers values by reading and comparing the values before/after reset.
This mechanism is described in datasheet at least from revision D.

Fixes: 12ed27863ea3 ("iio: accel: Add driver support for ADXL355")
Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
---
V3 -> V4: DMA-safe buffers are used finally
V2 -> V3: Second tryout to use DMA-save buffers
V1 -> V2: First tryout to use DMA-safe buffers after review comments
---
 drivers/iio/accel/adxl355_core.c | 44 ++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 2e00fd51b4d5..5fc7f814b907 100644
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
@@ -294,7 +296,12 @@ static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
 static int adxl355_setup(struct adxl355_data *data)
 {
 	unsigned int regval;
+	int retries = 5; /* the number is chosen based on empirical reasons */
 	int ret;
+	u8 *shadow_regs __free(kfree) = kzalloc(ADXL355_SHADOW_REG_COUNT, GFP_KERNEL);
+
+	if (!shadow_regs)
+		return -ENOMEM;
 
 	ret = regmap_read(data->regmap, ADXL355_DEVID_AD_REG, &regval);
 	if (ret)
@@ -321,14 +328,41 @@ static int adxl355_setup(struct adxl355_data *data)
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
 
+	do {
+		if (--retries == 0) {
+			dev_err(data->dev, "Shadow registers mismatch\n");
+			return -EIO;
+		}
+
+		/*
+		 * Perform a software reset to make sure the device is in a consistent
+		 * state after start-up.
+		 */
+		ret = regmap_write(data->regmap, ADXL355_RESET_REG,
+				   ADXL355_RESET_CODE);
+		if (ret)
+			return ret;
+
+		/* Wait at least 5ms after software reset */
+		usleep_range(5000, 10000);
+
+		/* Read shadow registers for comparison */
+		ret = regmap_bulk_read(data->regmap,
+				       ADXL355_BASE_ADDR_SHADOW_REG,
+				       data->buffer.buf,
+				       ADXL355_SHADOW_REG_COUNT);
+		if (ret)
+			return ret;
+	} while (memcmp(shadow_regs, data->buffer.buf,
+			ADXL355_SHADOW_REG_COUNT));
+
 	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
 				 ADXL355_POWER_CTL_DRDY_MSK,
 				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK, 1));
-- 
2.34.1


