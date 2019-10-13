Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A59D56AE
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfJMPuj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 11:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbfJMPuj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 11:50:39 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E889C206B7;
        Sun, 13 Oct 2019 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570981838;
        bh=rijLT5LKeTjWQ72GtqKXs7DE8zdfQ5GWo4DY9Vi/kQI=;
        h=From:To:Cc:Subject:Date:From;
        b=uoOrWsgIqDsVK5srhTWvL1KeXdyzLGydZqsApKti41pE2pF0Sl0VaSNT2IkjLehXw
         d9BtUxxQ3tkzO1swTY7by2gJIsW1eSb8gsyCHD21ONj2mdPnLv1TPDzg/13kgtCdSU
         6tTtwBLyd4IVFSG4raCivWwugekU0/Z9mCRmHfCw=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: [PATCH] iio: adc: rcar-gyroadc: use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 16:48:32 +0100
Message-Id: <20191013154832.1858884-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoids some local boilerplate.
Suggested by coccinelle.

CHECK   drivers/iio/adc/rcar-gyroadc.c
drivers/iio/adc/rcar-gyroadc.c:495:1-11: WARNING: Use devm_platform_ioremap_resource for priv -> regs

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
---
 drivers/iio/adc/rcar-gyroadc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index c37f201294b2..63ce743ee7af 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -481,7 +481,6 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rcar_gyroadc *priv;
 	struct iio_dev *indio_dev;
-	struct resource *mem;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
@@ -491,8 +490,7 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
 	priv = iio_priv(indio_dev);
 	priv->dev = dev;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(dev, mem);
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs))
 		return PTR_ERR(priv->regs);
 
-- 
2.23.0

