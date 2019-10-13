Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B6ED5636
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 14:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfJMMhc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 08:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbfJMMhc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 08:37:32 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2267206B7;
        Sun, 13 Oct 2019 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570970251;
        bh=0qXAw18/gOLPuTDIo/e3SEu7vxFj3QkKxpPSAiIDzhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kL/kw+wIY4ERj8u0xR6/UjJgBTvBioNdKQ0mh2nmc0XlicbbAAi1XD5d38T7O43Ch
         SpuLaZb/ILPByGC7Zplcedt4HLZ94N6DWAXSMLouoOt1aIHiIA18Z/heDa3UGECgoP
         sL/gfGGEWXsDB/9Y0cMjKjgXCvwDtmZW2fesChCQ=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/2] iio: adc: exynos: use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 13:35:24 +0100
Message-Id: <20191013123524.1821390-2-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191013123524.1821390-1-jic23@kernel.org>
References: <20191013123524.1821390-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduce local boilerplate.
Identified by coccinelle
drivers/iio/adc/exynos_adc.c:792:1-11: WARNING: Use devm_platform_ioremap_resource for info -> regs

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/exynos_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index b5a497381452..2df7d057b249 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -769,7 +769,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct s3c2410_ts_mach_info *pdata = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = NULL;
-	struct resource	*mem;
 	bool has_ts = false;
 	int ret = -ENODEV;
 	int irq;
@@ -788,8 +787,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	info->regs = devm_ioremap_resource(&pdev->dev, mem);
+	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
-- 
2.23.0

