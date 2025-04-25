Return-Path: <linux-iio+bounces-18632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4611A9C77D
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5591B1B6233F
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 11:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C03247290;
	Fri, 25 Apr 2025 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ak1e3QFh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E692451D7;
	Fri, 25 Apr 2025 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580365; cv=none; b=uLx2UAMsLMLJ5BB0I+SZ6vQz4nWv5caGSnwCRpR50l+MULYgtwSMy+10pzNzXL37zPIDEPHsvcTELCsxhPQEHQw943ht4ICZPfMrI1y/1lERQ5cH+IgThzoEwWSlp0m7o5Xkhg6CSErHU7IydV8iX1hAwRnXWLmxm36OiSROyVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580365; c=relaxed/simple;
	bh=WhDNFGkTo2hyV//6S5wb+sluC9RI/UNt7SBlFjgTMzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcvxEsesIXJON3Q7in5XSKE1wwxm2T1U2hn/3QfKyteaOplie68CPxpQH47dQgo203F0CDp1lznZ8VFEEXwYITxLQMeq7VtyMCIxi17QOKfPtKb8thkPAuAWRfhePzKXL3kcZNFGmMbDT4xXid+faI9aYvQgYt+1CKXWUke/zkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ak1e3QFh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAxBB0019343;
	Fri, 25 Apr 2025 07:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lDP6k
	CLEFE076BJOoAOJa4icE+7T0FgNjaJ0pdE2wEM=; b=Ak1e3QFhOkz/lz/7TDxqo
	qZ/WovoO4Un7flyM1jlVsSMYsJ/zqVyBb6htV3rOL6DlS1utcLpDC0RP5mGoycnE
	g6W6sT9iZQtLBUU9VuGEuU3+Yi6GduWXqEEMTTnprp/gH5C+WDaaefxKSEcgWyJx
	YUHq0+7qoOCJjZJL4kvoBRUDyPf4/gKJi3eekTjme507evWw3EQmRwN4umnKfDBI
	VdH07PN/EK4RvKI+etvNXRrsmYBsCXWtYjA7yoT+YxYfO3Or1CamDeJ65GclFmzN
	9Z/r11fkzDljS5pHIxM9yjpYgKbYi8mI1YuGXEytNn/PJVcWjiQ0CazABdA0XRDo
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 466jjqxyjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 07:26:00 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PBPxXR049227
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 07:25:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 25 Apr
 2025 07:25:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 07:25:58 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PBPjbt003881;
	Fri, 25 Apr 2025 07:25:53 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 03/11] iio: backend: add support for sync status
Date: Fri, 25 Apr 2025 14:25:30 +0300
Message-ID: <20250425112538.59792-4-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: DPta38AQr57eSIHegsPyH9Eq2hLePTcJ
X-Authority-Analysis: v=2.4 cv=DoJW+H/+ c=1 sm=1 tr=0 ts=680b7148 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=vaGy3gO87QTDluMa78cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MiBTYWx0ZWRfXzM+EG+i/vrGt msj+XJ4fetH/gZRjbHKO+80wyCnnqC5eXpFrFpXM00eLyLHyQyfCT2rpbk+4ieymngsO//urNRQ MfQ1HAmKoH6pjvA3ObGU2Xmt3Qw9d+O/t9q/oVtBIwkH5vph7y0IdguKciBXdmGCTcDI1gmD5YI
 m6wjnzwpHCvJEfNkXI8LV4kv0iAELuhD7Ap9nKlCOiZn3D8+XHbnBxcmIVjYK7ITdIbC7V00tvY y5ASVocNjBuTiz1/z7y4QBmEHg27KLxJWwis/KF4tXsVwmIRUA7UVbgh9OisZy6bfwzIxnlwqIq vROzfuL1ZKamtmRutnQdJysjye1/8FO68vUCVdYrokVAnUAKycWjap7mNJUpeZPBLp15D9/kDFj
 9NzZ/f/07PGb5gaaOKZAfGXHtO94TOrwGzf5SUVEWEzFJfJeNHdthD/Kn6eaLIuGD8I56V/i
X-Proofpoint-GUID: DPta38AQr57eSIHegsPyH9Eq2hLePTcJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250082

Add iio backend support for synchronization status read.
The return value is a boolean stating if the data alignment has been
correctly performed and capture is synchronized. If successful, the
return value will be true.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - update commit description.
 drivers/iio/industrialio-backend.c | 14 ++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index b77a31b16aa5..f7c8167a248d 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -819,6 +819,20 @@ int iio_backend_data_alignment_disable(struct iio_backend *back)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_alignment_disable, "IIO_BACKEND");
 
+/**
+ * iio_backend_sync_status_get - Read the syncronization status
+ * @back: Backend device
+ * @sync_en: Synchronization status returned (enabled or disabled)
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_sync_status_get(struct iio_backend *back, bool *sync_en)
+{
+	return iio_backend_op_call(back, sync_status_get, sync_en);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_sync_status_get, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index bd973de8cad9..e93d1a98e066 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -111,6 +111,7 @@ enum iio_backend_filter_type {
  * @filter_type_set: Set filter type.
  * @data_alignment_enable: Enable sync process.
  * @data_alignment_disable: Disable sync process.
+ * @sync_status_get: Get the syncronization status (enabled/disabled).
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -165,6 +166,7 @@ struct iio_backend_ops {
 			       enum iio_backend_filter_type type);
 	int (*data_alignment_enable)(struct iio_backend *back);
 	int (*data_alignment_disable)(struct iio_backend *back);
+	int (*sync_status_get)(struct iio_backend *back, bool *sync_en);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -209,6 +211,7 @@ int iio_backend_filter_type_set(struct iio_backend *back,
 				enum iio_backend_filter_type type);
 int iio_backend_data_alignment_enable(struct iio_backend *back);
 int iio_backend_data_alignment_disable(struct iio_backend *back);
+int iio_backend_sync_status_get(struct iio_backend *back, bool *sync_en);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


