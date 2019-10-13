Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECCED56CC
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfJMQXi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 12:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfJMQXh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 12:23:37 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A8A20659;
        Sun, 13 Oct 2019 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570983817;
        bh=/Gr9s0H0SajSm538jOlYy2EWQD9xiEdZP3Nkix/Np/M=;
        h=From:To:Cc:Subject:Date:From;
        b=vmWC5RC+20gVLMrGu0JhR20jytli0dqW8Bw9AkUKAdSL2e0z3PQXReEXhCqiipHyc
         wI0hoSe95u3eisKKnnDSZbJoGK5IMEeYCeSluehSCcn779QsIwWwCuemBvOFS5BsQB
         aZIdmlFr3PGZl9pgfU0msFT/i+w3gHYfPE6M+H2Y=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH] iio: adc: cpcap-adc: Fix missing IRQF_ONESHOT as only threaded handler.
Date:   Sun, 13 Oct 2019 17:21:33 +0100
Message-Id: <20191013162133.1999362-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Coccinelle noticed:
CHECK   drivers/iio/adc/cpcap-adc.c
drivers/iio/adc/cpcap-adc.c:1009:9-34: ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT

As far as I can see this is a simple case of it should be specified
but isn't.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 drivers/iio/adc/cpcap-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index 2d616cafe75f..5086a337f4c9 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -1008,7 +1008,7 @@ static int cpcap_adc_probe(struct platform_device *pdev)
 
 	error = devm_request_threaded_irq(&pdev->dev, ddata->irq, NULL,
 					  cpcap_adc_irq_thread,
-					  IRQF_TRIGGER_NONE,
+					  IRQF_TRIGGER_NONE | IRQF_ONESHOT,
 					  "cpcap-adc", indio_dev);
 	if (error) {
 		dev_err(&pdev->dev, "could not get irq: %i\n",
-- 
2.23.0

