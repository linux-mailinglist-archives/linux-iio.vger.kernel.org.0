Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38B01D2ACE
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 10:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgENI7P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 04:59:15 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40938 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbgENI7P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 04:59:15 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E8sYDU025632;
        Thu, 14 May 2020 04:58:53 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3100x5xn6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 04:58:52 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04E8wpKe065016
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 14 May 2020 04:58:51 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 04:58:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 04:58:50 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 14 May 2020 04:58:50 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04E8wlO7010610;
        Thu, 14 May 2020 04:58:47 -0400
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] iio: dac: vf610_dac: Replace indio_dev->mlock with own device lock
Date:   Thu, 14 May 2020 11:58:15 +0300
Message-ID: <20200514085835.80275-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_01:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=601 phishscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140080
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock on the device's state structure.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/dac/vf610_dac.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index 71f8a5c471c4..c1e15ede0e8e 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -36,6 +36,7 @@ struct vf610_dac {
 	struct device *dev;
 	enum vf610_conversion_mode_sel conv_mode;
 	void __iomem *regs;
+	struct mutex lock;
 };
 
 static void vf610_dac_init(struct vf610_dac *info)
@@ -64,7 +65,7 @@ static int vf610_set_conversion_mode(struct iio_dev *indio_dev,
 	struct vf610_dac *info = iio_priv(indio_dev);
 	int val;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&info->lock);
 	info->conv_mode = mode;
 	val = readl(info->regs + VF610_DACx_STATCTRL);
 	if (mode)
@@ -72,7 +73,7 @@ static int vf610_set_conversion_mode(struct iio_dev *indio_dev,
 	else
 		val &= ~VF610_DAC_LPEN;
 	writel(val, info->regs + VF610_DACx_STATCTRL);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&info->lock);
 
 	return 0;
 }
@@ -147,9 +148,9 @@ static int vf610_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&info->lock);
 		writel(VF610_DAC_DAT0(val), info->regs);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&info->lock);
 		return 0;
 
 	default:
@@ -205,6 +206,8 @@ static int vf610_dac_probe(struct platform_device *pdev)
 	indio_dev->channels = vf610_dac_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(vf610_dac_iio_channels);
 
+	mutex_init(&info->lock);
+
 	ret = clk_prepare_enable(info->clk);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.17.1

