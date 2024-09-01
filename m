Return-Path: <linux-iio+bounces-8935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE79F9676F8
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1531C20F69
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C8117E00B;
	Sun,  1 Sep 2024 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lke6fgLC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF91CFB9
	for <linux-iio@vger.kernel.org>; Sun,  1 Sep 2024 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199242; cv=none; b=V07XDueLfLaTeDPI8rnfm66lGHtd2oVY/U+gDc2po6sweN2f8BxmMt9wI8IIjNZmujGDQEvto3QVuyeoUXOUjcxvgz8D9NFiSvccCGwQZj3L4Gh0izjtHVUqHxleiAxOxG4vBuCSyDUuns+r/g9r7YIwD4q/Hkvm7toKwaSeaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199242; c=relaxed/simple;
	bh=iPAYHOG+gWjcUfaHXJtdksQmeN9rJXf5j9qduQJ1d/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5FlMTdNra7zCkGSo2n2Fte9hzjYh+CFzEUtmPHtuj0GUxXnKYyWGiUlHFISLJFuw0N4mw87x8a1q8Bbe3vbWqffjiLdUkpxzucC/zULRKxxPY0skFBTfqUT7ieaqDAgShwIytUq44EtxU1m2562FGvF6Q3otp5MQ35oV5r+uX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lke6fgLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF02C4CEC3;
	Sun,  1 Sep 2024 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199241;
	bh=iPAYHOG+gWjcUfaHXJtdksQmeN9rJXf5j9qduQJ1d/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lke6fgLCmZPvPa+2Lq+AciRbqaAuN0LSHH7G+hPpXVdHWC0C7GtZOKPMSacvxY0N2
	 CmXuq6bwpJyO6T8I7mW7Af4ZHNyIWq9W50NCbFlOqorWMSLhMJkcno5DQX4VDlF+sM
	 kyWAoVrenwf8GZMVNlzeN5kziP4CG4wTnpFuoyOuAKZPqFH5XkQzkQh3MAmRk0bU5h
	 AKdeci13yNdehZPIuUzR7/XnTnrH6258ktDgGKcFfUuZfQMPc0yMeipStgC5Z8clRW
	 qz0qOECPgkKVMvpZa3Zfn9dbt3EtIegI+ePlQQiI9LHzOQSnDnqSgNiz7LYzHswWO0
	 QDsVuKLFN1JcA==
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
Subject: [PATCH 09/15] iio: imu: bmi323: use irq_get_trigger_type()
Date: Sun,  1 Sep 2024 14:59:44 +0100
Message-ID: <20240901135950.797396-10-jic23@kernel.org>
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
 drivers/iio/imu/bmi323/bmi323_core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 671401ce80dc..89eab40bcfdf 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1881,7 +1881,6 @@ static int bmi323_trigger_probe(struct bmi323_data *data,
 	struct fwnode_handle *fwnode;
 	enum bmi323_irq_pin irq_pin;
 	int ret, irq, irq_type;
-	struct irq_data *desc;
 
 	fwnode = dev_fwnode(data->dev);
 	if (!fwnode)
@@ -1898,12 +1897,7 @@ static int bmi323_trigger_probe(struct bmi323_data *data,
 		irq_pin = BMI323_IRQ_INT2;
 	}
 
-	desc = irq_get_irq_data(irq);
-	if (!desc)
-		return dev_err_probe(data->dev, -EINVAL,
-				     "Could not find IRQ %d\n", irq);
-
-	irq_type = irqd_get_trigger_type(desc);
+	irq_type = irq_get_trigger_type(irq);
 	switch (irq_type) {
 	case IRQF_TRIGGER_RISING:
 		latch = false;
-- 
2.46.0


