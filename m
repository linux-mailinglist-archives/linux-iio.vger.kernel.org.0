Return-Path: <linux-iio+bounces-22098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F229BB13BCB
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 15:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575563BE8DF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0EE26CE1E;
	Mon, 28 Jul 2025 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="udgvwPyZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41526B748;
	Mon, 28 Jul 2025 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710341; cv=none; b=kIs7muIc+kvbyAvpHPA7YZce4vGfZ9eD1sTfsaEO7KHC7Qzdp7xD3HXrIbMmU7E8JlqeiI0IPw7anA+kCYvL470FrRU4LTTjgs1pVPHZg4/18w5SfdZxTN2RnaNyMreHYER5NETQiF1hxCCKQZYkRDXzIxzVuEqIiu31uM7WSjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710341; c=relaxed/simple;
	bh=x/AZOZo3TFc60ngu8lKc3SGZqUJN8B3FLoRBxsTD+a4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChSWD4UGgo/ql+Q3FofjxbzWYX0eQEn5JtW0p4OsA08MGtFFeZ2oyHMZp5ncRaImNKLGv9KQivwoUiXigJub4pwJAQQk9AAdtba3OmFFI4pOEGqpXfX+s4ZLAt08AsVEG7fpojh26cLNya+OOqLat2K7rgIL6anvq9DBEDboeZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=udgvwPyZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SCBP6P026427;
	Mon, 28 Jul 2025 09:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Id8Ot
	KdxE2zpb2eanh8AMB/h5OM+ErTmwhBOU4T9N8U=; b=udgvwPyZPsV79aqC5Sy0+
	m/9DPMFaCSu/oVs2UeQ5qeH3hADALFjJIOSCKP7cJjXO/Te+tnqjHbY841W5E6a3
	CEwUQC4oaKvZfaWNscYl6t8w1EJs1x78i1uQM/IfzaS5Ib9qFQvIePceya8nog7t
	AxZKWSBdd0hfAptgXGl+nWkbg/rEZAH8gqzYOOI+0jNz8S1Li8iUiUHOtINtYzEO
	apcjM5Z99lBjBGUJIL/mZp0dt5/ljQ/KCNr68tmxxfRJkvQKca7OKr/KmVuOSq1B
	3c8nWMFShE91nmU3ymFYi7OLpnUTVDSOL7IHHess7eBiQQuyU7fpgWb2TlpZFCia
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4861m6janw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 09:45:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 56SDjCeZ047141
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Jul 2025 09:45:12 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 28 Jul 2025 09:45:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 28 Jul 2025 09:45:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 28 Jul 2025 09:45:11 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.169])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56SDitBT027767;
	Mon, 28 Jul 2025 09:45:07 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Ramona Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>
Subject: [PATCH 2/4] iio: adc: adi-axi-adc: Add support for ad777x
Date: Mon, 28 Jul 2025 16:43:34 +0300
Message-ID: <20250728134340.3644-3-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
References: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=JtrxrN4C c=1 sm=1 tr=0 ts=68877ee9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=IFE5GQQk0ofQWT4hjvEA:9
X-Proofpoint-GUID: Z4hm9J0ToX217FjxRbLWvsy2NuuBBqv6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5OCBTYWx0ZWRfX6scmovaaHBFu
 N+DI3a73M/deUZo/GnudgwLCJqq0nYZ6EMaJ859k9xh1VgFIGy5YxBGHR7uqGYryj2jLBZp9uIf
 9A45GsZYSw33O1tlzZQ/rN1vysFIZaQekegdXjbHbTPleXT71MRqIEYyAIomvOkcLR39x08rAY6
 /XtRRMLQz3nNShRaazbSrBkMxy70OtDOjYz4YV9G3C2IGAAd7IlNMisyNXSrUtoXwjrYECM7xoH
 NI8U7RMnP6YgxaflPGkeSzAyW1DaySU7YORWevgegSG2F9CGDTmgIcpFhICt5b8UF+aJiMRKSd6
 SBW39kog2suH6LJ9tv4ax2+C8cqrLnX84QZjufdsSUPGap/9ndQ8zgS2XzuzGAHRMrrSCpLfO4u
 hZ+JxN9W+3q6F0XzASVYRTpGfshYBQi8W5dNyU6owAR/Rzj492QuJHsuG0O/9u0DFQq5mNPm
X-Proofpoint-ORIG-GUID: Z4hm9J0ToX217FjxRbLWvsy2NuuBBqv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280098

Add new compatible string and corresponding iio_backend_ops for AD777x
axi family.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 2d86bb0e08a7..c4b8ec6d9397 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -670,6 +670,25 @@ static const struct iio_backend_info axi_ad408x = {
 	.ops = &adi_ad408x_ops,
 };
 
+static const struct iio_backend_ops adi_ad777x_ops = {
+	.enable = axi_adc_enable,
+	.disable = axi_adc_disable,
+	.chan_enable = axi_adc_chan_enable,
+	.chan_disable = axi_adc_chan_disable,
+	.request_buffer = axi_adc_request_buffer,
+	.free_buffer = axi_adc_free_buffer,
+	.data_sample_trigger = axi_adc_data_sample_trigger,
+	.chan_status = axi_adc_chan_status,
+	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
+	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
+	.num_lanes_set = axi_adc_num_lanes_set,
+};
+
+static const struct iio_backend_info axi_ad777x = {
+	.name = "axi-ad777x",
+	.ops = &adi_ad777x_ops,
+};
+
 static int adi_axi_adc_probe(struct platform_device *pdev)
 {
 	struct adi_axi_adc_state *st;
@@ -790,12 +809,18 @@ static const struct axi_adc_info adi_axi_ad408x = {
 	.backend_info = &axi_ad408x,
 };
 
+static const struct axi_adc_info adi_axi_ad777x = {
+	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
+	.backend_info = &axi_ad777x,
+};
+
 /* Match table for of_platform binding */
 static const struct of_device_id adi_axi_adc_of_match[] = {
 	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
 	{ .compatible = "adi,axi-ad408x", .data = &adi_axi_ad408x },
 	{ .compatible = "adi,axi-ad485x", .data = &adi_axi_ad485x },
 	{ .compatible = "adi,axi-ad7606x", .data = &adc_ad7606 },
+	{ .compatible = "adi,axi-ad777x", .data = &adi_axi_ad777x},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
-- 
2.47.2


