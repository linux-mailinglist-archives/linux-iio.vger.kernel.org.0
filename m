Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE876CAD17
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2019 19:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbfJCReX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Oct 2019 13:34:23 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40435 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbfJCReW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Oct 2019 13:34:22 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 07B71FF80E;
        Thu,  3 Oct 2019 17:34:18 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 7/7] dt-bindings: iio: adc: max1027: Document max12xx series compatibles
Date:   Thu,  3 Oct 2019 19:34:01 +0200
Message-Id: <20191003173401.16343-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191003173401.16343-1-miquel.raynal@bootlin.com>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update the bindings documentation with new Maxim ADCs compatibles.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/iio/adc/max1027-adc.txt        | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt b/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
index 7b23d68f655c..1b703a01d882 100644
--- a/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
@@ -1,7 +1,13 @@
-* Maxim 1027/1029/1031 Analog to Digital Converter (ADC)
+* Maxim 1027/1029/1031/1227/1229/1231 Analog to Digital Converter (ADC)
 
 Required properties:
-  - compatible: Should be "maxim,max1027" or "maxim,max1029" or "maxim,max1031"
+  - compatible: Should be one of:
+    * "maxim,max1027"
+    * "maxim,max1029"
+    * "maxim,max1031"
+    * "maxim,max1227"
+    * "maxim,max1229"
+    * "maxim,max1231"
   - reg: SPI chip select number for the device
 
 Optional properties:
-- 
2.20.1

