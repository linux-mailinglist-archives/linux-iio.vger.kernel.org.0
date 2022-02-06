Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093784AB178
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiBFS5c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241720AbiBFS5b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8522AC06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 242D1B80D88
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3C4C340F1;
        Sun,  6 Feb 2022 18:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173846;
        bh=5aakm5MNswb8BcTxlBL9ZNBcTsk827f83J73Ukf+g08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMMAbh+yP+VEcnYGN47nVgDDVJNuUcpxE3gnKUW0MhG0zCntYAzoP/4os7KJfG7w4
         4m3AV9uChPDk9VpasLQhdu+g9xDy10Q2hSQJtzM9upQqRYmVjAc0NkIYVw9jdYV1xf
         9JGVjEzS7WQBz5dqR7jN6am6JPtVoQl6BgSRDYQG1v8uyAQ67dT4rLA6Qn/G/PndkN
         fEjfh7VH55mLkS16m6DekoU+3X8pE6UDK2iEmQzta7zvWxtyicggyq/yygwC1jScrs
         +4nMDLZVq+8mwg5tMbgDtUOJKFqsUeHPzDDTFfDVUpNie+obN4ThG6YM+7XIGaOukk
         fd7JyzA6F4aQg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 05/20] staging:iio:adc:ad7280a: Use bitfield ops to managed fields in transfers.
Date:   Sun,  6 Feb 2022 19:03:13 +0000
Message-Id: <20220206190328.333093-6-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
References: <20220206190328.333093-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The write and two types of read transfer are sufficiently complex that
they benefit from the clarity of using FIELD_PREP() and FIELD_GET().
This also applies to the handling in ad7280_event_handler() so
use a similar approach there as well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 64 ++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index b1698262cee0..0db7ac02589b 100644
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
@@ -806,17 +832,19 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 		goto out;
 
 	for (i = 0; i < st->scan_cnt; i++) {
-		if (((channels[i] >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6_REG) {
-			if (((channels[i] >> 11) & 0xFFF) >=
-			    st->cell_threshhigh) {
+		unsigned int val;
+
+		val = FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, channels[i]);
+		if (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, channels[i]) <=
+		    AD7280A_CELL_VOLTAGE_6_REG) {
+			if (val >= st->cell_threshhigh) {
 				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
 							 IIO_EV_DIR_RISING,
 							 IIO_EV_TYPE_THRESH,
 							 0, 0, 0);
 				iio_push_event(indio_dev, tmp,
 					       iio_get_time_ns(indio_dev));
-			} else if (((channels[i] >> 11) & 0xFFF) <=
-				   st->cell_threshlow) {
+			} else if (val <= st->cell_threshlow) {
 				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
 							 IIO_EV_DIR_FALLING,
 							 IIO_EV_TYPE_THRESH,
@@ -825,15 +853,13 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 					       iio_get_time_ns(indio_dev));
 			}
 		} else {
-			if (((channels[i] >> 11) & 0xFFF) >=
-				st->aux_threshhigh) {
+			if (val >= st->aux_threshhigh) {
 				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_RISING);
 				iio_push_event(indio_dev, tmp,
 					       iio_get_time_ns(indio_dev));
-			} else if (((channels[i] >> 11) & 0xFFF) <=
-				st->aux_threshlow) {
+			} else if (val <= st->aux_threshlow) {
 				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_FALLING);
-- 
2.35.1

