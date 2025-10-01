Return-Path: <linux-iio+bounces-24638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA149BB0CD4
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 16:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907EF2A591E
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE552D8781;
	Wed,  1 Oct 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="WsFsSrcI";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="WsFsSrcI"
X-Original-To: linux-iio@vger.kernel.org
Received: from h4.cmg1.smtp.forpsi.com (h4.cmg1.smtp.forpsi.com [185.129.138.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287C1D5CC6
	for <linux-iio@vger.kernel.org>; Wed,  1 Oct 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330032; cv=none; b=UDKEiq41wSeOckLI1EcsCCmQRTdBW/GDh1Rq1loXQQLX4sgl6H+Jc1Ys80LNd4H3zoQmYlWjmt2wkjsOFOa5wy8yzFTu0fmaF2lismKM4frZv1Gym4tjNtRPqZWJ5GnXtJT9rVSQ+MPgdIRLNMTokZ3cTXF2FJ1x90cyPxd51iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330032; c=relaxed/simple;
	bh=QYTEm+vkAzUPUFr3W/3lZ7sdrCAOqWhzpQ9HlyE/9N0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aVBPU1+3boos5eXgXTTkm3puaig1bVm3dXaHF16gCLd/XqQ602bkz9RcbmrGSjmdwKW8sapMlfINnX/b4smWxbvMPXqF/IsigPMfKawH4bGl6Etr8lvTqDLYFGC0hnml4/BTvEDBrfGy3gQZZZnjnklqQzqdmW9gwdg/4j5UgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=WsFsSrcI; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=WsFsSrcI; arc=none smtp.client-ip=185.129.138.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Received: from localhost.localdomain ([92.180.235.211])
	by cmgsmtp with ESMTPSA
	id 3xy7vi9Dyx9qo3xyYv0VEa; Wed, 01 Oct 2025 16:38:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1759329519; bh=WnfVj2nQL0Iu8Glnrhsrtphn4FcsDn3HqMfBO6IM3/U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=WsFsSrcIfJRdRnQnUT/hRxP74hHP5d37YEq1xwQRrSqK41islWbPfVajdfNuFu0vH
	 tfR2r0WlMGFZAUdaBt6MRAAEI5RseL7UhUDLDO359DnRLHN0cHncXW+kG7NfKdUkC5
	 Bz65Rt8uA9Ln4EAy3jxD0FPhG1w6GdDi21ASIbu7aZKaa/GtuHrjlG3p9A3ALUcfEY
	 EKPiRGbZsmbQJ4GIYG90ZUe0UOXkj2xUY6XYegvOxSTaFnTUvtyKXBE1hNs14UonNY
	 f5qGE5gbIqmYUrexXoHFOC4fYwe0waXWzgoqiJq5fWXQb87IN93K2YMtL0K65F1Ibh
	 RQBfXf2mO437Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1759329519; bh=WnfVj2nQL0Iu8Glnrhsrtphn4FcsDn3HqMfBO6IM3/U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=WsFsSrcIfJRdRnQnUT/hRxP74hHP5d37YEq1xwQRrSqK41islWbPfVajdfNuFu0vH
	 tfR2r0WlMGFZAUdaBt6MRAAEI5RseL7UhUDLDO359DnRLHN0cHncXW+kG7NfKdUkC5
	 Bz65Rt8uA9Ln4EAy3jxD0FPhG1w6GdDi21ASIbu7aZKaa/GtuHrjlG3p9A3ALUcfEY
	 EKPiRGbZsmbQJ4GIYG90ZUe0UOXkj2xUY6XYegvOxSTaFnTUvtyKXBE1hNs14UonNY
	 f5qGE5gbIqmYUrexXoHFOC4fYwe0waXWzgoqiJq5fWXQb87IN93K2YMtL0K65F1Ibh
	 RQBfXf2mO437Q==
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
Subject: [PATCH v3] iio: accel: fix ADXL355 startup race condition
Date: Wed,  1 Oct 2025 16:37:02 +0200
Message-Id: <20251001143702.587073-1-andrej.v@skyrain.eu>
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
X-CMAE-Envelope: MS4xfKkZCZOYtlKHnJ2DMlyQpZuqke4VS5RmvbAv6cflWVFiSO/Qi9/0vBozJUAx1Xb9NecAQAmKvvZWF1QhsqVDgGUVgjQL0tG6kqfV/DHVAmryb/j+RZ4p
 JruTDJYNyc9eDR0zcLI3ZTjOEmq9O1eXTjJSjaE5ls19A9j21pka0mzAbsl0byisFVgCOfqyI4x1A10iPgC64ZcTZlu+71unvtNoKO/xUfDr0QkYcwDjRPDZ
 CNSgdsLBVnPMMH22UmzFrz/6xj6t0+HhpbQKpurwu3SZxXVzUArQECx7p8XEMxqQ745vuRVoqtGgP42M28SnvUOiB+DkKCrcQWWj7SYW3uBpCLOr+7KLlwi0
 Hx5XHGEBMkK8VMuPtD7LIGmhdgkvHtu1TBZUM29IZvxezwOB2OBCsUl4Snxta4NLblbDRuAkvvIAf2P3dfJwemhF485XaXVgKsDo517mN5ETQ7PhhQx8vkv9
 q+sw0UPOKdqPx8qV

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
index 2e00fd51b4d5..782085d74ab8 100644
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
+	u8 *shadow_regs __free(kfree) = kzalloc(ADXL355_SHADOW_REG_COUNT, GFP_KERNEL);
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


