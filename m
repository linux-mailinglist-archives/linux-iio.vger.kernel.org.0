Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF89B28C
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2019 16:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395470AbfHWOyc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Aug 2019 10:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731256AbfHWOyb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Aug 2019 10:54:31 -0400
Received: from localhost.localdomain (unknown [194.230.147.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1037E22CEC;
        Fri, 23 Aug 2019 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566572070;
        bh=jTAvGbrIK7woCiAoMenaLUv5khtvsQODuJCy3dMwJ9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRf881yAjVE0zeNA2qSnKLZgBcDtbdT4tEenaTy2u/MXhAAOs86cHIlma5ZdPkfAU
         SAPZeWeIhZCQ99TWrCqfg8h3bjmt1ac2NxZ9bJ4U2raY9g996sFA0zVc9PCSiJMRLg
         moxpGG/hU/a9YYx6mYd+WlYfV/D/tqrc1Ynr+qQA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     notify@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [RFC 2/9] dt-bindings: arm: samsung: Document missing S5Pv210 boards bindings
Date:   Fri, 23 Aug 2019 16:53:49 +0200
Message-Id: <20190823145356.6341-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823145356.6341-1-krzk@kernel.org>
References: <20190823145356.6341-1-krzk@kernel.org>
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
index e963fd70c436..f8da3b5fb374 100644
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

