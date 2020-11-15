Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0EF2B3946
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 21:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgKOU5w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 15:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgKOU5w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2020 15:57:52 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64F8C0613CF
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2020 12:57:51 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id r9so22251915lfn.11
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2020 12:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AkV9z77tBV7FXEVNnX5OQoFm0Lfuvye+PLzLR2BAncQ=;
        b=FtVJkUqAwMhTkWja1OE1h1uQcUF0bbNSmr7uM3lQmvX96hnRgCVRMuBLnfYlfvk8Z1
         OLpAYzGgqLmzb0J2UbTGR8Bm6ejjcFLSdVNUNORMVtaYkqwsmBp+GpYUZTlzpBPGwmVO
         Ds9oHpcdkRKzvTaYJdZADhY7oY1T9yZ3h8qMrQGhnt2fvhnQzoCCjqvowbHgjPUmLmyQ
         a4i8NG6Wlp3fc6Af5QODZxEmlB+aRFUWtbFotts5MaLz9lnhfHjgQxJYvNCPwBMRJKQX
         6ECH93gQd1+PlNqzqvzRFCmLfGD3GQ1l/cY31w2pb2DCBIzDC10WRCioenzrSMk24v6g
         1fpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkV9z77tBV7FXEVNnX5OQoFm0Lfuvye+PLzLR2BAncQ=;
        b=l2NufwrmYQSLIEeqaYUCFTqn1gAR0ZO16z+0pmGANtceCfmZALbhfN18V4+WHRHxUB
         7lQvqRZCfmxiPtzlZ5Ad7nGoroEuucO2XrwC6LrwEkK+cte0UuubAxH2CqTMmL0wr+Hz
         6rgngfYf9cijGY+79xFp/stD5SRymDVqTtEhHTRrDV6gBRTtmv9dP2mvQt45AKAbKeGK
         uLIe1lpDJOuuyJ3bhTaI68KUzzE+eIwBaJwGmZyfte/dKmq0wZNq//NDnJ8nY1djJ7RJ
         z80fPaY3JGtNmm2QWgMzV5SEKOsGGpQUE5U0VnxA4OuDRx390jPuo+dwcUf5xChi4geU
         V0fA==
X-Gm-Message-State: AOAM532dibA35iCPt2NrFif9gAMa93YS2iSwg3YHbMsbZoQx+SmAXcmk
        zb+73wkd6ZJVyJj+V2Bp22gz9/NEtAyBCA==
X-Google-Smtp-Source: ABdhPJwbgCAYz02xEiLJhnbS+Ia7Cz3iAKjL+ZgfRnC2c+abP5JrMLH3RkbLa8ky+Lie5XHSdMaGLA==
X-Received: by 2002:a05:6512:24a:: with SMTP id b10mr4164453lfo.434.1605473870338;
        Sun, 15 Nov 2020 12:57:50 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id j4sm2458779lfk.275.2020.11.15.12.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 12:57:49 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3 v3] iio: accel: bmc150-accel: Add support for BMA222
Date:   Sun, 15 Nov 2020 21:57:44 +0100
Message-Id: <20201115205745.618455-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201115205745.618455-1-linus.walleij@linaro.org>
References: <20201115205745.618455-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds support for the BMA222 version of this sensor,
found in for example the Samsung GT-I9070 mobile phone.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Re-use the BMA222e channels for the BMA222 since they
  are anyway identical.
ChangeLog v1->v2:
- None, resend with the other patches.
---
 drivers/iio/accel/bmc150-accel-core.c | 15 +++++++++++++++
 drivers/iio/accel/bmc150-accel-i2c.c  |  4 ++++
 drivers/iio/accel/bmc150-accel-spi.c  |  2 ++
 drivers/iio/accel/bmc150-accel.h      |  1 +
 4 files changed, 22 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 48435865fdaf..01dbc01e328f 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -5,6 +5,7 @@
  *  - BMI055
  *  - BMA255
  *  - BMA250E
+ *  - BMA222
  *  - BMA222E
  *  - BMA280
  *
@@ -1063,6 +1064,20 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {153277, BMC150_ACCEL_DEF_RANGE_8G},
 				 {306457, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
+	[bma222] = {
+		.name = "BMA222",
+		.chip_id = 0x03,
+		.channels = bma222e_accel_channels,
+		.num_channels = ARRAY_SIZE(bma222e_accel_channels),
+		/*
+		 * The datasheet page 17 says:
+		 * 15.6, 31.3, 62.5 and 125 mg per LSB.
+		 */
+		.scale_table = { {156000, BMC150_ACCEL_DEF_RANGE_2G},
+				 {313000, BMC150_ACCEL_DEF_RANGE_4G},
+				 {625000, BMC150_ACCEL_DEF_RANGE_8G},
+				 {1250000, BMC150_ACCEL_DEF_RANGE_16G} },
+	},
 	[bma222e] = {
 		.name = "BMA222E",
 		.chip_id = 0xF8,
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 06021c8685a7..bba92dd33179 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -5,6 +5,7 @@
  *  - BMI055
  *  - BMA255
  *  - BMA250E
+ *  - BMA222
  *  - BMA222E
  *  - BMA280
  *
@@ -54,6 +55,7 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 	{"BMI055A",	bmi055},
 	{"BMA0255",	bma255},
 	{"BMA250E",	bma250e},
+	{"BMA222",	bma222},
 	{"BMA222E",	bma222e},
 	{"BMA0280",	bma280},
 	{"BOSC0200"},
@@ -66,6 +68,7 @@ static const struct i2c_device_id bmc150_accel_id[] = {
 	{"bmi055_accel",	bmi055},
 	{"bma255",		bma255},
 	{"bma250e",		bma250e},
+	{"bma222",		bma222},
 	{"bma222e",		bma222e},
 	{"bma280",		bma280},
 	{}
@@ -78,6 +81,7 @@ static const struct of_device_id bmc150_accel_of_match[] = {
 	{ .compatible = "bosch,bmi055_accel" },
 	{ .compatible = "bosch,bma255" },
 	{ .compatible = "bosch,bma250e" },
+	{ .compatible = "bosch,bma222" },
 	{ .compatible = "bosch,bma222e" },
 	{ .compatible = "bosch,bma280" },
 	{ },
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 2a8c311d6f5a..74a8aee4f612 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -39,6 +39,7 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 	{"BMI055A",	bmi055},
 	{"BMA0255",	bma255},
 	{"BMA250E",	bma250e},
+	{"BMA222",	bma222},
 	{"BMA222E",	bma222e},
 	{"BMA0280",	bma280},
 	{ },
@@ -50,6 +51,7 @@ static const struct spi_device_id bmc150_accel_id[] = {
 	{"bmi055_accel",	bmi055},
 	{"bma255",		bma255},
 	{"bma250e",		bma250e},
+	{"bma222",		bma222},
 	{"bma222e",		bma222e},
 	{"bma280",		bma280},
 	{}
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index ae6118ae11b1..f5427103574d 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -9,6 +9,7 @@ enum {
 	bmi055,
 	bma255,
 	bma250e,
+	bma222,
 	bma222e,
 	bma280,
 };
-- 
2.26.2

