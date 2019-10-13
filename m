Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F0AD56FE
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 19:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfJMRQT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 13:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbfJMRQS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 13:16:18 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E58A2067B;
        Sun, 13 Oct 2019 17:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570986978;
        bh=f5IASgienuTy7fQQ1suZ3YbLiNDM9SG159PTFyH1LUg=;
        h=From:To:Cc:Subject:Date:From;
        b=jKHi8GXW653FkylJGStDtwX53bckslslUpLUsywm7fRO3dtMRAdx2ITT46fQ9ZXL8
         jvt/v0InXKHQDha8V9rvykjWxKpfXAdNkYfjlDoskwbonqerkIGPSE0L2FGoKSW1OL
         tQ6YHwHvJYIlXIiTgSvo6WZIEtBqbPbMVsUzGXAg=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH] iio: dac: lpc18xx: Use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 18:14:14 +0100
Message-Id: <20191013171414.2154379-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduce boilerplate.
Suggested by coccinelle
  CHECK   drivers/iio/dac/lpc18xx_dac.c
drivers/iio/dac/lpc18xx_dac.c:121:1-10: WARNING: Use devm_platform_ioremap_resource for dac -> base

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Joachim Eastwood <manabian@gmail.com>
---
 drivers/iio/dac/lpc18xx_dac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/dac/lpc18xx_dac.c b/drivers/iio/dac/lpc18xx_dac.c
index 883e84e96609..0ab357bd3633 100644
--- a/drivers/iio/dac/lpc18xx_dac.c
+++ b/drivers/iio/dac/lpc18xx_dac.c
@@ -106,7 +106,6 @@ static int lpc18xx_dac_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
 	struct lpc18xx_dac *dac;
-	struct resource *res;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*dac));
@@ -117,8 +116,7 @@ static int lpc18xx_dac_probe(struct platform_device *pdev)
 	dac = iio_priv(indio_dev);
 	mutex_init(&dac->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dac->base = devm_ioremap_resource(&pdev->dev, res);
+	dac->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dac->base))
 		return PTR_ERR(dac->base);
 
-- 
2.23.0

