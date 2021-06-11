Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4EB3A3DCB
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 10:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhFKIN4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 04:13:56 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:9861 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFKINy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 04:13:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623399110; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Bi7D0hC47mnCGKuqVg7vgTlwI3Gh1/Xg8jdWwDLpYrlM/Fhwy6tX2buLZfXtRAajvS
    1NtISo1Ci2sDmxiiwK1hjhWy0376WVHIXFWvUJ35bIBk2tA+83Oc+nE1TUhmqBfvnsk1
    2vnU4x0y/IW5OhAU1Dne4/IXboJxJ5Idv7vAicJxYsWn9CqDeUYJjJscih7i6Hj02FvP
    PxtPSeYGWwUvqI4J5HLi43JtOjz8qiSv5seSwSYxFdJWsbxjYmeSpAMPrYzbtVu5JRsr
    VMZmB4RNsalSSrvEN66IPJUcjMtD/6WQGdR6jIjKYZpwJSPC5oWea9hpg6i5uciDrWY1
    8gsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399110;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RnlciFqVhgy9BlHJjaLfId0CtxqVht5q2o9IZGHpHRI=;
    b=nmV6ynGCBWc6wJAn5w8HcVS5se62Ata2bL+kU1YbSTugVsWurj85ASaPgoFGHrrObf
    pXMksgqD+QhG2BTk2MVYJP70wRDdCc8KBRziMRTR1YPMHK0NR6gp/5B+nUwdw9+pI0N8
    K4F5BOw0Hq1U0bb0VZEzrL6IeTrQvVEzLsbrgKiZSq8zDqJS53IVeB48RHMwmoThsfEe
    5U8qAe3JCbEofrMsfH1Kw+b6c5QOQMpLnpxSYPpjelBdyf5+KYyq0WikfSbQM1NMCCf5
    Ti6vT950CkgbjQ9Cp7AB9kSxtIcFoo1uuWf1jSTosmoJNIsV90AhK+n4vW7QCeyAJY8X
    J0og==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399110;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RnlciFqVhgy9BlHJjaLfId0CtxqVht5q2o9IZGHpHRI=;
    b=hYDoU0oTy4ihJeati2vABzd7MIpR2GlFpebrO5ylXJ+cqzlXISs5P3ltuXANxK0wwp
    WTX7ABM9GUeMh1NLE9ZpHbZCtMttkRumhD7TCpsYeXJJnu+neYULv5Q+5vdcOWUXwXGN
    uSzTVDaIyvkEfCD8nH0xX8HH+uZAyH9SO+3o5GrQVuDNtvC0JysWnnuC6l3Op55DZZ25
    BV5gISlsKVTJqNd9bG2vD24itfecDtqwJjKk6zgC5iRse7m9a+4fMzpRbBVgzd86QIi2
    IBiexijWsECObcDD6bfDHtqFEl5yfbI16xDM2Q2Llw076L23kys0SpD18L5ihKHZ9o7E
    cljQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6PrPw="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5B8Bo02g
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 10:11:50 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 03/10] iio: accel: bmc150: Drop misleading/duplicate chip identifiers
Date:   Fri, 11 Jun 2021 10:08:56 +0200
Message-Id: <20210611080903.14384-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611080903.14384-1-stephan@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v3: Sort combined chip names in chip info table
---
 drivers/iio/accel/bmc150-accel-core.c | 34 ++++++---------------------
 drivers/iio/accel/bmc150-accel-i2c.c  | 30 +++++++++++------------
 drivers/iio/accel/bmc150-accel-spi.c  | 30 +++++++++++------------
 drivers/iio/accel/bmc150-accel.h      | 10 --------
 4 files changed, 37 insertions(+), 67 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index a80ee0fdabc5..9ecbd3769593 100644
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
+		.name = "BMA255/BMC150/BMI055",
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
@@ -1152,7 +1132,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {612916, BMC150_ACCEL_DEF_RANGE_8G},
 				 {1225831, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
-	[bma222e] = {
+	{
 		.name = "BMA222E",
 		.chip_id = 0xF8,
 		.channels = bma222e_accel_channels,
@@ -1162,8 +1142,8 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
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
2.32.0

