Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 864FF6D6FA
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 00:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391375AbfGRWyw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 18:54:52 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:65224 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728139AbfGRWyw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 18:54:52 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IMqFnn028128;
        Fri, 19 Jul 2019 00:54:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=F6/mt0v/4lRGrQuZxyoylBUmAtkgi1SRGt/2PKBnngg=;
 b=jHYEeACwTMFppMwwS1bR41csxMOuTKbaKPLwxGgOhvZxnjTvO39SBhuRSfQUr9ElQ1uE
 SvDLIuL6AxOfz4uc+zl/LjtArEVwt+9KQX0n/af97UZ2GuUhBocNEsDKh1ME43pqs8AT
 qiWdVlx+pN8TC+xMNiHJGhd6SZsCCB2frJr1XAhQyqIVy3dq5UvYz76/5PyQ9CHVFTFW
 ZB+gPCfytm2lpU/IT46E6axpv9eKmCUI8QL4fOLHcfAvr4Ny6aSqryXumUa4fq/erpq8
 DXY5buQl+HT+kuR9zZZihQ3xwZ8lz7aKhF7dk+qXzTHM6xJSYyWAXCzOeZHCFgG8ObKM Gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tq4s24j71-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Jul 2019 00:54:46 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1463D31;
        Thu, 18 Jul 2019 22:54:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 007C810AD;
        Thu, 18 Jul 2019 22:54:45 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 19 Jul 2019 00:54:45
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <denis.ciocca@st.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v2 09/11] iio:pressure: device settings are set immediately during probe
Date:   Thu, 18 Jul 2019 15:53:51 -0700
Message-ID: <20190718225353.2078-10-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718225353.2078-1-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_12:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch set pressure settings right after probe start. This is
done in preparation of regmap that needs different configuration
based on multiread bit value.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
Changes in v2:
 not there in v1.

 drivers/iio/pressure/st_pressure_i2c.c | 27 +++++++++++++++++---------
 drivers/iio/pressure/st_pressure_spi.c | 18 +++++++++++++----
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index b7d9ba706abc..466e7dde5eae 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -78,18 +78,13 @@ static const struct i2c_device_id st_press_id_table[] = {
 MODULE_DEVICE_TABLE(i2c, st_press_id_table);
 
 static int st_press_i2c_probe(struct i2c_client *client,
-						const struct i2c_device_id *id)
+			      const struct i2c_device_id *id)
 {
-	struct iio_dev *indio_dev;
+	const struct st_sensor_settings *settings;
 	struct st_sensor_data *press_data;
+	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*press_data));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	press_data = iio_priv(indio_dev);
-
 	if (client->dev.of_node) {
 		st_sensors_of_name_probe(&client->dev, st_press_of_match,
 					 client->name, sizeof(client->name));
@@ -99,10 +94,24 @@ static int st_press_i2c_probe(struct i2c_client *client,
 			return -ENODEV;
 
 		strlcpy(client->name, st_press_id_table[ret].name,
-				sizeof(client->name));
+			sizeof(client->name));
 	} else if (!id)
 		return -ENODEV;
 
+	settings = st_press_get_settings(client->name);
+	if (!settings) {
+		dev_err(&client->dev, "device name %s not recognized.\n",
+			client->name);
+		return -ENODEV;
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*press_data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	press_data = iio_priv(indio_dev);
+	press_data->sensor_settings = (struct st_sensor_settings *)settings;
+
 	st_sensors_i2c_configure(indio_dev, client, press_data);
 
 	ret = st_press_common_probe(indio_dev);
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index ef61401c41d3..3e8c1ffe001e 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -61,18 +61,28 @@ MODULE_DEVICE_TABLE(of, st_press_of_match);
 
 static int st_press_spi_probe(struct spi_device *spi)
 {
-	struct iio_dev *indio_dev;
+	const struct st_sensor_settings *settings;
 	struct st_sensor_data *press_data;
+	struct iio_dev *indio_dev;
 	int err;
 
+	st_sensors_of_name_probe(&spi->dev, st_press_of_match,
+				 spi->modalias, sizeof(spi->modalias));
+
+	settings = st_press_get_settings(spi->modalias);
+	if (!settings) {
+		dev_err(&spi->dev, "device name %s not recognized.\n",
+			spi->modalias);
+		return -ENODEV;
+	}
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*press_data));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	press_data = iio_priv(indio_dev);
+	press_data->sensor_settings = (struct st_sensor_settings *)settings;
 
-	st_sensors_of_name_probe(&spi->dev, st_press_of_match,
-				 spi->modalias, sizeof(spi->modalias));
 	st_sensors_spi_configure(indio_dev, spi, press_data);
 
 	err = st_press_common_probe(indio_dev);
-- 
2.22.0

