Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB891202A7B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jun 2020 14:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgFUMcA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jun 2020 08:32:00 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4582 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730025AbgFUMb4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2020 08:31:56 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05LCN6vj029869;
        Sun, 21 Jun 2020 08:31:40 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31sfc5abff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Jun 2020 08:31:40 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 05LCVc7R063666
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 21 Jun 2020 08:31:38 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Sun, 21 Jun
 2020 05:31:36 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 21 Jun 2020 05:31:36 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05LCVWVa007980;
        Sun, 21 Jun 2020 08:31:34 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 1/7] iio: core: remove iio_priv_to_dev() helper
Date:   Sun, 21 Jun 2020 15:33:39 +0300
Message-ID: <20200621123345.2469-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200621123345.2469-1-alexandru.ardelean@analog.com>
References: <20200621123345.2469-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-21_05:2020-06-19,2020-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 spamscore=0
 priorityscore=1501 mlxlogscore=999 cotscore=-2147483648 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006210101
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All users of this helper have been updated to not use it.
Remove it now, so that we don't need to move it when creating the
iio_dev_opaque structure.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/iio.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 1c1d02107722..10a6d97a8e3e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -703,12 +703,6 @@ static inline void *iio_priv(const struct iio_dev *indio_dev)
 	return (char *)indio_dev + ALIGN(sizeof(struct iio_dev), IIO_ALIGN);
 }
 
-static inline struct iio_dev *iio_priv_to_dev(void *priv)
-{
-	return (struct iio_dev *)((char *)priv -
-				  ALIGN(sizeof(struct iio_dev), IIO_ALIGN));
-}
-
 void iio_device_free(struct iio_dev *indio_dev);
 struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
 struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
-- 
2.17.1

