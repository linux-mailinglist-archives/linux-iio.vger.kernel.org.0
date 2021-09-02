Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BD73FF668
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347827AbhIBVxz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:53:55 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:44843 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347798AbhIBVxs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:53:48 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id AA5BD240004;
        Thu,  2 Sep 2021 21:52:46 +0000 (UTC)
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
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 31/46] mfd: ti_am335x_tscadc: Add a boolean to clarify the presence of a touchscreen
Date:   Thu,  2 Sep 2021 23:51:29 +0200
Message-Id: <20210902215144.507243-32-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Just checking the number of wires will soon not be enough, add a boolean
to indicated the actual use or not of the touchscreen.

Certain checks only make sense when there is a touchscreen wired. Make
this checks explicitly depend on the presence of the touchscreen.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index f30bcdf600fb..cfdef833dffb 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -120,6 +120,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	struct mfd_cell *cell;
 	struct property *prop;
 	const __be32 *cur;
+	bool use_tsc = false;
 	u32 val;
 	int err;
 	int tscmag_wires = 0, adc_channels = 0, cell_idx = 0, total_channels;
@@ -143,6 +144,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	of_property_read_u32(node, "ti,wires", &tscmag_wires);
 	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
 	of_node_put(node);
+	if (tscmag_wires)
+		use_tsc = true;
 
 	node = of_get_child_by_name(pdev->dev.of_node, "adc");
 	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
@@ -168,7 +171,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (readouts * 2 + 2 + adc_channels > 16) {
+	if (use_tsc && (readouts * 2 + 2 + adc_channels > 16)) {
 		dev_err(&pdev->dev, "Too many step configurations requested\n");
 		return -EINVAL;
 	}
@@ -221,7 +224,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	/* Set the control register bits */
 	tscadc->ctrl = CNTRLREG_TSC_STEPCONFIGWRT | CNTRLREG_STEPID;
-	if (tscmag_wires > 0) {
+	if (use_tsc) {
 		tscadc->ctrl |= CNTRLREG_TSC_ENB;
 		if (tscmag_wires == 5)
 			tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
-- 
2.27.0

