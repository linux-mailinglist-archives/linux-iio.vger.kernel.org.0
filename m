Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748E26D6F5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 00:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfGRWyg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 18:54:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5378 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728139AbfGRWyg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 18:54:36 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IMpxnD028505;
        Fri, 19 Jul 2019 00:54:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=OpeuH215fjiXx/oZtF+bFjaM3RDujqMQIoOnm1MpsK0=;
 b=GpEhVrDosMYG0MhCt2uLu2c9GbL1dT8SGb3gpFwNYOOz0C/9zeC3AJcZhv24kUbOd+ha
 Anvxq4dbB+yrkU7ndStTYvPu3TS480iXo7rJvTA5qSnRuvNAr2Xi6jf0e6Mtv7Jc0DIO
 pEszXPMrjyUPDojnM/Q0bni5U1HKzZ2dO0bNhACH0l2D5uxxUQ5IRtHdReblnsboJQTY
 nmgzoUwIpQDQLk9MdiR/eH5lxen/oPbC/04vvJbC9RS5H7M288vHT4fAXVg8Y0PZji2e
 eaL9HAU96KHqV769RtgHCOtoIComAOHIo5Sw17Eg9fw0cSrYXgBgWAzX5Puo8W1lUJwL 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tq4e9da8v-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Jul 2019 00:54:32 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 628CA31;
        Thu, 18 Jul 2019 22:54:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 50F9510A4;
        Thu, 18 Jul 2019 22:54:32 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 19 Jul 2019 00:54:31
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <denis.ciocca@st.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v2 04/11] iio:magn: introduce st_magn_get_settings() function
Date:   Thu, 18 Jul 2019 15:53:46 -0700
Message-ID: <20190718225353.2078-5-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718225353.2078-1-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_12:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The function is introduced to retrieve magn device settings. It will be
used by probe in order to configure regmap.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
Changes in v2:
 not there in v1. This meant to replace "iio:magn:introduce st_magn_multiread_bit() function"

 drivers/iio/magnetometer/st_magn.h      |  1 +
 drivers/iio/magnetometer/st_magn_core.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index d69ef9b2a731..204b285725c8 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -22,6 +22,7 @@
 #define LIS2MDL_MAGN_DEV_NAME		"lis2mdl"
 #define LSM9DS1_MAGN_DEV_NAME		"lsm9ds1_magn"
 
+const struct st_sensor_settings *st_magn_get_settings(const char *name);
 int st_magn_common_probe(struct iio_dev *indio_dev);
 void st_magn_common_remove(struct iio_dev *indio_dev);
 
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 2f7a1dbcdeb3..43a49a52c81a 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -470,6 +470,24 @@ static const struct iio_trigger_ops st_magn_trigger_ops = {
 #define ST_MAGN_TRIGGER_OPS NULL
 #endif
 
+/*
+ * st_magn_get_settings() - get sensor settings from device name
+ * @name: device name buffer reference.
+ *
+ * Return: valid reference on success, NULL otherwise.
+ */
+const struct st_sensor_settings *st_magn_get_settings(const char *name)
+{
+	int index = st_sensors_get_settings_index(name,
+					st_magn_sensors_settings,
+					ARRAY_SIZE(st_magn_sensors_settings));
+	if (index < 0)
+		return NULL;
+
+	return &st_magn_sensors_settings[index];
+}
+EXPORT_SYMBOL(st_magn_get_settings);
+
 int st_magn_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
-- 
2.22.0

