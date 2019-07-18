Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47EC46D6F3
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 00:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfGRWyc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 18:54:32 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20832 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727972AbfGRWyc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 18:54:32 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IMqMZw028227;
        Fri, 19 Jul 2019 00:54:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=6Nz7EPP+a0kHR6d7/m52e/KJ0fQBrUsVhslfauSBf/0=;
 b=ZeoGDNcVJh1hPg+/rC8tC69pU0wApVwLyyu1JIymTJggRuxARyuZUuIMdBTsVu1YLc/u
 znBvAIIhR0DhND1tQr/gwNGdXTeo/yZ+Kf/j24pviYj2Im8gf6rOo9FkAhjoAHKOflCL
 1gENZBXpB2Qqs/5RQHJbpFwT3w3E2oX38hcrYNbynrt50s1J99B1v7YhePsky8pZ7j3c
 uwZ4Pd3JwqfZvPm/TAqGwGl9GgoU3jKl70AZeLmJBFcuyfsF/JsML1s55uxlRC4xUoU2
 Zk7HnQ2fBIm9fH89RHEFjIaBo7koFBL97k0SlbJmzGQySzAs+D/PL+oYAar0eSHXAmie Lw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tq4s24j5c-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Jul 2019 00:54:27 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2A61231;
        Thu, 18 Jul 2019 22:54:27 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 14BE210A4;
        Thu, 18 Jul 2019 22:54:27 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 19 Jul 2019 00:54:26
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <denis.ciocca@st.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v2 02/11] iio:accel: introduce st_accel_get_settings() function
Date:   Thu, 18 Jul 2019 15:53:44 -0700
Message-ID: <20190718225353.2078-3-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718225353.2078-1-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_12:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The function is introduced to retrieve accel device settings. It will be
used by probe in order to configure regmap.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
Changes in v2:
 not there in v1. This meant to replace "iio:accel:introduce st_accel_multiread_bit() function"

 drivers/iio/accel/st_accel.h      |  1 +
 drivers/iio/accel/st_accel_core.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 979ab9679b99..af09943f38c9 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -68,6 +68,7 @@ static const struct st_sensors_platform_data default_accel_pdata = {
 	.drdy_int_pin = 1,
 };
 
+const struct st_sensor_settings *st_accel_get_settings(const char *name);
 int st_accel_common_probe(struct iio_dev *indio_dev);
 void st_accel_common_remove(struct iio_dev *indio_dev);
 
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index e02b79931979..6fc490ffef7e 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1147,6 +1147,24 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
 #endif
 }
 
+/*
+ * st_accel_get_settings() - get sensor settings from device name
+ * @name: device name buffer reference.
+ *
+ * Return: valid reference on success, NULL otherwise.
+ */
+const struct st_sensor_settings *st_accel_get_settings(const char *name)
+{
+	int index = st_sensors_get_settings_index(name,
+					st_accel_sensors_settings,
+					ARRAY_SIZE(st_accel_sensors_settings));
+	if (index < 0)
+		return NULL;
+
+	return &st_accel_sensors_settings[index];
+}
+EXPORT_SYMBOL(st_accel_get_settings);
+
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
-- 
2.22.0

