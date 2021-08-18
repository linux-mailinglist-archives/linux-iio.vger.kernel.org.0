Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEB53F0262
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhHRLMr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:47 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57119 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbhHRLMZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:25 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5D7C160014;
        Wed, 18 Aug 2021 11:11:49 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 14/16] iio: adc: max1027: Consolidate the end of conversion helper
Date:   Wed, 18 Aug 2021 13:11:37 +0200
Message-Id: <20210818111139.330636-15-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now that we have a dedicated handler for End Of Conversion interrupts,
let's create a second path:
- Situation 1: we are using the external hardware trigger, a conversion
  has been triggered and the ADC pushed the data to its FIFO, we need to
  retrieve the data and push it to the IIO buffers.
- Situation 2: we are not using the external hardware trigger, hence we
  are likely waiting in a blocked thread waiting for this interrupt to
  happen: in this case we just wake up the waiting thread.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 8d86e77fb5db..8c5995ae59f2 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -235,6 +235,7 @@ struct max1027_state {
 	struct iio_trigger		*trig;
 	__be16				*buffer;
 	struct mutex			lock;
+	bool				data_rdy;
 	bool				cnvst_trigger;
 	u8				reg ____cacheline_aligned;
 };
@@ -243,12 +244,22 @@ static DECLARE_WAIT_QUEUE_HEAD(max1027_queue);
 
 static int max1027_wait_eoc(struct iio_dev *indio_dev)
 {
+	struct max1027_state *st = iio_priv(indio_dev);
 	unsigned int conversion_time = MAX1027_CONVERSION_UDELAY;
+	int ret;
 
-	if (indio_dev->active_scan_mask)
-		conversion_time *= hweight32(*indio_dev->active_scan_mask);
+	if (st->spi->irq) {
+		ret = wait_event_interruptible_timeout(max1027_queue,
+						       st->data_rdy, HZ / 1000);
+		st->data_rdy = false;
+		if (ret == -ERESTARTSYS)
+			return ret;
+	} else {
+		if (indio_dev->active_scan_mask)
+			conversion_time *= hweight32(*indio_dev->active_scan_mask);
 
-	usleep_range(conversion_time, conversion_time * 2);
+		usleep_range(conversion_time, conversion_time * 2);
+	}
 
 	return 0;
 }
@@ -481,6 +492,9 @@ static irqreturn_t max1027_eoc_irq_handler(int irq, void *private)
 	if (st->cnvst_trigger) {
 		ret = max1027_read_scan(indio_dev);
 		iio_trigger_notify_done(indio_dev->trig);
+	} else {
+		st->data_rdy = true;
+		wake_up(&max1027_queue);
 	}
 
 	if (ret)
-- 
2.27.0

