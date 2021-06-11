Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480BC3A3DCF
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 10:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFKIN6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 04:13:58 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:28596 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKIN5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 04:13:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623399111; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tvjYSwy8Fppc1RHei25ymUUr4o8DzklDgOvOsgO9n31Wio0EYWY9prhNebtlLOYbLD
    VZ59yYSphCTR7l21Rd95WP52u9+mRa+T8y/jX3knlDVHsiwC3c2Pm922nVgWWIfp64RZ
    eGkBUdYJO+w7MIVZtMPJ/+TfLY2WwXuWFWqrs//44XyvN5xJBqGIEG1NfleBkTDylEa4
    owbtxVqJb8W/cl7ySE4ko+e7ZeGz9xzQAN8LwXbNJGfsJV0SR+nmfDfaj3oJ11/mMH2E
    uFRxta71YTtiCQIxhZlgT+8sNbW86CmD2Li4Ep0WSJqaQbqeZ1IeJ/HadIxWMLqWjnMO
    6hTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399111;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XXFAcqf96vwfcunpTEDutx/jVcWi6SrARU+yhy/f5ow=;
    b=NniuxQ5Mfw3vteJs037/b3tCrcxt4di0odlNruoDEFeWXRmGvM9VQy4Oi6KZ67KgKc
    GauiNWOMmOb3uerHJiPzmsnKrSgdBgpiL2rjoGebjqrUwv51xXGRdyfmV00WHqMkpDnY
    D/tHrW71KHR95Ly3DB2baDmXD8mq1nQCkE5UxF8hYEAwViuyEczh2ZlNNwlKHcA09w52
    kCuHcCRB6timMLmBlrI7ur0AXKm0C6o7Qz+C8L4v/0aUk2ymWxOAzUGO0WUByxYZCdJ5
    oFd1Shkou8LjekcYCqdyd1h173dWe3wqtA1p8r4GY01RoeyWc7JVEHg6gUmItHfbU8R2
    yZzg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399111;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XXFAcqf96vwfcunpTEDutx/jVcWi6SrARU+yhy/f5ow=;
    b=oeZko6JIobQvD6DhuNB+EuhIRM1APp9JBXBS5dS2GDBKYObR3byMNFmOd2pSv8ua1G
    CjYxuDfJRe3jgN4A1euycL84WvlZ1F3CSfLjkZybFziUXPP74EISYOr7g1W2uooxyBbA
    CixbpPFE+gIrT8USg7Q6cNhrsrN/9HVG7i06xDZ6mhLMSsRX2sVNfGT7MeyCZfRXBmnc
    RNidouiBczfktOW8pHZFprvwEs/3LV7BV2Lc5jsr3zcCTWEZAZ/B7C4U4lqjbJCUEUgQ
    PBzMVsc25NigayQ3qA3PZBr/+7xPKXLZOkxtd6nO+H549WOvpHplmNAFxFnDsE7o6mbM
    6mSg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6PrPw="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5B8Bp02j
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 10:11:51 +0200 (CEST)
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
Subject: [PATCH v3 05/10] iio: accel: bmc150: Sort all chip names alphabetically / by chip ID
Date:   Fri, 11 Jun 2021 10:08:58 +0200
Message-Id: <20210611080903.14384-6-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611080903.14384-1-stephan@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Right now all the device IDs are listed in seemingly random order,
make this consistent by ordering those alphabetically. Also, order
bmc150_accel_chip_info_tbl by chip ID for the same reason.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v3: Move Kconfig changes into extra patch to clarify
               which chips are combos
New patch in v2.
---
 drivers/iio/accel/bmc150-accel-core.c | 40 +++++++++++++--------------
 drivers/iio/accel/bmc150-accel-i2c.c  | 26 ++++++++---------
 drivers/iio/accel/bmc150-accel-spi.c  | 18 ++++++------
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 4b5caa89a3b4..5a19676bcd2d 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1089,26 +1089,6 @@ static const struct iio_chan_spec bma280_accel_channels[] =
 	BMC150_ACCEL_CHANNELS(14);
 
 static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
-	{
-		.name = "BMA255/BMC150/BMI055",
-		.chip_id = 0xFA,
-		.channels = bmc150_accel_channels,
-		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
-		.scale_table = { {9610, BMC150_ACCEL_DEF_RANGE_2G},
-				 {19122, BMC150_ACCEL_DEF_RANGE_4G},
-				 {38344, BMC150_ACCEL_DEF_RANGE_8G},
-				 {76590, BMC150_ACCEL_DEF_RANGE_16G} },
-	},
-	{
-		.name = "BMA250E",
-		.chip_id = 0xF9,
-		.channels = bma250e_accel_channels,
-		.num_channels = ARRAY_SIZE(bma250e_accel_channels),
-		.scale_table = { {38344, BMC150_ACCEL_DEF_RANGE_2G},
-				 {76590, BMC150_ACCEL_DEF_RANGE_4G},
-				 {153277, BMC150_ACCEL_DEF_RANGE_8G},
-				 {306457, BMC150_ACCEL_DEF_RANGE_16G} },
-	},
 	{
 		.name = "BMA222",
 		.chip_id = 0x03,
@@ -1134,6 +1114,26 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {612915, BMC150_ACCEL_DEF_RANGE_8G},
 				 {1225831, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
+	{
+		.name = "BMA250E",
+		.chip_id = 0xF9,
+		.channels = bma250e_accel_channels,
+		.num_channels = ARRAY_SIZE(bma250e_accel_channels),
+		.scale_table = { {38344, BMC150_ACCEL_DEF_RANGE_2G},
+				 {76590, BMC150_ACCEL_DEF_RANGE_4G},
+				 {153277, BMC150_ACCEL_DEF_RANGE_8G},
+				 {306457, BMC150_ACCEL_DEF_RANGE_16G} },
+	},
+	{
+		.name = "BMA255/BMC150/BMI055",
+		.chip_id = 0xFA,
+		.channels = bmc150_accel_channels,
+		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
+		.scale_table = { {9610, BMC150_ACCEL_DEF_RANGE_2G},
+				 {19122, BMC150_ACCEL_DEF_RANGE_4G},
+				 {38344, BMC150_ACCEL_DEF_RANGE_8G},
+				 {76590, BMC150_ACCEL_DEF_RANGE_16G} },
+	},
 	{
 		.name = "BMA280",
 		.chip_id = 0xFB,
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index a0e2782580b7..7db436ddbdce 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -213,41 +213,41 @@ static int bmc150_accel_remove(struct i2c_client *client)
 }
 
 static const struct acpi_device_id bmc150_accel_acpi_match[] = {
-	{"BSBA0150"},
-	{"BMC150A"},
-	{"BMI055A"},
 	{"BMA0255"},
-	{"BMA250E"},
+	{"BMA0280"},
 	{"BMA222"},
 	{"BMA222E"},
-	{"BMA0280"},
+	{"BMA250E"},
+	{"BMC150A"},
+	{"BMI055A"},
 	{"BOSC0200"},
+	{"BSBA0150"},
 	{"DUAL250E"},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
 
 static const struct i2c_device_id bmc150_accel_id[] = {
-	{"bmc150_accel"},
-	{"bmi055_accel"},
-	{"bma255"},
-	{"bma250e"},
 	{"bma222"},
 	{"bma222e"},
+	{"bma250e"},
+	{"bma255"},
 	{"bma280"},
+	{"bmc150_accel"},
+	{"bmi055_accel"},
 	{}
 };
 
 MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
 
 static const struct of_device_id bmc150_accel_of_match[] = {
-	{ .compatible = "bosch,bmc150_accel" },
-	{ .compatible = "bosch,bmi055_accel" },
-	{ .compatible = "bosch,bma255" },
-	{ .compatible = "bosch,bma250e" },
 	{ .compatible = "bosch,bma222" },
 	{ .compatible = "bosch,bma222e" },
+	{ .compatible = "bosch,bma250e" },
+	{ .compatible = "bosch,bma255" },
 	{ .compatible = "bosch,bma280" },
+	{ .compatible = "bosch,bmc150_accel" },
+	{ .compatible = "bosch,bmi055_accel" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmc150_accel_of_match);
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 01b42fa6a015..dc884fa18ad0 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -34,26 +34,26 @@ static int bmc150_accel_remove(struct spi_device *spi)
 }
 
 static const struct acpi_device_id bmc150_accel_acpi_match[] = {
-	{"BSBA0150"},
-	{"BMC150A"},
-	{"BMI055A"},
 	{"BMA0255"},
-	{"BMA250E"},
+	{"BMA0280"},
 	{"BMA222"},
 	{"BMA222E"},
-	{"BMA0280"},
+	{"BMA250E"},
+	{"BMC150A"},
+	{"BMI055A"},
+	{"BSBA0150"},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
 
 static const struct spi_device_id bmc150_accel_id[] = {
-	{"bmc150_accel"},
-	{"bmi055_accel"},
-	{"bma255"},
-	{"bma250e"},
 	{"bma222"},
 	{"bma222e"},
+	{"bma250e"},
+	{"bma255"},
 	{"bma280"},
+	{"bmc150_accel"},
+	{"bmi055_accel"},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, bmc150_accel_id);
-- 
2.32.0

