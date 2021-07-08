Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E282C3BF7DC
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jul 2021 11:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhGHKCL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Jul 2021 06:02:11 -0400
Received: from aibo.runbox.com ([91.220.196.211]:33062 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231324AbhGHKCL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Jul 2021 06:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbx.email;
         s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
        bh=sX3qr2Vm8GAaJ2+VLtcLzuHYAmZWCfBOqIydL9l9cfk=; b=qZVXXV5ZbkDoOAifwi6jb9Qn5J
        ACQTAJHy7TAY0uNB+eLXDldbJsKCB6abZtoCzxzdAnhG4TQhI+ZkpmRc11X8p4vp3Q2Ab8gqtgRsY
        c6cKcGxEchMLi4e3OSsqpdLyCPptqSPPpvmDN820u1IFF7NvXfY6totXGMhyVH4lQeseVaxb0vr4a
        cTAEFCnxOcerYGqFYcLNvXENyPA/d0pxDXl3vmOL2+xMyiOVRRb3uATpTt9ImpOh2/dWT0NjuFLCa
        dVg6x89rIybkdqvwvVcSyw7SvCQTqC4WckZIRFU22YBQ/HlcO34wYhtMhwzBrkRa/XrikiyStT4PY
        SDJXPdHQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <detegr@rbx.email>)
        id 1m1QoY-0005Ds-Tw; Thu, 08 Jul 2021 11:59:27 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (932193)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1m1QoX-0007Nm-CZ; Thu, 08 Jul 2021 11:59:25 +0200
From:   =?UTF-8?q?Antti=20Ker=C3=A4nen?= <detegr@rbx.email>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Antti=20Ker=C3=A4nen?= <detegr@rbx.email>,
        Hannu Hartikainen <hannu@hrtk.in>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: adis: set GPIO reset pin direction
Date:   Thu,  8 Jul 2021 12:54:29 +0300
Message-Id: <20210708095425.13295-1-detegr@rbx.email>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <60e5ac8c.1c69fb81.c69f0.abab@mx.google.com>
References: <60e5ac8c.1c69fb81.c69f0.abab@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Set reset pin direction to output as the reset pin needs to be an active
low output pin.

Co-developed-by: Hannu Hartikainen <hannu@hrtk.in>
Signed-off-by: Hannu Hartikainen <hannu@hrtk.in>
Signed-off-by: Antti Keränen <detegr@rbx.email>
---
Removed unnecessary toggling of the pin as requested by Lars-Peter. I
missed out on the conversation, but I agree this is better.

 drivers/iio/imu/adis.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 319b64b2fd88..f8b7837d8b8f 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -415,12 +415,11 @@ int __adis_initial_startup(struct adis *adis)
 	int ret;
 
 	/* check if the device has rst pin low */
-	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset", GPIOD_ASIS);
+	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
 	if (gpio) {
-		gpiod_set_value_cansleep(gpio, 1);
 		msleep(10);
 		/* bring device out of reset */
 		gpiod_set_value_cansleep(gpio, 0);
-- 
2.32.0

