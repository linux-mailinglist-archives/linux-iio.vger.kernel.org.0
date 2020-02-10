Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1A8E156D22
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 01:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgBJALV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Feb 2020 19:11:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33348 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgBJALV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Feb 2020 19:11:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so5130575lji.0
        for <linux-iio@vger.kernel.org>; Sun, 09 Feb 2020 16:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0hGLg10sw3tfhnGXdW8vPJAXdeVCHIZxLTswmosoEg=;
        b=JGd/3FRe4J8fIx2Jxj9scuk7rONDiLPT22EmyfwOVRR1+6oqPd8RR2fLXfhJcXun6t
         5gD86ZhmlrOG8DMlgo+gDOB856aXrOL/KRNp/UCEWngPLZdC5sORH/1RhKA/z6k22GsE
         W5I/H3KyJIOJMOiIjVqCfFTDL+LvI8pQoHtt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0hGLg10sw3tfhnGXdW8vPJAXdeVCHIZxLTswmosoEg=;
        b=uaNLGm0VyqVkP9tdeHPoTOQ5mVJqrRbpO5ilR3ydjgrB/CxppMkVm5Jcg6Nm9ENniH
         y1Og/sIwKM7oIzl9kfUo7ckjhMSyb82oOUxuQBqunwIeDRDZaqH/+g+SLnRjS5AeN6Am
         PM/aEoNgsYPHtdNgoZXajNywlwdw+Vn+xIakLTmKDxHkAAFPrcivtXK/w7WK1RvKCq93
         bNd3bnqw3mpBnWSwdbX4uNmbO1gfWtQJd8KESQmCWb9tlARrfgwn8voY+cPD/DW8EqDv
         zC+R01AuzvsR9HfEZa7Zdz33U9KE9CI2BWkvnxsHAZScvjsyxb0CYoIu0TlhGwFiM4XX
         kqGA==
X-Gm-Message-State: APjAAAX6ELA0BY+c7/1hkpuUVcAOJF+xBSj2u85cBGkmt2sLKtkw8SPb
        Vc2jqQNovThrpEPXpc2qlFaiPNEb/YkfOWH5
X-Google-Smtp-Source: APXvYqwnqP/1Uf+NOsiNoMJU1q2B6qQ8vgIjSqhbQ4CSDBXY/y6xuvdZ+aOTqltvuFDHC9NGiPXZyA==
X-Received: by 2002:a2e:9b03:: with SMTP id u3mr6161859lji.87.1581293476993;
        Sun, 09 Feb 2020 16:11:16 -0800 (PST)
Received: from virtualbox.ipredator.se (anon-49-135.vpn.ipredator.se. [46.246.49.135])
        by smtp.gmail.com with ESMTPSA id f5sm4424962lfh.32.2020.02.09.16.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:11:16 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v6 2/3] iio: chemical: atlas-sensor: add DO-SM module support
Date:   Sun,  9 Feb 2020 16:10:57 -0800
Message-Id: <20200210001058.7515-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210001058.7515-1-matt.ranostay@konsulko.com>
References: <20200210001058.7515-1-matt.ranostay@konsulko.com>
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
index 9a1ab9f8fcc5..363b33f3f43b 100644
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
@@ -121,7 +131,7 @@ static const struct iio_chan_spec atlas_ph_channels[] = {
 	},
 };
 
-#define ATLAS_EC_CHANNEL(_idx, _addr) \
+#define ATLAS_CONCENTRATION_CHANNEL(_idx, _addr) \
 	{\
 		.type = IIO_CONCENTRATION, \
 		.indexed = 1, \
@@ -152,8 +162,8 @@ static const struct iio_chan_spec atlas_ec_channels[] = {
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
@@ -182,6 +192,19 @@ static const struct iio_chan_spec atlas_orp_channels[] = {
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
@@ -262,7 +285,31 @@ static int atlas_check_orp_calibration(struct atlas_data *data)
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
@@ -295,6 +342,13 @@ static struct atlas_device atlas_devices[] = {
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
@@ -507,6 +561,7 @@ static const struct i2c_device_id atlas_id[] = {
 	{ "atlas-ph-sm", ATLAS_PH_SM},
 	{ "atlas-ec-sm", ATLAS_EC_SM},
 	{ "atlas-orp-sm", ATLAS_ORP_SM},
+	{ "atlas-do-sm", ATLAS_DO_SM},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, atlas_id);
@@ -515,6 +570,7 @@ static const struct of_device_id atlas_dt_ids[] = {
 	{ .compatible = "atlas,ph-sm", .data = (void *)ATLAS_PH_SM, },
 	{ .compatible = "atlas,ec-sm", .data = (void *)ATLAS_EC_SM, },
 	{ .compatible = "atlas,orp-sm", .data = (void *)ATLAS_ORP_SM, },
+	{ .compatible = "atlas,do-sm", .data = (void *)ATLAS_DO_SM, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, atlas_dt_ids);
-- 
2.20.1

