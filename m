Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DFB26A531
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 14:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgIOM3x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 08:29:53 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52806 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbgIOMB5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 08:01:57 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FBtH2w002650;
        Tue, 15 Sep 2020 08:01:34 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33h7pr8s4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 08:01:34 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08FC1W9N007743
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 15 Sep 2020 08:01:32 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 15 Sep 2020 05:01:40 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 15 Sep 2020 05:01:40 -0700
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08FC1K9u004525;
        Tue, 15 Sep 2020 08:01:28 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 03/10] iio: adis16136: Use Managed device functions
Date:   Tue, 15 Sep 2020 14:02:51 +0200
Message-ID: <20200915120258.161587-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915120258.161587-1-nuno.sa@analog.com>
References: <20200915120258.161587-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_08:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009150103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the adis managed device functions to setup the buffer and the trigger.
The ultimate goal will be to completely drop the non devm version from
the lib.

Since we are here, drop the `.remove` callback by further using devm
functions.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---

Changes in v2:
* Further use devm functions to keep cleanup order and to drop `.remove`.

 drivers/iio/gyro/adis16136.c | 37 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index d8a96f6bbae2..a11ae9db0d11 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -523,6 +523,11 @@ static const struct adis16136_chip_info adis16136_chip_info[] = {
 	},
 };
 
+static void adis16136_stop(void *data)
+{
+	adis16136_stop_device(data);
+}
+
 static int adis16136_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -552,38 +557,23 @@ static int adis16136_probe(struct spi_device *spi)
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
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_add_action_or_reset(&spi->dev, adis16136_stop, indio_dev);
 	if (ret)
-		goto error_stop_device;
-
-	adis16136_debugfs_init(indio_dev);
-
-	return 0;
-
-error_stop_device:
-	adis16136_stop_device(indio_dev);
-error_cleanup_buffer:
-	adis_cleanup_buffer_and_trigger(&adis16136->adis, indio_dev);
-	return ret;
-}
-
-static int adis16136_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adis16136 *adis16136 = iio_priv(indio_dev);
+		return ret;
 
-	iio_device_unregister(indio_dev);
-	adis16136_stop_device(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret)
+		return ret;
 
-	adis_cleanup_buffer_and_trigger(&adis16136->adis, indio_dev);
+	adis16136_debugfs_init(indio_dev);
 
 	return 0;
 }
@@ -603,7 +593,6 @@ static struct spi_driver adis16136_driver = {
 	},
 	.id_table = adis16136_ids,
 	.probe = adis16136_probe,
-	.remove = adis16136_remove,
 };
 module_spi_driver(adis16136_driver);
 
-- 
2.28.0

