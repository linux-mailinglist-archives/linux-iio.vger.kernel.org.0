Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF833F784F
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbhHYPaB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:30:01 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:55527 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbhHYPaA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:30:00 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 64443C8708;
        Wed, 25 Aug 2021 15:25:47 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 41381C0011;
        Wed, 25 Aug 2021 15:25:23 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jason Reeder <jreeder@ti.com>
Subject: [PATCH 01/40] clk: ti: am43xx: Add clkctrl data for am43xx ADC1
Date:   Wed, 25 Aug 2021 17:24:39 +0200
Message-Id: <20210825152518.379386-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Declare ADC1 clkctrl which feeds the magnetic-reader/ADC1 hardware
module.

Co-developed-by: Jason Reeder <jreeder@ti.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Jason Reeder <jreeder@ti.com>
---
 drivers/clk/ti/clk-43xx.c       | 1 +
 include/dt-bindings/clock/am4.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index 46c0add99570..6e97a541cfd3 100644
--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -116,6 +116,7 @@ static const struct omap_clkctrl_reg_data am4_l3s_clkctrl_regs[] __initconst = {
 	{ AM4_L3S_VPFE0_CLKCTRL, NULL, CLKF_SW_SUP, "l3_gclk" },
 	{ AM4_L3S_VPFE1_CLKCTRL, NULL, CLKF_SW_SUP, "l3_gclk" },
 	{ AM4_L3S_GPMC_CLKCTRL, NULL, CLKF_SW_SUP, "l3s_gclk" },
+	{ AM4_L3S_ADC1_CLKCTRL, NULL, CLKF_SW_SUP, "l3s_gclk" },
 	{ AM4_L3S_MCASP0_CLKCTRL, NULL, CLKF_SW_SUP, "mcasp0_fck" },
 	{ AM4_L3S_MCASP1_CLKCTRL, NULL, CLKF_SW_SUP, "mcasp1_fck" },
 	{ AM4_L3S_MMC3_CLKCTRL, NULL, CLKF_SW_SUP, "mmc_clk" },
diff --git a/include/dt-bindings/clock/am4.h b/include/dt-bindings/clock/am4.h
index d961e7cb3682..4be6c5961f34 100644
--- a/include/dt-bindings/clock/am4.h
+++ b/include/dt-bindings/clock/am4.h
@@ -158,6 +158,7 @@
 #define AM4_L3S_VPFE0_CLKCTRL	AM4_L3S_CLKCTRL_INDEX(0x68)
 #define AM4_L3S_VPFE1_CLKCTRL	AM4_L3S_CLKCTRL_INDEX(0x70)
 #define AM4_L3S_GPMC_CLKCTRL	AM4_L3S_CLKCTRL_INDEX(0x220)
+#define AM4_L3S_ADC1_CLKCTRL	AM4_L3S_CLKCTRL_INDEX(0x230)
 #define AM4_L3S_MCASP0_CLKCTRL	AM4_L3S_CLKCTRL_INDEX(0x238)
 #define AM4_L3S_MCASP1_CLKCTRL	AM4_L3S_CLKCTRL_INDEX(0x240)
 #define AM4_L3S_MMC3_CLKCTRL	AM4_L3S_CLKCTRL_INDEX(0x248)
-- 
2.27.0

