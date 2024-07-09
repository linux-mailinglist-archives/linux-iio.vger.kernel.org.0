Return-Path: <linux-iio+bounces-7462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F8E92B63A
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 13:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBDA1C21A7E
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E144157E9B;
	Tue,  9 Jul 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CtSnOtca"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A066156F45
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523495; cv=none; b=pgYWf9AnNfGV30dAEQSFpdZG9o9jxlfzcYKyaRRtlplgGTeSK09qiCbonXm7fSImu/kAukJ5kdwLCP8c0k8ZOho+fSDRAUmBTYfkhbH0MfHI7occs7Ei8AHa4GRinDaF8fgpOxiCuj+bS0d+GJu8Ah6mkmdrQ+Te6UId9WFi9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523495; c=relaxed/simple;
	bh=AxoDbIsUCwSnpCKE90xWkm5dUWtjVswyE9WNQfobjbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iqndigOLq0WLELo8I4iT++4KbUYmsqp8YUBICxqzvyQ2W5LjpJZTKTX3U+nzR2VMP+eg7pQy9hz189cEWCnQ8+GkdFp7PconkplrrIv3FrtLnCbmc2J1HnEevvXYgk6KUCRnhMq0+TAB0p4zU7JfWeumV1YGEOt4tK8xW3ZUkUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CtSnOtca; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697pnEK011000;
	Tue, 9 Jul 2024 07:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jm2q/
	HuubdAJiDA5Sc1XDDuVl8Nt039rEqc8IbcH0Wc=; b=CtSnOtcaamaqJuhlB1Je8
	cgu1OngaMAu4ggjQlcWf6qu8Np6nTswoWc6eWY9+aVDELX/FX30I4ACjnG443da2
	i/0hqYLO53KOYN1qJDOPAvJRIs7TEkU2wwAq0vPrKiNilDHcGOnyi8kwWYSidviE
	CuMMnsPqGRyV+y/bPZNPeU9gscVC3yzn8gjnPQXIgRGe2OxIqOKZYWgrHFeoMWRp
	kNFcxKa09ey2FvpsFLiY1XRsnpGy6NjsJYDwJdbGsUoMkHD/JQy79jFkxZd1jqqo
	cXapDBXJ99LUgZQpPYYGNnlb924qCNCK5s5k8CnzCVEuO5roYBmE8S9oxzTvgS2H
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 408fy4m1qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:11:04 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 469BB3kx046278
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 07:11:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 9 Jul 2024
 07:11:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 9 Jul 2024 07:11:02 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 469BAlgm032387;
	Tue, 9 Jul 2024 07:10:56 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 9 Jul 2024 13:14:30 +0200
Subject: [PATCH 3/9] iio: backend: add debugFs interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-dev-iio-backend-add-debugfs-v1-3-fb4b8f2373c7@analog.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
In-Reply-To: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720523682; l=6823;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=AxoDbIsUCwSnpCKE90xWkm5dUWtjVswyE9WNQfobjbo=;
 b=l7SfHM9ilv+L+F9MrnpY7EO+ZqCUo/WkW/mWH1/C37a4bGrGVJTpbN389lo3huV2S2oMs3Wjt
 8jpjbxSxLerCo7J/mlbA7FL3XwZz2V7O7dmo324EgDlmL4PM6YFvDtj
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: zd7t_c0Nn4AGemms1rC6D6kAfkhI_YWD
X-Proofpoint-ORIG-GUID: zd7t_c0Nn4AGemms1rC6D6kAfkhI_YWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090076

This adds a basic debugfs interface for backends. Two new ops are being
added:

 * debugfs_reg_access: Analogous to the core IIO one but for backend
   devices.
 * debugfs_print_chan_status: One useful usecase for this one is for
   testing test tones in a digital interface and "ask" the backend to
   dump more details on why a test tone might have errors.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 115 +++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  16 +++++-
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index f9da635cdfea..52cbde0d5885 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -32,6 +32,7 @@
 #define dev_fmt(fmt) "iio-backend: " fmt
 
 #include <linux/cleanup.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -46,6 +47,8 @@
 #include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
 
+#define IIO_BACKEND_DEFAULT_NAME	"backend"
+
 struct iio_backend {
 	struct list_head entry;
 	const struct iio_backend_ops *ops;
@@ -53,6 +56,8 @@ struct iio_backend {
 	struct device *dev;
 	struct module *owner;
 	void *priv;
+	const char *name;
+	unsigned int cached_reg_addr;
 };
 
 /*
@@ -117,6 +122,111 @@ static DEFINE_MUTEX(iio_back_lock);
 			__stringify(op));			\
 }
 
+static ssize_t iio_backend_debugfs_read_reg(struct file *file,
+					    char __user *userbuf,
+					    size_t count, loff_t *ppos)
+{
+	struct iio_backend *back = file->private_data;
+	char read_buf[20];
+	unsigned int val;
+	int ret, len;
+
+	ret = iio_backend_op_call(back, debugfs_reg_access,
+				  back->cached_reg_addr, 0, &val);
+	if (ret)
+		return ret;
+
+	len = scnprintf(read_buf, sizeof(read_buf), "0x%X\n", val);
+
+	return simple_read_from_buffer(userbuf, count, ppos, read_buf, len);
+}
+
+static ssize_t iio_backend_debugfs_write_reg(struct file *file,
+					     const char __user *userbuf,
+					     size_t count, loff_t *ppos)
+{
+	struct iio_backend *back = file->private_data;
+	unsigned int val;
+	char buf[80];
+	ssize_t rc;
+	int ret;
+
+	rc = simple_write_to_buffer(buf, sizeof(buf), ppos, userbuf, count);
+	if (rc < 0)
+		return rc;
+
+	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
+
+	switch (ret) {
+	case 1:
+		return count;
+	case 2:
+		ret = iio_backend_op_call(back, debugfs_reg_access,
+					  back->cached_reg_addr, val, NULL);
+		if (ret)
+			return ret;
+		return count;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct file_operations iio_backend_debugfs_reg_fops = {
+	.open = simple_open,
+	.read = iio_backend_debugfs_read_reg,
+	.write = iio_backend_debugfs_write_reg,
+};
+
+/**
+ * iio_backend_debugfs_add - Add debugfs interfaces for Backends
+ * @back: Backend device
+ * @indio_dev: IIO device
+ */
+void iio_backend_debugfs_add(struct iio_backend *back,
+			     struct iio_dev *indio_dev)
+{
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+	char attr_name[128];
+
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+	if (!back->ops->debugfs_reg_access || !d)
+		return;
+
+	snprintf(attr_name, sizeof(attr_name), "%s_direct_reg_access",
+		 back->name);
+
+	debugfs_create_file(attr_name, 0644, d, back,
+			    &iio_backend_debugfs_reg_fops);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_debugfs_add, IIO_BACKEND);
+
+/**
+ * iio_backend_debugfs_print_chan_status - Print channel status
+ * @back: Backend device
+ * @chan: Channel number
+ * @buf: Buffer where to print the status
+ * @len: Available space
+ *
+ * One usecase where this is useful is for testing test tones in a digital
+ * interface and "ask" the backend to dump more details on why a test tone might
+ * have errors.
+ *
+ * RETURNS:
+ * Number of copied bytes on success, negative error code on failure.
+ */
+ssize_t iio_backend_debugfs_print_chan_status(struct iio_backend *back,
+					      unsigned int chan, char *buf,
+					      size_t len)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return -ENODEV;
+
+	return iio_backend_op_call(back, debugfs_print_chan_status, chan, buf,
+				   len);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_debugfs_print_chan_status, IIO_BACKEND);
+
 /**
  * iio_backend_chan_enable - Enable a backend channel
  * @back: Backend device
@@ -577,6 +687,11 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 		if (ret)
 			return ERR_PTR(ret);
 
+		if (name)
+			back->name = name;
+		else
+			back->name = IIO_BACKEND_DEFAULT_NAME;
+
 		return back;
 	}
 
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 4e81931703ab..a643d86c7487 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -9,6 +9,7 @@ struct fwnode_handle;
 struct iio_backend;
 struct device;
 struct iio_dev;
+struct dentry *d;
 
 enum iio_backend_data_type {
 	IIO_BACKEND_TWOS_COMPLEMENT,
@@ -22,6 +23,8 @@ enum iio_backend_data_source {
 	IIO_BACKEND_DATA_SOURCE_MAX
 };
 
+#define iio_backend_debugfs_ptr(ptr)	PTR_IF(IS_ENABLED(CONFIG_DEBUG_FS), ptr)
+
 /**
  * IIO_BACKEND_EX_INFO - Helper for an IIO extended channel attribute
  * @_name: Attribute name
@@ -81,6 +84,8 @@ enum iio_backend_sample_trigger {
  * @extend_chan_spec: Extend an IIO channel.
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
+ * @debugfs_print_chan_status: Print channel status into a buffer.
+ * @debugfs_reg_access: Read or write register value of backend.
  **/
 struct iio_backend_ops {
 	int (*enable)(struct iio_backend *back);
@@ -113,6 +118,11 @@ struct iio_backend_ops {
 			    const char *buf, size_t len);
 	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
 			    const struct iio_chan_spec *chan, char *buf);
+	int (*debugfs_print_chan_status)(struct iio_backend *back,
+					 unsigned int chan, char *buf,
+					 size_t len);
+	int (*debugfs_reg_access)(struct iio_backend *back, unsigned int reg,
+				  unsigned int writeval, unsigned int *readval);
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -152,5 +162,9 @@ __devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
 
 int devm_iio_backend_register(struct device *dev,
 			      const struct iio_backend_ops *ops, void *priv);
-
+ssize_t iio_backend_debugfs_print_chan_status(struct iio_backend *back,
+					      unsigned int chan, char *buf,
+					      size_t len);
+void iio_backend_debugfs_add(struct iio_backend *back,
+			     struct iio_dev *indio_dev);
 #endif

-- 
2.45.2


