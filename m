Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A24F4CB6
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2019 14:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfKHNJz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Nov 2019 08:09:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34367 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfKHNJz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Nov 2019 08:09:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id e4so3951436pgs.1;
        Fri, 08 Nov 2019 05:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GcSRBv+6yTz1aWV2wpvc++0ONMW5Gc651FnwYD+LCXY=;
        b=AgNwXhZjuQufrlApx1Jt4Pc0HtcVyvwwVSLlsT0Y0iUejJKTiLItU0kX2vW9nbTulQ
         y8oUnlCp/keIMjsp4eE1qOqq6FaCFY7BpYN2GaPGHicCpYe02HrCmJt+Pyou5zsntIlq
         hvN+AXnd4MMjA1DvaTIrq1RRnkizwggFpRaFwKqgyAjlHPFlWecpJAWNmK9MS0000bkL
         ZoI9CRzQM75ObTfSPARlY7juiBvzzdVnTqGyqv9X/Qg1P/QzI2sgijADyR9bZcD/dJed
         +7BqyiqP2gyi2g2T4qbg0sO2jCexf6NG2a4XdjWEcxim3ikpt8X2b46p/MCKk5jCgK+Z
         wrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GcSRBv+6yTz1aWV2wpvc++0ONMW5Gc651FnwYD+LCXY=;
        b=pGiBRXEAWVxDmWOIx4UN0l5lIR44rcZj7fU0OIzjXVBpQsUmuLrxXKGnErl73u0+mO
         CAAEyGfakU7uwL4SIPlTCx0f+oF3/x37xE64wyEYIJ1WKvKYQoz5iHUSEbJah/WhQGnP
         ZhAVxbW8EAeNvgFcrbdHoH0rVMZFc2egEJAxOmOcl3hD1cbG7VDtECsScth2aF0g/v4k
         mMOYTiVUUwj+ynYv6lFU4ssH4pUyOhZ+qlEW/uvG03bExUmkWoMIXqzmpUJd4isPb9jT
         ePimt8cIUF1mO6eTttKgyGa61+ZXWcK9wt0Kf5nP3swSMNSUqNDXISfGA4nslJcRm/fG
         ExFw==
X-Gm-Message-State: APjAAAXumxfSIguNUAq/QHN6LAUsJ0ra7ESkJri4PPssK6jWzzGdL4Qr
        gBH8c3n/DoCWQA3xo/GFC1I=
X-Google-Smtp-Source: APXvYqxxrcn6kFUEnC0t1jD0cIy6EM9JE3qdhbm9La/8uN+duByFOP1K8RDli97qPAJSimst4cYNSA==
X-Received: by 2002:a63:f94e:: with SMTP id q14mr7489585pgk.411.1573218593385;
        Fri, 08 Nov 2019 05:09:53 -0800 (PST)
Received: from localhost (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id n21sm3384316pjq.13.2019.11.08.05.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Nov 2019 05:09:52 -0800 (PST)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH 1/3] dt-bindings: iio: adc: add support for AD5940
Date:   Fri,  8 Nov 2019 21:09:44 +0800
Message-Id: <20191108130946.14740-1-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add yaml devicetree description file and a header file for
helping configure positive and negtive input of AD5940.

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 .../bindings/iio/adc/adi,ad5940.yaml          | 240 ++++++++++++++++++
 include/dt-bindings/iio/adc/adi,ad5940.h      |  52 ++++
 2 files changed, 292 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml
 create mode 100644 include/dt-bindings/iio/adc/adi,ad5940.h

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml
new file mode 100644
index 000000000000..f7f034fdd8ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml
@@ -0,0 +1,240 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ad5940.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5940 Device Tree Bindings
+
+maintainers:
+  - Song Qiang <songqiang1304521@gmail.com>
+
+description: |
+  Analog Devices AD5940 High Precision, Impedance, and Electrochemical Front End.
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD5940.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5940
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      The regulator to be used to supply the reference voltage.
+    maxItems: 1
+
+  adi,interrupt-io:
+    description:
+      Output GPIO index of interrupt controller of AD5940.
+    maxItems: 1
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [0, 3, 6, 7]
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - adi,interrupt-io
+
+patternProperties:
+  # 'channel@0-255'
+  "^channel@([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$":
+    type: object
+    description: |
+      Represents the external channels which are connected to the ADC.
+      See Documentation/devicetree/bindings/iio/adc/adc.txt.
+    properties:
+      reg:
+        description:
+          Index of this channel, must be starting from 0.
+        maxItems: 1
+
+      diff-channels:
+        description:
+          Positive input and negtive input of the ADC buffer of this channel.
+          Input candidates are defined in include/dt-bindings/iio/adc/adi,ad5940.h.
+        minItems: 2
+        maxItems: 2
+        items:
+          - description: Positive input channel
+          - enum:
+            - AD5940_ADC_INPUTP_EXCITATION
+            - AD5940_ADC_INPUTP_FLOATING
+            - AD5940_ADC_INPUTP_HSTIA
+            - AD5940_ADC_INPUTP_LPTIA_LP
+            - AD5940_ADC_INPUTP_AIN0
+            - AD5940_ADC_INPUTP_AIN1
+            - AD5940_ADC_INPUTP_AIN2
+            - AD5940_ADC_INPUTP_AIN3
+            - AD5940_ADC_INPUTP_AVDD_2
+            - AD5940_ADC_INPUTP_DVDD_2
+            - AD5940_ADC_INPUTP_AVDD_REG_2
+            - AD5940_ADC_INPUTP_TEMP
+            - AD5940_ADC_INPUTP_VBIAS_CAP
+            - AD5940_ADC_INPUTP_DE0
+            - AD5940_ADC_INPUTP_SE0
+            - AD5940_ADC_INPUTP_VREF_2V5_2
+            - AD5940_ADC_INPUTP_VREF_1V82
+            - AD5940_ADC_INPUTP_P_TEMP_N
+            - AD5940_ADC_INPUTP_AIN4
+            - AD5940_ADC_INPUTP_AIN6
+            - AD5940_ADC_INPUTP_VZERO
+            - AD5940_ADC_INPUTP_VBIAS0
+            - AD5940_ADC_INPUTP_VCE0
+            - AD5940_ADC_INPUTP_VRE0
+            - AD5940_ADC_INPUTP_VCE0_2
+            - AD5940_ADC_INPUTP_LPTIA
+            - AD5940_ADC_INPUTP_AGND_REF
+
+          - description: Negtive input channel
+          - enum:
+              # Negtive input candidates
+              - AD5940_ADC_INPUTN_FLOATING
+              - AD5940_ADC_INPUTN_HSTIA
+              - AD5940_ADC_INPUTN_LPTIA
+              - AD5940_ADC_INPUTN_AIN0
+              - AD5940_ADC_INPUTN_AIN1
+              - AD5940_ADC_INPUTN_AIN2
+              - AD5940_ADC_INPUTN_AIN3
+              - AD5940_ADC_INPUTN_VBIAS_CA8
+              - AD5940_ADC_INPUTN_TEMP_N
+              - AD5940_ADC_INPUTN_AIN4
+              - AD5940_ADC_INPUTN_AIN6
+              - AD5940_ADC_INPUTN_VZERO
+              - AD5940_ADC_INPUTN_VBIAS0
+              - AD5940_ADC_INPUTN_EXCITATION
+
+      channel-name:
+        description:
+          Any string format name you would like to assign to this channel.
+        maxItems: 1
+
+    required:
+      - reg
+      - diff-channels
+      - channel-name
+
+examples:
+  - |
+    ad5940: ad5940@0 {
+      compatible = "adi,ad5940";
+      reg = <0>;
+      spi-max-frequency = <16000000>;
+      vref-supply = <&adc_vref>;
+      interrupt-parent = <&gpio>;
+      interrupts = <24 2>;
+
+      adi,interrupt-io = <0>;
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      channel@0 {
+        reg = <0>;
+        diff-channels = <AD5940_ADC_INPUTP_VCE0
+                         AD5940_ADC_INPUTN_VBIAS0>;
+        channel-name = "Vce-Vbias";
+      };
+
+      channel@1 {
+        reg = <1>;
+        diff-channels = <AD5940_ADC_INPUTP_VRE0
+                         AD5940_ADC_INPUTN_VBIAS0>;
+        channel-name = "Vre-Vbias";
+      };
+
+      channel@2 {
+        reg = <2>;
+        diff-channels = <AD5940_ADC_INPUTP_SE0
+                         AD5940_ADC_INPUTN_VBIAS0>;
+        channel-name = "Vse-Vbias";
+      };
+
+      channel@3 {
+        reg = <3>;
+        diff-channels = <AD5940_ADC_INPUTP_DE0
+                         AD5940_ADC_INPUTN_VBIAS0>;
+        channel-name = "Vde-Vbias";
+      };
+
+      channel@4 {
+        reg = <4>;
+        diff-channels = <AD5940_ADC_INPUTP_AIN0
+                         AD5940_ADC_INPUTN_VBIAS0>;
+        channel-name = "ain0-Vbias";
+      };
+
+      channel@5 {
+        reg = <5>;
+        diff-channels = <AD5940_ADC_INPUTP_AIN1
+                         AD5940_ADC_INPUTN_VBIAS0>;
+        channel-name = "ain1-Vbias";
+      };
+
+      channel@6 {
+        reg = <6>;
+        diff-channels = <AD5940_ADC_INPUTP_AIN2
+                         AD5940_ADC_INPUTN_VBIAS0>;
+        channel-name = "ain2-Vbias";
+      };
+
+      channel@7 {
+        reg = <7>;
+        diff-channels = <AD5940_ADC_INPUTP_AIN3
+                         AD5940_ADC_INPUTN_VBIAS0>;
+        channel-name = "ain3-Vbias";
+      };
+
+      channel@8 {
+        reg = <8>;
+        diff-channels = <AD5940_ADC_INPUTP_AIN4
+                         AD5940_ADC_INPUTN_VBIAS0>;
+        channel-name = "ain4-Vbias";
+      };
+
+      channel@9 {
+        reg = <9>;
+        diff-channels = <AD5940_ADC_INPUTP_AIN6
+                         AD5940_ADC_INPUTN_VBIAS0>;
+        channel-name = "ain6-Vbias";
+      };
+
+      channel@10 {
+        reg = <10>;
+        diff-channels = <AD5940_ADC_INPUTP_LPTIA_LP
+                         AD5940_ADC_INPUTN_LPTIA>;
+        channel-name = "Low power TIA DC";
+      };
+
+      channel@11 {
+        reg = <11>;
+        diff-channels = <AD5940_ADC_INPUTP_LPTIA
+                         AD5940_ADC_INPUTN_LPTIA>;
+        channel-name = "Low power TIA AC";
+      };
+
+      channel@12 {
+        reg = <12>;
+        diff-channels = <AD5940_ADC_INPUTP_HSTIA
+                         AD5940_ADC_INPUTN_HSTIA>;
+        channel-name = "High Speed TIA";
+      };
+
+      channel@13 {
+        reg = <13>;
+        diff-channels = <AD5940_ADC_INPUTP_TEMP
+                         AD5940_ADC_INPUTN_VBIAS0>;
+        channel-name = "Temperature";
+      };
+    };
diff --git a/include/dt-bindings/iio/adc/adi,ad5940.h b/include/dt-bindings/iio/adc/adi,ad5940.h
new file mode 100644
index 000000000000..c17826f2f654
--- /dev/null
+++ b/include/dt-bindings/iio/adc/adi,ad5940.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for configuring the AD5940 AFE
+ */
+
+#ifndef _DT_BINDINGS_IIO_ADC_AD5940_H
+#define _DT_BINDINGS_IIO_ADC_AD5940_H
+
+#define AD5940_ADC_INPUTN_FLOATING	0
+#define AD5940_ADC_INPUTN_HSTIA		1
+#define AD5940_ADC_INPUTN_LPTIA		2
+#define AD5940_ADC_INPUTN_AIN0		4
+#define AD5940_ADC_INPUTN_AIN1		5
+#define AD5940_ADC_INPUTN_AIN2		6
+#define AD5940_ADC_INPUTN_AIN3		7
+#define AD5940_ADC_INPUTN_VBIAS_CA8	10
+#define AD5940_ADC_INPUTN_TEMP_N	11
+#define AD5940_ADC_INPUTN_AIN4		12
+#define AD5940_ADC_INPUTN_AIN6		14
+#define AD5940_ADC_INPUTN_VZERO		16
+#define AD5940_ADC_INPUTN_VBIAS0	17
+#define AD5940_ADC_INPUTN_EXCITATION	20
+
+#define AD5940_ADC_INPUTP_FLOATING	0
+#define AD5940_ADC_INPUTP_HSTIA		1
+#define AD5940_ADC_INPUTP_LPTIA_LP	2
+#define AD5940_ADC_INPUTP_AIN0		4
+#define AD5940_ADC_INPUTP_AIN1		5
+#define AD5940_ADC_INPUTP_AIN2		6
+#define AD5940_ADC_INPUTP_AIN3		7
+#define AD5940_ADC_INPUTP_AVDD_2	8
+#define AD5940_ADC_INPUTP_DVDD_2	9
+#define AD5940_ADC_INPUTP_AVDD_REG_2	10
+#define AD5940_ADC_INPUTP_TEMP		11
+#define AD5940_ADC_INPUTP_VBIAS_CAP	12
+#define AD5940_ADC_INPUTP_DE0		13
+#define AD5940_ADC_INPUTP_SE0		14
+#define AD5940_ADC_INPUTP_VREF_2V5_2	16
+#define AD5940_ADC_INPUTP_VREF_1V82	18
+#define AD5940_ADC_INPUTP_P_TEMP_N	19
+#define AD5940_ADC_INPUTP_AIN4		20
+#define AD5940_ADC_INPUTP_AIN6		22
+#define AD5940_ADC_INPUTP_VZERO		23
+#define AD5940_ADC_INPUTP_VBIAS0	24
+#define AD5940_ADC_INPUTP_VCE0		25
+#define AD5940_ADC_INPUTP_VRE0		26
+#define AD5940_ADC_INPUTP_VCE0_2	31
+#define AD5940_ADC_INPUTP_LPTIA		33
+#define AD5940_ADC_INPUTP_AGND_REF	35
+#define AD5940_ADC_INPUTP_EXCITATION	36
+
+#endif /* _DT_BINDINGS_IIO_ADC_AD5940 */
-- 
2.17.1

