Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C94335BC52
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbhDLIjQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 04:39:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16566 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbhDLIjQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 04:39:16 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FJht213lTz1BGYY;
        Mon, 12 Apr 2021 16:36:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 16:38:49 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <jic23@kernel.org>, <tduszyns@gmail.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC:     <linux-iio@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH drivers/iio 3/3] iio: trigger: stm32-timer: Convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Mon, 12 Apr 2021 16:39:11 +0800
Message-ID: <1618216751-1678-4-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618216751-1678-1-git-send-email-tiantao6@hisilicon.com>
References: <1618216751-1678-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix the following coccicheck warning:
drivers/iio/trigger/stm32-timer-trigger.c:299:8-16: WARNING:
use scnprintf or sprintf

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 3aa9e8b..3308387 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -296,7 +296,7 @@ static ssize_t stm32_tt_show_master_mode(struct device *dev,
 	else
 		cr2 = (cr2 & TIM_CR2_MMS) >> TIM_CR2_MMS_SHIFT;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", master_mode_table[cr2]);
+	return sysfs_emit(buf, "%s\n", master_mode_table[cr2]);
 }
 
 static ssize_t stm32_tt_store_master_mode(struct device *dev,
-- 
2.7.4

