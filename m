Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6DE5F23A7
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 16:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJBOlV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Oct 2022 10:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJBOlT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 10:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57601F2FC
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 07:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A88060EDD
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 14:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FA3C433C1;
        Sun,  2 Oct 2022 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664721677;
        bh=VoAu1yaU5MTwqcswtL+dasf6xRokS8CDb3bSG/LrKlk=;
        h=From:To:Cc:Subject:Date:From;
        b=d8NBt1YEiIjpnYSaVgBiyJ0+VZB/ZNuFc0498gPpdT8+A4VXAdl/lncKpQDepYL8P
         Aj9cewKAexlU7ht0qMT2mW3V+ZaNC7PEkxTWm+nmefASDTUn+SSPiCby38nLlPqnsf
         HFwDLPb+N/cY493Le+j6RQTfwdLLaCApLvcah8/lRMQJuO2LIPEbqUPuhzt7MMVJrk
         /KYD65KxYgNKJFKPkmGoqyVYsDo891dHvd2uLl3IeZXJDZLdpv/o7ZuZrp7uk5eLYt
         TP4Xd+6+m24ZPcOgBdrf4EcRie/zuCTPS5By2jgeVzZONFALl5c25NEoFZBVXlF1X1
         Wz4mD16Hs8/fA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Robertson <dan@dlrobertson.com>
Subject: [PATCH] iio: accel: bma400: Ensure VDDIO is enable defore reading the chip ID.
Date:   Sun,  2 Oct 2022 15:41:33 +0100
Message-Id: <20221002144133.3771029-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The regulator enables were after the check on the chip variant, which was
very unlikely to return a correct value when not powered.
Presumably all the device anyone is testing on have a regulator that
is already powered up when this code runs for reasons beyond the scope
of this driver. Move the read call down a few lines.

Fixes: 3cf7ded15e40 ("iio: accel: bma400: basic regulator support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Robertson <dan@dlrobertson.com>
---
 drivers/iio/accel/bma400_core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index e8de88e6cfb9..81bfec9e20cc 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -869,18 +869,6 @@ static int bma400_init(struct bma400_data *data)
 	unsigned int val;
 	int ret;
 
-	/* Try to read chip_id register. It must return 0x90. */
-	ret = regmap_read(data->regmap, BMA400_CHIP_ID_REG, &val);
-	if (ret) {
-		dev_err(data->dev, "Failed to read chip id register\n");
-		return ret;
-	}
-
-	if (val != BMA400_ID_REG_VAL) {
-		dev_err(data->dev, "Chip ID mismatch\n");
-		return -ENODEV;
-	}
-
 	data->regulators[BMA400_VDD_REGULATOR].supply = "vdd";
 	data->regulators[BMA400_VDDIO_REGULATOR].supply = "vddio";
 	ret = devm_regulator_bulk_get(data->dev,
@@ -902,6 +890,18 @@ static int bma400_init(struct bma400_data *data)
 	if (ret)
 		return ret;
 
+	/* Try to read chip_id register. It must return 0x90. */
+	ret = regmap_read(data->regmap, BMA400_CHIP_ID_REG, &val);
+	if (ret) {
+		dev_err(data->dev, "Failed to read chip id register\n");
+		return ret;
+	}
+
+	if (val != BMA400_ID_REG_VAL) {
+		dev_err(data->dev, "Chip ID mismatch\n");
+		return -ENODEV;
+	}
+
 	ret = bma400_get_power_mode(data);
 	if (ret) {
 		dev_err(data->dev, "Failed to get the initial power-mode\n");
-- 
2.37.2

