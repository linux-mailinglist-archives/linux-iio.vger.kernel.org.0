Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1E46D6F4
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 00:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfGRWyf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 18:54:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33829 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727972AbfGRWyf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 18:54:35 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IMpdDN000798;
        Fri, 19 Jul 2019 00:54:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=kCBpfdygLsVqShagbH65jZjfUCI4W94hVsFdCWU0mzE=;
 b=Ao1ABXnUOnbvH3S7axwU0E52m51FtxBqHJNoxPHDgP1mMmK44GW9L34Lmh3g//ovhq7q
 6oNhbCzztu6V4h9Crmwk3938nHC2LjCvOW4o+40KH3JWRdNDWIowoZHsp8kuYqRPK7+b
 I+/L4iHVjxoF5CpSwWAeWyV97c0haxD8mrMXrhcOnBicTZvq80eMg/1zeh1NCsOZJDKi
 iVxg1o+0pN2bOkk0pP8dfxA5is0zu7fQriHS8akvfAREymIxUqg3QLNd4XQ9R/l2pxE5
 p00K+Avi4tv4gkKR+SDL/a6tqE+yYqeeTkFAn3xEjuZJI+8ZS9yC8orNnQ1Ta/Fxv2mx 9g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tsdepr8wj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Jul 2019 00:54:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D24C031;
        Thu, 18 Jul 2019 22:54:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BED1810A4;
        Thu, 18 Jul 2019 22:54:29 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 19 Jul 2019 00:54:29
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <denis.ciocca@st.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v2 03/11] iio:gyro: introduce st_gyro_get_settings() function
Date:   Thu, 18 Jul 2019 15:53:45 -0700
Message-ID: <20190718225353.2078-4-denis.ciocca@st.com>
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

The function is introduced to retrieve gyro device settings. It will be
used by probe in order to configure regmap.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
Changes in v2:
 not there in v1. This meant to replace "iio:gyro:introduce st_gyro_multiread_bit() function"

 drivers/iio/gyro/st_gyro.h      |  1 +
 drivers/iio/gyro/st_gyro_core.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index 460d190be4a4..592f6b34e987 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -32,6 +32,7 @@ static const struct st_sensors_platform_data gyro_pdata = {
 	.drdy_int_pin = 2,
 };
 
+const struct st_sensor_settings *st_gyro_get_settings(const char *name);
 int st_gyro_common_probe(struct iio_dev *indio_dev);
 void st_gyro_common_remove(struct iio_dev *indio_dev);
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index e995dc77e30e..5cc63d41d855 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -368,6 +368,24 @@ static const struct iio_trigger_ops st_gyro_trigger_ops = {
 #define ST_GYRO_TRIGGER_OPS NULL
 #endif
 
+/*
+ * st_gyro_get_settings() - get sensor settings from device name
+ * @name: device name buffer reference.
+ *
+ * Return: valid reference on success, NULL otherwise.
+ */
+const struct st_sensor_settings *st_gyro_get_settings(const char *name)
+{
+	int index = st_sensors_get_settings_index(name,
+					st_gyro_sensors_settings,
+					ARRAY_SIZE(st_gyro_sensors_settings));
+	if (index < 0)
+		return NULL;
+
+	return &st_gyro_sensors_settings[index];
+}
+EXPORT_SYMBOL(st_gyro_get_settings);
+
 int st_gyro_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
-- 
2.22.0

