Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86A9B5286
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 18:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfIQQJm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 12:09:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49537 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfIQQJm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 12:09:42 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAG2i-0007j9-FW; Tue, 17 Sep 2019 18:09:28 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAG2g-0004VU-JQ; Tue, 17 Sep 2019 18:09:26 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     michael.hennerich@analog.com, lars@metafoo.de,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/3] iio: adc: ad799x: add pm_ops to disable the device completely
Date:   Tue, 17 Sep 2019 18:09:25 +0200
Message-Id: <20190917160925.9791-4-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917160925.9791-1-m.felsch@pengutronix.de>
References: <20190917160925.9791-1-m.felsch@pengutronix.de>
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
 drivers/iio/adc/ad799x.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index af5a2de9c22f..32d242ecb12c 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -875,6 +875,50 @@ static int ad799x_remove(struct i2c_client *client)
 	return 0;
 }
 
+static int __maybe_unused ad799x_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ad799x_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regulator_disable(st->vref);
+	if (ret) {
+		dev_err(dev, "Unable to disable vref regulator\n");
+		return ret;
+	}
+	ret = regulator_disable(st->reg);
+	if (ret) {
+		dev_err(dev, "Unable to disable vcc regulator\n");
+		return ret;
+	}
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
+		dev_err(dev, "Unable to enable vref regulator\n");
+		return ret;
+	}
+	/* resync config */
+	ad799x_update_config(st, st->config);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ad799x_pm_ops, ad799x_suspend, ad799x_resume);
+
 static const struct i2c_device_id ad799x_id[] = {
 	{ "ad7991", ad7991 },
 	{ "ad7995", ad7995 },
@@ -892,6 +936,7 @@ MODULE_DEVICE_TABLE(i2c, ad799x_id);
 static struct i2c_driver ad799x_driver = {
 	.driver = {
 		.name = "ad799x",
+		.pm = &ad799x_pm_ops,
 	},
 	.probe = ad799x_probe,
 	.remove = ad799x_remove,
-- 
2.20.1

