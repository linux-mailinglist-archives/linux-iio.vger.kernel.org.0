Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177E742EB72
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbhJOIRy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:17:54 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:32959 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbhJOIRh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:17:37 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AFFCC2000B;
        Fri, 15 Oct 2021 08:15:28 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 16/48] mfd: ti_am335x_tscadc: Move the driver structure allocation earlier
Date:   Fri, 15 Oct 2021 10:14:34 +0200
Message-Id: <20211015081506.933180-17-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allocating the driver structure should be done earlier in the probe so
that we can used its members from the beginning.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 53749a0a5722..2976028d2615 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -125,6 +125,13 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	int tsc_wires = 0, adc_channels = 0, total_channels;
 	int readouts = 0;
 
+	/* Allocate memory for device */
+	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
+	if (!tscadc)
+		return -ENOMEM;
+
+	tscadc->dev = &pdev->dev;
+
 	if (!pdev->dev.of_node) {
 		dev_err(&pdev->dev, "Could not find valid DT data.\n");
 		return -EINVAL;
@@ -164,13 +171,6 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Allocate memory for device */
-	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
-	if (!tscadc)
-		return -ENOMEM;
-
-	tscadc->dev = &pdev->dev;
-
 	err = platform_get_irq(pdev, 0);
 	if (err < 0)
 		return err;
-- 
2.27.0

