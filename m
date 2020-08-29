Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F065D256558
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 08:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgH2Gsp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 02:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgH2Gso (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 02:48:44 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC00321548;
        Sat, 29 Aug 2020 06:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598683724;
        bh=SNQEDWZSEyuEV44lUPa7TZAgyAUN1wW018JYD+wKFHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0flPPFNaEIomrsd1SRrqn4dBuFpTvrWIKJVqoyaufENRJH25akJyOI3O8AxE1eMG
         dPx37vRWagc1jIxtsAoiOHiwK2Mn9EFDLWkkmr8MGdaCIpSa2NJsQ8ElCTxyKZ0ye/
         WDVFpiTqyJ/11Y914cvy/Q78MEuHLKNQorJPCVPE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 12/18] iio: dac: dpot-dac: Simplify with dev_err_probe()
Date:   Sat, 29 Aug 2020 08:47:20 +0200
Message-Id: <20200829064726.26268-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829064726.26268-1-krzk@kernel.org>
References: <20200829064726.26268-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/dac/dpot-dac.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index be61c3b01e8b..2258535b8a42 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -183,18 +183,14 @@ static int dpot_dac_probe(struct platform_device *pdev)
 	indio_dev->num_channels = 1;
 
 	dac->vref = devm_regulator_get(dev, "vref");
-	if (IS_ERR(dac->vref)) {
-		if (PTR_ERR(dac->vref) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get vref regulator\n");
-		return PTR_ERR(dac->vref);
-	}
+	if (IS_ERR(dac->vref))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dac->vref),
+				     "failed to get vref regulator\n");
 
 	dac->dpot = devm_iio_channel_get(dev, "dpot");
-	if (IS_ERR(dac->dpot)) {
-		if (PTR_ERR(dac->dpot) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dpot input channel\n");
-		return PTR_ERR(dac->dpot);
-	}
+	if (IS_ERR(dac->dpot))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dac->dpot),
+				     "failed to get dpot input channel\n");
 
 	ret = iio_get_channel_type(dac->dpot, &type);
 	if (ret < 0)
-- 
2.17.1

