Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA318ED14
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 23:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCVWqi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 18:46:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40087 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgCVWqh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 18:46:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id f3so14677840wrw.7;
        Sun, 22 Mar 2020 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zz9hBu718mZQ2dhsZQciqBHR8CZ+3iF/z6AsVOjjjyY=;
        b=cljqWDWNVqYRVCD8vIg6A/pDDgMfzse7X+Aff2doKntjJdlGKdmq5lPOWiMpWGA/Im
         xP2m5sVtG2/sG7P+NLDRZbGDguX0bow4/SESqsspLwmHp4Pi3VCFvKVBB/SzGOWJBZPx
         xg9v/x4SSCagzSiIJJQaLYL2A3qnySWTcJi46OMDT3V8rOBBUDnkRuDVZTocWxdCNE/6
         JN6FEO0nmxw5Owgp9ss5vAXlVlw0iBhovNRhCfMdHbRYZdEY0nfVN76Ncc1Y5QBajOym
         /JVJ0Lw/vab6CXaHxN8KKsMSKRrVUSQz09hpfasi7ubzGc1FRJsLwu1dV7JZ41iE5UG1
         MD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zz9hBu718mZQ2dhsZQciqBHR8CZ+3iF/z6AsVOjjjyY=;
        b=K7dlMmybAxX5dFsCIY6Lu4y2D6T1hdvDq27cG+F9PjFKLQf14FXpISVb82Uj/CuQLX
         CuRv3bTMAS3V2TE5sEbXDc+Q1hZ4HYinw/Ef2RRhu3Fom6EBroLx1AmyhTgBriqVnUuP
         EleCTMsUr2vZ2iz6xuQ3mqH4osfV0TcZuzY7b3Vw5iynVyXMYRQjmlP/d9OuMTAGUIVS
         WVc8uBMNxcbdC6+mMagrtTaYMs2PU7LuDpjfuSBbiN6rinM1wvSUvLcJqQYVvBTiemlU
         6vqUvOKqzMZokMrHddN01CnyKIROd37TwIJ8Zs0pQmz+OikJuO6P/mMOpK9YN4+3qlqQ
         WxuA==
X-Gm-Message-State: ANhLgQ1ka66g5e8EG+0p3iiwO1Bai/fGOgKck2CBROrUzAm4xY0H/sVK
        e5euYHSNsdvbJKfvmyGt2gFe+UNMvTQ=
X-Google-Smtp-Source: ADFU+vsa+VfsopPSbloSSuVuZxTchLF6DLY2tBzhHmfmq7SFR9xMpDvZmjRI1AdeaJjSyM/nMPnu6Q==
X-Received: by 2002:a5d:510d:: with SMTP id s13mr15739180wrt.110.1584917195266;
        Sun, 22 Mar 2020 15:46:35 -0700 (PDT)
Received: from localhost.localdomain (p5DCFFFE5.dip0.t-ipconnect.de. [93.207.255.229])
        by smtp.gmail.com with ESMTPSA id r9sm19158549wma.47.2020.03.22.15.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 15:46:34 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 1/5] dt-bindings: mfd: add document bindings for mp2629
Date:   Sun, 22 Mar 2020 23:46:22 +0100
Message-Id: <20200322224626.13160-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322224626.13160-1-sravanhome@gmail.com>
References: <20200322224626.13160-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding information for mp2629 mfd driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../devicetree/bindings/mfd/mps,mp2629.yaml   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
new file mode 100644
index 000000000000..314309ea91ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MP2629 Battery Charger PMIC from Monolithic Power System.
+
+maintainers:
+  - Saravanan Sekar <sravanhome@gmail.com>
+
+description: |
+  MP2629 is an PMIC providing battery charging and power supply for smartphones,
+  wireless camera and portable devices. Chip is contrlled over I2C.
+
+  The MFD device handles battery charger controller and ADC IIO device for
+  battery, system voltage
+
+properties:
+  compatible:
+    const: mps,mp2629
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+    description:
+      The first cell is the IRQ number, the second cell is the trigger type.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@4b {
+            compatible = "mps,mp2629";
+            reg = <0x4b>;
+
+            interrupt-controller;
+            interrupt-parent = <&gpio2>;
+            #interrupt-cells = <2>;
+            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.17.1

