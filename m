Return-Path: <linux-iio+bounces-13543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0D79F339A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 15:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4D0163BB7
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7745025;
	Mon, 16 Dec 2024 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ci1GpKHF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16F73BBF2;
	Mon, 16 Dec 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360575; cv=none; b=d2MA2SvRiCBjn77Snx1m3bMqSnaWbP242KkcbvoUTxkJZMjVZApduPIc4yC6UKxV6k8Y8QwJFXIJQANAnGyMKcwvHSOXA5EqaEp+LjiNMwpBqqRBzaFRkhmzQi8oE+irUgr/cB7IUNpG/M77qsK7W++aQ5BEoA39O3sw36zu390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360575; c=relaxed/simple;
	bh=nBGOyzCAd/vzj7qKB3/lK73+BiqTitum8UI9RrQxEUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoJbh+CRcK0MAu3W5Vuk32FLqas/VM9SvANWIBUzsXheFCgSEL64nnp+91w7+5APICqdXO7v2Y7ESdOsKGsgG4LWlmB3mL3Ik4uKzuiDayknC9QP4uLKkMPYriyACzC/6ReSns062WAE62yRGHCY7Sx/lIYymClY37M+uFNcM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ci1GpKHF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGCFtcR001351;
	Mon, 16 Dec 2024 09:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eI9E+
	EOOg9FDNMPAujsVKIKh9Kcz0Cshn9brQOtxFfo=; b=Ci1GpKHFqluTgNy8QP5A7
	yYF68Uq+WAFCZhedGU0xa3Jsu6Y8JZSWHRAvXvB6RVPIXUsdgJ2jXtp8nWDmuvfq
	ZnN0YGo1T3/cXmSdvSNdX4k2mqGttVX2KVmGMU/Z3sJ7KPPGv7Rbx9o5fQsneXj8
	RI8GOf2I6CN6ne1pLyMYnuTImTLytSWdm+kah5t88cOX1AbDnaVhZzzLUf/S874T
	S7JIyG2YhScHZxjM6BBgaA5GYofHr7yUnmQ327SfQ8KbBs2JJup2fSGsU6ozR2B2
	s0qTxQLdy9zzJ0lnDBSDL4gMjGWh9lwdLoY6yX1wdw01m0Vi7xVFt4oWqQ1m8ssm
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43jm2d0kfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:49:17 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BGEnGe9044454
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Dec 2024 09:49:16 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 16 Dec 2024 09:49:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 16 Dec 2024 09:49:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 16 Dec 2024 09:49:15 -0500
Received: from dell-precision-robert.ad.analog.com ([10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BGEmKdl018405;
	Mon, 16 Dec 2024 09:49:10 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robert Budai
	<robert.budai@analog.com>,
        Shen Jianping <Jianping.Shen@de.bosch.com>,
        "Alex
 Lanzano" <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <robi_budai@yahoo.com>
Subject: [PATCH v3 4/7] iio: imu: adis: Add DIAG_STAT register size
Date: Mon, 16 Dec 2024 16:48:10 +0200
Message-ID: <20241216144818.25344-5-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216144818.25344-1-robert.budai@analog.com>
References: <20241216144818.25344-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 7-i6gMPa1KKFhJQMM7VPV6qOhwdJoi5L
X-Proofpoint-GUID: 7-i6gMPa1KKFhJQMM7VPV6qOhwdJoi5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160124

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
 drivers/iio/imu/adis.c       | 11 ++++++++---
 include/linux/iio/imu/adis.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 9e4113473dc4..a072307bfb6a 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -304,11 +304,15 @@ EXPORT_SYMBOL_NS(__adis_enable_irq, "IIO_ADISLIB");
  */
 int __adis_check_status(struct adis *adis)
 {
-	u16 status;
+	unsigned int status;
 	int ret;
 	int i;
 
-	ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
+	if (adis->data->diag_stat_size)
+		ret = adis->ops->read(adis, adis->data->diag_stat_reg, &status,
+				      adis->data->diag_stat_size);
+	else
+		ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg, (u16 *)&status);
 	if (ret)
 		return ret;
 
@@ -317,7 +321,8 @@ int __adis_check_status(struct adis *adis)
 	if (status == 0)
 		return 0;
 
-	for (i = 0; i < 16; ++i) {
+	for (i = 0; i < BITS_PER_BYTE * ((adis->data->diag_stat_size) ?
+					 adis->data->diag_stat_size : 2); ++i) {
 		if (status & BIT(i)) {
 			dev_err(&adis->spi->dev, "%s.\n",
 				adis->data->status_error_msgs[i]);
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 52652f51db2e..b888b22f5c8c 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -44,6 +44,7 @@ struct adis_timeout {
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
+ * @diag_stat_size: Length (in bytes) of the DIAG_STAT register.
  * @prod_id_reg: Register address of the PROD_ID register
  * @prod_id: Product ID code that should be expected when reading @prod_id_reg
  * @self_test_mask: Bitmask of supported self-test operations
@@ -70,6 +71,7 @@ struct adis_data {
 	unsigned int glob_cmd_reg;
 	unsigned int msc_ctrl_reg;
 	unsigned int diag_stat_reg;
+	unsigned int diag_stat_size;
 	unsigned int prod_id_reg;
 
 	unsigned int prod_id;
-- 
2.34.1


