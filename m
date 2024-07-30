Return-Path: <linux-iio+bounces-8057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A16940C3E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 10:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA43286D3A
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED88193087;
	Tue, 30 Jul 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Vco5X4a/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A533118F2CA;
	Tue, 30 Jul 2024 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329345; cv=none; b=ccPxe4+4FUY95OHRQCugGy5IPrj6I0HL76o1iptujuP6jHQM15tUFCD9f1yqhpHgVYuQhFF43S5s4n3l0Oa+Lsqov1KHcxnT++5EKYr0oKrF0gOtrkFedkRsDxKVNk6mTDfQ4s5+uCM3bdZTsFsfUoW4HCAOdb1MGp8w8faEjXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329345; c=relaxed/simple;
	bh=EHEwJMzYa5PY577fQamLCn+2jW+7V8xe3KWQf3LJ3ZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPD911yEEuTt/oGU915VJ0sd5qSLNHKJyWMET04gdl3jw8Z9z+XIkeExQCqgUYtam7rBJReuPWZ3LL99bbtEVbABNbURQkIY0stO4KToKwsgYV40H2fU5RlpUc45LRFj96r5lpFpZ+SXE49has/SnVlP75v+W03wPK+tO9xrb+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Vco5X4a/; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U5OGkn011282;
	Tue, 30 Jul 2024 10:48:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	3YExFMT+k8wI+SwJnxQ8w9XUS1Au+eC75USmBFji0z4=; b=Vco5X4a/FkvpIIf0
	oMqqrtc10/gFd43XWTTMd8OKq1SLBE+06pUkmWVxJiKCoGyI3QaK2Kz6ODqOQB4j
	Nn0NpCD9VoOnx14hu5BLflw9TdkvYSKwDzns5gkmuXqvX1bCCzLROtbGnGIHrawf
	buJsat2C5eeT79AeOI9XU/V7gAHnAe9Od/fg6Gy5ex2piHfNT6GGrR2WlXHiYOBv
	PyaRQVUBtHvngvdrY5eZp3bpMT2zkz03NEENEFtSuT469jrlfDh90Vv5+DpX/cEq
	M9BlAGuxs8vyvR0e2ijLfo/O8PAi1MZcHb4+6Dk3G+gMkswBlReonSPWcAbjZ2AJ
	sIe5xw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40mpagc30u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 10:48:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BF0F840044;
	Tue, 30 Jul 2024 10:48:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3548721ADC5;
	Tue, 30 Jul 2024 10:48:18 +0200 (CEST)
Received: from localhost (10.252.3.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 30 Jul
 2024 10:48:17 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/9] iio: add child nodes support in iio backend framework
Date: Tue, 30 Jul 2024 10:46:33 +0200
Message-ID: <20240730084640.1307938-4-olivier.moysan@foss.st.com>
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
index 25fce30f08d8..93ba89a3e436 100644
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


