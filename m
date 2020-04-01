Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA4819AC47
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbgDANAr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 09:00:47 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58090 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732632AbgDANAq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 09:00:46 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031D03cM014943;
        Wed, 1 Apr 2020 09:00:29 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6myqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 09:00:27 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 031D0PRi051091
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 1 Apr 2020 09:00:26 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 1 Apr 2020 06:00:24 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 1 Apr 2020 06:00:24 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 1 Apr 2020 06:00:24 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 031D0Hmx023654;
        Wed, 1 Apr 2020 09:00:22 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <lorenzo.bianconi83@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/3] staging: iio: ad5933: use iio_device_attach_kfifo_buffer() helper
Date:   Wed, 1 Apr 2020 15:59:36 +0300
Message-ID: <20200401125936.6398-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401125936.6398-1-alexandru.ardelean@analog.com>
References: <20200401125936.6398-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=990
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=2 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver calls iio_kfifo_allocate() vs devm_iio_kfifo_allocate(). But
the conversion is still simpler here, and cleans-up/reduces some error
paths.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../staging/iio/impedance-analyzer/ad5933.c   | 28 ++++---------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index af0bcf95ee8a..7bde93c6dd74 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -602,22 +602,6 @@ static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
 	.postdisable = ad5933_ring_postdisable,
 };
 
-static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *buffer;
-
-	buffer = iio_kfifo_allocate();
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-
-	/* Ring buffer functions - here trigger setup related */
-	indio_dev->setup_ops = &ad5933_ring_setup_ops;
-
-	return 0;
-}
-
 static void ad5933_work(struct work_struct *work)
 {
 	struct ad5933_state *st = container_of(work,
@@ -738,26 +722,25 @@ static int ad5933_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ad5933_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad5933_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
 
-	ret = ad5933_register_ring_funcs_and_init(indio_dev);
+	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
+					     &ad5933_ring_setup_ops);
 	if (ret)
 		goto error_disable_mclk;
 
 	ret = ad5933_setup(st);
 	if (ret)
-		goto error_unreg_ring;
+		goto error_disable_mclk;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_unreg_ring;
+		goto error_disable_mclk;
 
 	return 0;
 
-error_unreg_ring:
-	iio_kfifo_free(indio_dev->buffer);
 error_disable_mclk:
 	clk_disable_unprepare(st->mclk);
 error_disable_reg:
@@ -772,7 +755,6 @@ static int ad5933_remove(struct i2c_client *client)
 	struct ad5933_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iio_kfifo_free(indio_dev->buffer);
 	regulator_disable(st->reg);
 	clk_disable_unprepare(st->mclk);
 
-- 
2.17.1

