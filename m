Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C8A178F9E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 12:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbgCDLfN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 06:35:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726440AbgCDLfN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Mar 2020 06:35:13 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A00CA218892F29E61954;
        Wed,  4 Mar 2020 19:35:05 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Mar 2020
 19:34:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ak@it-klinger.de>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Jonathan.Cameron@huawei.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] iio: ping: set pa_laser_ping_cfg in of_ping_match
Date:   Wed, 4 Mar 2020 19:34:23 +0800
Message-ID: <20200304113423.26920-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

pa_laser_ping_cfg should be set in of_ping_match
instead of pa_ping_cfg.

Fixes: 7bb501f49ddb ("iio: ping: add parallax ping sensors")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/proximity/ping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
index 34aff10..12b893c 100644
--- a/drivers/iio/proximity/ping.c
+++ b/drivers/iio/proximity/ping.c
@@ -269,7 +269,7 @@ static const struct iio_chan_spec ping_chan_spec[] = {
 
 static const struct of_device_id of_ping_match[] = {
 	{ .compatible = "parallax,ping", .data = &pa_ping_cfg},
-	{ .compatible = "parallax,laserping", .data = &pa_ping_cfg},
+	{ .compatible = "parallax,laserping", .data = &pa_laser_ping_cfg},
 	{},
 };
 
-- 
2.7.4


