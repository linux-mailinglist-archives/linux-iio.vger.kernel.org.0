Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B9E400114
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhICOMm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 10:12:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14072 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231164AbhICOMm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 10:12:42 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1833YOqs015763;
        Fri, 3 Sep 2021 10:11:31 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3aubwmtu9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 10:11:30 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 183EBTDQ023577
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Sep 2021 10:11:29 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 3 Sep 2021 07:11:28 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 3 Sep 2021 07:11:27 -0700
Received: from nsa.ad.analog.com ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 183EBOFB024311;
        Fri, 3 Sep 2021 10:11:25 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH 1/5] iio: adis: do not disabe IRQs in 'adis_init()'
Date:   Fri, 3 Sep 2021 16:14:19 +0200
Message-ID: <20210903141423.517028-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903141423.517028-1-nuno.sa@analog.com>
References: <20210903141423.517028-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: obwKpaok6YZnGu6VBboM9TTLWJjAt6UG
X-Proofpoint-ORIG-GUID: obwKpaok6YZnGu6VBboM9TTLWJjAt6UG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_05,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030088
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With commit ecb010d441088 ("iio: imu: adis: Refactor adis_initial_startup")
we are doing a HW or SW reset to the device which means that we'll get
the default state of the data ready pin (which is enabled). Hence there's
no point in disabling the IRQ in the init function. Moreover, this
function is intended to initialize internal data structures and not
really do anything on the device.

As a result of this, some devices were left with the data ready pin enabled
after probe which was not the desired behavior. Thus, we move the call to
'adis_enable_irq()' to the initial startup function where it makes more
sense for it to be.

Note that for devices that cannot mask/unmask the pin, it makes no sense
to call the function at this point since the IRQ should not have been
yet requested. This will be improved in a follow up change.

Fixes: ecb010d441088 ("iio: imu: adis: Refactor adis_initial_startup")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index b9a06ca29bee..d4e692b187cd 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -430,6 +430,8 @@ int __adis_initial_startup(struct adis *adis)
 	if (ret)
 		return ret;
 
+	adis_enable_irq(adis, false);
+
 	if (!adis->data->prod_id_reg)
 		return 0;
 
@@ -526,7 +528,7 @@ int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 		adis->current_page = 0;
 	}
 
-	return adis_enable_irq(adis, false);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(adis_init);
 
-- 
2.33.0

