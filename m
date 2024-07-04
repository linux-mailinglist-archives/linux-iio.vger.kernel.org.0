Return-Path: <linux-iio+bounces-7316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1696E927A9A
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 17:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97318B23CC1
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772FB1B1433;
	Thu,  4 Jul 2024 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gVaaCIOI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D481ACE67;
	Thu,  4 Jul 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108597; cv=none; b=Ycq7YDoQx1FZuCf29jpxtoPX9tw/TvKNgKaWPOKDzFVE7PsCA6BVFuBkZQnYLtPcvTi/q2uRKQIh0HLE8vWMWd3pGxrZbkMH5JeEf+mQAxEymdAFVAgY/ifa1vMOM3uGPiCtif8Ks5FP1cJOz+ZvMhPdfdR0UfQFR2Z4SVV1teo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108597; c=relaxed/simple;
	bh=vJBJEQHuExlG3eTxzzhqOwNwIeSKl4ApGj6qCQwK2dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g666+kV7aMESvih7bmLjfbE+1zKr4k9FKbukaYGwAkUH3jyZf82EPqvCHi+NGDch+K3JGV0OCFnR9aiZAEIIp4atXmwWMtXn4G5zXQeGtxuu00t8iJqb4kWEMGf95up9Wdf1OOOvOh3DVsd+dqUVDDxjuaYOkYg9eF5CH62tCQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gVaaCIOI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464F8wKH001949;
	Thu, 4 Jul 2024 17:56:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	utCxzv0w4p0gPLLgoEdfExA6XJkBabrTOtHoTLU6wdo=; b=gVaaCIOI/ENxmnqk
	6AyAvGFck19TZcinVB3no27I+0aqv6eG1jedaKnO2hDF0XAAsSvqnUJO68nSuvao
	Atp4BGywgOMaX1/6DSA07nJPgruJNz6L3+O/uDatbNtG2EOuQ9jJV3j5Z2vwi2FM
	mEufOVvqdP7fpm+a2M+yQ1OwHf1IP9wxcRav3d09pp5AXQxJyCHFNyzeiCFsEoTE
	LDjbXHNigWIY/65VNLApLsskHhmwnfSbq1Y+nFDdUaCxB4uOSXRdwc97YkWFZi6r
	v1p6zwOm6PoQZQhWbxEXIxDS5bmTBtJVypx0new2hASeCagEefx0UYnW5lR9lsP4
	C0Qskw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 402w7jbg09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 17:56:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E017040044;
	Thu,  4 Jul 2024 17:56:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 81AB02291D2;
	Thu,  4 Jul 2024 17:55:46 +0200 (CEST)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Jul
 2024 17:55:46 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/8] iio: add enable and disable services to iio backend framework
Date: Thu, 4 Jul 2024 17:53:30 +0200
Message-ID: <20240704155338.2387858-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
References: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01

Add iio_backend_disable() and iio_backend_enable() APIs to allow
IIO backend consumer to request backend disabling and enabling.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 25 ++++++++++++++++++++++++-
 include/linux/iio/backend.h        |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 4e0ff6e6e9d4..893a55242aef 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -146,6 +146,29 @@ static void __iio_backend_disable(void *back)
 	iio_backend_void_op_call(back, disable);
 }
 
+/**
+ * iio_backend_disable - Backend disable
+ * @back: Backend device
+ */
+void iio_backend_disable(struct iio_backend *back)
+{
+	__iio_backend_disable(back);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_disable, IIO_BACKEND);
+
+/**
+ * iio_backend_enable - Backend enable
+ * @back: Backend device
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_enable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, enable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_enable, IIO_BACKEND);
+
 /**
  * devm_iio_backend_enable - Device managed backend enable
  * @dev: Consumer device for the backend
@@ -158,7 +181,7 @@ int devm_iio_backend_enable(struct device *dev, struct iio_backend *back)
 {
 	int ret;
 
-	ret = iio_backend_op_call(back, enable);
+	ret = iio_backend_enable(back);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 2d80e3fa58ce..2bfb849fff2c 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -122,6 +122,8 @@ struct iio_backend_ops {
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
 int iio_backend_chan_disable(struct iio_backend *back, unsigned int chan);
 int devm_iio_backend_enable(struct device *dev, struct iio_backend *back);
+int iio_backend_enable(struct iio_backend *back);
+void iio_backend_disable(struct iio_backend *back);
 int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
 				const struct iio_backend_data_fmt *data);
 int iio_backend_data_source_set(struct iio_backend *back, unsigned int chan,
-- 
2.25.1


