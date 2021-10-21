Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2AF43624A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 15:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhJUNDA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 09:03:00 -0400
Received: from www381.your-server.de ([78.46.137.84]:59690 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhJUNCX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 09:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=8OgCp0M1sFswPbP1ZtaoMvrGkGekdnKH4ojoC+CvNbA=; b=l1SC5msSY8SZyLROI5enaOvAje
        NIXafMjmnpuQx0S7NaYLgPhBGpUNcBr25OIFNU5D5eRCTYNRv3FerKxb/wn8cGV8RC7kMWS121j5Y
        etizxVeaShJrINk2jHgcRJWcJKbfn1VzddLcWwPbcQwtGmRd8L/W7lWaK9DWzB0uv/khZZjkTMUaR
        Ozy3Ll2ZyD7kRku66dl3AQaKxKnHPnDa+gNxlOqxuksvaWDB6dX7DHCBM0riuCHJ0F9DVLKpGLqDk
        OpheFfk49D0ea6+KSZWAOYKcXASs8e2S/Qs14umCflJ7p4scT2a/p4ocbmQKAOB4auaBJiiGZnZc6
        Pk6ytoVg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mdXfx-000FAa-6X; Thu, 21 Oct 2021 15:00:05 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mdXfx-0005Po-27; Thu, 21 Oct 2021 15:00:05 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Anand Ashok Dumbre <anandash@xilinx.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: xilinx-xadc: Make IRQ optional
Date:   Thu, 21 Oct 2021 14:59:50 +0200
Message-Id: <20211021125950.28707-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26329/Thu Oct 21 10:16:40 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In some setups the IRQ signal of the XADC might not be wired to the host
system. The driver currently requires that an interrupt is specified. Make
the interrupt optional so the driver can be used in such setups where the
interrupt is not connected.

Since both the internal triggers as well as events depend on the interrupt
being connected both are not available when the interrupt is not connected.

Buffered access is still supported even without an interrupt since an
external trigger can be used.

The IRQ is only optional when using the AXI interface, since the PCAP
interface needs the IRQ for reading and writing registers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/xilinx-xadc-core.c | 62 +++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 83bea5ef765d..2aa4278ecba7 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -107,6 +107,7 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
 #define XADC_AXI_INT_ALARM_MASK		0x3c0f
 
 #define XADC_FLAGS_BUFFERED BIT(0)
+#define XADC_FLAGS_IRQ_OPTIONAL BIT(1)
 
 /*
  * The XADC hardware supports a samplerate of up to 1MSPS. Unfortunately it does
@@ -562,7 +563,7 @@ static const struct xadc_ops xadc_7s_axi_ops = {
 	.get_dclk_rate = xadc_axi_get_dclk,
 	.update_alarm = xadc_axi_update_alarm,
 	.interrupt_handler = xadc_axi_interrupt_handler,
-	.flags = XADC_FLAGS_BUFFERED,
+	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_S7,
 };
 
@@ -573,7 +574,7 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.get_dclk_rate = xadc_axi_get_dclk,
 	.update_alarm = xadc_axi_update_alarm,
 	.interrupt_handler = xadc_axi_interrupt_handler,
-	.flags = XADC_FLAGS_BUFFERED,
+	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_US,
 };
 
@@ -1182,7 +1183,7 @@ static const struct of_device_id xadc_of_match_table[] = {
 MODULE_DEVICE_TABLE(of, xadc_of_match_table);
 
 static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
-	unsigned int *conf)
+	unsigned int *conf, int irq)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -1195,6 +1196,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	u32 ext_mux_chan;
 	u32 reg;
 	int ret;
+	int i;
 
 	*conf = 0;
 
@@ -1273,6 +1275,14 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	}
 	of_node_put(chan_node);
 
+	/* No IRQ => no events */
+	if (irq <= 0) {
+		for (i = 0; i < num_channels; i++) {
+			channels[i].event_spec = NULL;
+			channels[i].num_event_specs = 0;
+		}
+	}
+
 	indio_dev->num_channels = num_channels;
 	indio_dev->channels = devm_krealloc(dev, channels,
 					    sizeof(*channels) * num_channels,
@@ -1307,6 +1317,7 @@ static int xadc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
+	const struct xadc_ops *ops;
 	struct iio_dev *indio_dev;
 	unsigned int bipolar_mask;
 	unsigned int conf0;
@@ -1322,9 +1333,12 @@ static int xadc_probe(struct platform_device *pdev)
 	if (!id)
 		return -EINVAL;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
+	ops = id->data;
+
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 &&
+	    (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
+		return irq;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
 	if (!indio_dev)
@@ -1345,7 +1359,7 @@ static int xadc_probe(struct platform_device *pdev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &xadc_info;
 
-	ret = xadc_parse_dt(indio_dev, dev->of_node, &conf0);
+	ret = xadc_parse_dt(indio_dev, dev->of_node, &conf0, irq);
 	if (ret)
 		return ret;
 
@@ -1357,14 +1371,16 @@ static int xadc_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
-		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
-		if (IS_ERR(xadc->convst_trigger))
-			return PTR_ERR(xadc->convst_trigger);
+		if (irq > 0) {
+			xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
+			if (IS_ERR(xadc->convst_trigger))
+				return PTR_ERR(xadc->convst_trigger);
 
-		xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
-			"samplerate");
-		if (IS_ERR(xadc->samplerate_trigger))
-			return PTR_ERR(xadc->samplerate_trigger);
+			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
+				"samplerate");
+			if (IS_ERR(xadc->samplerate_trigger))
+				return PTR_ERR(xadc->samplerate_trigger);
+		}
 	}
 
 	xadc->clk = devm_clk_get(dev, NULL);
@@ -1396,15 +1412,17 @@ static int xadc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler, 0,
-			       dev_name(dev), indio_dev);
-	if (ret)
-		return ret;
+	if (irq > 0) {
+		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
+				       0, dev_name(dev), indio_dev);
+		if (ret)
+			return ret;
 
-	ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
-				       &xadc->zynq_unmask_work);
-	if (ret)
-		return ret;
+		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
+					       &xadc->zynq_unmask_work);
+		if (ret)
+			return ret;
+	}
 
 	ret = xadc->ops->setup(pdev, indio_dev, irq);
 	if (ret)
-- 
2.20.1

