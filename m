Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815151BBC19
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgD1LOT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 07:14:19 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15918 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbgD1LOT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 07:14:19 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03SBBZU8020199;
        Tue, 28 Apr 2020 07:14:17 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mj45baae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 07:14:16 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03SBEFjY017057
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 28 Apr 2020 07:14:15 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 28 Apr 2020 04:14:14 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 28 Apr 2020 04:13:56 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 28 Apr 2020 04:14:13 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03SBEAgt032471;
        Tue, 28 Apr 2020 07:14:10 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <rachna@ti.com>, <mugunthanvnm@ti.com>,
        <vigneshr@ti.com>, <afd@ti.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3] iio: adc: ti_am335x_adc: alloc channels via devm_kcalloc()
Date:   Tue, 28 Apr 2020 14:14:28 +0300
Message-ID: <20200428111430.71723-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_07:2020-04-28,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=2 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280091
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change attaches the life-cycle of the channels array to the parent
device object that is attached to the IIO device.
This way we can remove from the cleanup code, the explicit
tiadc_channels_remove() which simply does a kfree() on the channels array.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

The reason I'm targetting this driver, is because it's among the few
places where 'indio_dev->buffer' is accessed directly in the driver, and
that makes it difficult to think of a sane-backwards-compatible way to
do multiple IIO buffers.

 drivers/iio/adc/ti_am335x_adc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 9d984f2a8ba7..d932fe383a24 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -428,7 +428,8 @@ static const char * const chan_name_ain[] = {
 	"AIN7",
 };
 
-static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
+static int tiadc_channel_init(struct device *dev, struct iio_dev *indio_dev,
+			      int channels)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
 	struct iio_chan_spec *chan_array;
@@ -436,7 +437,8 @@ static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
 	int i;
 
 	indio_dev->num_channels = channels;
-	chan_array = kcalloc(channels, sizeof(*chan_array), GFP_KERNEL);
+	chan_array = devm_kcalloc(dev, channels, sizeof(*chan_array),
+				  GFP_KERNEL);
 	if (chan_array == NULL)
 		return -ENOMEM;
 
@@ -459,11 +461,6 @@ static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
 	return 0;
 }
 
-static void tiadc_channels_remove(struct iio_dev *indio_dev)
-{
-	kfree(indio_dev->channels);
-}
-
 static int tiadc_read_raw(struct iio_dev *indio_dev,
 		struct iio_chan_spec const *chan,
 		int *val, int *val2, long mask)
@@ -635,7 +632,7 @@ static int tiadc_probe(struct platform_device *pdev)
 	tiadc_writel(adc_dev, REG_FIFO1THR, FIFO1_THRESHOLD);
 	mutex_init(&adc_dev->fifo1_lock);
 
-	err = tiadc_channel_init(indio_dev, adc_dev->channels);
+	err = tiadc_channel_init(&pdev->dev, indio_dev, adc_dev->channels);
 	if (err < 0)
 		return err;
 
@@ -666,7 +663,6 @@ static int tiadc_probe(struct platform_device *pdev)
 err_buffer_unregister:
 	tiadc_iio_buffered_hardware_remove(indio_dev);
 err_free_channels:
-	tiadc_channels_remove(indio_dev);
 	return err;
 }
 
@@ -684,7 +680,6 @@ static int tiadc_remove(struct platform_device *pdev)
 	}
 	iio_device_unregister(indio_dev);
 	tiadc_iio_buffered_hardware_remove(indio_dev);
-	tiadc_channels_remove(indio_dev);
 
 	step_en = get_adc_step_mask(adc_dev);
 	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
-- 
2.17.1

