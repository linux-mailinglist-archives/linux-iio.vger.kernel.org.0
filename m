Return-Path: <linux-iio+bounces-11665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2159B7248
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 02:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711462856D9
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 01:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EDB84A50;
	Thu, 31 Oct 2024 01:57:30 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560FE80025;
	Thu, 31 Oct 2024 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339850; cv=none; b=CrhT+cW26i+JwSq29+g6KsGQUuxVqx6VSZlHeE/aSX9mzTNHijj68RPLE5cqSlnA/jf9EmQjZ6tTRzDZ5c3ggenY2OtmxMirUqtSvRIlQrfl0e1QthlHnYg7eqSLxWsNrSqNPoDjDGtfrNRu4jvhuKiN437SV1y5EugQj0Jx25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339850; c=relaxed/simple;
	bh=v5PD1ALo2kUOkuvSB43wsqgWRa1dMsEL670Ujginra0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ONaTcs6Z2ZZY1YlxKEeCk5FFi/SaduwxmAnYNPjkGd/3qlX3/v6TbUGqixv52W6I/OS22xVCUHzNsnh5J7zjwesGSfMoFw383w+SAMrmS0zDvXmxAPSbrFzByZLotzYxbUAboP7pL0s/Avl5RUXYJJqNdhLlNZiv0Qtzf44e4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xf6Ww20XxzpXdx;
	Thu, 31 Oct 2024 09:55:24 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id AE3FF14011F;
	Thu, 31 Oct 2024 09:57:19 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 31 Oct
 2024 09:57:19 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <mazziesaccount@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH] iio: fix infinite loop for gain_to_scaletables()
Date: Thu, 31 Oct 2024 01:46:26 +0000
Message-ID: <20241031014626.2313077-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200012.china.huawei.com (7.221.188.145)

In iio_gts_build_avail_time_table(), it is checked that gts->num_itime is
non-zero, but gts->num_itime is not checked in gain_to_scaletables(). The
variable time_idx is initialized as gts->num_itime - 1. This implies that
time_idx might initially be set to -1 (0 - 1 = -1). Consequently, using
while (time_idx--) could lead to an infinite loop.

Cc: stable@vger.kernel.org # v6.6+
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/iio/industrialio-gts-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 59d7615c0f56..f3acd392f4fc 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -205,7 +205,7 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
 	memcpy(all_gains, gains[time_idx], gain_bytes);
 	new_idx = gts->num_hwgain;
 
-	while (time_idx--) {
+	while (time_idx-- > 0) {
 		for (j = 0; j < gts->num_hwgain; j++) {
 			int candidate = gains[time_idx][j];
 			int chk;
-- 
2.34.1


