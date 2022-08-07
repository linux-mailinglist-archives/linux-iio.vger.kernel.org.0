Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA8058BC8A
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiHGSqN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbiHGSqM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:46:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4373D9591
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA0F1B80DD0
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148B2C433C1;
        Sun,  7 Aug 2022 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897968;
        bh=+ryTB9MQAplWrOUsr/aqEnqdFOa9zCg5+5NEfsjqxbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/+UAVAxyQh91eojsbKJuUzAfZGJpfjjrTyinU6vehP5rdpKKnAvhXjX++uBEOznl
         rf61WNNtRiJZ/N/8KYH38fHvm09VR8uLkHeGr98ML5l4fuNkD4pBkGhWdgvZtfl+mM
         DMnqFM2pTfoiFy1aOm+3HKz+5gR57cjmcjSLJk0980evFtxEaXtes/nqPBpsFoaTvy
         H3l40dUrdBE3/4s88x7t6uWgSNmKTRbDh/rnnQsZ/gK9O/3HKFaSiBK6KG2GZItiQ0
         QVnREwMz5nwoYKajUqw1b2f3QkEregFK2wOhFyR/KWWCBCa47A1zbjZmznzKqqxl/i
         12nYIY2tZXcvg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/6] iio: proximity: sx9324: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Sun,  7 Aug 2022 19:56:14 +0100
Message-Id: <20220807185618.1038812-3-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807185618.1038812-1-jic23@kernel.org>
References: <20220807185618.1038812-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new macros avoid the need for marking the callbacks __maybe_unused
whilst ensuring both callbacks and structure may be dropped by the compiler
if CONFIG_PM_SLEEP is not enabled.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/sx9324.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index edb5a2ce4e27..977cf17cec52 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -1073,7 +1073,7 @@ static int sx9324_probe(struct i2c_client *client)
 	return sx_common_probe(client, &sx9324_chip_info, &sx9324_regmap_config);
 }
 
-static int __maybe_unused sx9324_suspend(struct device *dev)
+static int sx9324_suspend(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	unsigned int regval;
@@ -1098,7 +1098,7 @@ static int __maybe_unused sx9324_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused sx9324_resume(struct device *dev)
+static int sx9324_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	int ret;
@@ -1114,7 +1114,7 @@ static int __maybe_unused sx9324_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(sx9324_pm_ops, sx9324_suspend, sx9324_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sx9324_pm_ops, sx9324_suspend, sx9324_resume);
 
 static const struct acpi_device_id sx9324_acpi_match[] = {
 	{ "STH9324", SX9324_WHOAMI_VALUE },
@@ -1139,7 +1139,7 @@ static struct i2c_driver sx9324_driver = {
 		.name	= "sx9324",
 		.acpi_match_table = sx9324_acpi_match,
 		.of_match_table = sx9324_of_match,
-		.pm = &sx9324_pm_ops,
+		.pm = pm_sleep_ptr(&sx9324_pm_ops),
 
 		/*
 		 * Lots of i2c transfers in probe + over 200 ms waiting in
-- 
2.37.1

