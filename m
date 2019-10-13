Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0D5D56A0
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfJMPej (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 11:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfJMPej (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 11:34:39 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D04720663;
        Sun, 13 Oct 2019 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570980878;
        bh=puI8I4fMp2LPkPF8Mh0/d7mqT129zhyx3YV/2AByRE0=;
        h=From:To:Cc:Subject:Date:From;
        b=OcZMrMBO3GPZuqEVTUF72ZRgCjGHunhFWJ2Amm2ePD7MoYnVbnB3ottSGJ8Qj5Nx8
         jHqTRBpfvD/YSQTLFL4seDzIm91r764/IzsfNPEJ07ron6/e1+pFGHoGmyfYQgnfJr
         BgaSe/KfexOhagp89S180HohBU3vzywT1L46RpH8=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH] iio: adc: lpc18xx: use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 16:32:34 +0100
Message-Id: <20191013153234.1835827-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoid local boilerplate.
Identified by coccinelle

CHECK   drivers/iio/adc/lpc18xx_adc.c
drivers/iio/adc/lpc18xx_adc.c:137:1-10: WARNING: Use devm_platform_ioremap_resource for adc -> base

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Joachim Eastwood <manabian@gmail.com>
---
 drivers/iio/adc/lpc18xx_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index e400a95f553d..4c6ac6644dc0 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -119,7 +119,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
 	struct lpc18xx_adc *adc;
-	struct resource *res;
 	unsigned int clkdiv;
 	unsigned long rate;
 	int ret;
@@ -133,8 +132,7 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 	adc->dev = &pdev->dev;
 	mutex_init(&adc->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	adc->base = devm_ioremap_resource(&pdev->dev, res);
+	adc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(adc->base))
 		return PTR_ERR(adc->base);
 
-- 
2.23.0

