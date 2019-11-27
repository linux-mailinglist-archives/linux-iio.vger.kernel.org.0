Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3164910B74C
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2019 21:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfK0URo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Nov 2019 15:17:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45742 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfK0URo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Nov 2019 15:17:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so25848920ljg.12
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2019 12:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k7EgH1pdI7jiOb43l2KChL8XU/OVJ0pFPhB2iwUohFg=;
        b=EWQYkDHmn8fNr62XU5plvV5eunttbqwO3NeWipNR4dfvIcX4Vsa18AuxeioF/aPOYr
         uOYU8t7uJIT+Co+ziykArSZMe6tplXgRosEWq/a2OHrmxMPrXJWTCI1G8rwLnqa+pG8C
         zkPCF/hcwKZKwIL18R5y7hX2MWJ1Kqaun+HSMWHl0pyWsD+x3+6du6EFbKdzJ4Kjt/H/
         V/8eMQ5yRbfvQhSbHh8oNk/mpnuRS6V36LPAc9gvc4cAlSOUJDs9KudPJxJzZ8bWtorq
         ZD3OOh/UXl+e125CjnsJbUv/pmL6aRvQKSPcROCOxsZP7ezN/hr1Fw8gqVjjjg/UVRvH
         wJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k7EgH1pdI7jiOb43l2KChL8XU/OVJ0pFPhB2iwUohFg=;
        b=LIm4inZW9Rf8ICRN0ltoWC3L60E+obCJEHzhvZuPtm6PQP6I8/ZVBZR9QIuuPEudM1
         2ZFDwi+fdxn4JsoFWLQu98nBRlnQmvmdHfSCy3Cb7MxRMxGEJseWO2LnYOXsQj0C9GD9
         KZNDNWjUxbycJmZfTXqkzfeVfNOmRPpx6Ve7haYxhI17qFFEtj6T2rmf/AhmQ0iTLKeS
         DcQ9Vy7qa9QSwZyIQf7VzxqnEDIuEBv0ntAkfqcv5VccryFrOwZULwEtP74U6iC5VwUv
         hG3nrrLjEQo0tDGkWf1p3Hdy7sAlWJIY832XuJm9DPaa+PETckxBRgic3drAlc6NQCea
         r7Iw==
X-Gm-Message-State: APjAAAWPr/T/RgflxLz9L2hFuAQ+6Ypf+8CXiuaBbGjSz2yoflxr60JO
        HtUZzZyDS20SLlFJwPUAp+wv2w==
X-Google-Smtp-Source: APXvYqyxx1RbDHxOjasS+gZ3VKMG8OBS3kDNKTGpB6dSy729EJVacBGbZFZQjgMJkER/fbfr8vF8zQ==
X-Received: by 2002:a05:651c:299:: with SMTP id b25mr32310330ljo.195.1574885861345;
        Wed, 27 Nov 2019 12:17:41 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-21cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.33])
        by smtp.gmail.com with ESMTPSA id a8sm7620844ljb.11.2019.11.27.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 12:17:40 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2] iio: imu: inv_mpu6050: Select I2C_MUX again
Date:   Wed, 27 Nov 2019 21:17:38 +0100
Message-Id: <20191127201738.1234-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

commit f7072198f217 ("iio: imu: Fix inv_mpu6050 dependencies")
undid the explicit selection of I2C_MUX previously
done by the driver, because I2C_MUX implicitly depended
on HAS_IOMEM.

However commit 93d710a65ef0 ("i2c: mux: fix up dependencies")
cleared up the situation properly and drivers that need
to select I2C_MUX can now do so again.

It makes a lot of sense for a driver to select the driver
infrastructure it needs so restore the natural order of
things.

Cc: Richard Weinberger <richard@nod.at>
Cc: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Depend on I2C instead of I2C_MUX, it's necessary to
  at least have the I2C infrastructure...
---
 drivers/iio/imu/inv_mpu6050/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index e4c4c12236a7..d9dba6b8abf6 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -10,7 +10,8 @@ config INV_MPU6050_IIO
 
 config INV_MPU6050_I2C
 	tristate "Invensense MPU6050 devices (I2C)"
-	depends on I2C_MUX
+	depends on I2C
+	select I2C_MUX
 	select INV_MPU6050_IIO
 	select REGMAP_I2C
 	help
-- 
2.21.0

