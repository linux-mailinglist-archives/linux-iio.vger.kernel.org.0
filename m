Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33ECB184E09
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 18:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMRzM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 13:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMRzM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 13:55:12 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C14F72072C;
        Fri, 13 Mar 2020 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584122112;
        bh=ge8lmYNtgcb053ddtWuR1OxdgckAbYZyxxLxK6mEyY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJO1L4O6RM9J+C0hVV6Tb7upwn7+ZImoMjvCcUEY0E+xhQ2iITNq0skY8hepCU3fz
         pRgvuA20vhOD3n4SjhRXZYVo0SKJmsMSh9JLlPATuT+me3rWGiijC2zuu6GUY9hip/
         ObtdS+kYkXZtF9kVwWd5AEgZOOPZ750fI577Stok=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, mario.tesi@st.com, denis.ciocca@st.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 2/2] iio: imu: st_lsm6dsx: specify slave odr in slv_odr
Date:   Fri, 13 Mar 2020 18:54:42 +0100
Message-Id: <b24597a5efda4c9d611b59eff18abaaf73bf5e35.1584121852.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584121851.git.lorenzo@kernel.org>
References: <cover.1584121851.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce slv_odr in ext_info data structure in order to distinguish
between sensor hub trigger (accel sensor) odr and i2c slave odr and
properly compute samples in FIFO pattern

Fixes: e485e2a2cfd6 ("iio: imu: st_lsm6dsx: enable sensor-hub support for lsm6dsm")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 29 +++++++++++++++-----
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index e9e756b1e92f..41cb20cb3809 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -357,6 +357,7 @@ struct st_lsm6dsx_sensor {
 
 	struct {
 		const struct st_lsm6dsx_ext_dev_settings *settings;
+		u32 slv_odr;
 		u8 addr;
 	} ext_info;
 };
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 95ddd19d1aa7..64ef07a30726 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -421,7 +421,8 @@ int st_lsm6dsx_shub_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
 
 	settings = sensor->ext_info.settings;
 	if (enable) {
-		err = st_lsm6dsx_shub_set_odr(sensor, sensor->odr);
+		err = st_lsm6dsx_shub_set_odr(sensor,
+					      sensor->ext_info.slv_odr);
 		if (err < 0)
 			return err;
 	} else {
@@ -459,7 +460,7 @@ st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	delay = 1000000000 / sensor->odr;
+	delay = 1000000000 / sensor->ext_info.slv_odr;
 	usleep_range(delay, 2 * delay);
 
 	len = min_t(int, sizeof(data), ch->scan_type.realbits >> 3);
@@ -500,8 +501,8 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
 		iio_device_release_direct_mode(iio_dev);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = sensor->odr / 1000;
-		*val2 = (sensor->odr % 1000) * 1000;
+		*val = sensor->ext_info.slv_odr / 1000;
+		*val2 = (sensor->ext_info.slv_odr % 1000) * 1000;
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	case IIO_CHAN_INFO_SCALE:
@@ -535,8 +536,20 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 
 		val = val * 1000 + val2 / 1000;
 		err = st_lsm6dsx_shub_get_odr_val(sensor, val, &data);
-		if (!err)
-			sensor->odr = val;
+		if (!err) {
+			struct st_lsm6dsx_hw *hw = sensor->hw;
+			struct st_lsm6dsx_sensor *ref_sensor;
+			u8 odr_val;
+			int odr;
+
+			ref_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
+			odr = st_lsm6dsx_check_odr(ref_sensor, val, &odr_val);
+			if (odr < 0)
+				return odr;
+
+			sensor->ext_info.slv_odr = val;
+			sensor->odr = odr;
+		}
 		break;
 	}
 	default:
@@ -613,6 +626,7 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 			     const struct st_lsm6dsx_ext_dev_settings *info,
 			     u8 i2c_addr, const char *name)
 {
+	enum st_lsm6dsx_sensor_id ref_id = ST_LSM6DSX_ID_ACC;
 	struct iio_chan_spec *ext_channels;
 	struct st_lsm6dsx_sensor *sensor;
 	struct iio_dev *iio_dev;
@@ -628,7 +642,8 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	sensor = iio_priv(iio_dev);
 	sensor->id = id;
 	sensor->hw = hw;
-	sensor->odr = info->odr_table.odr_avl[0].milli_hz;
+	sensor->odr = hw->settings->odr_table[ref_id].odr_avl[0].milli_hz;
+	sensor->ext_info.slv_odr = info->odr_table.odr_avl[0].milli_hz;
 	sensor->gain = info->fs_table.fs_avl[0].gain;
 	sensor->ext_info.settings = info;
 	sensor->ext_info.addr = i2c_addr;
-- 
2.24.1

