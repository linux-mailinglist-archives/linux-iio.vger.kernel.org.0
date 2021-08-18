Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAC13F0258
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhHRLM3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:29 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50709 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhHRLMY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:24 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AE75960013;
        Wed, 18 Aug 2021 11:11:48 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 13/16] iio: adc: max1027: Prepare re-using the EOC interrupt
Date:   Wed, 18 Aug 2021 13:11:36 +0200
Message-Id: <20210818111139.330636-14-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Right now the driver only has hardware trigger support, which makes use
of the End Of Conversion (EOC) interrupt by:
- Enabling the external trigger
- At completion of the conversion, run a generic handler
- Push the data to the IIO subsystem by using the triggered buffer
  infrastructure, which may not only serve this purpose.

In fact, the interrupt will fire for more reasons than just a hardware
trigger condition, so make a dedicated interrupt handler which will be
enhanced by the upcoming changes to handle more situations.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 2d6485591761..8d86e77fb5db 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -472,6 +472,24 @@ static int max1027_read_scan(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static irqreturn_t max1027_eoc_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct max1027_state *st = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (st->cnvst_trigger) {
+		ret = max1027_read_scan(indio_dev);
+		iio_trigger_notify_done(indio_dev->trig);
+	}
+
+	if (ret)
+		dev_err(&indio_dev->dev,
+			"Cannot read scanned values (%d)\n", ret);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t max1027_trigger_handler(int irq, void *private)
 {
 	struct iio_poll_func *pf = private;
@@ -563,11 +581,11 @@ static int max1027_probe(struct spi_device *spi)
 		}
 
 		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
-						iio_trigger_generic_data_rdy_poll,
+						max1027_eoc_irq_handler,
 						NULL,
 						IRQF_TRIGGER_FALLING,
 						spi->dev.driver->name,
-						st->trig);
+						indio_dev);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
 			return ret;
-- 
2.27.0

