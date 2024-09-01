Return-Path: <linux-iio+bounces-8934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EBC9676F7
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9481F2182F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C50D17E00B;
	Sun,  1 Sep 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5ErDBN7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3801CFB9
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199237; cv=none; b=jp5yI+aHDCE9SEgctjRrd1AMwtLbVIfQX8k841vRfSk/jTeW7Z7d14bcTBDMn4LF4z8pcrk0z0UVN5juZ9x3E8PseVz6rL3q2g4rBRaGdG165lQUm8xT40xUqDKPwUeCmCWYuetbkYOaINoIL3yhOvM89essf6/7ZeqvuB1Hrqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199237; c=relaxed/simple;
	bh=OkPIf7ka597J+EvGJEVW26+i07cp/LZcdnwT3yS5yPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLnKnDt1AZMQB7E5XSYJnaWyzvpI76dnww5UdFUPn4ouOTQv67i+fUdpbZF9Zg4tLX/i9WvWrKkc4CxVBtpDm239/FVrwPsPEJDIm4s6ierDjPeTA0zAPfV7jOXoNOPS1acWC3b+8ZEUDLRKhkCbPyqm1CEJIcqtEIEYZFUnq+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5ErDBN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD708C4CEC8;
	Sun,  1 Sep 2024 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199236;
	bh=OkPIf7ka597J+EvGJEVW26+i07cp/LZcdnwT3yS5yPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s5ErDBN7hmqturdF4b9SvIYx+sUQk1LGvRvr3026xeUoljvcBvI3Fg5b2gAH7OlP7
	 nQLTxvZkiXOAUbvCF1g1QvWXj7Ij7yPRZvY1bjlMMuiv7uJvJxCFAWFLZcho7ENeTG
	 NrdmyvOIC+q2DfZ9RaGTJp9ynSYCj4CMmQ24WrwmY+PZjOnDlhQPQX28dLz6NLArP5
	 ruqOZiqPYshteRJzLtwTxWPti1EtkVuW+RUQEkwkwtI+a8NKHv/8XEPJWyEVa/vmR9
	 Pso0l8VPlwZWj2tW3y5lYFquIKv84Jq10Bxro1S4VOeQfcS1IsA2vvfgiBrxb8Yckk
	 zXD41FTpKilCA==
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
Subject: [PATCH 08/15] iio: imu: bmi160: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:43 +0100
Message-ID: <20240901135950.797396-9-jic23@kernel.org>
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
 drivers/iio/imu/bmi160/bmi160_core.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 495e8a74ac67..3665fcd5ff0d 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -690,17 +690,8 @@ static int bmi160_config_device_irq(struct iio_dev *indio_dev, int irq_type,
 static int bmi160_setup_irq(struct iio_dev *indio_dev, int irq,
 			    enum bmi160_int_pin pin)
 {
-	struct irq_data *desc;
-	u32 irq_type;
 	int ret;
-
-	desc = irq_get_irq_data(irq);
-	if (!desc) {
-		dev_err(&indio_dev->dev, "Could not find IRQ %d\n", irq);
-		return -EINVAL;
-	}
-
-	irq_type = irqd_get_trigger_type(desc);
+	u32 irq_type = irq_get_trigger_type(irq);
 
 	ret = bmi160_config_device_irq(indio_dev, irq_type, pin);
 	if (ret)
-- 
2.46.0


