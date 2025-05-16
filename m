Return-Path: <linux-iio+bounces-19580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9B5AB97A5
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD244189A6D6
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770A7230BE2;
	Fri, 16 May 2025 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l589M83c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982B22FDF1;
	Fri, 16 May 2025 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384020; cv=none; b=pgE63f6CTFqSfJSS3ELaegHiGXCytcxZExhVWNC7KIV5UGIloKLFvUdqKLW8CnWIaYfA63TAKWcxTXZkOikPWvApntZ4nO8D1QpXYQkvjmaWRtHaXUgyXGXx+iOUVou7BzZnHBf/4T8i3AaatsGZekq6T+vv9h22UqDhWi/AEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384020; c=relaxed/simple;
	bh=ScSAyCK0HvQAe5UL0JgYS4SVnZb2FnQcIOkvm3RuSUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajRsYZ8wBXQ/d03yckTvNz3c+dhKtNp7/b/9Osu2wIdnTWb9gQ6qmLdTgjKrhljcourKiPyZoVCQ93fJuhC45a/mM9P/xc8J0uO4TGTs4CqADbE3KMxG1acjBW8Y+FpMt+CrzEOnBB4xOElYbZeFbRjrldqfodJIgfYHvIpOYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l589M83c; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G5Jecn001259;
	Fri, 16 May 2025 04:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0/TzE
	ylyZqjFXZZGxngmENbv6a/CxvMui1d6M10xyCo=; b=l589M83cR6aaXfeZmK4/g
	3POAM2405VLmJ9KInjXg7C1Yg2VT/asgfGygbnH32LcIIyYW+RT4XFYyVEBvn882
	OG2CvFQCk06dwfZuRhzLr9Tdkf5/DZ3me6LKGC0QkaY3nGJUDInXhcz5DST2RJlr
	uZw/7iDah+AqUWrg2NJkbPmzYC3htBJS+nd0HGBDGctoctIUL9I1jrCOEVYVaLZ7
	ws9ovBBT95RxkcwZb6dB6CjXjKWcuJ/fjJkP7WcANxB9yOkHY1bLb+VDh9dY37c6
	QDinFg2nVUtQgGfsNSE+QwCgQZJsdU2hj55f9ZdJZcFc/vLbn2msUJOf0DfocYAd
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46ny4a8qju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 04:26:56 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54G8QtCs033643
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 04:26:55 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:55 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 04:26:54 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.120])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54G8QZwl031549;
	Fri, 16 May 2025 04:26:49 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v6 07/10] iio: adc: adi-axi-adc: add num lanes support
Date: Fri, 16 May 2025 11:26:27 +0300
Message-ID: <20250516082630.8236-8-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516082630.8236-1-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: -_uAEg0jDYyWMf0mK5ot8Os2je2MZczU
X-Authority-Analysis: v=2.4 cv=MvdS63ae c=1 sm=1 tr=0 ts=6826f6d0 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=MtuLGBRfhagEvKnVNLsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -_uAEg0jDYyWMf0mK5ot8Os2je2MZczU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA3OSBTYWx0ZWRfX7MgyCAw8iGrO
 GGtUJk8h1o6rBN95xdd3Io1oIQvoiYTTKdQcaBlbun+PykJeS1X6zljJePsk+1uYJij9YyiLCs7
 CmAr18qRiQtHVldVRiHJhKYe/Fz7bxo+bRs+BTR03bXHi9UZW7u2EmZq8q6cDRfxjXAeK29Y2rO
 lCnzgucLvQw4rlchUtF4sSFfiTfymMgI0Ud7bqrgSY/N65wVSjHRFzSCilNzfhAxjadIhDhjxTa
 lzE+e4QAMDROLWK/gvJlWqWpJM/kIe6T2tEn3lOFecBLXBBsMO3yi87pWmZjIjmOq0D16+BnE/z
 EFGJ4XhM2pwNg4ohRK2ioAp0CgdDQSiSODxmRdbrxC+eyuyysNOyr8TkpjOeU+y3V/rE0f+QC+v
 lCn2OKSGT9ddlXDdjZ/rDjoHvVppBis8APFqWyRDGmE3ZaRSxDiFM5S+Y6D1bTZvv+TRmsYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160079

Add support for setting the number of lanes enabled.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6.
 drivers/iio/adc/adi-axi-adc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index f9c4018e3b41..d9a14fb6b8e8 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -44,6 +44,7 @@
 #define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
 
 #define ADI_AXI_ADC_REG_CTRL			0x0044
+#define    ADI_AXI_ADC_CTRL_NUM_LANES_MSK	GENMASK(12, 8)
 #define    ADI_AXI_ADC_CTRL_SYNC_MSK		BIT(3)
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
@@ -439,6 +440,19 @@ static int axi_adc_ad408x_interface_data_align(struct iio_backend *back,
 					1, timeout_us);
 }
 
+static int axi_adc_num_lanes_set(struct iio_backend *back,
+				 unsigned int num_lanes)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	if (!num_lanes)
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
+				  ADI_AXI_ADC_CTRL_NUM_LANES_MSK,
+				  FIELD_PREP(ADI_AXI_ADC_CTRL_NUM_LANES_MSK, num_lanes));
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -629,6 +643,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.data_sample_trigger = axi_adc_data_sample_trigger,
 	.filter_type_set = axi_adc_ad408x_filter_type_set,
 	.interface_data_align = axi_adc_ad408x_interface_data_align,
+	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.49.0


