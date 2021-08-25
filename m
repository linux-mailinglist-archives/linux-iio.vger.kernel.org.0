Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F2F3F7906
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbhHYPfr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:35:47 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:54391 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241942AbhHYPfj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:35:39 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id EBB9BCE0AE;
        Wed, 25 Aug 2021 15:26:55 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 54735C0017;
        Wed, 25 Aug 2021 15:26:32 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 35/40] iio: adc: ti_am335x_adc: Wait the idle state to avoid stalls
Date:   Wed, 25 Aug 2021 17:25:13 +0200
Message-Id: <20210825152518.379386-36-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A simple:
$ cat /sys/bus/iio/devices/iio\:deviceX/in_voltage*_raw
can stall forever. It seems that it comes from the fact that the
internal state machine does not have enough time to return to its idle
state in this situation before receiving another request, leading to an
internal stall.

Add a tiadc_wait_idle() helper to ensure no new conversion is requested
while the FSM is still busy.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index ebf6326af60d..d4619fd6fd54 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -17,6 +17,7 @@
 #include <linux/of_device.h>
 #include <linux/iio/machine.h>
 #include <linux/iio/driver.h>
+#include <linux/iopoll.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 #include <linux/iio/buffer.h>
@@ -94,6 +95,15 @@ static u32 get_adc_step_bit(struct tiadc_device *adc_dev, int chan)
 	return 1 << adc_dev->channel_step[chan];
 }
 
+static int tiadc_wait_idle(struct tiadc_device *adc_dev)
+{
+	u32 val;
+
+	return readl_poll_timeout(adc_dev->mfd_tscadc->tscadc_base + REG_ADCFSM,
+				  val, !(val & SEQ_STATUS), 10,
+				  IDLE_TIMEOUT_MS * 1000 * adc_dev->channels);
+}
+
 static void tiadc_step_config(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
@@ -268,6 +278,11 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
 	int i, fifo1count;
+	int ret;
+
+	ret = tiadc_wait_idle(adc_dev);
+	if (ret)
+		return ret;
 
 	tiadc_writel(adc_dev, REG_IRQCLR,
 		     IRQENB_FIFO1THRES | IRQENB_FIFO1OVRRUN |
@@ -419,12 +434,12 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 			  long mask)
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
@@ -434,6 +449,11 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
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
@@ -482,7 +502,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 
 err_unlock:
 	mutex_unlock(&adc_dev->fifo1_lock);
-	return ret;
+	return ret ? ret : IIO_VAL_INT;
 }
 
 static const struct iio_info tiadc_info = {
-- 
2.27.0

