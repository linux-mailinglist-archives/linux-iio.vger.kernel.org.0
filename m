Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4773F0259
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhHRLMa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:30 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57015 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbhHRLM0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:26 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AD88B60016;
        Wed, 18 Aug 2021 11:11:50 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 16/16] iio: adc: max1027: Enable software triggers to be used without IRQ
Date:   Wed, 18 Aug 2021 13:11:39 +0200
Message-Id: <20210818111139.330636-17-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Software triggers do not need a device IRQ to work. As opposed to
hardware triggers which need it to yield the data to the IIO core,
software triggers run a dedicated thread which does all the tasks on
their behalf. Then, the end of conversion status may either come from an
interrupt or from a sufficient enough extra delay. IRQs are not
mandatory so move the triggered buffer setup out of the IRQ condition.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index bb437e43adaf..e767437a578e 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -567,16 +567,18 @@ static int max1027_probe(struct spi_device *spi)
 	if (!st->buffer)
 		return -ENOMEM;
 
+	/* Enable triggered buffers */
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &max1027_trigger_handler,
+					      NULL);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Failed to setup buffer\n");
+		return ret;
+	}
+
+	/* If there is an EOC interrupt, enable the hardware trigger (cnvst) */
 	if (spi->irq) {
-		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-						      &iio_pollfunc_store_time,
-						      &max1027_trigger_handler,
-						      NULL);
-		if (ret < 0) {
-			dev_err(&indio_dev->dev, "Failed to setup buffer\n");
-			return ret;
-		}
-
 		st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-trigger",
 						  indio_dev->name);
 		if (st->trig == NULL) {
-- 
2.27.0

