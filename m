Return-Path: <linux-iio+bounces-9055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E3C969190
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 04:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDB51F21E9A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 02:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48BA1A264C;
	Tue,  3 Sep 2024 02:50:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E21E49F;
	Tue,  3 Sep 2024 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725331844; cv=none; b=ex5cCerALsPY8qfdrApuCwgU6RkCkSVECoHQZkDu0P/gA/CQOCTFCET4nDFFDw+EZlPTTxxMr1epY8Eachva7H3Bt2BLJ70QLggyo9nCEzVjVSA/mG2wsPILtG302BQRkyL0PC+ulRNsS9iGKdz/Kl0nle2CR7XCxGSlPUJyan0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725331844; c=relaxed/simple;
	bh=MRd6zLZvFMqI2WvRQXwjtiE1UzTFIZdJLPiFnZkfLbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h/PFuu8DiRrsLnYTdROf/B0x/Vcmkv/w03MTF7YokYOVirtPk0Nd4XEr5mrII2P5yPQj5N1U0rMLwdLZiiCMjXKCeUr3c8wK7J6AwOp7Jd5F6lTRA4yal/XJkF9uR+LaWkgD1DhisBH2Rz9zgPqVfbzgnT6ACIOyx8E+IUFviDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAA3PaF_edZmyxO1AA--.34150S2;
	Tue, 03 Sep 2024 10:50:39 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] HID: hid-sensor-custom: Convert comma to semicolon
Date: Tue,  3 Sep 2024 10:50:10 +0800
Message-Id: <20240903025010.493843-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA3PaF_edZmyxO1AA--.34150S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47GrWUAr47Jwb_yoWfZrbEya
	9rCa1ktFn3JFy7trn5Ca4Y9Fs5GrZ8ZFs7u3WYqay3A3s7Xr4kJFyjvr4agr1xWFyUXa40
	9wnxZr1Fyw1DWjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUqNtsUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/hid/hid-sensor-custom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index bd400f6b472b..66f0675df24b 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -732,7 +732,7 @@ static int hid_sensor_custom_dev_if_add(struct hid_sensor_custom *sensor_inst)
 
 	sensor_inst->custom_dev.minor = MISC_DYNAMIC_MINOR;
 	sensor_inst->custom_dev.name = dev_name(&sensor_inst->pdev->dev);
-	sensor_inst->custom_dev.fops = &hid_sensor_custom_fops,
+	sensor_inst->custom_dev.fops = &hid_sensor_custom_fops;
 	ret = misc_register(&sensor_inst->custom_dev);
 	if (ret) {
 		kfifo_free(&sensor_inst->data_fifo);
-- 
2.25.1


