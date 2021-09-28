Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B61A41B037
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbhI1Ndt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:33:49 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50551 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbhI1Ndq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:33:46 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A85EE60013;
        Tue, 28 Sep 2021 13:32:03 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 06/48] dt-bindings: mfd: ti,am3359-tscadc: Describe am4372 MFD compatible
Date:   Tue, 28 Sep 2021 15:31:01 +0200
Message-Id: <20210928133143.157329-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A more recent version of the am3359 ADC/Touchscreen controller is
available on certain SoCs of the am437x family. This IP has evolved a
little bit and deserves its own compatible.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
index b2bff85f2329..34bf6a01436f 100644
--- a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
@@ -16,6 +16,7 @@ properties:
       - items:
           - const: ti,am654-tscadc
           - const: ti,am3359-tscadc
+      - const: ti,am4372-magadc
 
   reg:
     maxItems: 1
@@ -47,6 +48,10 @@ properties:
     type: object
     description: Touchscreen controller child
 
+  mag:
+    type: object
+    description: Magnetic reader
+
 required:
   - compatible
   - reg
-- 
2.27.0

