Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537005F44B4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 15:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiJDNtl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Oct 2022 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJDNtj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 09:49:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36B8B05
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 06:49:36 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294C9OxI025012;
        Tue, 4 Oct 2022 09:48:53 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jxjf733jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 09:48:52 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 294Dmo4m001556
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Oct 2022 09:48:51 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Oct 2022 09:48:50 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Oct 2022 09:48:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Oct 2022 09:48:49 -0400
Received: from nsa.ad.analog.com ([10.44.3.52])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 294DlkVc032663;
        Tue, 4 Oct 2022 09:48:38 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Ciprian Regus" <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "Florian Boor" <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Chen-Yu Tsai" <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 05/16] iio: adc: ltc2947-core: do not use internal iio_dev lock
Date:   Tue, 4 Oct 2022 15:48:58 +0200
Message-ID: <20221004134909.1692021-6-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004134909.1692021-1-nuno.sa@analog.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: h1i7uS13TU4xze-n0huACFZmMzuzQrnl
X-Proofpoint-ORIG-GUID: h1i7uS13TU4xze-n0huACFZmMzuzQrnl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=996 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040089
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_device lock is only meant for internal use. Hence define a
device local lock to protect against concurrent accesses.

While at it, properly include "mutex.h" for mutex related APIs.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ltc2497-core.c | 7 +++++--
 drivers/iio/adc/ltc2497.h      | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index f52d37af4d1f..996f6cbbed3c 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -10,6 +10,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
 
 #include "ltc2497.h"
@@ -81,9 +82,9 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&ddata->lock);
 		ret = ltc2497core_read(ddata, chan->address, val);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&ddata->lock);
 		if (ret < 0)
 			return ret;
 
@@ -214,6 +215,8 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 	ddata->addr_prev = LTC2497_CONFIG_DEFAULT;
 	ddata->time_prev = ktime_get();
 
+	mutex_init(&ddata->lock);
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
 		goto err_array_unregister;
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index e023de0d88c4..781519b52475 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -12,6 +12,8 @@ struct ltc2497_chip_info {
 struct ltc2497core_driverdata {
 	struct regulator *ref;
 	ktime_t	time_prev;
+	/* lock to protect against multiple access to the device */
+	struct mutex lock;
 	const struct ltc2497_chip_info	*chip_info;
 	u8 addr_prev;
 	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
-- 
2.37.3

