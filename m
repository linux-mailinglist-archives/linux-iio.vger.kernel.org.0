Return-Path: <linux-iio+bounces-26617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD33C9ABA1
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 09:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8AD7345DD9
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 08:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7988E3054C2;
	Tue,  2 Dec 2025 08:40:54 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E762F691B;
	Tue,  2 Dec 2025 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764664854; cv=none; b=D3MacIXziYTit2+LErPkTUBZKSAWqot6qGI0L8BvKnkAM2pdKGn8ZU50QY6izNFl+Nbc6i0k6swpEVKgu9vVYOriIIERVSsvMG0FEUpnVfYdZo7h9hIlgxo1h8sODjHnG7IJPS1Een5ov9W7IzMXspt5tlhe+IaK5mTGdi0uLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764664854; c=relaxed/simple;
	bh=iD0+avu6pX4z2YnF8WjTS6d7hUKbsFDLIFXQ4T7IpHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTjPO6AVZd8AK53fHC4NPpwaKtjMwF2BSsqtGzMyfyASzR8yBjwxGg4stZO079LMOErjIimJC8zlXo1oSwvDs+g4XMNRs+QirtfQmf2UduQ/QjHBfi7+WuUsAJuMlSBuLmj91zD5NJNCWXA8Pk4yKiNAt6SlgSXGr2kHumkMRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowACHHc0Npi5pGWLWAg--.48847S2;
	Tue, 02 Dec 2025 16:40:46 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: wbg@kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] counter: 104-quad-8: Fix incorrect return value in IRQ handler
Date: Tue,  2 Dec 2025 16:39:52 +0800
Message-ID: <20251202083952.1975-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHHc0Npi5pGWLWAg--.48847S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4rKFW7XrWfKryrtw4ruFg_yoWkCrb_ur
	nrZwnrAFW7tr1DCrZIgr1Yv3sIv3Z5WFyfJF47tFy3t34DWr9Ivr18Zrn8GF4xWr48AFnx
	KFn5CrWIkry7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjO6pDUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsEA2kuYGnb5AACs4

quad8_irq_handler() should return irqreturn_t enum values, but it
directly returns negative errno codes from regmap operations on error.

Return IRQ_NONE instead of raw errno codes on regmap operation failures.

Fixes: 98ffe0252911 ("counter: 104-quad-8: Migrate to the regmap API")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/counter/104-quad-8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index ce81fc4e1ae7..17f4da6c24af 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1201,7 +1201,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 
 	ret = regmap_read(priv->map, QUAD8_INTERRUPT_STATUS, &status);
 	if (ret)
-		return ret;
+		return IRQ_NONE;
 	if (!status)
 		return IRQ_NONE;
 
@@ -1233,7 +1233,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 
 	ret = regmap_write(priv->map, QUAD8_CHANNEL_OPERATION, CLEAR_PENDING_INTERRUPTS);
 	if (ret)
-		return ret;
+		return IRQ_NONE;
 
 	return IRQ_HANDLED;
 }
-- 
2.50.1.windows.1


