Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2443BC881
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 11:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhGFJcJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 05:32:09 -0400
Received: from aibo.runbox.com ([91.220.196.211]:41692 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhGFJcI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Jul 2021 05:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbx.email;
         s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date;
        bh=oBkW26nHbIAk/9SaFxkSIezH97IsiGDnuTBNiewivCQ=; b=InTZT3z7FWnLU2BU1pCweAivAB
        bDcYbRosMDdgX/XlRA+pmEwByGdEr9Z2NLqeCEou/7KlaFSz9yuZddawYiKYstxmgGIOzG00AxCBr
        pnTvs7iOY0c/1wQFmu1OS6oheUVFfTyVHoFqVJisQmE+ugeH2Aoc/auE0vhf5KrHeaoOYtgKAy9ME
        uLh3qU5kkMn+PfrCGu+mANhRzATLcXlmoTtuWMH3IiaZKR+9rLCyYm6WbL7Q3in3JoMnsptN5kE2N
        9NE6y2SV55mNDBOzXmMZD03/MMI7/8VWQU7EDBZce4e9aYOhk9kpEaDpcsN/tWBd9cwiCOUYpvZUD
        kmvTL5gg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <detegr@rbx.email>)
        id 1m0hOR-0002AA-PZ; Tue, 06 Jul 2021 11:29:27 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (932193)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1m0hON-0007sM-U4; Tue, 06 Jul 2021 11:29:24 +0200
Date:   Tue, 6 Jul 2021 12:29:22 +0300
From:   Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>
To:     linux-iio@vger.kernel.org
Cc:     Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>,
        Hannu Hartikainen <hannu@hrtk.in>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [RESEND PATCH] iio: adis: set GPIO reset pin direction
Message-ID: <20210706092922.v555jjvxbyv52ifw@haukka.localdomain>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

