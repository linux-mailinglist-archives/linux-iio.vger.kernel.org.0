Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 992FA64CB2
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2019 21:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfGJTWd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jul 2019 15:22:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43709 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfGJTWb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jul 2019 15:22:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id c19so2380267lfm.10;
        Wed, 10 Jul 2019 12:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIIZp+Q37HH0NVHz5A4ofMD82GD7Zo8OOifoKPsJ8KQ=;
        b=EMt12crlTJiCbnpidDiQaZPcrWb31ws/nhoO+1BCbl/GA35w725rSk42Rcn+8pAw+U
         zVWuQxgDUvsrk+xQcEcB5gcf8UO2LPpvoz0YP6diL4gCmxHZ4lIS6gc0Dr6IQ+N57UvG
         TYr8nRJwQ3xL3jZcRwWHd+Kqr0EFz7jCJZinu+SN7+DK35HFZRwcS2qrVZhF9MHNRjX4
         wHLqg55n8fN7KkoR4MjNslcLLwdEk+d8k0pgG/2YEJDjiOiG5/V/bhjimmEY+gHXtHQ2
         oEK3SJ25feC/oGWG3hJdq7tbt6SQHuXzsWQT8PUVJib1+4LgIlZAr3pghQF0g95AhmOp
         jTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIIZp+Q37HH0NVHz5A4ofMD82GD7Zo8OOifoKPsJ8KQ=;
        b=PcKTSOdSSh7Jl2x6kNFZ+/+g6+HnTGeUonBGhIGOUFFZPrYxgUSuw9JmLOvHKKxiFX
         7b0I4gaAUynAsZfqEsloYKkp7ofamxAfZ95pvCfwjiorBSW56Mh2ND13n1orzzTkR4eH
         8IBAgHZ/vq2HCn2L4UPw43gP7B9q2rQiCIQTG51WgBhUjCyQ2T526WLcHcWvUhOnytC3
         tjgnH2t/uOoWz7/A40IHBCDXZgEJCuKQ0wSWQ8mP3OzqJh2P83QOrzCwyemf27HnrlRs
         OHh/a0oJRttDEtP9emuCov2cu2SQaJx2lg2Pz7xrTyKWF/oxaj3quusxdzGpVzpM4SIq
         oqXQ==
X-Gm-Message-State: APjAAAWTEpdmoRGWxh1bJ/3CpTM7mZwOXXY/uS4SfVqb1xjtPQF9A1bE
        wYbawDCqx0V6C9oKt90nZZVyw1pL6Qw=
X-Google-Smtp-Source: APXvYqzkpEG2wG7Eoyjn3xgZFBTpgSO2gHYbBcmoBXSjDZ7XikNGbe+sgEnTpGo9IKXuSb3C8syKOg==
X-Received: by 2002:a19:5f58:: with SMTP id a24mr649526lfj.111.1562786549312;
        Wed, 10 Jul 2019 12:22:29 -0700 (PDT)
Received: from arch.lan (89-70-29-67.dynamic.chello.pl. [89.70.29.67])
        by smtp.gmail.com with ESMTPSA id a70sm603515ljf.57.2019.07.10.12.22.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 12:22:28 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: chemical: pms7003: convert bindings to yaml
Date:   Wed, 10 Jul 2019 21:21:54 +0200
Message-Id: <20190710192155.11489-2-tduszyns@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190710192155.11489-1-tduszyns@gmail.com>
References: <20190710192155.11489-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert existing device tree bindings to yaml.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../iio/chemical/plantower,pms7003.txt        | 26 ----------
 .../iio/chemical/plantower,pms7003.yaml       | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
deleted file mode 100644
index c52ea2126eaa..000000000000
--- a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* Plantower PMS7003 particulate matter sensor
-
-Required properties:
-- compatible: must one of:
-   "plantower,pms1003"
-   "plantower,pms3003"
-   "plantower,pms5003"
-   "plantower,pms6003"
-   "plantower,pms7003"
-   "plantower,pmsa003"
-- vcc-supply: phandle to the regulator that provides power to the sensor
-
-Optional properties:
-- plantower,set-gpios: phandle to the GPIO connected to the SET line
-- reset-gpios: phandle to the GPIO connected to the RESET line
-
-Refer to serial/slave-device.txt for generic serial attached device bindings.
-
-Example:
-
-&uart0 {
-	air-pollution-sensor {
-		compatible = "plantower,pms7003";
-		vcc-supply = <&reg_vcc5v0>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
new file mode 100644
index 000000000000..a551d3101f93
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/plantower,pms7003.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Plantower PMS7003 air pollution sensor
+
+maintainers:
+  - Tomasz Duszynski <tduszyns@gmail.com>
+
+description: |
+  Air pollution sensor capable of measuring mass concentration of dust
+  particles.
+
+properties:
+  compatible:
+    enum:
+      - plantower,pms1003
+      - plantower,pms3003
+      - plantower,pms5003
+      - plantower,pms6003
+      - plantower,pms7003
+      - plantower,pmsa003
+
+  vcc-supply:
+    description: regulator that provides power to the sensor
+    maxItems: 1
+
+  plantower,set-gpios:
+    description: GPIO connected to the SET line
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO connected to the RESET line
+    maxItems: 1
+
+required:
+  - compatible
+  - vcc-supply
+
+examples:
+  - |
+    serial {
+      air-pollution-sensor {
+        compatible = "plantower,pms7003";
+        vcc-supply = <&reg_vcc5v0>;
+      };
+    };
+
+...
-- 
2.22.0

