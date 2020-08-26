Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE32C252D6C
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 14:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgHZMBe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 08:01:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60394 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729375AbgHZMBH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Aug 2020 08:01:07 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QBqkD7004452;
        Wed, 26 Aug 2020 08:00:51 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3330955b3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 08:00:51 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 07QC0o59065465
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 26 Aug 2020 08:00:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 26 Aug
 2020 08:00:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 26 Aug 2020 08:00:49 -0400
Received: from saturn.ad.analog.com ([10.48.65.100])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07QC0hNZ024342;
        Wed, 26 Aug 2020 08:00:44 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <jic23@kernel.org>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: stm32-dac: Replace indio_dev->mlock with own device lock
Date:   Wed, 26 Aug 2020 15:00:42 +0300
Message-ID: <20200826120042.200364-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826063850.47625-1-alexandru.ardelean@analog.com>
References: <20200826063850.47625-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_08:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=582 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260096
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock. The lock protects against potential races when
reading the CR reg and then updating, so that the state of pm_runtime
is consistent between the two operations.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dac/stm32-dac.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 092c796fa3d9..7a8aed476850 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -26,9 +26,11 @@
 /**
  * struct stm32_dac - private data of DAC driver
  * @common:		reference to DAC common data
+ * @lock:		lock to protect the data buffer during regmap ops
  */
 struct stm32_dac {
 	struct stm32_dac_common *common;
+	struct mutex		lock;
 };
 
 static int stm32_dac_is_enabled(struct iio_dev *indio_dev, int channel)
@@ -58,10 +60,10 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 	int ret;
 
 	/* already enabled / disabled ? */
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&dac->lock);
 	ret = stm32_dac_is_enabled(indio_dev, ch);
 	if (ret < 0 || enable == !!ret) {
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&dac->lock);
 		return ret < 0 ? ret : 0;
 	}
 
@@ -69,13 +71,13 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 		ret = pm_runtime_get_sync(dev);
 		if (ret < 0) {
 			pm_runtime_put_noidle(dev);
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&dac->lock);
 			return ret;
 		}
 	}
 
 	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&dac->lock);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "%s failed\n", en ?
 			"Enable" : "Disable");
@@ -327,6 +329,8 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	indio_dev->info = &stm32_dac_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	mutex_init(&dac->lock);
+
 	ret = stm32_dac_chan_of_init(indio_dev);
 	if (ret < 0)
 		return ret;
-- 
2.25.1

