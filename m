Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF191157B40
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 14:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgBJN2o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 08:28:44 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9748 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729832AbgBJN2o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 08:28:44 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADOB13009657;
        Mon, 10 Feb 2020 08:28:43 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1tyq81s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 08:28:43 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01ADSgCc022093
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Feb 2020 08:28:42 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 10 Feb
 2020 08:28:41 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 10 Feb 2020 08:28:41 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01ADSVZq017670;
        Mon, 10 Feb 2020 08:28:39 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nuno.sa@analog.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 7/9] iio: imu: adis: add support product ID check in adis_initial_startup
Date:   Mon, 10 Feb 2020 15:26:04 +0200
Message-ID: <20200210132606.9315-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210132606.9315-1-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_04:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100105
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Each driver/chip that wants to validate it's product id, can now
specify a 'prod_id_reg' and an expected 'prod_id' value.
The 'prod_id' value is intentionally left 0 (uninitialized). There aren't
(yet) any product IDs with value 0; this enforces that both 'prod_id_reg'
and 'prod_id' are specified.

At the very least, this routine validates that the SPI connection to the
ADIS chip[s] works well.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c       | 23 ++++++++++++++++++++++-
 include/linux/iio/imu/adis.h |  5 +++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 0bd6e32cf577..a8afd01de4f3 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -373,6 +373,10 @@ static int adis_self_test(struct adis *adis)
  * via GPIOLIB. If no pin is configured a SW reset will be performed.
  * The RST pin for the ADIS devices should be configured as ACTIVE_LOW.
  *
+ * After the self-test operation is performed, the function will also check
+ * that the product ID is as expected. This assumes that drivers providing
+ * 'prod_id_reg' will also provide the 'prod_id'.
+ *
  * Returns 0 if the device is operational, a negative error code otherwise.
  *
  * This function should be called early on in the device initialization sequence
@@ -382,6 +386,7 @@ int __adis_initial_startup(struct adis *adis)
 {
 	const struct adis_timeout *timeouts = adis->data->timeouts;
 	struct gpio_desc *gpio;
+	uint16_t prod_id;
 	int ret;
 
 	/* check if the device has rst pin low */
@@ -401,7 +406,23 @@ int __adis_initial_startup(struct adis *adis)
 			return ret;
 	}
 
-	return adis_self_test(adis);
+	ret = adis_self_test(adis);
+	if (ret)
+		return ret;
+
+	if (!adis->data->prod_id_reg)
+		return 0;
+
+	ret = adis_read_reg_16(adis, adis->data->prod_id_reg, &prod_id);
+	if (ret)
+		return ret;
+
+	if (prod_id != adis->data->prod_id)
+		dev_warn(&adis->spi->dev,
+			 "Device ID(%u) and product ID(%u) do not match.",
+			 adis->data->prod_id, prod_id);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(__adis_initial_startup);
 
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index b7feca4e5f26..ac7cfd073804 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -41,6 +41,8 @@ struct adis_timeout {
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
+ * @prod_id_reg: Register address of the PROD_ID register
+ * @prod_id: Product ID code that should be expected when reading @prod_id_reg
  * @self_test_reg: Register address to request self test command
  * @status_error_msgs: Array of error messgaes
  * @status_error_mask:
@@ -54,6 +56,9 @@ struct adis_data {
 	unsigned int glob_cmd_reg;
 	unsigned int msc_ctrl_reg;
 	unsigned int diag_stat_reg;
+	unsigned int prod_id_reg;
+
+	unsigned int prod_id;
 
 	unsigned int self_test_mask;
 	unsigned int self_test_reg;
-- 
2.20.1

