Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8CE76D6F8
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 00:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfGRWyq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 18:54:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33704 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728139AbfGRWyp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 18:54:45 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IMkxUR008016;
        Fri, 19 Jul 2019 00:54:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=IYVoBhs2EVsmX5p8pytQyzJyIYb3t3KqBJRnurGufE8=;
 b=jY3GmfoPoBZK4kJFOK67FUpe3lalymMJrfo39dAC1L0dgn4I6vFBL6TSQoOWkY3XVwd5
 OqKQ8LXxArfB1V+naVN4MfRciXElcm7EwJ/eLaX18zC4yoABv3y6VRC7PzAArMCyspAv
 mHS8bbZAsWqIbZa2cHBEMu0QUK+0RENtauCE5lC1oAe++iqQ1TjfPEoaREx0useYJs4q
 sK3xWsl1ku31Lk572Z5YVBfEq625mhwbYMCD6gh32V9jE73uGmswxUsRWkrsCLGjjnsP
 LtjY6+fgUWNWsaKOG9r0cHFQ5y+fZDmoTghvSwws1FWpwgG5VhJXR6tgW2A36pUhgqBC fQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tq66hmuq8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Jul 2019 00:54:41 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8628834;
        Thu, 18 Jul 2019 22:54:40 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 734D910A4;
        Thu, 18 Jul 2019 22:54:40 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 19 Jul 2019 00:54:39
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <denis.ciocca@st.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v2 07/11] iio:gyro: device settings are set immediately during probe
Date:   Thu, 18 Jul 2019 15:53:49 -0700
Message-ID: <20190718225353.2078-8-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718225353.2078-1-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_12:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch set gyro settings right after probe start. This is
done in preparation of regmap that needs different configuration
based on multiread bit value.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
Changes in v2:
 not there in v1.

 drivers/iio/gyro/st_gyro_i2c.c | 18 ++++++++++++++----
 drivers/iio/gyro/st_gyro_spi.c | 16 +++++++++++++---
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index f2a8683db7d9..fa71e94b76f4 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -63,19 +63,29 @@ MODULE_DEVICE_TABLE(of, st_gyro_of_match);
 #endif
 
 static int st_gyro_i2c_probe(struct i2c_client *client,
-						const struct i2c_device_id *id)
+			     const struct i2c_device_id *id)
 {
-	struct iio_dev *indio_dev;
+	const struct st_sensor_settings *settings;
 	struct st_sensor_data *gdata;
+	struct iio_dev *indio_dev;
 	int err;
 
+	st_sensors_of_name_probe(&client->dev, st_gyro_of_match,
+				 client->name, sizeof(client->name));
+
+	settings = st_gyro_get_settings(client->name);
+	if (!settings) {
+		dev_err(&client->dev, "device name %s not recognized.\n",
+			client->name);
+		return -ENODEV;
+	}
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*gdata));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	gdata = iio_priv(indio_dev);
-	st_sensors_of_name_probe(&client->dev, st_gyro_of_match,
-				 client->name, sizeof(client->name));
+	gdata->sensor_settings = (struct st_sensor_settings *)settings;
 
 	st_sensors_i2c_configure(indio_dev, client, gdata);
 
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 93c48248bea6..bb7082055f85 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -69,18 +69,28 @@ MODULE_DEVICE_TABLE(of, st_gyro_of_match);
 
 static int st_gyro_spi_probe(struct spi_device *spi)
 {
-	struct iio_dev *indio_dev;
+	const struct st_sensor_settings *settings;
 	struct st_sensor_data *gdata;
+	struct iio_dev *indio_dev;
 	int err;
 
+	st_sensors_of_name_probe(&spi->dev, st_gyro_of_match,
+				 spi->modalias, sizeof(spi->modalias));
+
+	settings = st_gyro_get_settings(spi->modalias);
+	if (!settings) {
+		dev_err(&spi->dev, "device name %s not recognized.\n",
+			spi->modalias);
+		return -ENODEV;
+	}
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*gdata));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	gdata = iio_priv(indio_dev);
+	gdata->sensor_settings = (struct st_sensor_settings *)settings;
 
-	st_sensors_of_name_probe(&spi->dev, st_gyro_of_match,
-				 spi->modalias, sizeof(spi->modalias));
 	st_sensors_spi_configure(indio_dev, spi, gdata);
 
 	err = st_gyro_common_probe(indio_dev);
-- 
2.22.0

