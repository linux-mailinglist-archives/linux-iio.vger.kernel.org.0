Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5CEAB40BF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 21:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390696AbfIPTBJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 15:01:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40381 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbfIPTBI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 15:01:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id d17so818984lfa.7;
        Mon, 16 Sep 2019 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdFwrVwEUeAJ2VkARMdjmgSlNTftRBjAbtQ5/KVV2eg=;
        b=FMVkQonCdVSH/hR0LlqfJmZq0V2ZeKqQjdyuZZh9k979QNY8a/wSyLiA7HwqHbgqQU
         KyfRakFCjhiqK+/UQnkjPaWVhnkE52hkioxLeAZFefPI7QYjukOWnNTmZqIDh1CcSWqW
         iVMevvVn9Tya7qJ9kBRmvvZNr3XdFGFpItIpwbEISLr+12G79LHCAQJhgmXeHHyzPBFj
         6nXO9Sm1UilWdlOuLYIzckydvROdUpmkAzMb5Whyh1f6DmocEad6Wr1SSa8mFWB7tRXY
         Z9VaEvSx6YpJwL27c1WUSbhJRV/093QzgkTMq627SkIcCQ6KzpbDoZJIA9a+U6hbpoE7
         vTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdFwrVwEUeAJ2VkARMdjmgSlNTftRBjAbtQ5/KVV2eg=;
        b=ftxfC4NLyh3JHVJeps1ZYj5eKthLsRqpTOxLcuDDJGct2Q3j5h9hhvQqeWqghLzq0O
         PDstHWE1HxBt6gshulZi160WmSSJ2/Rof/cVWDsxvfn00Ut22QCzrbb3XcIwiwCnSgv1
         nf/Sm57VHGo1kpG/+C2dzbuI3JrKVSxaQX0LOn6txOPy2hZWCZEmeoyk5TFELiJq3bIX
         +/h+HQC47O7o4DQ2oyr8eKtx8gj0IM7jZcp9AoGyCsOTOd/dvrdP/fcVzmnq87PJH8Qs
         jHEgU7UNW0ZEH4aartj1hyCS0mKNLm7l9PMmnEhaJuek0Kj6zvfOHm0fmreDmzMLE631
         G8sA==
X-Gm-Message-State: APjAAAXOs5mfybzPoPBr6aBS/d5J3SNQqggT9JyV2u/cyZ1PZk3TwWI9
        hg3as9QDD3a4DEewxHeUV9OcO9He44L1Lg==
X-Google-Smtp-Source: APXvYqxZofAFtbsd6wnuxMtHBbE3ssYtyu0+jzniPABwWRU7sHnYjLPfNGt2wY8ZZt86c6541hkyAw==
X-Received: by 2002:a19:4b4a:: with SMTP id y71mr489234lfa.118.1568660465364;
        Mon, 16 Sep 2019 12:01:05 -0700 (PDT)
Received: from arch.lan (89-70-31-203.dynamic.chello.pl. [89.70.31.203])
        by smtp.gmail.com with ESMTPSA id z9sm8414053ljn.78.2019.09.16.12.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 12:01:03 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: light: bh1750: convert bindings to yaml
Date:   Mon, 16 Sep 2019 21:00:23 +0200
Message-Id: <20190916190024.9955-2-tduszyns@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916190024.9955-1-tduszyns@gmail.com>
References: <20190916190024.9955-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert existing device tree bindings to yaml.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../devicetree/bindings/iio/light/bh1750.txt  | 18 --------
 .../devicetree/bindings/iio/light/bh1750.yaml | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.txt b/Documentation/devicetree/bindings/iio/light/bh1750.txt
deleted file mode 100644
index 1e7685797d7a..000000000000
--- a/Documentation/devicetree/bindings/iio/light/bh1750.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-ROHM BH1750 - ALS, Ambient light sensor
-
-Required properties:
-
-- compatible: Must be one of:
-    "rohm,bh1710"
-    "rohm,bh1715"
-    "rohm,bh1721"
-    "rohm,bh1750"
-    "rohm,bh1751"
-- reg: the I2C address of the sensor
-
-Example:
-
-light-sensor@23 {
-	compatible = "rohm,bh1750";
-	reg = <0x23>;
-};
diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
new file mode 100644
index 000000000000..1cc60d7ecfa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/bh1750.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BH1750 ambient light sensor
+
+maintainers:
+  - Tomasz Duszynski <tduszyns@gmail.com>
+
+description: |
+  Ambient light sensor with an i2c interface.
+
+properties:
+  compatible:
+    enum:
+      - rohm,bh1710
+      - rohm,bh1715
+      - rohm,bh1721
+      - rohm,bh1750
+      - rohm,bh1751
+
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
+      light-sensor@23 {
+        compatible = "rohm,bh1750";
+        reg = <0x23>;
+      };
+    };
+
+...
-- 
2.23.0

