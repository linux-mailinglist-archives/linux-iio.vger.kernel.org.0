Return-Path: <linux-iio+bounces-19527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8508AB80EE
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837B01BC17F2
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3672882A7;
	Thu, 15 May 2025 08:32:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF627FB16;
	Thu, 15 May 2025 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297943; cv=none; b=aGi8cEy6O9L8392l4WkFiyzCT38zY035YovoplMxxM1OrV6eVcQz1OpjcE/JzpIdf3D6b8rVN92LZfbs7uMteFWCWoNRPT0nJn8sZAMOL2jNlg6o1A93ba6hoTX8cstg7C2QO8DDZLpYF4+y+mcHevh3ttYY5mT/uiYWvrt2dpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297943; c=relaxed/simple;
	bh=ft0dKBqcbX3Ig1fHTnCsSOWKg6T6rN12vq7j5B2OZUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=icPL5hpWtEhhlWbmm527xrrFX+3HqC6lrM3taMeSBCRt/ocs6qlfkK4E8nbuQXgOeGpodtPuRb4HKKrFILNnAj5M+oB+kzrIxwvaAWNw1vpHRSC4P6OLqIl/unlw9mIkz0Cx3oS3XgLY4fP1SYwJmMFEPxnSYrN4GIqK0Du/AUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAAHRg58piVoyo_ZFQ--.49488S2;
	Thu, 15 May 2025 16:31:56 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	u.kleine-koenig@baylibre.com,
	tglx@linutronix.de,
	robh@kernel.org,
	jirislaby@kernel.org,
	fabrice.gasnier@foss.st.com
Cc: linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v2] iio: adc: stm32-adc: Fix race in installing chained IRQ handler
Date: Thu, 15 May 2025 16:31:01 +0800
Message-Id: <20250515083101.3811350-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHRg58piVoyo_ZFQ--.49488S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWUJF45KF13ZFyxGw4UArb_yoWkGrgEg3
	97ZwnxGw4Iyr9Iyw17XFnxZa4SqrW8KwsrCr1vvFZ3Gr9rZry5ZrsIvFsxur18WFykCas7
	ZFyxC3yfC3y5GjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRuksqDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Fix a race where a pending interrupt could be received and the handler
called before the handler's data has been setup, by converting to
irq_set_chained_handler_and_data().

Fixes: d58c67d1d851 ("iio: adc: stm32-adc: add support for STM32MP1")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Add Fixes tag.
---
 drivers/iio/adc/stm32-adc-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index bd3458965bff..21c04a98b3b6 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -430,10 +430,9 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < priv->cfg->num_irqs; i++) {
-		irq_set_chained_handler(priv->irq[i], stm32_adc_irq_handler);
-		irq_set_handler_data(priv->irq[i], priv);
-	}
+	for (i = 0; i < priv->cfg->num_irqs; i++)
+		irq_set_chained_handler_and_data(priv->irq[i],
+						 stm32_adc_irq_handler, priv);
 
 	return 0;
 }
-- 
2.25.1


