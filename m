Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B0112F6C1
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2020 11:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgACKdA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jan 2020 05:33:00 -0500
Received: from comms.puri.sm ([159.203.221.185]:42440 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgACKc7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Jan 2020 05:32:59 -0500
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jan 2020 05:32:59 EST
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id DCE6CE031B;
        Fri,  3 Jan 2020 02:27:10 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BrXUx_jgwVQu; Fri,  3 Jan 2020 02:27:09 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] iio: imu: st_lsm6dsx: add mount matrix support
Date:   Fri,  3 Jan 2020 11:26:30 +0100
Message-Id: <20200103102630.17109-1-martin.kepplinger@puri.sm>
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



 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 18 ++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index a763ff46f596..8483f770b233 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -76,6 +76,7 @@ enum st_lsm6dsx_hw_id {
 		.endianness = IIO_LE,					\
 	},								\
 	.event_spec = &st_lsm6dsx_event,				\
+	.ext_info = st_lsm6dsx_accel_ext_info,				\
 	.num_event_specs = 1,						\
 }
 
@@ -406,6 +407,8 @@ struct st_lsm6dsx_hw {
 	struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
 
 	const struct st_lsm6dsx_settings *settings;
+
+	struct iio_mount_matrix orientation;
 };
 
 static __maybe_unused const struct iio_event_spec st_lsm6dsx_event = {
@@ -479,4 +482,19 @@ st_lsm6dsx_write_locked(struct st_lsm6dsx_hw *hw, unsigned int addr,
 	return err;
 }
 
+static const struct iio_mount_matrix *
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
index 0c64e35c7599..587e02bb9be9 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2325,6 +2325,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 	    (pdata && pdata->wakeup_source))
 		device_init_wakeup(dev, true);
 
+	err = iio_read_mount_matrix(hw->dev, "mount-matrix", &hw->orientation);
+	if (err)
+		return err;
+
 	return 0;
 }
 EXPORT_SYMBOL(st_lsm6dsx_probe);
-- 
2.20.1

