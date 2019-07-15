Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED869E72
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 23:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfGOVmb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 17:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbfGOVmb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Jul 2019 17:42:31 -0400
Received: from localhost.localdomain (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 577302171F;
        Mon, 15 Jul 2019 21:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563226951;
        bh=GQdv/+FfE7T800zTAM0w9CDzQbAMj7311vojM6W6BFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9KnNsKdPxNnTUoxt/Jf+HPRjtlrfIUblwfoIhfOoc2IfgY3IBQfdYpodA95nLfHv
         yTLo3To6HspLij/bdoNBVjyaBBq1BYNLA6E8WEh8+0BmSKbr/CgvtX+v/jS2+dMFtt
         EqYcBVVzMvW+4xLa0xTclu0PoV/x8NsKtE2deO6c=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm
Subject: [PATCH 3/3] iio: imu: st_lsm6dsx: inline acc/gyro output regs
Date:   Mon, 15 Jul 2019 23:42:11 +0200
Message-Id: <ee4a6be25cc7cf59d90de1b8a463d5908b282ebe.1563226641.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563226641.git.lorenzo@kernel.org>
References: <cover.1563226641.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove output register definitions and inline register values since
they are used only for iio channel definitions. This is a preliminary
patch to add support for LSM9DS1 sensor to st_lsm6dsx driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 26 +++++---------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 9aa109428a52..0abd5b85b398 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -61,14 +61,6 @@
 #define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
 #define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
 
-#define ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR		0x28
-#define ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR		0x2a
-#define ST_LSM6DSX_REG_ACC_OUT_Z_L_ADDR		0x2c
-
-#define ST_LSM6DSX_REG_GYRO_OUT_X_L_ADDR	0x22
-#define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
-#define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
-
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
 		.wai = 0x69,
@@ -701,22 +693,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 };
 
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
-	ST_LSM6DSX_CHANNEL(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR,
-			   IIO_MOD_X, 0),
-	ST_LSM6DSX_CHANNEL(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR,
-			   IIO_MOD_Y, 1),
-	ST_LSM6DSX_CHANNEL(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_Z_L_ADDR,
-			   IIO_MOD_Z, 2),
+	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
+	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
+	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
-	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM6DSX_REG_GYRO_OUT_X_L_ADDR,
-			   IIO_MOD_X, 0),
-	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR,
-			   IIO_MOD_Y, 1),
-	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR,
-			   IIO_MOD_Z, 2),
+	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x22, IIO_MOD_X, 0),
+	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x24, IIO_MOD_Y, 1),
+	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x26, IIO_MOD_Z, 2),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
-- 
2.21.0

