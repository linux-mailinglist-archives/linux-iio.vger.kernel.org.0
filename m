Return-Path: <linux-iio+bounces-8928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1D09676F1
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA69D281949
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DD318132A;
	Sun,  1 Sep 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZPPOj4A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAF17F4F7
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199212; cv=none; b=pnFWFp0x7cpfBJMjxQHkfyqho7rfdimnHiVZ/pWQ7PCGp4raBnux+wvNTguv4S4Hi3+JUT65c211R86p+rWkKFEEjKHUS/5gY92MP3ChioovHpEamlyd3j6CUq/GGrnHdTh+wuuIuKg0mE9gorzE/edGhsGiapnUQHX597Segi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199212; c=relaxed/simple;
	bh=pUMWGNXOvuWoalJn9rzBb/WvYPyDxLDDF9d/TOrdWII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgwYag2yCScxzgoqbqsdOimszukNsbGwKlBOgpcDKn3POl8dTn/8uRkTxAwzixYDgDkkQ2zL6gt0t4uKhjPiUzfbZ2IbZNlauBaemXH+Mp9OOqD7VcMLY6atkp1yX2RWRcBlI6bLlA+rxxtTDyZmOOBKD9YoaHg8Sa6HEPz044Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZPPOj4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC14C4CEC3;
	Sun,  1 Sep 2024 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199211;
	bh=pUMWGNXOvuWoalJn9rzBb/WvYPyDxLDDF9d/TOrdWII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZPPOj4AaworO6OEpkmpUec/5dbOQR4tOF5HzYulTTyb8YlUXbjsD6CUxJdgrrV9M
	 5XPx4u1x8MshxXywNfCHdfs8AX/eTIRrbV+nOOx5CQbzA5sMzzauIw0oxXgGmxOGej
	 ueeryaalMLGKJpfZTsIaWcpN2UB/20E5OSLb33vkfPudP7DPKRi/PuUFtQsZNCPyf7
	 Or5dIfHEBGCUxUP8xtbbHHLBwG9uovwUNiZRF83VrIRIhXFaYgLx8rok2pwrO8P245
	 QLmB3TBf0aEGYnk8uuYi/BUaQBT79CPrlqXl8MdtkGnLR1CIao0Sr/VMfvqn3mTzFw
	 cdS2f1qcKab6Q==
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
Subject: [PATCH 02/15] iio: accel: fxls8962af: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:37 +0100
Message-ID: <20240901135950.797396-3-jic23@kernel.org>
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
 drivers/iio/accel/fxls8962af-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index acadabec4df7..a50c47f5179f 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -1103,7 +1103,7 @@ static int fxls8962af_irq_setup(struct iio_dev *indio_dev, int irq)
 	if (ret)
 		return ret;
 
-	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
+	irq_type = irq_get_trigger_type(irq);
 
 	switch (irq_type) {
 	case IRQF_TRIGGER_HIGH:
-- 
2.46.0


