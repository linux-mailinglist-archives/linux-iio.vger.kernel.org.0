Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CABD56A9
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 17:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfJMPqc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 11:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbfJMPqc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 11:46:32 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A04D8206B7;
        Sun, 13 Oct 2019 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570981591;
        bh=VrTukjtrCbmeIV1DAjolbBaA5GY5/dT0n9uv0ndDQ+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=eoNmaYKsPHUmVrMmXt8R+dauwLy7+jNOI1+qwoGj+o8u6mJmylVdMtOeZnlDLnLHb
         ZPM5sZOazZDiu0/3S3SuwtJGQX0OBVYBIUqo39BVQ4Mi79vMSR2Gt3IEuvp9EIwEiW
         AbNsW639R42tESeX1aXj+yYQVbNCGjPVDmQq3eZA=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH] iio: adc: npcm: use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 16:44:27 +0100
Message-Id: <20191013154427.1853794-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduces local boilerplate code.
Suggested by coccinelle via coccicheck.

CHECK   drivers/iio/adc/npcm_adc.c
drivers/iio/adc/npcm_adc.c:200:1-11: WARNING: Use devm_platform_ioremap_resource for info -> regs

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/iio/adc/npcm_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index 910f3585fa54..a6170a37ebe8 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -183,7 +183,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	int irq;
 	u32 div;
 	u32 reg_con;
-	struct resource *res;
 	struct npcm_adc *info;
 	struct iio_dev *indio_dev;
 	struct device *dev = &pdev->dev;
@@ -196,8 +195,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 
 	info->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	info->regs = devm_ioremap_resource(&pdev->dev, res);
+	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
-- 
2.23.0

