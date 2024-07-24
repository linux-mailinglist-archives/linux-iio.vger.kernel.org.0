Return-Path: <linux-iio+bounces-7848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5A293B3EB
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 17:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278592814C8
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257D615B54F;
	Wed, 24 Jul 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="y9Y5/U8W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF9158849;
	Wed, 24 Jul 2024 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835562; cv=none; b=JIvYQUmUdomYda2r63gLBZUOeygKoK9ci6xh/fw4Tz3gVkafYS8RhFp8DKxw+OJQeiQ7I0LzfQW4H2n9KAN9sDB1w4VkVs70jXliK1zlk4/VhvtCwmzuv2SgVkluRS674ZERa9DZiU4ulOsotakZKabe+2BgY/j3u/SqK/ncH6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835562; c=relaxed/simple;
	bh=vJtj0uiRD+wRP4s4o+1Grzp9TQho48vg38ByCKz9zWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNG66t+5iiqMCCFI0IlimKn7ynPwVzwSLARB/NZP2RhdkGMMHW/ecZ0CPIVFfeW25dyC1jbGHhhVsShqUNke7EFQouRZ9RpXqwTOiNwLQgOIIMtjA8glcCu7v0vJlo4uvyxaNKwDsfSyYbWo8HRR8ugxe3BFua3HRAikqshlf7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=y9Y5/U8W; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OBrGTk007164;
	Wed, 24 Jul 2024 17:39:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	obAHl17FOwdgFwlnCpiB2B4Xs5wcoUI3xJvQSaUYnm8=; b=y9Y5/U8WkW07faan
	ZnYGE0i4Ps+G2YLRrnRMSUQUp0fCoXf4l/wHN/+Bj8KaJAaPvmtTm9HsdsTIBW9S
	dujDZ7ZETWxsA+415bEL/bK8duNpR1bhF0gm83ntxHbGeasRjWf6QrcZBJaSbbHV
	DlkeCi+fv6Rk84IVnX3mATZpfa6WKQ/Ecb2rK1TR9qmXVM2F+NyONRJ15WdDbww5
	GRhy6/5tG09dI7KdLIKDEWVqI6z02wacuqRbBo9E1/mXhS130vIl4ctVqdlRPxMK
	L7iImEJuOyja+kyKveaHI6e6RWp/mnFr7V2UiOuVr/sEaRtUG7jWvjhpvUSRcJES
	6NUeuw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40gpt16a0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 17:39:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4EEF640045;
	Wed, 24 Jul 2024 17:38:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A9A2D2414B1;
	Wed, 24 Jul 2024 17:38:30 +0200 (CEST)
Received: from localhost (10.252.12.39) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 24 Jul
 2024 17:38:30 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/9] iio: add child nodes support in iio backend framework
Date: Wed, 24 Jul 2024 17:36:31 +0200
Message-ID: <20240724153639.803263-4-olivier.moysan@foss.st.com>
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

Add an API to support IIO generic channels binding:
http://devicetree.org/schemas/iio/adc/adc.yaml#
This new API is needed, as generic channel DT node isn't populated as a
device.
Add devm_iio_backend_fwnode_get() to allow an IIO device backend
consumer to reference backend phandles in its child nodes.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 57 +++++++++++++++++++++---------
 include/linux/iio/backend.h        |  3 ++
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index b53904b03464..9e5ae3823595 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -577,19 +577,10 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
 	return 0;
 }
 
-/**
- * devm_iio_backend_get - Device managed backend device get
- * @dev: Consumer device for the backend
- * @name: Backend name
- *
- * Get's the backend associated with @dev.
- *
- * RETURNS:
- * A backend pointer, negative error pointer otherwise.
- */
-struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
+static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, const char *name,
+							 struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *fwnode;
+	struct fwnode_handle *fwnode_back;
 	struct iio_backend *back;
 	unsigned int index;
 	int ret;
@@ -604,17 +595,17 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 		index = 0;
 	}
 
-	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
+	fwnode_back = fwnode_find_reference(fwnode, "io-backends", index);
 	if (IS_ERR(fwnode))
 		return dev_err_cast_probe(dev, fwnode,
 					  "Cannot get Firmware reference\n");
 
 	guard(mutex)(&iio_back_lock);
 	list_for_each_entry(back, &iio_back_list, entry) {
-		if (!device_match_fwnode(back->dev, fwnode))
+		if (!device_match_fwnode(back->dev, fwnode_back))
 			continue;
 
-		fwnode_handle_put(fwnode);
+		fwnode_handle_put(fwnode_back);
 		ret = __devm_iio_backend_get(dev, back);
 		if (ret)
 			return ERR_PTR(ret);
@@ -622,11 +613,45 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 		return back;
 	}
 
-	fwnode_handle_put(fwnode);
+	fwnode_handle_put(fwnode_back);
 	return ERR_PTR(-EPROBE_DEFER);
 }
+
+/**
+ * devm_iio_backend_get - Device managed backend device get
+ * @dev: Consumer device for the backend
+ * @name: Backend name
+ *
+ * Get's the backend associated with @dev.
+ *
+ * RETURNS:
+ * A backend pointer, negative error pointer otherwise.
+ */
+struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
+{
+	return __devm_iio_backend_fwnode_get(dev, name, dev_fwnode(dev));
+}
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, IIO_BACKEND);
 
+/**
+ * devm_iio_backend_fwnode_get - Device managed backend firmware node get
+ * @dev: Consumer device for the backend
+ * @name: Backend name
+ * @fwnode: Firmware node of the backend consumer
+ *
+ * Get's the backend associated with a firmware node.
+ *
+ * RETURNS:
+ * A backend pointer, negative error pointer otherwise.
+ */
+struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
+						const char *name,
+						struct fwnode_handle *fwnode)
+{
+	return __devm_iio_backend_fwnode_get(dev, name, fwnode);
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_fwnode_get, IIO_BACKEND);
+
 /**
  * __devm_iio_backend_get_from_fwnode_lookup - Device managed fwnode backend device get
  * @dev: Consumer device for the backend
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 84d362272fc7..424a64477d48 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -155,6 +155,9 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
 				 struct iio_chan_spec *chan);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
+struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
+						const char *name,
+						struct fwnode_handle *fwnode);
 struct iio_backend *
 __devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
 					  struct fwnode_handle *fwnode);
-- 
2.25.1


