Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C6570721
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 19:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfGVR0S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 13:26:18 -0400
Received: from sauhun.de ([88.99.104.3]:42206 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731369AbfGVR0R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:17 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id B5F004A1497;
        Mon, 22 Jul 2019 19:26:15 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: pressure: hp03: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:13 +0200
Message-Id: <20190722172613.3890-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722172613.3890-1-wsa+renesas@sang-engineering.com>
References: <20190722172613.3890-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/iio/pressure/hp03.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
index f00102577fd5..026ba15ef68f 100644
--- a/drivers/iio/pressure/hp03.c
+++ b/drivers/iio/pressure/hp03.c
@@ -243,10 +243,10 @@ static int hp03_probe(struct i2c_client *client,
 	 * which has it's dedicated I2C address and contains
 	 * the calibration constants for the sensor.
 	 */
-	priv->eeprom_client = i2c_new_dummy(client->adapter, HP03_EEPROM_ADDR);
-	if (!priv->eeprom_client) {
+	priv->eeprom_client = i2c_new_dummy_device(client->adapter, HP03_EEPROM_ADDR);
+	if (IS_ERR(priv->eeprom_client)) {
 		dev_err(dev, "New EEPROM I2C device failed\n");
-		return -ENODEV;
+		return PTR_ERR(priv->eeprom_client);
 	}
 
 	priv->eeprom_regmap = regmap_init_i2c(priv->eeprom_client,
-- 
2.20.1

