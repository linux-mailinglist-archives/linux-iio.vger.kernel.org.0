Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBC35B3B9D
	for <lists+linux-iio@lfdr.de>; Fri,  9 Sep 2022 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiIIPNo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Sep 2022 11:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiIIPNg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Sep 2022 11:13:36 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901D81449E4;
        Fri,  9 Sep 2022 08:13:34 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289F7Qqo002113;
        Fri, 9 Sep 2022 11:13:15 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jfu4m50r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 11:13:15 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 289FDDu8025311
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Sep 2022 11:13:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 Sep 2022
 11:13:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 Sep 2022 11:13:13 -0400
Received: from nsa.sphairon.box ([10.44.3.57])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 289FCw9l024296;
        Fri, 9 Sep 2022 11:13:06 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 1/3] iio: adc: ad7923: fix channel readings for some variants
Date:   Fri, 9 Sep 2022 17:14:11 +0200
Message-ID: <20220909151413.1164754-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909151413.1164754-1-nuno.sa@analog.com>
References: <20220909151413.1164754-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: rX8RILpApa59nXkHxOmXc9PPWR60LHPA
X-Proofpoint-GUID: rX8RILpApa59nXkHxOmXc9PPWR60LHPA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090053
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some of the supported devices have 4 or 2 LSB trailing bits that should
not be taken into account. Hence we need to shift these bits out which
fits perfectly on the scan type shift property. This change fixes both
raw and buffered reads.

Fixes: f2f7a449707e ("iio:adc:ad7923: Add support for the ad7904/ad7914/ad7924")
Fixes: 851644a60d20 ("iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7923.c | 46 +++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index edad1f30121d..910cf05e75cd 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -80,7 +80,7 @@ enum ad7923_id {
 	AD7928
 };
 
-#define AD7923_V_CHAN(index, bits)					\
+#define AD7923_V_CHAN(index, bits, _shift)				\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
@@ -93,38 +93,39 @@ enum ad7923_id {
 			.sign = 'u',					\
 			.realbits = (bits),				\
 			.storagebits = 16,				\
+			.shift = (_shift),				\
 			.endianness = IIO_BE,				\
 		},							\
 	}
 
-#define DECLARE_AD7923_CHANNELS(name, bits) \
+#define DECLARE_AD7923_CHANNELS(name, bits, shift) \
 const struct iio_chan_spec name ## _channels[] = { \
-	AD7923_V_CHAN(0, bits), \
-	AD7923_V_CHAN(1, bits), \
-	AD7923_V_CHAN(2, bits), \
-	AD7923_V_CHAN(3, bits), \
+	AD7923_V_CHAN(0, bits, shift), \
+	AD7923_V_CHAN(1, bits, shift), \
+	AD7923_V_CHAN(2, bits, shift), \
+	AD7923_V_CHAN(3, bits, shift), \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
 }
 
-#define DECLARE_AD7908_CHANNELS(name, bits) \
+#define DECLARE_AD7908_CHANNELS(name, bits, shift) \
 const struct iio_chan_spec name ## _channels[] = { \
-	AD7923_V_CHAN(0, bits), \
-	AD7923_V_CHAN(1, bits), \
-	AD7923_V_CHAN(2, bits), \
-	AD7923_V_CHAN(3, bits), \
-	AD7923_V_CHAN(4, bits), \
-	AD7923_V_CHAN(5, bits), \
-	AD7923_V_CHAN(6, bits), \
-	AD7923_V_CHAN(7, bits), \
+	AD7923_V_CHAN(0, bits, shift), \
+	AD7923_V_CHAN(1, bits, shift), \
+	AD7923_V_CHAN(2, bits, shift), \
+	AD7923_V_CHAN(3, bits, shift), \
+	AD7923_V_CHAN(4, bits, shift), \
+	AD7923_V_CHAN(5, bits, shift), \
+	AD7923_V_CHAN(6, bits, shift), \
+	AD7923_V_CHAN(7, bits, shift), \
 	IIO_CHAN_SOFT_TIMESTAMP(8), \
 }
 
-static DECLARE_AD7923_CHANNELS(ad7904, 8);
-static DECLARE_AD7923_CHANNELS(ad7914, 10);
-static DECLARE_AD7923_CHANNELS(ad7924, 12);
-static DECLARE_AD7908_CHANNELS(ad7908, 8);
-static DECLARE_AD7908_CHANNELS(ad7918, 10);
-static DECLARE_AD7908_CHANNELS(ad7928, 12);
+static DECLARE_AD7923_CHANNELS(ad7904, 8, 4);
+static DECLARE_AD7923_CHANNELS(ad7914, 10, 2);
+static DECLARE_AD7923_CHANNELS(ad7924, 12, 0);
+static DECLARE_AD7908_CHANNELS(ad7908, 8, 4);
+static DECLARE_AD7908_CHANNELS(ad7918, 10, 2);
+static DECLARE_AD7908_CHANNELS(ad7928, 12, 0);
 
 static const struct ad7923_chip_info ad7923_chip_info[] = {
 	[AD7904] = {
@@ -268,7 +269,8 @@ static int ad7923_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		if (chan->address == EXTRACT(ret, 12, 4))
-			*val = EXTRACT(ret, 0, 12);
+			*val = EXTRACT(ret, chan->scan_type.shift,
+				       chan->scan_type.realbits);
 		else
 			return -EIO;
 
-- 
2.37.3

