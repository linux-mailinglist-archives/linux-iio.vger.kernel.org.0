Return-Path: <linux-iio+bounces-24770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15246BBD8DC
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 11:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F073B9F70
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBEE215F7D;
	Mon,  6 Oct 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="YEXIdq61";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="YEXIdq61"
X-Original-To: linux-iio@vger.kernel.org
Received: from h4.cmg1.smtp.forpsi.com (h4.cmg1.smtp.forpsi.com [185.129.138.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEE218AD1
	for <linux-iio@vger.kernel.org>; Mon,  6 Oct 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744752; cv=none; b=g6vn4lGTigHGXSP4ZUul7NucGhEvllmAj6SEWbcIZq/TO4cUaTVbMH1SpHin6t5udLqIY70gFx7UcRuuOxec2TRO0eq/xe8s2++6yVxs8vnaD1fLOCCtP9ucPLMQtIw/FCGSt/25M+QWxZfsn0ow9w48NL/FytFFVciF1jOiiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744752; c=relaxed/simple;
	bh=a3PlZMY1AzAKa+LRBqlFv5iOn3dnylk0FlvKYR3G244=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sG1/g5IJi+6U0s7xIBysXZmTOs5qIoqQDVI4mMNp7HS5LScSVYPbL/HKLnGLc4tqEYUA42ykaKGbnPuljBJamt/O8ALqcIgKp3mv4VuG/ImFYYjmCyB0jy7EURvVZ57/m4Ft3pdOLPflQrG9K4OGJXPvkTwvTsjmdGYrv73rG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=YEXIdq61; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=YEXIdq61; arc=none smtp.client-ip=185.129.138.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Received: from localhost.localdomain ([92.180.235.211])
	by cmgsmtp with ESMTPSA
	id 5hzNvh7iYx9qo5hzcvCp9b; Mon, 06 Oct 2025 11:58:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1759744738; bh=T51TqDA17DuQhZo3twwv/fLsWv/0imwFufzExD2QAGM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=YEXIdq61fof1vAbW9xbk+Hzg9bF9rDOy2YNEJVys5Kl3Z1NzSfwx4XRsRm1IdY33J
	 qayGnfNenmUioNclbWfhis+R9VwitrGbQLtxBujB6e40Di+uV8oOtT7bfPIQ7VVx4r
	 0LTHeUocX6ccKXMU08CJk0F9vLFitdO/X8txZjAN0PePKaZF/22QdooPGd4fw1Lsy1
	 sqcPq56wK8duupbenxFk1XE6dpOnfjOA18jI8oRH0ApkXxwOQpoyoSJ/7tXWq7r8FQ
	 dx7s77UjQIb40W2Z07ZsV3Ihc162TTQ2pweLtstCa7U7EwQ1g0IAPs+CEFF8ynDwh+
	 CjtbEgG+ZNQMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1759744738; bh=T51TqDA17DuQhZo3twwv/fLsWv/0imwFufzExD2QAGM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=YEXIdq61fof1vAbW9xbk+Hzg9bF9rDOy2YNEJVys5Kl3Z1NzSfwx4XRsRm1IdY33J
	 qayGnfNenmUioNclbWfhis+R9VwitrGbQLtxBujB6e40Di+uV8oOtT7bfPIQ7VVx4r
	 0LTHeUocX6ccKXMU08CJk0F9vLFitdO/X8txZjAN0PePKaZF/22QdooPGd4fw1Lsy1
	 sqcPq56wK8duupbenxFk1XE6dpOnfjOA18jI8oRH0ApkXxwOQpoyoSJ/7tXWq7r8FQ
	 dx7s77UjQIb40W2Z07ZsV3Ihc162TTQ2pweLtstCa7U7EwQ1g0IAPs+CEFF8ynDwh+
	 CjtbEgG+ZNQMA==
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
Date: Mon,  6 Oct 2025 11:58:12 +0200
Message-Id: <20251006095812.102230-1-andrej.v@skyrain.eu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJrr1r/V0ZK3hB5OtI4OB4+R6F8DuYHSnrD1PQgZgqmj+UWOZaGpCV5ccMjw7r5NlXd9frliiUbPFZYGNSkiiQncPZlQR/0JmQwRCoj7OP/e/DJ4KwGt
 EIEIJZlxcExaMi0pGyVeOyBEP+lMzGMZKcetQR4phW+QnJI4nsNyKmS3ewaE6OC5WZaxOrftaosC+/Ri/GDsV/T+EcKg8HKIAurzfZAC4GwSOBpyVsxekf5i
 zxIAttIGgbbeEwTQs3/Bp5h0m0D8fGsFXGqHeFPXMQ/QqzQxvgASk7V1ENK8YKjnoFPtFITBO6zAR7y7O8/fiMVmaLiJKXYSmWAEoQbG7B4wke7DLfAaIGTx
 v/B8x3LH77RsEZFvvD4KdwjRdnmrfkzYIDgnNVJ2xbACLdHSTE4NeyZw1Wn8C5fidaEiAzP2BN60GCcpWjFF1y3btoPgUOnzaHu0EeT374EJlTZC1Egc4vUH
 ftkYzoa79LfIpWT3

From: Valek Andrej <andrej.v@skyrain.eu>

There is an race-condition where device is not full working after SW reset.
Therefore it's necessary to wait some time after reset and verify shadow
registers values by reading and comparing the values before/after reset.
This mechanism is described in datasheet at least from revision D.

Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
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


