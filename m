Return-Path: <linux-iio+bounces-26004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D0BC3E30E
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 03:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 895164E43EC
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 02:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6367626CE2D;
	Fri,  7 Nov 2025 02:02:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BA1F8AC5;
	Fri,  7 Nov 2025 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480957; cv=none; b=HzWaG1p93rm9Goma5nivGgKtXm7zcoIzLmg5j3AYWmvBFfGV8LuxntQdLAFf3dC5sJZfHpL1YSOV3zAvN1vV9M/XGXIZQ7GAAis3rLCb1/ZruLqV3yZ+Qe4LtHwV0KJB3cgR3IGH0EhICTy5vUHIr7Uczmp3KU9cTI/5QLmymxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480957; c=relaxed/simple;
	bh=kCB4KWLVe36DQ6wTdgNiQBnbTyRXqUgiTbvbgnzh0jc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jgJEscmK5PkrdhdcrhtxCqesIffZ1uisNUNIg3VBHfaTCkHFAl/FiAmggy6pqzHABdNHe25bMOkRDWQy4Ty1l2STeM7MIxtWPTet+RDwS5zIzRCVk2Rm+I5epEZom1BbmRJfTWsRz2BC5WdXs+QDvy9hl2g9ZSGol2gX39hmDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowAD3ZvUZUw1plVrWAQ--.41683S2;
	Fri, 07 Nov 2025 10:02:11 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v3] iio: trigger: Fix error handling in viio_trigger_alloc
Date: Fri,  7 Nov 2025 10:02:00 +0800
Message-Id: <20251107020200.6285-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowAD3ZvUZUw1plVrWAQ--.41683S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWkCF1kGF18ZryxKFy3Jwb_yoW8ZFWUpa
	n7Z3yUtFWkJF1kXF47Zry8Xa4fKa1rK3W5KFW0934ak3y5XryrKFyxAFWUAw18JrW8XrsF
	qF9rXa45Cr17XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUkHUDUUUUU=
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

Additionally, the current error handling has the following issues:
1. Potential double-free of IRQ descriptors when kvasprintf() fails.
2. The release function may attempt to free negative subirq_base.
3. Missing mutex_destroy() in release function.

Fix these issues by:
1. Replacing kfree(trig) with put_device(&trig->dev) in error paths.
2. Removing the free_descs label and handling IRQ descriptor freeing
   directly in the kvasprintf() error path.
3. Adding missing mutex_destroy().

Found by code review.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/iio/industrialio-trigger.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..7576dedee68e 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -524,6 +524,7 @@ static void iio_trig_release(struct device *device)
 			       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 	}
 	kfree(trig->name);
+	mutex_destroy(&trig->pool_lock);
 	kfree(trig);
 }
 
@@ -575,8 +576,10 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 		goto free_trig;
 
 	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
-	if (trig->name == NULL)
-		goto free_descs;
+	if (trig->name == NULL) {
+		irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
+		goto free_trig;
+	}
 
 	INIT_LIST_HEAD(&trig->list);
 
@@ -594,10 +597,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 
 	return trig;
 
-free_descs:
-	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 free_trig:
-	kfree(trig);
+	put_device(&trig->dev);
 	return NULL;
 }
 
-- 
2.17.1


