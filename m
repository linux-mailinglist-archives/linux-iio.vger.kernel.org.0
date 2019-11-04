Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D7AEE628
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 18:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfKDRiF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 12:38:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35704 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfKDRiF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 12:38:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id y6so12907410lfj.2;
        Mon, 04 Nov 2019 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUNcrQSOI4sR8ixM1BFvc1Mc4tX105obcT/Qt8emx5A=;
        b=W0AMDC8tB7cgDZAYLAXWsst6rLCF34qqWs2VFiSVmr4w2o2MnEfiLJibugUec4cSkp
         JnGuSEgzSpWXE0x+5lo5OnTEDIFHEqss8mmxM9O7QGxI8wJa+Hn6f4TnKVI+CviIX0tB
         PF2wfLF5+Q+hG52l+gf7FPQhp9wiR9R+R2+3HeYTS3Spece97puytr6jRFHW73Wzksij
         dWrDp36sa9Pd1mEZ9r4F4RBuu02rDW5XUvkrj+MOBU9JDSRa+kAst634cOgppbItmvn7
         egfAzhqxXZttWGbgyNLdAajbk9Kd6nA1SndpTF/aOPILUbj1R/4bwB+E2dQu8y/cBq9q
         g74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUNcrQSOI4sR8ixM1BFvc1Mc4tX105obcT/Qt8emx5A=;
        b=jhxQ1VieNrmn9SFYSS/dsWgF8WmkvmHfj7gbuMStyt/HBPuhtNqvrYxtbp7XnemEP2
         cbeTeQAuQeRVuwtPK+101sUXqmY+xuloacIl4sE+zuFIVJxJZh6G1AlL/5T/TB17hGM7
         5PvdcXhuRsP/wS0xLlj5WNugMeskIWlAz+oL2u/zHHzdP5iDzNxwBTzXC7r8xx0wh4OM
         JAsZLSn+xllQxD+w1VZ5MC4uWXNWZ4nkzAEI7O2AfeVKkz4I2x5NEEOU9YoPF6foIL32
         1oQa6lxtCCglLjd847CycR+ipJmCWLHS07m1BIt9eVlrtNKRDXJfHjYTrfZ2CM1jNbD6
         tK9Q==
X-Gm-Message-State: APjAAAUhYEsB67vp2xlSIJmf/gzN90Wem5SfdYpLsD6n0S2Fo3f7rGrb
        /oC+HsdtC0Hl7MSjFtruC/o=
X-Google-Smtp-Source: APXvYqztqZhavZJd8viRhAJEQHNeRV3229XQ0PyA+N9A6KdwiN8etZAGPZVm6vw85TgRkdJF403hOw==
X-Received: by 2002:a19:5010:: with SMTP id e16mr3833483lfb.49.1572889081644;
        Mon, 04 Nov 2019 09:38:01 -0800 (PST)
Received: from localhost.localdomain (c-2ec20990-74736162.cust.telenor.se. [46.194.9.144])
        by smtp.gmail.com with ESMTPSA id s23sm6891061ljm.20.2019.11.04.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 09:38:00 -0800 (PST)
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
Subject: [PATCH] dt-bindings: iio: dac: Migrate LTC1660 documentation to yaml
Date:   Mon,  4 Nov 2019 18:40:36 +0100
Message-Id: <20191104174036.3535-1-marcus.folkesson@gmail.com>
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
 .../bindings/iio/dac/lltc,ltc1660.yaml        | 54 +++++++++++++++++++
 .../devicetree/bindings/iio/dac/ltc1660.txt   | 21 --------
 MAINTAINERS                                   |  2 +-
 3 files changed, 55 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
new file mode 100644
index 000000000000..1f3136bfffcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
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
+    description: SPI chip select number for the device
+    maxItems: 1
+
+  spi-max-frequency:
+    description: |
+      Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt.
+    maximum: 5000000
+    maxItems: 1
+
+  vref-supply:
+    description: Phandle to the external reference voltage supply.
+    maxItems: 1
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

