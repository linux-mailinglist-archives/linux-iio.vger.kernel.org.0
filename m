Return-Path: <linux-iio+bounces-6210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314E69054EA
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B63283950
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435E117E914;
	Wed, 12 Jun 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dYjr1fmP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501517E90F
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201853; cv=none; b=gfjPNNbflEiRpcyvz9dBTHgn5d3oqgLrcp5AAjay+DIQp4W4icHrDt9Od8BYCoRc8Xc8lyPxlhIQ3ekRiJJEx1C/yvAD4BI79RYqhbBKXEQCESHx4s9gE94czc49LDKWN+/JO6vINEBt0ZGjWXBzMw2d6AcO8KNqCyMOKPWEV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201853; c=relaxed/simple;
	bh=1NlGtxxAHIubQEBvsF8E/0tuFfrqkT9ncbgbD8ji7lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FiA9gKwD+bNPh0XGG5IlSA76h0Hdx4PZ/YEaKfOP9RRa8lj3ugV/2AXdrL8XqSK8LTLJoecSz2+ITNTH0n2Nk88sAbhCp/vKYdgcn5dll1ZdgxLWYbS566yYr6l9dareuB+Nc9Kl+UvksehhRWM7Nvdm6XwLkL39g2wH6xHSFfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dYjr1fmP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CC96t4001981;
	Wed, 12 Jun 2024 10:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TJ9js
	0XXbCIlby5p+oITpwdIysb4THYVK7yCy8et/Ww=; b=dYjr1fmPVvU272xdNwAD1
	1rb1PHpNiy60WpHzPteJUzBgztgpIxIVOU0UmhiBuRsjlEB3aDai17S4PHyEv7Ub
	3U4uZFnYDsXNSmIvEnHJSwK2dG918NLEuf2Rdf6iB7ZtmWVlHnTPcj5EJoXpEc6c
	Df7vJtUgDjXtm0JLaEpoj3d5XmAtw7Cx1xo5iSQB6j3KQyCkzZw0+T+t/WxF8UOX
	kNa8nnlKRHeXafBk6l4uGPBHbvYm6rkAEDNduMDhimGXeL5ojlZSCubTYkgLtdZ6
	A0NdG3f2GJ7Zjdjc7/hBomaMRMMhK0hECAi1CxazTxUEklzHh3ti34WZUv1J0YKf
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ymm727k3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 10:17:17 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45CEHGH5053073
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 10:17:16 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Jun 2024 10:17:15 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Jun 2024 10:17:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Jun 2024 10:17:14 -0400
Received: from [127.0.0.1] ([10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45CEH4Av027005;
	Wed, 12 Jun 2024 10:17:09 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 12 Jun 2024 16:20:48 +0200
Subject: [PATCH RFC 1/3] iio: core: add new helper to iterate active
 channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-dev-iio-scan-private-v1-1-7c75c8e3d30b@analog.com>
References: <20240612-dev-iio-scan-private-v1-0-7c75c8e3d30b@analog.com>
In-Reply-To: <20240612-dev-iio-scan-private-v1-0-7c75c8e3d30b@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718202053; l=1100;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1NlGtxxAHIubQEBvsF8E/0tuFfrqkT9ncbgbD8ji7lY=;
 b=YDzUurcxPLO9Yb8dYh7XSaTRIru5e6zsLArUTEsyNr+beh1woYMaVMDSNL/W8lG8CSxAPQtbZ
 y5LklbPX21OAXZVEoHu1pOIrKo6gcQt84PxGg4VBFt0tMcVqfpq8Ome
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: NkEsMbUE9Rx6CZJs3ihKcnlnZTX0QlEp
X-Proofpoint-GUID: NkEsMbUE9Rx6CZJs3ihKcnlnZTX0QlEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 mlxlogscore=968
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120101

Add a new iio_for_each_active_channel() helper to iterate over the
active channels. Also add an helper to access masklength using
ACCESS_PRIVATE(). End goal is to annotate that variable as __private so that
we can get checker warnings if drivers directly access that variable.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/iio/iio.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 894309294182..a63888746707 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -860,6 +860,12 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
 	int *fract);
 
+#define iio_dev_masklength(indio_dev)	ACCESS_PRIVATE(indio_dev, masklength)
+
+#define iio_for_each_active_channel(indio_dev, bit) \
+	for_each_set_bit((bit), (indio_dev)->active_scan_mask, \
+			 iio_dev_masklength(indio_dev))
+
 /**
  * IIO_DEGREE_TO_RAD() - Convert degree to rad
  * @deg: A value in degree

-- 
2.45.2


