Return-Path: <linux-iio+bounces-9350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDBD9709FD
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 23:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD792827EC
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 21:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B751184118;
	Sun,  8 Sep 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="kXpovhT/"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16617BEBD;
	Sun,  8 Sep 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725829801; cv=none; b=W9qpK7mdLum70wGwgXDSzqvQrGzBlEpNkY9g6sMbjthtCRGpYKk64elZa8SxFEGKGV5qigPGronaO5JFBx/QGlEaCVZ6l8E2083zHRZoCzYoxN9RUQm1Omi4UeuRTnMxClWf3lu+xA+TdhctdNSjp8mAyzqSrONIzc/HhC6eF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725829801; c=relaxed/simple;
	bh=iqySBVgrCYk4SEf5Smqb0R4Fqpk7CWOcEPykIQqXkH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDifQsRNOEsBlcxT8bPMacoT0CsjHxRhI9XRdJsRxFs0UQXTfU2YBfBO7fC2RnN8AL1Ds8I/DytlzrcwNLVrSYnVkaj3xwDQWlR993mtO6GyBUj8EGEYdPh0UD43Oa+j3e1HRVUafUH+oFrzmutna9IXcP9V/zuCd5vdtBkbG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=kXpovhT/; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bN6g5LuUOiaBgVx2RDzw9SfT+Ft8rUzg+cw1TiUo10A=; b=kXpovhT/1PglOGOYSZG1/onakN
	Zgc7SaXzy5UvdMJdX/hUbYm8kOw8xEUq0dzJBy3r/dhLzp642DI0ov87xe3Aj7iDA4S+iieCvb3YR
	6vCT6KEvFh1WReF5eT1Qk12Pzc5ACEDxRbdHoVWa6hh5aTzAk26n/k7qJAOjSm+bAvN4IsoRbwOQ6
	wg1G79xx9nluJE4uzWSS06kFzAFzUHZRHW6l+e8km+SFkwH6AevuFHh5HAWjg3zzlnaEik+YX8n+a
	MNuJyaCD+Sx3kOBOo9/3jXpHeeYBQqIVaJt7C3j0XYoMhUA5fQj8qec5aitc6V3+SSa+vYiNGvotx
	WmPMwaGg==;
Received: from i5e8616cc.versanet.de ([94.134.22.204] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1snPA2-0003s9-Su; Sun, 08 Sep 2024 23:09:30 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	jikos@kernel.org,
	jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	pavel@ucw.cz,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 3/9] dt-bindings: mfd: add binding for qnap,ts433-mcu devices
Date: Sun,  8 Sep 2024 23:07:57 +0200
Message-ID: <20240908210803.3339919-4-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908210803.3339919-1-heiko@sntech.de>
References: <20240908210803.3339919-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These MCUs can be found in network attached storage devices made by QNAP.
They are connected to a serial port of the host device and provide
functionality like LEDs, power-control and temperature monitoring.

LEDs, buttons, etc are all elements of the MCU firmware itself, so don't
need devicetree input, though the fan gets its cooling settings from
a fan-0 subnode.

A binding for the LEDs for setting the linux-default-trigger may come
later, once all the LEDs are understood and ATA controllers actually
can address individual port-LEDs, but are really optional.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/mfd/qnap,ts433-mcu.yaml          | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml

diff --git a/Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml b/Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml
new file mode 100644
index 000000000000..877078ac172f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/qnap,ts433-mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QNAP NAS on-board Microcontroller
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+description:
+  QNAP embeds a microcontroller on their NAS devices adding system feature
+  as PWM Fan control, additional LEDs, power button status and more.
+
+properties:
+  compatible:
+    enum:
+      - qnap,ts433-mcu
+
+patternProperties:
+  "^fan-[0-9]+$":
+    $ref: /schemas/hwmon/fan-common.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    uart {
+      mcu {
+        compatible = "qnap,ts433-mcu";
+
+        fan-0 {
+          #cooling-cells = <2>;
+          cooling-levels = <0 64 89 128 166 204 221 238>;
+        };
+      };
+    };
-- 
2.43.0


