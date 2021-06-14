Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C83A65B0
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhFNLl5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233471AbhFNLhV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:37:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0D4F61283;
        Mon, 14 Jun 2021 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670410;
        bh=h7zAOrHasLUWNW7IyHLjIwSpypEVjBIIyS5aFPBrzzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoDjqVI1pE4PwIDSAo2yyfCb05NV/41BASu0kMFbraCt/r8kFHq2fmGUwJfGTJAA5
         MT60SG7wlxcat1nDDKJ7kM9vU0wyu/5Eu9mkSFvg+qeYgIW7xH+Qb8NkWoxHJpfJ4x
         qcDx/qTl5VClbMxXjDhRZ8a0NiOpra57d0oX6R2y0WhV8JtS6lXZWxH6Hv2+GfqpP3
         sRxCZq5gDkVbITAWEp3/2H/bbg8lCPBSpSdfSQzubn55XzdjJ1RCf7vCp2xpJcr/+6
         WVh6Jn563YzOLGaujBGCuJcFE7OAd9UxdiXFsvAhHNG3JoLEBoaJfRHnUv5eM0/+rp
         j6Na/8Kw7Vwuw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/17] staging:iio:adc:ad7280a: Use bitfield ops to managed fields in transfers.
Date:   Mon, 14 Jun 2021 12:34:55 +0100
Message-Id: <20210614113507.897732-6-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The write and two types of read transfer are sufficiently complex that
they benefit from the clarity of using FIELD_PREP() and FIELD_GET()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 46 ++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 1f7ea5fb1e20..158a792c0bf8 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -95,6 +95,23 @@
 #define   AD7280A_READ_ADDR_MSK				GENMASK(7, 2)
 #define AD7280A_CNVST_CTRL_REG			0x1D /* D7 to D0, Read/write */
 
+/* Transfer fields */
+#define AD7280A_TRANS_WRITE_DEVADDR_MSK		GENMASK(31, 27)
+#define AD7280A_TRANS_WRITE_ADDR_MSK		GENMASK(26, 21)
+#define AD7280A_TRANS_WRITE_VAL_MSK		GENMASK(20, 13)
+#define AD7280A_TRANS_WRITE_ALL_MSK		BIT(12)
+#define AD7280A_TRANS_WRITE_CRC_MSK		GENMASK(10, 3)
+#define AD7280A_TRANS_WRITE_RES_PATTERN		0x2
+
+/* Layouts differ for channel vs other registers */
+#define AD7280A_TRANS_READ_DEVADDR_MSK		GENMASK(31, 27)
+#define AD7280A_TRANS_READ_CONV_CHANADDR_MSK	GENMASK(26, 23)
+#define AD7280A_TRANS_READ_CONV_DATA_MSK	GENMASK(22, 11)
+#define AD7280A_TRANS_READ_REG_REGADDR_MSK	GENMASK(26, 21)
+#define AD7280A_TRANS_READ_REG_DATA_MSK		GENMASK(20, 13)
+#define AD7280A_TRANS_READ_WRITE_ACK_MSK	BIT(10)
+#define AD7280A_TRANS_READ_CRC_MSK		GENMASK(9, 2)
+
 /* Magic value used to indicate this special case */
 #define AD7280A_ALL_CELLS				(0xAD << 16)
 
@@ -216,10 +233,16 @@ static int __ad7280_read32(struct ad7280_state *st, unsigned int *val)
 static int ad7280_write(struct ad7280_state *st, unsigned int devaddr,
 			unsigned int addr, bool all, unsigned int val)
 {
-	unsigned int reg = devaddr << 27 | addr << 21 |
-			(val & 0xFF) << 13 | all << 12;
+	unsigned int reg = FIELD_PREP(AD7280A_TRANS_WRITE_DEVADDR_MSK, devaddr) |
+		FIELD_PREP(AD7280A_TRANS_WRITE_ADDR_MSK, addr) |
+		FIELD_PREP(AD7280A_TRANS_WRITE_VAL_MSK, val) |
+		FIELD_PREP(AD7280A_TRANS_WRITE_ALL_MSK, all);
+
+	reg |= FIELD_PREP(AD7280A_TRANS_WRITE_CRC_MSK,
+			ad7280_calc_crc8(st->crc_tab, reg >> 11));
+	/* Reserved b010 pattern not included crc calc */
+	reg |= AD7280A_TRANS_WRITE_RES_PATTERN;
 
-	reg |= ad7280_calc_crc8(st->crc_tab, reg >> 11) << 3 | 0x2;
 	st->tx = cpu_to_be32(reg);
 
 	return spi_write(st->spi, &st->tx, sizeof(st->tx));
@@ -264,10 +287,11 @@ static int ad7280_read_reg(struct ad7280_state *st, unsigned int devaddr,
 	if (ad7280_check_crc(st, tmp))
 		return -EIO;
 
-	if (((tmp >> 27) != devaddr) || (((tmp >> 21) & 0x3F) != addr))
+	if ((FIELD_GET(AD7280A_TRANS_READ_DEVADDR_MSK, tmp) != devaddr) ||
+	    (FIELD_GET(AD7280A_TRANS_READ_REG_REGADDR_MSK, tmp) != addr))
 		return -EFAULT;
 
-	return (tmp >> 13) & 0xFF;
+	return FIELD_GET(AD7280A_TRANS_READ_REG_DATA_MSK, tmp);
 }
 
 static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
@@ -310,10 +334,11 @@ static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
 	if (ad7280_check_crc(st, tmp))
 		return -EIO;
 
-	if (((tmp >> 27) != devaddr) || (((tmp >> 23) & 0xF) != addr))
+	if ((FIELD_GET(AD7280A_TRANS_READ_DEVADDR_MSK, tmp) != devaddr) ||
+	    (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, tmp) != addr))
 		return -EFAULT;
 
-	return (tmp >> 11) & 0xFFF;
+	return FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, tmp);
 }
 
 static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
@@ -351,8 +376,9 @@ static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
 		if (array)
 			array[i] = tmp;
 		/* only sum cell voltages */
-		if (((tmp >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6_REG)
-			sum += ((tmp >> 11) & 0xFFF);
+		if (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, tmp) <=
+		    AD7280A_CELL_VOLTAGE_6_REG)
+			sum += FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, tmp);
 	}
 
 	return sum;
@@ -407,7 +433,7 @@ static int ad7280_chain_setup(struct ad7280_state *st)
 			goto error_power_down;
 		}
 
-		if (n != ad7280a_devaddr(val >> 27)) {
+		if (n != ad7280a_devaddr(FIELD_GET(AD7280A_TRANS_READ_DEVADDR_MSK, val))) {
 			ret = -EIO;
 			goto error_power_down;
 		}
-- 
2.32.0

