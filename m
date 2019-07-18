Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 542CF6D6F7
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 00:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391318AbfGRWyo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 18:54:44 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19122 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728157AbfGRWyn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 18:54:43 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IMpdDP000798;
        Fri, 19 Jul 2019 00:54:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=TAKhK57YEVfQaySPa7Z6bNxY/RPPIVyCrG3PGbQ2mxM=;
 b=EsvcLE4rWhmw96bxPo8B+7lZBfYO0zfn++hWnACNB5Mbh9CuuQuRdSnc4FpeN112mlfL
 /9f6oOZNmuZNzgX/h2at5JUPS6DKlHca6lyIlG7FJ4Irsn9+b3+486UrAu9raiA2Yfne
 kWqGr5RjWUIhsrWYq5xjbCVC8K+/I72Id0W7nOPKPAFQ9RYm+WjJa5m3XAIY7tpt35+d
 T/ag93ut6aghgUpkaDjbGYmhadChgeZ8XP1FFQKzA49h472lNpTl6fZA2zrosiJ0EBZ1
 VutoRHKkgAMuuHfXIX7ymKidO2ZPWqN4m3LlZWGUB0NPazTS9IL4CrGdv0rr7+sWSEwN Jw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tsdepr8x1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Jul 2019 00:54:38 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D2D2C31;
        Thu, 18 Jul 2019 22:54:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BC7D210A4;
        Thu, 18 Jul 2019 22:54:37 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 19 Jul 2019 00:54:36
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <denis.ciocca@st.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v2 06/11] iio:accel: device settings are set immediately during probe
Date:   Thu, 18 Jul 2019 15:53:48 -0700
Message-ID: <20190718225353.2078-7-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718225353.2078-1-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_12:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch set accel settings right after probe start. This is
done in preparation of regmap that needs different configuration
based on multiread bit value.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
Changes in v2:
 not there in v1.

 drivers/iio/accel/st_accel_i2c.c | 19 ++++++++++++++-----
 drivers/iio/accel/st_accel_spi.c | 16 +++++++++++++---
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index c3c8f2e73c2a..a92cf776031e 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -150,20 +150,29 @@ MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
 
 static int st_accel_i2c_probe(struct i2c_client *client)
 {
-	struct iio_dev *indio_dev;
+	const struct st_sensor_settings *settings;
 	struct st_sensor_data *adata;
+	struct iio_dev *indio_dev;
 	const char *match;
 	int ret;
 
+	match = device_get_match_data(&client->dev);
+	if (match)
+		strlcpy(client->name, match, sizeof(client->name));
+
+	settings = st_accel_get_settings(client->name);
+	if (!settings) {
+		dev_err(&client->dev, "device name %s not recognized.\n",
+			client->name);
+		return -ENODEV;
+	}
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adata));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	adata = iio_priv(indio_dev);
-
-	match = device_get_match_data(&client->dev);
-	if (match)
-		strlcpy(client->name, match, sizeof(client->name));
+	adata->sensor_settings = (struct st_sensor_settings *)settings;
 
 	st_sensors_i2c_configure(indio_dev, client, adata);
 
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 474742e35d92..c0556db9d60a 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -102,18 +102,28 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
 
 static int st_accel_spi_probe(struct spi_device *spi)
 {
-	struct iio_dev *indio_dev;
+	const struct st_sensor_settings *settings;
 	struct st_sensor_data *adata;
+	struct iio_dev *indio_dev;
 	int err;
 
+	st_sensors_of_name_probe(&spi->dev, st_accel_of_match,
+				 spi->modalias, sizeof(spi->modalias));
+
+	settings = st_accel_get_settings(spi->modalias);
+	if (!settings) {
+		dev_err(&spi->dev, "device name %s not recognized.\n",
+			spi->modalias);
+		return -ENODEV;
+	}
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adata));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	adata = iio_priv(indio_dev);
+	adata->sensor_settings = (struct st_sensor_settings *)settings;
 
-	st_sensors_of_name_probe(&spi->dev, st_accel_of_match,
-				 spi->modalias, sizeof(spi->modalias));
 	st_sensors_spi_configure(indio_dev, spi, adata);
 
 	err = st_accel_common_probe(indio_dev);
-- 
2.22.0

