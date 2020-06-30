Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A637020ECFB
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 06:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgF3Eys (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 00:54:48 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35782 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729480AbgF3Eys (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 00:54:48 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U4nxYp007814;
        Tue, 30 Jun 2020 00:54:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 31wyy6836w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 00:54:32 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05U4rvVQ021607;
        Tue, 30 Jun 2020 00:54:32 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31wyy6836t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 00:54:32 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 05U4sU9Z023144
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 30 Jun 2020 00:54:31 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 30 Jun
 2020 00:54:29 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 30 Jun 2020 00:54:29 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05U4sPIk018305;
        Tue, 30 Jun 2020 00:54:27 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 1/7] iio: core: remove iio_priv_to_dev() helper
Date:   Tue, 30 Jun 2020 07:57:02 +0300
Message-ID: <20200630045708.14166-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630045708.14166-1-alexandru.ardelean@analog.com>
References: <20200630045708.14166-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 spamscore=0
 cotscore=-2147483648 adultscore=0 mlxlogscore=952 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300035
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All users of this helper have been updated to not use it.
Remove it now, so that we don't need to move it when creating the
iio_dev_opaque structure.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

