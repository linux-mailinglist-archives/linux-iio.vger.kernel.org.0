Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3062CAB7F6
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2019 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391958AbfIFMR1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Sep 2019 08:17:27 -0400
Received: from first.geanix.com ([116.203.34.67]:41588 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731749AbfIFMR1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Sep 2019 08:17:27 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 73B646394A;
        Fri,  6 Sep 2019 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567772230; bh=QpTEsfG/6y26j1BsVzsCzmb9pHkycYC3a+LcwjMTIBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=C0DD7cEUyS3jdTztQniuUfFbT20qplcew5WFwSTrUfib7/K6pAfvCdQ8HO8H1eunE
         3e1Ro36woZvrHYSmx8DtSuephLuTqA4uIXiy7kR75MLiBo6QGi7deGOyImppY79q8K
         RDUdLt1MX4SGG1F5YssbE++3uyQonijCVmHbnNTtSXraVA/MQgv/lmAz1nFVxsgkSb
         u3ozq4BiO+dun/QqloRijW2W6Fj8zJuDbQqpMO+quynUFNZ28bY5qkF1x6XdeVzhOa
         /JZqBH06yosZ1kTGrL0/PajHJOahCOfZbt0fmWXK1rRTvEeMB7H20ylbUbcD/Prju6
         unzakY8JB6+aA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v4 4/6] iio: imu: st_lsm6dsx: always enter interrupt thread
Date:   Fri,  6 Sep 2019 14:17:14 +0200
Message-Id: <20190906121716.66194-4-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906121716.66194-1-sean@geanix.com>
References: <20190906121716.66194-1-sean@geanix.com>
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
Changes since v3:
 * Removed unnecessary chunk in handler_irq

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 2dda0f90a816..ce467308eadd 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1614,9 +1614,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 
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

