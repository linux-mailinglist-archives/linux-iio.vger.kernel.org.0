Return-Path: <linux-iio+bounces-8052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5F2940C2D
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 10:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CA81F25B98
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 08:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E67187337;
	Tue, 30 Jul 2024 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XcKpCUkt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84782193065;
	Tue, 30 Jul 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329328; cv=none; b=izmli8AZijIGz8Ddtm4TcZlUgztEQ+l2G6nMFID6Lai1fXHXwlRQF3TeJbEjxYE4eJ4ecC+clazabHMUBnPRhRfrFxBSQitDriEhRjT0qPZHUvBjQkECFWpdt6kJFEl0czGxSz5h2HzF3XtlhpaR0bBy8BATmKOjxa9ZvaE8CeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329328; c=relaxed/simple;
	bh=kBFneU6R49V+WQX1C3rXTq747w5qEc3IKhKihApmF4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhxRxuBGuxMofWAjPVcaX+l9iFsikFlwh6IsqBv5x2uDubuloidyxdmiM8HDNRHu99bPWx41QkOiGWh7yFtr+mvSuoeLo91N0idhYMfQ+7WeaBuCM81nvqZxqQyI2uji+id1Wsa0jvswCYI3QtM1KKNhIOiJOc9oK9JXqoyC8N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XcKpCUkt; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U8Ib5B012747;
	Tue, 30 Jul 2024 10:48:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	aLx2/9qybrXJ8bJcqI7xnqVCXKAknZa0c4mGUwESj2s=; b=XcKpCUktf8GzyunT
	3u2OMafIAnlJQ/KlOiiU+43n4mekA0qfTUQSXwP+fFF8mGFWJp+MmMXvZNrAX+7g
	iN2dD9GD5EFPMpuLilHB9gu25njN+AAYLaRyZRSS7ec0O0+1LU4eMiDyXFxVRjm5
	EEZ1s67X0yUyZMRc7f9LEcmNyNS3AxRDUXbCv0JdVl0iK7LGgOGR3agyXtRi0T6Q
	f8MlBA4XZt9DF8oS7ExXO/i+YlrljtvJU3c1jALX4WMIF1SYyGacdpqmNl9p1D+8
	EeJSBHFrMBvgV7nW+DeMbbVRbVWN2iWwQlU02nVVP1do0KWN6NGIt/PZH4MYq3yW
	BTaguw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40naf29dvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 10:48:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 219FD40044;
	Tue, 30 Jul 2024 10:48:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D542221F0A5;
	Tue, 30 Jul 2024 10:47:15 +0200 (CEST)
Received: from localhost (10.252.3.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 30 Jul
 2024 10:47:15 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/9] iio: add read scale and offset services to iio backend framework
Date: Tue, 30 Jul 2024 10:46:31 +0200
Message-ID: <20240730084640.1307938-2-olivier.moysan@foss.st.com>
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

Add iio_backend_read_scale() and iio_backend_read_offset() services
to read channel scale and offset from an IIO backbend device.

Also add a read_raw callback which replicates the read_raw callback of
the IIO framework, and is intended to request miscellaneous channel
attributes from the backend device.
Both scale and offset helpers use this callback.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 19 +++++++++++++++++++
 include/linux/iio/backend.h        | 24 +++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index f9da635cdfea..72dc82a42d8f 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -361,6 +361,25 @@ int devm_iio_backend_request_buffer(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
 
+/**
+ * iio_backend_read_raw - Read a channel attribute from a backend device.
+ * @back:	Backend device
+ * @chan:	IIO channel reference
+ * @val:	First returned value
+ * @val2:	Second returned value
+ * @mask:	Specify the attribute to return
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_read_raw(struct iio_backend *back,
+			 struct iio_chan_spec const *chan, int *val, int *val2,
+			 long mask)
+{
+	return iio_backend_op_call(back, read_raw, chan, val, val2, mask);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_read_raw, IIO_BACKEND);
+
 static struct iio_backend *iio_backend_from_indio_dev_parent(const struct device *dev)
 {
 	struct iio_backend *back = ERR_PTR(-ENODEV), *iter;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 29c4cf0bd761..18b20426c25e 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -3,6 +3,7 @@
 #define _IIO_BACKEND_H_
 
 #include <linux/types.h>
+#include <linux/iio/iio.h>
 
 struct iio_chan_spec;
 struct fwnode_handle;
@@ -81,6 +82,7 @@ enum iio_backend_sample_trigger {
  * @extend_chan_spec: Extend an IIO channel.
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
+ * @read_raw: Read a channel attribute from a backend device
  **/
 struct iio_backend_ops {
 	int (*enable)(struct iio_backend *back);
@@ -113,6 +115,9 @@ struct iio_backend_ops {
 			    const char *buf, size_t len);
 	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
 			    const struct iio_chan_spec *chan, char *buf);
+	int (*read_raw)(struct iio_backend *back,
+			struct iio_chan_spec const *chan, int *val, int *val2,
+			long mask);
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -141,7 +146,9 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 				 const char *buf, size_t len);
 ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan, char *buf);
-
+int iio_backend_read_raw(struct iio_backend *back,
+			 struct iio_chan_spec const *chan, int *val, int *val2,
+			 long mask);
 int iio_backend_extend_chan_spec(struct iio_backend *back,
 				 struct iio_chan_spec *chan);
 void *iio_backend_get_priv(const struct iio_backend *conv);
@@ -153,4 +160,19 @@ __devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
 int devm_iio_backend_register(struct device *dev,
 			      const struct iio_backend_ops *ops, void *priv);
 
+static inline int iio_backend_read_scale(struct iio_backend *back,
+					 struct iio_chan_spec const *chan,
+					 int *val, int *val2)
+{
+	return iio_backend_read_raw(back, chan, val, val2, IIO_CHAN_INFO_SCALE);
+}
+
+static inline int iio_backend_read_offset(struct iio_backend *back,
+					  struct iio_chan_spec const *chan,
+					  int *val, int *val2)
+{
+	return iio_backend_read_raw(back, chan, val, val2,
+				    IIO_CHAN_INFO_OFFSET);
+}
+
 #endif
-- 
2.25.1


