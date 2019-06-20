Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F74DAB9
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 21:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfFTTwq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 15:52:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39631 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFTTwo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jun 2019 15:52:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id p24so3300649lfo.6;
        Thu, 20 Jun 2019 12:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgOvaybFVx8Zvodjw3FTHh7WY9oh8C3cTwy/9CQA0B4=;
        b=F0eb+SVnwJuZ6txyj6/fbZCjJoYMlFhpR9tEneH4igsKkJT9M9Ec1KiFfr8RkBK5zq
         Yntqpdj9ur5NQ7Y2gEa+pSI3AAoiFcw6mVjG/huQr1209hW2Lz5JgfTlWf6+/eLCzURN
         EPtFRawoXsmHWf8brKwNz+tpkVv7XFq+/shSOpQs0IFTPkmOsDucCjpxTSxuefPzcSF2
         bCs1ZQSQbZMf6SZJkP5LBtNDMqH6EOAu9dRwo6To0xhzJ6Eh3gCV4nN4qaciope1pPYs
         K1fp6ukzQz/diwewgyLEg9k6u1UV6fKzuRX+7f7tUch78ldcHaFezQnnM41ROgzjO3Lm
         7u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgOvaybFVx8Zvodjw3FTHh7WY9oh8C3cTwy/9CQA0B4=;
        b=nRgymk1VFZ2SfwKqs8lUO77rgwhZM/oGOW07unPw418piitii9iyYjAwaAya71iRNd
         13TF1v2uHnG1TUWXfIcWdeYcCyEz8NeNaVOHZ6CNnDz3fJDdrypVV6729EaePgYaaJFd
         undlXEqNM29fR28EaDBkalHkTR3jMPxy4iCAXQM3Xr0NwEJ2oif3RWo/C8IFTxXYYJ1z
         mkqjMHA+M/TBrM3CsU5zmwEeJmDfbof4i/GczfyTmzOkQmxzCz79v48p6d0MYWJAbVLo
         GHpfEm65Lwzlr+W3IwBSOUhyDeritnsX3FDSLvsWB//k2rxALuPAzjTCmJSnQl35BzBB
         wrcA==
X-Gm-Message-State: APjAAAXbVI+PgA1Zr0GgSEZYPWyOu2Lt9Nhkq3kHIRQq+6XbwBUmZgOx
        Mzn3PNKWb2Z3WSs2Bi3lW5aFkBhuxvULVg==
X-Google-Smtp-Source: APXvYqzCMHyz5LV/Dxn+p0BfDH2RL00iMtlOLHv2SMvlJvLnaOL8Ap+zWKh25kukExgA+IxVMY4Fiw==
X-Received: by 2002:ac2:518d:: with SMTP id u13mr1638021lfi.40.1561060361592;
        Thu, 20 Jun 2019 12:52:41 -0700 (PDT)
Received: from localhost.localdomain (89-64-59-58.dynamic.chello.pl. [89.64.59.58])
        by smtp.gmail.com with ESMTPSA id t17sm74645ljj.55.2019.06.20.12.52.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 12:52:41 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: chemical: sps30: convert bindings to yaml
Date:   Thu, 20 Jun 2019 21:50:10 +0200
Message-Id: <20190620195011.30942-2-tduszyns@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620195011.30942-1-tduszyns@gmail.com>
References: <20190620195011.30942-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert existing device tree bindings to yaml.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../bindings/iio/chemical/sensirion,sps30.txt | 12 ------
 .../iio/chemical/sensirion,sps30.yaml         | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
deleted file mode 100644
index 6eee2709b5b6..000000000000
--- a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-* Sensirion SPS30 particulate matter sensor
-
-Required properties:
-- compatible: must be "sensirion,sps30"
-- reg: the I2C address of the sensor
-
-Example:
-
-sps30@69 {
-	compatible = "sensirion,sps30";
-	reg = <0x69>;
-};
diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
new file mode 100644
index 000000000000..50a50a0d7070
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/sensirion,sps30.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SPS30 particulate matter sensor
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
+      - sensirion,sps30
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      air-pollution-sensor@69 {
+        compatible = "sensirion,sps30";
+        reg = <0x69>;
+      };
+    };
+
+...
--
2.22.0

