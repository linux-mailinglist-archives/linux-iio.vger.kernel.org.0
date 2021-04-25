Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5673936A6A0
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 12:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhDYK13 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 06:27:29 -0400
Received: from www381.your-server.de ([78.46.137.84]:36842 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhDYK13 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Apr 2021 06:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=T4E0+v6EF9HFbPfBKbVyCafbvjLlr6LE0XL+D08TjGY=; b=DE2RW0KTdGqTeSK9wJSTbBWckC
        nOOse32cDqz6jQ9PmugkqueHgIL2pPM7MNCOlbwhB84k0VgDciVmA2kyVDpGNdtkcrDvY9JI50MqJ
        z6+bgS59yvZ9FcM9+EIL4I2GIQvnrpaf6AERQ9MXz+rv+GlEAm0woR4Ff8lnTAazf8UCh+XqyKzGD
        AoGd0l6ScMIU0h6z2ldDxCx1ZXWVCZXon4rqHOMPgT+8xH3KaMp+mplvM0agEHurhD4fkxJaaFgO/
        UbhneFkdvUReA/gKt2DpkE/yKhBpg8OSOvg4l1/7Wt2rN6PDLBgv3OIvRiVFSl9UKAtEj061JPLxN
        wXnLRVxw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1labyS-0008X6-LE; Sun, 25 Apr 2021 12:26:48 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1labyS-000RIL-Fi; Sun, 25 Apr 2021 12:26:48 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Anand Ashok Dumbre <anandash@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio: xilinx-xadc: Remove `irq` field from state struct
Date:   Sun, 25 Apr 2021 12:26:37 +0200
Message-Id: <20210425102638.9511-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26150/Sat Apr 24 13:06:52 2021)
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
index 6914c1900ed0..dd1c92b2811f 100644
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

