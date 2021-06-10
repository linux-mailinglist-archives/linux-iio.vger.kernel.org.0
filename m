Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9013A2B6C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFJM0S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:26:18 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.175]:33204 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhFJM0P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:26:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623327849; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Nc7xTzU4f6vU7FjaLD0c5Xjf72E9RujPXyBumx2J1Jd2xIQwuQ8a+DQjGiirHSATzF
    gNVU4eMV8io0VzmdslcQC6CkZgEebbZyI7pHT5k1OYUnZQOVPzj+CLPCSIUF2fdyYQwT
    L+igcDMHOtYdIDglsGic5OuxV5eycdHMSNJ/hemjeiuV7iTu5/3ab2/bofqELGweUAoi
    CmXCelyMHs79GMK/E3mkHvDM505OHvhYUZbASlZ/CNJp8YvVDn50dSuDEizb3rnMdVkr
    toXvLYR+Bq2Ar7rLcS+dyTEKJitX+7Xw8WcHwNI9R1sVYgqV14dNt/JHoTBH0hoZxWcw
    F28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327849;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=aiTLXr6+ZboJpByh7I+hIxTMyKJ2BLZOGqmxqkTxqzA=;
    b=J2I6sdyk2tlhedrClpvamapxyvspVQRZy+mr9NSmU/0F8V6lh38aUdQsUXeSMWTxXN
    3+7W3zpIpQOoTlvr391ax5QRa7lQiVoXFhyP+0t01EeX2SJIzYmsT2DHQH8IGA8RhURI
    bADUNaIbUwPnKXyt1DrNbZfkOKRrbXn7Kiw08KEgm1HsM3y5bw3GawJYZGZdAVvVI1Y/
    tEho1CprptSVIdKRpqhPZDHpmyqFgjeqF0Il2uZEb+Dp42tbWvYkWkjX58OlY86zkO18
    mBfHFM2iRUzTX33/DsPVZnIwMzx9tvOXIlBmN1CC3RXmd+Jw8s8K5jmnUthO4/B9Uef9
    3JMQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327849;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=aiTLXr6+ZboJpByh7I+hIxTMyKJ2BLZOGqmxqkTxqzA=;
    b=A8/hmhMnZnXWVZQcRM07ib29mBZzAgx2gy1PO/Gum7YfRxKa9rNChII/bGVJXMO0bw
    AlMNJcdlNegxazwp4fUq2+odpzxdZ9WMJoluesT5qyXsZ7x+h9FU7TKcrWO+eCGW/Mii
    roKMmVQKr/nrymxDJ8P5K5SWhiyxOK3JPc1aHFroP7P4pxlGUsnGm5UeppmYTYl1lYfM
    IY/1IizMnjdZYn7ToIdgJVub88q7cM7o8+6wcb2AEZftJEQn7thbMGEVK9eDLvoXHc4H
    SNrbMwPHkF3P/WIIjAF497Pvt6PCQYSSb9e01c1UolygbGu8WDR4WCNsD+A51MnJD+ta
    q0mw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5ACO9tzy
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 14:24:09 +0200 (CEST)
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
Subject: [PATCH v2 6/9] iio: accel: bmc150: Add device IDs for BMA253
Date:   Thu, 10 Jun 2021 14:21:23 +0200
Message-Id: <20210610122126.50504-7-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610122126.50504-1-stephan@gerhold.net>
References: <20210610122126.50504-1-stephan@gerhold.net>
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
index 883aa8bc4340..1cc01b2c5c92 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -143,7 +143,7 @@ config BMC150_ACCEL
 	select BMC150_ACCEL_SPI if SPI
 	help
 	  Say yes here to build support for the following Bosch accelerometers:
-	  BMA222, BMA222E, BMA250E, BMA255, BMA280, BMC150, BMI055.
+	  BMA222, BMA222E, BMA250E, BMA253, BMA255, BMA280, BMC150, BMI055.
 
 	  BMC150 is a combo module with both accelerometer and magnetometer.
 	  This driver is only implementing accelerometer part, which has
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 1210a8b14a3c..ab41a8e18fa4 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1125,7 +1125,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {306457, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	{
-		.name = "BMC150/BMI055/BMA255",
+		.name = "BMC150/BMI055/BMA253/BMA255",
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

