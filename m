Return-Path: <linux-iio+bounces-17617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D468A7C0FD
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 17:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B150718996ED
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38A51F7095;
	Fri,  4 Apr 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1fjKzc3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1FE1F63F0;
	Fri,  4 Apr 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781931; cv=none; b=R9dKRqtgCVjKxXkJ5mbybL/LmL88uhf9TBvCw0PtQqEn6sleA6wMRW5I0uUHOu5jus+f/VjDbzUi/LzU2KTYgPkDvHSC7NpS6vvGW80/AGUVKrV51uFTgpZIWFTFMdeB+iIW00QF66iJLIsZYYBWulFAjXlSFiGtR9EUG2BSH78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781931; c=relaxed/simple;
	bh=pcYSAYWTjqkxlR36E9MUlFnt4MSwvXEXlSFsCIsJPXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZhNdBL9wbxDxDN8T3wo1z30I0tsMUwHlZ+/6/+tsoRq/klybk+f3pWdOd8VzO/IB3yMDEGRnJqg/DXgYgfeeS+k9orN5CXeWdFdwxOr3zrOZf02leRF37CARRfTFF19uM0RM1S4/w7HSjHJeun7NNUdhek6yM2VPnL9j/w7tx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1fjKzc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0C68C4CEE8;
	Fri,  4 Apr 2025 15:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743781929;
	bh=pcYSAYWTjqkxlR36E9MUlFnt4MSwvXEXlSFsCIsJPXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P1fjKzc3eGvhquRsSY3kKtexSoesNyLLuy3gvu/bDKBUPf+pI3WcDWcM/yPCsoBYC
	 wwnzIc4Go6I6exYpmwYPe9y1tj5Ns4T657M6S/ploo1T+IAlQVE2LXH4a6GfTp5lvf
	 WLG9kjv36EeO+CTl7ZQhxgMFuv3XXZUmWCcswOAsRWNQNWaaDRR0Wvkt+bbhygOdRd
	 IOrBm15UXGInQ3STw7jJidFfDKCmr+dlScoLZHEuNxalpRXbT9I1ClHUh20mGVEYAI
	 ByzVNlcBBev5Shvx/2bMyxFpfaRHBKX/v3/Z47MtvLTi2C+6kbub1RZH9G9X1zDrWk
	 FCxigDZhzM5Lw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A541CC369A2;
	Fri,  4 Apr 2025 15:52:09 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Fri, 04 Apr 2025 17:52:03 +0200
Subject: [PATCH 2/2] iio: imu: inv_icm42600: switch to use generic name irq
 get
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-2-72ed5100da14@tdk.com>
References: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-0-72ed5100da14@tdk.com>
In-Reply-To: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-0-72ed5100da14@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743781928; l=3719;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=aK+9d09n/DXh1B0QAO9MWRE0rSAinKtcE5JJVNT3Ho0=;
 b=byMnHzROPs8DLM2mn3cabTWIUFGWHCYa7CvT5NK8dMafO+wt5IyQInBVadqaxAQpFsbvxPSNB
 bWxW0fplXRVBMrLQhTM21wdXrJe3RHHtBmHInes/rgtZX9OxA9+lB4r
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Use generic fwnode_irq_get_byname() for getting interrupt pin using
interrupt name.
Only INT1 is supported by the driver currently.
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 13 +++++++++++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c  |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  2 +-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 18787a43477b89db12caee597ab040af5c8f52d5..f893dbe6996506a33eb5d3be47e6765a923665c9 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -426,7 +426,7 @@ int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
 int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval);
 
-int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
+int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 			    inv_icm42600_bus_setup bus_setup);
 
 struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index ef9875d3b79db116f9fb4f6d881a7979292c1792..bfdd7cd5fafae87ad7c6204f6dd3bef17935b3f9 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -683,12 +683,13 @@ static void inv_icm42600_disable_pm(void *_data)
 	pm_runtime_disable(dev);
 }
 
-int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
+int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 			    inv_icm42600_bus_setup bus_setup)
 {
 	struct device *dev = regmap_get_device(regmap);
 	struct inv_icm42600_state *st;
-	int irq_type;
+	struct fwnode_handle *fwnode;
+	int irq, irq_type;
 	bool open_drain;
 	int ret;
 
@@ -697,6 +698,14 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 		return -ENODEV;
 	}
 
+	/* get INT1 only supported interrupt */
+	fwnode = dev_fwnode(dev);
+	if (!fwnode)
+		return -ENODEV;
+	irq = fwnode_irq_get_byname(fwnode, "INT1");
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "error missing INT1 interrupt\n");
+
 	irq_type = irq_get_trigger_type(irq);
 	if (!irq_type)
 		irq_type = IRQF_TRIGGER_FALLING;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 04e440fe023aa3869529b0f0be003ea0544bfb8d..38cc0d7834fcb96dabc401f29d613cf9fc75b8f5 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -67,7 +67,7 @@ static int inv_icm42600_probe(struct i2c_client *client)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return inv_icm42600_core_probe(regmap, chip, client->irq,
+	return inv_icm42600_core_probe(regmap, chip,
 				       inv_icm42600_i2c_bus_setup);
 }
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 2bd2c4c8e50c3fe081e882aca6c64736510b474c..f40a09c4cbfc673e76922d13d61a3634785300ec 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -64,7 +64,7 @@ static int inv_icm42600_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return inv_icm42600_core_probe(regmap, chip, spi->irq,
+	return inv_icm42600_core_probe(regmap, chip,
 				       inv_icm42600_spi_bus_setup);
 }
 

-- 
2.49.0



