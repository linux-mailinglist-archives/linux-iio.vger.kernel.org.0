Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A475C3F78E2
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241965AbhHYPfl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:35:41 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:55019 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241911AbhHYPfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:35:37 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 4D66DCB3A3;
        Wed, 25 Aug 2021 15:26:44 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id EC168C0016;
        Wed, 25 Aug 2021 15:26:19 +0000 (UTC)
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
Subject: [PATCH 29/40] mfd: ti_am335x_tscadc: Support the correctly spelled DT property
Date:   Wed, 25 Aug 2021 17:25:07 +0200
Message-Id: <20210825152518.379386-30-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There was in the past a typo in the coordinate readouts property. The
bindings have been updated, the touchscreen driver as well and now
supports both. However, the MFD driver that is in charge of verifying
the validity of the property only checks the bogus one. Add support for
the correctly spelled DT property.

Fixes: c9aeb249bf72 ("Input: ti_am335x_tsc - fix spelling mistake in TSC/ADC DT binding")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index f4f6b9db4d2a..0bd260edc9ad 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -143,7 +143,13 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (tscadc->data->has_tsc) {
 		node = of_get_child_by_name(pdev->dev.of_node, "tsc");
 		of_property_read_u32(node, "ti,wires", &tscmag_wires);
-		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
+		err = of_property_read_u32(node, "ti,coordinate-readouts",
+					   &readouts);
+		if (err < 0) {
+			err = of_property_read_u32(node, "ti,coordiante-readouts",
+						   &readouts);
+		}
+
 		if (tscmag_wires)
 			use_tsc = true;
 	} else {
-- 
2.27.0

