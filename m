Return-Path: <linux-iio+bounces-14977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C1A27559
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 16:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F46E162DE1
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE0E2153FD;
	Tue,  4 Feb 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PS1qSbFR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C42147E9;
	Tue,  4 Feb 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681292; cv=none; b=TnFtFnxuMTFDZOwqWS9Y70+XTCzhEqLcoPyC/6lbE/k13ZOt/cchcSnlMUlOwaFOJnGP6O+0ED4DoKadEMWHnbjjs4Xh3xWGIZqjNgar36MZ/v1sTGqlmJFbIuyIbXwJBD6+ZE65bH1cXrtRuhoSBFZUuRubRqlzKyGkYgz0T20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681292; c=relaxed/simple;
	bh=9sxbJdxubH8PKeJUumaTFMB3vg2RZVnrkW6XnlLhRmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAht5AyykKET0nwCrJVd2Kh0gNHr8RckGm1HGsuMqQvw/4+WBZ0SDqi0q2+rgV/iCdsduAzaVoi7lcDsDOzw7kMU3f6rjvqvRQN4bIMkb50KxWW1AomrfhA8CED/b1ksaFLcJ8kkI27J2gRAVPcLQ5F1zasvVCDscZ8Lv9bnsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PS1qSbFR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514E1u97006966;
	Tue, 4 Feb 2025 10:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AAEdC
	bK3F/uGLacxNioJGlCxuiBgiEh5Aq6j43SGgPQ=; b=PS1qSbFRHlM5UZEiI+Ngi
	C1OWJewk0sJdRsQA2xA8MWZSSM68s3AS7MLX9HMruGZk7eQVR2odDUQeZ4N2OYtz
	7LPuWw+x9+vASIIDzUO9oFU8JPNAeX1yDhOr0YZVEcNWcJkRDPNNL43Xx9hiBqJO
	vBkqIyFLKIgSzqnLtQp0hEBJgbTbq/BkOJTe41VWHz8IOp8Om4urL+G288jS+0fW
	sEUS63fKwazDlaMundqvNzhQv/4RGYaKqDO+50iYo0NnRLLh7ne3ddaDu/XiG7MA
	KuHtw64KYdLSGI3q7LrBbH/HhKvf0pW4p2l96Fhr3Xi2XlwMOvxOPC0bm0jT7vew
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44kma3g8cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 10:01:15 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 514F1EYI020918
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Feb 2025 10:01:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Feb 2025
 10:01:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Feb 2025 10:01:14 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 514F0xFq005447;
	Tue, 4 Feb 2025 10:01:01 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cosmin.tanislav@analog.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <marcelo.schmitt@analog.com>, <dlechner@baylibre.com>,
        <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 2/3] Documentation: ABI: IIO: Re-add sysfs-bus-iio-adc-ad4130
Date: Tue, 4 Feb 2025 12:00:57 -0300
Message-ID: <c77b2d65f1115c1c394582f55944d6f685058f9c.1738680728.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1738680728.git.marcelo.schmitt@analog.com>
References: <cover.1738680728.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Df7tqutW c=1 sm=1 tr=0 ts=67a22bbb cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=40AwTsln27GJRGhbypkA:9 a=oVHKYsEdi7-vN-J5QA_j:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: dAe7hpmx5onnio9NJOhpq_gXH-XGLUah
X-Proofpoint-ORIG-GUID: dAe7hpmx5onnio9NJOhpq_gXH-XGLUah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040117

The ad4130 driver exports in_voltageY-voltageZ_filter_mode and
in_voltage-voltage_filter_mode_available attributes to user space. A
previous patch merged the documentation for those attributes with the
documentation for filter_type/filter_type_available into sysfs-bus-iio.
Filter mode and filter type refer to the same feature which is the digital
filter applied over ADC samples. However, since datasheets use the term
`filter type` and ad4130 driver is the only one using filter_mode,
deprecate the filter_mode ABI in favor of filter_type and keep the docs
separate to avoid confusion and intricate attribute descriptions.

Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio       |  2 +-
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 20 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ff9cc09360dc..2f8898c1a664 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2277,7 +2277,7 @@ Description:
 		representing the sensor unique ID number.
 
 What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_type_available
 KernelVersion:	6.1
 Contact:	linux-iio@vger.kernel.org
 Description:
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
new file mode 100644
index 000000000000..d3fad27421d6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
@@ -0,0 +1,20 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
+KernelVersion:  6.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns a list with the possible filter modes.
+
+		This ABI is only kept for backwards compatibility and the values
+		returned are identical to filter_type_available attribute
+		documented in Documentation/ABI/testing/sysfs-bus-iio. Please,
+		use filter_type_available like ABI to provide filter options for
+		new drivers.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
+KernelVersion:  6.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This ABI is only kept for backwards compatibility and the values
+		returned are identical to in_voltageY-voltageZ_filter_type
+		attribute documented in Documentation/ABI/testing/sysfs-bus-iio.
+		Please, use in_voltageY-voltageZ_filter_type for new drivers.
diff --git a/MAINTAINERS b/MAINTAINERS
index 98a3c1e46311..28dbbf6d6efa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1279,6 +1279,7 @@ M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 F:	drivers/iio/adc/ad4130.c
 
-- 
2.47.2


