Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597CB40C997
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 18:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhIOQCG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 12:02:06 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50603 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbhIOQBz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 12:01:55 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D86491BF213;
        Wed, 15 Sep 2021 16:00:33 +0000 (UTC)
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
Subject: [PATCH v3 42/47] iio: adc: ti_am335x_adc: Add a unit to the timeout delay
Date:   Wed, 15 Sep 2021 17:59:03 +0200
Message-Id: <20210915155908.476767-43-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The lack of unit in the macro name kind of tricked me when I was
troubleshooting an issue. Physical constants should always get a unit.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti_am335x_adc.c      | 4 ++--
 include/linux/mfd/ti_am335x_tscadc.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 6f47a1ace3d4..e7dba10b29b4 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -101,7 +101,7 @@ static int tiadc_wait_idle(struct tiadc_device *adc_dev)
 
 	return readl_poll_timeout(adc_dev->mfd_tscadc->tscadc_base + REG_ADCFSM,
 				  val, !(val & SEQ_STATUS), 10,
-				  IDLE_TIMEOUT * 1000 * adc_dev->channels);
+				  IDLE_TIMEOUT_MS * 1000 * adc_dev->channels);
 }
 
 static void tiadc_step_config(struct iio_dev *indio_dev)
@@ -461,7 +461,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	am335x_tsc_se_set_once(adc_dev->mfd_tscadc, step_en);
 
 	/* Wait for Fifo threshold interrupt */
-	timeout = jiffies + msecs_to_jiffies(IDLE_TIMEOUT * adc_dev->channels);
+	timeout = jiffies + msecs_to_jiffies(IDLE_TIMEOUT_MS * adc_dev->channels);
 	while (1) {
 		fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 		if (fifo1count)
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index 9a412e6d764b..223e5840f3a3 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -141,7 +141,7 @@
  *
  * max processing time: 266431 * 308ns = 83ms(approx)
  */
-#define IDLE_TIMEOUT		83 /* milliseconds */
+#define IDLE_TIMEOUT_MS		83 /* milliseconds */
 
 #define TSCADC_CELLS		2
 
-- 
2.27.0

