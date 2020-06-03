Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B17C1ECE96
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 13:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgFCLkj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 07:40:39 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23670 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbgFCLke (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2020 07:40:34 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 053Bdej8022901;
        Wed, 3 Jun 2020 07:40:33 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31e4scs6a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 07:40:32 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 053BeVLQ029997
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 3 Jun 2020 07:40:31 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 3 Jun 2020 04:40:30 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 3 Jun 2020 04:40:29 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 3 Jun 2020 04:40:29 -0700
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 053BeOtI017839;
        Wed, 3 Jun 2020 07:40:27 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <johan@kernel.org>, <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/6] iio: core: add iio_device_set_parent() helper
Date:   Wed, 3 Jun 2020 14:40:19 +0300
Message-ID: <20200603114023.175102-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603114023.175102-1-alexandru.ardelean@analog.com>
References: <20200603114023.175102-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_11:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 cotscore=-2147483648 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030093
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By default, the device allocation will also assign a parent device to the
IIO device object. In cases where devm_iio_device_alloc() is used,
sometimes the parent device must be different than the device used to
manage the allocation.

In that case, this helper should be used to change the parent, hence the
requirement to call this between allocation & registration.

This pattern/requirement is not very common in the IIO space, and it may be
cleaned up later.
But until then, assigning the parent manually between allocation &
registration is slightly easier.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/iio.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 91a69f4751aa..5784f8c9508f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -649,6 +649,26 @@ static inline struct iio_dev *iio_device_get(struct iio_dev *indio_dev)
 	return indio_dev ? dev_to_iio_dev(get_device(&indio_dev->dev)) : NULL;
 }
 
+/**
+ * iio_device_set_parent() - assign parent device to the IIO device object
+ * @indio_dev: 		IIO device structure
+ * @parent:		reference to parent device object
+ *
+ * This utility must be called between IIO device allocation
+ * (via devm_iio_device_alloc()) & IIO device registration
+ * (via {devm_}iio_device_register()).
+ * By default, the device allocation will also assign a parent device to
+ * the IIO device object. In cases where devm_iio_device_alloc() is used,
+ * sometimes the parent device must be different than the device used to
+ * manage the allocation.
+ * In that case, this helper should be used to change the parent, hence the
+ * requirement to call this between allocation & registration.
+ **/
+static inline void iio_device_set_parent(struct iio_dev *indio_dev,
+					 struct device *parent)
+{
+	indio_dev->dev.parent = parent;
+}
 
 /**
  * iio_device_set_drvdata() - Set device driver data
-- 
2.25.1

