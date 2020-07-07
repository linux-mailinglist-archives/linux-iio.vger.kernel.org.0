Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849012179AB
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jul 2020 22:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgGGUpa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jul 2020 16:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgGGUpa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Jul 2020 16:45:30 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51EB220675;
        Tue,  7 Jul 2020 20:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594154729;
        bh=vSrL5JyhpD5ajtZEs0nLda6epf5nVGgn7xh+Ofm+2fg=;
        h=From:To:Cc:Subject:Date:From;
        b=YMDYQWNIaaIrX7TOLf+nEvByxzlagZA68e+aVDDiFDQY0uu+ka0rx/Ad2V8xitFpM
         1RyJ5sdPX59FtWAdCNwAOz+YADJ8IVKVoQysyb1a4zhR8OL3aM3DQ1S4oaz7WfEdZL
         bQ9EaWiqISs2DtP2V/zZuBf+v5RUiDdcHHnkbkn8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio:adc:ti_am335x: Drop read variables that are set and not read.
Date:   Tue,  7 Jul 2020 21:43:24 +0100
Message-Id: <20200707204324.391215-1-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is no point in setting them so let us clear them out.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 6946d25b4642..c719d6cbc2ac 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -294,7 +294,7 @@ static int tiadc_start_dma(struct iio_dev *indio_dev)
 static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
-	int i, fifo1count, read;
+	int i, fifo1count;
 
 	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
 				IRQENB_FIFO1OVRRUN |
@@ -303,7 +303,7 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 	/* Flush FIFO. Needed in corner cases in simultaneous tsc/adc use */
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 	for (i = 0; i < fifo1count; i++)
-		read = tiadc_readl(adc_dev, REG_FIFO1);
+		tiadc_readl(adc_dev, REG_FIFO1);
 
 	return 0;
 }
@@ -343,7 +343,7 @@ static int tiadc_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
 	struct tiadc_dma *dma = &adc_dev->dma;
-	int fifo1count, i, read;
+	int fifo1count, i;
 
 	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
 				IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW));
@@ -358,7 +358,7 @@ static int tiadc_buffer_predisable(struct iio_dev *indio_dev)
 	/* Flush FIFO of leftover data in the time it takes to disable adc */
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 	for (i = 0; i < fifo1count; i++)
-		read = tiadc_readl(adc_dev, REG_FIFO1);
+		tiadc_readl(adc_dev, REG_FIFO1);
 
 	return 0;
 }
-- 
2.27.0

