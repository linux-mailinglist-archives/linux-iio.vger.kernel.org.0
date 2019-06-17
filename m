Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6274960F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 01:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfFQXuR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 19:50:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43680 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726427AbfFQXuR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 19:50:17 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HNkGxA021458;
        Tue, 18 Jun 2019 01:50:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=FuBTLBnFV0oOARfdW+NRbK00/QYaldE44hAe3+xjnJU=;
 b=TRi8veJXbM6E54BCPCWq2q+EqbXRVR0TqtfzOxBPSRA0ui2LPC2AfbGj4TuM7yZfl4mj
 60NmvtvKWTzWF64Nl63KvKrm2YstBrZBd+11564MTIc8QApfUa2s+EJnyRhTppFScoqj
 cTse6fbeyEV/4EmVaCsRxLl7GKuJPBigo0k6vz/WVbr8cbxrGBEQOI5vA42xyF02iQtv
 ufLpFMwy4mMbW+KusyPek1mnCeWuiAiViuYiRdwZKUcTfSMMxNyGFvm66VJ9MLcFLh6d
 e2oyyd+QKE2MfbpXoVNw0S6s3oz7tuEDYw2VRbERPP0pWUL1fVxl2+IiqorvCn6TXGPl +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t4qjhvws6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Jun 2019 01:50:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 040EB31;
        Mon, 17 Jun 2019 23:50:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D93041277;
        Mon, 17 Jun 2019 23:50:12 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG2NODE1.st.com (10.75.127.4)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Jun 2019 01:50:11
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <denis.ciocca@st.com>, <lorenzo@kernel.org>
Subject: [PATCH 1/7] iio:common:st_sensors: add st_sensors_get_settings_index() helper function
Date:   Mon, 17 Jun 2019 16:49:37 -0700
Message-ID: <20190617234943.10669-2-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617234943.10669-1-denis.ciocca@st.com>
References: <20190617234943.10669-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG2NODE1.st.com
 (10.75.127.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_09:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Extract from st_sensors_check_device_support() function the code that
is used to get the specific settings for a device. This will be used
by each driver to configure the multi-read bit at the beginning of the
probes.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 .../iio/common/st_sensors/st_sensors_core.c   | 45 ++++++++++++++-----
 include/linux/iio/common/st_sensors.h         |  4 ++
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 8b22dc241482..243b2097c57e 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -633,28 +633,49 @@ static int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
 	return 0;
 }
 
-int st_sensors_check_device_support(struct iio_dev *indio_dev,
-			int num_sensors_list,
-			const struct st_sensor_settings *sensor_settings)
+/*
+ * st_sensors_get_settings_index() - get index of sensor settings
+ *				     for a specific device.
+ * @name: device name buffer reference.
+ * @list: sensor settings list.
+ * @list_length: length of sensor settings list.
+ */
+int st_sensors_get_settings_index(const char *name,
+				  const struct st_sensor_settings *list,
+				  const int list_length)
 {
-	int i, n, err = 0;
-	u8 wai;
-	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	int i, n;
 
-	for (i = 0; i < num_sensors_list; i++) {
+	for (i = 0; i < list_length; i++) {
 		for (n = 0; n < ST_SENSORS_MAX_4WAI; n++) {
-			if (strcmp(indio_dev->name,
-				sensor_settings[i].sensors_supported[n]) == 0) {
+			if (strcmp(name, list[i].sensors_supported[n]) == 0) {
 				break;
 			}
 		}
 		if (n < ST_SENSORS_MAX_4WAI)
 			break;
 	}
-	if (i == num_sensors_list) {
-		dev_err(&indio_dev->dev, "device name %s not recognized.\n",
-							indio_dev->name);
+	if (i == list_length)
 		return -ENODEV;
+
+	return i;
+}
+EXPORT_SYMBOL(st_sensors_get_settings_index);
+
+int st_sensors_check_device_support(struct iio_dev *indio_dev,
+			int num_sensors_list,
+			const struct st_sensor_settings *sensor_settings)
+{
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	int i, err = 0;
+	u8 wai;
+
+	i = st_sensors_get_settings_index(indio_dev->name,
+					  sensor_settings, num_sensors_list);
+	if (i < 0) {
+		dev_err(&indio_dev->dev, "device name %s not recognized.\n",
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

