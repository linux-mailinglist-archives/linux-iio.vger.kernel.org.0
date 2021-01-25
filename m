Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0283730359A
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 06:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbhAZFrv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 00:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbhAYMKU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2021 07:10:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD00C061222
        for <linux-iio@vger.kernel.org>; Mon, 25 Jan 2021 03:43:52 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1l3zw7-0002WJ-2C; Mon, 25 Jan 2021 12:21:35 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1l3zw4-0000Ya-Ku; Mon, 25 Jan 2021 12:21:32 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     kernel@pengutronix.de, Holger Assmann <has@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: adc: stm32-adc: enable timestamping for non-DMA usage
Date:   Mon, 25 Jan 2021 12:21:27 +0100
Message-Id: <20210125112127.1583-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For non-DMA usage, we have an easy way to associate a timestamp with a
sample: iio_pollfunc_store_time stores a timestamp in the primary
trigger IRQ handler and stm32_adc_trigger_handler runs in the IRQ thread
to push out the buffer along with the timestamp.

For this to work, the driver needs to register an IIO_TIMESTAMP channel.
Do this.

For DMA, it's not as easy, because we don't push the buffers out of
stm32_adc_trigger, but out of stm32_adc_dma_buffer_done, which runs in
a tasklet scheduled after a DMA completion.

Preferably, the DMA controller would copy us the timestamp into that buffer
as well. Until this is implemented, restrict timestamping support to
only PIO. For low-frequency sampling, PIO is probably good enough.

Cc: Holger Assmann <has@pengutronix.de>
Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v2 -> v3:
  - explicitly specify alignment (Jonathan)
  - increase buffer size to hold additional timestamp
v1 -> v2:
  - Added comment about timestamping being PIO only (Fabrice)
  - Added missing DMA resource clean up in error path (Fabrice)
  - Added Fabrice's Acked-by
---
 drivers/iio/adc/stm32-adc.c | 39 +++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index c067c994dae2..ab2f440d7afb 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -177,7 +177,7 @@ struct stm32_adc_cfg {
  * @offset:		ADC instance register offset in ADC block
  * @cfg:		compatible configuration data
  * @completion:		end of single conversion completion
- * @buffer:		data buffer
+ * @buffer:		data buffer + 8 bytes for timestamp if enabled
  * @clk:		clock for this adc instance
  * @irq:		interrupt for this adc instance
  * @lock:		spinlock
@@ -200,7 +200,7 @@ struct stm32_adc {
 	u32			offset;
 	const struct stm32_adc_cfg	*cfg;
 	struct completion	completion;
-	u16			buffer[STM32_ADC_MAX_SQ];
+	u16			buffer[STM32_ADC_MAX_SQ + 8] __aligned(8);
 	struct clk		*clk;
 	int			irq;
 	spinlock_t		lock;		/* interrupt lock */
@@ -1718,7 +1718,7 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 	}
 }
 
-static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
+static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
 {
 	struct device_node *node = indio_dev->dev.of_node;
 	struct stm32_adc *adc = iio_priv(indio_dev);
@@ -1766,6 +1766,9 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
+	if (timestamping)
+		num_channels++;
+
 	channels = devm_kcalloc(&indio_dev->dev, num_channels,
 				sizeof(struct iio_chan_spec), GFP_KERNEL);
 	if (!channels)
@@ -1816,6 +1819,19 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
 		stm32_adc_smpr_init(adc, channels[i].channel, smp);
 	}
 
+	if (timestamping) {
+		struct iio_chan_spec *timestamp = &channels[scan_index];
+
+		timestamp->type = IIO_TIMESTAMP;
+		timestamp->channel = -1;
+		timestamp->scan_index = scan_index;
+		timestamp->scan_type.sign = 's';
+		timestamp->scan_type.realbits = 64;
+		timestamp->scan_type.storagebits = 64;
+
+		scan_index++;
+	}
+
 	indio_dev->num_channels = scan_index;
 	indio_dev->channels = channels;
 
@@ -1875,6 +1891,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	irqreturn_t (*handler)(int irq, void *p) = NULL;
 	struct stm32_adc *adc;
+	bool timestamping = false;
 	int ret;
 
 	if (!pdev->dev.of_node)
@@ -1931,16 +1948,22 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	ret = stm32_adc_chan_of_init(indio_dev);
-	if (ret < 0)
-		return ret;
-
 	ret = stm32_adc_dma_request(dev, indio_dev);
 	if (ret < 0)
 		return ret;
 
-	if (!adc->dma_chan)
+	if (!adc->dma_chan) {
+		/* For PIO mode only, iio_pollfunc_store_time stores a timestamp
+		 * in the primary trigger IRQ handler and stm32_adc_trigger_handler
+		 * runs in the IRQ thread to push out buffer along with timestamp.
+		 */
 		handler = &stm32_adc_trigger_handler;
+		timestamping = true;
+	}
+
+	ret = stm32_adc_chan_of_init(indio_dev, timestamping);
+	if (ret < 0)
+		goto err_dma_disable;
 
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 &iio_pollfunc_store_time, handler,
-- 
2.30.0

