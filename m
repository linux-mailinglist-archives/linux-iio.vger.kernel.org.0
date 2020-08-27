Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF51254E70
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgH0T2z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0T2y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Aug 2020 15:28:54 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA93322CB3;
        Thu, 27 Aug 2020 19:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598556533;
        bh=Qo3LbyvmpBGQKG4D/yZypYAesoTm5jVx4P7R/QfNlcY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Y99Kjf7Xm6QCUzRr+BYYbALcmO7/pKGdLuCAx67ZeebvUt6o5F377GUttN3Tlbg0j
         5pKeKWTeBlR9BwzZLH4XLu9IYFs/wqq28tfWla5JkBdyT1xW/xwzWzrMQQGGhEBB8a
         zu8suWm3kKlzE9knlCQRuPK/tRbjK56uwxELPoRY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 13/18] iio: imu: inv_mpu6050: Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 21:26:37 +0200
Message-Id: <20200827192642.1725-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827192642.1725-1-krzk@kernel.org>
References: <20200827192642.1725-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 3fee3947f772..18a1898e3e34 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1475,22 +1475,14 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	}
 
 	st->vdd_supply = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(st->vdd_supply)) {
-		if (PTR_ERR(st->vdd_supply) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get vdd regulator %d\n",
-				(int)PTR_ERR(st->vdd_supply));
-
-		return PTR_ERR(st->vdd_supply);
-	}
+	if (IS_ERR(st->vdd_supply))
+		return dev_err_probe(dev, PTR_ERR(st->vdd_supply),
+				     "Failed to get vdd regulator\n");
 
 	st->vddio_supply = devm_regulator_get(dev, "vddio");
-	if (IS_ERR(st->vddio_supply)) {
-		if (PTR_ERR(st->vddio_supply) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get vddio regulator %d\n",
-				(int)PTR_ERR(st->vddio_supply));
-
-		return PTR_ERR(st->vddio_supply);
-	}
+	if (IS_ERR(st->vddio_supply))
+		return dev_err_probe(dev, PTR_ERR(st->vddio_supply),
+				     "Failed to get vddio regulator\n");
 
 	result = regulator_enable(st->vdd_supply);
 	if (result) {
-- 
2.17.1

