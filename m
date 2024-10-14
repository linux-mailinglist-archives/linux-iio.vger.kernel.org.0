Return-Path: <linux-iio+bounces-10542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C8999BD50
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 03:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04671C2098F
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 01:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CBF125D5;
	Mon, 14 Oct 2024 01:32:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F68467;
	Mon, 14 Oct 2024 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869556; cv=none; b=iLLMviTT45lCApT/yKXjhQ7G+TBjzwMqJJYc4pRq6i8QyMNZ9+L1ms7oRCHlNkOKDoUAnng6omI/a2jeUUOThC/sJKGZ1vUd4FIx0CuZU2ywsbU+XH/XrhB0aWFH2G3BvVEoSOEGpl2B9p7dm6uUeiSu7kQSUq2Sc1LMHZCWXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869556; c=relaxed/simple;
	bh=KVDrxYKHYjVA7XmZNJSQ+lLsGlGS6ctGVksU9NQCHTo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ABxQr9qgZte2TZtvxBopYA/r6aTO7f41YKtGeDP5Sh4TbhNxopbqlQ8u2GkR84/vL9+euLkp0eVZcGfa9bhQ40mTAIwK+VLSToaF1aHJn8cwGn0aB2byfM70j4WKZtVUXzotvTvtaYhKNUVnTEO8pUZj83tw2jjcvd0qKmyZmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XRfnF6VcQz1T8Zh;
	Mon, 14 Oct 2024 09:30:41 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 472F0140137;
	Mon, 14 Oct 2024 09:32:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Oct
 2024 09:32:30 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <mazziesaccount@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] iio: gts-helper: Fix memory leaks for i = 1 error path
Date: Mon, 14 Oct 2024 09:31:44 +0800
Message-ID: <20241014013144.576701-1-ruanjinjie@huawei.com>
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

If i = 1, and per_time_scales[i] or per_time_gains[i] kcalloc fails in
iio_gts_build_avail_scale_table(), the err_free_out will fail to enter
kfree for loop because i-- is 0, and all the per_time_scales[0] and
per_time_gains[0] will not be freed, which will cause memory leaks.

Fix it by checking if i >= 0.

Cc: stable@vger.kernel.org
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
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


