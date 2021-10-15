Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BD842EB49
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbhJOIRR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:17:17 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:38481 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbhJOIRQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:16 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AFC0A20007;
        Fri, 15 Oct 2021 08:15:07 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v6 01/48] clk: ti: am43xx: Add clkctrl data for am43xx ADC1
Date:   Fri, 15 Oct 2021 10:14:19 +0200
Message-Id: <20211015081506.933180-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
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
Acked-by: Tony Lindgren <tony@atomide.com>
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

