Return-Path: <linux-iio+bounces-11457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821539B3029
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 13:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E4C1F21799
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 12:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1808F1DAC8C;
	Mon, 28 Oct 2024 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="A/tzm9/p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EBB1D95B0;
	Mon, 28 Oct 2024 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118407; cv=none; b=Wks62E37EMjzx/nQerx5jJ+vrONt6fYDJVjWt16aH1VJ8OsiiePbTyZYBcHAF1vFNFJmeokDcKslifRdG3KngIMwRw2wbSS2R0cFZKMA3rjwq8LzWlowgxjXTai5RNu6EivcJ2XJ7bm9vDgCvGw0qpUIgouOBuWYxqCbtRBHSnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118407; c=relaxed/simple;
	bh=BCXSV5VwPvquxUvZwBD7942Ybg18N1SOF3e2n3oF5+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+IsrbdPE/21K8kQNQhidkkcjANokiCTRJ1qVtP0+WUm1vCOWMzvZeebLf/UKDj+DisK46NQm0u1U9rGvBDSLp7MWQLrgeijPzrWtjO1ZZFrC78hRu9CliIiSqNhgHCuWAIHdGyrBa+a81yCRrMhtDxe94wkYKnAE9QUPFQP/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=A/tzm9/p; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SB3aeF027558;
	Mon, 28 Oct 2024 08:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hyVxz
	qXqlYPIWD6PZCRbFVYyS1wgshjAVbHXpz5fQpc=; b=A/tzm9/pZa3SH4RQv1HUp
	MYFZ5B8cyqDIYAmh6jrs+MAWms43K1ioFoHht1zyYhKAuie4ZHbsPJQtq0M+Pe9C
	ZAE2k3zcW/WSdl+JlEfVcqX97EWXEJpHNEV+eSHuN2VAgFX41wsijb/kX5Y/sqAg
	XzLDLrJpvXYkPxV5cWDRSTWTNx/Mxu1jprj+gd76Zi4LwYCe2SHOSm42xjoKWgfd
	a/l88QYy+NZMkawznJiyAzandF/GvPEhybXqsWzvW13wl2oFjKiaX7QyYEZ5RCag
	ntEVbypNvLIvy2Wz8hPye2k9g0YKnazQGSugFL4Z8lPWygUlF5efeCuheBLP/du1
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42gt92rew3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 08:26:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 49SCQUUw024368
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Oct 2024 08:26:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 28 Oct
 2024 08:26:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Oct 2024 08:26:29 -0400
Received: from dell-precision-robert.ad.analog.com ([10.48.65.123])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49SCQ0aM026080;
	Mon, 28 Oct 2024 08:26:24 -0400
From: Robert Budai <robert.budai@analog.com>
To: Nuno Sa <nuno.sa@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Robert Budai
	<robert.budai@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <robi_budai@yahoo.com>
Subject: [PATCH 2/5] iio: imu: adis: Add DIAG_STAT register size
Date: Mon, 28 Oct 2024 14:25:34 +0200
Message-ID: <20241028122543.8078-3-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028122543.8078-1-robert.budai@analog.com>
References: <20241028122543.8078-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: IfEwlmvr23yitzpgU_8O2PzokkPHqKeD
X-Proofpoint-ORIG-GUID: IfEwlmvr23yitzpgU_8O2PzokkPHqKeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280100

From: Nuno Sá <nuno.sa@analog.com>

Some devices may have more than 16 bits of status. This patch allows the
user to specify the size of the DIAG_STAT register. It defaults to 2 if
not specified. This is mainly for backward compatibility.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis.c       | 12 +++++++++---
 include/linux/iio/imu/adis.h |  3 +++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 504d18a36f90..f03f35c94f76 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -304,11 +304,17 @@ EXPORT_SYMBOL_NS(__adis_enable_irq, IIO_ADISLIB);
  */
 int __adis_check_status(struct adis *adis)
 {
-	u16 status;
+	unsigned int status = 0;
 	int ret;
 	int i;
+	/* default to 2 bytes */
+	unsigned int reg_size = 2;
 
-	ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
+	if (adis->data->diag_stat_size)
+		reg_size = adis->data->diag_stat_size;
+
+	ret = adis->ops->read(adis, adis->data->diag_stat_reg, &status,
+			      reg_size);
 	if (ret)
 		return ret;
 
@@ -317,7 +323,7 @@ int __adis_check_status(struct adis *adis)
 	if (status == 0)
 		return 0;
 
-	for (i = 0; i < 16; ++i) {
+	for (i = 0; i < (reg_size * 8); ++i) {
 		if (status & BIT(i)) {
 			dev_err(&adis->spi->dev, "%s.\n",
 				adis->data->status_error_msgs[i]);
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 7b589cc83380..fae31042a622 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -44,6 +44,8 @@ struct adis_timeout {
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
+ * @diag_stat_size: Length (in bytes) of the DIAG_STAT register.
+ *		    Defaults to 2 if not set.
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


