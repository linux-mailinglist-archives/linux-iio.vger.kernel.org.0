Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5CD318A85
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 13:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhBKM0d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 07:26:33 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:36236 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231685AbhBKMX5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 07:23:57 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BCLWNQ025201;
        Thu, 11 Feb 2021 07:23:05 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hrw905bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 07:23:04 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11BCN3qd004292
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Feb 2021 07:23:03 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 11 Feb 2021
 07:23:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 11 Feb 2021 07:23:02 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11BCMYWn011557;
        Thu, 11 Feb 2021 07:23:01 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v5 15/17] tools: iio: make iioutils_get_type() private in iio_utils
Date:   Thu, 11 Feb 2021 14:24:50 +0200
Message-ID: <20210211122452.78106-16-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211122452.78106-1-alexandru.ardelean@analog.com>
References: <20210211122452.78106-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_06:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110110
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

