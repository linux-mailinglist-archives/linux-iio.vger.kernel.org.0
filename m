Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D25C49613
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 01:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfFQXu3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 19:50:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18126 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727731AbfFQXu2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 19:50:28 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HNkbfH005183;
        Tue, 18 Jun 2019 01:50:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=Zboa62TDrTySAlr11LhE+g+HTh0kQ33JoSsVioA8cj0=;
 b=0+aXTz6zS6+wX4W3UFUrskli7CPxjvY7dobLumx8oJL0c4Mzcsk5Iwb5SlbNKwYUUMHP
 doEGZ43nel7OJjhagdyZFP1jzZK9CnLEbSsIXBWcdxBlQqLjNdsaAe+Wt0u+upyb8J4O
 WiaxjmVmDqAt7jzS2nI+GKrs5oj0wCws2DgAB3PlGXwYvN75JhuS2CpUHwrYXEWEVRSq
 IQbUXDgq/lzyi6xRjH0kiWwPjVbffLmfTH63fPGN3u6VVMtqx7hw6xdZ8KWfT7RSjI2D
 bCE/0MiOIQa2uK/5bDuqB2jdVrW7PPHlFrBbRbFih73IXVLQQCSaUIsWkDOs52Q2RyhU ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t4peu4v0m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Jun 2019 01:50:23 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C952631;
        Mon, 17 Jun 2019 23:50:22 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B23D9127A;
        Mon, 17 Jun 2019 23:50:22 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG2NODE1.st.com (10.75.127.4)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Jun 2019 01:50:21
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <denis.ciocca@st.com>, <lorenzo@kernel.org>
Subject: [PATCH 5/7] iio:pressure: introduce st_pressure_multiread_bit() function
Date:   Mon, 17 Jun 2019 16:49:41 -0700
Message-ID: <20190617234943.10669-6-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617234943.10669-1-denis.ciocca@st.com>
References: <20190617234943.10669-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG2NODE1.st.com
 (10.75.127.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_09:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This function is introduced as a preparation for regmap usage.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/pressure/st_pressure.h      |  1 +
 drivers/iio/pressure/st_pressure_core.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index 6a720cfb5686..c4b28dab34d8 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -41,6 +41,7 @@ static const struct st_sensors_platform_data default_press_pdata = {
 	.drdy_int_pin = 1,
 };
 
+bool st_press_multiread_bit(const char *name);
 int st_press_common_probe(struct iio_dev *indio_dev);
 void st_press_common_remove(struct iio_dev *indio_dev);
 
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index b960e76f7dfd..fb3bfaa00e85 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -664,6 +664,22 @@ static const struct iio_trigger_ops st_press_trigger_ops = {
 #define ST_PRESS_TRIGGER_OPS NULL
 #endif
 
+/*
+ * st_press_multiread_bit() - check if device requires multi-read bit.
+ * @name: device name buffer reference.
+ */
+bool st_press_multiread_bit(const char *name)
+{
+	int index = st_sensors_get_settings_index(name,
+					st_press_sensors_settings,
+					ARRAY_SIZE(st_press_sensors_settings));
+	if (index < 0)
+		return false;
+
+	return st_press_sensors_settings[index].multi_read_bit;
+}
+EXPORT_SYMBOL(st_press_multiread_bit);
+
 int st_press_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
-- 
2.22.0

