Return-Path: <linux-iio+bounces-7846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7913893B3E6
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 17:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237DA1F21010
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 15:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC2515B554;
	Wed, 24 Jul 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="aqPWgNJm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60CB158849;
	Wed, 24 Jul 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835500; cv=none; b=EkXv69lwRdwsDUqcYjZH0zt1mzOPAH6//UKe8sr39LuizTqVQeB/JOwu4Sree7EqS9u8hD7NeM880MD7ymc288QW8dJo5nUZHduHt/EmyI+neeVB2LeCOxv32ip4PDu0CiAqrPc2FeYwNoiYhW68XSbC8TvUzxxEkqEDXurRS6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835500; c=relaxed/simple;
	bh=w7yM4/gT0zRzyZ8+3a+fI73xZFdWR+AhV/rICHTFsQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaX+81zIQQstJVnp4GvszUYG29qrYl5XTVydOWicxxHa7B4dxjk3vzzz4+XxkoYvxqEB7oM0H5FRwwjaEgby7UPHNBEHOaF/XcZCk96/WHGeqtpjij5EI/aTTyTtfGn8BQHd+6s0prd44gjgh2sUlq/tsMrPUXmzQ0CNGDmQdao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=aqPWgNJm; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OB6Oxp014230;
	Wed, 24 Jul 2024 17:38:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	DR9mpnYwWT5K5gtCEEWN7v/SZM2szIn6V/w8v+ERgP4=; b=aqPWgNJmKeDA2m7y
	lylindi+3s0v0q0+NmJcfO63CW/6Qkmpxlzs6GyHgdTkCaNzjWKxT6tIM5NKvZNG
	tnH82cWtPKtaYn4n55BHAB8KytPMdGb2Ykees210VJy7ZnalmTPKZMv34GJBGQRr
	aCyza+gsmMeCJsq+7SLt7w3XsFh4vPSsAba1gnGJ5QOE3+5shknQJoUtA/rljItV
	Lr0ZVqZ7D9ibxrtYbPkHtgc553nOloBKZQjDVNyPQ2RuWygCl2NkTsLP1fo63nKw
	5qO6+8cUdfFIjt0vkUo7zAxNSdv4YqZBsMRyoNC7KQX2BH+NU0JJSABrlk4a17Qx
	B+6oVw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40g2nh87gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 17:38:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7FC5440046;
	Wed, 24 Jul 2024 17:37:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 83B702414AD;
	Wed, 24 Jul 2024 17:37:29 +0200 (CEST)
Received: from localhost (10.252.12.39) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 24 Jul
 2024 17:37:29 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/9] iio: add enable and disable services to iio backend framework
Date: Wed, 24 Jul 2024 17:36:30 +0200
Message-ID: <20240724153639.803263-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724153639.803263-1-olivier.moysan@foss.st.com>
References: <20240724153639.803263-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01

Add iio_backend_disable() and iio_backend_enable() APIs to allow
IIO backend consumer to request backend disabling and enabling.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 25 ++++++++++++++++++++++++-
 include/linux/iio/backend.h        |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 72dc82a42d8f..b53904b03464 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -150,6 +150,29 @@ static void __iio_backend_disable(void *back)
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
@@ -162,7 +185,7 @@ int devm_iio_backend_enable(struct device *dev, struct iio_backend *back)
 {
 	int ret;
 
-	ret = iio_backend_op_call(back, enable);
+	ret = iio_backend_enable(back);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 578e8f33d27b..84d362272fc7 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -123,6 +123,8 @@ struct iio_backend_ops {
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


