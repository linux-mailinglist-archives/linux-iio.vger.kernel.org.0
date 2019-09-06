Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70682AB7F3
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2019 14:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391962AbfIFMR0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Sep 2019 08:17:26 -0400
Received: from first.geanix.com ([116.203.34.67]:41562 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731749AbfIFMRZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Sep 2019 08:17:25 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id E316B6371D;
        Fri,  6 Sep 2019 12:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567772227; bh=rrRJl3GUBUJX7tM8bIZ7W7uPntFaIYwVdA91itbjIxs=;
        h=From:To:Cc:Subject:Date;
        b=BTFTFJUGM9ntDgDGadn94wgd40Vu+pfrfxI/CzVvMIFwo0d8/jch2xWYymF0UJP4W
         LIu0SmY145aRg0XMKq9Tmd8iiATfrQMvGf/pcSjj6PhEdJ0CXhN4VnhOtQPVY0XF54
         FhPm7zrbRRFqJexIJY8l6a23uQnvg1+rEnUGFy8NYjh5WA4c0ltVViZ9GCbOtFHRdT
         Ewze0LHht+xo/ylWnj0nyDMw/w2A341emWXlwWcmuptlfn6+dTKab8SH5DkFp2VrZc
         eveFrrVMGQ8yFLjr4CNzPfnP0gF3zqxWEOQ1qyW5XdyD9Z9mbYsXU9cHtN4yx2wO3W
         YdRLOau/5i64g==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v4 1/6] iio: imu: st_lsm6dsx: move interrupt thread to core
Date:   Fri,  6 Sep 2019 14:17:11 +0200
Message-Id: <20190906121716.66194-1-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=4.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This prepares the interrupt to be used for other stuff than
fifo reading + event readings.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 78 +---------------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 88 +++++++++++++++++++
 2 files changed, 89 insertions(+), 77 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index b0f3da1976e4..ef579650fd52 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -30,8 +30,6 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 #include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -42,10 +40,6 @@
 
 #include "st_lsm6dsx.h"
 
-#define ST_LSM6DSX_REG_HLACTIVE_ADDR		0x12
-#define ST_LSM6DSX_REG_HLACTIVE_MASK		BIT(5)
-#define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
-#define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
 #define ST_LSM6DSX_REG_FIFO_MODE_ADDR		0x0a
 #define ST_LSM6DSX_FIFO_MODE_MASK		GENMASK(2, 0)
 #define ST_LSM6DSX_FIFO_ODR_MASK		GENMASK(6, 3)
@@ -654,25 +648,6 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
 	return err;
 }
 
-static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
-{
-	struct st_lsm6dsx_hw *hw = private;
-
-	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
-}
-
-static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
-{
-	struct st_lsm6dsx_hw *hw = private;
-	int count;
-
-	mutex_lock(&hw->fifo_lock);
-	count = hw->settings->fifo_ops.read_fifo(hw);
-	mutex_unlock(&hw->fifo_lock);
-
-	return count ? IRQ_HANDLED : IRQ_NONE;
-}
-
 static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
@@ -702,59 +677,8 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
 
 int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 {
-	struct device_node *np = hw->dev->of_node;
-	struct st_sensors_platform_data *pdata;
 	struct iio_buffer *buffer;
-	unsigned long irq_type;
-	bool irq_active_low;
-	int i, err;
-
-	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
-
-	switch (irq_type) {
-	case IRQF_TRIGGER_HIGH:
-	case IRQF_TRIGGER_RISING:
-		irq_active_low = false;
-		break;
-	case IRQF_TRIGGER_LOW:
-	case IRQF_TRIGGER_FALLING:
-		irq_active_low = true;
-		break;
-	default:
-		dev_info(hw->dev, "mode %lx unsupported\n", irq_type);
-		return -EINVAL;
-	}
-
-	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_HLACTIVE_ADDR,
-				 ST_LSM6DSX_REG_HLACTIVE_MASK,
-				 FIELD_PREP(ST_LSM6DSX_REG_HLACTIVE_MASK,
-					    irq_active_low));
-	if (err < 0)
-		return err;
-
-	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
-	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
-	    (pdata && pdata->open_drain)) {
-		err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_PP_OD_ADDR,
-					 ST_LSM6DSX_REG_PP_OD_MASK,
-					 FIELD_PREP(ST_LSM6DSX_REG_PP_OD_MASK,
-						    1));
-		if (err < 0)
-			return err;
-
-		irq_type |= IRQF_SHARED;
-	}
-
-	err = devm_request_threaded_irq(hw->dev, hw->irq,
-					st_lsm6dsx_handler_irq,
-					st_lsm6dsx_handler_thread,
-					irq_type | IRQF_ONESHOT,
-					"lsm6dsx", hw);
-	if (err) {
-		dev_err(hw->dev, "failed to request trigger irq %d\n",
-			hw->irq);
-		return err;
-	}
+	int i;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
 		if (!hw->iio_devs[i])
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 2d3495560136..d0bcbbfb6297 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -50,6 +50,8 @@
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/bitfield.h>
@@ -65,6 +67,11 @@
 #define ST_LSM6DSX_REG_BDU_ADDR			0x12
 #define ST_LSM6DSX_REG_BDU_MASK			BIT(6)
 
+#define ST_LSM6DSX_REG_HLACTIVE_ADDR		0x12
+#define ST_LSM6DSX_REG_HLACTIVE_MASK		BIT(5)
+#define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
+#define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
+
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
 	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
 	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
@@ -1466,6 +1473,83 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	return iio_dev;
 }
 
+static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
+{
+	struct st_lsm6dsx_hw *hw = private;
+
+	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
+}
+
+static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
+{
+	struct st_lsm6dsx_hw *hw = private;
+	int count;
+
+	mutex_lock(&hw->fifo_lock);
+	count = hw->settings->fifo_ops.read_fifo(hw);
+	mutex_unlock(&hw->fifo_lock);
+
+	return count ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
+{
+	struct st_sensors_platform_data *pdata;
+	struct device_node *np = hw->dev->of_node;
+	unsigned long irq_type;
+	bool irq_active_low;
+	int err;
+
+	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_HIGH:
+	case IRQF_TRIGGER_RISING:
+		irq_active_low = false;
+		break;
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_FALLING:
+		irq_active_low = true;
+		break;
+	default:
+		dev_info(hw->dev, "mode %lx unsupported\n", irq_type);
+		return -EINVAL;
+	}
+
+	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_HLACTIVE_ADDR,
+				 ST_LSM6DSX_REG_HLACTIVE_MASK,
+				 FIELD_PREP(ST_LSM6DSX_REG_HLACTIVE_MASK,
+					    irq_active_low));
+	if (err < 0)
+		return err;
+
+	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
+	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
+	    (pdata && pdata->open_drain)) {
+		err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_PP_OD_ADDR,
+					 ST_LSM6DSX_REG_PP_OD_MASK,
+					 FIELD_PREP(ST_LSM6DSX_REG_PP_OD_MASK,
+						    1));
+		if (err < 0)
+			return err;
+
+		irq_type |= IRQF_SHARED;
+	}
+
+	err = devm_request_threaded_irq(hw->dev, hw->irq,
+					st_lsm6dsx_handler_irq,
+					st_lsm6dsx_handler_thread,
+					irq_type | IRQF_ONESHOT,
+					"lsm6dsx", hw);
+	if (err) {
+		dev_err(hw->dev, "failed to request trigger irq %d\n",
+			hw->irq);
+		return err;
+	}
+
+	return 0;
+}
+
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap)
 {
@@ -1514,6 +1598,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 	}
 
 	if (hw->irq > 0) {
+		err = st_lsm6dsx_irq_setup(hw);
+		if (err < 0)
+			return err;
+
 		err = st_lsm6dsx_fifo_setup(hw);
 		if (err < 0)
 			return err;
-- 
2.23.0

