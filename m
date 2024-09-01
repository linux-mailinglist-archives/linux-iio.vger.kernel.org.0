Return-Path: <linux-iio+bounces-8932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3769676F5
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B710F1F218EA
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F308178372;
	Sun,  1 Sep 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFdvCKkx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FADD14F9F5
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199228; cv=none; b=RsPUrSzJIvzBsZnp7dr9127HqKYaCK+3/oQx1Iqggiu04FYd5x34mb2ENWZNNybxrxOB8TUPfalm92MimLptKiOeOc6dxM91Za1CzLh5M18MLgustkToXXifzg0i3sLRScxBvCJKuk6TF0O5XP0sVmp8dPApbEfBA9O8MXr+mOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199228; c=relaxed/simple;
	bh=o5ye6VJcLFLbcvshdI/MyQUWelb5qkNqVLYB/v2VqiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhJNumOogkKq/27OdNVKbFjo+YQLC9n2hgaEcTGqxoC3QdOw9CC4FhBRBywnpSuo2lRm5DE3Q5qWyeeWxUSIoAbWYbxFmJ3dNWxHJwT7M07IWAtpLh4JoKV3LXUF+HNtjE3wWbInv450qce8XP1uMc+Znv9wdY7Q9nvscoHA0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFdvCKkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C26C4CEC3;
	Sun,  1 Sep 2024 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199227;
	bh=o5ye6VJcLFLbcvshdI/MyQUWelb5qkNqVLYB/v2VqiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFdvCKkxFiJmU7IstMO8w7i5HXIwH8KWSr/ZV8gHF3o5FejFx30arFk9hmwWo3gxD
	 QakphDOyh4LvF2RkYYcvi7Puw/HuDo8J/MuHUEs2U+CQLwQQR7vlFbDZvCdtgDXFZ9
	 Xol+BH2XQKg62b9FK+f6zCD+JDP/yjM9fJlA9OPoo4JhsTv8u+j9RQvXW46DGn44eM
	 YNv/ot68ivsKhjnfim/DSRJTMPwTA5y+dQR4udlJLaeDQTahf2xrFyAyqBIoCvV5qH
	 Ht+RU8Ivr6xjjKawixIvLsPAJz4JI9o9lGaCtIZGfq5JW3121FxvR3wwdXSkOqZumu
	 4npP61DYOx/FA==
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
Subject: [PATCH 06/15] iio: gyro: mpu3050: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:41 +0100
Message-ID: <20240901135950.797396-7-jic23@kernel.org>
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
 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 35af68b41408..b38d0678277e 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1059,7 +1059,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 	/* Check if IRQ is open drain */
 	mpu3050->irq_opendrain = device_property_read_bool(dev, "drive-open-drain");
 
-	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
+	irq_trig = irq_get_trigger_type(irq);
 	/*
 	 * Configure the interrupt generator hardware to supply whatever
 	 * the interrupt is configured for, edges low/high level low/high,
-- 
2.46.0


