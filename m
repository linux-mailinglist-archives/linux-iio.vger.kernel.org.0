Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00F1228AF
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 11:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLQK3i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 05:29:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42890 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQK3i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 05:29:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so7296159pfz.9;
        Tue, 17 Dec 2019 02:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JTNPZj4R6hy/kPfugeFWOdOqCxuLmzIRB2a24Rsi0UU=;
        b=AtZSWquRFrJo8ANZBoLANMCHGsr8cmGI6j8EEx+sjQY+nbyEFwLQRHVkqsljBhNo7y
         8y+wM0GNkXT5qXnjR8lSxKwMFfadj/B17/TEbIQBxDA3CZbeKX6TGbcVlJlO2qiYXqOP
         JME9QiYiyOiHeCxwXQ1AecpN5J0Ne7JqPEqaMNrrbVhUyAjrJswRtrkNY4OTp1BjE/Kz
         SfsbRYiUqsjiuQFafvQXMDN616KLJLRY/8Nr47P6XE7ZArIm96+ExcgSlu8Krhz/p6eg
         qONuBPDW3ng5EJhLVx+j060v21sZbD6D3XFVlRCWx+z5ypbO8wCo+4rLrxPOfUZH+s99
         ZDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JTNPZj4R6hy/kPfugeFWOdOqCxuLmzIRB2a24Rsi0UU=;
        b=UAVkvE3wlyJcg/t5kVvAL5h+5y+p9sMR4BF4wmvqo4KiJHkMkH/d5LY4okwpUUYUDe
         sD2YxBNvvYEfUU988UqrRqjcVU6c4mZOha3L+7wyDg1fZaPcoeB4rceGTNe8Q7UjUBPQ
         0NRPYgoSqrRu0ZyQ6bZ9MPimy4KElDj6u+PK4vflRp0ijh9w5MlKwqFAGSuvA509nsV3
         POpymqqt4pdrV2BmPDzViztCIGU7zUgV14Jx9tg2CrpXslGEZkivJVjhO7dml5zE/cBW
         +Ov+VXRzPYWCRH/U9DjXUAETAVbCmh4fgkiQOIAtpV9EpEulYcvhnr+c0ZYMpa/mt+ht
         LM9Q==
X-Gm-Message-State: APjAAAWPsrSlp9j2RY6f0PC7D0gsQba+9LCZHnuTQWqrifNNTJHZdjdl
        OCMnztzqBYGxFunLUVBv5Pg=
X-Google-Smtp-Source: APXvYqy2M3iyqy1LrgbvFNgojJi+KNd5nRPfflDx2XtvkMn4hf8GwtfkDMiFF+Y5WGt3jtskhcWSkw==
X-Received: by 2002:a63:d958:: with SMTP id e24mr23804857pgj.31.1576578577547;
        Tue, 17 Dec 2019 02:29:37 -0800 (PST)
Received: from ruantu.dev.localdomain ([103.103.128.212])
        by smtp.gmail.com with ESMTPSA id r193sm28177501pfr.100.2019.12.17.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 02:29:36 -0800 (PST)
From:   YuDong Zhang <mtwget@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, YuDong Zhang <mtwget@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: chemical: Add bindings for Dynament Premier series single gas sensor
Date:   Tue, 17 Dec 2019 18:29:30 +0800
Message-Id: <20191217102930.26102-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dynament Premier series single gas sensor.

Signed-off-by: YuDong Zhang <mtwget@gmail.com>
---
 .../iio/chemical/dynament,premier.yaml        | 39 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  1 +
 3 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml b/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
new file mode 100644
index 000000000000..e2bbae4dd086
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/dynament,premier.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dynament Premier series single gas sensor
+
+maintainers:
+  - YuDong Zhang <mtwget@gmail.com>
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
index ae228ac7adc9..4842a0afe32b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5796,6 +5796,7 @@ DYNAMENT PREMIER SERIES SINGLE GAS SENSOR DRIVER
 M:	YuDong Zhang <mtwget@gmail.com>
 S:	Maintained
 F:	drivers/iio/chemical/premier.c
+F:	Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
 
 DYNAMIC DEBUG
 M:	Jason Baron <jbaron@akamai.com>
-- 
2.24.1

