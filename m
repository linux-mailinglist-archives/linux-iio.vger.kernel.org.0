Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A167FFEC
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 16:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjA2PmP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 10:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2PmP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 10:42:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B14912870;
        Sun, 29 Jan 2023 07:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 065F960DC6;
        Sun, 29 Jan 2023 15:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0564FC4339E;
        Sun, 29 Jan 2023 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675006933;
        bh=48D1qji7MQQv0UQXB018g3Ske4Yx09paEJnj8pvmczs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVgDkjhesNxbHi12GifWQHb4tmwn6nUWdTWbf52pYERdb97L9+MBEyK1034M3+PYt
         KWVbEJi4epblX88RRa9FekW49eyiEXhrKU4AhatuaOcOq9owrcbAfYcYeLZ17jkXKu
         p77RESpPTIogbnyGLHgcSU/GuHdYavYVTXG/YMVgaXtElgjEvlR8nU0lsJ7O8aDfqa
         xHrGQSerYbzu8jVBoj3GwHol1wxdL9krVcUpbv85uWJD9oqdKy+P4MvKc7LWR/hwcT
         YgNIqbmHlkPhZ+jZ+OaZQG6AGXK2F2tG7uZJKGuFuhyJ5slhavZy6HANjPt5RDpqr1
         Anxt642Mw57Rg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 01/12] staging: iio: accel: adis16203: More conventional header ordering
Date:   Sun, 29 Jan 2023 15:55:51 +0000
Message-Id: <20230129155602.740743-2-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129155602.740743-1-jic23@kernel.org>
References: <20230129155602.740743-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A common practice in IIO drivers it to have the headers in
alphabetical order with the exception of the more specific IIO
headers which come in their own block at the end.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16203.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index c0e4c9266b5f..dd02ceb00d40 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -6,14 +6,13 @@
  */
 
 #include <linux/device.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/imu/adis.h>
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 
+#include <linux/iio/iio.h>
+#include <linux/iio/imu/adis.h>
+
 #define ADIS16203_STARTUP_DELAY 220 /* ms */
 
 /* Flash memory write count */
-- 
2.39.1

