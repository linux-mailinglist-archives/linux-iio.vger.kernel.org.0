Return-Path: <linux-iio+bounces-10650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF4F99FE3B
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 03:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37920287953
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 01:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64D4148FED;
	Wed, 16 Oct 2024 01:25:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA4148828;
	Wed, 16 Oct 2024 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041938; cv=none; b=dqDmJLSnydbCYi1c1FaN+XVVWi0hWmmKe0yfOVU8mk4kw96/vkPtarb+atHTAm5nupE4c65QqZSwV41NzJE87VN63XBojQ+vt7+btQXO/oFCLxucgqgUDe6UqAUg30QrJPxsXwBW0hnzHrbjrzRYIwFLJv6DP8LhNSI4XnNVwLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041938; c=relaxed/simple;
	bh=A0yBaWk5j8WWpvcqYdJ5DZ3LZ3ZYiiORPRkuAsqLd+8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UXmZ61LrYuW+KiA48o1P1PeqcJF1fPjUAcyxc5thkoGPbvYRCgrgo2aGDq5I1ipG9462lR77DW/Ii4A8G+8hMc/yhY01sPycxFSEXIXN7jK4Df39HBR3B1QtbdiVPUow0/0f9QTxSBysVPPY80vkIrTFGGbRTJczjdabmlXBGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XStY058ZNz2Ddhn;
	Wed, 16 Oct 2024 09:24:20 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DC02140136;
	Wed, 16 Oct 2024 09:25:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 16 Oct
 2024 09:25:33 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <mazziesaccount@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] iio: gts-helper: Fix memory leaks for the error path of iio_gts_build_avail_scale_table()
Date: Wed, 16 Oct 2024 09:24:53 +0800
Message-ID: <20241016012453.2013302-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

If per_time_scales[i] or per_time_gains[i] kcalloc fails in the for loop
of iio_gts_build_avail_scale_table(), the err_free_out will fail to call
kfree() each time when i is reduced to 0, so all the per_time_scales[0]
and per_time_gains[0] will not be freed, which will cause memory leaks.

Fix it by checking if i >= 0.

Cc: stable@vger.kernel.org
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Update the commit message.
- Add Reviewed-by.
---
 drivers/iio/industrialio-gts-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 7326c7949244..5f131bc1a01e 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -315,7 +315,7 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
 	return 0;
 
 err_free_out:
-	for (i--; i; i--) {
+	for (i--; i >= 0; i--) {
 		kfree(per_time_scales[i]);
 		kfree(per_time_gains[i]);
 	}
-- 
2.34.1


