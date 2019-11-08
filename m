Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2401BF4147
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2019 08:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfKHHXE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Nov 2019 02:23:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41831 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfKHHXE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Nov 2019 02:23:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id m9so5071311ljh.8;
        Thu, 07 Nov 2019 23:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bylgiZM2xRFq99r1QKW93hs3P5cqX5wAk6K6Dx44yjU=;
        b=L5r04l4MfZV8ucqNarNGUYWZAltL1WzaSICbTuJL1c3Lkj/LposlXXNzbkgFBl3Jj0
         BDOwx5fXK0KG5LyZnU/mYVsMes3fL+qmr+US9+PwF5WqwKXTMpD1tCL2AH7Vf6E818bK
         qPvI6WvnqlGLuvBPufFls59iWNqIsD2n90xQ1VGAuery+RWcQ81jTXyLwtGTdqtwR3wQ
         v+PY4tHiBfYY1onkrnpH3rZu8487dCjOjcI7Lryj2bXVLzMyNG0MkdTOUWHcj4xACG0l
         SqiWufbbvA3/JJK0e9eDPxqr0LfmU24yU0ZE8JFK+CTx4VbB1cQvc3UaNvsSofcoZxET
         qzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bylgiZM2xRFq99r1QKW93hs3P5cqX5wAk6K6Dx44yjU=;
        b=alxOrxi6/1qPsjd/4pM11aje4g4Xr0yrXGcKirzTGCki7hPMLXzpa8wWaDWdCOi/Gt
         b1ynZ1iOF3aKH9uKsOYiG5HPCmIjm1Z/8g9clE7y4W5D/77x4RGmZuqSbtjpsQ6UQ+X8
         03HWd+6VhvCOtOmBMLQJQEZGsoJ2vNFKHV+omNR1zjLd/gx3sjDvzXykAsrqOiCYeYil
         vfrztvqvpUBfG/tGOvNbHq19OHDiGa1VjADmAmhw0NG9mX5s/QdYoae4qeRNBBtNbSog
         kkQPjAO0IY5rHGA74TJEY6kPsze5d87HkGvz7gkdR5X60W+NGQI03qTJlXA/hOZq0O63
         XDoQ==
X-Gm-Message-State: APjAAAX0Oiz91/OTRUCsOuuro8eRUcDCxBJymwb2Y4zm+h7qG6o3cA/B
        YSpwrPg7cNOBbuE3XeK8jFc=
X-Google-Smtp-Source: APXvYqz1K08zUhgQhxwqBM8MTtpbDgSxm4D1wBRDtT4XepDniFLzeFfqiHVmJK8TqMD8F8ZRMggBUA==
X-Received: by 2002:a2e:b54d:: with SMTP id a13mr5615483ljn.4.1573197781419;
        Thu, 07 Nov 2019 23:23:01 -0800 (PST)
Received: from localhost.localdomain (c-5eea30e8-74736162.cust.telenor.se. [94.234.48.232])
        by smtp.gmail.com with ESMTPSA id f5sm1909924ljn.24.2019.11.07.23.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 23:23:00 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: iio: dac: Migrate LTC1660 documentation to yaml
Date:   Fri,  8 Nov 2019 08:25:39 +0100
Message-Id: <20191108072539.3547-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Rewrite bindings to use json-schema vocabulary.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 .../bindings/iio/dac/lltc,ltc1660.yaml        | 49 +++++++++++++++++++
 .../devicetree/bindings/iio/dac/ltc1660.txt   | 21 --------
 MAINTAINERS                                   |  2 +-
 3 files changed, 50 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
new file mode 100644
index 000000000000..13d005b68931
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+# Copyright 2019 Marcus Folkesson <marcus.folkesson@gmail.com>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/bindings/iio/dac/lltc,ltc1660.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Linear Technology Micropower octal 8-Bit and 10-Bit DACs
+
+maintainers:
+  - Marcus Folkesson <marcus.folkesson@gmail.com>
+
+description: |
+  Bindings for the Linear Technology Micropower octal 8-Bit and 10-Bit DAC.
+  Datasheet can be found here: https://www.analog.com/media/en/technical-documentation/data-sheets/166560fa.pdf
+
+properties:
+  compatible:
+    enum:
+      - lltc,ltc1660
+      - lltc,ltc1665
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 5000000
+
+  vref-supply:
+    description: Phandle to the external reference voltage supply.
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+  
+      dac@0 {
+        compatible = "lltc,ltc1660";
+        reg = <0>;
+        spi-max-frequency = <5000000>;
+        vref-supply = <&vref_reg>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/iio/dac/ltc1660.txt b/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
deleted file mode 100644
index c5b5f22d6c64..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* Linear Technology Micropower octal 8-Bit and 10-Bit DACs
-
-Required properties:
- - compatible: Must be one of the following:
-		"lltc,ltc1660"
-		"lltc,ltc1665"
- - reg: SPI chip select number for the device
- - vref-supply: Phandle to the voltage reference supply
-
-Recommended properties:
- - spi-max-frequency: Definition as per
-	 Documentation/devicetree/bindings/spi/spi-bus.txt.
-	 Max frequency for this chip is 5 MHz.
-
-Example:
-dac@0 {
-	compatible = "lltc,ltc1660";
-	reg = <0>;
-	spi-max-frequency = <5000000>;
-	vref-supply = <&vref_reg>;
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index fbccc9d450ff..23497d713298 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9619,7 +9619,7 @@ LTC1660 DAC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/dac/ltc1660.txt
+F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
 F:	drivers/iio/dac/ltc1660.c
 
 LTC4261 HARDWARE MONITOR DRIVER
-- 
2.23.0

