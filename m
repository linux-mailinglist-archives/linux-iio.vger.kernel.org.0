Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E291CB1E9
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 16:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgEHOjl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 10:39:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56160 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbgEHOjl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 10:39:41 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048EYe3f029405;
        Fri, 8 May 2020 10:39:39 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtef2ptw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 10:39:39 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 048EdcK9050649
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 10:39:38 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 10:39:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 10:39:37 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 10:39:37 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048EdZ0n000479;
        Fri, 8 May 2020 10:39:35 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] staging: iio: ad5933: attach life-cycle of kfifo buffer to parent device
Date:   Fri, 8 May 2020 17:39:35 +0300
Message-ID: <20200508143936.17845-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_14:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=2
 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change makes the use of devm_iio_kfifo_allocate() to attach the
life-cycle of the kfifo buffer to the parent (client->dev) object.

This removes the need to explicitly free 'indio_dev->buffer' via
iio_kfifo_free(), which is the main intent.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index af0bcf95ee8a..633adf1a08c1 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -602,11 +602,12 @@ static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
 	.postdisable = ad5933_ring_postdisable,
 };
 
-static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
+static int ad5933_register_ring_funcs_and_init(struct device *dev,
+					       struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer;
 
-	buffer = iio_kfifo_allocate();
+	buffer = devm_iio_kfifo_allocate(dev);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -742,7 +743,7 @@ static int ad5933_probe(struct i2c_client *client,
 	indio_dev->channels = ad5933_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
 
-	ret = ad5933_register_ring_funcs_and_init(indio_dev);
+	ret = ad5933_register_ring_funcs_and_init(&client->dev, indio_dev);
 	if (ret)
 		goto error_disable_mclk;
 
@@ -756,8 +757,6 @@ static int ad5933_probe(struct i2c_client *client,
 
 	return 0;
 
-error_unreg_ring:
-	iio_kfifo_free(indio_dev->buffer);
 error_disable_mclk:
 	clk_disable_unprepare(st->mclk);
 error_disable_reg:
@@ -772,7 +771,6 @@ static int ad5933_remove(struct i2c_client *client)
 	struct ad5933_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iio_kfifo_free(indio_dev->buffer);
 	regulator_disable(st->reg);
 	clk_disable_unprepare(st->mclk);
 
-- 
2.17.1

