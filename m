Return-Path: <linux-iio+bounces-17920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2DFA84848
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 17:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C532D1B642C4
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 15:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981D21EB5D5;
	Thu, 10 Apr 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aywQJazQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9E81EB5D8;
	Thu, 10 Apr 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299635; cv=none; b=l2zZfCGt/hwkXmb+bpQh+hZr7LakB5M4R6VR4nOV3lyClVY8pDSpNQF3i5BWQOekpN9lKR4LFFmQ6Qu+5AlcvPbH20HCIx7GLL/a9K516N+pXFQp8RZC6xleYYE6sG3oxrrBo9Q5QnvIUGH6ZJDmRrDzNblosWEO71gEbU0MMNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299635; c=relaxed/simple;
	bh=lCD7sKVCAEhXdY4MN5ognflah+r0Xx7o7R2JwN97PNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BTgGJsnBHPBSKySxps7wWsDPlmutqS4ZNVBYNSGfsk6WUcvRu1pNn7VNVgK1oSYlATez8OLfWT6M1prgHRLu4k+hjURR7KGnKZKJRH54Gukp1Bq/i7DLiAUWN+umdSDw7P6E7xwrknTCEhhD5a3V0BDXAlfKXH5QmOo7ihltGqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aywQJazQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDF07C4CEEB;
	Thu, 10 Apr 2025 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744299634;
	bh=lCD7sKVCAEhXdY4MN5ognflah+r0Xx7o7R2JwN97PNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aywQJazQOmrQs0aUlZ37D8rVUihDHVFYZfl2Eb2oZxOk+KfGFSgC2ZoFrNIwqVw7l
	 Dn1uhp/sBLONd2VzhxOGX93mNdQX+mD+PnbVtHy8iDqGsYXNt0Okz6tVXxqwaic3wP
	 HISs5zXD3vbWNIn/qlSrjkcIWycRhQgf0ZecQy6naw9DKkwIXaZL++b6iRilaazSqx
	 Z1QllS1yxfBtRwCg+9A6jhAiunADt/HkOMvI2IxiElwTVjb2/hFxFOaiaNDqeZS97U
	 JVfuNby0ZgAJ1VxV+qydRf7k+6jkxZZUTuhF+36mK5F+2rAPhqge7ltOV+s1TVlEmz
	 ZEU4BxomoxDiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEB3C369AA;
	Thu, 10 Apr 2025 15:40:34 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 10 Apr 2025 17:39:41 +0200
Subject: [PATCH v4 2/2] iio: imu: inv_icm42600: switch to use generic name
 irq get
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-2-19e4e2f8f7eb@tdk.com>
References: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-0-19e4e2f8f7eb@tdk.com>
In-Reply-To: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-0-19e4e2f8f7eb@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744299633; l=4015;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=qd/hxVeO3e4TL1TWiCdGib5jkD+pRfqNEUkSgk4JLuI=;
 b=C/rjRf1MqCDkS1ufczeuaWQyPLa0n+ORNdq5a4c6DxAabsaLlvhoxTtQ3a3Xf9U/TBA9uR7Cu
 4NJ3YdZfiaDD/ADlK8QYQCoDqUa+PiNBCFf+nPAir9b9whJa4cYiEH7
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Use generic fwnode_irq_get_byname() for getting interrupt pin using
interrupt name. Only INT1 is supported by the driver currently.

If not found fallback to first defined interrupt to keep compatibility.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 14 ++++++++++++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c  |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  2 +-
 4 files changed, 15 insertions(+), 5 deletions(-)

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
index ef9875d3b79db116f9fb4f6d881a7979292c1792..63d46619ebfaa1372171129fca96381ef4606b2e 100644
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
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct inv_icm42600_state *st;
-	int irq_type;
+	int irq, irq_type;
 	bool open_drain;
 	int ret;
 
@@ -697,6 +698,15 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 		return -ENODEV;
 	}
 
+	/* get INT1 only supported interrupt or fallback to first interrupt */
+	irq = fwnode_irq_get_byname(fwnode, "INT1");
+	if (irq < 0 && irq != -EPROBE_DEFER) {
+		dev_info(dev, "no INT1 interrupt defined, fallback to first interrupt\n");
+		irq = fwnode_irq_get(fwnode, 0);
+	}
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



