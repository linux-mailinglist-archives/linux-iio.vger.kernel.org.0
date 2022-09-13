Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094225B68B8
	for <lists+linux-iio@lfdr.de>; Tue, 13 Sep 2022 09:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiIMHda (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Sep 2022 03:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIMHda (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Sep 2022 03:33:30 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66BF58B48
        for <linux-iio@vger.kernel.org>; Tue, 13 Sep 2022 00:33:29 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D6L46R025593;
        Tue, 13 Sep 2022 03:33:17 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jgqg5tyjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 03:33:17 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 28D7XGBd064893
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Sep 2022 03:33:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 13 Sep
 2022 03:33:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 Sep 2022 03:33:15 -0400
Received: from nsa.ad.analog.com ([10.44.3.57])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28D7WuNQ002761;
        Tue, 13 Sep 2022 03:33:03 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/2] iio: dac: ad5593r: add check for i2c functionality
Date:   Tue, 13 Sep 2022 09:34:13 +0200
Message-ID: <20220913073413.140475-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913073413.140475-1-nuno.sa@analog.com>
References: <20220913073413.140475-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: vXOPocFpnx49ulJpcXTaaGzCZ-rKV-uJ
X-Proofpoint-ORIG-GUID: vXOPocFpnx49ulJpcXTaaGzCZ-rKV-uJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130033
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make sure that the needed i2c functionality is supported during probe.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/dac/ad5593r.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
index 43ee4efb250c..f09433e298db 100644
--- a/drivers/iio/dac/ad5593r.c
+++ b/drivers/iio/dac/ad5593r.c
@@ -98,6 +98,10 @@ static const struct ad5592r_rw_ops ad5593r_rw_ops = {
 static int ad5593r_i2c_probe(struct i2c_client *i2c,
 		const struct i2c_device_id *id)
 {
+	if (!i2c_check_functionality(i2c->adapter,
+				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
 	return ad5592r_probe(&i2c->dev, id->name, &ad5593r_rw_ops);
 }
 
-- 
2.37.3

