Return-Path: <linux-iio+bounces-25903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D548CC34F33
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 10:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAEBC4FC3DD
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 09:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F13009C3;
	Wed,  5 Nov 2025 09:47:41 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02071304BC2;
	Wed,  5 Nov 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336061; cv=none; b=DTcp9Yz9XN3PaSQjP5hr8rDDzjDJCwFOYLYIYZ7IVoq53G2W9MOe2GxP+/YrNxA9oFjdt5qk4a86vg7FKDspuZJQi2q34U0oziN7DkuzwXxkR/o5QnG8aDelSwc+qivacnSraEgD83kl9rbRPn/asNS+UPgBKArHL87KPuO7H/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336061; c=relaxed/simple;
	bh=k1tWbrj9M+uHbTZs67mYDrUUfWBdzxbLBbr+U38sZc0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lckR/IhPznOlet7635Nno0160KbImZY8vmE2pbWY5+aq+LWe+IQnCZkwXQ6vuw+JgFqmy6k5GuXGR69zrWIWumKkfBaHchT+LANEa7v9A1g1DHWbMbNMLr+NdSNwo8vDK6f5IZSMLTsguGkJsdC3wx5B1HZr857UjOwHvKL0c+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-01 (Coremail) with SMTP id qwCowADXQWwjHQtp27SKAQ--.284S2;
	Wed, 05 Nov 2025 17:47:23 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	error27@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: trigger: Fix error handling in viio_trigger_alloc
Date: Wed,  5 Nov 2025 17:47:14 +0800
Message-Id: <20251105094714.28117-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:qwCowADXQWwjHQtp27SKAQ--.284S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFy3uryUKFyUJw4DAr13Arb_yoWkCFgE9a
	na9rn7uw1UAw4kKF1fAr4rZFWIkrW7Kr92yr4SqasYgry3Xrs5XFnrWrsxtF4UWr45GFn8
	X3WY9rykJ3W3CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjWxR3UU
	UUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

viio_trigger_alloc() initializes the device with device_initialize()
but uses kfree() directly in error paths, which bypasses the device's
release callback iio_trig_release(). This could lead to memory leaks
and inconsistent device state.

Replace kfree(trig) with put_device(&trig->dev) in error paths to
ensure proper cleanup through the device's release callback.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 2c99f1a09da3 ("iio: trigger: clean up viio_trigger_alloc()")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/iio/industrialio-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..981e19757870 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -597,7 +597,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 free_descs:
 	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 free_trig:
-	kfree(trig);
+	put_device(&trig->dev);
 	return NULL;
 }
 
-- 
2.17.1


