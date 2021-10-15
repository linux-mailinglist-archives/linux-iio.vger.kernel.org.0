Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CCC42EB58
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbhJOIRb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:17:31 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58511 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbhJOIRX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:23 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6ACF92000A;
        Fri, 15 Oct 2021 08:15:15 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 06/48] dt-bindings: mfd: ti,am3359-tscadc: Describe am4372 MFD compatible
Date:   Fri, 15 Oct 2021 10:14:24 +0200
Message-Id: <20211015081506.933180-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
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

