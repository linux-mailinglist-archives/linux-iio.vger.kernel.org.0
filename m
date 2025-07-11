Return-Path: <linux-iio+bounces-21585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243AB0238A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 20:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68838B41E83
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 18:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EC92F2C5C;
	Fri, 11 Jul 2025 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hlaTYecE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30D2F271F;
	Fri, 11 Jul 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258147; cv=none; b=H8xQkIV1aL/tgylz0VYv3aZdhIDAm3+xbD9w3u7hJdonz9qFFZcIfhl/SgGW6UOfZsI81T4yv9YFUjTGpD7SphNsuAybajwunofqRoKLJ0ahynw3jC770bMGQKv8MTlEOg38h4wWRnGDFOjlJCZ+dhokV+a5ATojsV/3t9QhzeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258147; c=relaxed/simple;
	bh=WPxqsgcHN69KaegDws1laEv2TC95EIzTRBlTXIBMEk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSBTqDY4LAnOYfvywkga0iZT8JyPjTsMksahni3TJ61qn86fKuaRO3r2y+G80Cpbdw4vEsAD210+7+82oUnRyXkuAWk7Dwd0b7KzZUts2xLxbbutIUTaI+J1g9IwkjlUyGtveV1jHodfycB+Xy2eAPoIx8ILOw+azAtJxUUQ1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hlaTYecE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BCIuaq004484;
	Fri, 11 Jul 2025 09:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fHYy0
	eF/BH0+65Ui4ZSNiV1Q5cmY+r6R+4TLj4EVbm0=; b=hlaTYecEs1fBY8tYCqVMZ
	I5Yj998UKdSw36nG6ma4OSlRmU180tfkSl8vcPoiDfhtDBz2eCRnoQI11QWdyUSh
	x645FoqLQim0D1eRviCIlgk83Ol3F0avRVME2TB7F8/YMEnQ/GpnXBU0PVq2HLvF
	LOsm3qF7E93xvhpenvTBTQ6E1zV67Iq109JoRHlmQqYW62v3qRZS93wHK5x0808I
	BQULgfugig2oJ9RVAaK7Fdto06ASCYxAT1ZMaNA9nuQdkeGDXnLPhfXqqGKoF7gn
	k3+C/FstDBln7XgE2+r/Wdp0OP8lrC7Luc7iTou99KHAOLCjNkH5VoiJroodZTJA
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47pwwa7ccd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 09:03:30 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 56BD3TxB026792
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Jul 2025 09:03:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 11 Jul
 2025 09:03:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 11 Jul 2025 09:03:29 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.132])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56BD3Jqr027484;
	Fri, 11 Jul 2025 09:03:25 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/3] iio: add power and energy measurement modifiers
Date: Fri, 11 Jul 2025 16:02:35 +0300
Message-ID: <20250711130241.159143-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711130241.159143-1-antoniu.miclaus@analog.com>
References: <20250711130241.159143-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5MiBTYWx0ZWRfX6ziA7SP9mnk+
 4gw2f53Ai/9sD3sErqM3lVr9/86zc9QDdE58mbKM2CqQxm2/a6Oh57JvyfERfbRnDl/IoQ/Jy/x
 MgqurWUDThvqlCmLxzO59rtcQaXoY2Ch+vZJFNnE8uOcr9vq+QKtnJFl0eFgJGf4EHkaxqbxW0Z
 jietsKQzz67VTgDBxTiDGbgVWcf4NSLHXISg94zNurl/sZkcWMkD38rBdpn7fKyEvFMHRfs/Ppn
 c6n4u7Zoo9bbD4uuJOG2FbKDakCFaS4YM2/drYWjCEHa4s6CFixMEQCWB07U1PupXuULKUQGaX0
 g+GXj1ESX69O4Ywv96Mb6VhoXMv/ObGsV56csbPb07OuYbtoyq3aW5degAO30b02ihOGicXsed9
 WZic52CSe9wnKrfhQLxHGSTwjYMKmacrg6QRTPIRSc08xkQH4+iwzEk96nEGqjtmu6qSqx3t
X-Authority-Analysis: v=2.4 cv=E+DNpbdl c=1 sm=1 tr=0 ts=68710ba2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=une20UNuun7GP44vQxEA:9
X-Proofpoint-GUID: B0ZDiaWG1YBaXsEPVSnMrXb5RmERYgmV
X-Proofpoint-ORIG-GUID: B0ZDiaWG1YBaXsEPVSnMrXb5RmERYgmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110092

Add new IIO modifiers to support power and energy measurement devices:

Power modifiers:
- IIO_MOD_ACTIVE: Real power consumed by the load
- IIO_MOD_REACTIVE: Power that oscillates between source and load
- IIO_MOD_APPARENT: Magnitude of complex power
- IIO_MOD_FUND_REACTIVE: Reactive power at fundamental frequency
- IIO_MOD_FACTOR: Power factor (ratio of active to apparent power)

Energy modifiers:
- IIO_MOD_ACTIVE_ACCUM: Accumulated active energy
- IIO_MOD_APPARENT_ACCUM: Accumulated apparent energy
- IIO_MOD_REACTIVE_ACCUM: Accumulated reactive energy

Signal quality modifiers:
- IIO_MOD_RMS: Root Mean Square value
- IIO_MOD_SWELL: Voltage swell detection
- IIO_MOD_DIP: Voltage dip (sag) detection

These modifiers enable proper representation of power measurement
devices like energy meters and power analyzers.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 19 +++++++++++++++++++
 drivers/iio/industrialio-core.c         | 11 +++++++++++
 include/uapi/linux/iio/types.h          | 11 +++++++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3bc386995fb6..d5c227c03589 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -143,6 +143,9 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_rms_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_swell_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dip_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -158,6 +161,7 @@ Description:
 		component of the signal while the 'q' channel contains the quadrature
 		component.
 
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
@@ -170,6 +174,11 @@ Description:
 		of scale and offset are millivolts.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_active_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_reactive_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_apparent_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_fund_reactive_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_factor_raw
 KernelVersion:	4.5
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -178,6 +187,7 @@ Description:
 		unique to allow association with event codes. Units after
 		application of scale and offset are milliwatts.
 
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
 KernelVersion:	3.2
 Contact:	linux-iio@vger.kernel.org
@@ -1593,6 +1603,12 @@ Description:
 
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
@@ -1600,6 +1616,7 @@ Description:
 		device (e.g.: human activity sensors report energy burnt by the
 		user). Units after application of scale are Joules.
 
+
 What:		/sys/.../iio:deviceX/in_distance_input
 What:		/sys/.../iio:deviceX/in_distance_raw
 KernelVersion:	4.0
@@ -1718,6 +1735,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_rms_raw
 KernelVersion:	3.17
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1733,6 +1751,7 @@ Description:
 		component of the signal while the 'q' channel contains the quadrature
 		component.
 
+
 What:		/sys/.../iio:deviceX/in_energy_en
 What:		/sys/.../iio:deviceX/in_distance_en
 What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_en
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f13c3aa470d7..daf486cbe0bd 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -152,6 +152,17 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PITCH] = "pitch",
 	[IIO_MOD_YAW] = "yaw",
 	[IIO_MOD_ROLL] = "roll",
+	[IIO_MOD_RMS] = "rms",
+	[IIO_MOD_ACTIVE] = "active",
+	[IIO_MOD_REACTIVE] = "reactive",
+	[IIO_MOD_APPARENT] = "apparent",
+	[IIO_MOD_FUND_REACTIVE] = "fund_reactive",
+	[IIO_MOD_FACTOR] = "factor",
+	[IIO_MOD_ACTIVE_ACCUM] = "active_accum",
+	[IIO_MOD_APPARENT_ACCUM] = "apparent_accum",
+	[IIO_MOD_REACTIVE_ACCUM] = "reactive_accum",
+	[IIO_MOD_SWELL] = "swell",
+	[IIO_MOD_DIP] = "dip",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 3eb0821af7a4..9e05bbddcbe2 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -108,6 +108,17 @@ enum iio_modifier {
 	IIO_MOD_ROLL,
 	IIO_MOD_LIGHT_UVA,
 	IIO_MOD_LIGHT_UVB,
+	IIO_MOD_RMS,
+	IIO_MOD_ACTIVE,
+	IIO_MOD_REACTIVE,
+	IIO_MOD_APPARENT,
+	IIO_MOD_FUND_REACTIVE,
+	IIO_MOD_FACTOR,
+	IIO_MOD_ACTIVE_ACCUM,
+	IIO_MOD_APPARENT_ACCUM,
+	IIO_MOD_REACTIVE_ACCUM,
+	IIO_MOD_SWELL,
+	IIO_MOD_DIP,
 };
 
 enum iio_event_type {
-- 
2.49.0


