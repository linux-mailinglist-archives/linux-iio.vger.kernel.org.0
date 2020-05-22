Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F71DE1F8
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 10:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgEVIgU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 04:36:20 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12750 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729151AbgEVIgQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 04:36:16 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04M8Ycah015231;
        Fri, 22 May 2020 04:36:16 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 312a17dtf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 May 2020 04:36:16 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04M8aEdB040277
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 22 May 2020 04:36:14 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 01:36:13 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 01:36:12 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 22 May 2020 01:36:12 -0700
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04M8ZhUQ005306;
        Fri, 22 May 2020 04:36:03 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-input@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <devel@driverdev.osuosl.org>
CC:     <vilhelm.gray@gmail.com>, <syednwaris@gmail.com>,
        <fabrice.gasnier@st.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <jic23@kernel.org>,
        <dan@dlrobertson.com>, <jikos@kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <linus.walleij@linaro.org>,
        <wens@csie.org>, <hdegoede@redhat.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <peda@axentia.se>, <kgene@kernel.org>,
        <krzk@kernel.org>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <ak@it-klinger.de>, <paul@crapouillou.net>, <milo.kim@ti.com>,
        <vz@mleia.com>, <slemieux.tyco@gmail.com>, <khilman@baylibre.com>,
        <matthias.bgg@gmail.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <heiko@sntech.de>,
        <orsonzhai@gmail.com>, <baolin.wang7@gmail.com>,
        <zhang.lyra@gmail.com>, <mripard@kernel.org>, <tduszyns@gmail.com>,
        <rmfrfs@gmail.com>, <lorenzo.bianconi83@gmail.com>,
        <ktsai@capellamicro.com>, <songqiang1304521@gmail.com>,
        <tomislav.denis@avl.com>, <eajames@linux.ibm.com>,
        <dmitry.torokhov@gmail.com>, <coproscefalo@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/5] iio: remove left-over comments about parent assignment
Date:   Fri, 22 May 2020 11:22:06 +0300
Message-ID: <20200522082208.383631-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522082208.383631-1-alexandru.ardelean@analog.com>
References: <20200522082208.383631-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_05:2020-05-21,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=796 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220070
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These were obtained by doing a 'git diff | grep \/\*', in the previous diff
to find comments. These needed a bit more manual review, as the semantic
patch isn't great for catching these.

The result is:
 	/* Initialize Counter device and driver data */
 	/* Initialize IIO device */
 	/* Establish that the iio_dev is a child of the spi device */
 	/* Estabilish that the iio_dev is a child of the spi device */
 	/* Initiate the Industrial I/O device */
 	/* Establish that the iio_dev is a child of the device */
-	/* establish that the iio_dev is a child of the i2c device */
-	/* establish that the iio_dev is a child of the i2c device */
 	/* This is only used for removal purposes */
 	/* setup the industrialio driver allocated elements */
 	/* variant specific configuration */
 	/* Setup for userspace synchronous on demand sampling. */
 	st->readback_delay_us += 5; /* Add tWAIT */
-	/* Establish that the iio_dev is a child of the i2c device */
 	/* Establish that the iio_dev is a child of the i2c device */

Out of which, 4 are really left-over comments about parent assignment.
3 of them are removed by the semantic patch, as the comment removed (by
spatch) would be for an empty line.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7476.c         | 1 -
 drivers/iio/adc/ad7887.c         | 1 -
 drivers/iio/dac/ad5446.c         | 1 -
 drivers/staging/iio/cdc/ad7746.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index e2a69dd6a47e..6286e230f55b 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -300,7 +300,6 @@ static int ad7476_probe(struct spi_device *spi)
 
 	st->spi = spi;
 
-	/* Establish that the iio_dev is a child of the spi device */
 	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index ca4c98401ebc..0f93f5c8965d 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -264,7 +264,6 @@ static int ad7887_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 
-	/* Estabilish that the iio_dev is a child of the spi device */
 	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad7887_info;
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index e01ba90dc106..5931bd630c4e 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -250,7 +250,6 @@ static int ad5446_probe(struct device *dev, const char *name,
 	st->reg = reg;
 	st->dev = dev;
 
-	/* Establish that the iio_dev is a child of the device */
 	indio_dev->name = name;
 	indio_dev->info = &ad5446_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index bd9803c7c5b6..dfd71e99e872 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -693,7 +693,6 @@ static int ad7746_probe(struct i2c_client *client,
 	chip->client = client;
 	chip->capdac_set = -1;
 
-	/* Establish that the iio_dev is a child of the i2c device */
 	indio_dev->name = id->name;
 	indio_dev->info = &ad7746_info;
 	indio_dev->channels = ad7746_channels;
-- 
2.25.1

