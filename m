Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89BE31634F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 11:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBJKJo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 05:09:44 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62156 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230419AbhBJKHY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 05:07:24 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AA6PKq022840;
        Wed, 10 Feb 2021 05:06:32 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hr7qc5xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:06:32 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11AA6VuZ035803
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 10 Feb 2021 05:06:31 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 10 Feb 2021 05:06:30 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Wed, 10 Feb 2021 05:06:29 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 10 Feb 2021 05:06:29 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11AA5x0L018045;
        Wed, 10 Feb 2021 05:06:27 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 15/17] tools: iio: make iioutils_get_type() private in iio_utils
Date:   Wed, 10 Feb 2021 12:08:21 +0200
Message-ID: <20210210100823.46780-16-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210100823.46780-1-alexandru.ardelean@analog.com>
References: <20210210100823.46780-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_03:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100098
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a bit of a tidy-up, but also helps with extending the
iioutils_get_type() function a bit, as we don't need to use it outside of
the iio_utils.c file. So, we'll need to update it only in one place.

With this change, the 'unsigned' types are updated to 'unsigned int' in the
iioutils_get_type() function definition.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 tools/iio/iio_utils.c | 9 +++++----
 tools/iio/iio_utils.h | 4 ----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 7399eb7f1378..a96002f2c2d5 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -82,10 +82,11 @@ int iioutils_break_up_name(const char *full_name, char **generic_name)
  *
  * Returns a value >= 0 on success, otherwise a negative error code.
  **/
-int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
-		      unsigned *shift, uint64_t *mask, unsigned *be,
-		      const char *device_dir, const char *name,
-		      const char *generic_name)
+static int iioutils_get_type(unsigned int *is_signed, unsigned int *bytes,
+			     unsigned int *bits_used, unsigned int *shift,
+			     uint64_t *mask, unsigned int *be,
+			     const char *device_dir, const char *name,
+			     const char *generic_name)
 {
 	FILE *sysfsfp;
 	int ret;
diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
index 74bde4fde2c8..a5d0aa8a57d3 100644
--- a/tools/iio/iio_utils.h
+++ b/tools/iio/iio_utils.h
@@ -57,10 +57,6 @@ static inline int iioutils_check_suffix(const char *str, const char *suffix)
 }
 
 int iioutils_break_up_name(const char *full_name, char **generic_name);
-int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
-		      unsigned *shift, uint64_t *mask, unsigned *be,
-		      const char *device_dir, const char *name,
-		      const char *generic_name);
 int iioutils_get_param_float(float *output, const char *param_name,
 			     const char *device_dir, const char *name,
 			     const char *generic_name);
-- 
2.17.1

