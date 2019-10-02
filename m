Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835B4C888C
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 14:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfJBMai (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 08:30:38 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52187 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfJBMah (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 08:30:37 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 64AA7E000B;
        Wed,  2 Oct 2019 12:30:35 +0000 (UTC)
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
Subject: [PATCH 6/7] dt-bindings: iio: adc: max1027: Mark interrupts as optional
Date:   Wed,  2 Oct 2019 14:30:24 +0200
Message-Id: <20191002123025.21413-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002123025.21413-1-miquel.raynal@bootlin.com>
References: <20191002123025.21413-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The chips have a 'start conversion' and a 'end of conversion' pair of
pins. They can be used but this is absolutely not mandatory as regular
polling is supported by the chip depending on its internal clocking
setup.

There is no physical reason to force the use of interrupts so turn
them optional.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/iio/adc/max1027-adc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt b/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
index e680c61dfb84..7b23d68f655c 100644
--- a/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
@@ -3,6 +3,8 @@
 Required properties:
   - compatible: Should be "maxim,max1027" or "maxim,max1029" or "maxim,max1031"
   - reg: SPI chip select number for the device
+
+Optional properties:
   - interrupts: IRQ line for the ADC
   see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 
-- 
2.20.1

