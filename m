Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 784A3138EA1
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 11:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgAMKMH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 05:12:07 -0500
Received: from comms.puri.sm ([159.203.221.185]:56194 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgAMKMH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 05:12:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 52481DF98F;
        Mon, 13 Jan 2020 02:12:06 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0AKdzV64zIId; Mon, 13 Jan 2020 02:12:05 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3] iio: imu: st_lsm6dsx: add mount matrix support
Date:   Mon, 13 Jan 2020 11:11:40 +0100
Message-Id: <20200113101140.24305-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allow to read the mount-matrix device tree property and provide the
mount_matrix file for userspace to read.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

tested using the lsm9ds1 on the librem5-devkit (and userspace tools like
iio-sensor-proxy) where this will be needed.

thanks,

                                       martin

revision history
----------------
v3: fix race condition during probe(). thanks Jonathan
v2: additions and simplifications according to Lorenzo's review. thanks.


 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 19 +++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index a763ff46f596..7076fc8c4c3b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -76,6 +76,7 @@ enum st_lsm6dsx_hw_id {
 		.endianness = IIO_LE,					\
 	},								\
 	.event_spec = &st_lsm6dsx_event,				\
+	.ext_info = st_lsm6dsx_accel_ext_info,				\
 	.num_event_specs = 1,						\
 }
 
@@ -380,6 +381,7 @@ struct st_lsm6dsx_sensor {
  * @enable_event: enabled event bitmask.
  * @iio_devs: Pointers to acc/gyro iio_dev instances.
  * @settings: Pointer to the specific sensor settings in use.
+ * @orientation: sensor chip orientation relative to main hardware.
  */
 struct st_lsm6dsx_hw {
 	struct device *dev;
@@ -406,6 +408,8 @@ struct st_lsm6dsx_hw {
 	struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
 
 	const struct st_lsm6dsx_settings *settings;
+
+	struct iio_mount_matrix orientation;
 };
 
 static __maybe_unused const struct iio_event_spec st_lsm6dsx_event = {
@@ -479,4 +483,19 @@ st_lsm6dsx_write_locked(struct st_lsm6dsx_hw *hw, unsigned int addr,
 	return err;
 }
 
+static const inline struct iio_mount_matrix *
+st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
+			    const struct iio_chan_spec *chan)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+
+	return &hw->orientation;
+}
+
+static const struct iio_chan_spec_ext_info st_lsm6dsx_accel_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_lsm6dsx_get_mount_matrix),
+	{ }
+};
+
 #endif /* ST_LSM6DSX_H */
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 0c64e35c7599..6e4d0a03c8b5 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2312,6 +2312,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
+	err = iio_read_mount_matrix(hw->dev, "mount-matrix", &hw->orientation);
+	if (err)
+		return err;
+
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
 		if (!hw->iio_devs[i])
 			continue;
-- 
2.20.1

