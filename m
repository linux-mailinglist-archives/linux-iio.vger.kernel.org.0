Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC482800E4
	for <lists+linux-iio@lfdr.de>; Thu,  1 Oct 2020 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbgJAOHV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Oct 2020 10:07:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56672 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732018AbgJAOHV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Oct 2020 10:07:21 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091Dviuw009746;
        Thu, 1 Oct 2020 10:07:19 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4u3a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 10:07:19 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 091E7H4I003282
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 1 Oct 2020 10:07:17 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 1 Oct 2020 07:07:07 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 1 Oct 2020 07:07:07 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 1 Oct 2020 07:07:07 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 091E7Djx029050;
        Thu, 1 Oct 2020 10:07:13 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adc: ad7887: invert/rework external ref logic
Date:   Thu, 1 Oct 2020 17:11:43 +0300
Message-ID: <20201001141143.925-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_04:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010120
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change inverts/reworks the logic to use an external reference via a
provided regulator.

Now the driver tries to obtain a regulator. If one is found, then it is
used. The rest of the driver logic already checks if there is a non-NULL
reference to a regulator, so it should be fine.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7887.c             | 10 +++++++---
 include/linux/platform_data/ad7887.h |  4 ----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 037bcb47693c..9b32b1f43c34 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -246,11 +246,15 @@ static int ad7887_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	if (!pdata || !pdata->use_onchip_ref) {
-		st->reg = devm_regulator_get(&spi->dev, "vref");
-		if (IS_ERR(st->reg))
+	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
+	if (IS_ERR(st->reg)) {
+		if (PTR_ERR(st->reg) != -ENODEV)
 			return PTR_ERR(st->reg);
 
+		st->reg = NULL;
+	}
+
+	if (st->reg) {
 		ret = regulator_enable(st->reg);
 		if (ret)
 			return ret;
diff --git a/include/linux/platform_data/ad7887.h b/include/linux/platform_data/ad7887.h
index 732af46b2d16..9b4dca6ae70b 100644
--- a/include/linux/platform_data/ad7887.h
+++ b/include/linux/platform_data/ad7887.h
@@ -13,13 +13,9 @@
  *	second input channel, and Vref is internally connected to Vdd. If set to
  *	false the device is used in single channel mode and AIN1/Vref is used as
  *	VREF input.
- * @use_onchip_ref: Whether to use the onchip reference. If set to true the
- *	internal 2.5V reference is used. If set to false a external reference is
- *	used.
  */
 struct ad7887_platform_data {
 	bool en_dual;
-	bool use_onchip_ref;
 };
 
 #endif /* IIO_ADC_AD7887_H_ */
-- 
2.17.1

