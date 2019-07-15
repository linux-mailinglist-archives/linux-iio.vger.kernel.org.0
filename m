Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B213268500
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 10:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfGOIPZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 04:15:25 -0400
Received: from first.geanix.com ([116.203.34.67]:55286 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfGOIPZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Jul 2019 04:15:25 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 7149642BDB;
        Mon, 15 Jul 2019 08:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1563178499; bh=dKfSWpV7y8ack4Lk/btX6CH9aM7tl5Njcp9UW+6liQ0=;
        h=From:To:Cc:Subject:Date;
        b=NjjjotE5jZeKzDC0u/lpQ75F73ih2v2R5SVauVr+PN7bTaX+7i6LNOwYhi88nIYuF
         kbtK3CdIdAsrcXueVb9o3tL6/1fTL6MCIEhJcZlax3lUhDd/0jT4qfpCRBHiDJF6qH
         FL11ENzTriODiVtf8ek0Cjh3n5NrbWqfdugePtlBWpPLSG6DcMSxUz88IPZQVMfvZo
         rVzlmfAAaxO20zYm5Xk2ycc9Qh+UFlC3GfxTt/T7OzR406ZQJ4bEsqIqghBWBnCGQI
         X2eGM51GeYHW8Y6Qh+vO4wTYN2b+uMQSWEL2xPiK/+nIxO5OzrvZ2HaK4f29sfphxu
         zBgKPzLcSRVQA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        martin@geanix.com
Subject: [PATCH v2 1/6] iio: imu: st_lsm6dsx: move interrupt thread to core
Date:   Mon, 15 Jul 2019 10:15:09 +0200
Message-Id: <20190715081514.81129-1-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8945dcc0271d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This prepares the interrupt to be used for other stuff than
fifo reading + event readings.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---

Changes since v1:
 * none

 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 78 +----------------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 87 +++++++++++++++++++
 2 files changed, 88 insertions(+), 77 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 38194f4d2b7e..2b938d87ae34 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -29,8 +29,6 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 #include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -41,10 +39,6 @@
 
 #include "st_lsm6dsx.h"
 
-#define ST_LSM6DSX_REG_HLACTIVE_ADDR		0x12
-#define ST_LSM6DSX_REG_HLACTIVE_MASK		BIT(5)
-#define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
-#define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
 #define ST_LSM6DSX_REG_FIFO_MODE_ADDR		0x0a
 #define ST_LSM6DSX_FIFO_MODE_MASK		GENMASK(2, 0)
 #define ST_LSM6DSX_FIFO_ODR_MASK		GENMASK(6, 3)
@@ -654,25 +648,6 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
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
-	return !count ? IRQ_NONE : IRQ_HANDLED;
-}
-
 static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
 {
 	return st_lsm6dsx_update_fifo(iio_dev, true);
@@ -690,59 +665,8 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
 
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
index d8c4417cf4eb..e67341802fc6 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -41,6 +41,8 @@
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/bitfield.h>
@@ -61,6 +63,11 @@
 #define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
 #define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
 
+#define ST_LSM6DSX_REG_HLACTIVE_ADDR		0x12
+#define ST_LSM6DSX_REG_HLACTIVE_MASK		BIT(5)
+#define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
+#define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
+
 #define ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR		0x28
 #define ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR		0x2a
 #define ST_LSM6DSX_REG_ACC_OUT_Z_L_ADDR		0x2c
@@ -1069,6 +1076,83 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
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
+	count = st_lsm6dsx_read_fifo(hw);
+	mutex_unlock(&hw->fifo_lock);
+
+	return !count ? IRQ_NONE : IRQ_HANDLED;
+}
+
+int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
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
+	return err;
+}
+
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap)
 {
@@ -1117,6 +1201,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 	}
 
 	if (hw->irq > 0) {
+		err = st_lsm6dsx_irq_setup(hw);
+		if (err < 0)
+			return err;
 		err = st_lsm6dsx_fifo_setup(hw);
 		if (err < 0)
 			return err;
-- 
2.22.0

