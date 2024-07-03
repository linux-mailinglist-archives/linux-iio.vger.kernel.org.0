Return-Path: <linux-iio+bounces-7260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CF292658B
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 18:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC001F216D7
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194261822D0;
	Wed,  3 Jul 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="u9scog57"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5E181D17;
	Wed,  3 Jul 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022843; cv=none; b=ityU2vp9dnHH7QrVWLh/5MIzv3oLWlvcPNUn9OH37WdkNUnDBk0U7bST6I1pYH5v7UxbokWb1o1GyJDsR8Yet7T8InjTbff8dO+2lCaNrtK/04ByUocaaO+3dNO9j4WQe3Iqgrk4RnquhO+daPGssG/xQefuAM/dKDbkE2hxXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022843; c=relaxed/simple;
	bh=oaRZ3GdBLv8lrcnBNZCqoe/sQP4YaYVQ14PwYrNcr58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwaqbNQGRz3r7JidsYlynbwrlBwwSTeGqIdKDTSsBFmhk6FvEbZ9MJL/MWCpz6DcXsCQiYjWf1s9t4tPZYJWgSaog+EcUAnQ6YH4OHq1BcvoXIczijpItNzBQGu2Mz50sJ6KLEyMihluWn6LrnH7cHm4AAmk6lJTOZDLa/eYTXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=u9scog57; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463FJojl022188;
	Wed, 3 Jul 2024 18:06:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	o4A1BVBAi23p4fb0FEHwr5os2jESJIcp0IL+eEhr6sw=; b=u9scog57i9jt4YIW
	PMPr5TFq/RtRMUyXPcD8b/m02bchQ8jR4cTGv2/jf5L45n2YYEmzMluTVtMbD0pW
	qrhWCO0KMwBrtpc3Nts+zSmrJI7NPK17ifG0z+3HufeeoLvg8yx+funIgOXDwOij
	dyl78BrntNQUfcDm1EUaICAd7Vl5B3zyoZ323KaOpglQ8VLVGJ7LGW4MOGeTNyTl
	SWnjgzGKmcfQRpZQeLnsPxEaRw2eoWYakX5wrJhABbOZIyMQKWlQWbXk9ZdyCaVk
	85FyDk9uL+FiZbW8HDLQGsYNmzi8MSgeENdux183cggJBeUnlJni0LUkdgxwuCJI
	yRlA1w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4027pgstby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 18:06:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C8E0F40048;
	Wed,  3 Jul 2024 18:06:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D55A2291AC;
	Wed,  3 Jul 2024 18:06:28 +0200 (CEST)
Received: from localhost (10.252.27.110) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Jul
 2024 18:06:27 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/8] iio: add enable and disable services to iio backend framework
Date: Wed, 3 Jul 2024 18:05:27 +0200
Message-ID: <20240703160535.2277871-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703160535.2277871-1-olivier.moysan@foss.st.com>
References: <20240703160535.2277871-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_11,2024-07-03_01,2024-05-17_01

Add iio_backend_disable() and iio_backend_enable() APIs to allow
IIO backend consumer to request backend disabling and enabling.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 25 ++++++++++++++++++++++++-
 include/linux/iio/backend.h        |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 1d3d6dbdcc4e..bb6aac68979f 100644
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
index cbad233ae9f2..696997f2c0d6 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -121,6 +121,8 @@ struct iio_backend_ops {
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


