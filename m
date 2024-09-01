Return-Path: <linux-iio+bounces-8927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C853A9676F0
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EAD281B0B
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F74117E8F7;
	Sun,  1 Sep 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXOSuf/1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAC01D1319
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199208; cv=none; b=YmxvpibFnOFdFmbSPg4wpg4ReEJbyD/Dkm6Eb5mT4ryHGCz9WghK4tBxW2g20JvzI9FiP5/3cZn5Y7ycNod0iwIZ2+NgzZdSCPK2BXrfuiAOIjX5fQmaEDmF1fwvUj/Ifz8fymoJrMOiLI8WdiIywC9eAVNQ6oU21gtM0LG/2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199208; c=relaxed/simple;
	bh=n+XN5e57Uwqxf7KhwCyXQrxg/ejF/vX2alXXom/Uc60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAMm36SxLDVQBt7jmRduiASvSUuFuL4VLGcyOnAnyg7UzJYxOYG/CnLQxG3nzD1YHa+ba5fHPuLrvjb8cWJFrGH4vCRzfBTaPcLqaT6S+r8n77+NDcbNh9oeZSMc6qWdw1roGxKvmDE1ZOUuw4YjZ8oAlZJpoBHcserGPFDFICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXOSuf/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A811CC4CEC8;
	Sun,  1 Sep 2024 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199207;
	bh=n+XN5e57Uwqxf7KhwCyXQrxg/ejF/vX2alXXom/Uc60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bXOSuf/1lHS/6RR7Ee3uJTT2MVVPjgcP3PrugGnhLJUbTBctHcEIxvuEN2HQ0QXDw
	 skWgVupHu5vr34d7tJjg60KBY3qake+d0HdgjKfh58CPvFQGT9mq84ynL6g20g+7dq
	 E0Q530dbOF1jvN/qrqQu5sbOWrPVtrd3tYzFS6hTzKIraFHwt8L4mLXuVJ06TiK5Cg
	 T/oXvnAOrpBc+3nV7kbgAC6CfcM0Lpm2SoItwPu2xLOtSNqlE0hG41JwBO19p7guf8
	 b5mRkRvLtrR0omorua7Hf5dpQr+xgUBxpTpTzJcV96earpwr93bU38GCR3ay3u+D7a
	 9V2wc/9pyIHDg==
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
Subject: [PATCH 01/15] iio: accel: adxl380: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:36 +0100
Message-ID: <20240901135950.797396-2-jic23@kernel.org>
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
 drivers/iio/accel/adxl380.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 98863e22bb6b..9c9bee993fde 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -1719,7 +1719,6 @@ static int adxl380_config_irq(struct iio_dev *indio_dev)
 {
 	struct adxl380_state *st = iio_priv(indio_dev);
 	unsigned long irq_flag;
-	struct irq_data *desc;
 	u32 irq_type;
 	u8 polarity;
 	int ret;
@@ -1737,11 +1736,7 @@ static int adxl380_config_irq(struct iio_dev *indio_dev)
 		st->int_map[1] = ADXL380_INT1_MAP1_REG;
 	}
 
-	desc = irq_get_irq_data(st->irq);
-	if (!desc)
-		return dev_err_probe(st->dev, -EINVAL, "Could not find IRQ %d\n", st->irq);
-
-	irq_type = irqd_get_trigger_type(desc);
+	irq_type = irq_get_trigger_type(st->irq);
 	if (irq_type == IRQ_TYPE_LEVEL_HIGH) {
 		polarity = 0;
 		irq_flag = IRQF_TRIGGER_HIGH | IRQF_ONESHOT;
-- 
2.46.0


