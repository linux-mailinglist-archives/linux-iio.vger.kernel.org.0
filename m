Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89AD5F9D4F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Oct 2022 13:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJJLHs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Oct 2022 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiJJLHr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2022 07:07:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9345BC3B
        for <linux-iio@vger.kernel.org>; Mon, 10 Oct 2022 04:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1FD860DE4
        for <linux-iio@vger.kernel.org>; Mon, 10 Oct 2022 11:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADEAC433C1;
        Mon, 10 Oct 2022 11:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665400066;
        bh=lH/RZIuToKA2aYihftvPDaYHXdecpA5xlmKb7x/i5fQ=;
        h=From:To:Cc:Subject:Date:From;
        b=iBCzkrPMQjBDo7Qxllt4bS+e73Hb0J9UJ7IyHajhyiQtcrlrWRPVilUp3Kpk6+Eyq
         Hs0VTHTSBOLNxa0FhgQFt4SEm10SeC9bnpPBVnAw0dbpdtWdP2unejmHlhahkD9XhL
         ZosCplp4fppn/UMBCxpvQY059TuXRahbMdKwUwEG6s9AG3s3hFFEVjib91IL+9kmgJ
         aMgzoC0DWVGq9OBT7fbYatPwDPs0SQGzYOSTm9WSE+OO6ZsRyQURhzhBFjXlrz1iO4
         Ll+tpYrEWn6V08FfwlMrWybNOK2ag5f28ND9fsjcpPtnWY6mNjr1FWjp40aapauq5b
         rCR+SjamOhufA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] iio: imu: st_lsm6dsx: introduce st_lsm6dsx_device_set_enable routine
Date:   Mon, 10 Oct 2022 13:07:26 +0200
Message-Id: <e3fbe5d4a3bed41130908669f745f78c8505cf47.1665399959.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce st_lsm6dsx_device_set_enable utility routine and remove
duplicated code used to enable/disable sensors

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 11 +++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 14 +++-----------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 14 ++------------
 3 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 6b57d47be69e..d3a4e21bc114 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -509,6 +509,17 @@ st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
 	return &hw->orientation;
 }
 
+static inline int
+st_lsm6dsx_device_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
+{
+	if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
+	    sensor->id == ST_LSM6DSX_ID_EXT1 ||
+	    sensor->id == ST_LSM6DSX_ID_EXT2)
+		return st_lsm6dsx_shub_set_enable(sensor, enable);
+
+	return st_lsm6dsx_sensor_set_enable(sensor, enable);
+}
+
 static const
 struct iio_chan_spec_ext_info __maybe_unused st_lsm6dsx_accel_ext_info[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_lsm6dsx_get_mount_matrix),
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index e49f2d120ed3..48fe6a45671b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -673,17 +673,9 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
 			goto out;
 	}
 
-	if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
-	    sensor->id == ST_LSM6DSX_ID_EXT1 ||
-	    sensor->id == ST_LSM6DSX_ID_EXT2) {
-		err = st_lsm6dsx_shub_set_enable(sensor, enable);
-		if (err < 0)
-			goto out;
-	} else {
-		err = st_lsm6dsx_sensor_set_enable(sensor, enable);
-		if (err < 0)
-			goto out;
-	}
+	err = st_lsm6dsx_device_set_enable(sensor, enable);
+	if (err < 0)
+		goto out;
 
 	err = st_lsm6dsx_set_fifo_odr(sensor, enable);
 	if (err < 0)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index f8bbb005718e..6af2e905c161 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2317,12 +2317,7 @@ static int st_lsm6dsx_suspend(struct device *dev)
 			continue;
 		}
 
-		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
-		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
-		    sensor->id == ST_LSM6DSX_ID_EXT2)
-			err = st_lsm6dsx_shub_set_enable(sensor, false);
-		else
-			err = st_lsm6dsx_sensor_set_enable(sensor, false);
+		err = st_lsm6dsx_device_set_enable(sensor, false);
 		if (err < 0)
 			return err;
 
@@ -2353,12 +2348,7 @@ static int st_lsm6dsx_resume(struct device *dev)
 		if (!(hw->suspend_mask & BIT(sensor->id)))
 			continue;
 
-		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
-		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
-		    sensor->id == ST_LSM6DSX_ID_EXT2)
-			err = st_lsm6dsx_shub_set_enable(sensor, true);
-		else
-			err = st_lsm6dsx_sensor_set_enable(sensor, true);
+		err = st_lsm6dsx_device_set_enable(sensor, true);
 		if (err < 0)
 			return err;
 
-- 
2.37.3

