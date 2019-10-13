Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBF65D56B0
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 17:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfJMPyo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 11:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfJMPyo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 11:54:44 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB43206B7;
        Sun, 13 Oct 2019 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570982084;
        bh=sYvw9uL13ZKzvAsTlCagTxRYYTR6CAhlH+wPiEpqbqE=;
        h=From:To:Cc:Subject:Date:From;
        b=IQFliwcce41YKl77pK2wBuo19K95Xdtpr5g4lqGrunXVo411wIOCWsVsh/reSOGkl
         W/tK1NiMQizl6XeZwe/jPTOS048ocx6PEifwnWM9uABfJCu5Fde4M1UUSyCJB7EACo
         Y6IZsJcWxLFKn6AYIeAS3REGI7ov3pa39yrvnYGM=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: adc: spear_adc: Use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 16:52:39 +0100
Message-Id: <20191013155239.1868818-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoids local boilerplate doing the same thing.
Suggested by coccinelle

CHECK   drivers/iio/adc/spear_adc.c
drivers/iio/adc/spear_adc.c:283:1-22: WARNING: Use devm_platform_ioremap_resource for st -> adc_base_spear6xx

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/spear_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 592b97c464da..0ad536494e8f 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -260,7 +260,6 @@ static int spear_adc_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct spear_adc_state *st;
-	struct resource *res;
 	struct iio_dev *indio_dev = NULL;
 	int ret = -ENODEV;
 	int irq;
@@ -279,8 +278,7 @@ static int spear_adc_probe(struct platform_device *pdev)
 	 * (e.g. SPEAr3xx). Let's provide two register base addresses
 	 * to support multi-arch kernels.
 	 */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	st->adc_base_spear6xx = devm_ioremap_resource(&pdev->dev, res);
+	st->adc_base_spear6xx = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(st->adc_base_spear6xx))
 		return PTR_ERR(st->adc_base_spear6xx);
 
-- 
2.23.0

