Return-Path: <linux-iio+bounces-8937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4889676FB
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DEF8B212E1
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0930417F394;
	Sun,  1 Sep 2024 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNDNZNoe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDDE17E00F
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199249; cv=none; b=B74l18cRpChPYfVxGYn5VX30LgPak6hEoTRnFgdPBmsZtPh3jQ0lD6yTzBPjBl5IbrG7chagstHTzHGXB1yx5yhiN9Ikd84hUbaMb1AeLhxxJxr9FQEK6eUZO1iAfxLo5s6200s/DVhkFWsJfZJdafRvNteeV+AYIYCpfKoWPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199249; c=relaxed/simple;
	bh=eFKsplyC1bwfBfyxeBZZKcwmpB8mu+rVHwH4EC5UZrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hux64HMt3/U/Oku+RCKtz8Iw+LazinL9xTzWv5TidDcpTUI6Up9X0Y2TEo5kOZXQy7VrgTAOExGRzFaF+3VBVZBpm2PkL5kNXrV6vuUUxczcF4Ad95kfLBKQwK+2zKjpdbW0KVaJADvPOSEtRzYuvJSDj/08k+xJLG1q9vgPaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNDNZNoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A178C4CEC3;
	Sun,  1 Sep 2024 14:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199249;
	bh=eFKsplyC1bwfBfyxeBZZKcwmpB8mu+rVHwH4EC5UZrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNDNZNoeRCzUfIQJBdTRY0RQjhtqA+iZ/5xHR2k14kjlQrkZw5ly2tL+otOlyZ9WN
	 BJjq2Tf0ioi67gwRypZHB1Rss1tsoFEmTwK0+3YQ5MsHsH75zl74w24Ys2jE7I1UeV
	 BtAepr0F8hbxDI/ukF9wTKIFE15Lb7J8NsItqRmZ6ET5qib7isTTFWoIlws41wJBpW
	 0EMX6sFFeq4fwpSI3MM831V1Wxmh2NJXEVUTCFh+rjaFeaLMiupu2GGeWzlB9T2YOM
	 DlbgG4HHPbCWm3w/OwSaVe4/g8IzgzzqHCKO1i2BMaHqfi0U1qmhRE/i9XBWJwVoUR
	 +tTR2lVecUV9w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Marek Vasut <marex@denx.de>,
	Denis Ciocca <denis.ciocca@st.com>,
	Rui Miguel Silva <rui.silva@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/15] iio: imu: inv_mpu6050: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:46 +0100
Message-ID: <20240901135950.797396-12-jic23@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901135950.797396-1-jic23@kernel.org>
References: <20240901135950.797396-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Use irq_get_trigger_type() to replace getting the irq data then the
type in two steps.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 14d95f34e981..fdb48c5e5686 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1859,7 +1859,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	struct inv_mpu6050_platform_data *pdata;
 	struct device *dev = regmap_get_device(regmap);
 	int result;
-	struct irq_data *desc;
 	int irq_type;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -1893,13 +1892,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	}
 
 	if (irq > 0) {
-		desc = irq_get_irq_data(irq);
-		if (!desc) {
-			dev_err(dev, "Could not find IRQ %d\n", irq);
-			return -EINVAL;
-		}
-
-		irq_type = irqd_get_trigger_type(desc);
+		irq_type = irq_get_trigger_type(irq);
 		if (!irq_type)
 			irq_type = IRQF_TRIGGER_RISING;
 	} else {
-- 
2.46.0


