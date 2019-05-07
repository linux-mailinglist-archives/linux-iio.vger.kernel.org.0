Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5256215F48
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 10:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEGIXU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 04:23:20 -0400
Received: from first.geanix.com ([116.203.34.67]:42566 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfEGIXU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 May 2019 04:23:20 -0400
Received: from zen.localdomain (unknown [85.184.147.232])
        by first.geanix.com (Postfix) with ESMTPSA id D73B79EE;
        Tue,  7 May 2019 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1557217360; bh=NrfwDtp6F2bgm/6UPCb/JSu6blnlk9a81UTHq+Kuq2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aGEGeC6OVJLN3T4KqbdBwh3/g323Hz+aRm2JcXIsudsTN0cwRhN8xAZ0vX1LzN7Nr
         nelTbgU0vI7dZMxp6pZi3WNUKqokfXDqIx86iUzzPWcTMcDbKd2DRkqhtZFVLCq8tC
         5zqphpj3GVbvTBw4JUpplgcCNDljyBVbtBbSYDCcgwaTxFu34NnlOM2vD5IrWzvd1s
         CNxIuOBCO9eK81bTOsnL8FFLbpPzI1E1RUiD67Sn/x/vPGKfUUhKO3cbKpsKFGvbzP
         VhoMhJLAdh2AFZzRS4ohoIYB5u3RI9dEMn9U6AyGKnb3zrID99D012KOiMSOWpOwb2
         5DliLtvsh+S3Q==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 2/2] iio: adc: ti-ads8688: fix timestamp is not updated in buffer
Date:   Tue,  7 May 2019 10:23:04 +0200
Message-Id: <20190507082304.11692-2-sean@geanix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507082304.11692-1-sean@geanix.com>
References: <20190507082304.11692-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 9cf0eadf640b
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When using the hrtimer iio trigger timestamp isn't updated.
If we use iio_get_time_ns it is updated correctly.

Fixes: 2a86487786b5c ("iio: adc: ti-ads8688: add trigger and buffer support")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/adc/ti-ads8688.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index d9c354dbd7e4..304cad3dddc6 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -396,7 +396,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-			pf->timestamp);
+			iio_get_time_ns(indio_dev));
 
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.21.0

