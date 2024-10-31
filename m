Return-Path: <linux-iio+bounces-11666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B9C9B724E
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 02:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE691F2592B
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 01:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78A82499;
	Thu, 31 Oct 2024 01:58:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2A53A7;
	Thu, 31 Oct 2024 01:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339923; cv=none; b=PdbAenxTNMeMQVq/fwOjNdllaCDj01pVQTGU1CLi3nud2zjpqeLJyHqFiBDAUrzaYC2onm//za5mgvHiD9cMKaoSB2/5PpQbmeLillSziVV5wm36OFMZvPtRK76igTmYgqSTo8btzgOL4SYgMxMCoa26YYTdcgmiDPYDIz81lrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339923; c=relaxed/simple;
	bh=BMO5Um2k402N5llMU45si6zlYft08g0myJPm9Zl04xk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s4NMqjdriaDRiiS6on58n6XhIgwPecFtDnLAxJKavJeCqV8RMRMCLx1pB58VrXXxDitYJbwzEyXVuQeS47TTvIqrwra9EHwdMQY6/dSYMOKZM2h+MExhI2E+H5gSw/TUC3Xqc0CX5ZTd5LCCMeUHQ5kmOoxCTSrPryjicNAT3lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xf6Yq5M9bz2FblB;
	Thu, 31 Oct 2024 09:57:03 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id A93F31400DC;
	Thu, 31 Oct 2024 09:58:36 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 31 Oct
 2024 09:58:36 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <mazziesaccount@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH] iio: fix memory leak for iio_gts_build_avail_scale_table()
Date: Thu, 31 Oct 2024 01:47:43 +0000
Message-ID: <20241031014743.2313121-1-quzicheng@huawei.com>
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
 kwepemd200012.china.huawei.com (7.221.188.145)

In iio_gts_build_avail_scale_table(), the memory allocated for
per_time_gains is freed using kfree(per_time_gains) before return 0.
However, the type per_time_gains is 'int **', and the memory allocated
for its inner elements is not being freed, leading to a memory leak.

Cc: stable@vger.kernel.org # v6.6+
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/iio/industrialio-gts-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 59d7615c0f56..f2450b2e740d 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -307,6 +307,8 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
 	if (ret)
 		goto err_free_out;
 
+	for (j = 0; j < gts->num_itime; j++)
+		kfree(per_time_gains[i]);
 	kfree(per_time_gains);
 	gts->per_time_avail_scale_tables = per_time_scales;
 
-- 
2.34.1


