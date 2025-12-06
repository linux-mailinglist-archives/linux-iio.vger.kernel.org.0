Return-Path: <linux-iio+bounces-26840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E216CCAABBF
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 19:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E27D300B908
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 18:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444D629C327;
	Sat,  6 Dec 2025 18:01:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D92E645;
	Sat,  6 Dec 2025 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765044092; cv=none; b=MbCpsehym57b7sedss71ihm1NZgEBS+hHEd5EGDLM/18tcptyKoB9jRXBnG+p9IqOvy9dTO4asaiqJhxymse7lbj8YTkF+hoYYCHWXa5VJm4uQXm8SK8OIkjtFEPy5VNE+hpVBnnk2mxcznv0jO0GYM78uzuxMGgosCJFrvY5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765044092; c=relaxed/simple;
	bh=9AYL9BfY9e0dv0XpZDt9tyofUrWpSsh6wl8ybUzpub0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn2HedJ01r7Ld5+SytBtDHLdkXzY+/BK7qUbHSWfW/fg5QLes2Qyx5dumyQG6cKZL59PDxdfMRdaNejsRUZ8SrMwzocTApiA+R26JUpFulqEwfs/T76b5Zdw5YX6burI6JrSUcHo2jKw9c3q/qjx9EF+jYf9u2tijkjM4nqwujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [114.245.38.183])
	by APP-01 (Coremail) with SMTP id qwCowACXLMxtbzRp+RdNAw--.8335S2;
	Sun, 07 Dec 2025 02:01:19 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: wbg@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v2] counter: 104-quad-8: Fix incorrect return value in IRQ handler
Date: Sun,  7 Dec 2025 02:00:07 +0800
Message-ID: <20251206180007.1365-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20251202083952.1975-1-vulab@iscas.ac.cn>
References: <20251202083952.1975-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXLMxtbzRp+RdNAw--.8335S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1kGw4ftr15Kw4DJFWfAFb_yoW8WrW7pr
	Wjya4qy3WrZr4UXF4Fya17J3Z0va42qrW3uw1xuw43Zwn0yr4j9ay8KFyjqrWfCrW8GF17
	Z3y7CF4rCa15AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7UUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4IA2k0KSgPsQACss

quad8_irq_handler() should return irqreturn_t enum values, but it
directly returns negative errno codes from regmap operations on error.

Return IRQ_NONE if the interrupt status cannot be read. If clearing the
interrupt fails, return IRQ_HANDLED to prevent the kernel from disabling
the IRQ line due to a spurious interrupt storm. Also, log these regmap
failures with WARN_ONCE.

Fixes: 98ffe0252911 ("counter: 104-quad-8: Migrate to the regmap API")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
Changes in v2:
  -Return IRQ_HANDLED if regmap_write() fails.
  -Add WARN_ONCE() to log the error messages.
---
 drivers/counter/104-quad-8.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index ce81fc4e1ae7..836ab9349dd7 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1200,8 +1200,10 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 	int ret;
 
 	ret = regmap_read(priv->map, QUAD8_INTERRUPT_STATUS, &status);
-	if (ret)
-		return ret;
+	if (ret) {
+		WARN_ONCE(true, "quad8: regmap_read failed: %d\n", ret);
+		return IRQ_NONE;
+	}
 	if (!status)
 		return IRQ_NONE;
 
@@ -1232,8 +1234,10 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 	}
 
 	ret = regmap_write(priv->map, QUAD8_CHANNEL_OPERATION, CLEAR_PENDING_INTERRUPTS);
-	if (ret)
-		return ret;
+	if (ret) {
+		WARN_ONCE(true, "quad8: regmap_write failed: %d\n", ret);
+		return IRQ_HANDLED;
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.50.1.windows.1


