Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BC24A3981
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356306AbiA3UvG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356315AbiA3UvF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:51:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE26C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 12:51:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77652B829C0
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AFFC340F1;
        Sun, 30 Jan 2022 20:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575863;
        bh=NxbRf/ZHpWd1fpXAuztRqvDTjlS9xl2mIAC+MRfiGJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EjGPJpvXgKKM1LoHwpUhHEEjWwzLvMRaXPGGe2HpcekSfzx7hsXb5z+263tBFPyR7
         ke6d23MoB1E1yTB797oWa+WlL2LCwQFHnNJzaKBOa67xz3XywjZpBOgroh2I53Hqa7
         JC6+4pPXnOkI0nWiPFKn+e1FhselFEwn5UGpLUlq69ClUribpqSEKhR1X4ZJFispkm
         aHAuQW0mNcTYE/iNcBPLK4Jq+vy5V4c47W9Q5F11uQrjuCZxEni9Qal3a49jegF3As
         4EEDocY+uHmQTXH0ksvpzZJjBjtBp4YxjbN7ZTtFLsRk/9yoHUNTr0QlVWMDskHAXv
         6vk9xg9sYuRkA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 06/16] iio:dac:ad5592r: Move exports into IIO_AD5592R namespace
Date:   Sun, 30 Jan 2022 20:56:51 +0000
Message-Id: <20220130205701.334592-7-jic23@kernel.org>
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
that into the various specific device drivers that use them.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/dac/ad5592r-base.c | 4 ++--
 drivers/iio/dac/ad5592r.c      | 1 +
 drivers/iio/dac/ad5593r.c      | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 2fcc59728fd6..ec2937b8d768 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -661,7 +661,7 @@ int ad5592r_probe(struct device *dev, const char *name,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ad5592r_probe);
+EXPORT_SYMBOL_NS_GPL(ad5592r_probe, IIO_AD5592R);
 
 void ad5592r_remove(struct device *dev)
 {
@@ -675,7 +675,7 @@ void ad5592r_remove(struct device *dev)
 	if (st->reg)
 		regulator_disable(st->reg);
 }
-EXPORT_SYMBOL_GPL(ad5592r_remove);
+EXPORT_SYMBOL_NS_GPL(ad5592r_remove, IIO_AD5592R);
 
 MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5592R multi-channel converters");
diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
index 6bfd7951e18c..1572279b04bb 100644
--- a/drivers/iio/dac/ad5592r.c
+++ b/drivers/iio/dac/ad5592r.c
@@ -170,3 +170,4 @@ module_spi_driver(ad5592r_spi_driver);
 MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5592R multi-channel converters");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD5592R);
diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
index 64dd7a0bddf7..34e1319a9712 100644
--- a/drivers/iio/dac/ad5593r.c
+++ b/drivers/iio/dac/ad5593r.c
@@ -137,3 +137,4 @@ module_i2c_driver(ad5593r_driver);
 MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5593R multi-channel converters");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD5592R);
-- 
2.35.1

