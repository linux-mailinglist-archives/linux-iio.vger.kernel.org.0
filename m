Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36F4BD04B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 18:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbiBTRas (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 12:30:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbiBTRas (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 12:30:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639162409F
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 09:30:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01D7B60DBC
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 17:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ECBC340EB;
        Sun, 20 Feb 2022 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645378226;
        bh=fQQVpnTT5B9kEJUFjZB2e4agCOZY951GDbWbqfqpoG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVrWLtI2U1TTDfIF8qzlpqufK86vmPrBz7+mYFmTQ/w5FTbZWaq6Kj/DWUQQU2HEx
         0X0cWfhWliGifBbTzoywXJEF7i4Xq9cJLnRJtIhS3KL4tBf+cb+uGdTkE9l5+02ADx
         6redufgsXlRrK/vOjtBEzrWrdrOqxzbnuMpV/Z62jF2PyaJVs6Y8EvR0hia1/ZDW1X
         n/iQEwRShEa7sH05KH/JKYVM9iKvI5twjJxApYdELvUssM/0XehL1QoY2to8cr8061
         4uH9c9VagfJg8TgfYIbUmgLwAw6+IV0cLEKCfc9c3AgUQ4SpYvTIXEa8F0bZVZ0B5l
         qKT0A6+hCfuiA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 3/5] iio: chemical: sps30: Move symbol exports into IIO_SPS30 namespace
Date:   Sun, 20 Feb 2022 17:36:59 +0000
Message-Id: <20220220173701.502331-4-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220173701.502331-1-jic23@kernel.org>
References: <20220220173701.502331-1-jic23@kernel.org>
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
 drivers/iio/chemical/sps30.c        | 2 +-
 drivers/iio/chemical/sps30_i2c.c    | 1 +
 drivers/iio/chemical/sps30_serial.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index abd67559e451..814ce0aad1cc 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -372,7 +372,7 @@ int sps30_probe(struct device *dev, const char *name, void *priv, const struct s
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(sps30_probe);
+EXPORT_SYMBOL_NS_GPL(sps30_probe, IIO_SPS30);
 
 MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor driver");
diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30_i2c.c
index d33560ed7184..2aed483a2fde 100644
--- a/drivers/iio/chemical/sps30_i2c.c
+++ b/drivers/iio/chemical/sps30_i2c.c
@@ -256,3 +256,4 @@ module_i2c_driver(sps30_i2c_driver);
 MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
 MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_SPS30);
diff --git a/drivers/iio/chemical/sps30_serial.c b/drivers/iio/chemical/sps30_serial.c
index 3f311d50087c..164f4b3e025c 100644
--- a/drivers/iio/chemical/sps30_serial.c
+++ b/drivers/iio/chemical/sps30_serial.c
@@ -429,3 +429,4 @@ module_serdev_device_driver(sps30_serial_driver);
 MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
 MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor serial driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_SPS30);
-- 
2.35.1

