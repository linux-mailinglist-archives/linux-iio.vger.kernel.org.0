Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36A3A2B69
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhFJM0S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:26:18 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:12430 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhFJM0P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:26:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623327848; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=du/vEM0BJUmObeD5qFiL9266QvTHKuzLW1lCzmwvRFVOxxuTBnjWVFbRbiPDFMMmR9
    HKBQEoijPLHkqOofWu1koFnGWixlKe53b/cBAyBnM5S07708+l8I2GwgX58ygvBtq256
    OrUhT3ySuPx8fbbgDFJEVpTnHUfC+i1cpfOB7h9cK9de/I0ZuT/BOj/G8m7yu0Aaskwb
    Z2AFyI13DZganEDj6XLVIDh+MujkfK9UAaBaziKtdcAT0eEQNXpIdnSwk6urZmfwhP6c
    nZOV88QheM4xKRD8TRrF3bg6tUHtqolzIqh/plhShh5/5NSyeE2yxeEiquh6zp7YqyKb
    b2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327848;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7ZnJWOKXF3bam85beD5D5WnhHWKhMFJvGQTO/dyDe5w=;
    b=C8q/MMax9vCpMOd7XdLm7b+rRky0MFGwR1SBIusOkba9J6wvKrtSqRZAFdHceVljBH
    LN3+OSozaKLekRpdBH4fY6a+gKxtZ30FHP/v5AaqzN6v6nZeRYD+eSumcFAQn/idZTgS
    nGK0uNG4r2w/teHphoBuqjJyX+ADtTFRXR/5JM1Nq8oQB/PA4xf9g+YfKb+2OMit21j/
    9eQbUsrbsmSmKm4HhLtlGkNSTifc2AtWwe4q+zAkpby30PharIvKHUZDUIbiPsS2Bk8E
    YxjqWFfqL4z/AtfiQQvkUmXQ82pVdt74ySkzIwmw0WMrjz4MHHfSH/gxRMdvNY4XNyzt
    LdyQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327848;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7ZnJWOKXF3bam85beD5D5WnhHWKhMFJvGQTO/dyDe5w=;
    b=acF4Mq6im9xox4XgDiYu/tzRFO7tZxjtVhpKmCHVZh4XZNkFqvBbCdXZbyuHrfxCoD
    +qZ5T/UQzhtr+m5Y/XVhtx6N3SSbc1INOMMKl9Enqs0dIGzL9lqTtqMDr1S1NrQLHjwb
    2bwzDYL7eHc8MDc1lnIqD88moSJ9ddmmzR5OfnM9rbtBAZZoKDyO1KdOVywLHF6nCBnD
    nJgtQuk/fnwm7iJaxjyUSJS9t5ZgUf0Wmjkz+5j6GEypUVElOnzNatEvYxdYucwzyeMU
    Mqy9NGAAmc0mJU9nCT/XrZvauQkKIjjGuNNxukXaTW+jzkNxQn62XIEGUB8AEbskbChr
    vUxA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5ACO7tzv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 14:24:07 +0200 (CEST)
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
Subject: [PATCH v2 4/9] iio: accel: bmc150: Sort all chip names alphabetically / by chip ID
Date:   Thu, 10 Jun 2021 14:21:21 +0200
Message-Id: <20210610122126.50504-5-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610122126.50504-1-stephan@gerhold.net>
References: <20210610122126.50504-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Right now all the device IDs are listed in seemingly random order,
make this consistent by ordering those alphabetically. Also, order
bmc150_accel_chip_info_tbl by chip ID for the same reason.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
New patch in v2.
---
 drivers/iio/accel/Kconfig             |  4 +--
 drivers/iio/accel/bmc150-accel-core.c | 40 +++++++++++++--------------
 drivers/iio/accel/bmc150-accel-i2c.c  | 26 ++++++++---------
 drivers/iio/accel/bmc150-accel-spi.c  | 18 ++++++------
 4 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 17f6bdcf1db3..883aa8bc4340 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -143,9 +143,9 @@ config BMC150_ACCEL
 	select BMC150_ACCEL_SPI if SPI
 	help
 	  Say yes here to build support for the following Bosch accelerometers:
-	  BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
+	  BMA222, BMA222E, BMA250E, BMA255, BMA280, BMC150, BMI055.
 
-	  This is a combo module with both accelerometer and magnetometer.
+	  BMC150 is a combo module with both accelerometer and magnetometer.
 	  This driver is only implementing accelerometer part, which has
 	  its own address and register map.
 
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 6fb025b4228f..1210a8b14a3c 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1089,26 +1089,6 @@ static const struct iio_chan_spec bma280_accel_channels[] =
 	BMC150_ACCEL_CHANNELS(14);
 
 static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
-	{
-		.name = "BMC150/BMI055/BMA255",
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
+		.name = "BMC150/BMI055/BMA255",
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

