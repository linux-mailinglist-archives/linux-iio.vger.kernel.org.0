Return-Path: <linux-iio+bounces-6897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7794916CA0
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE8C281777
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9111717E44D;
	Tue, 25 Jun 2024 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="i5/bquyj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4ED17DE3F;
	Tue, 25 Jun 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328220; cv=none; b=JR8jVc5fyuGtJyzr4eF2caXV3vRV0udIpVCT7s6vBuGNnWcyicapIaq45rKyrvcjmkzoVWwshxj+MKiJpw1kMfPI8ru9yjv5HmCsPiedRjARmcRCIQuvuG27LhZyFBtY2Qptds3bgjkCrqL9sUaZOTleJbKdeNKik/YDtAW0Z/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328220; c=relaxed/simple;
	bh=Nxm/MVXf7/AR9EHi6YAuV5kZSaKsEifS4Rml97k7qkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMvrexM2541OZEiw7uAZum+d2BkV9yXCRnQO2T3X3MxNSFOZWsjvR7c9kKgVrVe1rEAxwfYDF00pt2gqgCQHMJL9Q+OLwb/PQ9LHXrgT+1E1SICcBIFwHrmj7QsLKLGoZFZKiJiiLaJcc7LiswUJf4tmxc5uuubQBGVJ9VuR+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=i5/bquyj; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PBi5T7011277;
	Tue, 25 Jun 2024 17:10:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	F4YmOnCQbw0N9IzGT1pQs6b7AWt5Zf3389UR4TetV4g=; b=i5/bquyj3EONNbpk
	Ey7heaZVt/pC0PxeqbqfZ7RfO+fo9bQCi5v1cIErEVsOxDvrUwWlE7iAHMiF2Dra
	1mRDVxBfoxkXSqM/VeC2G3vOJUn/8KeHmDw2t3OWRwg1O9hsB1NqLsQextxJysGH
	XfLo1HyNsWGKAXFl6XkDVqlBD/DJc7y6pzIcwMg1l8uIFguVqcKBM/i2/Jyyu9kz
	dsIh4kB1bPGJYt4NMemKdAn+mzZessHLcKR9u6TXHVex2tSPyTROHnZgTWKpyqnr
	7iVhcnwUqW/nWqrSYQKkzBupWvB1sNWoONJl1SQzu0cC3hwvztk9OYknnW0kVKoo
	InZCRA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx860jdxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:10:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5C95B40047;
	Tue, 25 Jun 2024 17:09:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 982092207A7;
	Tue, 25 Jun 2024 17:09:29 +0200 (CEST)
Received: from localhost (10.252.26.63) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 17:09:29 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/8] iio: add child nodes support in iio backend framework
Date: Tue, 25 Jun 2024 17:07:11 +0200
Message-ID: <20240625150717.1038212-4-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
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
 definitions=2024-06-25_10,2024-06-25_01,2024-05-17_01

Add an API to support IIO generic channels binding:
http://devicetree.org/schemas/iio/adc/adc.yaml#
This new API is needed, as generic channel DT node isn't populated as a
device.
Add devm_iio_backend_fwnode_get() to allow an IIO device backend
consumer to reference backend phandles in its child nodes.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 62 +++++++++++++++++++++---------
 include/linux/iio/backend.h        |  2 +
 2 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 6be1fa9a960b..8cc959ac278a 100644
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
@@ -604,19 +595,19 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 		index = 0;
 	}
 
-	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
-	if (IS_ERR(fwnode)) {
-		dev_err_probe(dev, PTR_ERR(fwnode),
+	fwnode_back = fwnode_find_reference(fwnode, "io-backends", index);
+	if (IS_ERR(fwnode_back)) {
+		dev_err_probe(dev, PTR_ERR(fwnode_back),
 			      "Cannot get Firmware reference\n");
-		return ERR_CAST(fwnode);
+		return ERR_CAST(fwnode_back);
 	}
 
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
@@ -624,11 +615,44 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
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
+struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev, const char *name,
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
index 23f21990b85f..6fa9f1c88f61 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -153,6 +153,8 @@ int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
 				 struct iio_chan_spec *chan);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
+struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev, const char *name,
+						struct fwnode_handle *node);
 struct iio_backend *
 __devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
 					  struct fwnode_handle *fwnode);
-- 
2.25.1


