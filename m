Return-Path: <linux-iio+bounces-14985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27FCA27753
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 17:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64D81885C1C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57544216394;
	Tue,  4 Feb 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g+MX49e0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED52153F7;
	Tue,  4 Feb 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687097; cv=none; b=CunuU2nZANQRoz7E+1pKSxsGqIfmxWuEiY4aAVmIGM8Gy0YsK1TywGlbhRRc0M3+tAFjKWWpzV5DawGF5CJbOqThQxnzBt7ehHQmhLcK/9R220xDVwsyGhZ8fyJavERIgt3clWovdTDG5aCymZnhIDjUdpxO61q7CrMklUnf9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687097; c=relaxed/simple;
	bh=+nUo6QipT1fv57PswVEOQq/zMfrGaDwchF7hW2G21fE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nroV4d1KwH1LyONB7KnnE/0GqKsSyVA0a2dmguZE1JToW2j3fgFddtbrO1NnLu2R2kjEWxRCTcXrJyaHYaWItMB0k2SIPNYcSNasFpUWGxsFbG+hHvOHCFzhwMvQICep8UaDt8CsJfmuhmHk583zVAvt1yNI8oi2CwhKCf30WcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g+MX49e0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514D3t9k028448;
	Tue, 4 Feb 2025 11:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yl1SN
	lfYgY2LKfVx73qTY5ESiiUVgoQzCmtWWf1wvD0=; b=g+MX49e0y6Ld9QcqmMgM9
	TspOzVO2be78wSS//Gra9nki/KdseS7xTe/mRo6PX5LzkzjMdhXFCBzHawv0kANQ
	R7xV/dBdS4ACp3RaWHmNhmhno3opD265gzm0GBpj+GgmFOW8w7dejaYQYLRIYUp8
	Zui6qgOiImIviRAds8fgbcqo2ydldLRXKQwO3gmHeFEeGyRLxbo2q5mTzOneI6cP
	6+hm3o9ZUI66kCDRifinzrmRylAEGh/07unUjSAnoBpcXZ9+w0ez9+vN0vODhti9
	U/KnqFLhIQoCYxEIAYMTwKyr1ZuVBh6U1Uu/J5XioSGTRSuZy0RXDQB4JZ1nJWpw
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44kkew8x2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 11:37:59 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 514GbvHK047809
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Feb 2025 11:37:57 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Feb 2025
 11:37:57 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Feb 2025 11:37:57 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 514GbMFI009577;
	Tue, 4 Feb 2025 11:37:50 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Nuno Sa <nuno.sa@analog.com>,
        Ramona
 Gradinariu <ramona.gradinariu@analog.com>,
        Trevor Gamblin
	<tgamblin@baylibre.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Paul
 Cercueil <paul@crapouillou.net>,
        David Lechner <dlechner@baylibre.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Robert Budai
	<robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v6 3/6] iio: imu: adis: Add DIAG_STAT register
Date: Tue, 4 Feb 2025 16:36:07 +0200
Message-ID: <20250204143612.85939-4-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204143612.85939-1-robert.budai@analog.com>
References: <20250204143612.85939-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=A4WWP7WG c=1 sm=1 tr=0 ts=67a24267 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=T6wov_ES6OZWEhoa6DIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: 6FASjFAAfSuF7a3oaP63bowbZ-DUAXv8
X-Proofpoint-ORIG-GUID: 6FASjFAAfSuF7a3oaP63bowbZ-DUAXv8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502040128

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

v6:
- commit message wrapped at 75 characters
- added local variable for status register
- applied suggestion for diag_stat_size description

 drivers/iio/imu/adis.c       | 19 ++++++++++++++++---
 include/linux/iio/imu/adis.h |  3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 84344f052fb7..b3f074116e9d 100644
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
index 13beb6a7317b..dd2f47f5a75f 100644
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
2.39.5


