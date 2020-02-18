Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0673D161F9E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 04:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgBRDm5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Feb 2020 22:42:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39067 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgBRDm5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Feb 2020 22:42:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so22121472wrt.6
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2020 19:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+r5+hfAE/Awbo6XNd+zhGvtwDw2C94kbs2Y5SVU2+8=;
        b=r6cHQ/WJSUUor1OynauuikEfFtk6Nm7CGvrlgeEBWcP7V/qaVklQbGFVUwyvr0Lk+V
         l/mihMSwCr0WtSGffzX9jxF7Hlr6VfEnysXpkNsZeDBNLAW5/rMdu8abFNl2cEXy5FHN
         OdcKTX0eU9s1U2Ed0kOvceQtZYVVqchOpxITc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+r5+hfAE/Awbo6XNd+zhGvtwDw2C94kbs2Y5SVU2+8=;
        b=HE7N15UpPavxO4l6a7l3Qs6pmHpWNX5Sa6QDuBST5UWbN1ahvQyWHFk5rpHPeKGP5f
         oLX3PgI443d1AL2knvijn70D2oJZKBW1pccATPaunl994jrpzctHtlY32DUIeJRk8J1A
         QuAYj9yYVc4+qycn5jFLPMNlXyCEw6I96+rHHzw62emBq6mtDNBhqD23l77ZOdnHWXBg
         KSkSYskyHUYokK7PAauE+FAYLMZujN8MW1ZXVHHVScx6ZULWfpdPRnkSDDjlfHO42Xjs
         EfryYTCu+i6vqnbd5ZKAJMiMnnxCH2c3ujqqNAnH81wnqdxWX5Us30YNGAPLDIQb0v1O
         qFog==
X-Gm-Message-State: APjAAAV/RQ1FyZ894HIJgAQAqa+TJg4IFtHdMRHzCWGlRthmQLDdHrXb
        aYtJmkCQIeBi+YUjg/cy3WdkFHbjkwa5X+ch
X-Google-Smtp-Source: APXvYqzpLS6F9fbSUbTyRC8ej9Ch3ZuVuP2mFFMYixmAKijc+bposck5rob0qaOT/G5xN8sPMeKUOw==
X-Received: by 2002:adf:f54d:: with SMTP id j13mr25764403wrp.19.1581997373060;
        Mon, 17 Feb 2020 19:42:53 -0800 (PST)
Received: from virtualbox.ipredator.se (anon-49-213.vpn.ipredator.se. [46.246.49.213])
        by smtp.gmail.com with ESMTPSA id s22sm1816901wmh.4.2020.02.17.19.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 19:42:52 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v7 2/3] iio: chemical: atlas-sensor: add DO-SM module support
Date:   Mon, 17 Feb 2020 19:42:38 -0800
Message-Id: <20200218034239.135619-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218034239.135619-1-matt.ranostay@konsulko.com>
References: <20200218034239.135619-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Atlas Scientific DO-SM OEM sensor reads disolved oxygen in
a solution. This is reported back as mg/L which maps directly
to ppm and so the IIO_CONCENTRATION channel type can be used.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-sensor.c | 64 +++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index d95818b74770..82d470561ad3 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -48,6 +48,11 @@
 #define ATLAS_REG_EC_CALIB_STATUS_LOW		BIT(2)
 #define ATLAS_REG_EC_CALIB_STATUS_HIGH		BIT(3)
 
+#define ATLAS_REG_DO_CALIB_STATUS		0x09
+#define ATLAS_REG_DO_CALIB_STATUS_MASK		0x03
+#define ATLAS_REG_DO_CALIB_STATUS_PRESSURE	BIT(0)
+#define ATLAS_REG_DO_CALIB_STATUS_DO		BIT(1)
+
 #define ATLAS_REG_PH_TEMP_DATA		0x0e
 #define ATLAS_REG_PH_DATA		0x16
 
@@ -60,14 +65,19 @@
 #define ATLAS_REG_ORP_CALIB_STATUS	0x0d
 #define ATLAS_REG_ORP_DATA		0x0e
 
+#define ATLAS_REG_DO_TEMP_DATA		0x12
+#define ATLAS_REG_DO_DATA		0x22
+
 #define ATLAS_PH_INT_TIME_IN_MS		450
 #define ATLAS_EC_INT_TIME_IN_MS		650
 #define ATLAS_ORP_INT_TIME_IN_MS	450
+#define ATLAS_DO_INT_TIME_IN_MS		450
 
 enum {
 	ATLAS_PH_SM,
 	ATLAS_EC_SM,
 	ATLAS_ORP_SM,
+	ATLAS_DO_SM,
 };
 
 struct atlas_data {
@@ -122,7 +132,7 @@ static const struct iio_chan_spec atlas_ph_channels[] = {
 	},
 };
 
-#define ATLAS_EC_CHANNEL(_idx, _addr) \
+#define ATLAS_CONCENTRATION_CHANNEL(_idx, _addr) \
 	{\
 		.type = IIO_CONCENTRATION, \
 		.indexed = 1, \
@@ -153,8 +163,8 @@ static const struct iio_chan_spec atlas_ec_channels[] = {
 			.endianness = IIO_BE,
 		},
 	},
-	ATLAS_EC_CHANNEL(0, ATLAS_REG_TDS_DATA),
-	ATLAS_EC_CHANNEL(1, ATLAS_REG_PSS_DATA),
+	ATLAS_CONCENTRATION_CHANNEL(0, ATLAS_REG_TDS_DATA),
+	ATLAS_CONCENTRATION_CHANNEL(1, ATLAS_REG_PSS_DATA),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 	{
 		.type = IIO_TEMP,
@@ -183,6 +193,19 @@ static const struct iio_chan_spec atlas_orp_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
+static const struct iio_chan_spec atlas_do_channels[] = {
+	ATLAS_CONCENTRATION_CHANNEL(0, ATLAS_REG_DO_DATA),
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+	{
+		.type = IIO_TEMP,
+		.address = ATLAS_REG_DO_TEMP_DATA,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.output = 1,
+		.scan_index = -1
+	},
+};
+
 static int atlas_check_ph_calibration(struct atlas_data *data)
 {
 	struct device *dev = &data->client->dev;
@@ -263,7 +286,31 @@ static int atlas_check_orp_calibration(struct atlas_data *data)
 		dev_warn(dev, "device has not been calibrated\n");
 
 	return 0;
-};
+}
+
+static int atlas_check_do_calibration(struct atlas_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(data->regmap, ATLAS_REG_DO_CALIB_STATUS, &val);
+	if (ret)
+		return ret;
+
+	if (!(val & ATLAS_REG_DO_CALIB_STATUS_MASK)) {
+		dev_warn(dev, "device has not been calibrated\n");
+		return 0;
+	}
+
+	if (!(val & ATLAS_REG_DO_CALIB_STATUS_PRESSURE))
+		dev_warn(dev, "device missing atmospheric pressure calibration\n");
+
+	if (!(val & ATLAS_REG_DO_CALIB_STATUS_DO))
+		dev_warn(dev, "device missing dissolved oxygen calibration\n");
+
+	return 0;
+}
 
 struct atlas_device {
 	const struct iio_chan_spec *channels;
@@ -296,6 +343,13 @@ static struct atlas_device atlas_devices[] = {
 				.calibration = &atlas_check_orp_calibration,
 				.delay = ATLAS_ORP_INT_TIME_IN_MS,
 	},
+	[ATLAS_DO_SM] = {
+				.channels = atlas_do_channels,
+				.num_channels = 3,
+				.data_reg = ATLAS_REG_DO_DATA,
+				.calibration = &atlas_check_do_calibration,
+				.delay = ATLAS_DO_INT_TIME_IN_MS,
+	},
 };
 
 static int atlas_set_powermode(struct atlas_data *data, int on)
@@ -511,6 +565,7 @@ static const struct i2c_device_id atlas_id[] = {
 	{ "atlas-ph-sm", ATLAS_PH_SM},
 	{ "atlas-ec-sm", ATLAS_EC_SM},
 	{ "atlas-orp-sm", ATLAS_ORP_SM},
+	{ "atlas-do-sm", ATLAS_DO_SM},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, atlas_id);
@@ -519,6 +574,7 @@ static const struct of_device_id atlas_dt_ids[] = {
 	{ .compatible = "atlas,ph-sm", .data = (void *)ATLAS_PH_SM, },
 	{ .compatible = "atlas,ec-sm", .data = (void *)ATLAS_EC_SM, },
 	{ .compatible = "atlas,orp-sm", .data = (void *)ATLAS_ORP_SM, },
+	{ .compatible = "atlas,do-sm", .data = (void *)ATLAS_DO_SM, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, atlas_dt_ids);
-- 
2.25.0

