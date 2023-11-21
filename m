Return-Path: <linux-iio+bounces-248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEBB7F386E
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 22:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095E51C20924
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 21:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFE3584F3;
	Tue, 21 Nov 2023 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAADD56;
	Tue, 21 Nov 2023 13:37:19 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ALJCwNP027036;
	Tue, 21 Nov 2023 16:37:06 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3uer08e1sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 16:37:06 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3ALLb50d057183
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Nov 2023 16:37:05 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 21 Nov
 2023 16:37:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 21 Nov 2023 16:37:04 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ALLaqiC020026;
	Tue, 21 Nov 2023 16:36:55 -0500
From: <marcelo.schmitt@analog.com>
To: <beniamin.bia@analog.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: Marcelo Schmitt <marcelo.schmitt@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] iio: adc: ad7091r-base: Add debugfs reg access
Date: Tue, 21 Nov 2023 18:36:52 -0300
Message-ID: <3fdf3d1815b5181dc01490e2500b4eb4fe3fe579.1700595310.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
References: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: SJ1pnIOPXoI6aswxSRZj1tMCS0ZsKlAS
X-Proofpoint-GUID: SJ1pnIOPXoI6aswxSRZj1tMCS0ZsKlAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_11,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311210169

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

Add direct register access support for AD7091R-2/-4/-5/-8 ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index f9b4f91d1c4f..798f7b3cc7e1 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -157,8 +157,20 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
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


