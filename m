Return-Path: <linux-iio+bounces-725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F8C809022
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 19:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6841F2120A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 18:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A039B4D5BA;
	Thu,  7 Dec 2023 18:39:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F079A;
	Thu,  7 Dec 2023 10:39:33 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B7Ga6L5023834;
	Thu, 7 Dec 2023 13:39:14 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3utd12hkrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 13:39:14 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3B7IdDDV056299
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Dec 2023 13:39:13 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 7 Dec 2023
 13:39:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Dec 2023 13:39:12 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3B7IcsuA015144;
	Thu, 7 Dec 2023 13:38:57 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 03/13] iio: adc: ad7091r: Set alert bit in config register
Date: Thu, 7 Dec 2023 15:38:53 -0300
Message-ID: <e392ad7b78c1d6244f605f4de2755b1adf3ab2ec.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: qsdUkKCk4j2_We1zOzYsusrytAYXDDUe
X-Proofpoint-GUID: qsdUkKCk4j2_We1zOzYsusrytAYXDDUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312070154

The ad7091r-base driver sets up an interrupt handler for firing events
when inputs are either above or below a certain threshold.
However, for the interrupt signal to come from the device it must be
configured to enable the ALERT/BUSY/GPO pin to be used as ALERT, which
was not being done until now.
Enable interrupt signals on the ALERT/BUSY/GPO pin by setting the proper
bit in the configuration register.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 0f192fbecbd4..6056a66d756c 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -28,6 +28,7 @@
 #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
 
 /* AD7091R_REG_CONF */
+#define AD7091R_REG_CONF_ALERT_EN   BIT(4)
 #define AD7091R_REG_CONF_AUTO   BIT(8)
 #define AD7091R_REG_CONF_CMD    BIT(10)
 
@@ -232,6 +233,11 @@ int ad7091r_probe(struct device *dev, const char *name,
 	iio_dev->channels = chip_info->channels;
 
 	if (irq) {
+		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+					 AD7091R_REG_CONF_ALERT_EN, BIT(4));
+		if (ret)
+			return ret;
+
 		dev_set_drvdata(st->dev, iio_dev);
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				ad7091r_event_handler,
-- 
2.42.0


