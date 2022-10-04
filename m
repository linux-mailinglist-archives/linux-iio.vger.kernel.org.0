Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3B5F44B6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 15:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJDNtn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Oct 2022 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJDNtj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 09:49:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4B32B255
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 06:49:32 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294C9Ox8025012;
        Tue, 4 Oct 2022 09:48:33 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jxjf733g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 09:48:33 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 294DmWpP001531
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Oct 2022 09:48:32 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Oct 2022
 09:48:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Oct 2022 09:48:31 -0400
Received: from nsa.ad.analog.com ([10.44.3.52])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 294DlkVY032663;
        Tue, 4 Oct 2022 09:48:19 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 01/16] iio: adc: ad799x: do not use internal iio_dev lock
Date:   Tue, 4 Oct 2022 15:48:54 +0200
Message-ID: <20221004134909.1692021-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004134909.1692021-1-nuno.sa@analog.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: SS5WqGEP61nJ1tXif6qOZQ3eX25vwLYQ
X-Proofpoint-ORIG-GUID: SS5WqGEP61nJ1tXif6qOZQ3eX25vwLYQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040089
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

'mlock' was being grabbed when setting the device frequency. In order to
not introduce any functional change a new lock is added. With that in
mind, the lock also needs to be grabbed in the places where 'mlock' is
since it was also being used to protect st->config against the current
device state.

On the other places the lock was being used, we can just drop
it since we are only doing one i2c bus read/write which is already
safe.

While at it, properly include "mutex.h" for mutex related APIs.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ad799x.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 262bd7665b33..44f7a80a0749 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/bitops.h>
 
 #include <linux/iio/iio.h>
@@ -125,6 +126,8 @@ struct ad799x_state {
 	const struct ad799x_chip_config	*chip_config;
 	struct regulator		*reg;
 	struct regulator		*vref;
+	/* lock to protect against multiple access to the device */
+	struct mutex			lock;
 	unsigned			id;
 	u16				config;
 
@@ -290,7 +293,9 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
+		mutex_lock(&st->lock);
 		ret = ad799x_scan_direct(st, chan->scan_index);
+		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 
 		if (ret < 0)
@@ -351,7 +356,8 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
+
 	ret = i2c_smbus_read_byte_data(st->client, AD7998_CYCLE_TMR_REG);
 	if (ret < 0)
 		goto error_ret_mutex;
@@ -373,7 +379,7 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 	ret = len;
 
 error_ret_mutex:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -407,6 +413,8 @@ static int ad799x_write_event_config(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	mutex_lock(&st->lock);
+
 	if (state)
 		st->config |= BIT(chan->scan_index) << AD799X_CHANNEL_SHIFT;
 	else
@@ -418,6 +426,7 @@ static int ad799x_write_event_config(struct iio_dev *indio_dev,
 		st->config &= ~AD7998_ALERT_EN;
 
 	ret = ad799x_write_config(st, st->config);
+	mutex_unlock(&st->lock);
 	iio_device_release_direct_mode(indio_dev);
 	return ret;
 }
@@ -454,11 +463,9 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
 	if (val < 0 || val > GENMASK(chan->scan_type.realbits - 1, 0))
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
 	ret = i2c_smbus_write_word_swapped(st->client,
 		ad799x_threshold_reg(chan, dir, info),
 		val << chan->scan_type.shift);
-	mutex_unlock(&indio_dev->mlock);
 
 	return ret;
 }
@@ -473,10 +480,8 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
 	int ret;
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&indio_dev->mlock);
 	ret = i2c_smbus_read_word_swapped(st->client,
 		ad799x_threshold_reg(chan, dir, info));
-	mutex_unlock(&indio_dev->mlock);
 	if (ret < 0)
 		return ret;
 	*val = (ret >> chan->scan_type.shift) &
@@ -863,6 +868,9 @@ static int ad799x_probe(struct i2c_client *client,
 		if (ret)
 			goto error_cleanup_ring;
 	}
+
+	mutex_init(&st->lock);
+
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_cleanup_ring;
-- 
2.37.3

