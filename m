Return-Path: <linux-iio+bounces-27080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E461CBC38B
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 03:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E18EF300C2B5
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEACB1FF1C4;
	Mon, 15 Dec 2025 02:04:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636213C8EA;
	Mon, 15 Dec 2025 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765764250; cv=none; b=MrO0yLPJMP2OXDt4Un6It3G0ON1qa/r6X1KCQt8XoH2sPjv+FqPsF2MYEjrgM/xv1MTt/eQ6IqyXI3cJRhRC0ESJUD5NEmtoXpNzHCxWGm61SEhc+s6OP+nnOu2MDG/hGtc4SEVFVvZ/UUOOo8PO6A3RC4bgE/2MMGbcYqRTshk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765764250; c=relaxed/simple;
	bh=BEEmsxlzCrN5ceNiLGBxj9dRct+fsZAiRyA8dgziHXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyIsRpC3BqWc3m6X2oAp6QINkTcmWZ9Cqpx1wSEsZXouQmpXXaj0qcJZrnhadpteiY4ZuIkbKfb+qznIqU2hip7bosa3gXGVesLVuSdrgR6w8MEGLAdtnXbh7nWShbQBne0QLe/79OTn30Wb/ha6qZ839+8Pq0tUTalIHPaJFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowAAnSuGTbD9pWh7BAA--.57049S2;
	Mon, 15 Dec 2025 10:04:03 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: wbg@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v3] counter: 104-quad-8: Fix incorrect return value in IRQ handler
Date: Mon, 15 Dec 2025 10:01:14 +0800
Message-ID: <20251215020114.1913-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAnSuGTbD9pWh7BAA--.57049S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyfuFW3GF17ur13Cry3urg_yoW5XFy8pF
	W0ka4qyF4Sqr1UXF4rA3WDJryY9FW7trWfCrn7Zw1Ivwn0yFW5WFW8Ka4jqrZ3CFWkGFy5
	Z3y3KF48Ca15AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUjR6wtUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAURA2k+0jr0LwAAs-

quad8_irq_handler() should return irqreturn_t enum values, but it
directly returns negative errno codes from regmap operations on error.

Return IRQ_NONE if the interrupt status cannot be read. If clearing the
interrupt fails, return IRQ_HANDLED to prevent the kernel from disabling
the IRQ line due to a spurious interrupt storm. Also, log these regmap
failures with dev_WARN_ONCE.

Fixes: 98ffe0252911 ("counter: 104-quad-8: Migrate to the regmap API")
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
Changes in v3:
  - Replace WARN_ONCE() calls with dev_WARN_ONCE() to automatically include
    device context in log messages.
  - Provide more descriptive warning messages indicating the specific
    register operation that failed.
Changes in v2:
  - Return IRQ_HANDLED if regmap_write() fails.
  - Add WARN_ONCE() to log the error messages.
---
 drivers/counter/104-quad-8.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index ce81fc4e1ae7..573b2fe93253 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1192,6 +1192,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 {
 	struct counter_device *counter = private;
 	struct quad8 *const priv = counter_priv(counter);
+	struct device *dev = counter->parent;
 	unsigned int status;
 	unsigned long irq_status;
 	unsigned long channel;
@@ -1200,8 +1201,11 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 	int ret;
 
 	ret = regmap_read(priv->map, QUAD8_INTERRUPT_STATUS, &status);
-	if (ret)
-		return ret;
+	if (ret) {
+		dev_WARN_ONCE(dev, true,
+			"Attempt to read Interrupt Status Register failed: %d\n", ret);
+		return IRQ_NONE;
+	}
 	if (!status)
 		return IRQ_NONE;
 
@@ -1223,8 +1227,9 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 				break;
 		default:
 			/* should never reach this path */
-			WARN_ONCE(true, "invalid interrupt trigger function %u configured for channel %lu\n",
-				  flg_pins, channel);
+			dev_WARN_ONCE(dev, true,
+				"invalid interrupt trigger function %u configured for channel %lu\n",
+				flg_pins, channel);
 			continue;
 		}
 
@@ -1232,8 +1237,11 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 	}
 
 	ret = regmap_write(priv->map, QUAD8_CHANNEL_OPERATION, CLEAR_PENDING_INTERRUPTS);
-	if (ret)
-		return ret;
+	if (ret) {
+		dev_WARN_ONCE(dev, true,
+			"Attempt to clear pending interrupts by writing to Channel Operation Register failed: %d\n", ret);
+		return IRQ_HANDLED;
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.50.1.windows.1


