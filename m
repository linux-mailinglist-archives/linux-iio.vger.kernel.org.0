Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD23749611
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 01:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfFQXuX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 19:50:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18142 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727159AbfFQXuX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 19:50:23 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HNlBvE005597;
        Tue, 18 Jun 2019 01:50:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=cDroc2VhFCFvPCn/dUWU60raoa/VJ2Zgab9kxNbRXhs=;
 b=EZClgnhRYjHnJwo0VJpJdVlyPfHvcxnGuPlAT2JgHPjNMLgf0xz1fsKqtGbsnSQrxZru
 UVkH/M9NpYnDSEiQ3p+rDN0P2LCoUXSlV1us8NOpgzRehb1ciTKDSlYg35YsrfRmCU74
 1EWGG/5LQdHsCTg3e5z2iUtMimsCQqHO6IchYtjkUlYxDvMntq7QS2UvrKPPN71XRHVP
 K0YOcvPHkG7MCqdkwjb7uYw78Qb2ru/UsE5i+B6RZ3IiAotnuiMfpAa2Bxvj71uQyQhm
 p4BpcM30hWrVkXPag4CBit5VijOZqZnzLDnKalX6UQY4taBSFALKa+7Jcl686hugCkY6 qA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t4peu4v08-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Jun 2019 01:50:18 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C960431;
        Mon, 17 Jun 2019 23:50:17 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B602E127A;
        Mon, 17 Jun 2019 23:50:17 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG2NODE1.st.com (10.75.127.4)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Jun 2019 01:50:16
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <denis.ciocca@st.com>, <lorenzo@kernel.org>
Subject: [PATCH 3/7] iio:magn: introduce st_magn_multiread_bit() function
Date:   Mon, 17 Jun 2019 16:49:39 -0700
Message-ID: <20190617234943.10669-4-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617234943.10669-1-denis.ciocca@st.com>
References: <20190617234943.10669-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG2NODE1.st.com
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
 drivers/iio/magnetometer/st_magn.h      |  1 +
 drivers/iio/magnetometer/st_magn_core.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index d69ef9b2a731..9a3c8b9525e2 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -22,6 +22,7 @@
 #define LIS2MDL_MAGN_DEV_NAME		"lis2mdl"
 #define LSM9DS1_MAGN_DEV_NAME		"lsm9ds1_magn"
 
+bool st_magn_multiread_bit(const char *name);
 int st_magn_common_probe(struct iio_dev *indio_dev);
 void st_magn_common_remove(struct iio_dev *indio_dev);
 
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 2f7a1dbcdeb3..2d8919eb5ada 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -470,6 +470,22 @@ static const struct iio_trigger_ops st_magn_trigger_ops = {
 #define ST_MAGN_TRIGGER_OPS NULL
 #endif
 
+/*
+ * st_magn_multiread_bit() - check if device requires multi-read bit.
+ * @name: device name buffer reference.
+ */
+bool st_magn_multiread_bit(const char *name)
+{
+	int index = st_sensors_get_settings_index(name,
+					st_magn_sensors_settings,
+					ARRAY_SIZE(st_magn_sensors_settings));
+	if (index < 0)
+		return false;
+
+	return st_magn_sensors_settings[index].multi_read_bit;
+}
+EXPORT_SYMBOL(st_magn_multiread_bit);
+
 int st_magn_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
-- 
2.22.0

