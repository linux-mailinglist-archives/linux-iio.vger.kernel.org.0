Return-Path: <linux-iio+bounces-18637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B58A9C790
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689F89E1D37
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C32500DE;
	Fri, 25 Apr 2025 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CdXnfpya"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17224BC1D;
	Fri, 25 Apr 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580370; cv=none; b=nj8vWTMLd6PactooX/q0ZNPmRlXQ7Oa/BaqKDfSyoKUO/XM5X36WNjYPmwJKiazxIjBv4cSVOUCW7Wy+d5qwrTNSNkgpuiHWBrsbmnyWtZzrDJyYEM0Jv6aYOPytAMc0bTD8botI9aw6xkEZPTS/c/NOeP02TNOasdAzznpHLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580370; c=relaxed/simple;
	bh=iM/1+mjJkqBWEyhnMLBu2ypEJGJGAEfcebv0zZO/Gbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdGExODNr8Y9nomrulWY4gUprIjsKJXN8S4/Tsmoa1SYBbGjjYgYBNh26sXscJPDfHPeisa140Q8oG/ge05K3hyKNoUKaX1jYpvqVohyA5imNWWJC2ehhjx/erJyftm2xTy8PV59YCMYmtPAnPVo8Ry7Hv1Tr/g6YvpQSpRlcBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CdXnfpya; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8g6NM016641;
	Fri, 25 Apr 2025 07:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8jmzc
	BldPW65Itrqkf7TqCw7wyMvgIUB5AjWuoWuhQM=; b=CdXnfpyaiVWXdP2I1NQMU
	5sp4ToOewRel5gGT2xW2xlmXJ+V872t57X3EqCniCtpFZRwZERE1pNJW3HvcUVvr
	wHLJcUJPOSwlvc/gktTtCbgX0rEfhfd/7E5slpfymVQ5iONGLfMiozOzwu7D10qP
	7GdS+Xu1zvJxa4D7odsm3Yk2Fq8X9O8N8liynZSEd9PmIpDVJOrab8OV9ih5bWxK
	4rOWwzv5AOys5M9CRKQzmUKFGM6TnQUKdBo7HBzBcn6jMe9Lu83sdZkS7Qx6CePO
	gUOQVkle2n54fpkIUn3XOwo2thcYhDyBeCqqKcWUYq7xGjf/8Wm4UsYLrgeyvVKk
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46833j9qu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 07:26:05 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PBQ4AZ049242
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 07:26:04 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Apr 2025 07:26:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Apr 2025 07:26:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 07:26:04 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PBPjc0003881;
	Fri, 25 Apr 2025 07:25:58 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 08/11] iio: adc: adi-axi-adc: add sync status
Date: Fri, 25 Apr 2025 14:25:35 +0300
Message-ID: <20250425112538.59792-9-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425112538.59792-1-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: mipgg8Rf1Mt4LBGT0chbJOI0WRE-h2mf
X-Proofpoint-GUID: mipgg8Rf1Mt4LBGT0chbJOI0WRE-h2mf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MiBTYWx0ZWRfX6/ldZ3VZ421/ zAr1cTCj1ZfVkl0QfDE3zOhkl2X14gWNp2Ved3L7+VeffWYCk8j22znNtphdozG0pZFIwMRj1qS ty30MOOaUHsSYXFq1lVg8yvUqVnjQBbM2a41/Rr/vL/RxDvH4JPwuDr5CCrvwdjv5wmzmA8yLiV
 feTPfxpxkgATNNwGJlWEj+1IM4baBQKbtiXYPsZALZ3Bt/AinALGNH7MxxIe/VbVaEdrSqAXNwl NAmtxJev6y9J7cP97f9Ap2Kod+OnAFJc5gQPFtUy6ZMD3TkYAsHYCtnC22cfkTQMpvEOwNG13r+ 8JwPJoZfiqVT/zHAfhy409Uui5AIU3VBNxEwv+TeiVO5sK1os+ElG5YchxixDwD1KK+FV3lI/Qu
 4QoHUYjydUynICtC9r89wBn1YOdlJvjmQenqebrdA9A3I1onsx9Fb4lhvfwSWUnBe6mhaGIk
X-Authority-Analysis: v=2.4 cv=Hu52G1TS c=1 sm=1 tr=0 ts=680b714d cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=kalMC6VxhFG8u9PshIUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250082

Add support for checking the ADC sync status. A true value is obtained
if the data capture is synchronized.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v3.
 drivers/iio/adc/adi-axi-adc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 9947be059f98..bf0155830d87 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -55,6 +55,9 @@
 #define   AXI_AD485X_PACKET_FORMAT_32BIT	0x2
 #define   AXI_AD408X_CNTRL_3_FILTER_EN_MSK	BIT(0)
 
+#define ADI_AXI_ADC_REG_SYNC_STATUS		0x0068
+#define   ADI_AXI_ADC_SYNC			BIT(0)
+
 #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
 #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
 
@@ -433,6 +436,21 @@ static int axi_adc_sync_disable(struct iio_backend *back)
 				 AXI_AD408X_CTRL_SYNC_MSK);
 }
 
+static int axi_adc_sync_status_get(struct iio_backend *back, bool *sync_en)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	int ret;
+	u32 val;
+
+	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_SYNC_STATUS, &val);
+	if (ret)
+		return ret;
+
+	*sync_en = FIELD_GET(ADI_AXI_ADC_SYNC, val);
+
+	return 0;
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -582,6 +600,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
+	.sync_status_get = axi_adc_sync_status_get,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
@@ -626,6 +645,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.filter_type_set = axi_adc_ad408x_filter_type_set,
 	.data_alignment_enable = axi_adc_sync_enable,
 	.data_alignment_disable = axi_adc_sync_disable,
+	.sync_status_get = axi_adc_sync_status_get,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.49.0


