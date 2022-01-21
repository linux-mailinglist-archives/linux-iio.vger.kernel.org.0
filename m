Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3823E496238
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jan 2022 16:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbiAUPl3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jan 2022 10:41:29 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44098 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381641AbiAUPl3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jan 2022 10:41:29 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LCiRQa015438;
        Fri, 21 Jan 2022 10:41:16 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dqj1bbann-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 10:41:16 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20LFfFKl049860
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jan 2022 10:41:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 21 Jan
 2022 10:41:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 21 Jan 2022 10:41:14 -0500
Received: from NSA-L01.ad.analog.com ([10.32.224.71])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20LFf3vM021092;
        Fri, 21 Jan 2022 10:41:08 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 2/3] adis: simplify 'adis_update_bits' macros
Date:   Fri, 21 Jan 2022 16:40:56 +0100
Message-ID: <20220121154057.251-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121154057.251-1-nuno.sa@analog.com>
References: <20220121154057.251-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 0qj7bxSLdZjpm5ivgzkfTkz2F07gW0vp
X-Proofpoint-ORIG-GUID: 0qj7bxSLdZjpm5ivgzkfTkz2F07gW0vp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_08,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=879 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201210105
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There's no need to use  '__builtin_choose_expr' to choose the right
call to 'adis_update_bits_base()'. We can change the 'BUILD_BUG_ON()'
condition so that it makes sure only the supported sizes are
passed in. With that, we can just use 'sizeof(val)' as the size argument
of 'adis_update_bits_base()'.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 include/linux/iio/imu/adis.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 7c02f5292eea..186e5f40df16 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -381,10 +381,8 @@ static inline int adis_update_bits_base(struct adis *adis, unsigned int reg,
  * @val can lead to undesired behavior if the register to update is 16bit.
  */
 #define adis_update_bits(adis, reg, mask, val) ({			\
-	BUILD_BUG_ON(sizeof(val) == 1 || sizeof(val) == 8);		\
-	__builtin_choose_expr(sizeof(val) == 4,				\
-		adis_update_bits_base(adis, reg, mask, val, 4),         \
-		adis_update_bits_base(adis, reg, mask, val, 2));	\
+	BUILD_BUG_ON(sizeof(val) != 2 && sizeof(val) == 4);		\
+	adis_update_bits_base(adis, reg, mask, val, sizeof(val));	\
 })
 
 /**
@@ -399,10 +397,8 @@ static inline int adis_update_bits_base(struct adis *adis, unsigned int reg,
  * @val can lead to undesired behavior if the register to update is 16bit.
  */
 #define __adis_update_bits(adis, reg, mask, val) ({			\
-	BUILD_BUG_ON(sizeof(val) == 1 || sizeof(val) == 8);		\
-	__builtin_choose_expr(sizeof(val) == 4,				\
-		__adis_update_bits_base(adis, reg, mask, val, 4),	\
-		__adis_update_bits_base(adis, reg, mask, val, 2));	\
+	BUILD_BUG_ON(sizeof(val) != 2 && sizeof(val) != 4);		\
+	__adis_update_bits_base(adis, reg, mask, val, sizeof(val));	\
 })
 
 int adis_enable_irq(struct adis *adis, bool enable);
-- 
2.34.1

