Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C46D6F6
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 00:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfGRWyl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 18:54:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19162 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728139AbfGRWyk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 18:54:40 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IMpdDO000798;
        Fri, 19 Jul 2019 00:54:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=7wb+gtWVn319P4TbpaHV41P1pin95o2BXMGl3c7pnek=;
 b=PSBc1cxno/OEjqz37od9H8EGprCI2jx9gBX/wj6Dp4X/9HzIZrIh4gqkOc66Jn2znYyg
 c0DipfDhVZhomYCQch6zoKsqk2VA1rF+dgNAVPxs/YxrZLRT3aNF4Ps7BE8yPwySUM7Y
 yi3rRfOkHOis1mu92wG47ERc6U7sqJ6RFP8GIe25DlztW3Bf0CPNHGN57TfX7/X7PGQY
 a/lPv8em6x6FryT2NEaakQpAK9aa33IMgQzQ04BySyN60HYngOP5NffjcZ7ZmDXATToW
 5N+DpNB0vcEkRA+RC56XRE+Rsgei3IJkQNveXrW15uQs/Zl962yoYuHxlDXv5Jk71/mK vA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tsdepr8wx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Jul 2019 00:54:35 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1166731;
        Thu, 18 Jul 2019 22:54:35 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F3AD910A4;
        Thu, 18 Jul 2019 22:54:34 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 19 Jul 2019 00:54:34
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <denis.ciocca@st.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v2 05/11] iio:pressure: introduce st_press_get_settings() function
Date:   Thu, 18 Jul 2019 15:53:47 -0700
Message-ID: <20190718225353.2078-6-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718225353.2078-1-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_12:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The function is introduced to retrieve press device settings. It will be
used by probe in order to configure regmap.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
Changes in v2:
 not there in v1. This meant to replace "iio:pressure:introduce st_press_multiread_bit() function"

 drivers/iio/pressure/st_pressure.h      |  1 +
 drivers/iio/pressure/st_pressure_core.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index 6a720cfb5686..c2e47a6c3118 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -41,6 +41,7 @@ static const struct st_sensors_platform_data default_press_pdata = {
 	.drdy_int_pin = 1,
 };
 
+const struct st_sensor_settings *st_press_get_settings(const char *name);
 int st_press_common_probe(struct iio_dev *indio_dev);
 void st_press_common_remove(struct iio_dev *indio_dev);
 
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index b960e76f7dfd..35d80ff27464 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -664,6 +664,24 @@ static const struct iio_trigger_ops st_press_trigger_ops = {
 #define ST_PRESS_TRIGGER_OPS NULL
 #endif
 
+/*
+ * st_press_get_settings() - get sensor settings from device name
+ * @name: device name buffer reference.
+ *
+ * Return: valid reference on success, NULL otherwise.
+ */
+const struct st_sensor_settings *st_press_get_settings(const char *name)
+{
+	int index = st_sensors_get_settings_index(name,
+					st_press_sensors_settings,
+					ARRAY_SIZE(st_press_sensors_settings));
+	if (index < 0)
+		return NULL;
+
+	return &st_press_sensors_settings[index];
+}
+EXPORT_SYMBOL(st_press_get_settings);
+
 int st_press_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
-- 
2.22.0

