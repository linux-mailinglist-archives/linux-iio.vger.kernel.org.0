Return-Path: <linux-iio+bounces-8940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5AC9676FC
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96AE1F2196F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF317F500;
	Sun,  1 Sep 2024 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR2Td05O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13017C211
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199263; cv=none; b=rUiiFuBgG4cMorx1IxQdRXAHBqkrd89GShzdoqm5QFFJ/yym/y0JG7ho5KCtIknNKow+lQP4/ThjBdTpCLlglbmgZ6jqm02iHJGMo7Jh+kJVqvi7pyjlvfsFBID7wSGCbxXOeDU/2DNEALnXWsJt0IEJqPLaHF3NnV3ipwPaiLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199263; c=relaxed/simple;
	bh=g8JuZv5hc41PQp8AhS2e5KtuIOdFwG819wzBMMn4p7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8bHVWpNubdcNIM3o6eOY5ZSA33NJi7qLLVCDGtcofykmWV4tZoLgY8K9l+YfEDRzP7pzBTJwxhz7fKMX/kKXu7xkkQza7VTqwfYLC6Gxu8eeOI16EUWX9D5D1gtRhw40/EWNpuFbIwpZNlQTM046FAXu2m0RvDCmi53LqobQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR2Td05O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B033C4CEC7;
	Sun,  1 Sep 2024 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199263;
	bh=g8JuZv5hc41PQp8AhS2e5KtuIOdFwG819wzBMMn4p7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YR2Td05Oe8a2uC1b/Wk2ZVg4u9qCWDL4vUPK1WZyhppBnTcmp66Kc/1U3CCRhZ4Ni
	 Cynyfb13ysj2cqOeqKb/vdcLhM3Ab2EtYsPGaHoZ+UEf7upeKbsKxL4pFYO6IBoeak
	 x6uaq2ogQHZW0I24aG3Eyn9fB3gv6qA0oUHsIE5HVzqmJWvFC8ceW5BbESaoJjwqIn
	 gD8GPLWlL0kOe+/ZYknq+G/2pHsWAXuHTXrNC/bjXpLCvbI7aS1Ol52MC7apfoSCIK
	 WsgFp3MsGdaUFRF4+0P0Nk/amvuoJmxcrXm6fzDlxXATt1eq+e0gLyOAd+bf2pERqK
	 ygY1uUyCRavYQ==
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
Subject: [PATCH 14/15] iio: magn: ak8974: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:49 +0100
Message-ID: <20240901135950.797396-15-jic23@kernel.org>
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
 drivers/iio/magnetometer/ak8974.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 961b1e0bfb13..8306a18706ac 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -910,7 +910,7 @@ static int ak8974_probe(struct i2c_client *i2c)
 
 	/* If we have a valid DRDY IRQ, make use of it */
 	if (irq > 0) {
-		irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
+		irq_trig = irq_get_trigger_type(irq);
 		if (irq_trig == IRQF_TRIGGER_RISING) {
 			dev_info(&i2c->dev, "enable rising edge DRDY IRQ\n");
 		} else if (irq_trig == IRQF_TRIGGER_FALLING) {
-- 
2.46.0


