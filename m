Return-Path: <linux-iio+bounces-17101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BABA6925F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 16:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D557A49D6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9380F1DFDB4;
	Wed, 19 Mar 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ormnKwFG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEAD1DDA39;
	Wed, 19 Mar 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396313; cv=none; b=H/nITxtIAFJVfqsFDsN2GvksujznsS09JmWdaGKhVz0PoLxzDqBqEADAEAKbHy6H1zyW7wL6fG89aJAirVh4ruDiLq0W6oVbU5FchZ+8ZEKGUif5Td73uiEeKETiVJ/AD1JAdkJo1B7RLqwyur4wa9jR1dvORXsjuHIz8ZP1T9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396313; c=relaxed/simple;
	bh=pLQgLbhzSWeLm1NsYOf8P/JZobH+b4N+xZ2+J0+pBzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWV7d5WeZ6QFnxbec4V1MVcXkvP9z0gtGIF3HgCS4ZXICzdmPSsAjKXU8Tw/lbcYqg4e8TijmszLmTZtoOlbGzfToKGaCeQJCAJnWpI6fLRF3bN1RTLfHoMCarjreTyT+ewI92weCiKhQexLLvGa6mnAAyph/q+guBwwaJGNOtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ormnKwFG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JCMjAJ030124;
	Wed, 19 Mar 2025 10:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rRFmb
	rbuid/omCXO+ai53evzFI6dNJbBmqCMoDl6dOU=; b=ormnKwFG6Ck7k91nOob5C
	jY4fH/F/R4s+ldPLzQtnZOKHW3jh4kALzmTEzFvBs/IXm78S7VmWORVEaHyR25ji
	YRozMLGrbcHC4iW9VxcHNwX0PKWUppJeebsqx8D5AGbDEVwtKZS8Lx2lMc6vZBvy
	1akTzZYFB29By1wWjkDkbHMldlmv2N0FFATtZB8K0cBTmO5oPtl2HynpNWeQzSU+
	gAWnl/y2rs1aIgnnH+Yy1/jmcbBH1H35W2L6mWpH7Y6tMnkH7jc7WuQwZQvMzTeG
	+ZoFmZK/XN0P7Ml1CUG1bmEcYfz0aPX1XxTQYmcEwNsrBl3tMgkIxGWugayxthCb
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45fwvmgt03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:58:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52JEwEu9048089
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Mar 2025 10:58:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 19 Mar
 2025 10:58:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Mar 2025 10:58:13 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52JEvxnt025145;
	Wed, 19 Mar 2025 10:58:02 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 4/5] Documentation: iio: ad4000: Add IIO Device characteristics section
Date: Wed, 19 Mar 2025 11:57:57 -0300
Message-ID: <f8660f905b3c0d6aa2325c13bb2b29f954afb628.1742394806.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1742394806.git.marcelo.schmitt@analog.com>
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: R9SdFk6TjaYoG8OsV4JNZsNwMqxjCedQ
X-Authority-Analysis: v=2.4 cv=J5+q7BnS c=1 sm=1 tr=0 ts=67dadb87 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=Mo4bjoQrprX0_McyEsMA:9
X-Proofpoint-ORIG-GUID: R9SdFk6TjaYoG8OsV4JNZsNwMqxjCedQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190101

Complement ad4000 IIO driver documentation with considerations about
``_scale_available`` attribute and table of typical channel attributes.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4000.rst | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/iio/ad4000.rst b/Documentation/iio/ad4000.rst
index 5578a9cfd9d5..468d30dc9214 100644
--- a/Documentation/iio/ad4000.rst
+++ b/Documentation/iio/ad4000.rst
@@ -144,3 +144,50 @@ Set ``adi,sdi-pin`` to ``"cs"`` to select this mode.
                     ^                    |             |
                     +--------------------| SCLK        |
                                          +-------------+
+
+IIO Device characteristics
+==========================
+
+The AD4000 series driver supports differential and pseudo-differential ADCs.
+
+The span compression feature available in AD4000 series devices can be
+enabled/disabled by changing the ``_scale_available`` attribute of the voltage
+channel. Note that span compression configuration requires writing to AD4000
+configuration register, which is only possible when the ADC is wired in 3-wire
+turbo mode, and the SPI controller is ``SPI_MOSI_IDLE_HIGH`` capable. If those
+conditions are not met, no ``_scale_available`` attribute is provided.
+
+Besides that, differential and pseudo-differential voltage channels present
+slightly different sysfs interfaces.
+
+Pseudo-differential ADCs
+------------------------
+
+Typical voltage channel attributes of a pseudo-differential AD4000 series device:
+
++-------------------------------------------+------------------------------------------+
+| Voltage Channel Attributes                | Description                              |
++===========================================+==========================================+
+| ``in_voltage0_raw``                       | Raw ADC output code.                     |
++-------------------------------------------+------------------------------------------+
+| ``in_voltage0_offset``                    | Offset to convert raw value to mV.       |
++-------------------------------------------+------------------------------------------+
+| ``in_voltage0_scale``                     | Scale factor to convert raw value to mV. |
++-------------------------------------------+------------------------------------------+
+| ``in_voltage0_scale_available``           | Toggles input span compression           |
++-------------------------------------------+------------------------------------------+
+
+Differential ADCs
+-----------------
+
+Typical voltage channel attributes of a differential AD4000 series device:
+
++-------------------------------------------+------------------------------------------+
+| Voltage Channel Attributes                | Description                              |
++===========================================+==========================================+
+| ``in_voltage0-voltage1_raw``              | Raw ADC output code.                     |
++-------------------------------------------+------------------------------------------+
+| ``in_voltage0-voltage1_scale``            | Scale factor to convert raw value to mV. |
++-------------------------------------------+------------------------------------------+
+| ``in_voltage0-voltage1_scale_available``  | Toggles input span compression           |
++-------------------------------------------+------------------------------------------+
-- 
2.47.2


