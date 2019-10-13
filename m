Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E09D56E1
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfJMQuw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 12:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfJMQuw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 12:50:52 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5874B20679;
        Sun, 13 Oct 2019 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570985452;
        bh=+799mVFsqM97UxlRpvWaZWAzBNxOyyNCuvtvtSNVZew=;
        h=From:To:Cc:Subject:Date:From;
        b=qfY8ODcloK/KARNOxR9yuX0/tETzYgcGykdTPJN2kBr3K6T1e3ahiC5TetpKos08v
         xE/w9DC+SFGzuMzuuovfd198wNyBO9RvcxgY+glBv7EQWJnFSOBEPCVp5fvR6MuYLX
         rJ85nVHslWeMJ63YVFi3u/qMCZSqjqqUBOZ9imJc=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Subject: [PATCH] iio: adc: xilinix-xadc: use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 17:48:48 +0100
Message-Id: <20191013164848.2069381-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduces local boilerplate.
Suggested by coccinelle.
 CHECK   drivers/iio/adc/xilinx-xadc-core.c
drivers/iio/adc/xilinx-xadc-core.c:1184:1-11: WARNING: Use devm_platform_ioremap_resource for xadc -> base

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Manish Narani <manish.narani@xilinx.com>
Cc: Sven Van Asbroeck <thesven73@gmail.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 4fd389678dba..ec227b358cd6 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1150,7 +1150,6 @@ static int xadc_probe(struct platform_device *pdev)
 	const struct of_device_id *id;
 	struct iio_dev *indio_dev;
 	unsigned int bipolar_mask;
-	struct resource *mem;
 	unsigned int conf0;
 	struct xadc *xadc;
 	int ret;
@@ -1180,8 +1179,7 @@ static int xadc_probe(struct platform_device *pdev)
 	spin_lock_init(&xadc->lock);
 	INIT_DELAYED_WORK(&xadc->zynq_unmask_work, xadc_zynq_unmask_worker);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	xadc->base = devm_ioremap_resource(&pdev->dev, mem);
+	xadc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xadc->base))
 		return PTR_ERR(xadc->base);
 
-- 
2.23.0

