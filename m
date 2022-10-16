Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B2960020E
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJPRKP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiJPRKD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 13:10:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54A127DDA
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 10:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 763B4B80D42
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 17:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F00C433C1;
        Sun, 16 Oct 2022 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665940174;
        bh=W0xdDPHm3+2JR9MhpcF3bBGNh6Sc94k3A142m5RGwy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lW4gc+U/seHLhIG9e5goNwWU2Ke1PKZNRAYNmYFeWploFJywenAee+g2l79ej3Fdx
         IdzXuE6cvzA+gPx2QrzRQDzSlkD6frJQAiMzIKBLbGo3B/wkmHXwGmodv/3MknWfue
         HK+E+2L9Chq2MKfN4PGpDR1tevoEf9f9g//t+r3VGgcvw140T5z/ltXrbdODK9zebe
         Eb5uuBEQVQ3SLsiE3hfo9IxJ5HhYJ/10CdR4gCCvJCGVSAvONclzJSlPfKvRq9EjHo
         XGDJ//9JK/wexvCyLD5HmwAsIzsgXqw91zseIN4ZGDo/5lDOtKo1arU1oB1Xenq6Kj
         /W2mbqhMV6UQQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/5] iio: adc: cc10001: Use devm_ to call device power down.
Date:   Sun, 16 Oct 2022 18:09:49 +0100
Message-Id: <20221016170950.387751-5-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221016170950.387751-1-jic23@kernel.org>
References: <20221016170950.387751-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

It is presumably safe to call the powerdown whether or not we are
in the commented shared state (the driver always did this).

The power down was previously out of order wrt to the probe() function
so move using devm_ will ensure it occurs after the userspace interfaces
are removed.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/cc10001_adc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index 332f0e06369f..b0daaec7ff16 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -310,6 +310,11 @@ static void cc10001_reg_disable(void *priv)
 	regulator_disable(priv);
 }
 
+static void cc10001_pd_cb(void *priv)
+{
+	cc10001_adc_power_down(priv);
+}
+
 static int cc10001_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -375,6 +380,9 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 	if (adc_dev->shared)
 		cc10001_adc_power_up(adc_dev);
 
+	ret = devm_add_action_or_reset(dev, cc10001_pd_cb, adc_dev);
+	if (ret)
+		return ret;
 	/* Setup the ADC channels available on the device */
 	ret = cc10001_adc_channel_init(indio_dev, channel_map);
 	if (ret < 0)
@@ -405,7 +413,6 @@ static int cc10001_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct cc10001_adc_device *adc_dev = iio_priv(indio_dev);
 
-	cc10001_adc_power_down(adc_dev);
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 
-- 
2.37.2

