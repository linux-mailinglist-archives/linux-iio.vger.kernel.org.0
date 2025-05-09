Return-Path: <linux-iio+bounces-19368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8C8AB112D
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2053B7C66
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF502900A1;
	Fri,  9 May 2025 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="n4cm0q/9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504528FFCE;
	Fri,  9 May 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787843; cv=none; b=k65lP1cJNV6Hpqmhh91kOkH6b44gQdCsRuIoWzoimjAAFhAFqZmPW7Qlt+7g0heMbHUMrAJZ+NP3u4gSpXayygaPL8dhhYMJK5Phe5dg2e2i3k66h7U686EmVJD+ZYEjIo31XbmJPA2QjC6VQ3B/2lj1rG/751oBkTTI8tLTuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787843; c=relaxed/simple;
	bh=sEJhucEqxDyy5ghmvqCHFSuyAs8HZoWTyKunKq4slTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2gBPk0C1Q0U2XmH5e85hbkXOCQejSTIshuWBmJnquFwJ0WDpqB+zTIp9qgKknT6/SczXjkoDDwqMAVObFjpoeb/U4/bZGi2SKc5hV/y+8y+fu1kFhOJ1KU1xrcwxcgoY14zVhpU+VfDv7UVs+F05v06dhetIWxfr20vjIVRlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=n4cm0q/9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549AenWZ016368;
	Fri, 9 May 2025 06:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fmEIe
	T6JTtSsCxNyfMN846aUBpW/rlvWECSiSd9Nm0E=; b=n4cm0q/9jfPnG/Ci6t8Zl
	nQTV1srNzsL76UOorGiCGsmAzupxTWNPfPE9mFPieJCiXt10+Wjgy4p5bZPaNcSQ
	TOXep/4Wm0hhAPhDtX19DXWhCjEFBl8HyjRFWVzgZ8TuMonl1fIDoGvDzaaT49yN
	xPuam4WgH0pfahzAsktPs8dSom5tCZUBIBxcdkwHavnhIsVHHKvvhTh9hHG0VNE2
	c5zuxR7uCtcloBcHz+960E2J0VRk6CozS02WXps4xkVNYg+Q+bo2VQPc2niXJwHr
	NaH4ZU72AMcyxhlTBnvf75eUmj9PoNr/wo3wF8LNMyqvSHzCuuOnKiK4bp8GUyo4
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46hg5tg0wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:50:35 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 549AoYHB049032
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 May 2025 06:50:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 May 2025
 06:50:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 May 2025 06:50:34 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 549AoK13014223;
	Fri, 9 May 2025 06:50:28 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v5 03/10] iio: backend: add support for number of lanes
Date: Fri, 9 May 2025 13:50:12 +0300
Message-ID: <20250509105019.8887-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509105019.8887-1-antoniu.miclaus@analog.com>
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: qKCoW6-OmJW9KStYl5_MzP49T8DyfbaJ
X-Proofpoint-ORIG-GUID: qKCoW6-OmJW9KStYl5_MzP49T8DyfbaJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwNCBTYWx0ZWRfX6KQNotqillL+
 Ml6N33MB5f6GALi41svV86dDvwDp932+01M4RLBKcDe9CPf57WwYffdnQdnFc0nkGKOg8urWlgK
 p8V3Zs/jL7XIktlCk7F1kMRNZKzzQ3nKdJIw2f1iOiyGtkBiRUKKuEFmlCgp4DIC28L4LbUfblC
 5IQteqEsLYjnUSs46fagm9Tsjbnh1VaOR46Afv48jvh8uefbdkLSehSjayX3mQMuwMcurJTz8//
 cIgYXlXCbMAn0HTHNePgchW3Vt24KfCJvx2tE1Jbcq+FZojFlRW+YXPuwtsLSup6doV/EEqoGN8
 zE8XysWNQm4YqCDeSDautmQqlYBBJEStrsFouGULF0ecLAch7D/rKq5Wo4zQNztZMK3zMbfwcjV
 2gjwlyjSGuIdzwIDmPUspVTwlYoN+QKYDoQxX6HoiF/j9u4YInFc8SbxyjR5kx91BoX2+GVA
X-Authority-Analysis: v=2.4 cv=eeE9f6EH c=1 sm=1 tr=0 ts=681dddfc cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=Ge_Sr372ckFWHCXdfyYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090104

Add iio backend support for number of lanes to be enabled.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
 drivers/iio/industrialio-backend.c | 17 +++++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 545923310f1f..537fb3202783 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -819,6 +819,23 @@ int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_interface_data_align, "IIO_BACKEND");
 
+/**
+ * iio_backend_num_lanes_set - Number of lanes enabled.
+ * @back: Backend device
+ * @num_lanes: Number of lanes.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes)
+{
+	if (!num_lanes)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, num_lanes_set, num_lanes);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_num_lanes_set, "IIO_BACKEND");
+
 /**
  * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index a971a83121b7..1be4671c8c07 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -110,6 +110,7 @@ enum iio_backend_filter_type {
  * @debugfs_reg_access: Read or write register value of backend.
  * @filter_type_set: Set filter type.
  * @interface_data_align: Perform the data alignment process.
+ * @num_lanes_set: Set the number of lanes enabled.
  * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
  * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
  * @data_stream_enable: Enable data stream.
@@ -163,6 +164,7 @@ struct iio_backend_ops {
 	int (*filter_type_set)(struct iio_backend *back,
 			       enum iio_backend_filter_type type);
 	int (*interface_data_align)(struct iio_backend *back, u32 timeout_us);
+	int (*num_lanes_set)(struct iio_backend *back, unsigned int num_lanes);
 	int (*ddr_enable)(struct iio_backend *back);
 	int (*ddr_disable)(struct iio_backend *back);
 	int (*data_stream_enable)(struct iio_backend *back);
@@ -206,6 +208,7 @@ int devm_iio_backend_request_buffer(struct device *dev,
 int iio_backend_filter_type_set(struct iio_backend *back,
 				enum iio_backend_filter_type type);
 int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us);
+int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes);
 int iio_backend_ddr_enable(struct iio_backend *back);
 int iio_backend_ddr_disable(struct iio_backend *back);
 int iio_backend_data_stream_enable(struct iio_backend *back);
-- 
2.49.0


