Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34E1EBB57
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 01:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKAADc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Oct 2019 20:03:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43084 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfKAADc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Oct 2019 20:03:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id c26so10895374qtj.10;
        Thu, 31 Oct 2019 17:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKxv5zSXLT1ehgNKTex+0kSfIDKsNz1FYp7ELOBKXaw=;
        b=uQ+7UtyjG5GA1UQaFEr6n72Aa3Q4dGYJnOftfMff/8zzfTXCojzeL74N5S4ghYJsk4
         oDU8oZ0+M0n6yy2h9bQoVd5OZQ+tOc46ZzkgEoh4NC4WjF4w3pfGBZFXyKb5akkGCT37
         fpJ0WYT4Y50xOk1AkIfDharSR6bHEfRupZQlC1zOzt7tSZKpsX22Snk6jq9MEctd5ehM
         jtKGS8hXO4BTODlIVlZRodLYBUMuntTj2eXCd0DH2/DGPy4lRwV6DybOvc0lLiPgAKMw
         hj3IhtwhiPqO1kFbc9gyl3876rMWhuN5qClB/zhaZMM6f6pGa8lryvbb7ONdyjVy0yTt
         4MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKxv5zSXLT1ehgNKTex+0kSfIDKsNz1FYp7ELOBKXaw=;
        b=FFxuVesOYZxGF0foGdwnuE47UiU5yMlKhm3eeUVLLfU1snHo7Eew6KUQXZhaTQW2Of
         blJ2MJsEIsqYylhDl8ISEAjj9GYGqWsBxQeMqt7w4prjKwLbG/m9MFPud81p0nw0yDRM
         lgjLf/BW6tMEOZrOLAeeKBsEm42H420Kh4xFK4EZB77QQk85rVsDzYaVj8FncGZc+J2G
         dNoHndDPoAjQqssMjJuhCpZ5lNMwMAsX8QOpwIzyZaeCGb2S7kF+C0YJSZC8pHufOuo/
         coH8SxavS5Rx8rgrlNPuNQo2JuqhOpUhJwZJAWUmiSq/NtQbrt8SHNdKFk52BqS+dH+k
         dNUw==
X-Gm-Message-State: APjAAAWl+z/cOFZuUcqNf+Z5Y6NA8MOEmGAWwVxtqkAdB0zXqfbG7LWC
        ehILRRQEHNapzDDY78dGGZM=
X-Google-Smtp-Source: APXvYqymy6b+iU9I+tawyTCVvYzzlBX02xlrg519Yb/4Rlqrui7DJhFfgNwIGWHab1ijOZsnqjWQSg==
X-Received: by 2002:ac8:549:: with SMTP id c9mr769668qth.178.1572566610732;
        Thu, 31 Oct 2019 17:03:30 -0700 (PDT)
Received: from localhost.localdomain ([187.34.252.37])
        by smtp.gmail.com with ESMTPSA id n5sm2693959qke.74.2019.10.31.17.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 17:03:30 -0700 (PDT)
From:   Rodrigo Carvalho <rodrigorsdc@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH v3] dt-bindings: iio: accel: add binding documentation for ADIS16240
Date:   Thu, 31 Oct 2019 21:03:01 -0300
Message-Id: <20191101000301.12901-1-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add device tree binding documentation for ADIS16240.

Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
---
V3:
   - Remove spi-cpol and spi-cpha field. They don't seem necessary
 .../bindings/iio/accel/adi,adis16240.yaml     | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
new file mode 100644
index 000000000000..9a4cd12c4818
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adis16240.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADIS16240 Programmable Impact Sensor and Recorder driver
+
+maintainers:
+  - Alexandru Ardelean <alexandru.ardelean@analog.com>
+
+description: |
+  ADIS16240 Programmable Impact Sensor and Recorder driver that supports
+  SPI interface.
+    https://www.analog.com/en/products/adis16240.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16240
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a SPI device node */
+        accelerometer@0 {
+            compatible = "adi,adis16240";
+            reg = <0>;
+            spi-max-frequency = <2500000>;
+            spi-cpol;
+            spi-cpha;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.23.0

