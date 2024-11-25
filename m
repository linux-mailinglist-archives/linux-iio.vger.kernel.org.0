Return-Path: <linux-iio+bounces-12637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D1A9D8752
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9FA0B2ECB4
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0502E1B0F26;
	Mon, 25 Nov 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OH/3BJMu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACF1ABEBF;
	Mon, 25 Nov 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541795; cv=none; b=PWgS2hEO6XA+kgLiruytFUmgY27+tAqAj0tQdnb7meNv/S9ny88EPMrSVNXLE6rJc1Gjt712cRRdmTgFfh8I3Pk61Et+qzNeYpxdnfHZqJv6CVFg9CIl8CmkSWLepvlu1Mjv9mTMrpbCOfPqPHoaVaJuGmjVa46duAAQscivKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541795; c=relaxed/simple;
	bh=CG3WFYYgvkz5nXR64JpYf80kCkGIiiHMLy2y/ywY/v4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uM2WAPHNFTwlen7b1xAD05mUsUQDgHvapzFRY/rmZQbPQt9fMUArydYhNvoXpvy5yT8qI6y7egvt9XnksOO4qh+tp42aDiTpdbjQuR0GiedfuYxOsRIkKNHsRJJkukNqfUhfLMTT8KTU2lbZxSkW5MO/aBOS0okXTYYB9YMhRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OH/3BJMu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP98AXg014880;
	Mon, 25 Nov 2024 08:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r1kqV
	70odboThrdpH3fUrHEu2Qxw5HY490RveAsqhis=; b=OH/3BJMu9LZjZL+YCNcp1
	k6ydp00x9Gfu/dK+eScPGTVDN37OsAFc1LrXcOP58NNhzEQyQq5QqvxvAURagMhs
	4arNJVywNEdSV3Wh7aIbs4Dh6FOqCoYc/A3h3PI3LG4YM6Zp3QVcn4Ag173iI7aD
	H95RIEfmuwHoHWvqFP5RG2368WJNcmoChMQQLaTRFaHTzd9QJeOYViydzNOm8DaK
	DytkhRY6eElGCCvI/t3Li5k+g0PMW4SY+JFCNbV1rLXguGEnel2BkNLjJVFgbgWx
	pUf+55BkkvQnmOWuLlctBvzbmQsJmrTioUDjAlULbxXgAXn4eCngAAWO/0fDVZVp
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 434pbd112t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 08:36:21 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4APDaKAU030691
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Nov 2024 08:36:20 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 25 Nov
 2024 08:36:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 25 Nov 2024 08:36:20 -0500
Received: from dell-precision-robert.ad.analog.com ([10.48.65.197])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4APDZR2E031415;
	Mon, 25 Nov 2024 08:36:13 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Ramona
 Gradinariu <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Robert Budai
	<robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 4/7] iio: imu: adis: Add DIAG_STAT register size
Date: Mon, 25 Nov 2024 15:35:11 +0200
Message-ID: <20241125133520.24328-5-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125133520.24328-1-robert.budai@analog.com>
References: <20241125133520.24328-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 82RiEQEngXAy1hdeKugk3QQLroUabDeE
X-Proofpoint-ORIG-GUID: 82RiEQEngXAy1hdeKugk3QQLroUabDeE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250116

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

v2:
- removed default 2 byte STAT_REG length
- used already defined MACROS
- signed of by submitter

 drivers/iio/imu/adis.c       | 11 ++++++++---
 include/linux/iio/imu/adis.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 865f7c56717a..29998f3b29f4 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -304,11 +304,15 @@ EXPORT_SYMBOL_NS(__adis_enable_irq, IIO_ADISLIB);
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


