Return-Path: <linux-iio+bounces-24109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73521B5799D
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 14:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55E1166F5F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B595304971;
	Mon, 15 Sep 2025 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="DlSRZ/aV";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="DlSRZ/aV"
X-Original-To: linux-iio@vger.kernel.org
Received: from h4.cmg2.smtp.forpsi.com (h4.cmg2.smtp.forpsi.com [185.129.138.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12F2FDC5D
	for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937587; cv=none; b=gM6HtFLxXFr9V+85eWCzkd+HnY4+RpasdV4+aUCmH37DQH8bTr0Ftok79DQp7o2Yr7bVC+jkfsYeiWRFLUpTNUIYCfQhFU3M3hda8B00PBL34mKwqU5L9K6k5sVi0W5qylQMMMRwKjNppHacwfbxUwbvA5hCCmWD21Ve8mA3svM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937587; c=relaxed/simple;
	bh=yBjPq438AgQuQJAK7rVBQjg6bAZwJBwT3eCsn9D07+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4BBVd7S+p49oShrcFK+1dazfsC2L+9DQWgORf4z/E/Km96x8HOVjRxo/JqXjD3bI1AFC3reWqEMuXqleM3pp08pp5aBBUQrps7Y4PSPJwJU7Yy0Jp/+8kcdvtEaLKKe836XulZZ1UyIKvQzmAFzKulaaEIufJDfluecXHnBT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=DlSRZ/aV; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=DlSRZ/aV; arc=none smtp.client-ip=185.129.138.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Received: from localhost.localdomain ([92.180.235.211])
	by cmgsmtp with ESMTPSA
	id y7rTu4EApC4ITy7rluCUi5; Mon, 15 Sep 2025 13:59:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1757937570; bh=sPJaA1Jy8z+7bzDuQNjJFUZCW45/tkpQ5a26EyVDacU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DlSRZ/aVOMskxzB3jW5ldxq5j315ALYPg6oNR1r75V7Uvn3xRGEQyZ9g4+vVdsYmJ
	 hG0N6Ht2AlgqRPrwl2NXznKoAA8nkvq98UPbOexhM5etHznK5g59SXBT6ikxQzu5uz
	 WC/KGD6sFRuLFOVUFSByFEPFq/uQCQ6DuJygci92Vl8JElTemGj3PEmvh4F5lQaO9M
	 f+Tfmh8IAT2vkLorej1kq7X+NNJbaEXh8dfAE0QCdENi2ahXA5+Oc59RimgSZs1vru
	 t8OPQiTpzP+XDQVUAO/pbImfpW7vud//YmXISaZ30xY4RRKb58cVf3Av8kqxCyHJNj
	 p8cccwhZd3PJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1757937570; bh=sPJaA1Jy8z+7bzDuQNjJFUZCW45/tkpQ5a26EyVDacU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DlSRZ/aVOMskxzB3jW5ldxq5j315ALYPg6oNR1r75V7Uvn3xRGEQyZ9g4+vVdsYmJ
	 hG0N6Ht2AlgqRPrwl2NXznKoAA8nkvq98UPbOexhM5etHznK5g59SXBT6ikxQzu5uz
	 WC/KGD6sFRuLFOVUFSByFEPFq/uQCQ6DuJygci92Vl8JElTemGj3PEmvh4F5lQaO9M
	 f+Tfmh8IAT2vkLorej1kq7X+NNJbaEXh8dfAE0QCdENi2ahXA5+Oc59RimgSZs1vru
	 t8OPQiTpzP+XDQVUAO/pbImfpW7vud//YmXISaZ30xY4RRKb58cVf3Av8kqxCyHJNj
	 p8cccwhZd3PJg==
From: Andrej Valek <andrej.v@skyrain.eu>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Valek Andrej <andrej.v@skyrain.eu>,
	Kessler Markus <markus.kessler@hilti.com>
Subject: [PATCH v2] iio: accel: fix ADXL355 startup race condition
Date: Mon, 15 Sep 2025 13:58:18 +0200
Message-Id: <20250915115818.14164-1-andrej.v@skyrain.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909085528.68966-1-andrej.v@skyrain.eu>
References: <20250909085528.68966-1-andrej.v@skyrain.eu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNv6/FNpRtjNB+HLvx3d8pY7RGSOFdi31O9vuLGB4lHaug/KZ0iGbAChjJ/NGtyo5+6jcV/CR8glt7wGE/3DmP8Jz67ubcP7cBAaYjH2lYqDDBf70iip
 2+4pXvERocfSl88BicCWrQdkeaFBsksxXoVRSSDhRCY9ar2dqxZnvydaif7CzJRCfbw6jc7urRlsoPD1rwUhuFtVtCbbhw4DANGMVhzcA6QybXyVwkwmhQZr
 aH1BnG1/F/jMlr2DEGtmhF2cwjIIObHb9H/UMWEXfTcBO8uuMoMv3yBzm/hzFfkauVNMXDXBaSLl5cEzuGMfh3FzUebca9IbevN5YZa5AIie7FHyo6IeolbV
 Ntu0GlQRPwO2tV+DRefU308gJiFHAT8vWskpnKLxI5HWcVxSAHI=

From: Valek Andrej <andrej.v@skyrain.eu>

There is an race-condition where device is not full working after SW reset.
Therefore it's necessary to wait some time after reset and verify shadow
registers values by reading and comparing the values before/after reset.
This mechanism is described in datasheet at least from revision D.

Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
---
 drivers/iio/accel/adxl355_core.c | 41 ++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 2e00fd51b4d51..d688841f374da 100644
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
@@ -294,6 +296,8 @@ static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
 static int adxl355_setup(struct adxl355_data *data)
 {
 	unsigned int regval;
+	u8 shadow_regs[ADXL355_SHADOW_REG_COUNT];
+	int retries = 5; /* the number is chosen based on empirical reasons */
 	int ret;
 
 	ret = regmap_read(data->regmap, ADXL355_DEVID_AD_REG, &regval);
@@ -321,14 +325,41 @@ static int adxl355_setup(struct adxl355_data *data)
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


