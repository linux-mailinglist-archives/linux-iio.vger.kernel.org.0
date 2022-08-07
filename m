Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA958BC8B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiHGSqP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiHGSqP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:46:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C765F3
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA95EB80DD0
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D303C433B5;
        Sun,  7 Aug 2022 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897971;
        bh=VxC4Z2wVSbKteM6WBCSLw+7FQQcD4ALIS+uI0ALLZP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kb0wEwRnnS+auq8NG9rqoHOkT5jSqMNsCFWK1xGobNVpxBPGLWcoaKK5yEihm4gIm
         pL+YBiFUKONnU9OACugWUp6QqGfC6gsXEb3iH/r6UJ9HkWyM2mN6uUn1gavO7F8mmV
         XANX9Zl1L+125cdaapBpjkT6MTZRFFaZYacHpWDsW5RRhA8nQ/a97KFFFMcJOt7Rim
         wuluWr9F5+6V7twXFPyuOzP+TOw39rj1f0yLIxVfPWmdJmTEzq5Q6m7xkEkNx3X8gf
         f4bpSi+S367pd3lilaxP4gJQOhmm5UwwdgeXmlY7UGB1RwUsnFtwEqglgJC+opnvfU
         766Fnt2ggKexQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/6] iio: proximity: sx9360: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Sun,  7 Aug 2022 19:56:15 +0100
Message-Id: <20220807185618.1038812-4-jic23@kernel.org>
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
 drivers/iio/proximity/sx9360.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index d9a12e6be6ca..7fa2213d23ba 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -819,7 +819,7 @@ static int sx9360_probe(struct i2c_client *client)
 	return sx_common_probe(client, &sx9360_chip_info, &sx9360_regmap_config);
 }
 
-static int __maybe_unused sx9360_suspend(struct device *dev)
+static int sx9360_suspend(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	unsigned int regval;
@@ -844,7 +844,7 @@ static int __maybe_unused sx9360_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused sx9360_resume(struct device *dev)
+static int sx9360_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	int ret;
@@ -861,7 +861,7 @@ static int __maybe_unused sx9360_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);
 
 static const struct acpi_device_id sx9360_acpi_match[] = {
 	{ "STH9360", SX9360_WHOAMI_VALUE },
@@ -886,7 +886,7 @@ static struct i2c_driver sx9360_driver = {
 		.name	= "sx9360",
 		.acpi_match_table = sx9360_acpi_match,
 		.of_match_table = sx9360_of_match,
-		.pm = &sx9360_pm_ops,
+		.pm = pm_sleep_ptr(&sx9360_pm_ops),
 
 		/*
 		 * Lots of i2c transfers in probe + over 200 ms waiting in
-- 
2.37.1

