Return-Path: <linux-iio+bounces-23043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ACDB2DBFA
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231CD1C23F33
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5D42ECEA2;
	Wed, 20 Aug 2025 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tVXjdnlR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A34183CC3;
	Wed, 20 Aug 2025 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691423; cv=none; b=AQ1sQFrLcSf8gpz6btBcJ1R6LwJc1GAABw/TKPre43wp/qZN9zoaVOU9+20RsSvuKWuqRcryWBm/njhTlA6JEm2MFm/9ePk4yD74AaRiL7gW74rZD+ByUY+I3KUdPlHHEUBrqb5rMX1B9dyqilCkfyuclTjYwA9gurvzQq0glUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691423; c=relaxed/simple;
	bh=z8bLqHwpvngK6gcUYWs7qMVeXee4Vtw/v6LaTDPqbxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdAmFD98NqkYQJxZ3xRGmi58YRSCZwtBPO3PSCPAINiL8WB4UsdwfV3I/+zLpFyoqrX1iIGRQr0CjgUWUMWPzMNKHP43ITjTmMxzK+1PPoggWQfIg2zpQwdUs1L9x1o7+VEaneM5U6Qb6BRm3EYLVVrEbB72MVh2VAQ1xWeu110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tVXjdnlR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KAeT62009192;
	Wed, 20 Aug 2025 08:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VlroM
	pKcXDPuoJj+59G58B7SlPdih7G8ELsAp5BUcS8=; b=tVXjdnlRlk+uV18twGtpC
	prlyi+/Ja6DcpK8HpDxRedD+K9irLDG6cMI/rdYauFn9hS4h/cofbGVQsnb9G5BK
	fZc4hjAlN7h8TfXFNI9e9uiMogfQfh9glzlYoLmxgB3Azo1KTpw6iqUqRK/kTkTG
	sSMyIGZ2uTu+PBV61BqYkpuPkF2IWlyTg/DPVzaYMcqCWaJNzbhU/c0bCI15YAdi
	M1Z2yg9lMYl/DgLh3Btz96D+hPpQgSypSS6EYe3pHJTYDDc+A/dVcor561fSjivc
	BinXLW4S3g5twYiliKYfyqQHqGk7oGxsTuskkQAikVSa7oF68AkgEM7K3EbgSfh1
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48n0tdufg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:03:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57KC3KX9037336
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Aug 2025 08:03:20 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 20 Aug 2025 08:03:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 20 Aug 2025 08:03:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 20 Aug 2025 08:03:20 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57KC31n1020092;
	Wed, 20 Aug 2025 08:03:13 -0400
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
Subject: [PATCH v4 1/4] iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
Date: Wed, 20 Aug 2025 15:02:42 +0300
Message-ID: <20250820120247.3012-2-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
References: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NSBTYWx0ZWRfX2J1p6Omh5b1d
 Ly+xmKXL4WSxbM+jjA3/8OVHCwVJadfG5WIKutGrC1NDdbuvD6mZdOs7tM9OT+FQfd766udY2Ya
 mlfg4rb4AZwPflmV3U+hzpRdaqHK0sDjsXq11JSxbU/VlWkMEO3JxBSmINnPv4YWxDzpEercaXx
 jkOlAEfCvJqqwM8GU0auZN2UOk3z45ynZHss3AQvUwr2CtGGeMpfDWVrIVbZE/rpWvJsfYQYh71
 hLU6qTOrRtcYSeQOmf7LXx4zRLEfHeHTSecC3JARXH+bMPoyQ5ZuJe3sTM68C5/ibqi/ZmRBEqK
 AR+egvW5MDSMvHBQ/5J6m63SelIDXLHuoc+6M9JMIJH7Em6KkqbQXYQz2qW97nnRBQ9vJ/pg4P5
 m8eEQ1Yg2sX3bOGGJqpyYdUy5Ay1tQ==
X-Proofpoint-ORIG-GUID: ouMI4jWoYZs6O73CNBe3TyHeECUAGTaB
X-Authority-Analysis: v=2.4 cv=BoHEAYX5 c=1 sm=1 tr=0 ts=68a5b989 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=Jw71EcAk_mQ5ulMM_6cA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ouMI4jWoYZs6O73CNBe3TyHeECUAGTaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190195

Add axi_adc_num_lanes_set in the adi_axi_adc_ops structure to support
setting number of lanes used by AXI ADC. This operation is included in
the generic structure because the number of lanes is a configurable
parameter of the generic AXI ADC IP core, not specific to a device.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
changes in v4:
 - improved patch description
 drivers/iio/adc/adi-axi-adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 2d86bb0e08a7..20bb59c24acf 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -617,6 +617,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
 	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
+	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.47.2


