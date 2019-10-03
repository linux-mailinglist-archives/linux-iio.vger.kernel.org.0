Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E937BCAD0E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2019 19:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfJCReP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Oct 2019 13:34:15 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:33433 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733237AbfJCReO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Oct 2019 13:34:14 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 73071FF812;
        Thu,  3 Oct 2019 17:34:11 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 2/7] iio: adc: max1027: Make it optional to use interrupts
Date:   Thu,  3 Oct 2019 19:33:56 +0200
Message-Id: <20191003173401.16343-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191003173401.16343-1-miquel.raynal@bootlin.com>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The chip has a 'start conversion' and a 'end of conversion' pair of
pins. They can be used but this is absolutely not mandatory as regular
polling of the value is totally fine with the current internal
clocking setup. Turn the interrupts optional and do not error out if
they are not inquired in the device tree. This has the effect to
prevent triggered buffers use though.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 57 +++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 6cdfe9ef73fc..823223b77a70 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -430,35 +430,40 @@ static int max1027_probe(struct spi_device *spi)
 		return -ENOMEM;
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-					&iio_pollfunc_store_time,
-					&max1027_trigger_handler, NULL);
-	if (ret < 0) {
-		dev_err(&indio_dev->dev, "Failed to setup buffer\n");
-		return ret;
-	}
+	if (spi->irq) {
+		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+						      &iio_pollfunc_store_time,
+						      &max1027_trigger_handler,
+						      NULL);
+		if (ret < 0) {
+			dev_err(&indio_dev->dev, "Failed to setup buffer\n");
+			return ret;
+		}
 
-	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-trigger",
-							indio_dev->name);
-	if (st->trig == NULL) {
-		ret = -ENOMEM;
-		dev_err(&indio_dev->dev, "Failed to allocate iio trigger\n");
-		return ret;
-	}
+		st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-trigger",
+						  indio_dev->name);
+		if (st->trig == NULL) {
+			ret = -ENOMEM;
+			dev_err(&indio_dev->dev,
+				"Failed to allocate iio trigger\n");
+			return ret;
+		}
 
-	st->trig->ops = &max1027_trigger_ops;
-	st->trig->dev.parent = &spi->dev;
-	iio_trigger_set_drvdata(st->trig, indio_dev);
-	iio_trigger_register(st->trig);
+		st->trig->ops = &max1027_trigger_ops;
+		st->trig->dev.parent = &spi->dev;
+		iio_trigger_set_drvdata(st->trig, indio_dev);
+		iio_trigger_register(st->trig);
 
-	ret = devm_request_threaded_irq(&spi->dev, spi->irq,
-					iio_trigger_generic_data_rdy_poll,
-					NULL,
-					IRQF_TRIGGER_FALLING,
-					spi->dev.driver->name, st->trig);
-	if (ret < 0) {
-		dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
-		return ret;
+		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
+						iio_trigger_generic_data_rdy_poll,
+						NULL,
+						IRQF_TRIGGER_FALLING,
+						spi->dev.driver->name,
+						st->trig);
+		if (ret < 0) {
+			dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
+			return ret;
+		}
 	}
 
 	/* Disable averaging */
-- 
2.20.1

