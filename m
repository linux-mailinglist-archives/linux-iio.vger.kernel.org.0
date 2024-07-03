Return-Path: <linux-iio+bounces-7262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00034926596
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 18:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310A71C21967
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142CD183091;
	Wed,  3 Jul 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hMwh3D2V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCEB18308B;
	Wed,  3 Jul 2024 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022904; cv=none; b=SZrRQFJwc9jITEcE4LqTa1pLSwy49q4nCYIwNLcCRlDzju6UVeDtZlA5rjDFhx/YxUGcPUsAs6ctKRLM2jNC2jvKK4/rqr4G7b/+6lznW/KU1aM+/9SIbinY5LeNkl2x4JaEdYF30PeOFxOY5GuvIpv2wcew0TGHE9JXIUn/IUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022904; c=relaxed/simple;
	bh=1z8V8HEBk+2j6wt+G/U1vVQmqcMILZmd3P4U3OMLbjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/a02X/iePKX6GldPC/f8N0+KJb6+ATLvL4eL7n/e2YZmhJy3eTCiOGHNAcJbA2imGoieL5i0xR3t/hQDwbX0ah//bPwcLgJBNxDB9fRgquLbzmcQjtg0QuIsYgPFggmSqLO9qCEq50Gi6niXanEGzMkOSTJXTLFPD/XO911pik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hMwh3D2V; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463Fswvx005432;
	Wed, 3 Jul 2024 18:08:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	5yUIOK1oSvhVoOntVMJRJ61xYS5I/uzj/mEkbfaRHck=; b=hMwh3D2VMJo1MvIo
	5duTjYJ3112sR3Q4cg7rilw7apc9vxynl+NgOn3D++Uu6wi934Q8GBog2GEgFF3e
	ZaMFKqOQjLpBYXOQEplUjlxhDEsicpLsfJN1BKprNKOiNnkULVq+TPqem0kcRHkm
	dPP8nrg7K0Hdvdc0InhUwHEZcCeHoukCh46XbFewNMMp4proYPG9nuzykhf4YKks
	thLpOvQjk8UDfvBAPmGtSJxK/I+aQ34+bFKVv14+NTOTtrvZ/01RTNOb+55Q3le8
	EgMo6ziz+UYa39otcT1+qzapshhEiZJ/GMbIGDOZUi40GxFjpKn8VabLm2lm+Zpq
	lich7Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 402w7j789s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 18:08:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 09C5D40046;
	Wed,  3 Jul 2024 18:07:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 56C0B2291AC;
	Wed,  3 Jul 2024 18:07:29 +0200 (CEST)
Received: from localhost (10.252.27.110) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Jul
 2024 18:07:29 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/8] iio: add child nodes support in iio backend framework
Date: Wed, 3 Jul 2024 18:05:28 +0200
Message-ID: <20240703160535.2277871-4-olivier.moysan@foss.st.com>
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

Add an API to support IIO generic channels binding:
http://devicetree.org/schemas/iio/adc/adc.yaml#
This new API is needed, as generic channel DT node isn't populated as a
device.
Add devm_iio_backend_fwnode_get() to allow an IIO device backend
consumer to reference backend phandles in its child nodes.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 56 +++++++++++++++++++++---------
 include/linux/iio/backend.h        |  2 ++
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index bb6aac68979f..522765c7784f 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -586,19 +586,10 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
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
@@ -613,17 +604,17 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
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
@@ -631,11 +622,44 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
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
index 696997f2c0d6..ec0d6a307c79 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -154,6 +154,8 @@ int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
 				 struct iio_chan_spec *chan);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
+struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev, const char *name,
+						struct fwnode_handle *fwnode);
 struct iio_backend *
 __devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
 					  struct fwnode_handle *fwnode);
-- 
2.25.1


