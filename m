Return-Path: <linux-iio+bounces-18970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 117E7AA6D61
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84AB1882EC6
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1092022DFA7;
	Fri,  2 May 2025 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SpURWTBJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9CB23BD06;
	Fri,  2 May 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176387; cv=none; b=HuloIo9CVTgBK2eLoWtExZRbyjt26aZD759XAnJOB4s/c8BMqp3WwK2DVN5P19OBeBpb/q3popn/x5/Tn2Ne8F7NQ/sikIxJ5VFc/TYYD9zEE9aAK6H7SRqaH7B+lzyy/278q/eiPf+xgG3675DpETem4ag+evCXVYgpX0ZbQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176387; c=relaxed/simple;
	bh=5Njg+X3lk57SOnUa5y2vPu2VFKsInRFRYmteG379BnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xr6EqRNgewht2htffGBnluCgyJMhXugaudrdAJMGv7ggDuSWdPNLdi8Nlk0OKXvIM3+LFIg1SMqq0nAOJCm0Bw9vN1duvTRK96aP+I3YgL59nuXQRBsXbc6x7LbdUrNSyz3MXUoOP2t7bNXWOlpuasdAMqZrNaOEkVafn+B9yq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SpURWTBJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54265IAu019278;
	Fri, 2 May 2025 04:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Gtwie
	b1q/RKDj57tnBTHrdi5jSfPp6vexNmKB4LUpb8=; b=SpURWTBJzrBuNwr4bXgKm
	hfGYxhedn/EMjuMh3swczBF/9MgvkWiC9AdfsXgFAH93qHawgrCM5jNFA8sGq7bV
	vSpoebjFMMNgy752Dcw3u8fBsWGhn0t/hYAOh+O3D+LrjZmDUZETg+qa/nJKpoVP
	TVQ2iqtqih4y38kw6MpV7EZeXqSrKUO4lBoJAG76p7jeiKwNlQA3RbFyjsGA5zES
	kyZ6O2v0y225qazXmevcgmN8alspyv2nYrrf3EjprT0Fn9d92Mgb172ySKLNW4Ei
	1YgTA6L7ziaxmLkLITWMvsH4caQDcSM4gpnth9q2dAjntew3M+KqtvAPLTor2rkK
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46cm5pskjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 04:59:40 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5428xdBw058981
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 04:59:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 2 May 2025
 04:59:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 2 May 2025 04:59:39 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5428xL7Q015723;
	Fri, 2 May 2025 04:59:33 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v4 07/10] iio: adc: adi-axi-adc: add num lanes support
Date: Fri, 2 May 2025 11:59:02 +0300
Message-ID: <20250502085905.24926-8-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502085905.24926-1-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: fOOcAsCxKZgZJp56SHSnRioR9zkupNv4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfXzB7A6/3JFq4o DgyzrAf+8Dets/yjiKv2yXQPMefmCZxOcw4nM29Qm3x3lw0GPg9XZpu7viGLCJRltgAJ1fWP3Uz hq4RAXfxrD4+aIJT5UKw+xmy8dQSCk/eVjmCwAekXy81wb3nsFVDuxFX0yN8V6fj+cMSP0kC8BT
 e9MgEDeQUByEJZN78LbkEGWZM+VsxEr0w0NX4fnNgkCgazvdcNK2J+1Lldc/KO9wzuMmI8Cv3+i TPNZCHEDtJZUJ3byeCfYu11QphsQpU/q6n1s49uuLJNe9l9PWdmThTLhU952fNo8uX0S8Sljv+5 z0JFFhbG+EWJuMpF9Q5M2C3cL2HcnZ1c+hsYxPQOAkjqM/MsvBSGxKSAf8+sHffGrviev7RpxsI
 JsT0KLjJYLdqtWDLP5W3ICO4r2KwNG57OG2chWPF8dW7Fe+2i9DulWhxQfOog471cK1UnFcg
X-Proofpoint-GUID: fOOcAsCxKZgZJp56SHSnRioR9zkupNv4
X-Authority-Analysis: v=2.4 cv=RYCQC0tv c=1 sm=1 tr=0 ts=6814897c cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=LVysS0whcD1go9EkdQUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020069

Add support for setting the number of lanes enabled.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - drop function assignment in axi_adc generic ops.
 - rename bit definitions.
 drivers/iio/adc/adi-axi-adc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 2a79c043c0de..64cf72f1c223 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -44,6 +44,7 @@
 #define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
 
 #define ADI_AXI_ADC_REG_CTRL			0x0044
+#define    ADI_AXI_ADC_CTRL_NUM_LANES_MSK	GENMASK(12, 8)
 #define    ADI_AXI_ADC_CTRL_SYNC_MSK		BIT(3)
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
@@ -452,6 +453,19 @@ static int axi_adc_ad408x_interface_data_align(struct iio_backend *back,
 	return 0;
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
@@ -642,6 +656,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.data_sample_trigger = axi_adc_data_sample_trigger,
 	.filter_type_set = axi_adc_ad408x_filter_type_set,
 	.interface_data_align = axi_adc_ad408x_interface_data_align,
+	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.49.0


