Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E323FF68A
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347772AbhIBVyS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:54:18 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37657 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347825AbhIBVyH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:54:07 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3A61F240003;
        Thu,  2 Sep 2021 21:53:06 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 41/46] iio: adc: ti_am335x_adc: Add a unit to the timeout delay
Date:   Thu,  2 Sep 2021 23:51:39 +0200
Message-Id: <20210902215144.507243-42-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
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
 drivers/iio/adc/ti_am335x_adc.c      | 2 +-
 include/linux/mfd/ti_am335x_tscadc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 0c72845e2b4f..72b11d7118aa 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -469,7 +469,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	am335x_tsc_se_set_once(adc_dev->mfd_tscadc, step_en);
 
 	/* Wait for Fifo threshold interrupt */
-	timeout = jiffies + msecs_to_jiffies(IDLE_TIMEOUT * adc_dev->channels);
+	timeout = jiffies + msecs_to_jiffies(IDLE_TIMEOUT_MS * adc_dev->channels);
 	while (1) {
 		fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 		if (fifo1count)
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index 1f29bcdf51c7..c5daab8682a8 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -157,7 +157,7 @@
  *
  * max processing time: 266431 * 308ns = 83ms(approx)
  */
-#define IDLE_TIMEOUT		83 /* milliseconds */
+#define IDLE_TIMEOUT_MS		83 /* milliseconds */
 
 #define TSCADC_CELLS		2
 
-- 
2.27.0

