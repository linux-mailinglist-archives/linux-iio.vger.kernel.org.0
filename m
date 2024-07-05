Return-Path: <linux-iio+bounces-7333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9657E9283F4
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2511C243D4
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 08:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400E7145FE0;
	Fri,  5 Jul 2024 08:43:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786914533A;
	Fri,  5 Jul 2024 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168990; cv=none; b=e6iVpyKpTaEvNhnvOfA2AJ6RPX+53J+dKB4+NZ/5G+3Sm7FzCa64spRGOQstT/51ZrdG3pVoKYETASrFCtVSRnkcLGYCaUcZyOf1VibFI2XklWzigG9SbjmUbUJet7zYIxZOf8BwQmyN4Kd5LiC0gyiuW5flXVKyPM++FZx+0Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168990; c=relaxed/simple;
	bh=xCm1e7A/omFtTbcPrO3v/wflEg7UUQPBc4Qaj2aezx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=liD42ENt3xSy3MK5gaaPKZohsFv7TyYjKLqgMJvXjkVEhlvRB8YcfqB8Zsso6tAMcNtVMB+qYo5wvAMb75P1RiB2Y4mLbA7JSG/mqByoVMCMsx0wE2kp7dsO7uJKGCVdhcv9B8KJGzs5xH5dUD6vyMaeV1Gy/IP+pv152HDtMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADnuSEWsodmjoKlAQ--.42801S2;
	Fri, 05 Jul 2024 16:43:02 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] iio: dac: ti-dac7311: Add check for spi_setup
Date: Fri,  5 Jul 2024 16:42:50 +0800
Message-Id: <20240705084250.3006527-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnuSEWsodmjoKlAQ--.42801S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4xAr4xAr47uFy8GF18uFg_yoW3CFX_Cr
	1xZwnrX34F9F47Gr45Ar1SvrWFyrWYvFWF9F1vqrWfGFy3AFy8ArW8ZF47Ar48uryvyan8
	Wr4YgrWruF4fCjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY
	02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUjwI6DUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of spi_setup() and return the error
if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/iio/dac/ti-dac7311.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
index 7f89d2a52f49..8e8a8ab0ebf6 100644
--- a/drivers/iio/dac/ti-dac7311.c
+++ b/drivers/iio/dac/ti-dac7311.c
@@ -249,7 +249,11 @@ static int ti_dac_probe(struct spi_device *spi)
 
 	spi->mode = SPI_MODE_1;
 	spi->bits_per_word = 16;
-	spi_setup(spi);
+	ret = spi_setup(spi);
+	if (ret < 0) {
+		dev_err(dev, "spi_setup failed\n");
+		return ret;
+	}
 
 	indio_dev->info = &ti_dac_info;
 	indio_dev->name = spi_get_device_id(spi)->name;
-- 
2.25.1


