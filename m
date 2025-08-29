Return-Path: <linux-iio+bounces-23371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CF4B3BA49
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 13:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966581C872E3
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 11:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A57C3164B2;
	Fri, 29 Aug 2025 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qdUHoasQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C30B314B7E;
	Fri, 29 Aug 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468388; cv=none; b=cdG+QltrhEZneQ9+jpnW78kw27jQ15ypH2Xp/lHJ35vBCAOHl3NG6ebhb/56LOiy9PDaBWi7W9LHKB4Dd91vcrqlVmZcjBjiYxwB56ZkPB60yFSV4kqRh5bNBWyrkXPU7jJPx6CWoR/gHK5GP++HyxSqpUjV7saAeUuy+YcscQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468388; c=relaxed/simple;
	bh=Gfn5o0Eh8hgb5BxtA54+vflqWgCuCtZQA4cAD5btAH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIJ464flaMFdZSBQiLKLGU6EGAiqNskjsIFx5k8GXpFLYMfpfdQsazGQL8BFfTbGu0PdK8rcx5EQlY7GbmaXMZ0MupHXVnUpKeZb2lZEZuuXl1WZgyjS/ByCoLmDHloLwsqND4P9xDoQjEKJzTc5s3zHmc559aCufAkUBn1J48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qdUHoasQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T8xnwF016468;
	Fri, 29 Aug 2025 07:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wFx/q
	BJHMe6z5e44ECPNhnqsC7176u7T2gjIMaMeSwE=; b=qdUHoasQy3Fqsx0knWmdE
	FlQi75qEYRK4AI8TtWUTNmjPZFiW6hN/q3Tzya9BESa4sYCqT4nIa+gB9fWZtZzf
	oXa60Ym4qyTbqIDEVVXlowM1YuLCCcT9kU2ksPL8Ir84Oare7rxLk1pzXwbOsz0w
	fIYNGCjXtT+k3YUjmCafUh+Z8h4k7uWGDd9L7Z5qaOTTbajrqdAsUGf623KIAbIi
	0OViD9yIyYt+em6Gl2lXptX/K3GUAmGVf+axTJPJmRUkVQpT/Avk5C1ytYQcx3Kl
	TQAJYaZXTkEKuxX6NlC1gfKZl4Hs2mE3hkGaxhvfTbhzxexBsZimHAamLxTVhwXR
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48u966rq28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 07:52:52 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57TBqpZi036257
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 07:52:51 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 07:52:50 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 07:52:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 07:52:50 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.226])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57TBqdAT017911;
	Fri, 29 Aug 2025 07:52:45 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 2/6] iio: add power and energy measurement modifiers
Date: Fri, 29 Aug 2025 11:41:36 +0000
Message-ID: <20250829115227.47712-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829115227.47712-1-antoniu.miclaus@analog.com>
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: I2A0WaEKuQZCbxzMQris0J9qMh-meUaH
X-Proofpoint-ORIG-GUID: I2A0WaEKuQZCbxzMQris0J9qMh-meUaH
X-Authority-Analysis: v=2.4 cv=J6Wq7BnS c=1 sm=1 tr=0 ts=68b19494 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=klP2xDLrsrBtVFqUoHYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDA3NCBTYWx0ZWRfX1csTdW0GIPkF
 HlcHMUNiqwKok1qJc9dzuLghfWRuw8rYqxUQacUQdD1/p+HP0TbuHEWXCqvHrIV5GprWMg3jRd+
 XT4m8u+ntBd/0BFIbMifnP5R+VoBolh4XN0oM4FHvLddAvakxoWGf6/Y/qdtTBSNhPErGCg0RTj
 4URNEUYLMUbamkYS/h/QfgTnj27BOyaZBOyW6LDe2O77Iy3nn7EJJKZXawaDSoHtSMb68Z+3m2I
 PR7TTgsSupcztMaAq1xdThrZ3g9MWqQwgthyuZEADP4Y135AJZv41tnARxKbIcX1WhNyG2ALbBs
 qFaQJOBViwJa1MPFseMnjbBEPt+AG2Lk50NEhPX2/J7MNk+mzcA0hICo+a1k1bYwHZgrYauYRPF
 H+w2b8So
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508290074

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
no changes in v6.
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


