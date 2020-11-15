Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8CA2B38BB
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 20:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgKOTcE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 14:32:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgKOTcE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Nov 2020 14:32:04 -0500
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B729B2417E;
        Sun, 15 Nov 2020 19:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605468724;
        bh=5fY4eeo9CrRYbF8Nlf9tRn8nQcFcZJBg4wDkbHq0/ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gE3DpyVoqa1TyoXadHx70cfvLVhq109IFbxAcAxYgocrsVt0isbTS8lyeTIOMOh09
         n1mH79mdqMMdCLvvYtWGvL4OKRgn4dzyqf8LB7nqACZTgbAnjKzz0i/qMkbcfD/O43
         Z/QuVCAGZL+lfMYiTaOWTZl46CsiQuzTzW5l7LoA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/9] dt-bindings:iio:samsung,exynos-adc: drop missuse of io-channel-ranges
Date:   Sun, 15 Nov 2020 19:29:44 +0000
Message-Id: <20201115192951.1073632-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115192951.1073632-1-jic23@kernel.org>
References: <20201115192951.1073632-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

io-channel-ranges is a property for consumers of io-channels, not
providers.  Hence it is not relevant in this binding or the examples
given.

Recent changes to dt-schema result int his being reported as an error
as a dependency is enforced between this property and io-channels.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reported-by: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml       | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index 5ebb0ab250bd..c65921e66dc1 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -49,8 +49,6 @@ properties:
   "#io-channel-cells":
     const: 1
 
-  io-channel-ranges: true
-
   vdd-supply: true
 
   samsung,syscon-phandle:
@@ -130,7 +128,6 @@ examples:
         reg = <0x12d10000 0x100>;
         interrupts = <0 106 0>;
         #io-channel-cells = <1>;
-        io-channel-ranges;
 
         clocks = <&clock 303>;
         clock-names = "adc";
@@ -156,7 +153,6 @@ examples:
         reg = <0x126C0000 0x100>;
         interrupts = <0 137 0>;
         #io-channel-cells = <1>;
-        io-channel-ranges;
 
         clocks = <&cmu CLK_TSADC>,
                  <&cmu CLK_SCLK_TSADC>;
-- 
2.28.0

