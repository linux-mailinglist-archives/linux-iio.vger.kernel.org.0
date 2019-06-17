Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D949612
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 01:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfFQXuY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 19:50:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43720 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727159AbfFQXuY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 19:50:24 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HNkGxD021458;
        Tue, 18 Jun 2019 01:50:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=wVgG7PCfIxo47C9FHWaJTS9pH35AF08KRAPJP2Q+tYM=;
 b=RhxYsGoOY4s6dzS87SDZXvQeN2Jla9KxGuztUcoJ6tqFL8UX6XVp7TAQ8INzgxF9/qeV
 h8TX2KP1cJYvTZZyMN7aXLtyXH86VNvcyRfaxTi6jUitgafnbyHAX1/aLLMayLLDppVz
 WhJ/IPC5HRvKt20HtUABKVK6N+XkEhD61IuAIxBerK75LpwuKR8Yg/CqYsi3Vk/z9xp3
 Z7GR8BgGOq8RE0Z3ZLrYIdjysJRBhqucIiaVgFk3DAS1nhJS36UufI4oE5Taau9b4F4V
 CpACqQQM2uyDXJzGAm+Qk2yhmv3VGWqXmbQlo5IjC8kf3GiSREDr0PRZ8JPXo5qfYPp8 JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t4qjhvwsr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Jun 2019 01:50:20 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3AE5C31;
        Mon, 17 Jun 2019 23:50:20 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 27A62127A;
        Mon, 17 Jun 2019 23:50:20 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG2NODE1.st.com (10.75.127.4)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Jun 2019 01:50:19
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <denis.ciocca@st.com>, <lorenzo@kernel.org>
Subject: [PATCH 4/7] iio:gyro: introduce st_gyro_multiread_bit() function
Date:   Mon, 17 Jun 2019 16:49:40 -0700
Message-ID: <20190617234943.10669-5-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617234943.10669-1-denis.ciocca@st.com>
References: <20190617234943.10669-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG2NODE1.st.com
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
 drivers/iio/gyro/st_gyro.h      |  1 +
 drivers/iio/gyro/st_gyro_core.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index 460d190be4a4..bf23cb8a59c0 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -32,6 +32,7 @@ static const struct st_sensors_platform_data gyro_pdata = {
 	.drdy_int_pin = 2,
 };
 
+bool st_gyro_multiread_bit(const char *name);
 int st_gyro_common_probe(struct iio_dev *indio_dev);
 void st_gyro_common_remove(struct iio_dev *indio_dev);
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index e995dc77e30e..84a014fdcad2 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -368,6 +368,22 @@ static const struct iio_trigger_ops st_gyro_trigger_ops = {
 #define ST_GYRO_TRIGGER_OPS NULL
 #endif
 
+/*
+ * st_gyro_multiread_bit() - check if device requires multi-read bit.
+ * @name: device name buffer reference.
+ */
+bool st_gyro_multiread_bit(const char *name)
+{
+	int index = st_sensors_get_settings_index(name,
+					st_gyro_sensors_settings,
+					ARRAY_SIZE(st_gyro_sensors_settings));
+	if (index < 0)
+		return false;
+
+	return st_gyro_sensors_settings[index].multi_read_bit;
+}
+EXPORT_SYMBOL(st_gyro_multiread_bit);
+
 int st_gyro_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
-- 
2.22.0

