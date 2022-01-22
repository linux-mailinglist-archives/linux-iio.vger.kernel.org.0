Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3930B496C77
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jan 2022 14:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiAVNJl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jan 2022 08:09:41 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1422 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232537AbiAVNJl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jan 2022 08:09:41 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20M6QxQA027255;
        Sat, 22 Jan 2022 08:09:30 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3drcna0g79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jan 2022 08:09:29 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20MD9Sug002427
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 22 Jan 2022 08:09:28 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 22 Jan 2022 08:09:27 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 22 Jan 2022 08:09:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 22 Jan 2022 08:09:27 -0500
Received: from NSA-L01.ad.analog.com ([10.32.224.71])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20MD9BHS004310;
        Sat, 22 Jan 2022 08:09:13 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v2 1/3] MAINTAINERS: add missing files to the adis lib
Date:   Sat, 22 Jan 2022 14:09:03 +0100
Message-ID: <20220122130905.99-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: p_k-cDLF4MDOamPmEtX6DBXAbd2PI6Sp
X-Proofpoint-ORIG-GUID: p_k-cDLF4MDOamPmEtX6DBXAbd2PI6Sp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-22_04,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=942 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201220092
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The triggered buffer support was missing in the MAINTAINERS file. Add
them.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
changes in v2:
 * none.

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 78881bbaf3c0..7527466b436d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1103,6 +1103,8 @@ M:	Nuno Sa <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/imu/adis.c
+F:	drivers/iio/imu/adis_buffer.c
+F:	drivers/iio/imu/adis_trigger.c
 F:	include/linux/iio/imu/adis.h
 
 ANALOG DEVICES INC ADIS16460 DRIVER
-- 
2.17.1

