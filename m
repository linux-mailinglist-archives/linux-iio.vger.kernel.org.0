Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB8B167C73
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 12:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBULrE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 06:47:04 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4668 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726989AbgBULrD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2020 06:47:03 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LBiCPA018888;
        Fri, 21 Feb 2020 06:47:02 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y8ucu71aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 06:47:01 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01LBl0uY029352
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 21 Feb 2020 06:47:00 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 21 Feb 2020 06:47:00 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 21 Feb 2020 06:46:59 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 21 Feb 2020 06:46:59 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01LBku5N017142;
        Fri, 21 Feb 2020 06:46:58 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] iio: imu: adis: update 'adis_data' struct doc-string
Date:   Fri, 21 Feb 2020 13:49:42 +0200
Message-ID: <20200221114943.2056-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221114943.2056-1-alexandru.ardelean@analog.com>
References: <20200221114943.2056-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_03:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210090
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The doc-string has been neglected over time.
This change updates it with all the missing info.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/imu/adis.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 0787a3aabd05..11c915b61ae2 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -43,10 +43,14 @@ struct adis_timeout {
  * @diag_stat_reg: Register address of the DIAG_STAT register
  * @prod_id_reg: Register address of the PROD_ID register
  * @prod_id: Product ID code that should be expected when reading @prod_id_reg
+ * @self_test_mask: Bitmask of supported self-test operations
  * @self_test_reg: Register address to request self test command
+ * @self_test_no_autoclear: True if device's self-test needs clear of ctrl reg
  * @status_error_msgs: Array of error messgaes
- * @status_error_mask:
+ * @status_error_mask: Bitmask of errors supported by the device
  * @timeouts: Chip specific delays
+ * @enable_irq: Hook for ADIS devices that have a special IRQ enable/disable
+ * @has_paging: True if ADIS device has paged registers
  */
 struct adis_data {
 	unsigned int read_delay;
-- 
2.20.1

