Return-Path: <linux-iio+bounces-6517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D4B90D8B8
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 18:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A7428686A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC674063;
	Tue, 18 Jun 2024 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="i91YT2Ob"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08C50297;
	Tue, 18 Jun 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727017; cv=none; b=pvvfSMb7dhWegkpKzFNskyvPVCjnCZUgzKNshraw02tiDcIEWiKg1tK6qlTXC49Jmo8w404KAs6TrSjeN5LyieOwRHInmU7QXM5enAXWOtd4Y5fGi770twM4VHgzGO5a2sUdGUehoHYs2lObPZnSa/QBw4l8LrSpi2yvZds6GBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727017; c=relaxed/simple;
	bh=USB1J3c1I1YDJiBjUQrzN4H4/OWzJtRXO4GYW8Vt/iQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXmSD53vuKtsxUWn+IW0fCnWama6/Nt7esg5tQqxlX0wBbah8p5oNLK8a0lUrqV2zYtsUMm+dPcewrY4elLyTYkFbhZ9tTASVOC/wfhZiMsYbeScEoKTbAMQA5PG9IDfpdcTxO9Vs3x+uXJtz5pLdhCnGUTt8TQO/mn29tTwT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=i91YT2Ob; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IG0GqB014183;
	Tue, 18 Jun 2024 18:09:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	vtRrWuN32WlRT8GMWwj0eu9Vi1SpQstEyGYmHWc9F/Q=; b=i91YT2ObqSmeWtxS
	zaCibFgRdSefsdEGbk5Z0BCAbbxaetDrrArO1KAXjF1jMj1Da1L57S5qJl6fsIod
	Z4kegLTNGV1Kxvf6TwyrAoauzoEv5hbSxLMO7JxO+5LQ9iw1hJSL1mzFJ3eeBP2L
	28gIuW7HlDQuRod8ThzH6mZuWD9ji5Z5ougpr8lp8C2RyRImxHMBr+sKW2+StWkW
	nlHD/btne38O1VFsH4y1thO3ZQhUPdE/8Fz5nqVPoZ2vSLtPNYUIVqqlSDeUOraO
	QbIJP4kazrBTv7U9a5WQX8Q7vzZ/xKEsBl/xpM3rmPd41ItjzDZYspjExazOxHbu
	XOPWQQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys035m8dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 18:09:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 60A5A40045;
	Tue, 18 Jun 2024 18:09:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A141721D3CA;
	Tue, 18 Jun 2024 18:09:24 +0200 (CEST)
Received: from localhost (10.252.27.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 18:09:24 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] iio: add enable and disable services to iio backend framework
Date: Tue, 18 Jun 2024 18:08:28 +0200
Message-ID: <20240618160836.945242-3-olivier.moysan@foss.st.com>
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

Add iio_backend_disable() and iio_backend_enable() APIs to allow
IIO backend consumer to request backend disabling and enabling.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/industrialio-backend.c | 26 ++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index b950e30018ca..d3db048c086b 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -166,6 +166,32 @@ int devm_iio_backend_enable(struct device *dev, struct iio_backend *back)
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_backend_enable, IIO_BACKEND);
 
+/**
+ * iio_backend_enable - Backend enable
+ * @dev: Consumer device for the backend
+ * @back: Backend device
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_enable(struct device *dev, struct iio_backend *back)
+{
+	return iio_backend_op_call(back, enable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_enable, IIO_BACKEND);
+
+/**
+ * iio_backend_disable - Backend disable
+ * @dev: Consumer device for the backend
+ * @back: Backend device
+ *
+ */
+void iio_backend_disable(struct device *dev, struct iio_backend *back)
+{
+	iio_backend_void_op_call(back, disable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_disable, IIO_BACKEND);
+
 /**
  * iio_backend_data_format_set - Configure the channel data format
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index cff486699054..81277e5b6160 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -120,6 +120,8 @@ struct iio_backend_ops {
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
 int iio_backend_chan_disable(struct iio_backend *back, unsigned int chan);
 int devm_iio_backend_enable(struct device *dev, struct iio_backend *back);
+int iio_backend_enable(struct device *dev, struct iio_backend *back);
+void iio_backend_disable(struct device *dev, struct iio_backend *back);
 int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
 				const struct iio_backend_data_fmt *data);
 int iio_backend_data_source_set(struct iio_backend *back, unsigned int chan,
-- 
2.25.1


