Return-Path: <linux-iio+bounces-11664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419CF9B7242
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 02:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24DB285711
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 01:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1630680BF7;
	Thu, 31 Oct 2024 01:56:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241F53A7;
	Thu, 31 Oct 2024 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339764; cv=none; b=rVH8IRb/+oLLuc1W2Y7IHrKrogLMO+8i9UKZVqvxM5imHnoDzTGGAj3ppzskZGNg1s/gzk7wCl5+Y6TsGAPFzvBdqchD3mmh+efk7X6iXFB7iTOa5KJfWn/IXvxgOW4e0GotWOfr9/X3WpJxO7H/6HDOeqa1bHXG9BzSA1gfrQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339764; c=relaxed/simple;
	bh=gEIzvc29LhMk9yeVSoXmqmsbY20YWF+lGKxT9sb5dj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ui/EmLZ1rZ3g0p+4Ys+3hwW+LcWeOfVj0390ujvUDkeq0JnQMH/OynPsMKHiCF4YfJrWpBPbsnfegFNfVPwd7rGUboB4fwPAgu+SzfxYFRtAQksfXHpCLrBudsfuySvvahH+SCSdZ9JBGIS3Ywp/0aqnCwB2tQRlNI1y8W68m7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xf6RP3ftQz1HLDS;
	Thu, 31 Oct 2024 09:51:29 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id B372B18001B;
	Thu, 31 Oct 2024 09:55:58 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 31 Oct
 2024 09:55:58 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <mazziesaccount@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH] iio: Fix uninitialized symbol 'ret'
Date: Thu, 31 Oct 2024 01:45:05 +0000
Message-ID: <20241031014505.2313035-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Initialize the variable ret at the time of declaration to prevent it from
being returned without a defined value. Fixes smatch warning:
drivers/iio/industrialio-gts-helper.c:256 gain_to_scaletables() error:
uninitialized symbol 'ret'.

Cc: stable@vger.kernel.org # v6.6+
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/iio/industrialio-gts-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 59d7615c0f56..c5dc5b51693d 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -167,7 +167,7 @@ static int iio_gts_gain_cmp(const void *a, const void *b)
 
 static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
 {
-	int ret, i, j, new_idx, time_idx;
+	int i, j, new_idx, time_idx, ret = 0;
 	int *all_gains;
 	size_t gain_bytes;
 
-- 
2.34.1


