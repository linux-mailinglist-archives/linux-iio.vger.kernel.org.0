Return-Path: <linux-iio+bounces-27453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8364FCEC90B
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 22:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CC0030213E6
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 21:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC57C2FDC28;
	Wed, 31 Dec 2025 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6NyM/rF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C323043BE;
	Wed, 31 Dec 2025 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767215670; cv=none; b=giKUiWDCsOEDjhhV9Z5QuDyOR40PONvEsYkBs+pDi6ITPp7DZOEP2i6R9oa2czPe0VDhHeai3pcWt/6JFLfsabys8hveiQq6W4Sr/DP4eroaXJ+h/ZDWsTOYhlsIQsbmLK04Jjkj7hSKjqnGb+qrx2RVRH29pXJkFa5/qVqfRdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767215670; c=relaxed/simple;
	bh=MIyUFqUQ8pLZaTFNF/rrkm8jpq7XA/UENeIJrIox5kE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hZDpNbxDykVypH7+3ssR9BA7drH3HQHsCG0f8Nz3S3NPVdkcoWZ8KQ9Tfrgtrc3qtgfjzmy75v4FwP9b5wBQGCsY0S/bvZERPlyo9oci3NoowNfPUOQJWRK2fP+baSrOcSfc9jWYxo++i4N8jFP9JMDstxX5x6CzgBNdZQzU1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6NyM/rF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8606EC113D0;
	Wed, 31 Dec 2025 21:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767215670;
	bh=MIyUFqUQ8pLZaTFNF/rrkm8jpq7XA/UENeIJrIox5kE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V6NyM/rFPRSwRWC0R/7yKsxkm97DuUpRkm97fOg9GLuAD+Sqo72qg8GrmFaj8g8Wm
	 vkus9RnglmkHNUUQDcs/Wb0ZxdoUH1mAY8PXr4VqvRnJ/m/h47nlpKIvXlUkBc+5Cy
	 FZSTBz0EmvabwjOjOkfkL1hvuXsvQTtr2DE/S66n6EW5SgXXTSl3LY/V8/69MnButw
	 jwDGZZuzF/dhVTt1ALSLL3Z7M4eQRKpXpygsX3XoOBX8l+eG0ynOY72Ui38CzOTdXE
	 9LYf7c5sg0cREdHKR/XNedLH8FCYxQeZCo05jsLrWQaFJVtk+PnuUvZkGaklbeamFa
	 T6FfhwCe6EIIw==
From: akemnade@kernel.org
Date: Wed, 31 Dec 2025 22:14:16 +0100
Subject: [PATCH 1/2] iio: imu: inv-mpu9150: fix irq ack preventing irq
 storms
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-mpu9150-v1-1-08ecf085c4ae@kernel.org>
References: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
In-Reply-To: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 Andreas Kemnade <akemnade@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3065; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=xVZ2MeCM3xTY7L1LreCQ1qTAzPegB9GsgA0fEY+sJVk=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJmhk3S51cvk6+UWeIUrZDB4eCn8u6Zpe9W01tZifbpvC
 e9ExrcdpSwMYlwMsmKKLL+sFdw+qTzLDZ4aYQ8zh5UJZAgDF6cATOTJbYY/PIe8apZ+Ykx4r2K6
 7ur1mPen199Rf3w04MXBlzm5Zpe+GTAy7H439764V2Rds8f7rYxbDPZEtL/YVLdTozVx9r2w/3O
 jmAA=
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

From: Andreas Kemnade <andreas@kemnade.info>

IRQ needs to be acked. for some odd reasons, reading from irq status does
not reliable help, enable acking from any register to be on the safe side
and read the irq status register. Comments in the code indicate a known
unreliability with that register.
The blamed commit was tested with mpu6050 in lg,p895 and lg,p880 according
to Tested-bys. But with the MPU9150 in the Epson Moverio BT-200 this leads
to irq storms without properly acking the irq.

Fixes: 0a3b517c8089 ("iio: imu: inv_mpu6050: fix interrupt status read for old buggy chips")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 8 ++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     | 2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 5 ++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index b2fa1f4957a5b..5796896d54cd8 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1943,6 +1943,14 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 			irq_type);
 		return -EINVAL;
 	}
+
+	/*
+	 * Acking interrupts by status register does not work reliably
+	 * but seem to work when this bit is set.
+	 */
+	if (st->chip_type == INV_MPU9150)
+		st->irq_mask |= INV_MPU6050_INT_RD_CLEAR;
+
 	device_set_wakeup_capable(dev, true);
 
 	st->vdd_supply = devm_regulator_get(dev, "vdd");
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 211901f8b8eb6..6239b1a803f77 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -390,6 +390,8 @@ struct inv_mpu6050_state {
 /* enable level triggering */
 #define INV_MPU6050_LATCH_INT_EN	0x20
 #define INV_MPU6050_BIT_BYPASS_EN	0x2
+/* allow acking interrupts by any register read */
+#define INV_MPU6050_INT_RD_CLEAR	0x10
 
 /* Allowed timestamp period jitter in percent */
 #define INV_MPU6050_TS_PERIOD_JITTER	4
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 10a4733420759..22c1ce66f99ee 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -248,7 +248,6 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
 	switch (st->chip_type) {
 	case INV_MPU6000:
 	case INV_MPU6050:
-	case INV_MPU9150:
 		/*
 		 * WoM is not supported and interrupt status read seems to be broken for
 		 * some chips. Since data ready is the only interrupt, bypass interrupt
@@ -257,6 +256,10 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
 		wom_bits = 0;
 		int_status = INV_MPU6050_BIT_RAW_DATA_RDY_INT;
 		goto data_ready_interrupt;
+	case INV_MPU9150:
+		/* IRQ needs to be acked */
+		wom_bits = 0;
+		break;
 	case INV_MPU6500:
 	case INV_MPU6515:
 	case INV_MPU6880:

-- 
2.47.3


