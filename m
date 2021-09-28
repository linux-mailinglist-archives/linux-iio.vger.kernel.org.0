Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D954F41B0CA
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbhI1Nfl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:35:41 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43717 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241424AbhI1NfI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:35:08 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8022860010;
        Tue, 28 Sep 2021 13:33:25 +0000 (UTC)
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
Subject: [PATCH v4 41/48] iio: adc: ti_am335x_adc: Get rid of useless gotos
Date:   Tue, 28 Sep 2021 15:31:36 +0200
Message-Id: <20210928133143.157329-42-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Gotos jumping to a return statement are not really useful, drop them.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 496603ab7841..aa151d702a14 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -636,11 +636,11 @@ static int tiadc_probe(struct platform_device *pdev)
 						IRQF_SHARED,
 						&tiadc_buffer_setup_ops);
 	if (err)
-		goto err_free_channels;
+		return err;
 
 	err = iio_device_register(indio_dev);
 	if (err)
-		goto err_buffer_unregister;
+		return err;
 
 	platform_set_drvdata(pdev, indio_dev);
 
@@ -652,8 +652,7 @@ static int tiadc_probe(struct platform_device *pdev)
 
 err_dma:
 	iio_device_unregister(indio_dev);
-err_buffer_unregister:
-err_free_channels:
+
 	return err;
 }
 
-- 
2.27.0

