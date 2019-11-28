Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12E10CC39
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2019 16:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfK1Pzd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Nov 2019 10:55:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfK1Pzd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Nov 2019 10:55:33 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613092178F;
        Thu, 28 Nov 2019 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574956532;
        bh=ind/PGMhzdOfbmx0QdiY5HWec/UEFbdozcyI4GvD2n4=;
        h=From:To:Cc:Subject:Date:From;
        b=s/jMsz/IgcyHsFUOFCf2xtuYiJfOxhrwNEzxlbE8O7NanxIAK6wF0nsOX2fi7xPW8
         9r2Fo4g8WI7FwROZxLQWeJin3Dr6nZtRdSBgaxbQgZDCqXSc5mDUfxSWlKrwjpllUo
         chofdiGfBunVpK9O1q0qjdx+gizBmeaOdJm1IVlE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, mario.tesi@st.com,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: fix decimation factor estimation
Date:   Thu, 28 Nov 2019 17:55:18 +0200
Message-Id: <6d08e5a80bb0c49eb96dc883ff1ed2936f142bbb.1574956387.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix decimation factor and sip estimation for LSM6DSM series
(max value for decimation factor is 32).
If gyro and accel sensors are enabled at 12.5Hz and 416Hz
respectively, decimation factor lookup will fail, producing
unaligned data.
Remove unused decimator filed in st_lsm6dsx_sensor structure.

Fixes: f8710f0357bc ("iio: imu: st_lsm6dsx: express odr in mHZ")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 --
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 25 +++++++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index b54aefcdaad4..dc55d7dff3eb 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -320,7 +320,6 @@ enum st_lsm6dsx_fifo_mode {
  * @odr: Output data rate of the sensor [Hz].
  * @watermark: Sensor watermark level.
  * @sip: Number of samples in a given pattern.
- * @decimator: FIFO decimation factor.
  * @ts_ref: Sensor timestamp reference for hw one.
  * @ext_info: Sensor settings if it is connected to i2c controller
  */
@@ -334,7 +333,6 @@ struct st_lsm6dsx_sensor {
 
 	u16 watermark;
 	u8 sip;
-	u8 decimator;
 	s64 ts_ref;
 
 	struct {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index bfd4c6306c0b..cb536b81a1c2 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -78,14 +78,20 @@ struct st_lsm6dsx_decimator_entry st_lsm6dsx_decimator_table[] = {
 	{ 32, 0x7 },
 };
 
-static int st_lsm6dsx_get_decimator_val(u8 val)
+static int
+st_lsm6dsx_get_decimator_val(struct st_lsm6dsx_sensor *sensor, u32 max_odr)
 {
 	const int max_size = ARRAY_SIZE(st_lsm6dsx_decimator_table);
+	u32 decimator =  max_odr / sensor->odr;
 	int i;
 
-	for (i = 0; i < max_size; i++)
-		if (st_lsm6dsx_decimator_table[i].decimator == val)
+	if (decimator > 1)
+		decimator = round_down(decimator, 2);
+
+	for (i = 0; i < max_size; i++) {
+		if (st_lsm6dsx_decimator_table[i].decimator == decimator)
 			break;
+	}
 
 	return i == max_size ? 0 : st_lsm6dsx_decimator_table[i].val;
 }
@@ -111,6 +117,13 @@ static void st_lsm6dsx_get_max_min_odr(struct st_lsm6dsx_hw *hw,
 	}
 }
 
+static u8 st_lsm6dsx_get_sip(struct st_lsm6dsx_sensor *sensor, u32 min_odr)
+{
+	u8 sip = sensor->odr / min_odr;
+
+	return sip > 1 ? round_down(sip, 2) : sip;
+}
+
 static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
 {
 	const struct st_lsm6dsx_reg *ts_dec_reg;
@@ -131,12 +144,10 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
 		sensor = iio_priv(hw->iio_devs[i]);
 		/* update fifo decimators and sample in pattern */
 		if (hw->enable_mask & BIT(sensor->id)) {
-			sensor->sip = sensor->odr / min_odr;
-			sensor->decimator = max_odr / sensor->odr;
-			data = st_lsm6dsx_get_decimator_val(sensor->decimator);
+			sensor->sip = st_lsm6dsx_get_sip(sensor, min_odr);
+			data = st_lsm6dsx_get_decimator_val(sensor, max_odr);
 		} else {
 			sensor->sip = 0;
-			sensor->decimator = 0;
 			data = 0;
 		}
 		ts_sip = max_t(u16, ts_sip, sensor->sip);
-- 
2.21.0

