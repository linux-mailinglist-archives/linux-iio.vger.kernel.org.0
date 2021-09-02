Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1F93FF5E5
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347619AbhIBVwt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:52:49 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:60231 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347600AbhIBVwt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:52:49 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9E553240005;
        Thu,  2 Sep 2021 21:51:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 01/46] clk: ti: am43xx: Add clkctrl data for am43xx ADC1
Date:   Thu,  2 Sep 2021 23:50:59 +0200
Message-Id: <20210902215144.507243-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Declare ADC1 clkctrl which feeds the magnetic-reader/ADC1 hardware
module.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/ti/clk-43xx.c       | 1 +
 include/dt-bindings/clock/am4.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index e5538d577ce5..4a7900628f0c 100644
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

