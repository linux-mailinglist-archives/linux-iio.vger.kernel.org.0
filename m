Return-Path: <linux-iio+bounces-298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8427F644E
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 17:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B49DB21025
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704653418E;
	Thu, 23 Nov 2023 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CA19E;
	Thu, 23 Nov 2023 08:43:38 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ANFk7bq030777;
	Thu, 23 Nov 2023 11:43:25 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3uhxk5thbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 11:43:24 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3ANGhN5c054371
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Nov 2023 11:43:23 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 23 Nov 2023 11:43:22 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 23 Nov 2023 11:43:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 23 Nov 2023 11:43:22 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ANGh7Fl019854;
	Thu, 23 Nov 2023 11:43:10 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: Marcelo Schmitt <marcelo.schmitt@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/7] iio: adc: ad7091r-base: Add debugfs reg access
Date: Thu, 23 Nov 2023 13:43:06 -0300
Message-ID: <271203e245d324f94678d212e4daf13386bee463.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: OQCKt7W2B-OVfZ353XB2MY1EGmA9gPOl
X-Proofpoint-ORIG-GUID: OQCKt7W2B-OVfZ353XB2MY1EGmA9gPOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311060001
 definitions=main-2311230122

Add direct register access support for AD7091R-2/-4/-5/-8 ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index dbc60ea1bafc..4d5051316428 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -177,8 +177,20 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
 	return ret;
 }
 
+static int ad7091r_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct ad7091r_state *st  = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->map, reg, readval);
+
+	return regmap_write(st->map, reg, writeval);
+}
+
 static const struct iio_info ad7091r_info = {
 	.read_raw = ad7091r_read_raw,
+	.debugfs_reg_access = &ad7091r_reg_access,
 };
 
 static irqreturn_t ad7091r_event_handler(int irq, void *private)
-- 
2.42.0


