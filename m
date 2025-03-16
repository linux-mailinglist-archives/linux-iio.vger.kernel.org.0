Return-Path: <linux-iio+bounces-16916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07E2A636A8
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 18:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710E03AA5B1
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9691DC9BE;
	Sun, 16 Mar 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="HZOgJdm7"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19B1D79B3;
	Sun, 16 Mar 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145056; cv=none; b=Z15ewLErW/IdczpjFTw72i6N+iJVeTtoZIKruhxHOnJOL7CAdMhFaW2d/B/3MSQr2suhL1txn2n3xglh1N57SDU2uJ/kumH5bTLexHVF7A6VCQZndMcsAhiDwam9Xkgs4/h5x4ZUyrrtu2QiEChbVg0K0hWtTuZgqXzCu5nEHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145056; c=relaxed/simple;
	bh=Ut6/uvm/LJnsRkoge6Y+FX4G8D3w0CiJIl7k/asqpjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fMeiFm9jdefMIxTM3kAyOyZ+GGee3TAXQhf6xxl2XBReUZ5IgkC6dJ92nkxwaqUoVVPbOzOaZJDOn1GEa81cxZm0H5b3Ntg60nAej5s58rlnlyCYu4q54ddcKiUr3fgBJ13afSTA8Isti3szAWEiIjRWao7m2Md97ayxgY2Brg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=HZOgJdm7; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sFBq13VOe2LJlR8KlAGkiN9rR4oA/bfKUXRXI6P2gco=; b=HZOgJdm7Hpf4+mULIQ9zzxDkEv
	gCQf39KreA18mvnJ4aVJVB4hNDaWMzqD0fOEVvhQ5VNbBbVb7UkI/ExNSijNnNhQNhDItXBBBpwzc
	LgdWA5K/EB98WKOWSslBUdqgQXWYSIdGguxJJqpXScmZ3cx15JAmwY/2fR3rShrZHANy4mDuVIlL9
	Jgm3AWHRYSqkXOMld3H1kz7R4DRN9DeDOpwUh+iTquRFEDE4EsJa/DqITtAbuo5IKJigseP2PlreM
	3hzBegMkJq1iSYsLZAvGt2D/LyFAKHS/pl5XmJAtrNpbhyjQcVI2dKFpkvKwlPPWjd9d/FCCmPsTz
	pxnO2wqw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ttrAM-0000DB-2r;
	Sun, 16 Mar 2025 17:48:46 +0100
Received: from [2a0f:6480:1:600:fc64:4dfc:9829:9e5f] (helo=anderl.linuxhotel.de)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ttrAM-000MlM-3A;
	Sun, 16 Mar 2025 17:48:46 +0100
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
Subject: [PATCH v2 1/3] dt-bindings: iio: light: veml6046x00: add color sensor
Date: Sun, 16 Mar 2025 17:48:11 +0100
Message-Id: <20250316164813.30291-2-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250316164813.30291-1-ak@it-klinger.de>
References: <20250316164813.30291-1-ak@it-klinger.de>
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
 .../iio/light/vishay,veml6046x00.yaml         | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
new file mode 100644
index 000000000000..112d448ff0bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
@@ -0,0 +1,51 @@
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
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


