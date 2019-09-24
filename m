Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9FE5BC610
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2019 12:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438881AbfIXK6I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Sep 2019 06:58:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38004 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388652AbfIXK6I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2019 06:58:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id w10so840883plq.5;
        Tue, 24 Sep 2019 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1uLcprepoBdWyKW9LylPGoN3ylDuBDWdUhK2CKVWl/8=;
        b=KknHRWgSeyHKgIKK/bYF+T0DhZkIo92kEM4AP/3AH/tXdMiX6MWqA9TGuLlcRITZB4
         QUAw1NGBSk0t0HYyxcRVVhwS7vWrawmhQ9/vuLutYi1iG9U8r8huiX26swCB+uKPj+Mh
         JUMObwMX3ZUcVVYYOnRWI8r8JA6WkbOYkgeq2j2zbKqbZ6XTo2+sZQoeVtMsw6WmdJ1T
         GqOkbeaUiIAP11xXNOU8JaAsmG7ylR4eAEP0d5Emv4L775n4NbqXUsSbXIa+ns4sHPRt
         D4xWHHfQI8qgZKoZRG5UfcComUG4sWrbAMo8WexQCWmP3AYarl7/NSqQ3/pS8rB0ASo5
         f3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1uLcprepoBdWyKW9LylPGoN3ylDuBDWdUhK2CKVWl/8=;
        b=mjfz9TJIWkwle0nhwAnLAXKvHFfVFPAGE/kV5eFw+K+quuehJ3HPOo+ySq7cgvMdGS
         RkSTQbxmiD3AH8exyiqvZPYAKA1xl/ShlhAq/4/bvW0raFdid+ML0TFMTPQtY/KsrvkU
         MvSwVf8cTQeEc8wpKZe0o1kj9pnI3Ezm96WFLSMx6hY1QxX78CleP3d8s1zW+m2TMK4k
         Y4Pe+HlUib4+ic1cPn7OuzS+8nk2W0P4618pSCpvXxwDqvgAlo8xqnln9uDfGJRBrtJ3
         J6pfytyn+nll91tQPuKCl1hKIaHUSFsVtG/kMp5ILl95OV3VlyMR0WeU/mjOYZ1E/txS
         8+HQ==
X-Gm-Message-State: APjAAAXv3mCCg5zS6/XuHtdh9zx83/llI+WwKvzUHfA10sPiEciDi0yr
        MVhZ75D3a6PKYNdf0GC8bOA=
X-Google-Smtp-Source: APXvYqxnJrvXqL382NC5KpQCcd7G7BJPv+bDVB4njdI+jp4HRxX9mbXKRETglZ//GrgiJatj/iKN/Q==
X-Received: by 2002:a17:902:169:: with SMTP id 96mr2150622plb.297.1569322687320;
        Tue, 24 Sep 2019 03:58:07 -0700 (PDT)
Received: from localhost.localdomain ([106.51.110.135])
        by smtp.gmail.com with ESMTPSA id c125sm1953886pfa.107.2019.09.24.03.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Sep 2019 03:58:06 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hslester96@gmail.com, wsa+renesas@sang-engineering.com,
        Rishi Gupta <gupt21@gmail.com>
Subject: [RESEND PATCH v2 2/3] dt-bindings: iio: light: add veml6030 ALS bindings
Date:   Tue, 24 Sep 2019 16:21:57 +0530
Message-Id: <b9d5cb134c7c2c7351025a0b556148bca23f302f.1569321085.git.gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1569321085.git.gupt21@gmail.com>
References: <cover.1569321085.git.gupt21@gmail.com>
In-Reply-To: <cover.1569321085.git.gupt21@gmail.com>
References: <cover.1569321085.git.gupt21@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds device tree bindings for veml6030 ambient
light sensor.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v2:
* Corrected grammatical mistake from 'is' to 'are' in description of bindings

 .../devicetree/bindings/iio/light/veml6030.yaml    | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/veml6030.yaml b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
new file mode 100644
index 0000000..969b314
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
+  If the interrupts are used, application will receive an IIO event
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

