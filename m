Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8AC8DD3
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfJBQIJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 12:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbfJBQII (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Oct 2019 12:08:08 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A88A021D82;
        Wed,  2 Oct 2019 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570032487;
        bh=aTT+KOPtG7lEZoKFjOcg12k7mYDVzqbZ+kRKqJj+Q/Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=yEmU39OEZPdIZkciVrsHxumq0dwlb6xYD984LvdxOpFBegUQbYQWY/kqPJNkQB/S/
         klHIFe9iE5JLM4gPOXgmmzDpt+3ictm+NdolqN8XcQ+4TvJlyCpK97vjB/H7i3U59c
         6CWPL8cy4Ul0kVyv78QOfgaINaaEebGmpqnpqAvk=
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
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: rtc: s3c: Use defines instead of clock numbers
Date:   Wed,  2 Oct 2019 18:07:42 +0200
Message-Id: <20191002160744.11307-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002160744.11307-1-krzk@kernel.org>
References: <20191002160744.11307-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make the examples in S3C RTC bindings more readable and bring them
closer to real DTS by using defines for clocks.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/rtc/s3c-rtc.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
index 95570d7e19eb..4d91cdc9b998 100644
--- a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
@@ -75,11 +75,14 @@ allOf:
 
 examples:
   - |
+    #include <dt-bindings/clock/exynos5420.h>
+    #include <dt-bindings/clock/samsung,s2mps11.h>
+
     rtc@10070000 {
         compatible = "samsung,s3c6410-rtc";
         reg = <0x10070000 0x100>;
         interrupts = <0 44 4>, <0 45 4>;
-        clocks = <&clock 0>, // CLK_RTC
-                 <&s2mps11_osc 0>; // S2MPS11_CLK_AP
+        clocks = <&clock CLK_RTC>,
+                 <&s2mps11_osc S2MPS11_CLK_AP>;
         clock-names = "rtc", "rtc_src";
     };
-- 
2.17.1

