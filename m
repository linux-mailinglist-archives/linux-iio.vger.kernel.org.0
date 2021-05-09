Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB73377664
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhEILiZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhEILiY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C012613E5;
        Sun,  9 May 2021 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560242;
        bh=LHeK3JUudoE8lSVlcvjMgN8jPFPiMkYf7y2tLY1zTU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lq9n8zzxaFEQ8b+9N29pwbLoslssBI6D7r+zISE1Ebehjagv60+FQblvFrsadTWr6
         ds7C6nQouHXNspJYEbWhJDQdNyKhC2WtrOv7UWBWYL3WVEEbKeR84spXqwwn5G1Op+
         Xi5C9UbtUGUCLWCGT8lM3TbTBSsi5+XF7MY/mCEVg6Yr7iaUKPDaMtiu6oAzoTqV1X
         kPCecOXSb998XX8mBk1H7DaZ1KlEcVGsKBQXwVSuWNmKNPhUH2HmakAOsPYCSJMYdz
         kdOS+ip9kbTL8eRfDbEB7GCi/YZuhzZtF483pi6HTiTTU2V8ju84VnQGL6QJM/EBDE
         VGpGfxE2E+G+A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH 14/28] iio: adc: stm32-adc: Use pm_runtime_resume_and_get() to replace open coding.
Date:   Sun,  9 May 2021 12:33:40 +0100
Message-Id: <20210509113354.660190-15-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Found using coccicheck script under review at:
https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/

This is a prequel to taking a closer look at the runtime pm in IIO drivers
in general.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index c9d36c88ee6a..5088de835bb1 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1158,11 +1158,9 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 
 	adc->bufi = 0;
 
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* Apply sampling time settings */
 	stm32_adc_writel(adc, regs->smpr[0], adc->smpr_val[0]);
@@ -1364,11 +1362,9 @@ static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
 	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	adc->num_conv = bitmap_weight(scan_mask, indio_dev->masklength);
 
@@ -1413,11 +1409,9 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
 	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	if (!readval)
 		stm32_adc_writel(adc, reg, writeval);
@@ -1537,11 +1531,9 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = stm32_adc_set_trig(indio_dev, indio_dev->trig);
 	if (ret) {
-- 
2.31.1

