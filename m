Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C261CB1EB
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 16:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgEHOjo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 10:39:44 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58608 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbgEHOjn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 10:39:43 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048Eardf002016;
        Fri, 8 May 2020 10:39:42 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtek2mj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 10:39:42 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 048EdedK050652
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 10:39:41 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 07:39:39 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 07:39:39 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048EdZ0o000479;
        Fri, 8 May 2020 10:39:36 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] staging: iio: ad5933: convert probe init to use device managed callbacks
Date:   Fri, 8 May 2020 17:39:36 +0300
Message-ID: <20200508143936.17845-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508143936.17845-1-alexandru.ardelean@analog.com>
References: <20200508143936.17845-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_14:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change moves the clock & regulator disable to use the
devm_add_action_or_reset() callback and uses the devm_iio_device_register()
to register the IIO device.

With this, it should be now possible to get rid of the remove callback.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../staging/iio/impedance-analyzer/ad5933.c   | 67 +++++++++----------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 633adf1a08c1..c468355b0848 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -677,6 +677,20 @@ static void ad5933_work(struct work_struct *work)
 	}
 }
 
+static void ad5933_reg_disable(void *data)
+{
+	struct ad5933_state *st = data;
+
+	regulator_disable(st->reg);
+}
+
+static void ad5933_clk_disable(void *data)
+{
+	struct ad5933_state *st = data;
+
+	clk_disable_unprepare(st->mclk);
+}
+
 static int ad5933_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -704,23 +718,32 @@ static int ad5933_probe(struct i2c_client *client,
 		dev_err(&client->dev, "Failed to enable specified VDD supply\n");
 		return ret;
 	}
-	ret = regulator_get_voltage(st->reg);
 
+	ret = devm_add_action_or_reset(&client->dev, ad5933_reg_disable, st);
+	if (ret)
+		return ret;
+
+	ret = regulator_get_voltage(st->reg);
 	if (ret < 0)
-		goto error_disable_reg;
+		return ret;
 
 	st->vref_mv = ret / 1000;
 
 	st->mclk = devm_clk_get(&client->dev, "mclk");
-	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT) {
-		ret = PTR_ERR(st->mclk);
-		goto error_disable_reg;
-	}
+	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT)
+		return PTR_ERR(st->mclk);
 
 	if (!IS_ERR(st->mclk)) {
 		ret = clk_prepare_enable(st->mclk);
 		if (ret < 0)
-			goto error_disable_reg;
+			return ret;
+
+		ret = devm_add_action_or_reset(&client->dev,
+					       ad5933_clk_disable,
+					       st);
+		if (ret)
+			return ret;
+
 		ext_clk_hz = clk_get_rate(st->mclk);
 	}
 
@@ -745,36 +768,13 @@ static int ad5933_probe(struct i2c_client *client,
 
 	ret = ad5933_register_ring_funcs_and_init(&client->dev, indio_dev);
 	if (ret)
-		goto error_disable_mclk;
+		return ret;
 
 	ret = ad5933_setup(st);
 	if (ret)
-		goto error_unreg_ring;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring;
-
-	return 0;
-
-error_disable_mclk:
-	clk_disable_unprepare(st->mclk);
-error_disable_reg:
-	regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad5933_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ad5933_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	regulator_disable(st->reg);
-	clk_disable_unprepare(st->mclk);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id ad5933_id[] = {
@@ -799,7 +799,6 @@ static struct i2c_driver ad5933_driver = {
 		.of_match_table = ad5933_of_match,
 	},
 	.probe = ad5933_probe,
-	.remove = ad5933_remove,
 	.id_table = ad5933_id,
 };
 module_i2c_driver(ad5933_driver);
-- 
2.17.1

