Return-Path: <linux-iio+bounces-6895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763D0916C97
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3290928540D
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B0C17D8A7;
	Tue, 25 Jun 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ddUHvUmr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F2176ABC;
	Tue, 25 Jun 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328161; cv=none; b=Tdnjf69vdxTn2kLjH1vDEyOhQOFvDHhDfL/aI4R7oD7NF1c3cPpFdcUqYlXqFGpHKAi9s5XvfaaAEd9ejpNq88leiyWri9JJCER/BcImrEdJbKMlDcMB62fq0PcS3QgJSa8PvwT8Wj03JmuP82u6LyZjiH9oMt5x21RHJu9deU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328161; c=relaxed/simple;
	bh=DWyIRgAm2/ZgAsKzkSsxAMgx107uHC8RP532ONiCNdQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjJGYsGf/k5sXCfY53ZKi6QVYESlmoTOSk1m+dueHNp3J8nrUpOyUXRNYPqu7MbPw5B3gd4WX5h9IwHOEIApb4haFIyL28GmYLDaxlrrR4jspLO0pp6kllQIFd3iMPP+aMMIXxRn7BzxJIeOoCHAiyFO0sYeZxMXTgRdIl7Ifjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ddUHvUmr; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PCrVtL031056;
	Tue, 25 Jun 2024 17:09:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	tCXbFJg9wVsfi8NKUKCu/SDya2sct3sk/6NtMXHJ8xo=; b=ddUHvUmrMCufLCCH
	xJDdFtg/UwcUtHX5WuCfVteb1sPG78XarHF4u3NVPu4PqDsSXnOE6Oau7sjchaDi
	Q35k/3t41E1MqWsLfskyT5oEzAvY2oF0uqsXsOHpgFpDElq2XWIGLiPtS02aQvcx
	bbgk6E/UinvXwbeUF3g2eQWJvQkv9kIpz31PQVG9CjHMfmtdwywiOg4jDez8VCUH
	7lScJPOv7xCOeKIgkCvnHPGfJc2M5KlUoW0XH+6nsXncNC0Lzl9M1KkYZ1uTCDIh
	5Q5mdPE6E9yYHXloANlHcqyjQoIXLpixGLFjD+ZObdm0BO0PRu+kU7KaXuNUBqKX
	SSvgHA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywkr5cbwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:09:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6E47440048;
	Tue, 25 Jun 2024 17:08:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 704422207AC;
	Tue, 25 Jun 2024 17:08:28 +0200 (CEST)
Received: from localhost (10.252.26.63) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 17:08:28 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/8] iio: add enable and disable services to iio backend framework
Date: Tue, 25 Jun 2024 17:07:10 +0200
Message-ID: <20240625150717.1038212-3-olivier.moysan@foss.st.com>
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

Add iio_backend_disable() and iio_backend_enable() APIs to allow
IIO backend consumer to request backend disabling and enabling.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 25 ++++++++++++++++++++++++-
 include/linux/iio/backend.h        |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 0e2653de1956..6be1fa9a960b 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -146,6 +146,29 @@ static void __iio_backend_disable(void *back)
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
@@ -158,7 +181,7 @@ int devm_iio_backend_enable(struct device *dev, struct iio_backend *back)
 {
 	int ret;
 
-	ret = iio_backend_op_call(back, enable);
+	ret = iio_backend_enable(back);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 24185718b20d..23f21990b85f 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -121,6 +121,8 @@ struct iio_backend_ops {
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


