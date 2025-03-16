Return-Path: <linux-iio+bounces-16899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F53DA63567
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4EA16FCC7
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E38B1A0BCF;
	Sun, 16 Mar 2025 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="WwXaeq7o"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4919E7FA;
	Sun, 16 Mar 2025 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742124778; cv=none; b=UPmAaC6VapJFpH46X/FhCR+yyg2/atcREc/AZvEtfkrUmbI5dKeqZh84StmjwjMKBwN1y1XVtKCd5aAvOusvlOsyoV5/uAUGvE4jLT1cVcRijxO2WN7DdIop7AimtRmEcTEE2RBzzFcNdokILONUhlnAx0eULzp0PChMhobIdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742124778; c=relaxed/simple;
	bh=Mn8iYUp/ZrAYV0Cf/Yz5if2wB2UOuIKXA7uDL6OiNU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGu3y+DEvWsM9eoRTIWVLTi7qoxWMho8PZGZaoKDaBuXfe6/ke0lHcEoHgrH+yX4odu1wSkqe2o5q0XsUD0bEkj3a8gavolRCQiZDT+3hjm82Am671wRkAXOAlLfkjMvSNn70p5h3VBPLi3Nzk3rzc1lbgaDFV1VxIZ7rMHJHoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=WwXaeq7o; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jWog9o6qMNqYsivAKFCIvm/AOdaDfFoYilSEsJvVbp4=; b=WwXaeq7og5qiSSmFsN5eAiVLb9
	UO/c9aRtmPKj0fyw7CfxVJlXGKBD7atZe7pmZFNxOc2NAlQ8AciOgvI0vQvvrISAHC0KiD02Cxbu7
	U1wBedsjDLbdkzTXKZnYgQ+BN7eI1ie4XNLpsVCJ1Ur3x3aD362arxeUuyc33fdeXUStr9VrgbH1/
	thN8FIqJstjzvCvJQsvy1apU476azLAbBYK+kNHStSc4HdQ7fn/TCiwLrq4evmXNa1pasPhLTJ9Lj
	53Et44WL/HNVXgGtrSkGpEmzSQdyvFUOt1bRS3MDHHWxUbS2R+X94BNsXBix1Fb+HsCJRCGkl2v7Y
	09rS9R0Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ttmEd-0005cp-2g;
	Sun, 16 Mar 2025 12:32:51 +0100
Received: from [2a0f:6480:1:600:fc64:4dfc:9829:9e5f] (helo=anderl.linuxhotel.de)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ttmEd-0008s3-2Z;
	Sun, 16 Mar 2025 12:32:51 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com,
	subhajit.ghosh@tweaklogic.com,
	muditsharma.info@gmail.com,
	arthur.becker@sentec.com,
	ivan.orlov0322@gmail.com,
	ak@it-klinger.de
Subject: [PATCH 1/3] dt-bindings: iio: light: veml6046x00: add color sensor
Date: Sun, 16 Mar 2025 12:31:29 +0100
Message-Id: <20250316113131.62884-2-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250316113131.62884-1-ak@it-klinger.de>
References: <20250316113131.62884-1-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27579/Sun Mar 16 09:35:38 2025)

Add a new compatible for Vishay high accuracy RGBIR color sensor
veml6046x00.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../iio/light/vishay,veml6046x00.yaml         | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
new file mode 100644
index 000000000000..3207800fc539
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/vishay,veml6046x00.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Vishay VEML6046X00 High accuracy RGBIR color sensor
+
+maintainers:
+  - Andreas Klinger <ak@it-klinger.de>
+
+description:
+  VEML6046X00 datasheet at https://www.vishay.com/docs/80173/veml6046x00.pdf
+
+properties:
+  compatible:
+    enum:
+      - vishay,veml6046x00
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        color-sensor@29 {
+            compatible = "vishay,veml6046x00";
+            reg = <0x29>;
+            vdd-supply = <&vdd_reg>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...
-- 
2.39.5


