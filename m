Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED70BAC59D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406628AbfIGJUu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Sep 2019 05:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406600AbfIGJUt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Sep 2019 05:20:49 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0B2B218DE;
        Sat,  7 Sep 2019 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567848049;
        bh=LHFmcuk/vzruYg3dab9NBWSTbnEIQjOOGTrmtbnr1vo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=v5MkQIOSFsfvZcTxGNvc3U7CVH2HsEkHY6gy4q2XicW14ozJphjkVEogIwE2scXbE
         HnE4So0qSq/NzzA04npiXdkAUoSI/t3vIjdAFhZs5gUGU48mU/BcU1fQ3pkWFKtZsB
         b4DHql01Z09IqEOiMaLyBCLy2ETkqrNl+J99LV+s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: [PATCH v2 06/11] dt-bindings: arm: samsung: Convert Exynos Chipid bindings to json-schema
Date:   Sat,  7 Sep 2019 11:20:02 +0200
Message-Id: <20190907092007.9946-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190907092007.9946-1-krzk@kernel.org>
References: <20190907092007.9946-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert Samsung Exynos Chipid bindings to DT schema format using
json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/arm/samsung/exynos-chipid.txt    | 12 ---------
 .../bindings/arm/samsung/exynos-chipid.yaml   | 25 +++++++++++++++++++
 2 files changed, 25 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
deleted file mode 100644
index 85c5dfd4a720..000000000000
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-SAMSUNG Exynos SoCs Chipid driver.
-
-Required properties:
-- compatible : Should at least contain "samsung,exynos4210-chipid".
-
-- reg: offset and length of the register set
-
-Example:
-	chipid@10000000 {
-		compatible = "samsung,exynos4210-chipid";
-		reg = <0x10000000 0x100>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
new file mode 100644
index 000000000000..9c573ad7dc7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/samsung/exynos-chipid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC series Chipid driver
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - const: samsung,exynos4210-chipid
+
+  reg:
+    maxItems: 1
+
+examples:
+  - |
+    chipid@10000000 {
+      compatible = "samsung,exynos4210-chipid";
+      reg = <0x10000000 0x100>;
+    };
-- 
2.17.1

