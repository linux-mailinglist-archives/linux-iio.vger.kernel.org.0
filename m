Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D66E187174
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 18:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbgCPRq3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 13:46:29 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:54132 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732228AbgCPRq2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 13:46:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5CED2FB06;
        Mon, 16 Mar 2020 18:46:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7xGcqZA3zAmj; Mon, 16 Mar 2020 18:46:23 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id E114041257; Mon, 16 Mar 2020 18:46:20 +0100 (CET)
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
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/4] iio: vcnl4000: Export near level property for proximity sensor
Date:   Mon, 16 Mar 2020 18:46:19 +0100
Message-Id: <5566fe01df933d3281f058666e2147cb97b38126.1584380360.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1584380360.git.agx@sigxcpu.org>
References: <cover.1584380360.git.agx@sigxcpu.org>
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
 drivers/iio/light/vcnl4000.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 38fcd9a26046..7111118e0fda 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -83,6 +83,7 @@ struct vcnl4000_data {
 	struct mutex vcnl4000_lock;
 	struct vcnl4200_channel vcnl4200_al;
 	struct vcnl4200_channel vcnl4200_ps;
+	uint32_t near_level;
 };
 
 struct vcnl4000_chip_spec {
@@ -342,6 +343,26 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 	},
 };
 
+
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
+		.name = "near_level",
+		.shared = IIO_SEPARATE,
+		.read = vcnl4000_read_near_level,
+	},
+	{ /* sentinel */ }
+};
+
 static const struct iio_chan_spec vcnl4000_channels[] = {
 	{
 		.type = IIO_LIGHT,
@@ -350,6 +371,7 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
 	}, {
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.ext_info = vcnl4000_ext_info,
 	}
 };
 
@@ -439,6 +461,10 @@ static int vcnl4000_probe(struct i2c_client *client,
 	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
 		data->chip_spec->prod, data->rev);
 
+	if (device_property_read_u32(&client->dev, "near-level",
+				     &data->near_level) < 0)
+		data->near_level = 0;
+
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &vcnl4000_info;
 	indio_dev->channels = vcnl4000_channels;
-- 
2.23.0

