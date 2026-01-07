Return-Path: <linux-iio+bounces-27509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C6CFCA1B
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 09:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D17DA301F278
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 08:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B84928E571;
	Wed,  7 Jan 2026 08:31:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E6283FEA;
	Wed,  7 Jan 2026 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774671; cv=none; b=qFtPbujKLrPFAUXZfRkDy4T+VOQvg0IkAarKhXILkckqEb7vf7TunutFA3l57wZ5cwkapHt8RiQKnqfW4tR7H3mNU3QMnyrBKlhG1kVkHOSPoB027LRlc4jZalsbfCiarImNKv0SNMkKgTD5eWsfBQ8eaWcfttnQo86eY0ouRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774671; c=relaxed/simple;
	bh=Pv3YfgIoJaLKQBXGHTj2qArCd/34qH8pE1yTj2QFILU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iFelajnHvHEfsc61LCFV9yn0g7foV9kuJ1aenGWPMfxM2rFfT4KuXae1cYoe7P1ut+bnQ80/wiQ53D32joJUxGv0H0riW8JtMra0Pdecw2ZUnCP40k6PocS1DiZWpBGtzwy2EP8xzCUWQtDkQn/Kyx1c83dJCq0HFo6VobNV9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAA3T9bEGV5pHtbxAw--.28951S2;
	Wed, 07 Jan 2026 16:31:00 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	mazziesaccount@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] iio: adc: ad7476: Remove duplicate include
Date: Wed,  7 Jan 2026 16:29:20 +0800
Message-Id: <20260107082920.2151042-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3T9bEGV5pHtbxAw--.28951S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYC7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVWYoVW2owAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCF54
	CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRVuWdU
	UUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove duplicate inclusion of linux/bitops.h.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/iio/adc/ad7476.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 1bec6657394c..21d3f6aae972 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -16,7 +16,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/bitops.h>
 #include <linux/delay.h>
 
 #include <linux/iio/iio.h>
-- 
2.25.1


