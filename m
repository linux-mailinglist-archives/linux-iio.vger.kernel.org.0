Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699E967FFF7
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 16:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjA2PmX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 10:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjA2PmW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 10:42:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D981A485;
        Sun, 29 Jan 2023 07:42:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C32860C6D;
        Sun, 29 Jan 2023 15:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43120C433EF;
        Sun, 29 Jan 2023 15:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675006940;
        bh=O29dY269yId+Tk5piMwcX/yhYJ65tW/QMiVRDIvTutI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvWcR22Ge8GZ06zQzW1562KQzzZJkOtiXjwj5ETmNKrrbVih8axwobKo444JjEZC5
         6Bsk3OTqGAlezrqqDSrtqDbbMJJ8AjfkV2cFD5jYEGB+TGxpz8k8o68ZBChDqFHoBT
         z2fsqVQv3wLug388qU9hj9i6u42dJJAXvVBA3ZcTnCCdkH0Kjl6fINuHxu64AppO6Z
         Ex9VOODE3wHdxHkpoB+t3gGv97XZE5zz7g/AkCN05t2h7OBpewx/+8QN/lnQk3sJS/
         AdRu4DHhW9eDp85K4s8advd2kjuBpGA8heHyOD6OgFHAs5Tg/1vHp5Y2Nv7LSEGTdC
         O1VTK2sMUrkhQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 05/12] staging: iio: accel: adis16203: Simplify handling of calibbias
Date:   Sun, 29 Jan 2023 15:55:55 +0000
Message-Id: <20230129155602.740743-6-jic23@kernel.org>
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

Dropping the indirection on address lookup as there was only one
address enables several other minor cleanups.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16203.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index b59a003f3e26..67c0340d7097 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -5,6 +5,7 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -57,6 +58,8 @@
 
 #define ADIS16203_ERROR_ACTIVE          BIT(14)
 
+#define ADIS16203_INCLI_NULL_MSK     GENMASK(13, 0)
+
 enum adis16203_scan {
 	 ADIS16203_SCAN_INCLI_X,
 	 ADIS16203_SCAN_SUPPLY,
@@ -66,10 +69,6 @@ enum adis16203_scan {
 
 #define DRIVER_NAME		"adis16203"
 
-static const u8 adis16203_addresses[] = {
-	[ADIS16203_SCAN_INCLI_X] = ADIS16203_INCL_NULL,
-};
-
 static int adis16203_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int val,
@@ -77,10 +76,12 @@ static int adis16203_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct adis *st = iio_priv(indio_dev);
-	/* currently only one writable parameter which keeps this simple */
-	u8 addr = adis16203_addresses[chan->scan_index];
 
-	return adis_write_reg_16(st, addr, val & 0x3FFF);
+	if (mask != IIO_CHAN_INFO_CALIBBIAS)
+		return -EINVAL;
+
+	return adis_write_reg_16(st, ADIS16203_INCL_NULL,
+				 FIELD_PREP(ADIS16203_INCLI_NULL_MSK, val));
 }
 
 static int adis16203_read_raw(struct iio_dev *indio_dev,
@@ -90,7 +91,7 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 {
 	struct adis *st = iio_priv(indio_dev);
 	int ret;
-	u8 addr;
+
 	s16 val16;
 
 	switch (mask) {
@@ -123,8 +124,7 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		addr = adis16203_addresses[chan->scan_index];
-		ret = adis_read_reg_16(st, addr, &val16);
+		ret = adis_read_reg_16(st, ADIS16203_INCL_NULL, &val16);
 		if (ret)
 			return ret;
 		*val = sign_extend32(val16, 13);
-- 
2.39.1

