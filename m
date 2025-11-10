Return-Path: <linux-iio+bounces-26117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AADC44DF1
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 04:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2CB1345D26
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 03:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E72957B6;
	Mon, 10 Nov 2025 03:58:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231628FFF6;
	Mon, 10 Nov 2025 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747138; cv=none; b=JlBWqOmEVCa4t2xjLzWCLFsX0nmpdpp1hJ+ZcoAVg+OouenksC30XnaXVJ2MoyYboArug08oPqotZefzduJuJoxi2B3y0FyrCSgj2Oc4SB02IcfSmZ3aa6LG6bLm24NLN4XyPF9proRtWxIBmWQTHf+XHzf+gdJ+nFJVWvDknCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747138; c=relaxed/simple;
	bh=ok8NsApduW/IN5cvePLaPGfY//aumNxaday+CPgv2Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OuSZJ48NuPacEQH8BuiGb3OWJl+dlUv9ruez8yjdYV4qiMagaPixMo0chyoREaGf2tK0gh0VNcphmK3IqiD030xTbfYnKXp1tqNqF3BFCc9MYgHqhui1v2dTxclFjdh+TB4YTZ3ffYrwVY2BJ/StGwz0Fw5S7lL4xiLX709JE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowACXm2zvYhFp8DMwAA--.8990S2;
	Mon, 10 Nov 2025 11:58:46 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v4 2/2] iio: trigger: fix device initialization order in viio_trigger_alloc
Date: Mon, 10 Nov 2025 11:58:38 +0800
Message-Id: <20251110035838.37029-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXm2zvYhFp8DMwAA--.8990S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWxZF1kuF1xur43Ar1xuFg_yoW8trW3pr
	Wxuan8tFWDGFy8Gw48Zw1kXry3WanYka1UKF4rC3sY93y5Aryv9ryxtr45Aa1rGrWkZa13
	try3Xa48Cr1DAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe4EEUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Move device initialization to the end of viio_trigger_alloc() to
simplify error handling. This follows the pattern used in similar
functions like spi_alloc_device(), where device_initialize() is called
only after all resources have been successfully allocated.

This change eliminates the need for complex cleanup in error paths and
ensures that the device release callback only runs when the device was
fully initialized.

By moving device_initialize() after all resource allocations, we can
use simple kfree() in error paths instead of put_device(), making the
code more straightforward and less error-prone.

Found by code review.

Suggested-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v4:
- split the patch into two independent patches and modified according to developer's suggestions;
Changes in v3:
- modified the patch;
Changes in v2:
- modified the patch, thanks for developer's suggestions.
---
 drivers/iio/industrialio-trigger.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 5baa83349e8f..760ae3e60639 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -562,12 +562,6 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 	if (!trig)
 		return NULL;
 
-	trig->dev.parent = parent;
-	trig->dev.type = &iio_trig_type;
-	trig->dev.bus = &iio_bus_type;
-	device_initialize(&trig->dev);
-	INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);
-
 	mutex_init(&trig->pool_lock);
 	trig->subirq_base = irq_alloc_descs(-1, 0,
 					    CONFIG_IIO_CONSUMERS_PER_TRIGGER,
@@ -593,6 +587,13 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
 	}
 
+	/* Initialize device only after all resources are allocated */
+	trig->dev.parent = parent;
+	trig->dev.type = &iio_trig_type;
+	trig->dev.bus = &iio_bus_type;
+	device_initialize(&trig->dev);
+	INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);
+
 	return trig;
 
 free_descs:
-- 
2.17.1


