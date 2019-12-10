Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6296F117FD4
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 06:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfLJFhx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Dec 2019 00:37:53 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:41602 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfLJFhx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Dec 2019 00:37:53 -0500
Received: by mail-pj1-f67.google.com with SMTP id ca19so6916708pjb.8;
        Mon, 09 Dec 2019 21:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93jiaHca4EssK1FrB0ZD+vlxRNxOIkPL2Gvfj6wAjrs=;
        b=f8bGqPWv9jFexQ3+/1p7H7zgG/pfozkxHk5xCjI5zoHK1Q7JGMv2VAfOsYa8KSuPpC
         4iIb5f2JAYGBDiKeb8K4bsGuxdxy4SfQR3aGD9fumHPmLbG9DkdcIATj2Z150YiSHiBf
         9l1kSGZwCh/E9zqDxQQEd34OpDKhwYf2tsHwThqxu7ouGuHF4/0mV4BdAgxzF7cpDRRC
         m5rAmGHHgGDdEKZsyVjGjPXIVvGShAy41loDKdtFjYUfzXyeCiUIhjjUWto63VSha3zz
         lHjk1Bs+UgmXT/mb4The2bTP809rPdy76RonLuojzqMMKIb08HLu+WyyjhoMWVosCD03
         vbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93jiaHca4EssK1FrB0ZD+vlxRNxOIkPL2Gvfj6wAjrs=;
        b=p3Zcb6Lbc16hNVyP/Yx7/WC0rHjX5272U33KKEYVd+Sv+pCzV2r7DqxfHRHbqa199r
         vyUY2Kz3FGI8wc9Vd5shxfTasa6EOU/APbjDQ2oV9gOv/UoqmsswNZoHFr69epPnD3qy
         FEC0dAwvSjZ1Gmh02DnAQF/ofD/G6rx0bsHQflD0mP6q6uPNt3CTT0IFHyNl1i4Mr/AY
         YrTq3rbQJ+P9/4Kq3ZoR31piZlYnPByNRkkt+hGHeMQmwIyEKreUqk95M2kJpYU0Qa0P
         Ft3mj/zQ+8lCNqQq4cv6iLyFceQKcYOT9xMv7IT6ssO4ITDLG/3v7aazXJdIuyOlDF5m
         i6xg==
X-Gm-Message-State: APjAAAUpXRr6Xdi2wLChEYrECIdFh2LTr8xHJayk1n9Eb4HColhOImgx
        QNjZrp3hyfwj1OyX3ArkgWk=
X-Google-Smtp-Source: APXvYqzvqcqss4VN9bzi2rJdG6EFDIZtvq7AJ+gTxgSbFi5YfSCeGmgRyP5oAZcdmFnp+fFuusOQUw==
X-Received: by 2002:a17:902:b095:: with SMTP id p21mr32946718plr.313.1575956272512;
        Mon, 09 Dec 2019 21:37:52 -0800 (PST)
Received: from ruantu.dev.localdomain ([103.103.128.212])
        by smtp.gmail.com with ESMTPSA id a17sm1152642pjv.6.2019.12.09.21.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 21:37:52 -0800 (PST)
From:   ruantu <mtwget@gmail.com>
To:     jic23@kernel.org
Cc:     mtwget@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: chemical: Add bindings for Dynament Premier series single gas sensor
Date:   Tue, 10 Dec 2019 13:37:44 +0800
Message-Id: <20191210053744.732093-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dynament Premier series single gas sensor.

Signed-off-by: ruantu <mtwget@gmail.com>
---
 .../iio/chemical/dynament,premier.yaml        | 43 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  1 +
 3 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml b/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
new file mode 100644
index 000000000000..076ae9d90cee
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/dynament,premier.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dynament Premier series single gas sensor
+
+maintainers:
+  - ruantu <mtwget@gmail.com>
+
+description: |
+  single gas sensor capable of measuring gas concentration of dust
+  particles, multi-gas sensor are not supported.
+
+  Specifications about the sensor can be found at:
+    https://www.dynament.com/_webedit/uploaded-files/All%20Files/SIL%20Data/tds0045_1.44.pdf, read chapter 1.5.2 Read live data simple
+
+properties:
+  compatible:
+    enum:
+      - dynament,premier
+
+  vcc-supply:
+    description: regulator that provides power to the sensor
+
+  reset-gpios:
+    description: GPIO connected to the RESET line
+    maxItems: 1
+
+required:
+  - compatible
+
+examples:
+  - |
+    serial {
+      single-gas-sensor {
+        compatible = "dynament,premier";
+        vcc-supply = <&reg_vcc5v0>;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6046f4555852..5afca0586c41 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -261,6 +261,8 @@ patternProperties:
     description: Dragino Technology Co., Limited
   "^dserve,.*":
     description: dServe Technology B.V.
+  "^dynament,.*":
+    description: Dynament, Ltd.
   "^ea,.*":
     description: Embedded Artists AB
   "^ebs-systart,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index 18c26558ddfe..84592789e01b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13137,6 +13137,7 @@ DYNAMENT PREMIER SERIES SINGLE GAS SENSOR DRIVER
 M:	ruantu <mtwget@gmail.com>
 S:	Maintained
 F:	drivers/iio/chemical/premier.c
+F:	Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
 
 PLANTOWER PMS7003 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
-- 
2.24.0

