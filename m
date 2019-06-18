Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20284A14B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 14:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFRM76 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 08:59:58 -0400
Received: from first.geanix.com ([116.203.34.67]:37326 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfFRM75 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 08:59:57 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 6325EB0E;
        Tue, 18 Jun 2019 12:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560862789; bh=XvLp6MObahEArU1VuFlBiaL0pBUWQvqL0S1HHeUDYpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NB/gH0lTMmbM9H+O6VnI+AP3T31PBv6uOCsEIX2aJg9Ac8LWiQht+EvDpZYXIaA4m
         ZOuM6xAXiJJapUSyHQoqsyg6rzEjCybvcxn0mUkuNzQfd+OynihOCDUgpy+MSY1wqM
         HsxxIqkDFawzAAfemZlGBEsdOLa6QCd21Zin/nxvZvbWyiDf7TwsssNlDiouixOSG1
         hEp7ZafvROx+UpbGIpUzYULzfQSreFeTM2BC2kCUgGfKqiM03JqjNCwVUB/163yjS4
         w+SdNGgsMkRNig5k9o7hVGp/a/D5UJ04taEAqXwNu0rZnlWcQqLys8FpvMo1aPvA0X
         9F8xeyA2b6PEw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        martin@geanix.com
Subject: [PATCH 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
Date:   Tue, 18 Jun 2019 14:59:37 +0200
Message-Id: <20190618125939.105903-4-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618125939.105903-1-sean@geanix.com>
References: <20190618125939.105903-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

this add ways for the SoC to wake from accelerometer wake events.

In the suspend function we skip disabling the sensor if wakeup-source
and events are activated.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 351c46f01662..59a34894e495 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1076,6 +1076,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 			return err;
 	}
 
+	if (dev->of_node)
+		if (of_property_read_bool(dev->of_node, "wakeup-source"))
+			device_init_wakeup(dev, true);
+
 	return 0;
 }
 EXPORT_SYMBOL(st_lsm6dsx_probe);
@@ -1088,6 +1092,12 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 	int i, err = 0;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		if (device_may_wakeup(dev) && (i == ST_LSM6DSX_ID_ACC)) {
+			/* Enable wake from IRQ */
+			enable_irq_wake(hw->irq);
+			continue;
+		}
+
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
@@ -1112,6 +1122,11 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 	int i, err = 0;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		if (device_may_wakeup(dev) && (i == ST_LSM6DSX_ID_ACC)) {
+			disable_irq_wake(hw->irq);
+			continue;
+		}
+
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
-- 
2.22.0

