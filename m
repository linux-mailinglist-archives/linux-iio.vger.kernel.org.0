Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E815D38298E
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhEQKNY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 06:13:24 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:36689 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231658AbhEQKNX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 06:13:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UZ7T3sw_1621246318;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UZ7T3sw_1621246318)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 May 2021 18:12:06 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] iio: buffer: Remove redundant assignment to in_loc
Date:   Mon, 17 May 2021 18:11:57 +0800
Message-Id: <1621246317-62725-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Variable in_loc is being assigned a value from a calculation
however the assignment is never read, so this redundant assignment
can be removed.

Clean up the following clang-analyzer warning:

drivers/iio/industrialio-buffer.c:929:3: warning: Value stored to
'in_loc' is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/iio/industrialio-buffer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 10923b4..fdd6234 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -926,7 +926,6 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 		if (ret)
 			goto error_clear_mux_table;
 		out_loc += length;
-		in_loc += length;
 	}
 	buffer->demux_bounce = kzalloc(out_loc, GFP_KERNEL);
 	if (buffer->demux_bounce == NULL) {
-- 
1.8.3.1

