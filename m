Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C1E3A3DD4
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 10:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhFKIN7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 04:13:59 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.104]:20649 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhFKIN6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 04:13:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623399113; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QYt/J3/eADVs5ukd6StvkJR4X2IUNfaJKWf2BbGCW938SMAi6UDKemKhqwHhz+X8Dq
    +Eud50IJyRNhNqRNfa/Ov7aJ4sw1jW0vTNTMd57r/VfnmxsjoaKu2HID/up/j/Bt7nLk
    r/YswLROaYbcRrl/gNQtWE8uD9Nj13k4jSlYKw5y8A8c3mXnxPA0lq2Cegdnr9i5t9SZ
    UchCKvv8b/YCzxPF+AQx3jcCXLfbkjbnJoflNu9ouLoeXeUOyBwxFkS993E2eeUbZ0IF
    tjI5GshoUnykg6Lqsz8qHKQtYxjSWDRe8LxagudXdn0gDjK8NgXXVj/V2ekWxND1rv+H
    lMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399113;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fhT7wAdCwpMivbtOdh7u7EIUcVxiuK8pSs+eAlKgGtk=;
    b=GANja6mz9iU2FLr96ZMoFlQkbEVe166+MMCbVE3NRos4FpwazavBm7fhEPCdy4lHJx
    3XxfNKzA3/7tGmglTFT4G9x76/7Ob8R0l2hyMw019C08qCWTYiEcOPv+1y1TI+CgUgHV
    j1cfRMBA49cNcBreZDupqncflYA+XdqrMtNIzh6ZUO+dzJy6hB5RGjk2n44mhEj9WKNe
    oCg2AAKdXsldX/qxTMibpBYMTE3ZPzjs1OQgrVhJfBWOJDcyUVjMqgnExycK421qEsKh
    jJMFVxOMjFzu818Fo/azr9sgEV6J+gAb0bl8UVJiAMrbxg1xN1L0iiR4QYa8J1V1063p
    ahYg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399113;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fhT7wAdCwpMivbtOdh7u7EIUcVxiuK8pSs+eAlKgGtk=;
    b=UTO53wt9M+7H9yxxfSvoQt/KPOxH5YFzV2h6NuzoKNPKYgzC7D75jxjEKhwm649YxD
    H0B6tYsExB9XnDh1j0dVN3lNaaiitmaNyIwY0MsX5v4FXENnr2f2kjh4Y0GMJNYQru0p
    ddYnFvUXTUpOq7PWAqJV5e2ULFHrxhhhH82q398097igbawKk6sl0ws1Ibga/SXUFItP
    6kb1c9J81lzH8E6cmLmg+UXhorPSQDb7HZs2ML8Hu4xcX6dpQHlZqSwjPL2DyqGPLYId
    YieCo1InSCT78p56PcYNVVAURgciX2VFQDhPY5STOao6DKbRm/Rpv8ABuPQ6f7LRnfTu
    mTjA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6PrPw="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5B8Bq02l
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 10:11:52 +0200 (CEST)
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
Subject: [PATCH v3 07/10] iio: accel: bmc150: Add device IDs for BMA253
Date:   Fri, 11 Jun 2021 10:09:00 +0200
Message-Id: <20210611080903.14384-8-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611080903.14384-1-stephan@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/Kconfig             | 2 +-
 drivers/iio/accel/bmc150-accel-core.c | 2 +-
 drivers/iio/accel/bmc150-accel-i2c.c  | 2 ++
 drivers/iio/accel/bmc150-accel-spi.c  | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index cbca6ab7da88..f8dc5403397d 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -143,7 +143,7 @@ config BMC150_ACCEL
 	select BMC150_ACCEL_SPI if SPI
 	help
 	  Say yes here to build support for the following Bosch accelerometers:
-	  BMA222, BMA222E, BMA250E, BMA255, BMA280, BMC150, BMI055.
+	  BMA222, BMA222E, BMA250E, BMA253, BMA255, BMA280, BMC150, BMI055.
 
 	  Note that some of these are combo modules:
 	    - BMC150: accelerometer and magnetometer
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 5a19676bcd2d..3faa3de0dd4d 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1125,7 +1125,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {306457, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	{
-		.name = "BMA255/BMC150/BMI055",
+		.name = "BMA253/BMA255/BMC150/BMI055",
 		.chip_id = 0xFA,
 		.channels = bmc150_accel_channels,
 		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 7db436ddbdce..32ed07354a9a 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -231,6 +231,7 @@ static const struct i2c_device_id bmc150_accel_id[] = {
 	{"bma222"},
 	{"bma222e"},
 	{"bma250e"},
+	{"bma253"},
 	{"bma255"},
 	{"bma280"},
 	{"bmc150_accel"},
@@ -244,6 +245,7 @@ static const struct of_device_id bmc150_accel_of_match[] = {
 	{ .compatible = "bosch,bma222" },
 	{ .compatible = "bosch,bma222e" },
 	{ .compatible = "bosch,bma250e" },
+	{ .compatible = "bosch,bma253" },
 	{ .compatible = "bosch,bma255" },
 	{ .compatible = "bosch,bma280" },
 	{ .compatible = "bosch,bmc150_accel" },
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index dc884fa18ad0..54b8c9c8068b 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -50,6 +50,7 @@ static const struct spi_device_id bmc150_accel_id[] = {
 	{"bma222"},
 	{"bma222e"},
 	{"bma250e"},
+	{"bma253"},
 	{"bma255"},
 	{"bma280"},
 	{"bmc150_accel"},
-- 
2.32.0

