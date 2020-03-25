Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5391926D4
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 12:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCYLJY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 07:09:24 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:37706 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgCYLJP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 25 Mar 2020 07:09:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 14FEAFB04;
        Wed, 25 Mar 2020 12:09:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hVX3jahIkFCv; Wed, 25 Mar 2020 12:09:11 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 711F0401F8; Wed, 25 Mar 2020 12:09:08 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v3 3/4] iio: vcnl4000: Export near level property for proximity sensor
Date:   Wed, 25 Mar 2020 12:09:07 +0100
Message-Id: <af2ce35478a5720e5325645b334f61d3c745fadd.1585134362.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1585134362.git.agx@sigxcpu.org>
References: <cover.1585134362.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When an object can be considered close to the sensor is hardware
dependent. Allowing to configure the property via device tree
allows to configure this device specific value.

This is useful for e.g. iio-sensor-proxy to indicate to userspace
if an object is close to the sensor.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/iio/light/vcnl4000.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index ec803c1e81df..a4bac101549e 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -83,6 +83,7 @@ struct vcnl4000_data {
 	struct mutex vcnl4000_lock;
 	struct vcnl4200_channel vcnl4200_al;
 	struct vcnl4200_channel vcnl4200_ps;
+	uint32_t near_level;
 };
 
 struct vcnl4000_chip_spec {
@@ -343,6 +344,25 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 	},
 };
 
+static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
+					uintptr_t priv,
+					const struct iio_chan_spec *chan,
+					char *buf)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%u\n", data->near_level);
+}
+
+static const struct iio_chan_spec_ext_info vcnl4000_ext_info[] = {
+	{
+		.name = "nearlevel",
+		.shared = IIO_SEPARATE,
+		.read = vcnl4000_read_near_level,
+	},
+	{ /* sentinel */ }
+};
+
 static const struct iio_chan_spec vcnl4000_channels[] = {
 	{
 		.type = IIO_LIGHT,
@@ -351,6 +371,7 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
 	}, {
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.ext_info = vcnl4000_ext_info,
 	}
 };
 
@@ -440,6 +461,10 @@ static int vcnl4000_probe(struct i2c_client *client,
 	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
 		data->chip_spec->prod, data->rev);
 
+	if (device_property_read_u32(&client->dev, "near-level",
+				     &data->near_level))
+		data->near_level = 0;
+
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &vcnl4000_info;
 	indio_dev->channels = vcnl4000_channels;
-- 
2.23.0

