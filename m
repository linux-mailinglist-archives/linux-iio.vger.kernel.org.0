Return-Path: <linux-iio+bounces-17301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B675A74041
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 22:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB5E3B43B4
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 21:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DE31DC197;
	Thu, 27 Mar 2025 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sFPogJoJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467011D89EF;
	Thu, 27 Mar 2025 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110766; cv=none; b=Rq56U57UxEQ4TMw9BipqQOLqwzEPomE2LmoG8XnQ+h06tjVzacuvkQm8pjUKWqZWesPrPWxR5EtNC3eGb9Sui3SdWyVRL6APT9k34dDhqenSM3WaW6XwDXS9W715cCEbToffWgzgEngKwKt8PlbxFIz2PxGufbmczbulbvM9GXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110766; c=relaxed/simple;
	bh=se43mwTLEQGCP9uC/PloigyaUa4E+BcAfUXL104tZS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Viek7KSIo49E3H0IhPjTg9THPxhEIJiJjfBlEjsocmFTWWkajHub8Vs1s500lFYEIiICO/7yzqFIFL1SN5M0hsaHi2abluLtv5aXGZQe5XIjqBUqSFMsQQJnHa+lP5JeS5Lc0NO+upNIzkznkGzsITWBHoNRKcm/4sRLQAsex00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sFPogJoJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RK9Wcx010423;
	Thu, 27 Mar 2025 17:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zuzeo
	yrfZwYLJPjmXBoMFoEoF0VMnuKQ9V3UV5Wtkhc=; b=sFPogJoJVkCvyi8hio1Ft
	ojWEozkqkGGJ1dIzr8Ie6zUzZYRLZo4KhP2ZQfwVC4DXX+Zyklug7Jgf3RMrW0NA
	/V2IkfTT/kn7cjUcdEklboChvlqwqn/Jp3DM9CfvBHsdzxeoc3bQGfJv2wiva1OM
	ON268NnJr/oVH1h2KyXLl8jSNs5PxOrKJMV/mTEllBWW2pBqH+axAZqH/luJUeWD
	NQLb6JtUJ5MEzZKo21rzBxQhOiH3gJ1pw56XCuYc7BT3ezjYxQczMDrYoUnWdRs/
	xUZJhCwssiUoq5vXqZJngNyudzezds0oxdHPUd010Ru8y/o6bjsi9ypDKeLAvMlP
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45mwxcdkp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 17:25:48 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52RLPlkf047499
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Mar 2025 17:25:47 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 27 Mar 2025 17:25:46 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 27 Mar 2025 17:25:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 27 Mar 2025 17:25:46 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52RLPVp6022576;
	Thu, 27 Mar 2025 17:25:34 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 4/4] Documentation: iio: ad4000: Describe offload support
Date: Thu, 27 Mar 2025 18:25:29 -0300
Message-ID: <eb94013b1a4d66a8492cf094aef3e4410f81d22b.1743110188.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1743110188.git.marcelo.schmitt@analog.com>
References: <cover.1743110188.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AdmxH2XG c=1 sm=1 tr=0 ts=67e5c25c cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=wI1k2SEZAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=k5wdjJE9De7JZY4JY-8A:9 a=6HWbV-4b7c7AdzY24d_u:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: Ho3VjS0B-R19RczkJ6-dNP3TTD7dEw9p
X-Proofpoint-ORIG-GUID: Ho3VjS0B-R19RczkJ6-dNP3TTD7dEw9p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270144

When SPI offloading is supported, the IIO device provides different sysfs
interfaces to allow using the adjusting the sample rate. Document SPI
offload support for AD4000 and similar devices.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4000.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/iio/ad4000.rst b/Documentation/iio/ad4000.rst
index 468d30dc9214..c1d04d3436d2 100644
--- a/Documentation/iio/ad4000.rst
+++ b/Documentation/iio/ad4000.rst
@@ -191,3 +191,30 @@ Typical voltage channel attributes of a differential AD4000 series device:
 +-------------------------------------------+------------------------------------------+
 | ``in_voltage0-voltage1_scale_available``  | Toggles input span compression           |
 +-------------------------------------------+------------------------------------------+
+
+SPI offload support
+-------------------
+
+To be able to achieve the maximum sample rate, the driver can be used with SPI
+offload engines such as the one usually present in `AXI SPI Engine`_, to provide
+SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html
+
+To keep up with SPI offloading transfer speeds, the ADC must be connected either
+in 3-wire turbo mode or in 3-wire without busy indicator mode and have SPI
+controller CS line connected to the CNV pin.
+
+When set for SPI offload support, the IIO device will provide different
+interfaces.
+
+* Either ``in_voltage0_sampling_frequency`` or
+  ``in_voltage0-voltage1_sampling_frequency`` file is provided to allow setting
+  the sample rate.
+* IIO trigger device is not provided (no ``trigger`` directory).
+* ``timestamp`` channel is not provided.
+
+Also, because the ADC output has a one sample latency (delay) when the device is
+wired in "3-wire" mode and only one transfer per sample is done when using SPI
+offloading, the first data sample in the buffer is not valid because it contains
+the output of an earlier conversion result.
-- 
2.47.2


