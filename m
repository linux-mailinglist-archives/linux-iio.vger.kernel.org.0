Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0C0D4336
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 16:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfJKOoE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 10:44:04 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:56603 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfJKOoD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 10:44:03 -0400
Received: from xps13.stephanxp.local (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8063C24001E;
        Fri, 11 Oct 2019 14:44:01 +0000 (UTC)
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
Subject: [PATCH v4 8/8] dt-bindings: Add max12xx SPI ADC series as trivial devices
Date:   Fri, 11 Oct 2019 16:43:47 +0200
Message-Id: <20191011144347.19146-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191011144347.19146-1-miquel.raynal@bootlin.com>
References: <20191011144347.19146-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update the compatible list with three Maxim ADCs compatibles.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index e0095ecb472f..765fd1c170df 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -120,6 +120,12 @@ properties:
           - maxim,max1029
             # 10-bit 16 channels 300ks/s SPI ADC with temperature sensor
           - maxim,max1031
+            # 12-bit 8 channels 300ks/s SPI ADC with temperature sensor
+          - maxim,max1227
+            # 12-bit 12 channels 300ks/s SPI ADC with temperature sensor
+          - maxim,max1229
+            # 12-bit 16 channels 300ks/s SPI ADC with temperature sensor
+          - maxim,max1231
             # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
           - maxim,max1237
             # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
-- 
2.20.1

