Return-Path: <linux-iio+bounces-17794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9585CA7EE83
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 22:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D120F17F448
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 20:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC2222563;
	Mon,  7 Apr 2025 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9n3ckJL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CEB1EE032;
	Mon,  7 Apr 2025 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055847; cv=none; b=Y6MnzNKkFg8Uw0c+bO3j2OiuqD/glHEJbm6aF0DHppNVXw2YT0Sp93AxpgIkz0+aCxfK/IGo+WX6ORO/hvbsVdGIVtwg0NQl3KO1UoWqdavqWIzY7HDTGvIzhuRse0xR2qOaL51SlpnLuUS59YVlLUwcPPK/a1axJdu+juCqL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055847; c=relaxed/simple;
	bh=0w8yAQJiPOZnV0UHv/R8A2XVkSYUyrYq+ByRjE1W+QM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nyjp0CWMofKlK9Agu+g15hJ2WFrXEeNGoy0msrY1Hl1P1Dufk2TizR1y63tFVtq94pVTonIrQuKYKb2dmUY0koS7bpbc7DmkPcqw/3Lg/f5CRDuQ1SMDwtEmkjPXlHlqo9T5D5OE9Xjw1x7k1EbWE/b9VZRQOqjZKylNnmm0ddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9n3ckJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6306FC4CEEA;
	Mon,  7 Apr 2025 19:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744055846;
	bh=0w8yAQJiPOZnV0UHv/R8A2XVkSYUyrYq+ByRjE1W+QM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g9n3ckJLHDizLaYQFqISwBpcKh6rPB7Q7FB9LLQuU3K6UXc6/kry4ZI56J1gNXNo7
	 C+0Gwr9ywQtlSuurppRpdm+NuDA5c6rDv2a6PMUzu7ANmLx1NIhAZ3Cb+udNn0AWdN
	 nRcc8xebQKc7PX37OUdlXFLf9liwkdZkJARAbwPDCQuINe/KvJ6kDNnV7KAeAef975
	 35INPp8CP0omVOOaM72C64Mp9rdfLWlno+YTj8gDjNAyWwsmcqRumd7zXHI5NUmzWB
	 1aKQfzDoSsmVFzxd+dLCcduo9f/o1RUd7tsNI/SAVeYsmQ2J5g4cdR2TULDELIWnJy
	 yP5lGHciGc8iw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E645C369A4;
	Mon,  7 Apr 2025 19:57:26 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 07 Apr 2025 21:57:17 +0200
Subject: [PATCH v2 2/2] iio: imu: inv_icm42600: switch to use generic name
 irq get
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-2-c278acf587b2@tdk.com>
References: <20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-0-c278acf587b2@tdk.com>
In-Reply-To: <20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-0-c278acf587b2@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055845; l=4065;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=/VtK2uQ40gbKTy8BClZYWTjqk6A7kwyWnfPM64PZuwk=;
 b=HTTaFHOjNygAhaaE+ihAi5Ein9GCd0uQOmNqA89j/teBbBEzXxZxrScJRMGNkcl1j6FSwX/E3
 WjQwV8y9CUbDoTT2CHNAuo7DVPpKEQak6BwAkXeWW2ujC2Rv4Zu6kfQ
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
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 17 +++++++++++++++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c  |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  2 +-
 4 files changed, 18 insertions(+), 5 deletions(-)

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
index ef9875d3b79db116f9fb4f6d881a7979292c1792..8ce817a4d5aa78cc8b228ee3064083b336c2c357 100644
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
 
@@ -697,6 +698,18 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 		return -ENODEV;
 	}
 
+	/* get INT1 only supported interrupt or fallback to first interrupt */
+	fwnode = dev_fwnode(dev);
+	if (!fwnode)
+		return -ENODEV;
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



