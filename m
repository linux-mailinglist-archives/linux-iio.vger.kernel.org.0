Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4BA49610
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 01:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfFQXuV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 19:50:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43686 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726427AbfFQXuV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 19:50:21 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HNkGb8021457;
        Tue, 18 Jun 2019 01:50:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=be3alPzowUCSHxEefbQ+3IipkJSdaTB7AEsUoCZPAG4=;
 b=hb2H1r6HcCNquWOBcZ4MXDYlvhbgZwTybd7ddrmdp/ZSXUbL2C0OX6GAbVeuiAEWJk9s
 cih7XKJQij4S3/0aR5VEnf/oS8xuRa+9hcHzIHH0v+3j7xMcAqJVmVtdD18NEWJErSYS
 2chz98JJZsmcSYDb0dkV4rWvUgjIPkSfIJnzA9yi8H69Zei8XjDIqFvry58W3yGnWfia
 TzqTcFvwd2FyuUjcXokPlBi11+1UrZh6dxL9cyyRvnNRa6/atEbkpMnXR+AN6gjxBvT+
 +4X5DCLVzP66K19OYcibyjKJRuCYBxbRvhJNZRsSOqEx7NfKpcC1HoWBm9Oobv1lEjth rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t4qjhvwsc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Jun 2019 01:50:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7591931;
        Mon, 17 Jun 2019 23:50:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 616901278;
        Mon, 17 Jun 2019 23:50:15 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG2NODE1.st.com (10.75.127.4)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Jun 2019 01:50:14
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <denis.ciocca@st.com>, <lorenzo@kernel.org>
Subject: [PATCH 2/7] iio:accel: introduce st_accel_multiread_bit() function
Date:   Mon, 17 Jun 2019 16:49:38 -0700
Message-ID: <20190617234943.10669-3-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617234943.10669-1-denis.ciocca@st.com>
References: <20190617234943.10669-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG2NODE1.st.com
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
 drivers/iio/accel/st_accel.h      |  1 +
 drivers/iio/accel/st_accel_core.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 979ab9679b99..0f0e5e8c8661 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -68,6 +68,7 @@ static const struct st_sensors_platform_data default_accel_pdata = {
 	.drdy_int_pin = 1,
 };
 
+bool st_accel_multiread_bit(const char *name);
 int st_accel_common_probe(struct iio_dev *indio_dev);
 void st_accel_common_remove(struct iio_dev *indio_dev);
 
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index e02b79931979..5029b399efa8 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1147,6 +1147,22 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
 #endif
 }
 
+/*
+ * st_accel_multiread_bit() - check if device requires multi-read bit.
+ * @name: device name buffer reference.
+ */
+bool st_accel_multiread_bit(const char *name)
+{
+	int index = st_sensors_get_settings_index(name,
+					st_accel_sensors_settings,
+					ARRAY_SIZE(st_accel_sensors_settings));
+	if (index < 0)
+		return false;
+
+	return st_accel_sensors_settings[index].multi_read_bit;
+}
+EXPORT_SYMBOL(st_accel_multiread_bit);
+
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
-- 
2.22.0

