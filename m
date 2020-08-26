Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0922A252DC3
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 14:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgHZMGY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 08:06:24 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55440 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729519AbgHZMGX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Aug 2020 08:06:23 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QC4Kvp019378;
        Wed, 26 Aug 2020 08:06:17 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 332w765g4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 08:06:17 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 07QC6Gfb002516
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 26 Aug 2020 08:06:16 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 26 Aug 2020 08:06:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 26 Aug 2020 08:06:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 26 Aug 2020 08:06:14 -0400
Received: from saturn.ad.analog.com ([10.48.65.100])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07QC6ASE000563;
        Wed, 26 Aug 2020 08:06:11 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adc: fsl-imx25-gcq: Replace indio_dev->mlock with own device lock
Date:   Wed, 26 Aug 2020 15:06:09 +0300
Message-ID: <20200826120609.203724-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_08:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=612 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008260098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock, to protect against any other accesses during the
reading of sample. Reading a sample requires multiple consecutive regmap
operations and a completion callback, so this requires that no other
read occurs until it completes.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 8cb51cf7a816..2a56ed0fc793 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -38,6 +38,7 @@ struct mx25_gcq_priv {
 	struct completion completed;
 	struct clk *clk;
 	int irq;
+	struct mutex lock;
 	struct regulator *vref[4];
 	u32 channel_vref_mv[MX25_NUM_CFGS];
 };
@@ -137,9 +138,9 @@ static int mx25_gcq_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&priv->lock);
 		ret = mx25_gcq_get_raw_value(&indio_dev->dev, chan, priv, val);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&priv->lock);
 		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -314,6 +315,8 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->regs);
 	}
 
+	mutex_init(&priv->lock);
+
 	init_completion(&priv->completed);
 
 	ret = mx25_gcq_setup_cfgs(pdev, priv);
-- 
2.25.1

