Return-Path: <linux-iio+bounces-26116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 444B3C44DE9
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 04:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6851D4E6E38
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 03:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103FB28C5B1;
	Mon, 10 Nov 2025 03:57:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0F28C849;
	Mon, 10 Nov 2025 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747051; cv=none; b=c/qBX0TScELKRy2VYh87RYuhUqscmpViOm9o5HlxXhwMNE6CtELUylHfb9rXQNyO01KAko+tTFyJ18T5q0lAjI7nRdVWkHBQwHyWIXU758uZf9UaSqfM4R5KpDAQocmESHOC31qJ5kxgu7pM3AosydAvThkweZHilk/L/rPsxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747051; c=relaxed/simple;
	bh=AvYHyVvWUBXTXvGWmhush9b6zxfxo027zVKfgAjfc7M=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MexSPOf0LCk9IMkutBs4TmmzIAur94ov5riIwr/bYVUzZh6/mqG9GrBU7Eh+QdSvSyLXpC1J2xsvdfbQ4GNfuV9+PPrc/5b+tcAD608HZtDWvSkphTgMpwkvyg2mDwuQHeoqYXMa7NMnonFaC8SHjUbSWU0yydOA0zKmxnlMqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowAAXHG2QYhFpryowAA--.8967S2;
	Mon, 10 Nov 2025 11:57:14 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v4 1/2] iio: trigger: add missing mutex_destroy in iio_trig_release
Date: Mon, 10 Nov 2025 11:57:01 +0800
Message-Id: <20251110035701.36691-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowAAXHG2QYhFpryowAA--.8967S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1Uuw47AF15ur1fGF18Grg_yoWDArb_Ca
	n3Cwn7uw1jvw4jka13tF43XFs0krWkur1vkFyIqryYgr9IvFs5AFnrWr1UtF4UWr45GFn8
	Z3W5C348A3ZF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4q2NUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

Add missing mutex_destroy() call in iio_trig_release() to properly
clean up the mutex initialized in viio_trigger_alloc(). Ensure proper
resource cleanup and follows kernel practices.

Found by code review.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v4:
- split the patch into two independent patches and modified according to developer's suggestions;
Changes in v3:
- modified the patch;
Changes in v2:
- modified the patch, thanks for developer's suggestions.
---
 drivers/iio/industrialio-trigger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..5baa83349e8f 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -524,6 +524,7 @@ static void iio_trig_release(struct device *device)
 			       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 	}
 	kfree(trig->name);
+	mutex_destroy(&trig->pool_lock);
 	kfree(trig);
 }
 
-- 
2.17.1


