Return-Path: <linux-iio+bounces-14689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F42A218E7
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 09:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DF87A353F
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 08:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A441AA1E4;
	Wed, 29 Jan 2025 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="P0YoP2ce"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AE01A2C04;
	Wed, 29 Jan 2025 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138895; cv=none; b=fYLrk9+IXbLkA5Z5iFkx26Kilxo7GxJgXLgSfwiakfB07/zEp4rK5KKR3EW+6TXp2q47PERdErXa4mLUYPtUKxyLcL3V8raDoDQ3H1FgBPU/7YyOPH0BkSrzd6/4OtgzQLMEfsRiPKm7CM5k5Yv/Pxn/gn0aksnOPel99qb8Kds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138895; c=relaxed/simple;
	bh=n3X/xBFTwc9JGkTL8b1vaNAnwbNMtB4t53MzOB2/rJw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EC3qbrRWz9vjPyK5xDi9gEQVJtQxiL0INRgGNIhF+fsYgEDQcBAUWcVsvHYyWLIjxe39+f+puzSGxiuTAu8owuppafoWAmd1FeQ2hpn7G1NrgZ2iZVDhZVNXWry9jH/2tfzYWv0CSKmDno+eMxjEOrNb90SRh09859Tt9oT7r8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=P0YoP2ce; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T7aCbt029339;
	Wed, 29 Jan 2025 03:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=x7vZ5
	Vj6EMcNBIDuHkr4JGlyzCdBcAfft1gP+S+AQlM=; b=P0YoP2ceCMY9p50Vbzybm
	TQ6zaOVNB5xEdVo3+TQg6DCqwCwKB++03ysXvUQbep4H3/CpGY6F8LwXL8XbtHX0
	ERo7TwzeGRyU+faqha5YRCzSY+ivtercv1NujTqLmA9kgjtak1R9Onvm5DQ7Bvhv
	/iSvm5vXebHq8qn+ct1NztP93iCpQRTAcfzWvQG2gHixU6CZ7TXozGMVnL9iDhy/
	hPLemgZ0H0hO0LDP3BVTMRa4rgW53QLenA+cjVgwGMczAY/o9IqflOXYumOzD2CK
	OeE1cx4nL36kuOkKCWgSwyfBRD3K8AR5gz870Xfdlm4EzPHdK1qH1hOUJQv0TfNl
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44fg3a84k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 03:21:19 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50T8LI9C028240
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Jan 2025 03:21:18 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 29 Jan 2025 03:21:18 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 29 Jan 2025 03:21:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 29 Jan 2025 03:21:18 -0500
Received: from robi-Precision-5540.ad.analog.com ([10.48.65.150])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50T8KtHJ025874;
	Wed, 29 Jan 2025 03:21:09 -0500
From: Robert Budai <robert.budai@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <ramona.gradinariu@analog.com>, <antoniu.miclaus@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <lanzano.alex@gmail.com>,
        <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v5 3/6] iio: imu: adis: Add DIAG_STAT register size
Date: Wed, 29 Jan 2025 10:20:43 +0200
Message-ID: <20250129082053.19077-4-robert.budai@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129082053.19077-1-robert.budai@analog.com>
References: <20250129082053.19077-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 7a_WJkL90SSxKc1IbdjUrgc3KaH7xRUy
X-Proofpoint-GUID: 7a_WJkL90SSxKc1IbdjUrgc3KaH7xRUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290067

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

v5:
- added local variable
- mentioned default handling of diag_stat_size in comments 

 drivers/iio/imu/adis.c       | 14 +++++++++++---
 include/linux/iio/imu/adis.h |  3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 84344f052fb7..57e724412f52 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -304,11 +304,16 @@ EXPORT_SYMBOL_NS(__adis_enable_irq, "IIO_ADISLIB");
  */
 int __adis_check_status(struct adis *adis)
 {
-	u16 status;
+	unsigned int status;
+	int diag_stat_bits;
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
 
@@ -317,7 +322,10 @@ int __adis_check_status(struct adis *adis)
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
index 13beb6a7317b..ad40fb95fcdc 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -44,6 +44,8 @@ struct adis_timeout {
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
+ * @diag_stat_size: Length (in bytes) of the DIAG_STAT register. If not
+ *					defined, default value is 2 bytes long.
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
2.43.0


