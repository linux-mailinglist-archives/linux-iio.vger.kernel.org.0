Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E9926A52C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 14:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgIOM3L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 08:29:11 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64806 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726281AbgIOMB5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 08:01:57 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FBrPtI015685;
        Tue, 15 Sep 2020 08:01:39 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33gu85285j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 08:01:39 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08FC1bX4007801
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 15 Sep 2020 08:01:38 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 15 Sep 2020 05:01:46 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 15 Sep 2020 05:01:45 -0700
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08FC1K9x004525;
        Tue, 15 Sep 2020 08:01:34 -0400
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
Subject: [PATCH v2 06/10] iio: adis16460: Use Managed device functions
Date:   Tue, 15 Sep 2020 14:02:54 +0200
Message-ID: <20200915120258.161587-7-nuno.sa@analog.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915120258.161587-1-nuno.sa@analog.com>
References: <20200915120258.161587-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_08:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=984 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150103
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

 drivers/iio/imu/adis16460.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index b26a5f1bc51a..74a161e39733 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -403,7 +403,7 @@ static int adis16460_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
+	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
 	if (ret)
 		return ret;
 
@@ -411,30 +411,14 @@ static int adis16460_probe(struct spi_device *spi)
 
 	ret = __adis_initial_startup(&st->adis);
 	if (ret)
-		goto error_cleanup_buffer;
+		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
-		goto error_cleanup_buffer;
+		return ret;
 
 	adis16460_debugfs_init(indio_dev);
 
-	return 0;
-
-error_cleanup_buffer:
-	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
-	return ret;
-}
-
-static int adis16460_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adis16460 *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
-
 	return 0;
 }
 
@@ -457,7 +441,6 @@ static struct spi_driver adis16460_driver = {
 	},
 	.id_table = adis16460_ids,
 	.probe = adis16460_probe,
-	.remove = adis16460_remove,
 };
 module_spi_driver(adis16460_driver);
 
-- 
2.28.0

