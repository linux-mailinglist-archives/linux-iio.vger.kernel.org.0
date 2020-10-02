Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BEA280EB9
	for <lists+linux-iio@lfdr.de>; Fri,  2 Oct 2020 10:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgJBI1b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Oct 2020 04:27:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26984 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbgJBI1a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Oct 2020 04:27:30 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0928LlsA025681;
        Fri, 2 Oct 2020 04:27:29 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4wm8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 04:27:29 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0928RROf040519
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Oct 2020 04:27:27 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 2 Oct 2020 01:27:17 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 2 Oct 2020 01:27:16 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 2 Oct 2020 01:27:16 -0700
Received: from saturn.ad.analog.com ([10.48.65.110])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0928ROCL010924;
        Fri, 2 Oct 2020 04:27:24 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: adc: ad7887: invert/rework external ref logic
Date:   Fri, 2 Oct 2020 11:27:23 +0300
Message-ID: <20201002082723.184810-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001141143.925-1-alexandru.ardelean@analog.com>
References: <20201001141143.925-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_05:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=924 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020064
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

Changelog v1 -> v2:
* remove omitted '!pdata->use_onchip_ref' check; the field was removed from
  the platform data, but was still used

 drivers/iio/adc/ad7887.c             | 12 ++++++++----
 include/linux/platform_data/ad7887.h |  4 ----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 037bcb47693c..99a480ad3985 100644
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
@@ -269,7 +273,7 @@ static int ad7887_probe(struct spi_device *spi)
 	/* Setup default message */
 
 	mode = AD7887_PM_MODE4;
-	if (!pdata || !pdata->use_onchip_ref)
+	if (!st->reg)
 		mode |= AD7887_REF_DIS;
 	if (pdata && pdata->en_dual)
 		mode |= AD7887_DUAL;
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
2.25.1

