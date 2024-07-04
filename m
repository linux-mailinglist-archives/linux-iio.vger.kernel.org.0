Return-Path: <linux-iio+bounces-7317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BE4927A9C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C651C23B60
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D81B14F3;
	Thu,  4 Jul 2024 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LQM5sHRr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DC1AD403;
	Thu,  4 Jul 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108598; cv=none; b=rxGDLtpKq+ihG5XsZuJGWtgzdAkHM3I2o7sqW5nQDBOL672Uh6NUml5d8dYQss16lbKBLp5DuqKspJEOv2mmxk1I+940OzjDVH2W416w9L+LMT3MXMBH9mte/hy0ZO1FnwNqOsQg0elAjUdldmHP8dDLFxlMqr/uTCQ23moYPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108598; c=relaxed/simple;
	bh=53UhMXqkQ/FjSJYtW4+BEOnxpGdLmgdfKucfYdP67nM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k24vVUalB62IaBeta2I3k0PfwkHwroqqHYTutTvwhsuC3dCp5lnLI4f2iPI7ZV+yGP96ic4NPqRoQ1z0THjgp1Cr2NowkPTYDCUxZbihGBZIS8VW/RunuSyoKCE0M4ffLyS1rke0OR5Lzl0UZ/Jv6zxg8RT1p5idgQU2kkDzbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LQM5sHRr; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464BGSxE015863;
	Thu, 4 Jul 2024 17:56:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	VWOXh5qERCLxblJ9Gwq00gOLdmVVQpKvvRh5HL52+lY=; b=LQM5sHRrmi3F3Yi7
	HhwFvlLQ2YNeWaMgZf9A49AkLPEOiMM/lqFt2WXguSWBG9qzKj3q5epAGnOg3M3I
	sqnIZDuUovlgY3ly+2kd2d82Z4PiHfxNaNQLKw5P7/bj/YOMAzJ3XodkzxpxscdK
	ZccewLvUNH4baAqxPyIRW7xOjxS/JyUGBs6cmayRTlU3vYp1sUrGNxoq9SdrhPaI
	aClELI8FJ6JVbM+hAkN0q/nirQPVY2Q6pB5qERf5Do1IBBcXghXXLLa51I48N2tk
	MQtjFSL3VTP78odBte5r2zyI4eK7SKEwt4W+9bl8uum5AqmGcNRRvZR6pUgoHylV
	JNWbIw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4027d5nxqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 17:56:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3E43F40049;
	Thu,  4 Jul 2024 17:56:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 72EB82291D1;
	Thu,  4 Jul 2024 17:55:45 +0200 (CEST)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Jul
 2024 17:55:45 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/8] iio: add read scale and offset services to iio backend framework
Date: Thu, 4 Jul 2024 17:53:29 +0200
Message-ID: <20240704155338.2387858-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
References: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01

Add iio_backend_read_scale() and iio_backend_read_offset() services
to read channel scale and offset from an IIO backbend device.

Also add a read_raw callback which replicates the read_raw callback of
the IIO framework, and is intended to request miscellaneous channel
attributes from the backend device.
Both scale and offset helpers use this callback.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 34 ++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  9 +++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index efe05be284b6..4e0ff6e6e9d4 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -357,6 +357,40 @@ int devm_iio_backend_request_buffer(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
 
+/**
+ * iio_backend_read_scale - Request channel scale from the IIO backend.
+ * @back:	Backend device
+ * @chan:	IIO channel reference
+ * @scale:	returned scale value
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_read_scale(struct iio_backend *back,
+			   struct iio_chan_spec const *chan, int *scale)
+{
+	return iio_backend_op_call(back, read_raw, chan, scale, NULL,
+				   IIO_CHAN_INFO_SCALE);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_read_scale, IIO_BACKEND);
+
+/**
+ * iio_backend_read_offset - Request channel offset from the IIO backend.
+ * @back:	Backend device
+ * @chan:	IIO channel reference
+ * @offset:	returned offset value
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_read_offset(struct iio_backend *back,
+			    struct iio_chan_spec const *chan, int *offset)
+{
+	return iio_backend_op_call(back, read_raw, chan, offset, NULL,
+				   IIO_CHAN_INFO_OFFSET);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_read_offset, IIO_BACKEND);
+
 static struct iio_backend *iio_backend_from_indio_dev_parent(const struct device *dev)
 {
 	struct iio_backend *back = ERR_PTR(-ENODEV), *iter;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 8099759d7242..2d80e3fa58ce 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -81,6 +81,7 @@ enum iio_backend_sample_trigger {
  * @extend_chan_spec: Extend an IIO channel.
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
+ * @read_raw: Read a channel attribute from a backend device
  **/
 struct iio_backend_ops {
 	int (*enable)(struct iio_backend *back);
@@ -113,6 +114,9 @@ struct iio_backend_ops {
 			    const char *buf, size_t len);
 	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
 			    const struct iio_chan_spec *chan, char *buf);
+	int (*read_raw)(struct iio_backend *back,
+			struct iio_chan_spec const *chan, int *val, int *val2,
+			long mask);
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -141,7 +145,10 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 				 const char *buf, size_t len);
 ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan, char *buf);
-
+int iio_backend_read_scale(struct iio_backend *back,
+			   struct iio_chan_spec const *chan, int *scale);
+int iio_backend_read_offset(struct iio_backend *back,
+			    struct iio_chan_spec const *chan, int *offset);
 int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
 				 struct iio_backend *back,
 				 struct iio_chan_spec *chan);
-- 
2.25.1


