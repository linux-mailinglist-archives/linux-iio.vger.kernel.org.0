Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30DB5D55D6
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfJMLjL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 07:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbfJMLjL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 07:39:11 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C352082F;
        Sun, 13 Oct 2019 11:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570966750;
        bh=ZGK0n3UQ7Lk+1oY+Tx2nrJpuo/KAnQgYlNqms6D/ehc=;
        h=From:To:Cc:Subject:Date:From;
        b=GpqKp1/PoPQ4m7p1ehwGMER6RJG/K2OBhWDyFBfv8eSCE7NLgLXrsNXhefAuqDam7
         5UTnGM6fnoeqf1EYcIYTTmzh6P9zXLW1mOenH2c0qSQTzNkfWFoEIFEqyhcI7hVNEk
         Qd1npIjpqy0LcM4Tvg+Tm130ARqm/kJxB2l/6y2Q=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rick Altherr <raltherr@google.com>
Subject: [PATCH] iio: adc: aspeed: use devm_platform_ioremap_resource
Date:   Sun, 13 Oct 2019 12:37:05 +0100
Message-Id: <20191013113705.1721011-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduces boilerplate.

Identified by: Coccinelle / coccicheck

CHECK   drivers/iio/adc/aspeed_adc.c
drivers/iio/adc/aspeed_adc.c:189:1-11: WARNING: Use devm_platform_ioremap_resource for data -> base

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rick Altherr <raltherr@google.com>
---
 drivers/iio/adc/aspeed_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index d3fc39df535d..1e5375235cfe 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -173,7 +173,6 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct aspeed_adc_data *data;
 	const struct aspeed_adc_model_data *model_data;
-	struct resource *res;
 	const char *clk_parent_name;
 	int ret;
 	u32 adc_engine_control_reg_val;
@@ -185,8 +184,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	data = iio_priv(indio_dev);
 	data->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(&pdev->dev, res);
+	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-- 
2.23.0

