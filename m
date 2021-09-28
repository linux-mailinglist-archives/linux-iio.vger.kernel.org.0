Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABE441B03F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbhI1Ndz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:33:55 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40171 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241105AbhI1Ndu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:33:50 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 48EBD60011;
        Tue, 28 Sep 2021 13:32:08 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 08/48] mfd: ti_am335x_tscadc: Ensure a balanced number of node get/put
Date:   Tue, 28 Sep 2021 15:31:03 +0200
Message-Id: <20210928133143.157329-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

of_node_put() should be called after a successful of_get_child_by_name().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 55adc379f94b..eb5c23e3eacd 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -142,6 +142,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
 	of_property_read_u32(node, "ti,wires", &tsc_wires);
 	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
+	of_node_put(node);
 
 	node = of_get_child_by_name(pdev->dev.of_node, "adc");
 	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
@@ -149,9 +150,13 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		if (val > 7) {
 			dev_err(&pdev->dev, " PIN numbers are 0..7 (not %d)\n",
 					val);
+			of_node_put(node);
 			return -EINVAL;
 		}
 	}
+
+	of_node_put(node);
+
 	total_channels = tsc_wires + adc_channels;
 	if (total_channels > 8) {
 		dev_err(&pdev->dev, "Number of i/p channels more than 8\n");
-- 
2.27.0

