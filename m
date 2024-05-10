Return-Path: <linux-iio+bounces-4921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0008C2025
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 11:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A87CB2135C
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 09:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9480015FA87;
	Fri, 10 May 2024 09:01:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D077119;
	Fri, 10 May 2024 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331691; cv=none; b=HQbeFJ8hnaqFTigVzv2kyBqoQDl6TQ/tMSPay4oEs4JwbTfFQ58DfbzAG4FX0gJXnQWjN4dgD/A7fkuRpsnqpFg+d4CWPWHHpYRxm6dn8+RExw5+0+YJRpG777ONQ8byeSeg/k+9zFTYML1TqLxtDPFiR48KSJ57zNGQRpSThBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331691; c=relaxed/simple;
	bh=MGQgGQ0Iu5HQ3Uu82ZP8L0jLXlDORQB5TOSq/IIUP34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JlpXj0F0Pbo+J3DQ8pItQvRPK4NuyoHpcWNrDIV285ISc3ODIR+pkgWHn8QIow8yP2ELBtPL1Hq2FwBcyZq9jqGygS8hiVJgofUq01FHMgKAX3z9QZKYf2kcn5kRiTFlp98ARi7Jy9ePcfmdxDrTi7VMZG0wmHs+5ZovVHKvgIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowABXX+dg4j1mzzgOCg--.44565S2;
	Fri, 10 May 2024 17:01:20 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: vigneshr@ti.com,
	jpanis@baylibre.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] counter: ti-ecap-capture: Handle error for clk_enable
Date: Fri, 10 May 2024 17:00:59 +0800
Message-Id: <20240510090059.2126666-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXX+dg4j1mzzgOCg--.44565S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr47tF1xGF13Xr1Utw1UZFb_yoWfXwbE9F
	Wq9w4xZF45X3Wvkr12qwn8Zr98Wrn2qryxtw4vqws7JayUt3sxXr4Ivw1DC3yrZ3y7CFn0
	yrnYyryxZr13CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8uwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSsjbUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

As the potential failure of the clk_enable(), it should be better to
check it and return error if fails.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/counter/ti-ecap-capture.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index 675447315caf..30a269fa5da0 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -574,8 +574,11 @@ static int ecap_cnt_resume(struct device *dev)
 {
 	struct counter_device *counter_dev = dev_get_drvdata(dev);
 	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
+	int ret;
 
-	clk_enable(ecap_dev->clk);
+	ret = clk_enable(ecap_dev->clk);
+	if (ret)
+		return ret;
 
 	ecap_cnt_capture_set_evmode(counter_dev, ecap_dev->pm_ctx.ev_mode);
 
-- 
2.25.1


