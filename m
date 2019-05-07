Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8723C15F47
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 10:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfEGIXT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 04:23:19 -0400
Received: from first.geanix.com ([116.203.34.67]:42562 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfEGIXT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 May 2019 04:23:19 -0400
Received: from zen.localdomain (unknown [85.184.147.232])
        by first.geanix.com (Postfix) with ESMTPSA id F36169A4;
        Tue,  7 May 2019 08:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1557217359; bh=KUEy8lkDyGgm1Jf2E9ADSE8XlfO1mY2FOQ1/BZwwZpM=;
        h=From:To:Cc:Subject:Date;
        b=Z2vlBpYPyltF5ve/XRcfjSBBsdK4cM6nhFV/Y4lcB8sKF/riXNCiwRC3JvaT9b6Sx
         fUGzAZG539oo8WylE5BCVSYnPLAsGI7+HH3Kt6lpafOdCTEBHWXT6U30iRBZYd0ELs
         Jm82uLkPb2TekkvJEo/cBvf8Kt9wx7xnNfrvPlBqswgwLEBDWXdxZaqaBLD0Tcqqx3
         jhg6dHp6Jw/wuQ3g6lNaVGSNaOIDSiPb+0yTnoRNawYl8zDUHWkprVwfjne5tCB8ON
         hvDGhZSkM7bLvQxw1x0MgFQTvO34G5AYUe7rAj0EZprEPhccF4050iLyTZC8j8pw6Z
         nbFUk/TcTH6vA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 1/2] iio: adc: ti-ads8688: save values correct in buffer
Date:   Tue,  7 May 2019 10:23:03 +0200
Message-Id: <20190507082304.11692-1-sean@geanix.com>
X-Mailer: git-send-email 2.21.0
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

Fill the read values in the buffer so we comply
with the given index values.

Fixes: 2a86487786b5c ("iio: adc: ti-ads8688: add trigger and buffer support")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/adc/ti-ads8688.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index f9461070a74a..d9c354dbd7e4 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -387,13 +387,12 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
-	int i, j = 0;
+	int bit;
 
-	for (i = 0; i < indio_dev->masklength; i++) {
-		if (!test_bit(i, indio_dev->active_scan_mask))
-			continue;
-		buffer[j] = ads8688_read(indio_dev, i);
-		j++;
+	memset(buffer, 0, sizeof(buffer));
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
+		buffer[bit] = ads8688_read(indio_dev, bit);
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-- 
2.21.0

