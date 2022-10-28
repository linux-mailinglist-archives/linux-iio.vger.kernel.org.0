Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0F8610F96
	for <lists+linux-iio@lfdr.de>; Fri, 28 Oct 2022 13:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJ1LX7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Oct 2022 07:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJ1LX6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Oct 2022 07:23:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEADD1B157B
        for <linux-iio@vger.kernel.org>; Fri, 28 Oct 2022 04:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73070B803F6
        for <linux-iio@vger.kernel.org>; Fri, 28 Oct 2022 11:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984E0C433D6;
        Fri, 28 Oct 2022 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666956234;
        bh=MquIsTLN7galM2kTQ5pTGrE+6Z0endcrmpY5698CXj8=;
        h=From:To:Cc:Subject:Date:From;
        b=LC2tvEFjk/Cz6in/Z9YYTFohqHvMH6vcCL+BSP2law0h1uxjbuLGguuOOEeyu8r7k
         V1WOVD/OS+6F8dRYC4zcd+xRfod9cZirm01rznBtp1lC6BZOZB4hY4iH5WPoUz4D/B
         VCkUpyT536Xmxeb7zO2Wy37eQ+EryDI+xxvdDjIVFkwh4a33y6OXb4cxENPF4B/ysz
         ekx+DON9bdE1/aLJYJZ49OL2fST4xYZHmQy3zhuLwujBytY/0QM4f3u+oo69BbYALp
         pN8pd7IvRL3nO/dcDHxns+xbpE1JoNt5RYCqKErFR8chujAenz0+gQPEJWFhu+Yvsu
         cVaTTGlgYVKBQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com
Subject: [PATCH] iio: imu: st_lsm6dsx: introduce sw trigger support
Date:   Fri, 28 Oct 2022 13:23:42 +0200
Message-Id: <93ae6ff1150b531a9d7a4d3d1b1adb8383613717.1666955685.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are some hw configuration where irq0 and/or irq1 pins are not
connected to the SPI or I2C/I3C controller. In order to avoid polling
the output register introduce iio-sw trigger support when irq line is
not available (or hw FIFO is not supported).

Suggested-by: Mario Tesi <mario.tesi@st.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 78 ++++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c |  4 +-
 3 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 07ad8027de73..6399b0bb6f67 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -424,7 +424,7 @@ struct st_lsm6dsx_hw {
 	struct {
 		__le16 channels[3];
 		s64 ts __aligned(8);
-	} scan[3];
+	} scan[ST_LSM6DSX_ID_MAX];
 };
 
 static __maybe_unused const struct iio_event_spec st_lsm6dsx_event = {
@@ -456,6 +456,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val);
 int st_lsm6dsx_shub_probe(struct st_lsm6dsx_hw *hw, const char *name);
 int st_lsm6dsx_shub_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable);
+int st_lsm6dsx_shub_read_output(struct st_lsm6dsx_hw *hw, u8 *data, int len);
 int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable);
 
 static inline int
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index fe5fa08b68ac..73fd5f038375 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -53,6 +53,8 @@
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/minmax.h>
@@ -2117,6 +2119,32 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
 }
 
+static irqreturn_t st_lsm6dsx_sw_trigger_handler_thread(int irq,
+							void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *iio_dev = pf->indio_dev;
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+
+	if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
+	    sensor->id == ST_LSM6DSX_ID_EXT1 ||
+	    sensor->id == ST_LSM6DSX_ID_EXT2)
+		st_lsm6dsx_shub_read_output(hw,
+					    (u8 *)hw->scan[sensor->id].channels,
+					    sizeof(hw->scan[sensor->id].channels));
+	else
+		st_lsm6dsx_read_locked(hw, iio_dev->channels[0].address,
+				       hw->scan[sensor->id].channels,
+				       sizeof(hw->scan[sensor->id].channels));
+
+	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan[sensor->id],
+					   iio_get_time_ns(iio_dev));
+	iio_trigger_notify_done(iio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 {
 	struct st_sensors_platform_data *pdata;
@@ -2175,6 +2203,46 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 	return 0;
 }
 
+static int st_lsm6dsx_sw_buffer_preenable(struct iio_dev *iio_dev)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+
+	return st_lsm6dsx_device_set_enable(sensor, true);
+}
+
+static int st_lsm6dsx_sw_buffer_postdisable(struct iio_dev *iio_dev)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+
+	return st_lsm6dsx_device_set_enable(sensor, false);
+}
+
+static const struct iio_buffer_setup_ops st_lsm6dsx_sw_buffer_ops = {
+	.preenable = st_lsm6dsx_sw_buffer_preenable,
+	.postdisable = st_lsm6dsx_sw_buffer_postdisable,
+};
+
+static int st_lsm6dsx_sw_buffers_setup(struct st_lsm6dsx_hw *hw)
+{
+	int i;
+
+	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		int err;
+
+		if (!hw->iio_devs[i])
+			continue;
+
+		err = devm_iio_triggered_buffer_setup(hw->dev,
+					hw->iio_devs[i], NULL,
+					st_lsm6dsx_sw_trigger_handler_thread,
+					&st_lsm6dsx_sw_buffer_ops);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int st_lsm6dsx_init_regulators(struct device *dev)
 {
 	/* vdd-vddio power regulators */
@@ -2255,6 +2323,16 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
+	if (!hw->irq || !hw->settings->fifo_ops.read_fifo) {
+		/*
+		 * Rely on sw triggers (e.g. hr-timers) if irq pin is not
+		 * connected of if the device does not support HW FIFO
+		 */
+		err = st_lsm6dsx_sw_buffers_setup(hw);
+		if (err)
+			return err;
+	}
+
 	err = iio_read_mount_matrix(hw->dev, &hw->orientation);
 	if (err)
 		return err;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 99562ba85ee4..f2b64b4956a3 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -170,9 +170,7 @@ static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
  *
  * Read st_lsm6dsx i2c controller register
  */
-static int
-st_lsm6dsx_shub_read_output(struct st_lsm6dsx_hw *hw, u8 *data,
-			    int len)
+int st_lsm6dsx_shub_read_output(struct st_lsm6dsx_hw *hw, u8 *data, int len)
 {
 	const struct st_lsm6dsx_shub_settings *hub_settings;
 	int err;
-- 
2.37.3

