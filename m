Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B3A359624
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 09:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhDIHP2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 03:15:28 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51949 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229803AbhDIHP2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 03:15:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UUyaniy_1617952509;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UUyaniy_1617952509)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 09 Apr 2021 15:15:13 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jikos@kernel.org
Cc:     jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] HID: hid-sensor-custom: remove useless variable
Date:   Fri,  9 Apr 2021 15:15:08 +0800
Message-Id: <1617952508-47150-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix the following gcc warning:

drivers/hid/hid-sensor-custom.c:400:7: warning: variable ‘ret’ set but
not used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hid/hid-sensor-custom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 2628bc5..e430673 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -397,15 +397,14 @@ static ssize_t store_value(struct device *dev, struct device_attribute *attr,
 
 	if (!strncmp(name, "value", strlen("value"))) {
 		u32 report_id;
-		int ret;
 
 		if (kstrtoint(buf, 0, &value) != 0)
 			return -EINVAL;
 
 		report_id = sensor_inst->fields[field_index].attribute.
 								report_id;
-		ret = sensor_hub_set_feature(sensor_inst->hsdev, report_id,
-					     index, sizeof(value), &value);
+		sensor_hub_set_feature(sensor_inst->hsdev, report_id, index,
+				       sizeof(value), &value);
 	} else
 		return -EINVAL;
 
-- 
1.8.3.1

