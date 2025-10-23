Return-Path: <linux-iio+bounces-25370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D63C009CF
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 13:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47223359C08
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0875B30BF4F;
	Thu, 23 Oct 2025 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WS/xO+6w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9030AD03;
	Thu, 23 Oct 2025 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217328; cv=none; b=lpDFhUYMmHVbqaLkkbmgeiPEc619uuz0AJpGxV6YPgnLw/Tsu4ADnGOt+a1DLG67x5woJ247DzAGTIFf245wR+La+h5jQB/jRiEzYVpUnDF+IlDMMfW2dpCkdiy7fOgZbs1M19y4ZLri4WcSjh+6QLag/Ecs/N5ad3++0dsdK9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217328; c=relaxed/simple;
	bh=grpTd2Q24jSFjXbLIoJdhXFOY2P91VIgIdRdyI2qKnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ouIfaIWTqzNAGaDAcXPvBypdkX4NPGao8GTlFdq1shRizx2NIrnDJ3SS+JzlzAejOjwGToxw+SvKTqtG+J8B/He9U33j9tMnh6oPbWtKmg8znuGZvWyJwrbmCQg/AFq387dI+jFqJ+pBzaCDTmmqrkCN5DDbr6LWU0olqoG2IiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WS/xO+6w; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N73A5D022094;
	Thu, 23 Oct 2025 07:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Hwd6y
	ZlnHzds3VZxajkXz5qHHSRsfKMmMm6QuKKHwRg=; b=WS/xO+6wOX1GKRNF7Tmze
	y5Z+Gpzv5hbL6SHk1omB4N52YxfWVf+/w3NTUtSb0zMmj7yIzPuTB2w3kJqQWJkb
	M7tJ2pQITMz2dcpnY17vWmZtNdB0DSW4+dmKtvwyvDg207rnnNWl12HsXBVco9r6
	8yL9KkqVagC672FVerHMzkYMWH+nne+U9R180nLBvXeSkkToJack/+UxzMwu21zv
	LmOc0LiCABZOwfgzmt6f4S4wbfSGQVu2pne8fdHRmOUc3MywZcEp6UaPsGZriHQE
	r4nNRHiBPyacVHMbEhaVvKtGOCy3mgPedJodL4qNcg9rBBVlUbYVQVHOzH80P2Ae
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49y7mjbtrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 07:01:57 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59NB1umn015087
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Oct 2025 07:01:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 23 Oct
 2025 07:01:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 23 Oct 2025 07:01:56 -0400
Received: from NSA-L02.ad.analog.com (NSA-L02.ad.analog.com [10.48.65.124])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59NB1eqv027813;
	Thu, 23 Oct 2025 07:01:48 -0400
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Thu, 23 Oct 2025 14:01:38 +0300
Subject: [PATCH v2 2/3] iio: dac: ad5456: Add missing DT compatibles
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20251023-ad5446-bindings-v2-2-27fab9891e86@analog.com>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
In-Reply-To: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.15-dev-52d38
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=T/uBjvKQ c=1 sm=1 tr=0 ts=68fa0b25 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=c0rxktb7h3u7A2EZBesA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: j88BpOpQyciWzLIz8xpI79WaRu1Wdpr3
X-Proofpoint-ORIG-GUID: j88BpOpQyciWzLIz8xpI79WaRu1Wdpr3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE4MyBTYWx0ZWRfX/QgDb8Xiin96
 EnWnXnKBU0haFcbp3XokPOHzRsOB/52d92hQA9/EgFfbKIOPVrybGOi4hOHnfLpQVRCPYxCfjCV
 z+DkFawGFLuDEx3cojKDLaUQxwA0v5ZzjPiXCwVqgsIUExDl9FSa8JhG35xzx5DnYY3StYqFCGl
 oGVeIkj0qtxKjl2D3mYxCKcJ045UKxpKqybqpPE8ta++rytoZGGaD4/gityl3uwsTwlGt5G2eUF
 GjNQBFicURgHzerDl920FQ10YqT+GGyT7dy4S4bCmxhUa/nskebIXxTFJRnXGlz0YMC5HLXFKqT
 swVPtU+z/aVdCJHAzWoSIijEOFciMu3GcJen8zhKwhuo2tE+Ge55S/yD++k0Q9Y2QqMIlHVsj0j
 JJfHvD9Aw2cYBETVc9/BA2f6p4kDjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 priorityscore=1501 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220183

Add missing of_device_id compatibles for the i2c and spi drivers.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index ad304b0fec08..b6967f3b9386 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -445,6 +445,35 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);
 
 static const struct of_device_id ad5446_of_ids[] = {
+	{ .compatible = "adi,ad5300" },
+	{ .compatible = "adi,ad5310" },
+	{ .compatible = "adi,ad5320" },
+	{ .compatible = "adi,ad5444" },
+	{ .compatible = "adi,ad5446" },
+	{ .compatible = "adi,ad5450" },
+	{ .compatible = "adi,ad5451" },
+	{ .compatible = "adi,ad5452" },
+	{ .compatible = "adi,ad5453" },
+	{ .compatible = "adi,ad5512a" },
+	{ .compatible = "adi,ad5541a" },
+	{ .compatible = "adi,ad5542a" },
+	{ .compatible = "adi,ad5543" },
+	{ .compatible = "adi,ad5553" },
+	{ .compatible = "adi,ad5600" },
+	{ .compatible = "adi,ad5601" },
+	{ .compatible = "adi,ad5611" },
+	{ .compatible = "adi,ad5621" },
+	{ .compatible = "adi,ad5641" },
+	{ .compatible = "adi,ad5620-2500" },
+	{ .compatible = "adi,ad5620-1250" },
+	{ .compatible = "adi,ad5640-2500" },
+	{ .compatible = "adi,ad5640-1250" },
+	{ .compatible = "adi,ad5660-2500" },
+	{ .compatible = "adi,ad5660-1250" },
+	{ .compatible = "adi,ad5662" },
+	{ .compatible = "ti,dac081s101" },
+	{ .compatible = "ti,dac101s101" },
+	{ .compatible = "ti,dac121s101" },
 	{ .compatible = "ti,dac7512" },
 	{ }
 };
@@ -547,9 +576,21 @@ static const struct i2c_device_id ad5446_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);
 
+static const struct of_device_id ad5446_i2c_of_ids[] = {
+	{ .compatible = "adi,ad5301" },
+	{ .compatible = "adi,ad5311" },
+	{ .compatible = "adi,ad5321" },
+	{ .compatible = "adi,ad5602" },
+	{ .compatible = "adi,ad5612" },
+	{ .compatible = "adi,ad5622" },
+	{ }
+};
+MODULE_DEVICE_TABLE(OF, ad5446_i2c_of_ids);
+
 static struct i2c_driver ad5446_i2c_driver = {
 	.driver = {
 		   .name = "ad5446",
+		   .of_match_table = ad5446_i2c_of_ids,
 	},
 	.probe = ad5446_i2c_probe,
 	.id_table = ad5446_i2c_ids,

-- 
2.34.1


