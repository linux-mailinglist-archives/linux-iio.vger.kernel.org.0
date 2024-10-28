Return-Path: <linux-iio+bounces-11466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A859B3229
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F441C219B4
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 13:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89A61DD0C6;
	Mon, 28 Oct 2024 13:52:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C61DC19D
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123549; cv=none; b=IQF8J3qbIXDlNV+LZREZqTW9oChBaB08U6TFWxj3ik0Ag1WqS3yTKNq3DvGD5ZfKLM7lVEXBqbQCliQzuxeNB2prCdHYLT09WH3VhqkCMlPNd0emSw/BbJ88ksIeAHnjOGXkEiXyVleB29MDvxAwy9XHyttpi3yX3WR1q8NGGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123549; c=relaxed/simple;
	bh=zFnv03t2lgMFjyGQEKfqPPAzKyh02FIV5eXfK2V2aGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRspTxvEquH7hue6TTrRh8uHoi0IUttptQqT8z9Wdl+wx7Hx1t261DRMc3hK5iECuvLU4jufz5PWNzHVwjE/7o9lCaEAO6hXuprXt+zS6XqFMLFZ00PVa0bp2X5k8E11rAHm6e+Nt4T/H31VnhfhHBCwgwJTSxhaqkhij/8J08I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XcZZH4G9Cz4f3mW0
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 21:52:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 225A81A058E
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 21:52:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.84.26.158])
	by APP4 (Coremail) with SMTP id gCh0CgCHYoYQlx9nmtXDAA--.17462S4;
	Mon, 28 Oct 2024 21:52:19 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: nuno.sa@analog.com,
	olivier.moysan@foss.st.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	yangyingliang@huawei.com,
	bobo.shaobowang@huawei.com,
	Jonathan.Cameron@huawei.com
Subject: [PATCH] iio: backend: fix wrong pointer passed to IS_ERR()
Date: Mon, 28 Oct 2024 21:52:15 +0800
Message-ID: <20241028135215.1549-1-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHYoYQlx9nmtXDAA--.17462S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr18ZF47Zw47GryfAFW5ZFb_yoWDXFg_GF
	18trs7JryjkF1vqrZFvr13WrZ0krWDursakr4ak3yfGa4DAFZYqr1q9F95JFWUWFs8KFy5
	G3ZYkr10vw4SkjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

It should be fwnode_back passed to IS_ERR().

Fixes: c464cc610f51 ("iio: add child nodes support in iio backend framework")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/industrialio-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 20b3b5212da7..fb34a8e4d04e 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -737,8 +737,8 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
 	}
 
 	fwnode_back = fwnode_find_reference(fwnode, "io-backends", index);
-	if (IS_ERR(fwnode))
-		return dev_err_cast_probe(dev, fwnode,
+	if (IS_ERR(fwnode_back))
+		return dev_err_cast_probe(dev, fwnode_back,
 					  "Cannot get Firmware reference\n");
 
 	guard(mutex)(&iio_back_lock);
-- 
2.33.0


