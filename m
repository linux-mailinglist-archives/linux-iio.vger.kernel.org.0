Return-Path: <linux-iio+bounces-14945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 306D0A26356
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 20:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144731885757
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857BF20B7ED;
	Mon,  3 Feb 2025 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SGTN8tGo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19062054E6;
	Mon,  3 Feb 2025 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609899; cv=none; b=rKon4R4g6CPBHbEKPmDZevlO1i9LNp6kxz7zxgmmVBJuzN4hoyD4sfqjb222w3SVFWnDOUhCLSSrzurbwET98DS8jf0b/BTw42xqtqYOGFAjXslGICaOF6+L9K+7Ta3TPRQAt53yZmjYfOkIfBzhSxAPAlyWCyW3sJu+O4PC7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609899; c=relaxed/simple;
	bh=EjJaZkY11QYq1RRCJOR+aACep4F0Xl88By6MCo+JSfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfRf+Z55MAAApVAoTMF7MPW0HrN6TZBNAugxbsel2i7ypfkIamNjAnFd08j88vcrrxqVIKUhnZD/tQVrVxVE8RJlRVXe4WkfMmo1VOC5ITYcaJCFPl4Hq8kK5hanh/sxbWZKubbcjDN8favdz/cS0S7UugrfTdCZRuwoMyBbogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SGTN8tGo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513EB9s8022304;
	Mon, 3 Feb 2025 14:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xQVi5
	UQ6DE0lyaXvQnYcnPtQV/VkMpVMcSAqeXvV6lA=; b=SGTN8tGo3dziMbvZW7R+V
	cbKWbBRd5mI2FlfjetgtYZAQwNJlQq1MY2qj3MQKz5RVEMfIeKNT0WvWE9DJQqaE
	8hI5Zyc44JqFPvaPyyycl7foWrJhO6AVr6Naz/RRcby6hgpx+Q4uyObS/nPI2ab3
	YgmJXxPS2iWPYNKf55YysWD2SUH+y+O/V3toENGYWzj5TlNw9lLgPVPP8EgsZLFa
	4gz/oATuganYdG56MkS2s2EjYu/GjUdHGP7p/Mj2YX/OmIgOKjtGVYLoYtc9KR/w
	W+rbWjcmQGscNpjKOh6aShdV5TyY31uACXFvlKP3i2XasWoOiFkPl9AgIFcmUuEk
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44jp6mb8s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:11:22 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 513JBLd8052016
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Feb 2025 14:11:21 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 3 Feb 2025
 14:11:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 3 Feb 2025 14:11:21 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 513JB6tB026382;
	Mon, 3 Feb 2025 14:11:09 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cosmin.tanislav@analog.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <marcelo.schmitt@analog.com>, <dlechner@baylibre.com>,
        <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 1/3] Documentation: ABI: IIO: Add filter_type documentation
Date: Mon, 3 Feb 2025 16:11:04 -0300
Message-ID: <cd749bbbf13b27caac5734b22c716124565a7216.1738608986.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1738608986.git.marcelo.schmitt@analog.com>
References: <cover.1738608986.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: rzi2pcv5sstR3Gl_8-eeXKRD1ziBBwRO
X-Proofpoint-ORIG-GUID: rzi2pcv5sstR3Gl_8-eeXKRD1ziBBwRO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030139

A previous patch added documentation for filter_type_available attributes.
However, the description for the value attribute (filter_type) was missing.
Add documentation for filter_type sysfs ABI.

Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d97c35057a03..ff9cc09360dc 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2300,6 +2300,14 @@ Description:
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
 
+What:		/sys/bus/iio/devices/iio:deviceX/filter_type
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_type
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
2.47.2


