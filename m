Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 360D31857EF
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 02:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCOBv1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Mar 2020 21:51:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42600 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCOBv1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2020 21:51:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id 13so4989440oiy.9;
        Sat, 14 Mar 2020 18:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=35XhdiPf7N2b+kAbuAAdXV42xW5hub0L667+H4IKlmk=;
        b=YXFjcvBeV6V4LELDQyU58eupJBzeXQnfnsR6yFHR/maxum8Vs72anKO6WdFh/Z/Qek
         pR6wsEdmurMvkQg0FTAkBdskTO+SOovm+V0vgm8TPwEfYdOff7Us85puFuAtoaa+9d3R
         6uV4gsymxTnUJsWtXy6OqXtug5iXGH8CEG8XXZrUf9f6qIdAeW9QIQD5AfWg0YT3MhXr
         6L05Wj/4Bo+kxXcJojXlQcsl1vBGa8whfWQ3dZgyaakzt09KYB831bTUB141MkOzT+BX
         rrPj1RFcL6QnFjk8lzrKtwMRGqS02I8zJYmyip02DSzSL4Y5UuemFq+tQy7fim/zzF2T
         YhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=35XhdiPf7N2b+kAbuAAdXV42xW5hub0L667+H4IKlmk=;
        b=GoUi0VcTjOdRvF24ReovgkpQgiOHig8MIxsftsMFT3jPdc9q9uvhIkUCWw11SNt/bt
         Q30YdxKvQe32zgVFaiX7J8rMwM1ZLbahO5yyIsEo3T8siPtlOgx3SaXHtQfuVPIz8MrL
         y8SJ+s5ZDA2CXY8FN9/rGM/CQ1SLd6vT4vEcXSZ8T10C/1S80a9yCWd61LNF96XVjkSb
         4rYyJliDKydQ9vBrLu1EUZfgW1/AF02hz6gE1DeTFgJ3UKNep6T2/U3bJf7xDE84v0Bl
         jt2FcdyXVl/hB1vhl/UccxaFDZ9klFyxuSKgzjQgXxezpSv1J2K7hflcRXWcntXHxJ3G
         xHGg==
X-Gm-Message-State: ANhLgQ1SZzV8hBatpiv+KlAYdBgg365o9y0oetQtyO92MRLgMLMSHGO0
        P5bxrbFfY1rVRVZAZqmLlWpHksUw
X-Google-Smtp-Source: ADFU+vsfG2YRIywLZtaTGNFY5QnxtFNloA653nmIEte+/glxpF5LNbpsrXEPBg5BD0BeozWHLv5KUA==
X-Received: by 2002:a17:90a:a48b:: with SMTP id z11mr15529796pjp.1.1584193385623;
        Sat, 14 Mar 2020 06:43:05 -0700 (PDT)
Received: from nish-HP-Pavilion ([113.30.156.69])
        by smtp.gmail.com with ESMTPSA id md20sm14771530pjb.15.2020.03.14.06.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 06:43:05 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, nish.malpani25@gmail.com, sre@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: tsl2563: convert bindings to YAML
Date:   Sat, 14 Mar 2020 19:12:37 +0530
Message-Id: <20200314134237.12187-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the TSL2563 device tree bindings to the new YAML format.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

The link for the datasheet is not attached in the binding document
because it was not available on the manufacturer's (AMS) website [1].

[1] https://ams.com/ambient-light-sensors
---
 .../devicetree/bindings/iio/light/tsl2563.txt | 19 --------
 .../bindings/iio/light/tsl2563.yaml           | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/tsl2563.txt b/Documentation/devicetree/bindings/iio/light/tsl2563.txt
deleted file mode 100644
index f91e809e736e..000000000000
--- a/Documentation/devicetree/bindings/iio/light/tsl2563.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* AMS TAOS TSL2563 ambient light sensor
-
-Required properties:
-
-  - compatible : should be "amstaos,tsl2563"
-  - reg : the I2C address of the sensor
-
-Optional properties:
-
-  - amstaos,cover-comp-gain : integer used as multiplier for gain
-                              compensation (default = 1)
-
-Example:
-
-tsl2563@29 {
-	compatible = "amstaos,tsl2563";
-	reg = <0x29>;
-	amstaos,cover-comp-gain = <16>;
-};
diff --git a/Documentation/devicetree/bindings/iio/light/tsl2563.yaml b/Documentation/devicetree/bindings/iio/light/tsl2563.yaml
new file mode 100644
index 000000000000..2a70b8d62760
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/tsl2563.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/tsl2563.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS TAOS TSL2563 ambient light sensor
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  Ambient light sensor with an i2c interface.
+
+properties:
+  compatible:
+    enum:
+      - amstaos,tsl2563
+
+  reg:
+    maxItems: 1
+
+  amstaos,cover-comp-gain:
+    description: Multiplier for gain compensation
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [1, 16]
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      light-sensor@29 {
+        compatible = "amstaos,tsl2563";
+        reg = <0x29>;
+        amstaos,cover-comp-gain = <16>;
+      };
+    };
+...
-- 
2.20.1

