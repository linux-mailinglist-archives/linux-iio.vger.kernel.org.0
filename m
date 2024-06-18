Return-Path: <linux-iio+bounces-6519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C588B90D8EB
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 18:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5D8281E5B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9A06BFB0;
	Tue, 18 Jun 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="aY9Ll6nD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746C4C630;
	Tue, 18 Jun 2024 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727074; cv=none; b=ePc1hQtyy1/gIr3Wwafq/V828GYrrgTtaJgG5f/aqZUtfhte/wOxmL0vlAlbTMy9YhvnE/DD2YNek3aAf9IfC4wJRkDVSxOZeLFXA1WNBzThXJOVUgus+6eB/w7dqIaAupCGBv5d2BMtj/Ilw6oe22TJeWWL7FAbAsGFkMhgFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727074; c=relaxed/simple;
	bh=blUqWMur+GT3FDU86sdlfITnHZzcxIPkaS2QFUl1y9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcJF+2SS7cv79NMDQq4YicLpR66fToZfqQ6GNM8+11+K/pBpZ29PX2kCWVV9IfhUK5uhoq1gC730SsMwphKrd6hC4tZxL73fZnEyzw+efahINdq9jqu3twa787uKBcxk4G22clq34FfFHO2NoMsewI+G+Vppn+vLN9U4BxdsPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=aY9Ll6nD; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IBAh6F032172;
	Tue, 18 Jun 2024 18:10:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	GSJTsNXSeJ6OnoklQniiPvioT7fGdiL7gkkotOLYSXs=; b=aY9Ll6nDpTI5ll9p
	DoYmMKCz/5PcDEr2IxYR7Pt7Vo7DMtMgwGQxGh8DVBAjjjohNur5hy1Red9vjexv
	KdyDWPHZypu6KN1H26s4P/OL0IP8+WIu6neHakpnsoVomqTzFvx/I/EaYmNfIqRC
	unVwnoINZuOBPTA/zualkFGy3ozNgOl4LHiCPFlORZ+kffZ976wTdR5m+4arbx7m
	UGBnFAHeMkguhY2dRLctnQVQHq09IpYiJrVKF+QT9idR0ekUu1cHUBM8ZrxIl+j4
	OVTVZD6i1qUFy9e9NqgI5cHttH0dSjt0q/jLFCC+ftL7kjFDDoXA2z1CkgZ9B4s0
	D7SCew==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ysnwja5dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 18:10:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9F27E40044;
	Tue, 18 Jun 2024 18:10:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C5E8E21D382;
	Tue, 18 Jun 2024 18:10:25 +0200 (CEST)
Received: from localhost (10.252.27.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 18:10:25 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] iio: add child nodes support in iio backend framework
Date: Tue, 18 Jun 2024 18:08:29 +0200
Message-ID: <20240618160836.945242-4-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618160836.945242-1-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
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
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

Add an API to support IIO generic channels binding:
http://devicetree.org/schemas/iio/adc/adc.yaml#
This new API is needed, as generic channel DT node
isn't populated as a device.
Add devm_iio_backend_subnode_get() to allow an IIO device
backend consumer to configure backend phandles in its
child nodes.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/industrialio-backend.c | 48 ++++++++++++++++++++++--------
 include/linux/iio/backend.h        |  2 ++
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index d3db048c086b..e9d29131634d 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -575,17 +575,8 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
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
+static struct iio_backend *__devm_iio_backend_node_get(struct device *dev, const char *name,
+						       struct fwnode_handle *node)
 {
 	struct fwnode_handle *fwnode;
 	struct iio_backend *back;
@@ -602,7 +593,7 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 		index = 0;
 	}
 
-	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
+	fwnode = fwnode_find_reference(node, "io-backends", index);
 	if (IS_ERR(fwnode)) {
 		dev_err_probe(dev, PTR_ERR(fwnode),
 			      "Cannot get Firmware reference\n");
@@ -625,8 +616,41 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 	fwnode_handle_put(fwnode);
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
+	return __devm_iio_backend_node_get(dev, name, dev_fwnode(dev));
+}
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, IIO_BACKEND);
 
+/**
+ * devm_iio_backend_subnode_get - Device managed backend device get
+ * @dev: Consumer device for the backend
+ * @name: Backend name
+ * @node: Firmware node of the backend consumer
+ *
+ * Get's the backend associated with @dev.
+ *
+ * RETURNS:
+ * A backend pointer, negative error pointer otherwise.
+ */
+struct iio_backend *devm_iio_backend_subnode_get(struct device *dev, const char *name,
+						 struct fwnode_handle *node)
+{
+	return __devm_iio_backend_node_get(dev, name, node);
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_backend_subnode_get, IIO_BACKEND);
+
 /**
  * __devm_iio_backend_get_from_fwnode_lookup - Device managed fwnode backend device get
  * @dev: Consumer device for the backend
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 81277e5b6160..1050ab68e4e4 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -152,6 +152,8 @@ int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
 				 struct iio_chan_spec *chan);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
+struct iio_backend *devm_iio_backend_subnode_get(struct device *dev, const char *name,
+						 struct fwnode_handle *node);
 struct iio_backend *
 __devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
 					  struct fwnode_handle *fwnode);
-- 
2.25.1


