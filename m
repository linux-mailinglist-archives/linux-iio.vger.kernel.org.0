Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6A840C98C
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 18:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhIOQCB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 12:02:01 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52801 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238519AbhIOQBq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 12:01:46 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BB1C91BF204;
        Wed, 15 Sep 2021 16:00:24 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 37/47] iio: adc: ti_am335x_adc: Wait the idle state to avoid stalls
Date:   Wed, 15 Sep 2021 17:58:58 +0200
Message-Id: <20210915155908.476767-38-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

At least on a am4372, a simple:
$ cat /sys/bus/iio/devices/iio\:deviceX/in_voltage*_raw
can stall forever. It seems that it comes from the fact that the
internal state machine does not have enough time to return to its idle
state in this situation before receiving another request, leading to an
internal stall.

Add a tiadc_wait_idle() helper to ensure no new conversion is requested
while the FSM is still busy.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 1cc2efbb2875..0a4d66a541ed 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/iio/machine.h>
 #include <linux/iio/driver.h>
+#include <linux/iopoll.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 #include <linux/iio/buffer.h>
@@ -102,6 +103,15 @@ static u32 get_adc_step_bit(struct tiadc_device *adc_dev, int chan)
 	return 1 << adc_dev->channel_step[chan];
 }
 
+static int tiadc_wait_idle(struct tiadc_device *adc_dev)
+{
+	u32 val;
+
+	return readl_poll_timeout(adc_dev->mfd_tscadc->tscadc_base + REG_ADCFSM,
+				  val, !(val & SEQ_STATUS), 10,
+				  IDLE_TIMEOUT * 1000 * adc_dev->channels);
+}
+
 static void tiadc_step_config(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
@@ -295,6 +305,11 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
 	int i, fifo1count;
+	int ret;
+
+	ret = tiadc_wait_idle(adc_dev);
+	if (ret)
+		return ret;
 
 	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
 				IRQENB_FIFO1OVRRUN |
@@ -446,12 +461,12 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 		int *val, int *val2, long mask)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
-	int ret = IIO_VAL_INT;
 	int i, map_val;
 	unsigned int fifo1count, read, stepid;
 	bool found = false;
 	u32 step_en;
 	unsigned long timeout;
+	int ret;
 
 	if (iio_buffer_enabled(indio_dev))
 		return -EBUSY;
@@ -461,6 +476,11 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	mutex_lock(&adc_dev->fifo1_lock);
+
+	ret = tiadc_wait_idle(adc_dev);
+	if (ret)
+		goto err_unlock;
+
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 	while (fifo1count--)
 		tiadc_readl(adc_dev, REG_FIFO1);
@@ -508,7 +528,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 
 err_unlock:
 	mutex_unlock(&adc_dev->fifo1_lock);
-	return ret;
+	return ret ? ret : IIO_VAL_INT;
 }
 
 static const struct iio_info tiadc_info = {
-- 
2.27.0

