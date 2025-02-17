Return-Path: <linux-iio+bounces-15640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1157A382C2
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 13:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD63F18956F4
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE51621ADD6;
	Mon, 17 Feb 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zaKZaBcs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F04221A42D;
	Mon, 17 Feb 2025 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794458; cv=none; b=ROoOBW4FHIy8o99GfXtYIZXMQqjpv/AhJYs6lsfkAboYPfJFQFqLOIyND1KXtIFBk6nr9mPygpEC+521OJvgmk9jmnT0yjfQc3DbyRDnSsmoGrcumN0y3HgpuIKXAI5Mp+upYzEybfUGHoFtDZEKGA15MDFyodZQIk0Kv8cm+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794458; c=relaxed/simple;
	bh=qDgtgapxypyWeITOYgPrFKOn9eBPe1X5gF3qQTcOJes=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDPd5m4Zy0JJJfh/u+b2G/rJRTcV768c0XRHUb5v9jdDFzpIdGdbOpCaIF+IPQ7Ty1k+qOLVr52e3n9cvDIcQdFKEQiWzxrc1ItRaaANq7jd4pynrTNDnb/2ftPNGK5cpG7IGYHh/54mPU0EvrAOD7gUUTdAiuI8cchw9Gnf3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zaKZaBcs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HA0CYX030466;
	Mon, 17 Feb 2025 07:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ea4sK
	/XS5VW2a+MohAdZhz0Sv9Mw6/g583j+qT1sxG4=; b=zaKZaBcsuBSgYVEQVpP1d
	J7eQuw9t/Hohz8keGXrfqAyzBd5XCmsyggZEXCkRe1HOGqOwWSc1DyDcCrUY+mWa
	grqqbJ5eyecLMrhoSV0/kkPha5HdXfD5lIL1B1uadGRSPbLxxKZFJ7GhGNpbtWEQ
	6/aLLw7MTzSEnmNDFYDs+IRN2i51kM+qCTCqQGpYa+7DoKit2hz0sbcJ5eqYmkfc
	R3cIr7qRCFVLD7QjI+llf3RV/8aI4U8nzCUf2JSbMZ6QzlQOavo3MvTcUNdgYObs
	Ppak+Y0gAbWLQP7HAXIDEZN9IzAb+VWMlQzZNaCt214y6Im+ZKQ+9G69cL5f/zO/
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44v2ysrfgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 07:14:03 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51HCE2bH010521
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Feb 2025 07:14:02 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 17 Feb 2025 07:14:02 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 17 Feb 2025 07:14:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 17 Feb 2025 07:14:02 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51HCDZMR016764;
	Mon, 17 Feb 2025 07:13:57 -0500
From: Robert Budai <robert.budai@analog.com>
To: Nuno Sa <nuno.sa@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Robert Budai <robert.budai@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 3/6] iio: imu: adis: Add DIAG_STAT register
Date: Mon, 17 Feb 2025 12:12:16 +0200
Message-ID: <20250217101221.600898-4-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217101221.600898-1-robert.budai@analog.com>
References: <20250217101221.600898-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: FItTpVcWHFv_yc7UFQof5_xAG7iWfqt2
X-Proofpoint-ORIG-GUID: FItTpVcWHFv_yc7UFQof5_xAG7iWfqt2
X-Authority-Analysis: v=2.4 cv=ELj800ZC c=1 sm=1 tr=0 ts=67b3280b cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=DB0AQMrG3xWRM5OvMKQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170107

Some devices may have more than 16 bits of status. This patch allows the
user to specify the size of the DIAG_STAT register. It defaults to 2 if
not specified. This is mainly for backward compatibility.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v8:
- added extra bracket for kernel styling
- fixed pointer issue

 drivers/iio/imu/adis.c       | 18 +++++++++++++++---
 include/linux/iio/imu/adis.h |  3 +++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 84344f052..1c646c36a 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -304,11 +304,20 @@ EXPORT_SYMBOL_NS(__adis_enable_irq, "IIO_ADISLIB");
  */
 int __adis_check_status(struct adis *adis)
 {
-	u16 status;
+	unsigned int status;
+	int diag_stat_bits;
+	u16 status_16;
 	int ret;
 	int i;
 
-	ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
+	if (adis->data->diag_stat_size) {
+		ret = adis->ops->read(adis, adis->data->diag_stat_reg, &status,
+				      adis->data->diag_stat_size);
+	} else {
+		ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg,
+					 &status_16);
+		status = status_16;
+	}
 	if (ret)
 		return ret;
 
@@ -317,7 +326,10 @@ int __adis_check_status(struct adis *adis)
 	if (status == 0)
 		return 0;
 
-	for (i = 0; i < 16; ++i) {
+	diag_stat_bits = BITS_PER_BYTE * (adis->data->diag_stat_size ?
+					  adis->data->diag_stat_size : 2);
+
+	for (i = 0; i < diag_stat_bits; ++i) {
 		if (status & BIT(i)) {
 			dev_err(&adis->spi->dev, "%s.\n",
 				adis->data->status_error_msgs[i]);
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 52652f51d..aa160511e 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -44,6 +44,8 @@ struct adis_timeout {
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
+ * @diag_stat_size:	Length (in bytes) of the DIAG_STAT register. If 0 the
+ *			default length is 2 bytes long.
  * @prod_id_reg: Register address of the PROD_ID register
  * @prod_id: Product ID code that should be expected when reading @prod_id_reg
  * @self_test_mask: Bitmask of supported self-test operations
@@ -70,6 +72,7 @@ struct adis_data {
 	unsigned int glob_cmd_reg;
 	unsigned int msc_ctrl_reg;
 	unsigned int diag_stat_reg;
+	unsigned int diag_stat_size;
 	unsigned int prod_id_reg;
 
 	unsigned int prod_id;
-- 
2.34.1


