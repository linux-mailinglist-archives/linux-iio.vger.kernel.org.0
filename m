Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35145B3BA3
	for <lists+linux-iio@lfdr.de>; Fri,  9 Sep 2022 17:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiIIPNm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Sep 2022 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiIIPNh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Sep 2022 11:13:37 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B0F1449F3;
        Fri,  9 Sep 2022 08:13:35 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289C8ed1030790;
        Fri, 9 Sep 2022 11:13:16 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jf8yc4b47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 11:13:16 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 289FDF35025320
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Sep 2022 11:13:15 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 9 Sep 2022 11:13:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 9 Sep 2022 11:13:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 Sep 2022 11:13:14 -0400
Received: from nsa.sphairon.box ([10.44.3.57])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 289FCw9m024296;
        Fri, 9 Sep 2022 11:13:07 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 2/3] iio: adc: ad7923: support extended range
Date:   Fri, 9 Sep 2022 17:14:12 +0200
Message-ID: <20220909151413.1164754-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909151413.1164754-1-nuno.sa@analog.com>
References: <20220909151413.1164754-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Cqim13b8Lz6ZtSUVmfdIh3bhne1uk-Uv
X-Proofpoint-ORIG-GUID: Cqim13b8Lz6ZtSUVmfdIh3bhne1uk-Uv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090053
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By default the driver was always setting the RANGE bit which means that
the analog input goes from 0 to VREF. However, we might want to have 0
to 2xVREF. This change adds a new FW property to allow for the range
selection while keeping the default behavior if nothing is provided.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7923.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 910cf05e75cd..4bd0ae209d18 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -6,8 +6,10 @@
  * Copyright 2012 CS Systemes d'Information
  */
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
@@ -45,6 +47,8 @@
 /* val = value, dec = left shift, bits = number of bits of the mask */
 #define EXTRACT(val, dec, bits)		(((val) >> (dec)) & ((1 << (bits)) - 1))
 
+#define AD7923_RANGE_0_VREF	1
+
 struct ad7923_state {
 	struct spi_device		*spi;
 	struct spi_transfer		ring_xfer[5];
@@ -300,6 +304,7 @@ static void ad7923_regulator_disable(void *data)
 
 static int ad7923_probe(struct spi_device *spi)
 {
+	u32 ad7923_range = FIELD_PREP(AD7923_RANGE, AD7923_RANGE_0_VREF), val;
 	struct ad7923_state *st;
 	struct iio_dev *indio_dev;
 	const struct ad7923_chip_info *info;
@@ -311,8 +316,17 @@ static int ad7923_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	ret = device_property_read_u32(&spi->dev, "adi,range-select", &val);
+	if (!ret) {
+		if (val > AD7923_RANGE_0_VREF)
+			return dev_err_probe(&spi->dev, -EINVAL,
+					     "Invalid range (%u) selected\n", val);
+
+		ad7923_range = FIELD_PREP(AD7923_RANGE, val);
+	}
+
 	st->spi = spi;
-	st->settings = AD7923_CODING | AD7923_RANGE |
+	st->settings = AD7923_CODING | ad7923_range |
 			AD7923_PM_MODE_WRITE(AD7923_PM_MODE_OPS);
 
 	info = &ad7923_chip_info[spi_get_device_id(spi)->driver_data];
-- 
2.37.3

