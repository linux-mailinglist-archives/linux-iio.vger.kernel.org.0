Return-Path: <linux-iio+bounces-13964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96975A043E7
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573C33A3DF6
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFD01F2C24;
	Tue,  7 Jan 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zMvGFybY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B21F2C20;
	Tue,  7 Jan 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262857; cv=none; b=mOyZH4oeWThFeXFfhBeUNzaEX/a1xwbcKNhFoD9LRRar2N0jIMFIr8pNsOxN2T0TEwDfqwAVMw62OYB6Xbc8vxMsNKvx318o4yDkbwWCSo0VC4kpbiXJlX2dIngDtV2BDvtPaR6KgFiLGrvbtOtM0h95OPApOC9kDNOK7hUtiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262857; c=relaxed/simple;
	bh=OWS3VmOHbA6Sm+CoV65kGZAxylw3vN1jEUei5YLsWd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G27xxSvtCX8tj5le8FVyoW6sckYMXN4HtDbdbEWfNQUXxvHHfbmDjCgz8fowSOIyknTq/uAcJvCKueSbrtyhpyBFArUqAF0Yz4DgF7N/vgrMB51H5j418+l+S3NiLab66XDhBUgpDzcDIDbkN9qxkrJbCj1PEiYZHYgkDOXvFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zMvGFybY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvDbY013537;
	Tue, 7 Jan 2025 10:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8cmf/
	l0/aCsILDzn7CXeVkfj25iXERXekxVq/yfDRrs=; b=zMvGFybYMJMTi1sMrtxZo
	qc9r14JlZtEGpy+31K+O4JUksY/+Ly0pd2E1pyg83ePpDCF+LaA+mMZ6CSniZD2s
	D0k5uip7OAcyFZC5eMNNtFfeon38T6S3nXkFlZRcJ/A8JlO5AhMWdvroL6FJWuWe
	kETQf0lJCVDkShsRquahrA63+o2NQokmCqGz+5UmCXrNORSOrj95M4IGk3b8Gz+J
	B1DTipA4UTgYAjuzs3477mh4DsMHf0I7op9ewKjh2Zg6GAN5EKooSnJPBItwtxXR
	v1YPNEwVprk/KA756zpPO2mj55HTfpLu6xQCwy0vKthKiwjJe6EQASOmJUmCl+Tz
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4415f6gc0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:13:57 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FDuqv033538
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:13:56 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:13:56 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:13:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:13:56 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FDeXm029895;
	Tue, 7 Jan 2025 10:13:43 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cosmin.tanislav@analog.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <marcelo.schmitt@analog.com>, <dlechner@baylibre.com>,
        <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 2/3] Documentation: ABI: IIO: Add filter_type documentation
Date: Tue, 7 Jan 2025 12:13:39 -0300
Message-ID: <30cf1924e6745e1e67a6543bef5bde578e7b1452.1736261048.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1736261047.git.marcelo.schmitt@analog.com>
References: <cover.1736261047.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: _nlZar0UstC0FIl1ho0pctKmhq3azkju
X-Proofpoint-GUID: _nlZar0UstC0FIl1ho0pctKmhq3azkju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070127

A previous patch added documentation for filter_type_available attributes.
However, the description for the value attribute (filter_type) was missing.
Add documentation for filter_type sysfs ABI.

Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 1faac5b2ad84..1ddf3d7dd2b3 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2299,6 +2299,13 @@ Description:
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
 
+What:		/sys/bus/iio/devices/iio:deviceX/filter_type
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies which filter type apply to the channel. The possible
+		values are given by the filter_type_available attribute.
+
 What:		/sys/.../events/in_proximity_thresh_either_runningperiod
 KernelVersion:	6.6
 Contact:	linux-iio@vger.kernel.org
-- 
2.45.2


