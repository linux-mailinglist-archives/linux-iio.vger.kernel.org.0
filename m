Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA251B7252
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 12:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgDXKov (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 06:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDXKov (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 Apr 2020 06:44:51 -0400
Received: from localhost.localdomain.com (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 644442064A;
        Fri, 24 Apr 2020 10:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587725091;
        bh=+R2L3PyZ1c0qeAYGVTviJHhvMvp7aZu4jg8HcUQIxik=;
        h=From:To:Cc:Subject:Date:From;
        b=lDieJtnK5sBnVROL94l8iqTlC+HhjrGh1FfdrK9ySG0khZRg8nwQxhGPBLQ4WUpAN
         +0lmWm1C81+cAQU7tH7Fmu5lVkWVdVX+035VY12OqLpejuZhcrJhqWlJQR3lbyzePk
         bwkt9A3dopwYfdHEJ9dt92OqiM03u3FxgDEtDFxA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] iio: imu: st_lsm6dsx: enable 833Hz sample frequency for tagged sensors
Date:   Fri, 24 Apr 2020 12:44:38 +0200
Message-Id: <81e5660e7b7755346efefdd90f721a4b0cd63726.1587724988.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable 833Hz ODR for sensors that supports tagged hw FIFO:
- LSM6DSO/LSM6DSOX
- LSM6DSR/LSM6DSRX
- ASM330LHH

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 21 +++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 84d219ae6aee..e6339bbb4469 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -27,7 +27,8 @@
  *   - FIFO size: 4KB
  *
  * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX:
- *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
+ *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416,
+ *     833
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 3KB
@@ -791,7 +792,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104000, 0x04 },
 				.odr_avl[4] = { 208000, 0x05 },
 				.odr_avl[5] = { 416000, 0x06 },
-				.odr_len = 6,
+				.odr_avl[6] = { 833000, 0x07 },
+				.odr_len = 7,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -804,7 +806,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104000, 0x04 },
 				.odr_avl[4] = { 208000, 0x05 },
 				.odr_avl[5] = { 416000, 0x06 },
-				.odr_len = 6,
+				.odr_avl[6] = { 833000, 0x07 },
+				.odr_len = 7,
 			},
 		},
 		.fs_table = {
@@ -994,7 +997,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104000, 0x04 },
 				.odr_avl[4] = { 208000, 0x05 },
 				.odr_avl[5] = { 416000, 0x06 },
-				.odr_len = 6,
+				.odr_avl[6] = { 833000, 0x07 },
+				.odr_len = 7,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -1007,7 +1011,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104000, 0x04 },
 				.odr_avl[4] = { 208000, 0x05 },
 				.odr_avl[5] = { 416000, 0x06 },
-				.odr_len = 6,
+				.odr_avl[6] = { 833000, 0x07 },
+				.odr_len = 7,
 			},
 		},
 		.fs_table = {
@@ -1171,7 +1176,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104000, 0x04 },
 				.odr_avl[4] = { 208000, 0x05 },
 				.odr_avl[5] = { 416000, 0x06 },
-				.odr_len = 6,
+				.odr_avl[6] = { 833000, 0x07 },
+				.odr_len = 7,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -1184,7 +1190,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104000, 0x04 },
 				.odr_avl[4] = { 208000, 0x05 },
 				.odr_avl[5] = { 416000, 0x06 },
-				.odr_len = 6,
+				.odr_avl[6] = { 833000, 0x07 },
+				.odr_len = 7,
 			},
 		},
 		.fs_table = {
-- 
2.25.3

