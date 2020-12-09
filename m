Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547612D4F15
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 00:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgLIXvn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 18:51:43 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:39817 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732493AbgLIXtz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 18:49:55 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 797F3240007;
        Wed,  9 Dec 2020 23:49:07 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/6] iio:common:ms_sensors:ms_sensors_i2c: rework CRC calculation helper
Date:   Thu, 10 Dec 2020 00:48:55 +0100
Message-Id: <20201209234857.1521453-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The CRC calculation always happens on 8 words which is why there is an
extra element in the prom array of struct ms_tp_dev. However, on ms5637 and
similar, only 7 words are readable.

Then, set MS_SENSORS_TP_PROM_WORDS_NB to 8 and stop passing a len parameter
to ms_sensors_tp_crc_valid as this simply hide the fact that it is
hardcoded.

Finally, use the newly introduced hw->prom_len to know how many words can be
read.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 12 +++++-------
 drivers/iio/common/ms_sensors/ms_sensors_i2c.h |  4 ++--
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index b9e2038d05ef..872f90459e2e 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -493,19 +493,18 @@ EXPORT_SYMBOL(ms_sensors_ht_read_humidity);
  *     This function is only used when reading PROM coefficients
  *
  * @prom:	pointer to PROM coefficients array
- * @len:	length of PROM coefficients array
  *
  * Return: True if CRC is ok.
  */
-static bool ms_sensors_tp_crc_valid(u16 *prom, u8 len)
+static bool ms_sensors_tp_crc_valid(u16 *prom)
 {
 	unsigned int cnt, n_bit;
 	u16 n_rem = 0x0000, crc_read = prom[0], crc = (*prom & 0xF000) >> 12;
 
-	prom[len - 1] = 0;
+	prom[MS_SENSORS_TP_PROM_WORDS_NB - 1] = 0;
 	prom[0] &= 0x0FFF;      /* Clear the CRC computation part */
 
-	for (cnt = 0; cnt < len * 2; cnt++) {
+	for (cnt = 0; cnt < MS_SENSORS_TP_PROM_WORDS_NB * 2; cnt++) {
 		if (cnt % 2 == 1)
 			n_rem ^= prom[cnt >> 1] & 0x00FF;
 		else
@@ -537,7 +536,7 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
 {
 	int i, ret;
 
-	for (i = 0; i < MS_SENSORS_TP_PROM_WORDS_NB; i++) {
+	for (i = 0; i < dev_data->hw->prom_len; i++) {
 		ret = ms_sensors_read_prom_word(
 			dev_data->client,
 			MS_SENSORS_TP_PROM_READ + (i << 1),
@@ -547,8 +546,7 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
 			return ret;
 	}
 
-	if (!ms_sensors_tp_crc_valid(dev_data->prom,
-				     MS_SENSORS_TP_PROM_WORDS_NB + 1)) {
+	if (!ms_sensors_tp_crc_valid(dev_data->prom)) {
 		dev_err(&dev_data->client->dev,
 			"Calibration coefficients crc check error\n");
 		return -ENODEV;
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
index f4a88148c113..f15b973f27c6 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
@@ -11,7 +11,7 @@
 #include <linux/i2c.h>
 #include <linux/mutex.h>
 
-#define MS_SENSORS_TP_PROM_WORDS_NB		7
+#define MS_SENSORS_TP_PROM_WORDS_NB		8
 
 /**
  * struct ms_ht_dev - Humidity/Temperature sensor device structure
@@ -47,7 +47,7 @@ struct ms_tp_dev {
 	struct i2c_client *client;
 	struct mutex lock;
 	const struct ms_tp_hw_data *hw;
-	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB + 1];
+	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB];
 	u8 res_index;
 };
 
-- 
2.28.0

