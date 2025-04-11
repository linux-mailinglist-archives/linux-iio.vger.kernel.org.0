Return-Path: <linux-iio+bounces-17929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883AA85D33
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0EB7B83EC
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70BD2BE7AD;
	Fri, 11 Apr 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JIPEVil3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6B29C33C;
	Fri, 11 Apr 2025 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375009; cv=none; b=us5e3p9Jog3tAqsNqcnrhYIPZy4cqtDI6x3wDO6ddnv7AXTN/FOv2vo/ZB7gstwFdZrADKb2qHRdfLNJcD1sRNJTBlYHVsIqQZOsmxkissENDGgwGbOLUVJgGTZxLgdKnzGf7pSJmJYskTM2+yvo3t+K3kPDPnlQmPBz3JNa9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375009; c=relaxed/simple;
	bh=442iTi1RNwcosl6qNVoczMJmJravZdgS2cI9stGoKsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCvmyDJiNo5Gst5xrWncJkVYWEq0crwrUTbEWuMrmAZz92P6WYN2vYobDzZqusng1Kuf+jHkfj7KHCSRzPJCs1twpyc2llE81jTiRp1e2AGYrU3rtW0qkiU9S31xAGtbZe+1abRStZCTrW058UoTEXwzbQZUEZOvnDUclMMtXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JIPEVil3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BA5YuE015128;
	Fri, 11 Apr 2025 08:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aexCs
	pUfsridXQVw3Sf/TXKjWK5UbOJ/ylP/lpKeGDI=; b=JIPEVil3rfztxNAOBr1Zf
	nYXzVmpy7Z86S/WyB+4uM19f352uvGsI1j307xcTR/FAWQ8qyKCaEbv6qJA0eCzY
	l3JrhO100cjIJeiEnGYHbu/Hga7UHNyaLsPgKKePozNsUToE4OWS8UE9fT4jyQYT
	hgwDezsV3CZd3tZJ3Zk3j/aWj3MEtlu06uJo3brDfwUlEDGmVaduIlXatdrLHGh+
	dJ46svxNpqGSPVam7XjBcRRzaKoy/7aEgSMJJq5O0o+GG7U53YhCqieRM+Ti2ruS
	k0q3rsQXQoTdUovdR2A7WJT9RiChQUPPD2rqb+gkC8jaFQx6J8gYnHh7RtxJdPBq
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45u1e6u55h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:36:44 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53BCahEs005158
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:36:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 11 Apr
 2025 08:36:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 08:36:43 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.151])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BCaTPO006015;
	Fri, 11 Apr 2025 08:36:38 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 04/13] iio: backend: add support for sync status
Date: Fri, 11 Apr 2025 15:36:18 +0300
Message-ID: <20250411123627.6114-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411123627.6114-1-antoniu.miclaus@analog.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: KbxxqnpQJHYDqz02l-DBlgDLb3iPLhGi
X-Authority-Analysis: v=2.4 cv=cdjSrmDM c=1 sm=1 tr=0 ts=67f90cdc cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=x1tXHNgHMfKpHKJ5ZLIA:9
X-Proofpoint-GUID: KbxxqnpQJHYDqz02l-DBlgDLb3iPLhGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110080

Add iio backend support for synchronization status read.
The return value is a boolean stating if the synchronization is enabled
or disabled.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2.
 drivers/iio/industrialio-backend.c | 14 ++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index cb23433b22c6..0b27f88d6c27 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -860,6 +860,20 @@ int iio_backend_self_sync_disable(struct iio_backend *back)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_self_sync_disable, "IIO_BACKEND");
 
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
index 6d006cb0da5a..9bf03181c5c1 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -106,6 +106,7 @@ enum iio_backend_interface_type {
  * @data_alignment_disable: Disable sync process.
  * @self_sync_enable: Enable the self sync data capture.
  * @self_sync_disable: Disable the self sync data capture.
+ * @sync_status_get: Get the syncronization status (enabled/disabled).
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -162,6 +163,7 @@ struct iio_backend_ops {
 	int (*data_alignment_disable)(struct iio_backend *back);
 	int (*self_sync_enable)(struct iio_backend *back);
 	int (*self_sync_disable)(struct iio_backend *back);
+	int (*sync_status_get)(struct iio_backend *back, bool *sync_en);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -208,6 +210,7 @@ int iio_backend_data_alignment_enable(struct iio_backend *back);
 int iio_backend_data_alignment_disable(struct iio_backend *back);
 int iio_backend_self_sync_enable(struct iio_backend *back);
 int iio_backend_self_sync_disable(struct iio_backend *back);
+int iio_backend_sync_status_get(struct iio_backend *back, bool *sync_en);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


