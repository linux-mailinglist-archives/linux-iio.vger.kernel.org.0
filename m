Return-Path: <linux-iio+bounces-25929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22580C39966
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 09:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BA61A22EA5
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 08:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C0302167;
	Thu,  6 Nov 2025 08:29:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE2B302142;
	Thu,  6 Nov 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417791; cv=none; b=NBvyQEjL9/kSMA5X97wF9oi4smhzTEZvuNKZqp3bKpu+pkwJW9VPc65o8sEc+QZTiFyFsuAwZqVtU4iw19w8XsUqtmYDNFGEYQun3j8o68N93sukagYhNi3ObB3ORvC1USpGvsGorAqnDM4AA0JMktlvJG1XkQh4FxXse9DLsuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417791; c=relaxed/simple;
	bh=UxbC1vicz9GSMfWV81A0ecke1oaKM6VqkOqImVMc98w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WAFO+gfiBmjsGd5os09G+aSQkP72s/j+rzyWv6ZhV4SR1mReg41OY6SxJLBiwUtZYmLDw/khlyvR7OWXJ90By9MTuy0bI3Y3IWl52Nw8S5lA1GH6a+jbnFZReUqyv/J7bidQo+8e0eV8stpUMWhQc5ZrJ7WsXVLA6/2Ag2In7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowAC3NOxkXAxpmp61AQ--.43240S2;
	Thu, 06 Nov 2025 16:29:32 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	error27@gmail.com,
	andriy.shevchenko@intel.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: trigger: Fix error handling in viio_trigger_alloc
Date: Thu,  6 Nov 2025 16:29:23 +0800
Message-Id: <20251106082923.32688-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowAC3NOxkXAxpmp61AQ--.43240S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWkCF1kGF18ZryxKFy3Jwb_yoW8CFWfpa
	n7ZayqkryDJF1kXw47Z3W8ZryfGa1rKa15KF48A3sI93y5XryrKFyIyrWjyw18Jry8XF42
	qasrXa45Cr1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeYLvDUUU
	U
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
1. Potential double-free of IRQ descriptors when kvasprintf fails.
2. The release function may attempt to free negative subirq_base.
3. Missing mutex_destroy in release function.

Fix these issues by:
1. Replacing kfree(trig) with put_device(&trig->dev) in error paths.
2. Setting subirq_base to 0 after freeing IRQ descriptors in error
path to prevent double-free in release callback.
3. Modifying release function to properly handle negative subirq_base.
4. Adding missing mutex_destroy().

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 2c99f1a09da3 ("iio: trigger: clean up viio_trigger_alloc()")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch, thanks for developer's suggestions.
---
 drivers/iio/industrialio-trigger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..9f6d30a244d9 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -524,6 +524,7 @@ static void iio_trig_release(struct device *device)
 			       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 	}
 	kfree(trig->name);
+	mutex_destroy(&trig->pool_lock);
 	kfree(trig);
 }
 
@@ -596,8 +597,9 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 
 free_descs:
 	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
+	trig->subirq_base = 0;
 free_trig:
-	kfree(trig);
+	put_device(&trig->dev);
 	return NULL;
 }
 
-- 
2.17.1


