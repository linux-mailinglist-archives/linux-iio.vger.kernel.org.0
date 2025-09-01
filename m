Return-Path: <linux-iio+bounces-23620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AA5B3EF03
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435F41A85A3C
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36CC2673B7;
	Mon,  1 Sep 2025 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="5jWEjWfP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74081AF0BB;
	Mon,  1 Sep 2025 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756510; cv=none; b=Qt/XG7CINaA4h447rXGYvsT1JMyPFtbSZ1esaePOWhP5m2dt80gXXInozjgHsedvMDL5fzf1oNzsneBMB4vOr+xYj5+RNfNX5H1kn7BXcrjpAI/tXd2OdS1LprYowXH3kKWHrrec2/8sSnmVffueddUA2mgogDmPx4L/79WEdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756510; c=relaxed/simple;
	bh=cvbXcOjmrceea2vVvj79DAGDBVMFe6HplK3FUkfUUoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntbSteIMkdKGasOS3K9OvdaT37ZNcafuK5hSuouM+rHvJQnVz1fAhHebpyDJaeEUIaj+WnCWVC9eU+/dsM1gWCALK0OPF+7HYditQHFe3znnMxJ/TA3HGd/Psl/MRkxxjworyTooh2MidWKiaExP21HlpslSW+m9nf4E9Gj3h8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=5jWEjWfP; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 1E179173BE9;
	Mon, 01 Sep 2025 22:47:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1756756074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3MAwKLb02xFBAnfdcoXq8JKOD808RppgqaRPlq0x6c=;
	b=5jWEjWfPc8HMBHwH8SVArnr4W83dLtBXSChH2H433txrl4mF4ZVkD+lVBaJMK0I51mLiST
	B2Wx4vukuX52ZcDLvNXqDl0SjUoH//P9crAPKrqQaB09Rx1izA4ib9IVAAghtm7Sx6Fdon
	ZfR4gQjcpcEBz4BUIeQkVuOvJxHYcJgSgbrOPcbwMr2+YeIEZ0TCFq7o537Kvuu3wLsdkf
	ESLvemxIv7HTYp3qCII37Q3krBp9JI2/JxC+xQlbqWiXcOwHutzNNwAuAEai+4oSBsm5EB
	JGoz7OnsI9Kysd4Lszr7QH1XyEBLIGadYNhKa2/WIqDpPlGIe/ruGNMsj+0Mlg==
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH 01/10] dt-bindings: iio: accel: bosch,BMA220 improvements
Date: Mon,  1 Sep 2025 22:47:27 +0300
Message-ID: <20250901194742.11599-2-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250901194742.11599-1-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - fix title typo
 - add optional watchdog setting that recovers the sensor from a stuck-low
 SDA condition
 - set correct SPI phase and polarity
 - interrupt on rising edge. the level-based interrupt that is being
 replaced was not actually implemented in the driver.

This set of changes should not negatively affect existing users.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 .../bindings/iio/accel/bosch,bma220.yaml      | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
index ec643de031a3..f71b2320b010 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/accel/bosch,bma220.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#

-title: Bosch BMA220 Trixial Acceleration Sensor
+title: Bosch BMA220 Triaxial Acceleration Sensor

 maintainers:
   - Jonathan Cameron <Jonathan.Cameron@huawei.com>
@@ -20,6 +20,20 @@ properties:
   interrupts:
     maxItems: 1

+  bosch,watchdog:
+    description:
+      In order to prevent the built-in I2C slave to lock-up the I2C bus, a
+      watchdog timer is introduced. The WDT observes internal I2C signals and
+      resets the I2C interface if the bus is locked-up by the BMA220.
+      0 - off
+      1 - 1ms
+      2 - 10ms
+    enum: [0, 1, 2]
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  spi-cpha: true
+  spi-cpol: true
+
   vdda-supply: true
   vddd-supply: true
   vddio-supply: true
@@ -44,8 +58,10 @@ examples:
             compatible = "bosch,bma220";
             reg = <0>;
             spi-max-frequency = <2500000>;
+            spi-cpol;
+            spi-cpha;
             interrupt-parent = <&gpio0>;
-            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupts = <0 IRQ_TYPE_EDGE_RISING>;
         };
     };
 ...
--
2.49.1


