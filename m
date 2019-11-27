Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B046710B73E
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2019 21:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfK0UNE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Nov 2019 15:13:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44582 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfK0UNE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Nov 2019 15:13:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id v201so17141520lfa.11
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2019 12:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qkKvmR1lvRVaQVqTNCUXKdGkBLLOZ/vX1xMimv9EXuY=;
        b=Xbp95GxDVlne8OITRvbPQ3kCbxOU2I0yTT/idQktls7K1HAx58VfdLUeyWYPV1j4pU
         HcrdbIqUNcsXHgyVVUVU8DbU0ShZ/l0hqjTdovRNBPEJfGq9Sna9USKaQ437vJYrwvik
         t8xCXzkSToTouaCBv3hGJs0Tt7rkvvVJ4efN4VpBLajocRuJGkk+ugfiNxO+ZfJ0H6KC
         Twhr2X7zllNzpoT1bZU/8/n7rEpiq3c7YH/ATKzXEltqBZ/S7V4wE5EX7bKHpazhB8IH
         DSK+pFTTPbdb3pLFqDn1LhEbLWuIaR4IGnk8nLbxt7tYPtK/pXYanyEkCU2v5zffpZEP
         fX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qkKvmR1lvRVaQVqTNCUXKdGkBLLOZ/vX1xMimv9EXuY=;
        b=cIPm4h/sigMx5h2v1/AkRL9oGQ6OTlR/KE0uKn77PJIVegbOb2CzCVQpwklGg9AdfN
         Y6v4jVLIV8qRO49Wvd6rwe3MhPDjbPoremZOBqJUDf329MpYatH/pDoi4B4EMCE/H3nl
         wuzZ2H7ehj/kcA8qDxEgWGeX//8Fo/Z+CQ2fybP6VhRE5wX5+SUK1YTZBP0IsIJ99g40
         c5M490NXHFqPzyxAY63cYq7KdcXNcoDsfjHarWqKNW/jkrptV+M1kj+w88we38fzShir
         3BrbTurp5H5ZW+AGT3w3XefVVEqtO4AoWj3l38YwMmcl9PuTJCSuHyvGXS872GCy7zZE
         dmfQ==
X-Gm-Message-State: APjAAAVifMrCmiqGCuTWZKajk37WKmH10MNqp9YHcDswBwqC7hxuBzTe
        +wvOo79RZHIg88jFzrI2UdcrRQ3yMK/6iA==
X-Google-Smtp-Source: APXvYqw93456acjpsdtbj/wA5/RBDpHgyCtt3+LlNGtEk0yJ/xoNJRum9filLELGjpUB95uWVRjWKA==
X-Received: by 2002:a19:e343:: with SMTP id c3mr4252283lfk.192.1574885581733;
        Wed, 27 Nov 2019 12:13:01 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-21cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.33])
        by smtp.gmail.com with ESMTPSA id c20sm2277132ljj.55.2019.11.27.12.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 12:13:00 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] iio: imu: inv_mpu6050: Select I2C_MUX again
Date:   Wed, 27 Nov 2019 21:12:56 +0100
Message-Id: <20191127201256.716-1-linus.walleij@linaro.org>
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
 drivers/iio/imu/inv_mpu6050/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index e4c4c12236a7..ce40d73ec09c 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -10,7 +10,7 @@ config INV_MPU6050_IIO
 
 config INV_MPU6050_I2C
 	tristate "Invensense MPU6050 devices (I2C)"
-	depends on I2C_MUX
+	select I2C_MUX
 	select INV_MPU6050_IIO
 	select REGMAP_I2C
 	help
-- 
2.21.0

