Return-Path: <linux-iio+bounces-8930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E2F9676F3
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB3B1F2188D
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80EF178372;
	Sun,  1 Sep 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N99nca3n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9BF1CFB9
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199222; cv=none; b=WafUXKultYCHkipZA00r4d1LKuq26H6z847Kxc8SbDPAIoC96EiSNwuXqPxfhTiNSPKatFKyDWzFGNsfXexf7r0RdOx+OhIICqwDEqRHsaSIt7AXhzKdMe5k+3SgOvg3DKVN+CLDq2tkC5LZSRnx++fcZ0OYUT90kEC12qUYc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199222; c=relaxed/simple;
	bh=sTvmqCgKGsf9SLpV6XscDCdQVEBV+z+GGIOKOWfIsIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NY/dTxergW6XM22IWrneB6XinNhiUOwPYjmW2poJjfi8pEC6N2BTujkHVOdWbRQ1TI8hF7+lVVuPNGMGgum71Q9i3QFUrdeklLpvgxInE8tyPvzHR3hInSdfIpI3E8KLmKMH+j1OODuJSwivrg1yv7Zy7IDgaYdozvAcEsI7UmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N99nca3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C39C4CEC3;
	Sun,  1 Sep 2024 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199222;
	bh=sTvmqCgKGsf9SLpV6XscDCdQVEBV+z+GGIOKOWfIsIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N99nca3n/3ZqCVZIWz5pSSfG1bkv2ihnt5A4cq+apza3cY0c4tCk8d4EwH4Ik5j82
	 zGks3T9Dp3XLvDxMJ9l4SPew38cxXT3ivJtIIuNRARzHumiIOJqYE0qJV/bXPQXTdw
	 ijqoGAgkzOILwB49lqY+scoPlyHNl5WdsvO3QvFTrHYl9nVEhtWsXV5h10lpdIy9xa
	 C8h1FazrxYSjKAGWepBHQP4f7xvGIlOBQm0hiJAY3loaoY3cd6c9/GsEjfu6UYyoOb
	 kE0rh7PTxiTEHCvVSq4QfJBnBXttNEFAGpNgm7O6Xyn3f6NAOYLBr4uUv8oq7vChex
	 yV/BDvZshwzqA==
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
Subject: [PATCH 04/15] iio: common: st: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:39 +0100
Message-ID: <20240901135950.797396-5-jic23@kernel.org>
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
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index a0df9250a69f..1c51ac110078 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -134,7 +134,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	iio_trigger_set_drvdata(sdata->trig, indio_dev);
 	sdata->trig->ops = trigger_ops;
 
-	irq_trig = irqd_get_trigger_type(irq_get_irq_data(sdata->irq));
+	irq_trig = irq_get_trigger_type(sdata->irq);
 	/*
 	 * If the IRQ is triggered on falling edge, we need to mark the
 	 * interrupt as active low, if the hardware supports this.
-- 
2.46.0


