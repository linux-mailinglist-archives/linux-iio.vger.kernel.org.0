Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816F92CB8FF
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 10:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbgLBJgi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 04:36:38 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:27568 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387860AbgLBJgi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 04:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606901625;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=1ePQH0/RVXsCzCLZhCC6D/7gY6cMj/NHBqH3xq8ktbo=;
        b=r8QPmuuFG4O2MMaQZrMUN6EXRUZwZH6j5XcBnIHApuZ7w+Ntd0p+7Gk110FNHxgZdA
        mFz9yQPf9QDCofOkQ+KmyKFWFniGfGdnnldDTk8WEAu4T44OPCNvSYk4JgHnwjRingAx
        zOvemTnVVjk9BuN3xdCY59nOhlivqXpnscXs4aiIXLN+ka1e+9MXJtUBkidMTHiHmEwr
        siTDOiPovI58F55u7l8qg1c7/BWOR2z6EhF4JEIHgOugLTw5+Ii0Gfer2Jzw0Wohl1Ho
        Q+65F75t1udN3dNQ0f4MCmgcYnZrzLjJ12L+d1GsN5v926aRtd62YYzDZAUD5XkXcKfc
        EM8w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB626NJkxR"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 47.3.4 SBL|AUTH)
        with ESMTPSA id Z061efwB29XcVub
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 10:33:38 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/4] iio: magnetometer: bmc150: Add rudimentary regulator support
Date:   Wed,  2 Dec 2020 10:33:20 +0100
Message-Id: <20201202093322.77114-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202093322.77114-1-stephan@gerhold.net>
References: <20201202093322.77114-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMC150 needs VDD and VDDIO regulators that might need to be explicitly
enabled. Add some rudimentary support to obtain and enable these
regulators during probe() and disable them during remove()
or on the error path.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
This is mostly copy-paste of
079c1c3f2082 ("iio: accel: bmc150-accel: Add rudimentary regulator support")
from Linus Walleij but for the BMC150 magnetometer driver.
---
 drivers/iio/magnetometer/bmc150_magn.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index fa09fcab620a..b2f3129e1b4f 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -25,6 +25,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include "bmc150_magn.h"
 
@@ -135,6 +136,7 @@ struct bmc150_magn_data {
 	 */
 	struct mutex mutex;
 	struct regmap *regmap;
+	struct regulator_bulk_data regulators[2];
 	struct iio_mount_matrix orientation;
 	/* 4 x 32 bits for x, y z, 4 bytes align, 64 bits timestamp */
 	s32 buffer[6];
@@ -692,12 +694,24 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 	int ret, chip_id;
 	struct bmc150_magn_preset preset;
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				    data->regulators);
+	if (ret < 0) {
+		dev_err(data->dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+	/*
+	 * 3ms power-on time according to datasheet, let's better
+	 * be safe than sorry and set this delay to 5ms.
+	 */
+	msleep(5);
+
 	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND,
 					 false);
 	if (ret < 0) {
 		dev_err(data->dev,
 			"Failed to bring up device from suspend mode\n");
-		return ret;
+		goto err_regulator_disable;
 	}
 
 	ret = regmap_read(data->regmap, BMC150_MAGN_REG_CHIP_ID, &chip_id);
@@ -752,6 +766,8 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 
 err_poweroff:
 	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
+err_regulator_disable:
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 	return ret;
 }
 
@@ -867,6 +883,13 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 	data->irq = irq;
 	data->dev = dev;
 
+	data->regulators[0].supply = "vdd";
+	data->regulators[1].supply = "vddio";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators),
+				      data->regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
+
 	ret = iio_read_mount_matrix(dev, "mount-matrix",
 				&data->orientation);
 	if (ret)
@@ -984,6 +1007,7 @@ int bmc150_magn_remove(struct device *dev)
 	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
 	mutex_unlock(&data->mutex);
 
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 	return 0;
 }
 EXPORT_SYMBOL(bmc150_magn_remove);
-- 
2.29.2

