Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0694BD08A
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiBTSJR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 13:09:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244482AbiBTSJR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 13:09:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9547527E3
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 10:08:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FD05B801BC
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 18:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698D0C340F4;
        Sun, 20 Feb 2022 18:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645380533;
        bh=sgiBlcb8DRSoGepw38+5vb+HoqjBBxFIQNn38CWPE8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pu8fCHbZqkcfU3/mnsyCx/9JSZA5UT2PcnIKdadCzzwTxSMg/dLT4dJTzXf13S9uJ
         clDhEhLhhxOyHhA6FKnTejb/VVPXvfcXLgXuKwGwJmLaCcGeZeBwGQZMvycNoP390n
         u05AQMh1s6MEpcK7+b9nUZQAmihkEVfnOu/Ouwa46jdYEU9HQj6L2ZgAku+CnV5NfB
         c1/MyUqW1haz29ZLmE0PX04qPSeE5oRGV1OP+SEWgOI6cV2Rko7rVS6gKuHi87gjpD
         Gh0APR4suTBD+aIEb3lupWwxEOISYmUGorJuS5u4MTqdfZPD3DvvIMZ+lpX64aBZpj
         JtHZesbgya0rQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/8] iio: chemical: scd30: Move symbol exports into IIO_SCD30 namespace
Date:   Sun, 20 Feb 2022 18:15:17 +0000
Message-Id: <20220220181522.541718-4-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220181522.541718-1-jic23@kernel.org>
References: <20220220181522.541718-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoid unnecessary pollution of the global symbol namespace by
moving library functions in to a specific namespace and import
that into the drivers that make use of the functions.

For more info: https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 drivers/iio/chemical/scd30_core.c   | 4 ++--
 drivers/iio/chemical/scd30_i2c.c    | 1 +
 drivers/iio/chemical/scd30_serial.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 6c6c11c2772a..682fca39d14d 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -543,7 +543,7 @@ static int scd30_resume(struct device *dev)
 	return scd30_command_write(state, CMD_START_MEAS, state->pressure_comp);
 }
 
-EXPORT_SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume);
+EXPORT_NS_SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume, IIO_SCD30);
 
 static void scd30_stop_meas(void *data)
 {
@@ -759,7 +759,7 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL(scd30_probe);
+EXPORT_SYMBOL_NS(scd30_probe, IIO_SCD30);
 
 MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
 MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor core driver");
diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
index 7c332e4e8e46..bae479a4721f 100644
--- a/drivers/iio/chemical/scd30_i2c.c
+++ b/drivers/iio/chemical/scd30_i2c.c
@@ -137,3 +137,4 @@ module_i2c_driver(scd30_i2c_driver);
 MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
 MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_SCD30);
diff --git a/drivers/iio/chemical/scd30_serial.c b/drivers/iio/chemical/scd30_serial.c
index 8664f3ce6b33..3c519103d30b 100644
--- a/drivers/iio/chemical/scd30_serial.c
+++ b/drivers/iio/chemical/scd30_serial.c
@@ -261,3 +261,4 @@ module_serdev_device_driver(scd30_serdev_driver);
 MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
 MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor serial driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_SCD30);
-- 
2.35.1

