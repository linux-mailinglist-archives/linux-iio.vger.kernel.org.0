Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF83A9D95
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 16:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhFPObK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 10:31:10 -0400
Received: from aibo.runbox.com ([91.220.196.211]:53210 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232408AbhFPObK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 10:31:10 -0400
X-Greylist: delayed 3636 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jun 2021 10:31:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbx.email;
         s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From;
        bh=oBkW26nHbIAk/9SaFxkSIezH97IsiGDnuTBNiewivCQ=; b=r7hhtn8j+tBKG1wkOqD/5V3S/i
        IZ7aAQOMjOs5GiNzpIRKT34ohay5WUyB8gBna9GEemcddYgRzcj76K1V+HVM2WQl0zgTKl7GJ+2lo
        XlfXpEaZz+WmIN1De9rHQU9d0EMUdFjC46NeO87f6LJ4rg6xnMpfJl9lhAuXrzQBrlPXdM3ciw3GN
        XjIQ17yQaUe/06nVa/QKWI6mKtZrcnD99EoqKo64ip6XKlkuBjxniokzFqk0FGgngyulcashyNo3a
        PAb81jO8HpDqKUUGTMQYepwrz6ZJq6i/tz/KhTZ4WGiS58nWrC0rV+R+Klp8smelR7jRP0X+HuqqQ
        K+GfD7ng==;
Received: from [10.9.9.72] (helo=submission01.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <detegr@rbx.email>)
        id 1ltVaj-0005ao-HH; Wed, 16 Jun 2021 15:28:25 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated alias (932193)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1ltVaM-0003oX-GH; Wed, 16 Jun 2021 15:28:02 +0200
From:   =?UTF-8?q?Antti=20Ker=C3=A4nen?= <detegr@rbx.email>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Antti=20Ker=C3=A4nen?= <detegr@rbx.email>,
        Hannu Hartikainen <hannu@hrtk.in>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: adis: set GPIO reset pin direction
Date:   Wed, 16 Jun 2021 16:25:13 +0300
Message-Id: <20210616132512.634123-1-detegr@rbx.email>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use GPIOD_OUT_LOW instead of GPIOD_ASIS as the reset pin needs to be an
active low output pin.

Suggested-by: Hannu Hartikainen <hannu@hrtk.in>
Signed-off-by: Antti Keränen <detegr@rbx.email>
---
The documentation of GPIO consumer interface states:

Be aware that there is no default direction for GPIOs. Therefore,
**using a GPIO without setting its direction first is illegal and will
result in undefined behavior!**

Therefore the direction of the reset GPIO pin should be set as output.

 drivers/iio/imu/adis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 319b64b2fd88..7f13b3763732 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -415,7 +415,7 @@ int __adis_initial_startup(struct adis *adis)
 	int ret;
 
 	/* check if the device has rst pin low */
-	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset", GPIOD_ASIS);
+	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
-- 
2.31.1

