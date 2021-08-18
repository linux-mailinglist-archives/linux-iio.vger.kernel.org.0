Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2413F0264
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhHRLM7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:59 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36135 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbhHRLMW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:22 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5E12B6000B;
        Wed, 18 Aug 2021 11:11:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 11/16] iio: adc: max1027: Separate the IRQ handler from the read logic
Date:   Wed, 18 Aug 2021 13:11:34 +0200
Message-Id: <20210818111139.330636-12-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Create a max1027_read_scan() helper which will make clearer the future IRQ
handler updates (no functional change).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 83526f3d7d3a..afc3ce69f7ea 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -427,19 +427,18 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 	return 0;
 }
 
-static irqreturn_t max1027_trigger_handler(int irq, void *private)
+static int max1027_read_scan(struct iio_dev *indio_dev)
 {
-	struct iio_poll_func *pf = private;
-	struct iio_dev *indio_dev = pf->indio_dev;
 	struct max1027_state *st = iio_priv(indio_dev);
 	unsigned int scanned_chans = fls(*indio_dev->active_scan_mask);
 	u16 *buf = st->buffer;
 	unsigned int bit;
-
-	pr_debug("%s(irq=%d, private=0x%p)\n", __func__, irq, private);
+	int ret;
 
 	/* fill buffer with all channel */
-	spi_read(st->spi, st->buffer, scanned_chans * 2);
+	ret = spi_read(st->spi, st->buffer, scanned_chans * 2);
+	if (ret < 0)
+		return ret;
 
 	/* Only keep the channels selected by the user */
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
@@ -451,6 +450,22 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
 
 	iio_push_to_buffers(indio_dev, st->buffer);
 
+	return 0;
+}
+
+static irqreturn_t max1027_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	int ret;
+
+	pr_debug("%s(irq=%d, private=0x%p)\n", __func__, irq, private);
+
+	ret = max1027_read_scan(indio_dev);
+	if (ret)
+		dev_err(&indio_dev->dev,
+			"Cannot read scanned values (%d)\n", ret);
+
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
-- 
2.27.0

