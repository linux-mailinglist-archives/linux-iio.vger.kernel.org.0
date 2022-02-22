Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96714BF0DF
	for <lists+linux-iio@lfdr.de>; Tue, 22 Feb 2022 05:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiBVEW0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Feb 2022 23:22:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiBVEWY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 23:22:24 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB09889330
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 20:15:45 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7423B2023D2;
        Tue, 22 Feb 2022 05:15:44 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 11ABA2023E6;
        Tue, 22 Feb 2022 05:15:44 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EF19F183AC96;
        Tue, 22 Feb 2022 12:15:42 +0800 (+08)
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Cc:     haibo.chen@nxp.com, linux-imx@nxp.com
Subject: [PATCH] iio: imu: fxos8700: few bug fix for fxos8700
Date:   Tue, 22 Feb 2022 12:07:02 +0800
Message-Id: <1645502822-5585-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

1, z raw data always 0, regmap_buk_read use the wrong length. fix it
and optmize read the only need data.
2, use the correct register address when try to read raw data.
3, before set scale, need to set the sensor to standby mode. otherwise
the scale set is not work.
4, give the correct offset when config odr bit.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/iio/imu/fxos8700_core.c | 66 +++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index ab288186f36e..1896d6db6d77 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -162,12 +162,11 @@
 
 #define FXOS8700_DEVICE_ID          0xC7
 #define FXOS8700_PRE_DEVICE_ID      0xC4
-#define FXOS8700_DATA_BUF_SIZE      3
 
 struct fxos8700_data {
 	struct regmap *regmap;
 	struct iio_trigger *trig;
-	__be16 buf[FXOS8700_DATA_BUF_SIZE] ____cacheline_aligned;
+	__be16 buf ____cacheline_aligned;
 };
 
 /* Regmap info */
@@ -345,7 +344,8 @@ static int fxos8700_set_active_mode(struct fxos8700_data *data,
 static int fxos8700_set_scale(struct fxos8700_data *data,
 			      enum fxos8700_sensor t, int uscale)
 {
-	int i;
+	int i, ret, val;
+	bool active_mode;
 	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
 	struct device *dev = regmap_get_device(data->regmap);
 
@@ -354,6 +354,23 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
 		return -EINVAL;
 	}
 
+	ret = regmap_read(data->regmap, FXOS8700_CTRL_REG1, &val);
+	if (ret)
+		return ret;
+
+	active_mode = val & FXOS8700_ACTIVE;
+
+	if (active_mode) {
+		/*
+		 * The device must be in standby mode to change any of the
+		 * other fields within CTRL_REG1
+		 */
+		ret = regmap_write(data->regmap, FXOS8700_CTRL_REG1,
+				   val & ~FXOS8700_ACTIVE);
+		if (ret)
+			return ret;
+	}
+
 	for (i = 0; i < scale_num; i++)
 		if (fxos8700_accel_scale[i].uscale == uscale)
 			break;
@@ -361,8 +378,12 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
 	if (i == scale_num)
 		return -EINVAL;
 
-	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
+	ret = regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
 			    fxos8700_accel_scale[i].bits);
+	if (ret)
+		return ret;
+	return regmap_update_bits(data->regmap, FXOS8700_CTRL_REG1,
+				  FXOS8700_ACTIVE, active_mode);
 }
 
 static int fxos8700_get_scale(struct fxos8700_data *data,
@@ -393,23 +414,29 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
 static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
 			     int axis, int *val)
 {
-	u8 base, reg;
-	int ret;
+	u8 base, offset;
 	enum fxos8700_sensor type = fxos8700_to_sensor(chan_type);
+	u8 tmp_data[2];
+	u16 native_data;
+	int ret;
 
-	base = type ? FXOS8700_OUT_X_MSB : FXOS8700_M_OUT_X_MSB;
+	base = type ? FXOS8700_M_OUT_X_MSB : FXOS8700_OUT_X_MSB;
+	offset = axis - IIO_MOD_X;
 
-	/* Block read 6 bytes of device output registers to avoid data loss */
-	ret = regmap_bulk_read(data->regmap, base, data->buf,
-			       FXOS8700_DATA_BUF_SIZE);
+	ret = regmap_bulk_read(data->regmap, base + offset, &tmp_data[0], 2);
 	if (ret)
-		return ret;
+		return -EIO;
 
-	/* Convert axis to buffer index */
-	reg = axis - IIO_MOD_X;
 
+	data->buf = ((tmp_data[1] << 8) & 0xff00) | tmp_data[0];
 	/* Convert to native endianness */
-	*val = sign_extend32(be16_to_cpu(data->buf[reg]), 15);
+	native_data = be16_to_cpu(data->buf);
+
+	/*accel raw data only has 14 bit */
+	if (!type)
+		native_data = native_data >> 2;
+
+	*val = sign_extend32(native_data, 15);
 
 	return 0;
 }
@@ -462,6 +489,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
 		return ret;
 
 	val &= FXOS8700_CTRL_ODR_MSK;
+	val = val >> 3;
 
 	for (i = 0; i < odr_num; i++)
 		if (val == fxos8700_odr[i].bits)
@@ -592,14 +620,14 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
 	if (ret)
 		return ret;
 
-	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
-	ret = regmap_write(data->regmap, FXOS8700_CTRL_REG1,
-			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
+	/* Set for max full-scale range (+/-8G) */
+	ret = regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG, MODE_8G);
 	if (ret)
 		return ret;
 
-	/* Set for max full-scale range (+/-8G) */
-	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG, MODE_8G);
+	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
+	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
+			   FXOS8700_CTRL_ODR_MAX << 3 | FXOS8700_ACTIVE);
 }
 
 static void fxos8700_chip_uninit(void *data)
-- 
2.25.1

