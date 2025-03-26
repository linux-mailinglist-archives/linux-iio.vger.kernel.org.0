Return-Path: <linux-iio+bounces-17271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF80A71787
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 14:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F0817601B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D801E8349;
	Wed, 26 Mar 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DkizeIwa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0981E1E0E;
	Wed, 26 Mar 2025 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995591; cv=none; b=Dl7fVQA3LKfNU/jsjT49p8l0Zj/BAnXJLXsMrgtolBQX1UFQxCcuM3hyfnGtLw3yIeMeGLXkE378zDzlIWtFgImHQy5NAFKxfbYvYURiUH0LiRJoV09AIlyhtMk84rX7EcPQDXh+2te70tfepM4KW0U+7AeLmOMsSEEMu6PtTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995591; c=relaxed/simple;
	bh=e4WPJLy4WLWqR1uxlbOhTXxyF9pIISMdopBY4cREdnU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fet1enHNRYvhtt/fNcKX9iSoedSn7qxZaJ1S8R37c2YWcjTfqfZmRYMsvnU15ICtuk/KRjA4F2T7z2n+9RCP1nqu5GlXrhNbvNPMdPHFPVHtRI4ldOUzNDRR9cwAOqHHslTw/PwrzBRfXeDsAmHSrO6Lf8Fm657/4/6W2BNS0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DkizeIwa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QD6M06023412;
	Wed, 26 Mar 2025 09:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QIqEc
	y1I/zozxpW/KJvAzrS1AD5Zlf7UtNIh5CGaGBw=; b=DkizeIwaQCmKpV6esP9y7
	zFmMYgzC37ryz8D9dW8AtX4HsnLfSL2aDFgu/YByLmzeNhZ80F9tIWRsEXBf7Fz+
	jLPV2iuKo4Q/YBsMYqQsBlTCuLwmWDa1NLZzdajJhlK80ivWKXA/vJBj9kx6nAjG
	yiQooB/BIcJrp1+hn4eSaCCTCwD/h4wIT9HlVEPRIpwfs/OelpG9CPQNCItpwI/Q
	ePdvzdnlFvLZ0nrCRSQSxa/oCVUyS/e4J79dr7w4PbZyfqwKOlIJGWRIV2O8fnHI
	2vHO/BLBuBpjPpJoIMHcsIhT8HmhAfnS3OSJuMnc1VwdA898HuEe/4ndC7PuEO8D
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45krwh768x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 09:26:12 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52QDQBUF043251
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Mar 2025 09:26:11 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 26 Mar 2025 09:26:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 26 Mar 2025 09:26:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 26 Mar 2025 09:26:11 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52QDPwqO007595;
	Wed, 26 Mar 2025 09:26:01 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 4/4] Documentation: iio: ad4000: Describe offload support
Date: Wed, 26 Mar 2025 10:25:57 -0300
Message-ID: <92b7db8eddce5b11476352405ed7695107ba7745.1742992305.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1742992305.git.marcelo.schmitt@analog.com>
References: <cover.1742992305.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: MoW91kgA5apYGZGc_Wz7L-ZCjARooGXc
X-Proofpoint-ORIG-GUID: MoW91kgA5apYGZGc_Wz7L-ZCjARooGXc
X-Authority-Analysis: v=2.4 cv=IuAecK/g c=1 sm=1 tr=0 ts=67e40074 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=wI1k2SEZAAAA:8 a=gAnH3GRIAAAA:8 a=zhJGIpXlanaEhhhmQREA:9 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260082

When SPI offloading is supported, the IIO device provides different sysfs
interfaces to allow using the adjusting the sample rate. Document SPI
offload support for AD4000 and similar devices.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4000.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/iio/ad4000.rst b/Documentation/iio/ad4000.rst
index 468d30dc9214..e490f9604b94 100644
--- a/Documentation/iio/ad4000.rst
+++ b/Documentation/iio/ad4000.rst
@@ -191,3 +191,25 @@ Typical voltage channel attributes of a differential AD4000 series device:
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
+
+Also, because the ADC output has a one sample latency (delay) when the device is
+wired in "3-wire" mode and only one transfer per sample is done when using SPI
+offloading, the first data sample in the buffer is not valid because it contains
+the output of an earlier conversion result.
-- 
2.47.2


