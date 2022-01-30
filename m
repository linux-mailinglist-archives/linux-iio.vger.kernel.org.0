Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659014A397B
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347649AbiA3Uu6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243587AbiA3Uu5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:50:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76468C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 12:50:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47ED1B829BD
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECD4C340E4;
        Sun, 30 Jan 2022 20:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575855;
        bh=rszeuAW3ozM4s++o4Ue7PkoSMNl9ILPHcanV4MWugm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEOD9m1XG9uKdSZRQCacZOLcBwQhuJKjsEENtaeKfJ8l6CM35SMYZBfC4JTGel3Sc
         SWIYRZedEaHKHcxIMquIvttfcPNl82lJayYfE/D4iK8R54FvZGlyWgXzsP7ww1Qjf3
         k4D2SJGGGPnEBLzszYmQkp6gLdpZvDXp2MLdQ8J2r3a57k96TdltLoeswvhAwcNIhi
         +o16NCx4CfAH6JrGYUheOPzp5Z0D4tyzM9A6iaEHeEy+h/Z+Sf00zJk+mRSe8GsPxG
         zxEUgvgWDXMrZafD8L/g4VvkePEUcMnhXB3aH7EzA1Ic2Al3H5Yy7/tGOeHorPM6L9
         XGEHnyxT8BgIw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 02/16] iio:adc:ad7091r: Move exports into IIO_AD7091R namespace.
Date:   Sun, 30 Jan 2022 20:56:47 +0000
Message-Id: <20220130205701.334592-3-jic23@kernel.org>
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
move the core/library functions into a specific namespace and import
that into the various specific device drivers that use them.

For more information see https://lwn.net/Articles/760045/

An alternative here would be to conclude that we are unlikely to see
support for the other ad7091r parts in the near future and just merge
the two modules into one supporting just the i2c -5 variant.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/adc/ad7091r-base.c | 4 ++--
 drivers/iio/adc/ad7091r5.c     | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 63b4d6ea4566..8e252cde735b 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -260,7 +260,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 
 	return devm_iio_device_register(dev, iio_dev);
 }
-EXPORT_SYMBOL_GPL(ad7091r_probe);
+EXPORT_SYMBOL_NS_GPL(ad7091r_probe, IIO_AD7091R);
 
 static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 {
@@ -290,7 +290,7 @@ const struct regmap_config ad7091r_regmap_config = {
 	.writeable_reg = ad7091r_writeable_reg,
 	.volatile_reg = ad7091r_volatile_reg,
 };
-EXPORT_SYMBOL_GPL(ad7091r_regmap_config);
+EXPORT_SYMBOL_NS_GPL(ad7091r_regmap_config, IIO_AD7091R);
 
 MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7091Rx multi-channel converters");
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 9665679c3ea6..47f5763023a4 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -111,3 +111,4 @@ module_i2c_driver(ad7091r5_driver);
 MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7091R5 multi-channel ADC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD7091R);
-- 
2.35.1

