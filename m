Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D023141D7B
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2020 12:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgASLHD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jan 2020 06:07:03 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:39094 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726673AbgASLHD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jan 2020 06:07:03 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Jan 2020 06:07:02 EST
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 00JB0bem001025;
        Sun, 19 Jan 2020 13:00:37 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 7546260328; Sun, 19 Jan 2020 13:00:37 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, joel@jms.id.au
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/2] dt-binding: iio: add NPCM ADC reset support
Date:   Sun, 19 Jan 2020 13:00:31 +0200
Message-Id: <20200119110032.124745-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add NPCM ADC reset binding documentation.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
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

