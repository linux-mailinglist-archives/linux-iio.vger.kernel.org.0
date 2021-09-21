Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB984132EC
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 13:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhIULzu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 07:55:50 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:56015 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbhIULzu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 07:55:50 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8FA28240018;
        Tue, 21 Sep 2021 11:54:20 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 14/16] iio: adc: max1027: Use the EOC IRQ when populated for single reads
Date:   Tue, 21 Sep 2021 13:54:06 +0200
Message-Id: <20210921115408.66711-15-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210921115408.66711-1-miquel.raynal@bootlin.com>
References: <20210921115408.66711-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

So far the End-Of-Conversion interrupt was only used in conjunction with
the internal trigger to process the data. Let's extend the use of this
interrupt handler to support regular single-shot conversions as well.

Doing so requires writing our own hard IRQ handler. This handler has to
check if buffers are enabled or not:

*** Buffers disabled condition ***

  This means the user requested a single conversion and the sample is
  ready to be retrieved.

    -> This implies adding the relevant completion boilerplate.

*** Buffers enabled condition ***

  Triggers are used. So far there is only support for the internal
  trigger but this trigger might soon be attached to another device as
  well so it is the core duty to decide which handler to call in order
  to process the data. The core will decide to either:

  * Call the internal trigger handler which will extract the data that
    is already present in the ADC FIFOs

  or

  * Call the trigger handler of another driver when using this trigger
    with another device, even though this call will be slightly delayed
    by the fact that the max1027 IRQ is a data-ready interrupt rather
    than a real trigger:

  -> The new handler will manually inform the core about the trigger
     having transitioned by directly calling iio_trigger_poll() (which
     iio_trigger_generic_data_rdy_poll() initially did).

In order for the handler to be "source" agnostic, we also need to change
the private pointer and provide the IIO device instead of the trigger
object.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Jonathan,

I hope this fits the IIO model now. In order to be sure I got the big
picture I first refused to look at your code snippets. Just with your
"plain english" explanations I wrote most of these three patches, before
checking back that they were indeed fully aligned with your examples. I
truly hope they do now, but do not hesitate if I missed something.

Cheers,
Miquèl

 drivers/iio/adc/max1027.c | 43 +++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 84217e18ef70..0fa7b0fbdba0 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -270,15 +270,26 @@ struct max1027_state {
 	struct iio_trigger		*trig;
 	__be16				*buffer;
 	struct mutex			lock;
+	struct completion		complete;
 
 	u8				reg ____cacheline_aligned;
 };
 
 static int max1027_wait_eoc(struct iio_dev *indio_dev)
 {
+	struct max1027_state *st = iio_priv(indio_dev);
 	unsigned int conversion_time = MAX1027_CONVERSION_UDELAY;
+	int ret;
 
-	usleep_range(conversion_time, conversion_time * 2);
+	if (st->spi->irq) {
+		ret = wait_for_completion_timeout(&st->complete,
+						  msecs_to_jiffies(1000));
+		reinit_completion(&st->complete);
+		if (!ret)
+			return ret;
+	} else {
+		usleep_range(conversion_time, conversion_time * 2);
+	}
 
 	return 0;
 }
@@ -473,6 +484,30 @@ static int max1027_read_scan(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static irqreturn_t max1027_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct max1027_state *st = iio_priv(indio_dev);
+
+	/*
+	 * If buffers are disabled (raw read), we just need to unlock the
+	 * waiters which will then handle the data.
+	 *
+	 * When using the internal trigger, we must hand-off the choice of the
+	 * handler to the core which will then lookup through the interrupt tree
+	 * for the right handler registered with iio_triggered_buffer_setup()
+	 * to execute, as this trigger might very well be used in conjunction
+	 * with another device. The core will then call the relevant handler to
+	 * perform the data processing step.
+	 */
+	if (!iio_buffer_enabled(indio_dev))
+		complete(&st->complete);
+	else
+		iio_trigger_poll(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t max1027_trigger_handler(int irq, void *private)
 {
 	struct iio_poll_func *pf = private;
@@ -517,6 +552,7 @@ static int max1027_probe(struct spi_device *spi)
 	st->info = &max1027_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
 	mutex_init(&st->lock);
+	init_completion(&st->complete);
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &max1027_info;
@@ -560,10 +596,9 @@ static int max1027_probe(struct spi_device *spi)
 			return ret;
 		}
 
-		ret = devm_request_irq(&spi->dev, spi->irq,
-				       iio_trigger_generic_data_rdy_poll,
+		ret = devm_request_irq(&spi->dev, spi->irq, max1027_handler,
 				       IRQF_TRIGGER_FALLING,
-				       spi->dev.driver->name, st->trig);
+				       spi->dev.driver->name, indio_dev);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
 			return ret;
-- 
2.27.0

