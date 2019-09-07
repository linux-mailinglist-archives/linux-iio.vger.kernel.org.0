Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D07AC5C6
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 11:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406598AbfIGJUm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Sep 2019 05:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406592AbfIGJUk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Sep 2019 05:20:40 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3315F218AF;
        Sat,  7 Sep 2019 09:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567848039;
        bh=cWo8UMY+qdzhv9zEUE6bF/VNqUqOWP09bVH4/y6TTAk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hfhpT9X2LPD+6kHWEwHtG8iPFTCQcRpLme6YyGFxR4TOo/zh89KmBrFtQUBaYxO5I
         2ipPWsNaJdxH+ZvLexrFF89NRj5BzHaye5dZPy3ithhXHTFn6kUIvQm6Jg6pFKMblG
         bklNSwQBqUXcl5UjbPT77n5Z240DAKFGLplfQWBU=
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
Subject: [PATCH v2 04/11] dt-bindings: arm: samsung: Document missing S5Pv210 boards bindings
Date:   Sat,  7 Sep 2019 11:20:00 +0200
Message-Id: <20190907092007.9946-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190907092007.9946-1-krzk@kernel.org>
References: <20190907092007.9946-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing documentation of Samsung S5Pv210 SoC based boards bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/arm/samsung/samsung-boards.yaml           | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index d8811edf7b7a..98401a6db2a0 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -14,6 +14,16 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - description: S5PV210 based boards
+        items:
+          - enum:
+              - aesop,torbreck                  # aESOP Torbreck based on S5PV210
+              - samsung,aquila                  # Samsung Aquila based on S5PC110
+              - samsung,goni                    # Samsung Goni based on S5PC110
+              - yic,smdkc110                    # YIC System SMDKC110 based on S5PC110
+              - yic,smdkv210                    # YIC System SMDKV210 based on S5PV210
+          - const: samsung,s5pv210
+
       - description: S5PV210 based Aries boards
         items:
           - enum:
-- 
2.17.1

