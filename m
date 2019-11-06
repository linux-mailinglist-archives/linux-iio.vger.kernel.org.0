Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA20F14A9
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2019 12:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfKFLKC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Nov 2019 06:10:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35007 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfKFLKC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2019 06:10:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id y6so17730870lfj.2;
        Wed, 06 Nov 2019 03:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bnwVsjbNiFuh5JOeo4upmlnPXVCJtlYPqMTxNS+DiLI=;
        b=cJUWstEO1+yXWrupneRMJq4VR/toW3Xn6XKBkK8AFQk3KovnnsTne6c7yoxHJfzAAJ
         mSZDlDpUPFKDZX75azo7tTmfn1KD79reG+D0kjqTKcWpYpBnj9a8yZAM+V27nwRLcLsi
         Ap7V3VQOx1fiLTjfx+D41QBSoYmGDUSXOaDFc0t9iu5/A0dUU/sl1ULFkWkehL52uKQC
         ujueJS8KncjrAaS+Q8JmPegGh0BuEgEad957GuRTSpQRIqVH2TSYtSMQ7JAzSK+K8sDD
         Pq+X+SnOGEhP/XiMng+HDbdSBKo4hgj6jixGLbNJnzV8z+DWdsmU2CKb4EJYVvI1AH9C
         v0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bnwVsjbNiFuh5JOeo4upmlnPXVCJtlYPqMTxNS+DiLI=;
        b=m3ujWBOsX64ZrHjj8tt2qyPxBG0ykcFdq0050zRp/JBSXWvomqIcH8DSWD088D0WFf
         fu1xg69cJR8nGQuW6g3iiwnniHxJzKWP01qWMB2SXJ9Pm6uaKiwGInGINWMmff12vpwM
         7O1Ago/nMcctHCMS0Q2i5/+oabmv/Ae7aWqFJPh2GboBOUj1jbR/mSmrB9xdEvhxM89o
         YcTIhKiAs26Xt4O5eQkuKf5zjr1I92ONWN22bBVm0jj1I/tc6IVOqbiesVV1eTtc7ejQ
         w7Z/tBkpSzQ2VLhqvP2EUMJb/XW7FJl70nEX3u//BxuZWv0lB0LvFRtnK0k5uOrupmQw
         IUKw==
X-Gm-Message-State: APjAAAVmzj6HO9fEsHa2KVpfyQ3dfABAwnANSPwaCsf3lhTmeESmYYE+
        XtxsVAFduBoqdiLGlZEbOFY=
X-Google-Smtp-Source: APXvYqyDAZlkhUC0it716Vc74H5Yhm1zXCS8linsSxcwyIkPeH3AM/teWSo+RcUkqCBTSrnOY7ThEQ==
X-Received: by 2002:ac2:4856:: with SMTP id 22mr23327083lfy.131.1573038599923;
        Wed, 06 Nov 2019 03:09:59 -0800 (PST)
Received: from localhost.localdomain ([94.234.51.156])
        by smtp.gmail.com with ESMTPSA id 28sm9888753lfy.38.2019.11.06.03.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 03:09:59 -0800 (PST)
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
Subject: [PATCH v2] dt-bindings: iio: dac: Migrate LTC1660 documentation to yaml
Date:   Wed,  6 Nov 2019 12:12:33 +0100
Message-Id: <20191106111233.6905-1-marcus.folkesson@gmail.com>
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

Notes:
    v2:
    	- Remove description for reg and spi-max-frequency (Rob & Alexa)
    	- Drop maxItems for vref-supply

 .../bindings/iio/dac/lltc,ltc1660.yaml        | 49 +++++++++++++++++++
 .../devicetree/bindings/iio/dac/ltc1660.txt   | 21 --------
 MAINTAINERS                                   |  2 +-
 3 files changed, 50 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
new file mode 100644
index 000000000000..505b3d54b81c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
@@ -0,0 +1,49 @@
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

