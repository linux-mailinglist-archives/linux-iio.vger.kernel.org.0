Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EACD3A28DC
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 11:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFJKBU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 06:01:20 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:25443 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJKBU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 06:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623318984; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UxKBtim/qhiLdKMmOn+dupV9i0xsO0nfs3FrpT84mNIi85Rr/yYCSgeFfTZpNXcbdP
    DHCPCibMSf5TXr7YIniETY8QRQnaPfW6bPKu2byQevYqcw4I2sShNtwLkvr7r0xaTcHE
    wsir3py74UxoR2C2y1+zEn+AJS/K/H4hBpS0UmrykQfhht/Iz22MPnydKP5ydgfmFaj0
    E4QSp024B9nD8m5a64zbrwqRTTOJNBzy0bKBPg7+uTK5c40nynuMGNJXDsi9GbAPhVRv
    0nyf8oYgRxuKn2fpWEQX5M5QE3MUBYg3lg2TOyRhx+9NAmjk5BHt9nOrQB6vPxcELNfd
    aGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318984;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZBrKvpayqrI6RhcSuPGx5OIyUigdkTCBJlRkGtVotVs=;
    b=MP7ZeJePUErohuB4m6ZRBKJIH5eXQk8xNmMiAdPwSayWAM8BtDxfgRMmS7isxn6JQ9
    NpemilgixvfrBYWxGNAu01LjU11ZYE0D0QmcGy4y6sXHjOMtS7UsdbPPOSem79eRyMUW
    osYYuQHIy9wiC2xrtwNz0Y+251Uh/W2dsYGkI0TeNk4hv6xgcyFFLIPW1dz7z8nXFJRK
    H3Ua19dRGSQlQXaEKP+5U/QYVmlmOC8Mbud6YCW+39nzKchMkpl0n0TunT5MmxHYkRju
    HTJMMO7zyQOPTv+Gu4GvRyy3BZrrBZCHMYeSxbiAT6j+biTDUsqa7iMCOsFnzbdruk0C
    AAow==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318984;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZBrKvpayqrI6RhcSuPGx5OIyUigdkTCBJlRkGtVotVs=;
    b=GoDmoQ6HZJXare0qr4lCE0s2JWJbbjp3DLXaZJuwpKMbM80v6/DVT763R8o5x+AKjV
    txk+9lw6gKiQWe2uDhQw+5R3hKBMf1aOMQ/qSw4h0ILfaCXY5mfF6vMFAnuhN2KcWy2j
    byfmJg5knci5hxtm1nEzSl8LmkiR1xk4CZvaXmJra3/wh5ECMPPR6u+SdQAwkzJgA3x+
    tbLGgLpw4ew76bpuWHwwCefK49BxpxySLnIDnpoW2yNBW2wQVV56gQDf6SUMZk2Z9NTb
    e001BBSQNb112cjFTevLX/kYCd4IbiLLASM+Pd//XmxGrAHGYCgMZi17QaOICEfEBOtA
    5MYQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5A9uNsnz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 11:56:23 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Laurentiu Palcu <laurentiu.palcu@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/6] iio: accel: bmc150: Drop misleading/duplicate chip identifiers
Date:   Thu, 10 Jun 2021 11:52:55 +0200
Message-Id: <20210610095300.3613-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610095300.3613-1-stephan@gerhold.net>
References: <20210610095300.3613-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit 0ad4bf370176 ("iio:accel:bmc150-accel: Use the chip ID to detect
sensor variant") stopped using the I2C/ACPI match data to look up the
bmc150_accel_chip_info. However, the bmc150_accel_chip_info_tbl remained
as-is, with multiple entries with the same chip_id (e.g. 0xFA for
BMC150/BMI055/BMA255). This is redundant now because actually the driver
will always select the first entry with a matching chip_id.

So even if a device probes e.g. with BMA0255 it will end up using the
chip_info for BMC150. And in general that's fine for now, the entries
for BMC150/BMI055/BMA255 were exactly the same anyway (except for the
name, which is replaced with the more accurate one later).

But in this case it's misleading because it suggests that one should
add even more entries with the same chip_id when adding support for
new variants. Let's make that more clear by removing the enum with
the chip identifiers entirely and instead have only one entry per
chip_id.

Note that we may need to bring back some mechanism to differentiate
between different chips with the same chip_id in the future.
For example, BMA250 (currently supported by the bma180 driver) has the
same chip_id = 0x03 as BMA222 even though they have different channel
sizes (8 bits vs 10 bits). But in any case, that mechanism would
need to look quite different from what we have right now.

Cc: Bastien Nocera <hadess@hadess.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/bmc150-accel-core.c | 34 ++++++---------------------
 drivers/iio/accel/bmc150-accel-i2c.c  | 30 +++++++++++------------
 drivers/iio/accel/bmc150-accel-spi.c  | 30 +++++++++++------------
 drivers/iio/accel/bmc150-accel.h      | 10 --------
 4 files changed, 37 insertions(+), 67 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index a3d08d713362..d4349f749485 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1097,28 +1097,8 @@ static const struct iio_chan_spec bma280_accel_channels[] =
 	BMC150_ACCEL_CHANNELS(14);
 
 static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
-	[bmc150] = {
-		.name = "BMC150A",
-		.chip_id = 0xFA,
-		.channels = bmc150_accel_channels,
-		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
-		.scale_table = { {9610, BMC150_ACCEL_DEF_RANGE_2G},
-				 {19122, BMC150_ACCEL_DEF_RANGE_4G},
-				 {38344, BMC150_ACCEL_DEF_RANGE_8G},
-				 {76590, BMC150_ACCEL_DEF_RANGE_16G} },
-	},
-	[bmi055] = {
-		.name = "BMI055A",
-		.chip_id = 0xFA,
-		.channels = bmc150_accel_channels,
-		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
-		.scale_table = { {9610, BMC150_ACCEL_DEF_RANGE_2G},
-				 {19122, BMC150_ACCEL_DEF_RANGE_4G},
-				 {38344, BMC150_ACCEL_DEF_RANGE_8G},
-				 {76590, BMC150_ACCEL_DEF_RANGE_16G} },
-	},
-	[bma255] = {
-		.name = "BMA0255",
+	{
+		.name = "BMC150/BMI055/BMA255",
 		.chip_id = 0xFA,
 		.channels = bmc150_accel_channels,
 		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
@@ -1127,7 +1107,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {38344, BMC150_ACCEL_DEF_RANGE_8G},
 				 {76590, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
-	[bma250e] = {
+	{
 		.name = "BMA250E",
 		.chip_id = 0xF9,
 		.channels = bma250e_accel_channels,
@@ -1137,7 +1117,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {153277, BMC150_ACCEL_DEF_RANGE_8G},
 				 {306457, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
-	[bma222] = {
+	{
 		.name = "BMA222",
 		.chip_id = 0x03,
 		.channels = bma222e_accel_channels,
@@ -1151,7 +1131,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {625000, BMC150_ACCEL_DEF_RANGE_8G},
 				 {1250000, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
-	[bma222e] = {
+	{
 		.name = "BMA222E",
 		.chip_id = 0xF8,
 		.channels = bma222e_accel_channels,
@@ -1161,8 +1141,8 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {612915, BMC150_ACCEL_DEF_RANGE_8G},
 				 {1225831, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
-	[bma280] = {
-		.name = "BMA0280",
+	{
+		.name = "BMA280",
 		.chip_id = 0xFB,
 		.channels = bma280_accel_channels,
 		.num_channels = ARRAY_SIZE(bma280_accel_channels),
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index d34dddb850d9..b8bda0dfb495 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -221,14 +221,14 @@ static int bmc150_accel_remove(struct i2c_client *client)
 }
 
 static const struct acpi_device_id bmc150_accel_acpi_match[] = {
-	{"BSBA0150",	bmc150},
-	{"BMC150A",	bmc150},
-	{"BMI055A",	bmi055},
-	{"BMA0255",	bma255},
-	{"BMA250E",	bma250e},
-	{"BMA222",	bma222},
-	{"BMA222E",	bma222e},
-	{"BMA0280",	bma280},
+	{"BSBA0150"},
+	{"BMC150A"},
+	{"BMI055A"},
+	{"BMA0255"},
+	{"BMA250E"},
+	{"BMA222"},
+	{"BMA222E"},
+	{"BMA0280"},
 	{"BOSC0200"},
 	{"DUAL250E"},
 	{ },
@@ -236,13 +236,13 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
 
 static const struct i2c_device_id bmc150_accel_id[] = {
-	{"bmc150_accel",	bmc150},
-	{"bmi055_accel",	bmi055},
-	{"bma255",		bma255},
-	{"bma250e",		bma250e},
-	{"bma222",		bma222},
-	{"bma222e",		bma222e},
-	{"bma280",		bma280},
+	{"bmc150_accel"},
+	{"bmi055_accel"},
+	{"bma255"},
+	{"bma250e"},
+	{"bma222"},
+	{"bma222e"},
+	{"bma280"},
 	{}
 };
 
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 74a8aee4f612..01b42fa6a015 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -34,26 +34,26 @@ static int bmc150_accel_remove(struct spi_device *spi)
 }
 
 static const struct acpi_device_id bmc150_accel_acpi_match[] = {
-	{"BSBA0150",	bmc150},
-	{"BMC150A",	bmc150},
-	{"BMI055A",	bmi055},
-	{"BMA0255",	bma255},
-	{"BMA250E",	bma250e},
-	{"BMA222",	bma222},
-	{"BMA222E",	bma222e},
-	{"BMA0280",	bma280},
+	{"BSBA0150"},
+	{"BMC150A"},
+	{"BMI055A"},
+	{"BMA0255"},
+	{"BMA250E"},
+	{"BMA222"},
+	{"BMA222E"},
+	{"BMA0280"},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
 
 static const struct spi_device_id bmc150_accel_id[] = {
-	{"bmc150_accel",	bmc150},
-	{"bmi055_accel",	bmi055},
-	{"bma255",		bma255},
-	{"bma250e",		bma250e},
-	{"bma222",		bma222},
-	{"bma222e",		bma222e},
-	{"bma280",		bma280},
+	{"bmc150_accel"},
+	{"bmi055_accel"},
+	{"bma255"},
+	{"bma250e"},
+	{"bma222"},
+	{"bma222e"},
+	{"bma280"},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, bmc150_accel_id);
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index d67d6ed6ae77..47121f070fe9 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -68,16 +68,6 @@ struct bmc150_accel_data {
 	struct iio_mount_matrix orientation;
 };
 
-enum {
-	bmc150,
-	bmi055,
-	bma255,
-	bma250e,
-	bma222,
-	bma222e,
-	bma280,
-};
-
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 			    const char *name, bool block_supported);
 int bmc150_accel_core_remove(struct device *dev);
-- 
2.31.1

