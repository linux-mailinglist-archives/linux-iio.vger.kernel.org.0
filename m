Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 065A5D562C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 14:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfJMMRo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 08:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbfJMMRo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 08:17:44 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1C7F2082F;
        Sun, 13 Oct 2019 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570969063;
        bh=tvwMq3kBoW7wcmtz0tJ2gNhcYOJPA+0T0DVixVwywOs=;
        h=From:To:Cc:Subject:Date:From;
        b=x+87J/8ox71iJs/rKnc8C65GzepglwrJu3aIA15LMLxQbo/OXrfeWgKcG/2bbtl7x
         jtauW5nQ701VfFAqvoUYiHNcKrATfmdz0W0FH3l4jNVyDtusMvJ1HdeVrR7v7vNj0x
         xBnCtu8xN7FiK1dHBTOd1v2b2litDbO3OtBKaW2Q=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH] iio: adc: mt6577_auxdac: use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 13:15:38 +0100
Message-Id: <20191013121538.1782436-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduces boilerplate.  Identified by coccinelle

CHECK   drivers/iio/adc/mt6577_auxadc.c
drivers/iio/adc/mt6577_auxadc.c:257:1-18: WARNING: Use devm_platform_ioremap_resource for adc_dev -> reg_base

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 7bbb64ca3b32..a4776d924f3a 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -237,7 +237,6 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 {
 	struct mt6577_auxadc_device *adc_dev;
 	unsigned long adc_clk_rate;
-	struct resource *res;
 	struct iio_dev *indio_dev;
 	int ret;
 
@@ -253,8 +252,7 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 	indio_dev->channels = mt6577_auxadc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mt6577_auxadc_iio_channels);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	adc_dev->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(adc_dev->reg_base)) {
 		dev_err(&pdev->dev, "failed to get auxadc base address\n");
 		return PTR_ERR(adc_dev->reg_base);
-- 
2.23.0

