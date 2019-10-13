Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32724D5630
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 14:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfJMM1S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 08:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbfJMM1S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 08:27:18 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0C782082F;
        Sun, 13 Oct 2019 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570969637;
        bh=pztlU3OIlw6RCelH88vjmv73d1NP3/wCDgPzo9Opae8=;
        h=From:To:Cc:Subject:Date:From;
        b=IZ0mNHB/qYDfZ29XggoTPKIMesa2NeCC8NS8LwHwgZGu5PGYSWyYmdrG923ycN7S7
         zSb2tS0Jvmk/gQ1HswChyAd0wnkGTcU3xagOnIymvnlHpf4rcqh9IaKRm6dyMsrhrH
         6W65fyV+wI6TqlivLFZOCCAgp09WDddfXVVXq3DU=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Naidu Tellapati <naidu.tellapati@imgtec.com>
Subject: [PATCH] iio: adc: cc10001: use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 13:25:12 +0100
Message-Id: <20191013122512.1793656-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduces local boilerplate.
Found by coccinelle:

drivers/iio/adc/cc10001_adc.c:344:1-18: WARNING: Use devm_platform_ioremap_resource for adc_dev -> reg_base

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Naidu Tellapati <naidu.tellapati@imgtec.com>
---
 drivers/iio/adc/cc10001_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index f93f1d93b80d..fe9257624f16 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -310,7 +310,6 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct cc10001_adc_device *adc_dev;
 	unsigned long adc_clk_rate;
-	struct resource *res;
 	struct iio_dev *indio_dev;
 	unsigned long channel_map;
 	int ret;
@@ -340,8 +339,7 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 	indio_dev->info = &cc10001_adc_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	adc_dev->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(adc_dev->reg_base)) {
 		ret = PTR_ERR(adc_dev->reg_base);
 		goto err_disable_reg;
-- 
2.23.0

