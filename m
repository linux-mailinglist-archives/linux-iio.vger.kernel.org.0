Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936B33A28D2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 11:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhFJJ6a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 05:58:30 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:31446 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFJJ63 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 05:58:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623318985; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TZ4VVvG4RUQAdQRUoxY+AjEPZWcE6lII0Kdvtw91QA+gtLeAOrHFBLETkcli3Gff3f
    nB3gpHVGMEDDHgSsjSNREvQtKv+EEo/8T9d4zFJTEpZq67Czlqc1XrtBl7fQhOd9X9eZ
    mPyKWsNm3Oi7Nm2f6MD+YZ4SWe2B8j1ZTMN/tFTULdru/KoSjNVCUnQnppVvGm6Syq/j
    P4lH4VnRjlDK3y+lS6nifHyW1RTU5lbUAQfef0ztVmNJpIbQ0bRLthoCQRR9UPwFria0
    W7/HpJZKV7CE/26xH5RsUovqASAHYKUvZB7tF4x4c8xc2vAWHfSOIGOjTeXrabOwtuVd
    0dMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318985;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WNlaHF78g9bl4CygxMSmelkWWtwJ1TUDvf6CaasmChQ=;
    b=LFI1U2/AkL7jCzVsXIYo5yAHMce6P2O2vNU8FiwOLo9Qx96FOS999GPg4IcEs0Hb31
    2Ac3YDmGkusP2iW+f4l2/QapdUb5X908iQjDNFWRRnTpzSeiMe/9/GWcWahqziejHDsA
    /4kNoOlvoeoaPGdUFXreoLG5r0URrfhuPZVoY/0o9VEsrCGyFAYt/C9vH/oDTr88IbAa
    nBCtyQfM+tFk+V7TYZ65C3WzTQfhdOuVUDnOTotQfJ2a+8bNdhbivpYameenrDSmtpOa
    fhZAs22lfuSXEiyhhjwW80RWdxhuSIFbIfovPaTKiwTeXX4dPVsP4XryX6rkCa8iLNy5
    z+EA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318985;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WNlaHF78g9bl4CygxMSmelkWWtwJ1TUDvf6CaasmChQ=;
    b=l01FliAmrKTbJNzKaORDZySSz1POe1RY0YV8VWHkYWUdOhJqXx9MZSn5njXNXgVFZ1
    0ZJDC4UqyhxEeB9hgFP6LQFC7qLFUkBLLgtCB+kjh7Ju8Jg89BT+aeRV+yzn1OV7oGNT
    mnyngE0BqFHHFY1TmXaeLKlr5Ik3LkHw1ClYXyx1ywvLPym6LJX8wF8SuIEzYt0j+W9z
    8tzaFQlQeBRAu14fs7qz+LG121dCEYL2OLJUAYQ7REbUWfdyJgUyjZFbMAkuEmlWpbWh
    LYIn1SfhiAyT1sE5LaGgHPA43WVyQD8SgaS09cX/E9tdP3ZlS8x0les+Z19xmZ1N8DML
    vSag==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5A9uPso1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 11:56:25 +0200 (CEST)
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
Subject: [PATCH 3/6] iio: accel: bmc150: Add device IDs for BMA253
Date:   Thu, 10 Jun 2021 11:52:57 +0200
Message-Id: <20210610095300.3613-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610095300.3613-1-stephan@gerhold.net>
References: <20210610095300.3613-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMA253 is mostly like BMA255 and has exactly the same register layout
as used by the bmc150-accel driver as far I can tell. Making it work
is as simple as adding new device IDs for it since it has the same
chip_id = 0xFA (250) as BMA255 and others.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/Kconfig             | 2 +-
 drivers/iio/accel/bmc150-accel-core.c | 4 ++--
 drivers/iio/accel/bmc150-accel-i2c.c  | 2 ++
 drivers/iio/accel/bmc150-accel-spi.c  | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 17f6bdcf1db3..f68c14f02d6b 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -143,7 +143,7 @@ config BMC150_ACCEL
 	select BMC150_ACCEL_SPI if SPI
 	help
 	  Say yes here to build support for the following Bosch accelerometers:
-	  BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
+	  BMC150, BMI055, BMA250E, BMA222E, BMA253, BMA255, BMA280.
 
 	  This is a combo module with both accelerometer and magnetometer.
 	  This driver is only implementing accelerometer part, which has
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index d4349f749485..21abc8d166e6 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -3,7 +3,7 @@
  * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
  *  - BMC150
  *  - BMI055
- *  - BMA255
+ *  - BMA253/BMA255
  *  - BMA250E
  *  - BMA222
  *  - BMA222E
@@ -1098,7 +1098,7 @@ static const struct iio_chan_spec bma280_accel_channels[] =
 
 static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 	{
-		.name = "BMC150/BMI055/BMA255",
+		.name = "BMC150/BMI055/BMA253/BMA255",
 		.chip_id = 0xFA,
 		.channels = bmc150_accel_channels,
 		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index b8bda0dfb495..a87306f03a4c 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -238,6 +238,7 @@ MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
 static const struct i2c_device_id bmc150_accel_id[] = {
 	{"bmc150_accel"},
 	{"bmi055_accel"},
+	{"bma253"},
 	{"bma255"},
 	{"bma250e"},
 	{"bma222"},
@@ -251,6 +252,7 @@ MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
 static const struct of_device_id bmc150_accel_of_match[] = {
 	{ .compatible = "bosch,bmc150_accel" },
 	{ .compatible = "bosch,bmi055_accel" },
+	{ .compatible = "bosch,bma253" },
 	{ .compatible = "bosch,bma255" },
 	{ .compatible = "bosch,bma250e" },
 	{ .compatible = "bosch,bma222" },
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 01b42fa6a015..dec7dd252658 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -49,6 +49,7 @@ MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
 static const struct spi_device_id bmc150_accel_id[] = {
 	{"bmc150_accel"},
 	{"bmi055_accel"},
+	{"bma253"},
 	{"bma255"},
 	{"bma250e"},
 	{"bma222"},
-- 
2.31.1

