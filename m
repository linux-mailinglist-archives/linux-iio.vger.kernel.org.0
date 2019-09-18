Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A2B5A06
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 05:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfIRDJl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 23:09:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33858 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIRDJl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 23:09:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so3148730pgc.1;
        Tue, 17 Sep 2019 20:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V4dfqH9cr9ZOJT5sqm0l8wJAHrLJRz9FaSLp2042uos=;
        b=f6I1NeEXkGZ+sI1W6vqQ3Y/3dEuWWik83da25RFn9o23iJAJ/oxK6RznhDlnmGWuPQ
         KYPplaJOfndptEX4em+UyRRA7HNyI0AvLFeBA7Efhceyxu7a0rrZYB8FXprX/68MHror
         6P5Ly+AgT6+J5GoDvw2Pb27ZGkJYRF4Ek1fvVuGw4Ap82Nbtb9FRu9sRpVSRo1hKqNBU
         w4ulOuC+PlO/zqCZrHvFqegyvXHahAIllsa0IHCk1lwoygBuOzS4xsrunM8esMDTq4YF
         EW34I87wYZBxvia7KmbkDgq3tlToYtEjN4eXYTgJ0KO1xsOhmxAzvcnZDE62keJ2HkfU
         PNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V4dfqH9cr9ZOJT5sqm0l8wJAHrLJRz9FaSLp2042uos=;
        b=jj40HEmZWrQDmqHu7GMrUyBAU7KkuEGI10yVbgJm8/CFSLqigciew62VPFefQaWgEc
         YpRmfJP/vfTfcKpDx+7MIpcIPTtheps+AUZEbxRt/gC75pCpNIV7i4KF75GkHQbJqu+u
         dkVBPeurHPLeFbQiiigos8jD6kOYeGV8Kyhm6cY0EO5YBVXZuWLKqon4Ko9E6vsnGkGG
         +YRH8w1v0MT8UZqVGZPL8mVvMm/O8N0uBfAN6mD/zY8Zahsir4o0kdn1U+vp1skgHAbp
         t4Uum9WKtBYxzyEeM7rkO+YT01CILz2+HNQkrgKeNy0acygK/UqYjo6smvyYh72ZjNtV
         Ql5g==
X-Gm-Message-State: APjAAAUq0kpMgUdEaDB/EAzTJnv19LEaqDwkJs8FUCc9W4TFF2ZUt6bg
        KjXwJ9zs+s1ElVQLxo9fkag=
X-Google-Smtp-Source: APXvYqy+Sb0cPBxaiBO8RFeDBF74xOQD0n4XvdxcLRptPZpeHmV77/W8sr/JsMMNn+hDCC6hEN0oXg==
X-Received: by 2002:a63:c0d:: with SMTP id b13mr1900935pgl.420.1568776180514;
        Tue, 17 Sep 2019 20:09:40 -0700 (PDT)
Received: from localhost.localdomain ([106.51.108.240])
        by smtp.gmail.com with ESMTPSA id x68sm4234116pfd.183.2019.09.17.20.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 20:09:40 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH 2/2] dt-bindings: iio: light: add veml6030 ALS bindings
Date:   Wed, 18 Sep 2019 08:39:17 +0530
Message-Id: <1568776157-5373-3-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568776157-5373-1-git-send-email-gupt21@gmail.com>
References: <1568776157-5373-1-git-send-email-gupt21@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds device tree bindings for veml6030 ambient
light sensor.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 .../devicetree/bindings/iio/light/veml6030.yaml    | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/veml6030.yaml b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
new file mode 100644
index 0000000..d92684a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/veml6030.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VEML6030 Ambient Light Sensor (ALS)
+
+maintainers:
+  - Rishi Gupta <gupt21@gmail.com>
+
+description: |
+  Bindings for the ambient light sensor veml6030 from Vishay
+  Semiconductors over an i2c interface.
+
+  Irrespective of whether interrupt is used or not, application
+  can get the ALS and White channel reading from IIO raw interface.
+
+  If the interrupts is used, application will receive an IIO event
+  whenever configured threshold is crossed.
+
+  Specifications about the sensor can be found at:
+    https://www.vishay.com/docs/84366/veml6030.pdf
+
+properties:
+  compatible:
+    enum:
+      - vishay,veml6030
+
+  reg:
+    description:
+      I2C address of the device. If the ADDR pin on veml6030
+      is pulled up, this address is 0x48. If the ADDR pin is
+      pulled down, this address is 0x10.
+    maxItems: 1
+
+  interrupts:
+    description:
+      interrupt mapping for IRQ. Configure with IRQ_TYPE_LEVEL_LOW.
+      Refer to interrupt-controller/interrupts.txt for generic
+      interrupt client node bindings.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@10 {
+                compatible = "vishay,veml6030";
+                reg = <0x10>;
+                interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
-- 
2.7.4

