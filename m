Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F656B1A73
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbfIMJH0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 05:07:26 -0400
Received: from first.geanix.com ([116.203.34.67]:49592 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387819AbfIMJH0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Sep 2019 05:07:26 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id BD61B650D4;
        Fri, 13 Sep 2019 09:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568365600; bh=uFNkWZhDh0OLOXnrW7dMbKAsJzNlL7W4/9q3iYbbha8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ter/CJI8MRfBYuqFrY5JdJu9vaIF+QeGfhNQ0DkHBJW9xkGGd3wME1JHtbtjQ3qZB
         NIzGxvU5kq1Sybz7+9qzw9Xg5+BEatL+iUqoK858lyRp2d0zhiUl39bZyk03+wd1Ow
         r44RamgQ6ciCk3ojYoQ6TJjY5vFToxqeHY2J8aRxMiFyzx6bNcOsKwhd2RVSZJudfh
         49E7SZj7HMJ8DVq2e9tohZOWIR7PdJt0G0PK3wt8tkTR7hU6M4QGUGW/JHoojesBsO
         4PlTJzLeVjen1OIOkFkEs0Md9/pfh20TnOVfle53T+XZj5lE10cG8TExaeyfqhkPcI
         4/Fz1eGXe5Xdw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v8 4/5] iio: imu: st_lsm6dsx: always enter interrupt thread
Date:   Fri, 13 Sep 2019 11:07:07 +0200
Message-Id: <20190913090708.1442057-5-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913090708.1442057-1-sean@geanix.com>
References: <20190913090708.1442057-1-sean@geanix.com>
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
index 810807c52d5f..80a94335175f 100644
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

