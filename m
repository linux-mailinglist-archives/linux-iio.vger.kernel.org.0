Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF19B430896
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 14:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245621AbhJQMSG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 08:18:06 -0400
Received: from www381.your-server.de ([78.46.137.84]:55182 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbhJQMSG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Oct 2021 08:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=NiXXpK5slDP9FkP0v/hoiSktqiXPnfA2w/cykvgYQ4E=; b=CaJVbkqg0mWaQv0EBcmmMiyz9P
        TrzGnS/55W4uvVLJl5H7xwO0TugP01lZyaOf39b2v4FPHAGqrS4wvovQ0Xol2DyI92rDceF9Gm3mS
        C/G+vCEvNfy8jkrqdL0ptiUuwqRy0gUq17AVRouY5yZpeKH1OPDio5Rx8iFufK9sh+DIGcvynfatB
        KOj5YEGVeBEdpuJwkJnYkBv5HxZWP0IqGFdfJcOirzrYmccS1b1kPF3TlUDDz1C6Hpyzb33yhhErj
        9pozjOCUPuRwvLFEm3tqRlgdBTTRIUo/PND5X5qpH7wox/ZtXwvTKWcGIwvtg93VJtUTfouUi3waY
        rE+HbLyQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mc551-0004F7-Sm; Sun, 17 Oct 2021 14:15:55 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mc551-000One-Nl; Sun, 17 Oct 2021 14:15:55 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: xilinx-xadc: Remove `irq` field from state struct
Date:   Sun, 17 Oct 2021 14:15:51 +0200
Message-Id: <20211017121551.24063-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26325/Sun Oct 17 10:17:54 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since commit 2a9685d1a3b7 ("iio: adc: xilinx: use more devres helpers and
remove remove()") the `irq` field from XADC driver state struct is only
used in the `probe()` function.

Use the local `irq` variable throughout the `probe()` function and remove
the now unused field from the state struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/xilinx-xadc-core.c | 5 ++---
 drivers/iio/adc/xilinx-xadc.h      | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 198d2916266d..83bea5ef765d 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1332,7 +1332,6 @@ static int xadc_probe(struct platform_device *pdev)
 
 	xadc = iio_priv(indio_dev);
 	xadc->ops = id->data;
-	xadc->irq = irq;
 	init_completion(&xadc->completion);
 	mutex_init(&xadc->mutex);
 	spin_lock_init(&xadc->lock);
@@ -1397,7 +1396,7 @@ static int xadc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_request_irq(dev, xadc->irq, xadc->ops->interrupt_handler, 0,
+	ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler, 0,
 			       dev_name(dev), indio_dev);
 	if (ret)
 		return ret;
@@ -1407,7 +1406,7 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
+	ret = xadc->ops->setup(pdev, indio_dev, irq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 8b80195725e9..7d78ce698967 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -67,7 +67,6 @@ struct xadc {
 	spinlock_t lock;
 
 	struct completion completion;
-	int irq;
 };
 
 enum xadc_type {
-- 
2.20.1

