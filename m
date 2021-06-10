Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E179C3A2B65
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhFJM0P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:26:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:26888 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJM0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:26:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623327847; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=U9K/4NXhiz+KGL36ojsHxfk8bsrWDqAxOEYFETV6nQfLXlWB6nfJi/LqWl6+Yj3cKP
    zxu1DHjfTSaDzzq3PzkDdPOJMWtx/qmijTq4P2nNWvnjs7sEg9YRLb3CmZp1ADIN+3iL
    fknQIy0yOv/9/UpJ61W8j8l3nbyqhY0KhxqX3ihYc0i4yObJu4OrMbtOl/IVzeAWEDfS
    kvsVGYQbyRyYXCW+t/635Xnxn9dfqFKCGoXM5uli+bqztrQMEUhnefZHtdtKPv0DSkBB
    tF+RAe7yQniW967We+QznzFsj9e+pMecGeF8RsmiexmO41NahEMrjKyGl5U7doiaUUxq
    lvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327847;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Q3a2e6tWtMSAThjzKRoRF1YLXGRImqB6MZinCdGysEc=;
    b=mRGW90YggplPOrnSPQDgF+RUBhkfX0/tM11m52zOLi5KaWEqpynxdB4qgsFUbh9K8+
    80+/QM0eA0DAitY+PW79r5mEY8wxLumWDs8gaySKXFIzoTLBkI4/SM4AoD1jRnICRwJm
    9KTp6U3pU3WCX0wQwvqysbUWL3W6ncFRTNaqCRxx1Q/6Wg003TMknGZ57jvrYgrlA+2L
    Lht9QxDPojKa39Tg88ptu7CwtG6gVPPRQsY7CE7whBRwHajB3hxXm7V4QUBTfez8oqW7
    DUlSa16yKR9Qj68vQyc6fyMQnzsVj23x60Z95rec0yxoP48uLsc19VDemunN26FNTy/X
    ai7w==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327847;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Q3a2e6tWtMSAThjzKRoRF1YLXGRImqB6MZinCdGysEc=;
    b=MLwf2EKGoGS4eQvMvOhZ+3ifTSxcKqmOgi/Q5qt4zbkd7pWjJ4qNAqKiNwagEYcFQG
    JLcaoOCM4THE43tKA/zWV9nl1mHUeIYw4WCqWtaZcOAo7XZojnzbTYutdV+X+BF9dv6C
    AX+J4NCttmAz3IMFZ6uHah2ku6xVPnCEuSUs+HDD86aRFwx9HqXwFoHNqUFAOyprUGPL
    C1QAFTQ4Snj8bsavF17cGGrvUFYdsm8f3egIJDHZ4ah2wDxS2G+jTR1RkPqwNBSPnVUP
    jve358FDhdka6WQhixI3gILZ8cx04SKfrNxmHfWtT1xWy1FTp5sXhudMCvKkjpeY3P3k
    xsSA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5ACO6tzt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 14:24:06 +0200 (CEST)
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
Subject: [PATCH v2 2/9] iio: accel: bmc150: Drop misleading/duplicate chip identifiers
Date:   Thu, 10 Jun 2021 14:21:19 +0200
Message-Id: <20210610122126.50504-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610122126.50504-1-stephan@gerhold.net>
References: <20210610122126.50504-1-stephan@gerhold.net>
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
Note: Andy's Reviewed-by: here applies only together with patch 4
("iio: accel: bmc150: Sort all chip names alphabetically / by chip ID"). :)
---
 drivers/iio/accel/bmc150-accel-core.c | 34 ++++++---------------------
 drivers/iio/accel/bmc150-accel-i2c.c  | 30 +++++++++++------------
 drivers/iio/accel/bmc150-accel-spi.c  | 30 +++++++++++------------
 drivers/iio/accel/bmc150-accel.h      | 10 --------
 4 files changed, 37 insertions(+), 67 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index a80ee0fdabc5..a0df704730ee 100644
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

