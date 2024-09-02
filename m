Return-Path: <linux-iio+bounces-8999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C89968786
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 14:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F252DB27A54
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F7118592D;
	Mon,  2 Sep 2024 12:28:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30619E97A;
	Mon,  2 Sep 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280124; cv=none; b=Tnn2BaqVIsHKLPAKx1De5ytSdng/SwiduO5KwEJOicGXa6ZSWBdfUoExoGvk15w2UbFaCFHOTgEnh3vTvZuxHBfLxvnZxSHjKicxjUsYus0GxeDzzDr8OV5AvPdGya0TKxhqJkrtl5/CZY+HPmfc7CwthV/UdmwvPBaGd/AYnvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280124; c=relaxed/simple;
	bh=/dMrchNLwUohDjHIrvkMoicr42iwrfGgsm7r4UuC8do=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HxgfOZGyPyBxP9yhd7DEMWtjetrotVCKcrt0R8VOG7UY5BVJEMw+ZIR0MEss7PuvcxC+U9UdMsj7UIQGET5fkIv9My8klq9c2bLBTjMTi3csgecas2/n+laWUhXKYANb0TKMS+TzAzerTjEbGL4eXK+VRhxkcO50skIQdD6QUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wy7MS4dC1z2Dbdc;
	Mon,  2 Sep 2024 20:28:20 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 815B31402CC;
	Mon,  2 Sep 2024 20:28:38 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Sep
 2024 20:28:38 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <patrick.havelange@essensium.com>, <wbg@kernel.org>,
	<liaochen4@huawei.com>
Subject: [PATCH -next] counter: ftm-quaddec: Enable module autoloading
Date: Mon, 2 Sep 2024 12:20:14 +0000
Message-ID: <20240902122014.905237-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules can be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/counter/ftm-quaddec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 200876f3ec04..6ac4efb5658b 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -311,6 +311,7 @@ static const struct of_device_id ftm_quaddec_match[] = {
 	{ .compatible = "fsl,ftm-quaddec" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, ftm_quaddec_match);
 
 static struct platform_driver ftm_quaddec_driver = {
 	.driver = {
-- 
2.34.1


