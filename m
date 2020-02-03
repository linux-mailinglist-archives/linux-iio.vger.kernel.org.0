Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB58150939
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 16:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgBCPK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Feb 2020 10:10:28 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:36315 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727746AbgBCPK1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2020 10:10:27 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 013F9JC5001609;
        Mon, 3 Feb 2020 17:09:19 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 60F0D60328; Mon,  3 Feb 2020 17:09:19 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, joel@jms.id.au
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-binding: iio: add NPCM ADC reset support
Date:   Mon,  3 Feb 2020 17:09:16 +0200
Message-Id: <20200203150917.176391-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add NPCM ADC reset binding documentation.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
index eb939fe77836..ef8eeec1a997 100644
--- a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
@@ -6,6 +6,7 @@ Required properties:
 - compatible: "nuvoton,npcm750-adc" for the NPCM7XX BMC.
 - reg: specifies physical base address and size of the registers.
 - interrupts: Contain the ADC interrupt with flags for falling edge.
+- resets : phandle to the reset control for this device.
 
 Optional properties:
 - clocks: phandle of ADC reference clock, in case the clock is not
@@ -21,4 +22,5 @@ adc: adc@f000c000 {
 	reg = <0xf000c000 0x8>;
 	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&clk NPCM7XX_CLK_ADC>;
+	resets = <&rstc NPCM7XX_RESET_IPSRST1 NPCM7XX_RESET_ADC>;
 };
-- 
2.22.0

