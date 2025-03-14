Return-Path: <linux-iio+bounces-16846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEA5A61761
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 18:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7DA07AAD96
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B582046BA;
	Fri, 14 Mar 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dcCJwOwv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66FD1F957;
	Fri, 14 Mar 2025 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972810; cv=none; b=qOwZi0X9TdWNEhEtw4dFv58S6TnjZS139u9TebIVhiomdnROgORS+aXewZScyESV3myFNzD0MrHK+fMkOHm9Ze2WgqYCsSPb7qGeoBeQw+jwfF0SDi1zc5lsbRujT/xIAXlm1f0UymnyjVbiKOvG3VErd7QAfrUA0EbAOJKpyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972810; c=relaxed/simple;
	bh=hBCkIy161593SDro4nXEJtezsRYeIUGUIUSdstTYZdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFsezXYEwInSD92gRGcjWTggyQm514LTN/kz8MZFWkrz2sXIjpeyuOn/mvL2rVpS1iD1ZVi4akEpzjooyLFq62yezof9k9w9drZroij1qb51e1ocoXT2gFnhnx9rnE7S/YhbnrvbfgLhpEpdj8+ONNiSfSBO1H6j7cYrKGHtfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dcCJwOwv; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EFvxnB016602;
	Fri, 14 Mar 2025 13:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/44YR
	xSL9Q8uuoRaHgYdki5Nl3NKnqHtGIMCXJ2oTrg=; b=dcCJwOwvGobsS1uRjnjp+
	BBm7USoHz1wVvBVyHK/acLrGOoWGvWvb8LZrvaQK9T/wvDxVmOWN3gscOzMy3/1E
	oJXoK+FCC9O3LQzADjvTRU2xGsa4/vyN7kxvS1igXzB9WRPxLkXJbh+jWzDf3KMF
	hz++Ht6FOQUPlCM8lrTD6rbg2mpZSYduvNPWKHRsCH+kUS2xLd6khYNerktpZqjx
	WDXDkkPj7T3ju257Rb/SQHcg3z08ticmygBLrR396lFCDGUhmRsA8lPWfdAkIsj7
	Gg/WCGkQJQJFI47Qmhqx3wNbwqFcBcrrAUy1v6SQkaEGU6oblHUFHq6g2n0ezEoP
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45cqjg8ac2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 13:19:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52EHJqhf037032
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Mar 2025 13:19:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 14 Mar
 2025 13:19:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 14 Mar 2025 13:19:52 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52EHJaCu005028;
	Fri, 14 Mar 2025 13:19:39 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 4/4] Documentation: iio: ad4000: Describe offload support
Date: Fri, 14 Mar 2025 14:19:33 -0300
Message-ID: <18df335c2dd4c4db3bf27d68cbf1852425114131.1741970538.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1741970538.git.marcelo.schmitt@analog.com>
References: <cover.1741970538.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jf96dmMTYiPjuqNVVkkWlC_oR6dCucQW
X-Proofpoint-ORIG-GUID: jf96dmMTYiPjuqNVVkkWlC_oR6dCucQW
X-Authority-Analysis: v=2.4 cv=EL0G00ZC c=1 sm=1 tr=0 ts=67d4653a cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=wI1k2SEZAAAA:8 a=gAnH3GRIAAAA:8 a=zhJGIpXlanaEhhhmQREA:9 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_06,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140136

When SPI offloading is supported, the IIO device provides different sysfs
interfaces to allow using the adjusting the sample rate. Document SPI
offload support for AD4000 and similar devices.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4000.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/iio/ad4000.rst b/Documentation/iio/ad4000.rst
index 468d30dc9214..2d56b0762570 100644
--- a/Documentation/iio/ad4000.rst
+++ b/Documentation/iio/ad4000.rst
@@ -191,3 +191,20 @@ Typical voltage channel attributes of a differential AD4000 series device:
 +-------------------------------------------+------------------------------------------+
 | ``in_voltage0-voltage1_scale_available``  | Toggles input span compression           |
 +-------------------------------------------+------------------------------------------+
+
+SPI offload support
+-------------------
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html
+
+When set for SPI offload support, the IIO device will provide different
+interfaces.
+
+* Either ``in_voltage0_sampling_frequency`` or
+  ``in_voltage0-voltage1_sampling_frequency`` file is provided to allow setting
+  the sample rate.
+* IIO trigger device is not provided (no ``trigger`` directory).
+* ``timestamp`` channel is not provided.
-- 
2.47.2


