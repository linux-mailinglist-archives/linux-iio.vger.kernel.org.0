Return-Path: <linux-iio+bounces-11824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1EF9B9E50
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 10:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14C72833C5
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E5166308;
	Sat,  2 Nov 2024 09:36:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF216191B;
	Sat,  2 Nov 2024 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730540188; cv=none; b=JHT+lZc2QjEigCIyWUUbLZ5NmYeWUGuJCS6yreJYTO3Xo1BXcv56x1ccOLHm8gzd7+KgncM0YkzqK404/Xcxeg2zw/pHZbwImVR/8sMmSG91C3+wUf4GtudVy30Y6IukqqDzl+xKtp6Vhl667qL/091MVoOVCYulLFkEDBRNR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730540188; c=relaxed/simple;
	bh=OYwd57jp+EOC8Mco+E+PNVXjgwttaxsS7msLmzKS//E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vBDKP8+2ntzqY65DA2NgMKwjG4lA5TxZvJVdBo7AVqTRGZnmSr5hyE3oWp7yeug4GygSb3ad6eolLCVYJlrisCV/8p7R6YiwLC/WL6TfIQs9XOwlAGRjGNFbAb83di34zii8fJ38s2V6Zw3GAvBOtyEx0vneTmH53nMhkxPxZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XgXbv07KlzdkNt;
	Sat,  2 Nov 2024 17:33:47 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 03BEA14038F;
	Sat,  2 Nov 2024 17:36:22 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 2 Nov
 2024 17:36:21 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <nuno.sa@analog.com>,
	<andy.shevchenko@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH] iio: Fix fwnode_handle in __fwnode_iio_channel_get_by_name()
Date: Sat, 2 Nov 2024 09:25:25 +0000
Message-ID: <20241102092525.2389952-1-quzicheng@huawei.com>
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

In the fwnode_iio_channel_get_by_name(), iterating over parent nodes to
acquire IIO channels via fwnode_for_each_parent_node(). The variable
chan was mistakenly attempted on the original node instead of the
current parent node. This patch corrects the logic to ensure that
__fwnode_iio_channel_get_by_name() is called with the correct parent
node.

Cc: stable@vger.kernel.org # v6.6+
Fixes: 1e64b9c5f9a0 ("iio: inkern: move to fwnode properties")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 151099be2863..3305ebbdbc07 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -269,7 +269,7 @@ struct iio_channel *fwnode_iio_channel_get_by_name(struct fwnode_handle *fwnode,
 			return ERR_PTR(-ENODEV);
 		}
 
-		chan = __fwnode_iio_channel_get_by_name(fwnode, name);
+		chan = __fwnode_iio_channel_get_by_name(parent, name);
 		if (!IS_ERR(chan) || PTR_ERR(chan) != -ENODEV) {
 			fwnode_handle_put(parent);
  			return chan;
-- 
2.34.1


