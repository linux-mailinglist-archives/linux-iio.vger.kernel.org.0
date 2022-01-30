Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88E54A3986
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347670AbiA3UvQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347676AbiA3UvQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:51:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A087CC061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 12:51:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DEF960DE6
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A62C340E4;
        Sun, 30 Jan 2022 20:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575874;
        bh=30XRaav1OGVyuCdjgwgjoALIzCnl5ekq42ogIdYkhww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQAera2j0D9KYJMTwBlOkvhPNNu+jUMUd76RQYK0sBWoC5jsuHJwOIIzHPRC9d5UO
         uGC4XH7bddxYkWER00H5p27jFrQ6EHsM2yrSJxtLudCJwHdW07yX1dMFqQU0PG05GO
         1AHmD4xt6Cl+QyMAFz4tjgqeIoWSvRt+SIj1tBDSivFJHIT8HwbDQ8zSi6phGzY22v
         e3M6QU0tRym90CUZu1Agcg4MxTI3yavl5jABdXtXrJfaXIMM9xNARJvRfohZ6YXMks
         ydYXBg9Q/RZ+TADN42nyt13RODlUAoGp6IGORsnwPEfj7Eah8uGhGUVsUDL+9ysL8s
         C2q4KUp1M6pVA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/16] iio:pressure:mpl115: Move exports into IIO_MPL115 namespace
Date:   Sun, 30 Jan 2022 20:56:56 +0000
Message-Id: <20220130205701.334592-12-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130205701.334592-1-jic23@kernel.org>
References: <20220130205701.334592-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In order to avoid unnecessary pollution of the global symbol namespace
move the common/library functions into a specific namespace and import
that into the bus specific device drivers that use them.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/mpl115.c     | 2 +-
 drivers/iio/pressure/mpl115_i2c.c | 1 +
 drivers/iio/pressure/mpl115_spi.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 81f288312a28..5bf5b9abe6f1 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -187,7 +187,7 @@ int mpl115_probe(struct device *dev, const char *name,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(mpl115_probe);
+EXPORT_SYMBOL_NS_GPL(mpl115_probe, IIO_MPL115);
 
 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
 MODULE_DESCRIPTION("Freescale MPL115 pressure/temperature driver");
diff --git a/drivers/iio/pressure/mpl115_i2c.c b/drivers/iio/pressure/mpl115_i2c.c
index ac1f12bcb65e..099ab1c6832c 100644
--- a/drivers/iio/pressure/mpl115_i2c.c
+++ b/drivers/iio/pressure/mpl115_i2c.c
@@ -62,3 +62,4 @@ module_i2c_driver(mpl115_i2c_driver);
 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
 MODULE_DESCRIPTION("Freescale MPL115A2 pressure/temperature driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_MPL115);
diff --git a/drivers/iio/pressure/mpl115_spi.c b/drivers/iio/pressure/mpl115_spi.c
index 4d064f98f56a..7feec87e2704 100644
--- a/drivers/iio/pressure/mpl115_spi.c
+++ b/drivers/iio/pressure/mpl115_spi.c
@@ -101,3 +101,4 @@ module_spi_driver(mpl115_spi_driver);
 MODULE_AUTHOR("Akinobu Mita <akinobu.mita@gmail.com>");
 MODULE_DESCRIPTION("Freescale MPL115A1 pressure/temperature driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_MPL115);
-- 
2.35.1

