Return-Path: <linux-iio+bounces-463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9369D7FBE10
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 16:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F726282E8C
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075D95D4BD;
	Tue, 28 Nov 2023 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EE610DF;
	Tue, 28 Nov 2023 07:23:58 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ASBO6qk025530;
	Tue, 28 Nov 2023 10:23:38 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ukxxjsux0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 10:23:38 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3ASFNbLJ025841
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Nov 2023 10:23:37 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 28 Nov
 2023 10:23:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 28 Nov 2023 10:23:36 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ASFNMDc003945;
	Tue, 28 Nov 2023 10:23:32 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 28 Nov 2023 16:26:09 +0100
Subject: [PATCH v2 2/2] iio: dac: ad5791: Add support for controlling RBUF
 via devicetree
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231128-ad5791-michael-stuff-v2-2-541bb1c9dc43@analog.com>
References: <20231128-ad5791-michael-stuff-v2-0-541bb1c9dc43@analog.com>
In-Reply-To: <20231128-ad5791-michael-stuff-v2-0-541bb1c9dc43@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701185184; l=1575;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=V60ayX58Xp4oAs8NlC1uKeQ7LGPvuaHa+/Zm9B0Kn5A=;
 b=bXkkBSOrWJRRPPSTneaxn6Kk/r5UdOIXWWlq/G14GZRP8uSn83wbxS331OOKRSsAeqAPhugk0
 +gVHM4IQ5xCCVdQzzQrPf4RYH9jMYYR7a8991dzROXIfQRccaJmY5eO
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 9JgrjWD4CuFsrIk0RuJc2Bw1Xg7a8z_X
X-Proofpoint-GUID: 9JgrjWD4CuFsrIk0RuJc2Bw1Xg7a8z_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_16,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 mlxlogscore=739 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311060001
 definitions=main-2311280122

From: Michael Hennerich <michael.hennerich@analog.com>

This patch adds support for an external amplifier to be connected in a
gain of two configuration.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5791.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index a4167454da81..75b549827e15 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -345,6 +345,7 @@ static int ad5791_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct ad5791_state *st;
 	int ret, pos_voltage_uv = 0, neg_voltage_uv = 0;
+	bool use_rbuf_gain2;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -379,6 +380,12 @@ static int ad5791_probe(struct spi_device *spi)
 	st->pwr_down = true;
 	st->spi = spi;
 
+	if (pdata)
+		use_rbuf_gain2 = pdata->use_rbuf_gain2;
+	else
+		use_rbuf_gain2 = device_property_read_bool(&spi->dev,
+							   "adi,rbuf-gain2-en");
+
 	if (!IS_ERR(st->reg_vss) && !IS_ERR(st->reg_vdd)) {
 		st->vref_mv = (pos_voltage_uv + neg_voltage_uv) / 1000;
 		st->vref_neg_mv = neg_voltage_uv / 1000;
@@ -398,7 +405,7 @@ static int ad5791_probe(struct spi_device *spi)
 
 
 	st->ctrl = AD5761_CTRL_LINCOMP(st->chip_info->get_lin_comp(st->vref_mv))
-		  | ((pdata && pdata->use_rbuf_gain2) ? 0 : AD5791_CTRL_RBUF) |
+		  | (use_rbuf_gain2 ? 0 : AD5791_CTRL_RBUF) |
 		  AD5791_CTRL_BIN2SC;
 
 	ret = ad5791_spi_write(st, AD5791_ADDR_CTRL, st->ctrl |

-- 
2.43.0


