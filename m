Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC8E4A3982
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356314AbiA3UvI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40650 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356317AbiA3UvH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:51:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67DC9B829C4
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6917C340EF;
        Sun, 30 Jan 2022 20:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575865;
        bh=2wnmXK78NFk2c+W1vLHfcnxyRIa+YivFAatAG5Z1Crs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFhbKFMuVfNx6z8mWvmV2Q2/uyBhu/AhLatNWaxeUgg/lpDTq0lZLgRo8nru/OgL/
         y2Frkw4yc0g2fYFONKAMv6xgUYIA+2k1Oww3wL4Mfb5mkF5H982ykyg0sMFbqxO8ka
         OUR1VrYcAv/N3/BalFDWklxYcNUN4jCg0c//y+Ag82Xx5bFJo/jf3n/EBftTfhbqV7
         P9T9bZ6bKvKIB3ZmAALdE363tuZyCawUgj6u+j6+Ff4NKn8tPQq7sY8ZDW6i+Pv4yJ
         S5WLJJXGMz5SH2qPNrDB/8BFxZTL9eg79+rDdRHk4nU53CrVPRD66hS4mloJQgJ2dv
         fDOwJV9kjxFkw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/16] iio:dac:ad5686: Move exports into IIO_AD5686 namespace
Date:   Sun, 30 Jan 2022 20:56:52 +0000
Message-Id: <20220130205701.334592-8-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130205701.334592-1-jic23@kernel.org>
References: <20220130205701.334592-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note these are used in the related ad5696-i2c drivers as well as the
more obviously connected ad5686-spi driver.

In order to avoid unnecessary pollution of the global symbol namespace
move the common/library functions into a specific namespace and import
that into the various specific device drivers that use them.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad5686-spi.c | 1 +
 drivers/iio/dac/ad5686.c     | 4 ++--
 drivers/iio/dac/ad5696-i2c.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 2628810fdbb1..75b54c5ba39f 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -137,3 +137,4 @@ module_spi_driver(ad5686_spi_driver);
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5686 and similar multi-channel DACs");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD5686);
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index e592a995f404..f78dd3f33199 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -536,7 +536,7 @@ int ad5686_probe(struct device *dev,
 		regulator_disable(st->reg);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ad5686_probe);
+EXPORT_SYMBOL_NS_GPL(ad5686_probe, IIO_AD5686);
 
 void ad5686_remove(struct device *dev)
 {
@@ -547,7 +547,7 @@ void ad5686_remove(struct device *dev)
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 }
-EXPORT_SYMBOL_GPL(ad5686_remove);
+EXPORT_SYMBOL_NS_GPL(ad5686_remove, IIO_AD5686);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5686/85/84 DAC");
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 93f0e0e66c22..762503c1901b 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -125,3 +125,4 @@ module_i2c_driver(ad5686_i2c_driver);
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5686 and similar multi-channel DACs");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD5686);
-- 
2.35.1

