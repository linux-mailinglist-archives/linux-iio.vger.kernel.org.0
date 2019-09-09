Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9FAD5FA
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbfIIJpQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 05:45:16 -0400
Received: from first.geanix.com ([116.203.34.67]:49148 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbfIIJpQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 05:45:16 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 55DAB6417D;
        Mon,  9 Sep 2019 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568022287; bh=eZtuo/EAhAPq+AL4t9RUpPPRALaSqNeORtoyQGx7Q9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=U9GrW0cbyQTMH4qKavTybuKJYIb4Trq1EXtZdT9+jFrkEJJAkhn/1sxDVCbTsSmdL
         ZWZT1/5IrANt/V1qLLnS+HjijsDpDpGUqXDovNErwHYIjFaY8sb3yHy6t+chMd0plS
         UWH2Z/6tIyeeMiSoFbChMQ6K+2neOZ+M9PmilZ6iCmzcL9kLH82ErvjS0r5Sj0ctmc
         bRxjANdRyaMsBmVWg59DUOgYALXgFBiwPo78riY6KRLto3jQqbWdD+Ck6uV/BBYN/X
         7gIGA35a2qzpFpah38cMKOPXJTPeQ/5kpnGrILg+tZ9l+KkYg1UbD9Xtzxyfjq/lPQ
         cN2/8eYaG4aZA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v5 4/6] iio: imu: st_lsm6dsx: always enter interrupt thread
Date:   Mon,  9 Sep 2019 11:45:04 +0200
Message-Id: <20190909094506.51792-4-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909094506.51792-1-sean@geanix.com>
References: <20190909094506.51792-1-sean@geanix.com>
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
index 68df2a8d628b..7ab31206104e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1681,9 +1681,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 
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

