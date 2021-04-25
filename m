Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C7B36A6A1
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 12:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhDYK13 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 06:27:29 -0400
Received: from www381.your-server.de ([78.46.137.84]:36848 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhDYK13 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Apr 2021 06:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=yEPOlV2o1ZSPhGG28lYcW0SPt7GuNtY4DISWNkqD5LQ=; b=lOEe7wTbsBrYkMgvU3UXWn79uA
        YPwtRAE9b6IlClVmBIISD/K/hCQ8FhlexhfM4H670cb7eulPY6QazGawEUn+Usu8GYxaLvgpDvrTO
        PoiZI5PT2QbKpp4TiAxQvTJv9dR20BqJhu4x1Y6UEFoFY2xA1Cntiv0ixrpUOSSXTliBZkG5YQZf8
        FiDWXsG8Z/729pOlDjZ8uqejspNwcDMTvI/XPNkollNfaim6qEw0gCjd5KZO8pnePTS8VMfE00STp
        871Gu3vYOiQ4UiededqaQyikDTjLH96t6xsmGrHDjE0eQh1o8f2SqYbptqFiGoT7uwdkL3TWtEvVi
        wjEsFmWA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1labyS-0008X9-PS; Sun, 25 Apr 2021 12:26:48 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1labyS-000RIL-Je; Sun, 25 Apr 2021 12:26:48 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Anand Ashok Dumbre <anandash@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio: xilinx-xadc: Make IRQ optional
Date:   Sun, 25 Apr 2021 12:26:38 +0200
Message-Id: <20210425102638.9511-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210425102638.9511-1-lars@metafoo.de>
References: <20210425102638.9511-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26150/Sat Apr 24 13:06:52 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In some setups the IRQ signal of the XADC might not be wired to the host
system. The driver currently requires that an interrupt is specified. Make
the interrupt optional so the driver can be used in such setups where the
interrupt is not connected.

Since both buffered capture as well as events depend on the interrupt being
connected both are not available when the interrupt is not connected.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/xilinx-xadc-core.c | 39 +++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index dd1c92b2811f..ffefb01a3893 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1182,7 +1182,7 @@ static const struct of_device_id xadc_of_match_table[] = {
 MODULE_DEVICE_TABLE(of, xadc_of_match_table);
 
 static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
-	unsigned int *conf)
+	unsigned int *conf, int irq)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -1195,6 +1195,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	u32 ext_mux_chan;
 	u32 reg;
 	int ret;
+	int i;
 
 	*conf = 0;
 
@@ -1273,6 +1274,14 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
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
@@ -1322,9 +1331,9 @@ static int xadc_probe(struct platform_device *pdev)
 	if (!id)
 		return -EINVAL;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO)
+		return irq;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
 	if (!indio_dev)
@@ -1345,11 +1354,11 @@ static int xadc_probe(struct platform_device *pdev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &xadc_info;
 
-	ret = xadc_parse_dt(indio_dev, dev->of_node, &conf0);
+	ret = xadc_parse_dt(indio_dev, dev->of_node, &conf0, irq);
 	if (ret)
 		return ret;
 
-	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
+	if (irq > 0 && (xadc->ops->flags & XADC_FLAGS_BUFFERED)) {
 		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 						      &iio_pollfunc_store_time,
 						      &xadc_trigger_handler,
@@ -1396,15 +1405,17 @@ static int xadc_probe(struct platform_device *pdev)
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

