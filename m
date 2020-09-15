Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A30826A533
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 14:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgIOMaX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 08:30:23 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48720 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726472AbgIOMB4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 08:01:56 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FBrORs015681;
        Tue, 15 Sep 2020 08:01:30 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33gu85284x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 08:01:30 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08FC1TSX051497
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 15 Sep 2020 08:01:29 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 15 Sep 2020 08:01:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 15 Sep 2020 08:01:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 15 Sep 2020 08:01:37 -0400
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08FC1K9s004525;
        Tue, 15 Sep 2020 08:01:24 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 01/10] iio: adis16201: Use Managed device functions
Date:   Tue, 15 Sep 2020 14:02:49 +0200
Message-ID: <20200915120258.161587-2-nuno.sa@analog.com>
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
 adultscore=0 priorityscore=1501 mlxlogscore=883 spamscore=0
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

 drivers/iio/accel/adis16201.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 59a24c355a1a..f955cccb3e77 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -281,34 +281,15 @@ static int adis16201_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
+	ret = devm_adis_setup_buffer_and_trigger(st, indio_dev, NULL);
 	if (ret)
 		return ret;
 
 	ret = adis_initial_startup(st);
 	if (ret)
-		goto error_cleanup_buffer_trigger;
-
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		goto error_cleanup_buffer_trigger;
-
-	return 0;
-
-error_cleanup_buffer_trigger:
-	adis_cleanup_buffer_and_trigger(st, indio_dev);
-	return ret;
-}
-
-static int adis16201_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adis *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	adis_cleanup_buffer_and_trigger(st, indio_dev);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static struct spi_driver adis16201_driver = {
@@ -316,7 +297,6 @@ static struct spi_driver adis16201_driver = {
 		.name = "adis16201",
 	},
 	.probe = adis16201_probe,
-	.remove = adis16201_remove,
 };
 module_spi_driver(adis16201_driver);
 
-- 
2.28.0

