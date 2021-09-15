Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D740C97F
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbhIOQBj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 12:01:39 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:54157 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbhIOQBi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 12:01:38 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id DCAB21BF20D;
        Wed, 15 Sep 2021 16:00:16 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 33/47] mfd: ti_am335x_tscadc: Add a boolean to clarify the presence of a touchscreen
Date:   Wed, 15 Sep 2021 17:58:54 +0200
Message-Id: <20210915155908.476767-34-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Just checking the number of wires will soon not be enough, add a boolean
to indicated the actual use or not of the touchscreen.

Certain checks only make sense when there is a touchscreen wired. Make
these checks explicitly depend on the presence of the touchscreen.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index a181b5b07012..ab6c0e82d389 100644
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
@@ -223,7 +226,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	 * added manually when timely.
 	 */
 	tscadc->ctrl = CNTRLREG_TSC_STEPCONFIGWRT | CNTRLREG_STEPID;
-	if (tscmag_wires > 0) {
+	if (use_tsc) {
 		tscadc->ctrl |= CNTRLREG_TSC_ENB;
 		if (tscmag_wires == 5)
 			tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
-- 
2.27.0

