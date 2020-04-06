Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA2E19F5D4
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgDFMcK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 08:32:10 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60702 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727652AbgDFMcJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 08:32:09 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036CUQeg010174;
        Mon, 6 Apr 2020 08:32:07 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 306m3672rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 08:32:07 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 036CW6XB045562
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 6 Apr 2020 08:32:06 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 6 Apr 2020 08:32:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 6 Apr 2020 08:32:05 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 6 Apr 2020 08:32:05 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 036CW3WT026034;
        Mon, 6 Apr 2020 08:32:03 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <alexandru.tachici@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adc: ad7192: fix null de-ref crash during probe
Date:   Mon, 6 Apr 2020 15:31:09 +0300
Message-ID: <20200406123109.56947-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_07:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060109
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the 'spi_device_id' table was removed, it omitted to cleanup/fix the
assignment:
  'indio_dev->name = spi_get_device_id(spi)->name;'

After that patch 'spi_get_device_id(spi)' returns NULL, so this crashes
during probe with null de-ref.

This change assigns the 'compatible' string from the DT table, as the new
'indio_dev->name'. As such, the new device/part name now looks like
'adi,ad719x', and now has the vendor prefix.

Note that this change is not doing any NULL check to the return value of
'of_match_device()'. This shouldn't happen, and if it does it's likely a
framework error on the probe side.

Fixes 66614ab2be38: ("staging: iio: adc: ad7192: removed spi_device_id")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7192.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8ec28aa8fa8a..0039a45e1f33 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -888,6 +888,7 @@ MODULE_DEVICE_TABLE(of, ad7192_of_match);
 
 static int ad7192_probe(struct spi_device *spi)
 {
+	const struct of_device_id *of_id;
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
@@ -937,10 +938,12 @@ static int ad7192_probe(struct spi_device *spi)
 		goto error_disable_avdd;
 	}
 
+	of_id = of_match_device(ad7192_of_match, &spi->dev);
+
 	spi_set_drvdata(spi, indio_dev);
-	st->devid = (unsigned long)of_device_get_match_data(&spi->dev);
+	st->devid = (unsigned long)of_id->data;
 	indio_dev->dev.parent = &spi->dev;
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->name = of_id->compatible;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ad7192_channels_config(indio_dev);
-- 
2.17.1

