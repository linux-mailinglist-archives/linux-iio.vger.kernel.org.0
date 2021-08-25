Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD38D3F78E8
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbhHYPfl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:35:41 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:50191 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241906AbhHYPfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:35:37 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 5BC8EC6994;
        Wed, 25 Aug 2021 15:26:42 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E8FC9C0018;
        Wed, 25 Aug 2021 15:26:15 +0000 (UTC)
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
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 27/40] mfd: ti_am335x_tscadc: Move control register configuration
Date:   Wed, 25 Aug 2021 17:25:05 +0200
Message-Id: <20210825152518.379386-28-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The datasheet states that most of the configuration should be set in the
control register in the first place, before actually enabling the
hardware. So far only half of the configuration was made in the first
step, which does not make really sense and would complicating the code
when introducing support for the am437x hardware.

Let's move that register write a bit below to enclose more configuration.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index a40091830cea..1a30610dc65f 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -224,7 +224,6 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	tscadc->ctrl = CNTRLREG_STEPID;
 	if (tscadc->data->has_tsc) {
 		tscadc->ctrl |= CNTRLREG_TSC_STEPCONFIGWRT;
-		regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
 		if (use_tsc) {
 			tscadc->ctrl |= CNTRLREG_TSC_ENB;
 			if (tscmag_wires == 5)
@@ -235,6 +234,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	}
 
+	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
+
 	tscadc_idle_config(tscadc);
 
 	/* Enable the TSC module enable bit */
-- 
2.27.0

