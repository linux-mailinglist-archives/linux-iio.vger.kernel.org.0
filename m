Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF302B10B4
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 22:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKLVzS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 16:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgKLVzS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 16:55:18 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10D2C0613D6
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2020 13:55:07 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id v20so8065917ljk.8
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2020 13:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AQ9kJjq8vdt06kdZLoqUGJ+vyt/6DNWO/fQqsAmMfO0=;
        b=JAZydcCJvlZGMujua67M50Pgnp5DsswCJJ+AllU7c/K+Z/fQT6Qv3X4q5+VFxdXJWB
         ZQSrJlB0KPaMQNVI8UdRuDeWEqeE0thmmv07+eESgZveON92Sd/crxDBlvkeCVI1xfv8
         hQQLlue+sIVo638FKqlblgcadSJEH1sHshJuGR64nBPgUg2niEo1EcMniYNfT5bhD1LP
         XGg3tfYk9rwUtkKulUlcJMZbWEh+rKcJc1Fl7UzuxLc5KL7MkX6cKYt9zlaLMy4KNzee
         poNNDS7PnrXNlj5A8WmEvkRmOhud+BcVm9spRrMVCeuPggtbBXtMcm07GWK0Y+u58Zcs
         OhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AQ9kJjq8vdt06kdZLoqUGJ+vyt/6DNWO/fQqsAmMfO0=;
        b=KeUmm0BwwZA2L5upCIGhi6SqDD2IxLWJX6ygvdbwIcLlcbdP9ZbqVrLmGdObzif9dB
         IPD60ThoDG0h+hSc1LAdK6CZmCUfyK+9JeNhnANSQtw8vfvvkYqDKIo/iAqejcWEJdJN
         ojJidKT8gIMBRjFbhAKY2uA2nh8gE//E44byceEtdkG9fK0piBZg96U0ZE3oYRUI/NTd
         NWUetEj4aojEIQT2ymrc0VcfOTg33TNTNpg2VGFZNaE1bpbx8uboUH8869IJHbXjbIcv
         5kRVMJdTY9DWx0g+GhW9HYWUC5kZbkmpL2iuPLex14FrC6H+nRcxEVLeZwUjrzQUleSZ
         JKug==
X-Gm-Message-State: AOAM532C37PeV+U7PbMd+dV09E1Zn67ebf/y9WxHJy9bOakro7++UsVi
        E6MawBBVhEXq2CJjP52KK6vuCg==
X-Google-Smtp-Source: ABdhPJx1atOw9utTuEhIU/mwb4fSfLJDhoqXygLmUEIgujWOhqWsuWTMWg3te1FYsu3D1AQUYbmxxQ==
X-Received: by 2002:a05:651c:1074:: with SMTP id y20mr707965ljm.432.1605218105786;
        Thu, 12 Nov 2020 13:55:05 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x24sm967731ljj.112.2020.11.12.13.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:55:05 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3 v2] iio: accel: bmc150-accel: Add support for BMA222
Date:   Thu, 12 Nov 2020 22:54:50 +0100
Message-Id: <20201112215451.2606136-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112215451.2606136-1-linus.walleij@linaro.org>
References: <20201112215451.2606136-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds support for the BMA222 version of this sensor,
found in for example the Samsung GT-I9070 mobile phone.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- None, resend with the other patches.
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

