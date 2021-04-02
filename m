Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E074E352F6A
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 20:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhDBSru (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 14:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231462AbhDBSrt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 14:47:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9893761151;
        Fri,  2 Apr 2021 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617389268;
        bh=S4oG72TbJDDFDuf16qz3CrczaERMvPOwJ7VUOi2FjwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hgLDqODon7HjoLDvehRC1nnJwEG8wvX6OBdmMDr7S4KBdLylNtLIk6k0Coxw4qJ6R
         KxlKkl9ZkWhmyIEa2yF0K8oVfO7dlms00GQWJDnvvBZXQDhAqleMutTuBl+eneeto+
         FG2/wTnse3/0O6PEdCFRMiX5mWnVug4f9QHLoulOhvB51GP/QYBz+ydSLe0etIHjSI
         kI/ogB2mmRobTEUGGewo+A7votaRrlM8QicxChOn579L9JceE1mZoIaTa6V1BUeTMY
         IGj3leCSD/YJprROJljOUZtp7fnPbw6yau7Op/wD33+6kbyECCucQpQex7Tpn6wU6O
         pHzDQg91/1QOQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/7] iio:adc:nau7802: Use IRQF_NO_AUTOEN instead of request then disable
Date:   Fri,  2 Apr 2021 19:45:40 +0100
Message-Id: <20210402184544.488862-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402184544.488862-1-jic23@kernel.org>
References: <20210402184544.488862-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst a race during interrupt enabling is probably not a problem,
it is better to not enable the interrupt at all.  The new
IRQF_NO_AUTOEN flag allows us to do that.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/iio/adc/nau7802.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 07c85434b568..bb70b51d25b1 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -498,7 +498,8 @@ static int nau7802_probe(struct i2c_client *client,
 		ret = request_threaded_irq(client->irq,
 				NULL,
 				nau7802_eoc_trigger,
-				IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+				IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
+				IRQF_NO_AUTOEN,
 				client->dev.driver->name,
 				indio_dev);
 		if (ret) {
@@ -513,8 +514,7 @@ static int nau7802_probe(struct i2c_client *client,
 			dev_info(&client->dev,
 				"Failed to allocate IRQ, using polling mode\n");
 			client->irq = 0;
-		} else
-			disable_irq(client->irq);
+		}
 	}
 
 	if (!client->irq) {
-- 
2.31.1

