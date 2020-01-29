Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856B914CC3C
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2020 15:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgA2OVi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jan 2020 09:21:38 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6330 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgA2OVh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jan 2020 09:21:37 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TEF8kV004865;
        Wed, 29 Jan 2020 09:21:14 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xrgdbv9tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 09:21:14 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 00TELC5g039266
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 29 Jan 2020 09:21:12 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 29 Jan
 2020 06:21:10 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 29 Jan 2020 09:21:10 -0500
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00TEKwxf027599;
        Wed, 29 Jan 2020 09:21:07 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v4 1/5] iio: core: Handle 'dB' suffix in core
Date:   Wed, 29 Jan 2020 16:22:57 +0200
Message-ID: <20200129142301.13918-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129142301.13918-1-beniamin.bia@analog.com>
References: <20200129142301.13918-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_03:2020-01-28,2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=1 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001290118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch handles the db suffix used for writing micro db values.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/industrialio-core.c | 35 ++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 65ff0d067018..b70111837420 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -769,17 +769,18 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 }
 
 /**
- * iio_str_to_fixpoint() - Parse a fixed-point number from a string
+ * __iio_str_to_fixpoint() - Parse a fixed-point number from a string
  * @str: The string to parse
  * @fract_mult: Multiplier for the first decimal place, should be a power of 10
  * @integer: The integer part of the number
  * @fract: The fractional part of the number
+ * @scale_db: True if this should parse as dB
  *
  * Returns 0 on success, or a negative error code if the string could not be
  * parsed.
  */
-int iio_str_to_fixpoint(const char *str, int fract_mult,
-	int *integer, int *fract)
+int __iio_str_to_fixpoint(const char *str, int fract_mult,
+			  int *integer, int *fract, bool scale_db)
 {
 	int i = 0, f = 0;
 	bool integer_part = true, negative = false;
@@ -810,6 +811,10 @@ int iio_str_to_fixpoint(const char *str, int fract_mult,
 				break;
 			else
 				return -EINVAL;
+		} else if (!strncmp(str, " dB", sizeof(" dB") - 1) && scale_db) {
+			/* Ignore the dB suffix */
+			str += sizeof(" dB") - 1;
+			continue;
 		} else if (*str == '.' && integer_part) {
 			integer_part = false;
 		} else {
@@ -832,6 +837,22 @@ int iio_str_to_fixpoint(const char *str, int fract_mult,
 }
 EXPORT_SYMBOL_GPL(iio_str_to_fixpoint);
 
+/**
+ * iio_str_to_fixpoint() - Parse a fixed-point number from a string
+ * @str: The string to parse
+ * @fract_mult: Multiplier for the first decimal place, should be a power of 10
+ * @integer: The integer part of the number
+ * @fract: The fractional part of the number
+ *
+ * Returns 0 on success, or a negative error code if the string could not be
+ * parsed.
+ */
+int iio_str_to_fixpoint(const char *str, int fract_mult,
+			int *integer, int *fract)
+{
+	return __iio_str_to_fixpoint(str, fract_mult, integer, fract, false);
+}
+
 static ssize_t iio_write_channel_info(struct device *dev,
 				      struct device_attribute *attr,
 				      const char *buf,
@@ -842,6 +863,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
 	int ret, fract_mult = 100000;
 	int integer, fract = 0;
 	bool is_char = false;
+	bool scale_db = false;
 
 	/* Assumes decimal - precision based on number of digits */
 	if (!indio_dev->info->write_raw)
@@ -853,6 +875,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
 		case IIO_VAL_INT:
 			fract_mult = 0;
 			break;
+		case IIO_VAL_INT_PLUS_MICRO_DB:
+			scale_db = true;
+			/* fall through */
 		case IIO_VAL_INT_PLUS_MICRO:
 			fract_mult = 100000;
 			break;
@@ -877,6 +902,10 @@ static ssize_t iio_write_channel_info(struct device *dev,
 		if (ret)
 			return ret;
 	}
+	ret = __iio_str_to_fixpoint(buf, fract_mult, &integer, &fract,
+				    scale_db);
+	if (ret)
+		return ret;
 
 	ret = indio_dev->info->write_raw(indio_dev, this_attr->c,
 					 integer, fract, this_attr->address);
-- 
2.17.1

