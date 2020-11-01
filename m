Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E769F2A1DDB
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 13:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgKAM2n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 07:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgKAM2m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2020 07:28:42 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9620C061A04
        for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2020 04:28:40 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l28so13752595lfp.10
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2020 04:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1h7tD4oiBs+mtjedWhyGqQzrspO0zTn8Dim8Rdes2w=;
        b=OUj2TIp/ohXcdhyUDwBAYjJoD7jDmxhbZmHC+LCnwQrsu91AmAnoUu8DdQGKswq916
         pd4q30RKAWKmHlzkJVX72nt2YWmKgoqDO+ye7efx8vsQjarvgq6tJwniznEgNppiO2gG
         1zA22L0ObT9AJcJKCbRXfSGeHRLtfDSD3Mh7IaFjnVSAEBhNToKgIMUKBTyeOPm0lUAq
         U0zoIdmXsV+eIsCJIOIX554dz43+Hbk4PFH1XNCnhZDVrqNa0gZUbrF9KQJxI1Lp6Nvb
         hVQykyX97Z6yvcO+k6UNSE8X+f7ld0mNNKqb3b2GveVOjccb6WhgH12geaglyXMwSWll
         xEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1h7tD4oiBs+mtjedWhyGqQzrspO0zTn8Dim8Rdes2w=;
        b=n80+hAjagJ8Vmc5gUOnJ3Rd01APPDiUG7Ze84bCfTju32OesZMXUp4QSQ9Fk4xX51D
         RNH91wnUtWyZ3qEIs6sj/0Kg+8Rw4MafqBklG5xYwCDmYPMgCp/urMNIcE79tgk8FMyu
         XatJRymsmNaArBZOfWujOPfVXQJoGbMr7vbKoJb59T7I4kjGcksg1D2hNW3Xe3/t1MkD
         RACEYTOpoPjNbvgBFJkLVHbkFqrwudoJmk8xHF0d+qu/1IunuzSXkZ8Hh9K8Ek6YumLH
         jcjyNZ0kpQCrrgxKkjwX341eMK3YFhj0j9jhLbD87ML5lsM3BmHiIIef8IiIs8LEuCRN
         kAeA==
X-Gm-Message-State: AOAM531eSGkSPN3ELjV/dwIHci62DJN1c59hLxHr578UMPTnd8zgX4Gq
        fam4fMNdALHo53VQmbEi+f/55fScw5VwJrPC
X-Google-Smtp-Source: ABdhPJzB8baLBtt5YFSzEoZE82l+qR2ZiDf8GynuaiaYbeMO8ypaeQClSONW2KvAevqf76foljON6A==
X-Received: by 2002:ac2:4d58:: with SMTP id 24mr3908549lfp.32.1604233719423;
        Sun, 01 Nov 2020 04:28:39 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id 190sm1480655lfk.238.2020.11.01.04.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 04:28:38 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3] iio: accel: bmc150-accel: Add support for BMA222
Date:   Sun,  1 Nov 2020 13:28:32 +0100
Message-Id: <20201101122833.1111424-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201101122833.1111424-1-linus.walleij@linaro.org>
References: <20201101122833.1111424-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds support for the BMA222 version of this sensor,
found in for example the Samsung GT-I9070 mobile phone.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/bmc150-accel-core.c | 17 +++++++++++++++++
 drivers/iio/accel/bmc150-accel-i2c.c  |  4 ++++
 drivers/iio/accel/bmc150-accel-spi.c  |  2 ++
 drivers/iio/accel/bmc150-accel.h      |  1 +
 4 files changed, 24 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 48435865fdaf..0dafe4052856 100644
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
@@ -1013,6 +1014,8 @@ static const struct iio_event_spec bmc150_accel_event = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),					\
 }
 
+static const struct iio_chan_spec bma222_accel_channels[] =
+	BMC150_ACCEL_CHANNELS(8);
 static const struct iio_chan_spec bma222e_accel_channels[] =
 	BMC150_ACCEL_CHANNELS(8);
 static const struct iio_chan_spec bma250e_accel_channels[] =
@@ -1063,6 +1066,20 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {153277, BMC150_ACCEL_DEF_RANGE_8G},
 				 {306457, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
+	[bma222] = {
+		.name = "BMA222",
+		.chip_id = 0x03,
+		.channels = bma222_accel_channels,
+		.num_channels = ARRAY_SIZE(bma222_accel_channels),
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

