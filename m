Return-Path: <linux-iio+bounces-8054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E6B940C35
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 10:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4D0285B44
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 08:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65115194154;
	Tue, 30 Jul 2024 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wP7tM4Jp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374E192B9B;
	Tue, 30 Jul 2024 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329333; cv=none; b=Oj9XrArxZIq+KqgRx2bIZrqxsJ/I7aZ50uyAQSqVsCPWlFJpzBsZDwfnMdGxwB4SF/gHL1YHwy0eozGIKLmEoWlZlWyUsX1rN010xfZuMXOZ9PCWn1ILlz4ZliH6zy8KvLY4YpZ+I0ADlpr/HU2+xFX+NOZvbKooWc6Vsh5T3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329333; c=relaxed/simple;
	bh=/Aq309fEJ+Po2qLIink1l6xapJxeqax8AyON9pHaqqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCiTRzEgpmGalpWy+G/OLsEbZLFrA/vxt91MUFp0/sfgY9bIFMN5XYyU3ILKaa9z6cphhcp1vPa2pdd9xUk4xluBXrwEW0JydyjIaRePxgesajWbdKmUozDsbtw5G9dKVUDmFmBA3fQSUpSqY3wLLJOLvEk5LPj9rGlQuZzBjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wP7tM4Jp; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U60v73028193;
	Tue, 30 Jul 2024 10:48:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	oemq5k4NNHYaMwsZ+8EWpjsIvvc93Y9ynTIpRlDHi3c=; b=wP7tM4JpMGxvtaKU
	04lsk4/vq79spM4rKOBmz3QgKYYWLWq4iWkLgsBG4xzBkJ6Xl30Nv0wXc0PNkWua
	VjXHahmWpJZZubT1fP9RjM+/O9xE06n9XcsQIxcEWLgUp/9jNq2tn2whsyv/jWwT
	b5O8JfGZm5Ym7d7rS0WBOXxlODiiRj5zs2gpu7J7y8VbvzjPB6OqylnoRm75f7lf
	iHuDEZkwQnHfOuyirtGSDjp3goT7p6Cl4IDKQ14FzyqvOhYqPl2sG4KXCH9PZ68w
	1C8/VvjDPpzbs9ZLUSbgg920eJ8otd/hwyPpQBk2TeE/e3zpdBhFz2CiBuobuQ3k
	XgaH/w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40naf29dwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 10:48:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BC4BF40044;
	Tue, 30 Jul 2024 10:48:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0886821F0C6;
	Tue, 30 Jul 2024 10:47:17 +0200 (CEST)
Received: from localhost (10.252.3.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 30 Jul
 2024 10:47:16 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/9] iio: add enable and disable services to iio backend framework
Date: Tue, 30 Jul 2024 10:46:32 +0200
Message-ID: <20240730084640.1307938-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
References: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
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
 definitions=2024-07-30_09,2024-07-26_01,2024-05-17_01

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
index 18b20426c25e..25fce30f08d8 100644
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


