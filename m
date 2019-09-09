Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9ACAD7E7
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 13:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfIIL2z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 07:28:55 -0400
Received: from first.geanix.com ([116.203.34.67]:53520 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730067AbfIIL2z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 07:28:55 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id DA17D641DD;
        Mon,  9 Sep 2019 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568028506; bh=oCuXYMSmVQgOn5dkAoMZDqaKmL291ZpJJqeMU0TyhFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=M3nrqCZKph02QQeDV7uC5TMRisxblmHsa8nImbMR1KGIGVCDV93fQKZlRTTwe11hJ
         PSSV9P6gucCdKMkid2bWas6/tAg0snq0dtxO/K7LnbLZnawnzd39deRZP14MaplXVI
         3gvrGvvibwWC2iCkokcapQsyxGZKaJz0ofvuzQWjgg7LIGLMfxPvLRghxidH1nAAMR
         Xmm/+QVPWGK1A3ERM37HZovPkymcBpe7gqflgNXuBb1mxJurzaSh3SlFwgl7blIW1Q
         /GrC2vhDP9Z412NqX0hMqtA02Y4FFDH2tbqYK1LH6SNLIqVhI7ER6TAKAeCybNuvvZ
         iQIFVYC/vtIDA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v6 4/6] iio: imu: st_lsm6dsx: always enter interrupt thread
Date:   Mon,  9 Sep 2019 13:28:44 +0200
Message-Id: <20190909112846.55280-4-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909112846.55280-1-sean@geanix.com>
References: <20190909112846.55280-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=4.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The interrupt source can come from multiple sources,
fifo and wake interrupts.
Enter interrupt thread to check which interrupt that has fired.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 9d023b99139f..5b8bcd9cc4d2 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1661,9 +1661,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 
 static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
 {
-	struct st_lsm6dsx_hw *hw = private;
-
-	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
+	return IRQ_WAKE_THREAD;
 }
 
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
-- 
2.23.0

