Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 489A86D6F9
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 00:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391355AbfGRWys (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 18:54:48 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12236 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728139AbfGRWys (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 18:54:48 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IMpK2X028031;
        Fri, 19 Jul 2019 00:54:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=vpmJ1038BeiU2wkWfjl6bJqlVvIXCgFOHZ7ZNpXVk54=;
 b=IrAdKrKprD+ciwR0pei5F/SHm1hm0I50F6Leh81fIfUqUH90+JutZ29ySUyGudOfFfbu
 2XwVBoJlwbwQ8WcVTR7savMItxadFGjIlpHY0R/8RsnjDxunnKFnPi4pIqm3Ug7td2dc
 bfyX82agQTFGHbu/KCLITLKzzSf01Fdg4BS3pRUteUQ0Jk/S6C+Ye3YVO/9+2JQfCXDo
 dXLvfrUypSbGfIldhEl9SXVFjn7xFA2EurdWa4VWvEn1IyFGUxEqj40yRRej40tv9uN8
 uhFy7i85ynO4AKZmKoV9t63IpQTz+4QdYI3cifWo0ilMiTqcEgb0p9XK8cz6l+xGLnxo RA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tq4e9da9k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Jul 2019 00:54:43 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5176A34;
        Thu, 18 Jul 2019 22:54:43 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3C61F10AC;
        Thu, 18 Jul 2019 22:54:43 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 19 Jul 2019 00:54:42
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <denis.ciocca@st.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v2 08/11] iio:magn: device settings are set immediately during probe
Date:   Thu, 18 Jul 2019 15:53:50 -0700
Message-ID: <20190718225353.2078-9-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718225353.2078-1-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_12:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch set magn settings right after probe start. This is
done in preparation of regmap that needs different configuration
based on multiread bit value.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
Changes in v2:
 not there in v1.

 drivers/iio/magnetometer/st_magn_i2c.c | 18 ++++++++++++++----
 drivers/iio/magnetometer/st_magn_spi.c | 16 +++++++++++++---
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 4d014fd1aeb0..d5d565639bed 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -55,19 +55,29 @@ MODULE_DEVICE_TABLE(of, st_magn_of_match);
 #endif
 
 static int st_magn_i2c_probe(struct i2c_client *client,
-						const struct i2c_device_id *id)
+			     const struct i2c_device_id *id)
 {
-	struct iio_dev *indio_dev;
+	const struct st_sensor_settings *settings;
 	struct st_sensor_data *mdata;
+	struct iio_dev *indio_dev;
 	int err;
 
+	st_sensors_of_name_probe(&client->dev, st_magn_of_match,
+				 client->name, sizeof(client->name));
+
+	settings = st_magn_get_settings(client->name);
+	if (!settings) {
+		dev_err(&client->dev, "device name %s not recognized.\n",
+			client->name);
+		return -ENODEV;
+	}
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mdata));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	mdata = iio_priv(indio_dev);
-	st_sensors_of_name_probe(&client->dev, st_magn_of_match,
-				 client->name, sizeof(client->name));
+	mdata->sensor_settings = (struct st_sensor_settings *)settings;
 
 	st_sensors_i2c_configure(indio_dev, client, mdata);
 
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 0d47070611b1..a3045afc6b53 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -51,18 +51,28 @@ MODULE_DEVICE_TABLE(of, st_magn_of_match);
 
 static int st_magn_spi_probe(struct spi_device *spi)
 {
-	struct iio_dev *indio_dev;
+	const struct st_sensor_settings *settings;
 	struct st_sensor_data *mdata;
+	struct iio_dev *indio_dev;
 	int err;
 
+	st_sensors_of_name_probe(&spi->dev, st_magn_of_match,
+				 spi->modalias, sizeof(spi->modalias));
+
+	settings = st_magn_get_settings(spi->modalias);
+	if (!settings) {
+		dev_err(&spi->dev, "device name %s not recognized.\n",
+			spi->modalias);
+		return -ENODEV;
+	}
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*mdata));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	mdata = iio_priv(indio_dev);
+	mdata->sensor_settings = (struct st_sensor_settings *)settings;
 
-	st_sensors_of_name_probe(&spi->dev, st_magn_of_match,
-				 spi->modalias, sizeof(spi->modalias));
 	st_sensors_spi_configure(indio_dev, spi, mdata);
 
 	err = st_magn_common_probe(indio_dev);
-- 
2.22.0

