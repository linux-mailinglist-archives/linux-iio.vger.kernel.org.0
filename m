Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DACB0928
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfILHG0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 03:06:26 -0400
Received: from first.geanix.com ([116.203.34.67]:53092 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbfILHG0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Sep 2019 03:06:26 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 1192564D9A;
        Thu, 12 Sep 2019 07:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568271944; bh=J77mp1xbabMYn1/oRXzKQSBBQL0IN/nuqIPDb4vlwFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bznNWcSRtE2CjgerWfKy2XCM7vXIWs9LLAlK1xMR5s1QO8xQjVlTM9a2oslfTJ797
         3/8eIfVXJzCsi61/bLyVtWDqox5w+TkOIR3nROi0YCSGD4ivKZH8UtICA8EeksoCsH
         6t89FEeadg6BTYUKGipmxCOMDr44KKVD5zIOt/4sBo4j7Mwcn3I8Gy8Yxc3HQt2VWT
         s2CgCpmK7VR7hWy6TcO6bHPbQagHtpoghdNEaB0tvc81dL3+QyghkSE9jXGhfZxN59
         PEME+y4MXXHrBb7qwnq4VmmqApgIT/XDK/SiNH87TywFP1CnYaoxHmjrdWCissxaXG
         tmQ/tv33rLPYQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v7 4/5] iio: imu: st_lsm6dsx: always enter interrupt thread
Date:   Thu, 12 Sep 2019 09:06:13 +0200
Message-Id: <20190912070614.1144169-5-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190912070614.1144169-1-sean@geanix.com>
References: <20190912070614.1144169-1-sean@geanix.com>
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
index f79978a2870f..c0568ab69a77 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1717,9 +1717,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 
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

