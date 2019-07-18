Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC136D6F2
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 00:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfGRWya (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 18:54:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20848 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727972AbfGRWya (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 18:54:30 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IMpZql027763;
        Fri, 19 Jul 2019 00:54:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=K/51DZ5UXNtNAtxxfOlgGd59QZXnzug5FDLoGzO0n1I=;
 b=tuxtj2Nk0a7NZelvtDinhkhTtzndbWjqLi4615ktOiKUzJ5NwQ5mg2+snvLo/hakA0ou
 SXuRqFCmy+IjAKuKqRVQTC3XuTVzodBJQCkjT9XLEW8FUgzD37VInzWZjIHUcVPnTQRB
 0Wxz1lR8Q49dbG60URtPx84BhL3Mn5wDKf7zOHDJ5TY09tGcGKYQtW/7RecoWDe2LTQI
 gq/2mWcjUZRq6jOgliRn2u7r9Nw6zJHdIBpi35Bc7xrFzy/BZ7FQmuo9PHLHoWZwTiYR
 rdZ74WKO+PyI3VW9N6qeOhY0C3jsvtSANI/kW7j3oSPAh4tXYmOypZKrvhJuN63fC1RU fQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tq4s24j55-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Jul 2019 00:54:25 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7C29F31;
        Thu, 18 Jul 2019 22:54:24 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6655E10A4;
        Thu, 18 Jul 2019 22:54:24 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 19 Jul 2019 00:54:23
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <denis.ciocca@st.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v2 01/11] iio:common:st_sensors: add st_sensors_get_settings_index() helper function
Date:   Thu, 18 Jul 2019 15:53:43 -0700
Message-ID: <20190718225353.2078-2-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718225353.2078-1-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_12:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Extract from st_sensors_check_device_support() function the code that
is used to get the specific settings for a device. This will be used
as generic extractor by each ST driver.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
Changes in v2:
 return immediately in st_sensors_settings_index after device name is found
 remove err initialization inside st_sensors_check_device_support
 
 .../iio/common/st_sensors/st_sensors_core.c   | 49 +++++++++++++------
 include/linux/iio/common/st_sensors.h         |  4 ++
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 8b22dc241482..3610ca9eaa87 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -633,28 +633,47 @@ static int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
 	return 0;
 }
 
+/*
+ * st_sensors_get_settings_index() - get index of the sensor settings for a
+ *				     specific device from list of settings
+ * @name: device name buffer reference.
+ * @list: sensor settings list.
+ * @list_length: length of sensor settings list.
+ *
+ * Return: non negative number on success (valid index),
+ *	   negative error code otherwise.
+ */
+int st_sensors_get_settings_index(const char *name,
+				  const struct st_sensor_settings *list,
+				  const int list_length)
+{
+	int i, n;
+
+	for (i = 0; i < list_length; i++) {
+		for (n = 0; n < ST_SENSORS_MAX_4WAI; n++) {
+			if (strcmp(name, list[i].sensors_supported[n]) == 0)
+				return i;
+		}
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL(st_sensors_get_settings_index);
+
 int st_sensors_check_device_support(struct iio_dev *indio_dev,
 			int num_sensors_list,
 			const struct st_sensor_settings *sensor_settings)
 {
-	int i, n, err = 0;
-	u8 wai;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	int i, err;
+	u8 wai;
 
-	for (i = 0; i < num_sensors_list; i++) {
-		for (n = 0; n < ST_SENSORS_MAX_4WAI; n++) {
-			if (strcmp(indio_dev->name,
-				sensor_settings[i].sensors_supported[n]) == 0) {
-				break;
-			}
-		}
-		if (n < ST_SENSORS_MAX_4WAI)
-			break;
-	}
-	if (i == num_sensors_list) {
+	i = st_sensors_get_settings_index(indio_dev->name,
+					  sensor_settings, num_sensors_list);
+	if (i < 0) {
 		dev_err(&indio_dev->dev, "device name %s not recognized.\n",
-							indio_dev->name);
-		return -ENODEV;
+			indio_dev->name);
+		return i;
 	}
 
 	err = st_sensors_init_interface_mode(indio_dev, &sensor_settings[i]);
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 2948ac99e2da..17fbf3e9b013 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -334,6 +334,10 @@ int st_sensors_set_fullscale_by_gain(struct iio_dev *indio_dev, int scale);
 int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *ch, int *val);
 
+int st_sensors_get_settings_index(const char *name,
+				  const struct st_sensor_settings *list,
+				  const int list_length);
+
 int st_sensors_check_device_support(struct iio_dev *indio_dev,
 	int num_sensors_list, const struct st_sensor_settings *sensor_settings);
 
-- 
2.22.0

