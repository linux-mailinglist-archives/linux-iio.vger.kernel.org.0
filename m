Return-Path: <linux-iio+bounces-22458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B2B1EA09
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C289416EB43
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55E727F006;
	Fri,  8 Aug 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yVRXa4mE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC320322;
	Fri,  8 Aug 2025 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662282; cv=none; b=PcQQWX22qUAjQQfTTFEVuUsRxoCdukXdGLx9pIJxY5bifH40x8lG1fh+XsG5dSmzrwilFY3kiWmlj5FRVbpa6noKPHp08tVdnx8//DnLJsgbmhvHZJp7U1XUw/CZXvvRRbpLbKPzY+3UK7Eejj9AnKOLgt1XvIKAjN9KI0MlhN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662282; c=relaxed/simple;
	bh=JNr5UMi6M2TmSodvNZ28S9ped2wLTVNu+9q6/rB3AyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZCJfD3MhWBclbRIwPvDohx0u8CerJcfjFeEFSCdL1XH2GPASV7SdnzFI+fTHFhVuItdaK8W5wbO8mi+c4Er0C2Y/Luk4tDeIb5vS73waJs/MVoXH2iPybhmnc1rS6xY8S44+zZD3jYtfNFiwogGhlPMlZuyfp2QjrqmMd4d3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yVRXa4mE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578E1jIn005753;
	Fri, 8 Aug 2025 10:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LYULt
	TTtk/bvJaKwcgU0rESYYMOYGbWjyHgFGdhohpg=; b=yVRXa4mEGgXkZnUSE0Xgo
	lDhJO10JvEEyoHR4OMA48P1nJiZtKww3pYKXGk6CpycvhTMDlWroyJqtqBhDblUt
	Uz2LqX/m384O36dxEGE6FH5xqh0U/oyocw2AjhnoLkHPBnGKJpJj4xGIXi8OmLys
	kh9YbsdXFw9HDf9bq7IeZpPtDrM3BOy1ej5gBXMIL+y0wgzfrJE27ykxKiN4uRTT
	yq+3/tHKZF9wAUXzCPL1laU0Dhioj01n8mcoU8adODY+Gh5V1TSZT6vJFWjeQbqC
	0zk4HjXakupxJ9cnWLuH1puZ+qAkr9QTpvIOIWlewO0MObXXJ/h08FpkzSdNqkAW
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48cmhtrhtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 10:11:05 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 578EB4Hj062929
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Aug 2025 10:11:04 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 8 Aug 2025 10:11:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 8 Aug 2025 10:11:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 8 Aug 2025 10:11:03 -0400
Received: from Ubuntu.ad.analog.com ([10.32.13.94])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 578EAqfB014662;
	Fri, 8 Aug 2025 10:10:58 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 1/4] iio: add power and energy measurement modifiers
Date: Fri, 8 Aug 2025 14:10:13 +0000
Message-ID: <20250808141020.4384-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808141020.4384-1-antoniu.miclaus@analog.com>
References: <20250808141020.4384-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ZZsdNtVA c=1 sm=1 tr=0 ts=68960579 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=zDixRrezC0ZtxPwGlo8A:9
X-Proofpoint-ORIG-GUID: W_QIbIdBCyU8Mu5YgFW3In-McMkQSGys
X-Proofpoint-GUID: W_QIbIdBCyU8Mu5YgFW3In-McMkQSGys
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDAyNSBTYWx0ZWRfX+8enk4Ngjnxm
 559k2Q1cjigu6x9Mu9+8Skq0mJdhRcIh3u0+qMF7i+BTKLSQA59xp2oOsMh+Ui830Nin605lrBs
 rNNTdZzhxkUnLKyEmylWyHF4RH219n3EBcntqkVgd5G/UBRj9ulrsYk+lQNxQPH4FfTeGSXGCjR
 CnICahKCSufBiZKiD4SzDLsOsgFBjHXsuf3vZmBsEabIIXxARStyik+lIAj61F+e1qQrkfUBxR3
 XAGg02cCR+m+a0xDiojFUt4iwPnXL7Oe5HpbJQDzxuSUJzrX+rl3mL0W0KeSuBjuYGbV08TJ2Xd
 s/KFSi5Ex5yJFHXclcqGtLJwu91WXWjPZweSIO6cp2/0TYddYmgEYICWmXJNTVqTbqBa5FthkRT
 Hmsw0iOF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070025

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
changes in v3:
 - remove accumulated energy modifiers
 - rename power_factor to powerfactor for consistency
 Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
 drivers/iio/industrialio-core.c         |  5 +++++
 include/linux/iio/types.h               |  1 +
 include/uapi/linux/iio/types.h          |  4 ++++
 4 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2fb2cea4b192..28f51e4cc367 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -167,7 +167,12 @@ Description:
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
@@ -176,6 +181,8 @@ Description:
 		unique to allow association with event codes. Units after
 		application of scale and offset are milliwatts.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_powerfactor
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
 KernelVersion:	3.2
 Contact:	linux-iio@vger.kernel.org
@@ -1569,6 +1576,9 @@ Description:
 
 What:		/sys/.../iio:deviceX/in_energy_input
 What:		/sys/.../iio:deviceX/in_energy_raw
+What:		/sys/.../iio:deviceX/in_energyY_active_raw
+What:		/sys/.../iio:deviceX/in_energyY_reactive_raw
+What:		/sys/.../iio:deviceX/in_energyY_apparent_raw
 KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1692,6 +1702,7 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_rms_raw
 KernelVersion:	3.17
 Contact:	linux-iio@vger.kernel.org
 Description:
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f13c3aa470d7..b046c4bc8486 100644
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
2.43.0


