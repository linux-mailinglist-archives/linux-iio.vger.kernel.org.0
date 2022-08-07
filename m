Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1899558BC89
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiHGSqL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbiHGSqJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:46:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294F57671
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBE5FB80DCF
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD9DC433D7;
        Sun,  7 Aug 2022 18:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897965;
        bh=FyaYCXTTx6pNWOhuBnlVDQC2D+JDuYQRCigKmAA/ACM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otYoqcDfQ2LHrTPkNg+2Yc7Zhwcilb0AxTtgfQLadACpv8QcoIP1PqdhFgBr05wnc
         RA0j/+kyGw0twtKr2Gc0zumdNI+iL7DNDoJxS6FLKqytgBazEFSDOj1o5AtRv6ZJcp
         I16SpGfWpwnLxb2EhcNH4JtSZnzTa42Fk45XiCbH2zqa7mvJlGwQ8mIbLphIdOgq55
         ErE9bTQr7J1Yvi4g6rbdt2b5lG7jQoqpfcchp9KiO71zu/qo/l+41uqOL6IRN1ZdDo
         mbxXnRrvGzikX4FHWi7HLieTiOqt+L53/QrU34O4RZO2Qy6Pe758dyP58Ee33cntUR
         nhI777uIcfMqQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/6] iio: proximity: sx9310: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Sun,  7 Aug 2022 19:56:13 +0100
Message-Id: <20220807185618.1038812-2-jic23@kernel.org>
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
 drivers/iio/proximity/sx9310.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index ea7318b508ea..0e4747ccd3cf 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -965,7 +965,7 @@ static int sx9310_probe(struct i2c_client *client)
 	return sx_common_probe(client, &sx9310_chip_info, &sx9310_regmap_config);
 }
 
-static int __maybe_unused sx9310_suspend(struct device *dev)
+static int sx9310_suspend(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	u8 ctrl0;
@@ -991,7 +991,7 @@ static int __maybe_unused sx9310_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused sx9310_resume(struct device *dev)
+static int sx9310_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	int ret;
@@ -1013,7 +1013,7 @@ static int __maybe_unused sx9310_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
 
 static const struct acpi_device_id sx9310_acpi_match[] = {
 	{ "STH9310", SX9310_WHOAMI_VALUE },
@@ -1041,7 +1041,7 @@ static struct i2c_driver sx9310_driver = {
 		.name	= "sx9310",
 		.acpi_match_table = sx9310_acpi_match,
 		.of_match_table = sx9310_of_match,
-		.pm = &sx9310_pm_ops,
+		.pm = pm_sleep_ptr(&sx9310_pm_ops),
 
 		/*
 		 * Lots of i2c transfers in probe + over 200 ms waiting in
-- 
2.37.1

