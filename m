Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99F4D56D4
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 18:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfJMQkA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 12:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfJMQkA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 12:40:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E29572067B;
        Sun, 13 Oct 2019 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570984799;
        bh=ynKn+r6ziysDeNRqhU2nqUi7IkBO/3U52Tq2S+QM0d4=;
        h=From:To:Cc:Subject:Date:From;
        b=iHI1dxFNv7s1mWK98QBxbD5vLYT/WY5vXT30/5WM1GJtiRtezGePmK0hqfrsCWJTo
         SY22dXPtBh3w07ZdUYxYvmbIwD05c43vv22rrJARy8MKSbxCGWetlvRC+IVPLyWl38
         IbNlhr57Za90TVF5K+ikYetRENdwSlnV3NbdfTDo=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] iio: adc: tsl4030: Use false / true instead of 0 / 1 with booleans
Date:   Sun, 13 Oct 2019 17:37:54 +0100
Message-Id: <20191013163754.2044672-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Suggestion from coccinelle / coccicheck

CHECK   drivers/iio/adc/twl4030-madc.c
drivers/iio/adc/twl4030-madc.c:524:6-15: WARNING: Comparison of 0/1 to bool variable
drivers/iio/adc/twl4030-madc.c:655:1-43: WARNING: Assignment of 0/1 to bool variable
drivers/iio/adc/twl4030-madc.c:659:2-44: WARNING: Assignment of 0/1 to bool variable
drivers/iio/adc/twl4030-madc.c:664:1-43: WARNING: Assignment of 0/1 to bool variable
drivers/iio/adc/twl4030-madc.c:498:2-34: WARNING: Assignment of 0/1 to bool variable
drivers/iio/adc/twl4030-madc.c:510:2-19: WARNING: Assignment of 0/1 to bool variable
drivers/iio/adc/twl4030-madc.c:511:2-11: WARNING: Assignment of 0/1 to bool variable
drivers/iio/adc/twl4030-madc.c:531:2-19: WARNING: Assignment of 0/1 to bool variable
drivers/iio/adc/twl4030-madc.c:532:2-11: WARNING: Assignment of 0/1 to bool variable

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sebastian Reichel <sre@kernel.org>
---
 drivers/iio/adc/twl4030-madc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 55c5119fe575..472b08f37fea 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -495,7 +495,7 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
 		ret = twl4030_madc_disable_irq(madc, i);
 		if (ret < 0)
 			dev_dbg(madc->dev, "Disable interrupt failed %d\n", i);
-		madc->requests[i].result_pending = 1;
+		madc->requests[i].result_pending = true;
 	}
 	for (i = 0; i < TWL4030_MADC_NUM_METHODS; i++) {
 		r = &madc->requests[i];
@@ -507,8 +507,8 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
 		len = twl4030_madc_read_channels(madc, method->rbase,
 						 r->channels, r->rbuf, r->raw);
 		/* Free request */
-		r->result_pending = 0;
-		r->active = 0;
+		r->result_pending = false;
+		r->active = false;
 	}
 	mutex_unlock(&madc->lock);
 
@@ -521,15 +521,15 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
 	 */
 	for (i = 0; i < TWL4030_MADC_NUM_METHODS; i++) {
 		r = &madc->requests[i];
-		if (r->active == 0)
+		if (!r->active)
 			continue;
 		method = &twl4030_conversion_methods[r->method];
 		/* Read results */
 		len = twl4030_madc_read_channels(madc, method->rbase,
 						 r->channels, r->rbuf, r->raw);
 		/* Free request */
-		r->result_pending = 0;
-		r->active = 0;
+		r->result_pending = false;
+		r->active = false;
 	}
 	mutex_unlock(&madc->lock);
 
@@ -652,16 +652,16 @@ static int twl4030_madc_conversion(struct twl4030_madc_request *req)
 	ret = twl4030_madc_start_conversion(twl4030_madc, req->method);
 	if (ret < 0)
 		goto out;
-	twl4030_madc->requests[req->method].active = 1;
+	twl4030_madc->requests[req->method].active = true;
 	/* Wait until conversion is ready (ctrl register returns EOC) */
 	ret = twl4030_madc_wait_conversion_ready(twl4030_madc, 5, method->ctrl);
 	if (ret) {
-		twl4030_madc->requests[req->method].active = 0;
+		twl4030_madc->requests[req->method].active = false;
 		goto out;
 	}
 	ret = twl4030_madc_read_channels(twl4030_madc, method->rbase,
 					 req->channels, req->rbuf, req->raw);
-	twl4030_madc->requests[req->method].active = 0;
+	twl4030_madc->requests[req->method].active = false;
 
 out:
 	mutex_unlock(&twl4030_madc->lock);
-- 
2.23.0

