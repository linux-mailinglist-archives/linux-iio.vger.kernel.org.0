Return-Path: <linux-iio+bounces-15368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D601A31642
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C277E18871FC
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9259F2641CD;
	Tue, 11 Feb 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iXGaSPVU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C408B2641C7;
	Tue, 11 Feb 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303941; cv=none; b=CSReRcnWNFrC7dXBt5PIS5iJ5cdlMvraL/syOuMIndVFCi8CrYJ0oNk3ujfTW2SMdZm3OhNTk/bIXqISlEsNDQr/SraDvmRnZ6szQkambQbLMCX+ZhtKlkz4S7NT3HoUHrfBOtuApCmXtAVQAHmuHFS6GWeniN28w2lFcL5DMMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303941; c=relaxed/simple;
	bh=Xvibdq8i7rMxPCEiHkEkv92fdm42FyQDvfsS7zHs1GA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIcMVKl1ZsehzG0mKVGMcqsmT9oVQamSpM+/qIOUP4VyJG8LxaFcJ0SPEKZa+FBP7urPaRe50bxdsBs9sF0pO0wldAPUZv1S3bC+vehlzxEOMYNprJmB/3a0HOra65KB+64o/2jWIAQ60+WoryOk5rM6SXmCTseJ1wTX0kSgjCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iXGaSPVU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BJXJ8B001679;
	Tue, 11 Feb 2025 14:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KcGZY
	3LEheYGQYNGB8qP+UqqUsY+w00H19H481Insaw=; b=iXGaSPVUWGSAvzowT+8Ve
	G+anr/mM7Kr68Q7v+yZnkfxDUaGHaurZ/KzJkdfyM56q+RIBC5bgCQVppVn0cYpy
	46+EHrPuCXIe1emfFivDL3GZ6wn8WdgU0Ml+MWjAcS12aF7VlxbF3ijyRTEaig02
	+LxE3bAYHIj0YP6A8zkPXytYzn4BHp27ZtvYPtZ1yBOTf+lSX2BlT4TfdjJ8ZLNo
	8sxbNE8c6TxfCCd/NEVzQy73RbVT+Mq1GxfH0ub88p6hp0Ik2htCQSjVlUE3ku3v
	Yvis8IgUKfu76LXwobBTqI27AWEZyvTeVXdR8Xt7w5LBubZZhp4I9ESOLutsU07A
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44r857hd19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 14:58:46 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51BJwi3T048374
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 14:58:44 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 11 Feb
 2025 14:58:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 14:58:44 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BJwFRC031076;
	Tue, 11 Feb 2025 14:58:37 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Ramona
 Gradinariu <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Robert Budai <robert.budai@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 3/6] iio: imu: adis: Add DIAG_STAT register
Date: Tue, 11 Feb 2025 19:57:00 +0200
Message-ID: <20250211175706.276987-4-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211175706.276987-1-robert.budai@analog.com>
References: <20250211175706.276987-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: MXtFUBo5WfocjxX3JiTwSN5h6FsX33Ki
X-Proofpoint-ORIG-GUID: MXtFUBo5WfocjxX3JiTwSN5h6FsX33Ki
X-Authority-Analysis: v=2.4 cv=U5VoDfru c=1 sm=1 tr=0 ts=67ababf6 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=RUNVjLDSgTOuRutKXbcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110129

Some devices may have more than 16 bits of status. This patch allows the user
to specify the size of the DIAG_STAT register. It defaults to 2 if not
specified. This is mainly for backward compatibility.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---
 drivers/iio/imu/adis.c       | 19 ++++++++++++++++---
 include/linux/iio/imu/adis.h |  3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 84344f052..b3f074116 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -304,11 +304,21 @@ EXPORT_SYMBOL_NS(__adis_enable_irq, "IIO_ADISLIB");
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
+	if (adis->data->diag_stat_size)
+		ret = adis->ops->read(adis, adis->data->diag_stat_reg, &status,
+				      adis->data->diag_stat_size);
+	else
+	{
+		ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg,
+					 status_16);
+		status = status_16;
+	}
 	if (ret)
 		return ret;
 
@@ -317,7 +327,10 @@ int __adis_check_status(struct adis *adis)
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
index 52652f51d..35797fe93 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -44,6 +44,8 @@ struct adis_timeout {
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
+ * @diag_stat_size: 	Length (in bytes) of the DIAG_STAT register. If 0 the 
+ * 			default length is 2 bytes long.
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


