Return-Path: <linux-iio+bounces-21811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE116B0C2CC
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D933E17B558
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF71A29A311;
	Mon, 21 Jul 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZhN9BLpB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C02989B1;
	Mon, 21 Jul 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097119; cv=none; b=lnYFqok5F10moEbm4EuD2KQt/Unrl9n6XW52iXQz7mui1kY7IwPHLgsUTOGPzhBcDkaUOX9pUcdZ4wCxQ3C5Es0KMHgkzhEyQdetX6PAXf/FhLIKa8HURp0Ei3UB36Jr77/zJel0ajN8VLxkEn3psL+otf4a00lGiQWBN3tU4OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097119; c=relaxed/simple;
	bh=TWig90DiAvEyVBEyozMfE8rmKcPPtIEjKoK6WUgGYLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E7vcH+aZ2WV2dhwFjDWUCa1TxawJ60cpX9D5jhbddO40qR74G0n+4MNpQaXcANy/ON5Tyo5tVo1o9R7J6zFUNuKSaW/gdcAvOHpSBeF5c1cpZTjRxiD+2qGN6DLcG08ppc1Dl8lBGeXtKZgVMeSSfSWiFO6dPFLiGKd3C4FBbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZhN9BLpB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L95M5P015212;
	Mon, 21 Jul 2025 07:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=HeX6pUvKYXIOfvjzUO/EpP5xMDe
	CVQue/V6MKHoPA8E=; b=ZhN9BLpBjljTx1Z3Y8sbse88xpixzLF58gtLaSsV8jc
	ny+0EI00TGiLtbuF4F6IaJg0ldDoTi7FoQ1VyQ9LYWVX8JGIXbdot+yL/Y3psqNG
	Uk4tIYQ/mEXsCxRB0vIDpJ+131/lKizu/nEuBw3bITpIaoeenrG/1+gRSFmLvCvn
	XRcaMiKHph1htz18LslTg2yQ901bO4PVX6sX3upWgH2CHYsHxkK0kYZOyvsXh216
	1l7ptyQYd5lcKWXCgie7VegNXXY7htiQIANQWMy0x5PEBJGg5WKg/dGwuz6YBCKf
	2lsQUE3Ln00cRaWX7vzj/dSazGb1NA54zLfQTtksOTw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 480spgns82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 07:25:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 56LBP7UP033294
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Jul 2025 07:25:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 21 Jul
 2025 07:25:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 21 Jul 2025 07:25:07 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.210])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56LBOxBi007027;
	Mon, 21 Jul 2025 07:25:01 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 1/5] iio: add power and energy measurement modifiers
Date: Mon, 21 Jul 2025 14:24:41 +0300
Message-ID: <20250721112455.23948-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 6Zu-51zqvRVbpjoAnkegdI-G5ZWGEp8d
X-Authority-Analysis: v=2.4 cv=eLoTjGp1 c=1 sm=1 tr=0 ts=687e2394 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=PmzoHiALbJE4VtwYMdEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEwMSBTYWx0ZWRfXxiHg/ausT+aj
 rnV8KdW76Pk0aW9cS/jUirFDXWW9I4j70WogQF4UFaO1ESNF7eevNgiqtNkfXySI1jiV4WuQ4Wh
 T+tn/z92Rrel9oSBhzv4hx2d7rrl0xBA3YZF0iTg99/FNwy5HxozG0lVdzZpceBMFNZD3kO/fd8
 OihW50YL2BR0j3SAO3zAUAlqghe+tiQr8ytS5KswAD3QV/tPwSFryaM1MBBlXTLqCOndvIW8qy/
 OoTLpySu/qVFTS8lpKDGwVgdiatBGI2WIEjm8WSVN746AndLNuR/20TRUif8P/HLRsUVuKs0bY8
 UP3x+hygJKrvsKgCjSma2V3iCqqPY7LxEYNJ2UUZef7PBcFHp6KtBLCW0AsjfJu8Z50Bk3Aj5lA
 lA+HVVyrKzlsnMzSrWDAKEDlPQNfU9OAIbyaXE5AjzwUgi+LfYrOUV3fVbuef6s4EpMDUzaF
X-Proofpoint-GUID: 6Zu-51zqvRVbpjoAnkegdI-G5ZWGEp8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210101

Add new IIO modifiers to support power and energy measurement devices:

Power modifiers:
- IIO_MOD_ACTIVE: Real power consumed by the load
- IIO_MOD_REACTIVE: Power that oscillates between source and load
- IIO_MOD_APPARENT: Magnitude of complex power
- IIO_MOD_FUND_REACTIVE: Reactive power at fundamental frequency
- IIO_MOD_FACTOR: Power factor (ratio of active to apparent power)

Signal quality modifiers:
- IIO_MOD_RMS: Root Mean Square value

These modifiers enable proper representation of power measurement
devices like energy meters and power analyzers.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - drop _accum modifiers
 - drop dip/swell modifiers
 - change power factor to be a chan_info
 - voltage -> altvoltage for rms
 Documentation/ABI/testing/sysfs-bus-iio | 14 ++++++++++++++
 drivers/iio/industrialio-core.c         |  5 +++++
 include/linux/iio/types.h               |  1 +
 include/uapi/linux/iio/types.h          |  4 ++++
 4 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3bc386995fb6..0948611227a8 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -169,7 +169,12 @@ Description:
 		is required is a consistent labeling.  Units after application
 		of scale and offset are millivolts.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_active_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_reactive_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_apparent_raw
 KernelVersion:	4.5
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -178,6 +183,8 @@ Description:
 		unique to allow association with event codes. Units after
 		application of scale and offset are milliwatts.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_power_factor
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
 KernelVersion:	3.2
 Contact:	linux-iio@vger.kernel.org
@@ -1593,6 +1600,12 @@ Description:
 
 What:		/sys/.../iio:deviceX/in_energy_input
 What:		/sys/.../iio:deviceX/in_energy_raw
+What:		/sys/.../iio:deviceX/in_energyY_active_raw
+What:		/sys/.../iio:deviceX/in_energyY_reactive_raw
+What:		/sys/.../iio:deviceX/in_energyY_apparent_raw
+What:		/sys/.../iio:deviceX/in_energyY_active_accum_raw
+What:		/sys/.../iio:deviceX/in_energyY_reactive_accum_raw
+What:		/sys/.../iio:deviceX/in_energyY_apparent_accum_raw
 KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1718,6 +1731,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_rms_raw
 KernelVersion:	3.17
 Contact:	linux-iio@vger.kernel.org
 Description:
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f13c3aa470d7..7889f8b62336 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -152,6 +152,10 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PITCH] = "pitch",
 	[IIO_MOD_YAW] = "yaw",
 	[IIO_MOD_ROLL] = "roll",
+	[IIO_MOD_RMS] = "rms",
+	[IIO_MOD_ACTIVE] = "active",
+	[IIO_MOD_REACTIVE] = "reactive",
+	[IIO_MOD_APPARENT] = "apparent",
 };
 
 /* relies on pairs of these shared then separate */
@@ -189,6 +193,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
 	[IIO_CHAN_INFO_TROUGH] = "trough_raw",
 	[IIO_CHAN_INFO_CONVDELAY] = "convdelay",
+	[IIO_CHAN_INFO_POWER_FACTOR] = "power_factor",
 };
 /**
  * iio_device_id() - query the unique ID for the device
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index ad2761efcc83..f26a0fbd6ab4 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -70,6 +70,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_ZEROPOINT,
 	IIO_CHAN_INFO_TROUGH,
 	IIO_CHAN_INFO_CONVDELAY,
+	IIO_CHAN_INFO_POWER_FACTOR,
 };
 
 #endif /* _IIO_TYPES_H_ */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 3eb0821af7a4..0afda9ec2379 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -108,6 +108,10 @@ enum iio_modifier {
 	IIO_MOD_ROLL,
 	IIO_MOD_LIGHT_UVA,
 	IIO_MOD_LIGHT_UVB,
+	IIO_MOD_RMS,
+	IIO_MOD_ACTIVE,
+	IIO_MOD_REACTIVE,
+	IIO_MOD_APPARENT,
 };
 
 enum iio_event_type {
-- 
2.49.0


