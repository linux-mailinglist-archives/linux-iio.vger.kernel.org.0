Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80581D5700
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfJMRTn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 13:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbfJMRTn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 13:19:43 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24B30206B7;
        Sun, 13 Oct 2019 17:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570987181;
        bh=P9WHcc5t1g96pZSPD23VM/kBiYubq3ifN5AGIi+aafY=;
        h=From:To:Cc:Subject:Date:From;
        b=kaNbna3fLp8U6mBV1LO4bqzbucl+8JFgds5YzagVpnwOszkSeIfxLz1rSxQIueor7
         iC+RizGPzLe7IyjcaKgcRZSxWjOf0GU28MpRXNfmnn0lSl51e2/Dc9+n/ud3q2tZXO
         T5NHW0zI2WiC0zkGmjoJHBsCz6LRHdoa9vqpAlo0=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH] iio: dac: vf610: Use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 18:17:32 +0100
Message-Id: <20191013171732.2169010-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduce local boilerplate.
Suggested by coccinelle

CHECK   drivers/iio/dac/vf610_dac.c
drivers/iio/dac/vf610_dac.c:189:1-11: WARNING: Use devm_platform_ioremap_resource for info -> regs

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/iio/dac/vf610_dac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index 0ec4d2609ef9..71f8a5c471c4 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -172,7 +172,6 @@ static int vf610_dac_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
 	struct vf610_dac *info;
-	struct resource *mem;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
@@ -185,8 +184,7 @@ static int vf610_dac_probe(struct platform_device *pdev)
 	info = iio_priv(indio_dev);
 	info->dev = &pdev->dev;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	info->regs = devm_ioremap_resource(&pdev->dev, mem);
+	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
-- 
2.23.0

