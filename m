Return-Path: <linux-iio+bounces-10439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B02899A088
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 11:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101721F25AD8
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2970B20FAA2;
	Fri, 11 Oct 2024 09:56:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB6209690;
	Fri, 11 Oct 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640562; cv=none; b=ayCVAEimZaRezVhDa5UBcnXfw3JzpttxJKNhYMhDwRM0NMIICg0W+94MXIYvO7hZFQkOYhTeLM45dMM1FRLB5lIzQJfK49vcL3q45OzbV9eJKXflXbInN8xfV1BIEdJBn+gQavC9z2kFYNJ0lfIpEMfdYS2IoQ1WuAcEtPG6UdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640562; c=relaxed/simple;
	bh=H89xnCSMspvWzseXTG4JMjw7+Hia//k65KxgYeRA+yE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VaelhVj5WMCScRQKYSEIaQICtvuP54HwbYJ/cqxljKiPX9Z6E7Q3HJ+pqgW+Hq46dTVNbndxqheflf0LSniq7sW2iwcC0Wpw31Ki0iQL9omVXR3iRnlZtGcS+Tc6k8Tcvi+zGdGaXWco1W8L07GBBdBJ6GV7S8xWkbZx+F3nVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XQ26K0ZYpz2DdPk;
	Fri, 11 Oct 2024 17:54:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id D0A64140392;
	Fri, 11 Oct 2024 17:55:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 11 Oct
 2024 17:55:56 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <mazziesaccount@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] iio: gts-helper: Fix memory leaks in iio_gts_build_avail_scale_table()
Date: Fri, 11 Oct 2024 17:55:12 +0800
Message-ID: <20241011095512.3667549-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

modprobe iio-test-gts and rmmod it, then the following memory leak
occurs:

	unreferenced object 0xffffff80c810be00 (size 64):
	  comm "kunit_try_catch", pid 1654, jiffies 4294913981
	  hex dump (first 32 bytes):
	    02 00 00 00 08 00 00 00 20 00 00 00 40 00 00 00  ........ ...@...
	    80 00 00 00 00 02 00 00 00 04 00 00 00 08 00 00  ................
	  backtrace (crc a63d875e):
	    [<0000000028c1b3c2>] kmemleak_alloc+0x34/0x40
	    [<000000001d6ecc87>] __kmalloc_noprof+0x2bc/0x3c0
	    [<00000000393795c1>] devm_iio_init_iio_gts+0x4b4/0x16f4
	    [<0000000071bb4b09>] 0xffffffdf052a62e0
	    [<000000000315bc18>] 0xffffffdf052a6488
	    [<00000000f9dc55b5>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000175a3fd4>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000f505065d>] kthread+0x2e8/0x374
	    [<00000000bbfb0e5d>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80cbfe9e70 (size 16):
	  comm "kunit_try_catch", pid 1658, jiffies 4294914015
	  hex dump (first 16 bytes):
	    10 00 00 00 40 00 00 00 80 00 00 00 00 00 00 00  ....@...........
	  backtrace (crc 857f0cb4):
	    [<0000000028c1b3c2>] kmemleak_alloc+0x34/0x40
	    [<000000001d6ecc87>] __kmalloc_noprof+0x2bc/0x3c0
	    [<00000000393795c1>] devm_iio_init_iio_gts+0x4b4/0x16f4
	    [<0000000071bb4b09>] 0xffffffdf052a62e0
	    [<000000007d089d45>] 0xffffffdf052a6864
	    [<00000000f9dc55b5>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000175a3fd4>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000f505065d>] kthread+0x2e8/0x374
	    [<00000000bbfb0e5d>] ret_from_fork+0x10/0x20
	......

It includes 5*5 times "size 64" memory leaks, which correspond to 5 times
test_init_iio_gain_scale() calls with gts_test_gains size 10 (10*size(int))
and gts_test_itimes size 5. It also includes 5*1 times "size 16"
memory leak, which correspond to one time __test_init_iio_gain_scale()
call with gts_test_gains_gain_low size 3 (3*size(int)) and gts_test_itimes
size 5.

The reason is that the per_time_gains[i] is not freed which is allocated in
the "gts->num_itime" for loop in iio_gts_build_avail_scale_table().

Cc: stable@vger.kernel.org
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/iio/industrialio-gts-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 59d7615c0f56..7326c7949244 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -307,6 +307,8 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
 	if (ret)
 		goto err_free_out;
 
+	for (i = 0; i < gts->num_itime; i++)
+		kfree(per_time_gains[i]);
 	kfree(per_time_gains);
 	gts->per_time_avail_scale_tables = per_time_scales;
 
-- 
2.34.1


