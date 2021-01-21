Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CC22FE95C
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 12:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbhAULyf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 06:54:35 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6646 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729774AbhAULsv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 06:48:51 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10LBdjI2003557;
        Thu, 21 Jan 2021 06:47:55 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rce6sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 06:47:55 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 10LBlrAd033327
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Jan 2021 06:47:53 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Thu, 21 Jan 2021 03:47:52 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 21 Jan 2021 03:47:52 -0800
Received: from nsa.sphairon.box ([10.44.3.51])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10LBllDg013729;
        Thu, 21 Jan 2021 06:47:49 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/4] iio: adis: add helpers for locking
Date:   Thu, 21 Jan 2021 12:49:51 +0100
Message-ID: <20210121114954.64156-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121114954.64156-1-nuno.sa@analog.com>
References: <20210121114954.64156-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-21_04:2021-01-21,2021-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210064
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add some helpers to lock and unlock the device.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 include/linux/iio/imu/adis.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 04e96d688ba9..f9b728d490b1 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -428,6 +428,16 @@ static inline int adis_initial_startup(struct adis *adis)
 	return ret;
 }
 
+static inline void adis_dev_lock(struct adis *adis)
+{
+	mutex_lock(&adis->state_lock);
+}
+
+static inline void adis_dev_unlock(struct adis *adis)
+{
+	mutex_unlock(&adis->state_lock);
+}
+
 int adis_single_conversion(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int error_mask,
 	int *val);
-- 
2.30.0

