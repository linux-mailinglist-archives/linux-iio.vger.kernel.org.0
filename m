Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B977D42EBA6
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbhJOISv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:18:51 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50799 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbhJOISE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:18:04 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 1CF2920022;
        Fri, 15 Oct 2021 08:15:56 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 37/48] mfd: ti_am335x_tscadc: Support the correctly spelled DT property
Date:   Fri, 15 Oct 2021 10:14:55 +0200
Message-Id: <20211015081506.933180-38-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 7b6d18144e27..07825cfd8aa8 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -144,8 +144,14 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (ti_adc_with_touchscreen(tscadc)) {
 		node = of_get_child_by_name(pdev->dev.of_node, "tsc");
 		of_property_read_u32(node, "ti,wires", &tscmag_wires);
-		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
+		err = of_property_read_u32(node, "ti,coordinate-readouts",
+					   &readouts);
+		if (err < 0)
+			of_property_read_u32(node, "ti,coordiante-readouts",
+					     &readouts);
+
 		of_node_put(node);
+
 		if (tscmag_wires)
 			use_tsc = true;
 	} else {
-- 
2.27.0

