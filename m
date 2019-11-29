Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E8810D8B5
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2019 17:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfK2Qx1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Nov 2019 11:53:27 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45063 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfK2Qx1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Nov 2019 11:53:27 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iajW9-0000cU-Va; Fri, 29 Nov 2019 17:53:17 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iajW8-0004ur-By; Fri, 29 Nov 2019 17:53:16 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     alexandru.Ardelean@analog.com, StefanSerban.Popa@analog.com,
        Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3] iio: adc: ad799x: add pm_ops to disable the device completely
Date:   Fri, 29 Nov 2019 17:53:14 +0100
Message-Id: <20191129165314.18829-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The device is always in a low-power state due to the hardware design. It
wakes up upon a conversion request and goes back into the low-power
state. The pm ops are added to disable the device completely and to free
the regulator. Disbaling the device completely should be not that
notable but freeing the regulator is important. Because if it is a shared
power-rail the regulator won't be disabled during suspend-to-ram/disk
and so all devices connected to that rail keeps on.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Hi,

this v3 contains the comments made on [1].

[1] https://www.spinics.net/lists/linux-iio/msg48135.html

Changelog:
v3:
- add resync error check during resume

v2:
- squash patch 2 & 3
- call regulator_disable() unconditional during suspend()
- drop dev_err() messages during suspend
- fix error path within resume()
---
 drivers/iio/adc/ad799x.c | 66 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index f658012baad8..ef013af1aec0 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -167,6 +167,21 @@ static int ad799x_read_config(struct ad799x_state *st)
 	}
 }
 
+static int ad799x_update_config(struct ad799x_state *st, u16 config)
+{
+	int ret;
+
+	ret = ad799x_write_config(st, config);
+	if (ret < 0)
+		return ret;
+	ret = ad799x_read_config(st);
+	if (ret < 0)
+		return ret;
+	st->config = ret;
+
+	return 0;
+}
+
 /**
  * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
  *
@@ -808,13 +823,9 @@ static int ad799x_probe(struct i2c_client *client,
 	indio_dev->channels = st->chip_config->channel;
 	indio_dev->num_channels = chip_info->num_channels;
 
-	ret = ad799x_write_config(st, st->chip_config->default_config);
-	if (ret < 0)
-		goto error_disable_vref;
-	ret = ad799x_read_config(st);
-	if (ret < 0)
+	ret = ad799x_update_config(st, st->chip_config->default_config);
+	if (ret)
 		goto error_disable_vref;
-	st->config = ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		&ad799x_trigger_handler, NULL);
@@ -864,6 +875,48 @@ static int ad799x_remove(struct i2c_client *client)
 	return 0;
 }
 
+static int __maybe_unused ad799x_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ad799x_state *st = iio_priv(indio_dev);
+
+	regulator_disable(st->vref);
+	regulator_disable(st->reg);
+
+	return 0;
+}
+
+static int __maybe_unused ad799x_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ad799x_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(dev, "Unable to enable vcc regulator\n");
+		return ret;
+	}
+	ret = regulator_enable(st->vref);
+	if (ret) {
+		regulator_disable(st->reg);
+		dev_err(dev, "Unable to enable vref regulator\n");
+		return ret;
+	}
+
+	/* resync config */
+	ret = ad799x_update_config(st, st->config);
+	if (ret) {
+		regulator_disable(st->vref);
+		regulator_disable(st->reg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ad799x_pm_ops, ad799x_suspend, ad799x_resume);
+
 static const struct i2c_device_id ad799x_id[] = {
 	{ "ad7991", ad7991 },
 	{ "ad7995", ad7995 },
@@ -881,6 +934,7 @@ MODULE_DEVICE_TABLE(i2c, ad799x_id);
 static struct i2c_driver ad799x_driver = {
 	.driver = {
 		.name = "ad799x",
+		.pm = &ad799x_pm_ops,
 	},
 	.probe = ad799x_probe,
 	.remove = ad799x_remove,
-- 
2.20.1

