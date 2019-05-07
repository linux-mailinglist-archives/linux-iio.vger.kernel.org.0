Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92EBB15EDD
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 10:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfEGIMI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 04:12:08 -0400
Received: from first.geanix.com ([116.203.34.67]:42360 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfEGIMI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 May 2019 04:12:08 -0400
Received: from zen.localdomain (unknown [85.184.147.232])
        by first.geanix.com (Postfix) with ESMTPSA id 8641E9E7;
        Tue,  7 May 2019 08:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1557216129; bh=epJzmFCOzrZ6SzXewbx5cV2M9n1CDFNH7sohWDJ5aSo=;
        h=From:To:Cc:Subject:Date;
        b=QdQjc1Ypi3ykaGWrQu2dGP4CXfuvycujRzBRfaGlGojGVcvAsdCzDwfoUULx0Yr3v
         TiXdwaouwMgC6CgBEIAz9Tb3Ply9sh+EVNGUKioTttiHUoT3zmph4BhpvchB/YYDHN
         Ph++cOfnz3VWTbpajyX0vfiLWyZBgB0NunVypDcQ/6Miehr0QdEMF6wfqfZDv7hD5R
         l3FcaAh6jiuKyisCrzY6EZ97WApgcsC+gFkQq3CuDUkw5prKdqGQ/Zqw+O0Nrh1OjC
         7KqxWbuRz8xp1tRswzyMD/9HEmUyYxc3lXbDNV+RIv0XOo/Gu3yWOA+1OwBTHu5xtJ
         d5xAKrdLdNS8Q==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: only set available_scan_masks if using device fifo
Date:   Tue,  7 May 2019 10:02:24 +0200
Message-Id: <20190507080225.108000-1-sean@geanix.com>
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

We only need available scan_masks set if we are going to use the
onboard fifo. Unfortunately it requires the IRQ pins to be connected
to the SoC.
The next patch in this series add support for iio triggered buffer
for use with iio triggers.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index cf82c9049945..1ca69598678f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1007,7 +1007,6 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 
 	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->dev.parent = hw->dev;
-	iio_dev->available_scan_masks = st_lsm6dsx_available_scan_masks;
 
 	sensor = iio_priv(iio_dev);
 	sensor->id = id;
@@ -1074,6 +1073,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 		hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
 		if (!hw->iio_devs[i])
 			return -ENOMEM;
+
+		hw->iio_devs[i]->available_scan_masks =
+				 st_lsm6dsx_available_scan_masks;
 	}
 
 	err = st_lsm6dsx_init_device(hw);
-- 
2.21.0

