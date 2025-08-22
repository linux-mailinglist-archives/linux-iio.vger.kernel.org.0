Return-Path: <linux-iio+bounces-23154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C61FBB32023
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 18:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64ADB189EAAF
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CB027F195;
	Fri, 22 Aug 2025 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RHDZfLyU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9439A25B1D3;
	Fri, 22 Aug 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878556; cv=none; b=mgGAJzWSi4ZzWAF8IT2jkVuh0YAyhc9kMXFxiSKm62sGMlRveAr7xvGgBR5ovgvk2lyzqG1NH/2unAdr5Oz3oCBUlhs4oAih/cFsbWBNeIEqD558O+buw7Db36IbW/4qiA/lwfZBAAnwwzLKv5SwlBulpU1c1wnSS/8NCo4ynQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878556; c=relaxed/simple;
	bh=KtKdQIvWklMRfoS3tsolr8p4OxelHxPQxzcpIuqlAvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCeLGow225IUe5DFSge6+Mr8ZTsnljj1FazvatJnoGl8QI/IIjKJd8EMtLuwrpWw/NH7BmRqaDUmGk+RWZKgCoInA1RhzqWoMadw3ikiHBXjksEYOVEp18fQzhsGYlOwQ8RzUiDaJWiIwHIEEpgBOsusa1YIImjwAIdTD9T1fAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RHDZfLyU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MBxoBI019234;
	Fri, 22 Aug 2025 12:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=D+dlv
	7v4cuuMV5v2jiDBXW07M7uQ5VJnOSjvqJ25xrs=; b=RHDZfLyUo3LGRH9PiDXSf
	k4sGjzHChuoD7zGUIJkDjSIp4fcviW3Gxg0j7Lm2+aW27wIRVeaQ31EZ4YCxCP+J
	MTXXfvG4cG1MB6imRTGuvAh29ZIbIlj0leyxcVWiOPng3GPjvfEWJi44Wy/NO1Rt
	WSxRC42cMCX58UHObERlTtITgI9CJZPwXfykIR95V5YOIgBaPE6onwu3h7lvSJ0C
	VgAy+r4j1Iz4hqLXB4dtkT9yv0mR7i69919vrqyHg+vw1eg5KDtssIKZsnM9weFe
	RulvKKJnI9crzUlPnTPyUwxefQjmDC8+eIYNy8NQI+aSql4z7lOslhaKnObj7s69
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48nunshdxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:02:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57MG2I16033802
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Aug 2025 12:02:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 22 Aug
 2025 12:02:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 22 Aug 2025 12:02:18 -0400
Received: from Ubuntu.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57MG263N000568;
	Fri, 22 Aug 2025 12:02:13 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 2/6] iio: add power and energy measurement modifiers
Date: Fri, 22 Aug 2025 16:01:51 +0000
Message-ID: <20250822160157.5092-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822160157.5092-1-antoniu.miclaus@analog.com>
References: <20250822160157.5092-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=e+Zfiap/ c=1 sm=1 tr=0 ts=68a8948c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=klP2xDLrsrBtVFqUoHYA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 4uWTYHVM33lxzhuzLuAg9h6TrEhmkVYK
X-Proofpoint-GUID: 4uWTYHVM33lxzhuzLuAg9h6TrEhmkVYK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDAyNiBTYWx0ZWRfX/G8uTAzIEArI
 oS2mFOKEjNfSxi7YE/x9E8f+M1wWV1GjDexKXVaFOfYCVuZRpVp8IiR5QHaGl7vf3XfpDR0Qzl5
 5dKdVGZ1UidfLEo92woVHgjA5rYhtSvA6utIAlrqybLt6cuOAg9MJN3rmZp5qeJgSv9RcdZ/d/k
 1HZhSHyrIEQVZgkiy9mDB3vxqejbrEKOuDp1yLi3x8lrvRZpZ2ZURFaWF2dHTCnwlIQO3GGS50a
 wJOYhzabpUZq23gy7VCvbl+mdX2IjgWeZ0pI/KMQo19hmBWjOmmWPwKFM1OrQYLr0icZyUINp9f
 UX8PDqiwkEphZIl0k+nBBiAwyHOD8LU3MwCZCA17tAlRImSvIqBVgrmNghkT6IauWDdq10vDdcd
 J94XKGcO2ODgILW4uStUwIUFXYL7Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508210026

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
no changes in v5.
 Documentation/ABI/testing/sysfs-bus-iio | 29 +++++++++++++++++++++++++
 drivers/iio/industrialio-core.c         |  5 +++++
 include/linux/iio/types.h               |  1 +
 include/uapi/linux/iio/types.h          |  4 ++++
 4 files changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2fb2cea4b192..78da68826307 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -167,7 +167,18 @@ Description:
 		is required is a consistent labeling.  Units after application
 		of scale and offset are millivolts.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) Root Mean Square (RMS) voltage measurement from
+		channel Y. Units after application of scale and offset are
+		millivolts.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_active_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_reactive_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_apparent_raw
 KernelVersion:	4.5
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -176,6 +187,13 @@ Description:
 		unique to allow association with event codes. Units after
 		application of scale and offset are milliwatts.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_powerfactor
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Power factor measurement from channel Y. Power factor is the
+		ratio of active power to apparent power. The value is unitless.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
 KernelVersion:	3.2
 Contact:	linux-iio@vger.kernel.org
@@ -1569,6 +1587,9 @@ Description:
 
 What:		/sys/.../iio:deviceX/in_energy_input
 What:		/sys/.../iio:deviceX/in_energy_raw
+What:		/sys/.../iio:deviceX/in_energyY_active_raw
+What:		/sys/.../iio:deviceX/in_energyY_reactive_raw
+What:		/sys/.../iio:deviceX/in_energyY_apparent_raw
 KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1707,6 +1728,14 @@ Description:
 		component of the signal while the 'q' channel contains the quadrature
 		component.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_rms_raw
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no bias removal etc.) Root Mean Square (RMS) current
+		measurement from channel Y. Units after application of scale and
+		offset are milliamps.
+
 What:		/sys/.../iio:deviceX/in_energy_en
 What:		/sys/.../iio:deviceX/in_distance_en
 What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_en
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 8c9098668772..9e372ed38552 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -153,6 +153,10 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PITCH] = "pitch",
 	[IIO_MOD_YAW] = "yaw",
 	[IIO_MOD_ROLL] = "roll",
+	[IIO_MOD_RMS] = "rms",
+	[IIO_MOD_ACTIVE] = "active",
+	[IIO_MOD_REACTIVE] = "reactive",
+	[IIO_MOD_APPARENT] = "apparent",
 };
 
 /* relies on pairs of these shared then separate */
@@ -190,6 +194,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
 	[IIO_CHAN_INFO_TROUGH] = "trough_raw",
 	[IIO_CHAN_INFO_CONVDELAY] = "convdelay",
+	[IIO_CHAN_INFO_POWERFACTOR] = "powerfactor",
 };
 /**
  * iio_device_id() - query the unique ID for the device
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index ad2761efcc83..34eebad12d2c 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -70,6 +70,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_ZEROPOINT,
 	IIO_CHAN_INFO_TROUGH,
 	IIO_CHAN_INFO_CONVDELAY,
+	IIO_CHAN_INFO_POWERFACTOR,
 };
 
 #endif /* _IIO_TYPES_H_ */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 3c3cc1497a1e..6d269b844271 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -109,6 +109,10 @@ enum iio_modifier {
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
2.43.0


