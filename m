Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEAB26A240
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgIOJck (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 05:32:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35576 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbgIOJcj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 05:32:39 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08F9VMBr016219;
        Tue, 15 Sep 2020 05:32:21 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33gu851uxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 05:32:20 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08F9WJpk047083
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 15 Sep 2020 05:32:19 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 15 Sep 2020 02:32:27 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 15 Sep 2020 02:32:27 -0700
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08F9W7vi027664;
        Tue, 15 Sep 2020 05:32:14 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Ardelean --dry-run <alexandru.ardelean@analog.com>
Subject: [PATCH 03/10] iio: adis16136: Use Managed device functions
Date:   Tue, 15 Sep 2020 11:33:38 +0200
Message-ID: <20200915093345.85614-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915093345.85614-1-nuno.sa@analog.com>
References: <20200915093345.85614-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_05:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=864 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150087
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the adis managed device functions to setup the buffer and the trigger.
The ultimate goal will be to completely drop the non devm version from
the lib.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/gyro/adis16136.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index d8a96f6bbae2..a4b060d9d23f 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -552,13 +552,13 @@ static int adis16136_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = adis_setup_buffer_and_trigger(&adis16136->adis, indio_dev, NULL);
+	ret = devm_adis_setup_buffer_and_trigger(&adis16136->adis, indio_dev, NULL);
 	if (ret)
 		return ret;
 
 	ret = adis16136_initial_setup(indio_dev);
 	if (ret)
-		goto error_cleanup_buffer;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -570,21 +570,16 @@ static int adis16136_probe(struct spi_device *spi)
 
 error_stop_device:
 	adis16136_stop_device(indio_dev);
-error_cleanup_buffer:
-	adis_cleanup_buffer_and_trigger(&adis16136->adis, indio_dev);
 	return ret;
 }
 
 static int adis16136_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adis16136 *adis16136 = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	adis16136_stop_device(indio_dev);
 
-	adis_cleanup_buffer_and_trigger(&adis16136->adis, indio_dev);
-
 	return 0;
 }
 
-- 
2.28.0

