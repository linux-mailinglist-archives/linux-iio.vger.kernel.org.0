Return-Path: <linux-iio+bounces-23876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E56DB48584
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 09:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF177B1913
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 07:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873F72E8DF7;
	Mon,  8 Sep 2025 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CPV0OTlG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990672E7BCB;
	Mon,  8 Sep 2025 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316976; cv=none; b=uUMpm3Y3FnNSot3ccEoaCLRpg1lJYR88UtCpyHjM7ESf3GPmeu/z33Hof20H+pLThDEN12amoigmUGH2+C2VDpXs4K6yC2t2O6qtQYL4d3DsjrSHRHfGKkWXqlzH8LeZg6d+UDGNfDDedTE2F/rZ2ArwGMkcQ8x/OHckz++4k8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316976; c=relaxed/simple;
	bh=JZrJ85i5faqjawGQ6N84C3rWLvF1iJ6SNx9DsYfDw4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAosLeKPgA+nBD5vPkRkeuNq0M4uOUVfEDZB9KLRLuA9IUzr70EQCS0MD7EC/XjgF2R2OJyrfNMk0mJFecko+lKnBL0sfJMsRUoYiI3o5wy1KK7yoNqzsK//taXq9+76K7ohevM0NUXafauzOCv7BhkueubSLsdpTTHwx1p1QCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CPV0OTlG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5883xACS003822;
	Mon, 8 Sep 2025 03:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+7/kG
	scdwGNsDembX2CrKkaVRxiDahJiGIH+Ixxor4o=; b=CPV0OTlGjRtQBFIYk6mXD
	yXJjHsHbs4oRU6hTR8TFehYzX2ADAYS9eZSMcfnyfzcJHVwE1gAfHuFtQcmsRrmn
	9xVUWsvFEPb/Kq7Pm3aphOsW28sEq2UkRpuSS/xPaOomxGnwpUoSbjXrSEHOI7YP
	kYGifOf/7KczXTGu4A+VNeu5AEG3uUR1SDbiB1VZwkkD46hOGTt+CZzaS5lvakRA
	eBK9puytv9huYwk9DoKUD2+yF4ZLN6d9e9G1R10iZgKxWcs/2qI9wS1e/zSKzgzz
	9FXBlFdFImHNHoBlcNHurXzdoKc6sjwXmS2trW3afNsCVq5m0ASjCxrhNzdCNbvk
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 491qqfguff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 03:36:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5887a5fp036430
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Sep 2025 03:36:05 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 8 Sep 2025 03:36:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 8 Sep 2025 03:36:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Sep 2025 03:36:05 -0400
Received: from Ubuntu.ad.analog.com ([10.132.255.227])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5887ZpEe004718;
	Mon, 8 Sep 2025 03:35:59 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v7 2/6] iio: add power and energy measurement modifiers
Date: Mon, 8 Sep 2025 07:35:22 +0000
Message-ID: <20250908073531.3639-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908073531.3639-1-antoniu.miclaus@analog.com>
References: <20250908073531.3639-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNSBTYWx0ZWRfX8A9yOVfQ/NSc
 CQI+TjWsqAJD2CrlesV7ksKrXQJ9SC+f532T4iR7k3wVb2YTJvkMOEvPAisHpzaUvhhPCmSfI3Z
 9/fdiDMlUf1EB4qILexkJB7nFlFWOAqk/QKb0EaytTLjpvs52AnMTvnid/ZV6nML+/6iun/wOul
 a9AuP6rlEjJlgfww6kOGKM9TBnNhcUq8EaO7tMmTDa9MjPoG73K3gvuGXdIj1UONleMNPmkj3cs
 INN1bB3uUo0dBTMMVl47a3QCAO3Ult83JBwGFna8odRNocqZ2hsaz1qDnOzKd86cE+E5cqFEGt3
 re0wlJ/a2HD3+w9yzvPBgNi6daXd0OdcUDJ0dkiBHxhUCgGO1v8gu1xKsDs2jXeP3EiYmH2oGl9
 cgAHPxkG
X-Authority-Analysis: v=2.4 cv=EJkG00ZC c=1 sm=1 tr=0 ts=68be8766 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=4CwWzBU9b3dOdXpWUEUA:9
X-Proofpoint-ORIG-GUID: LCyPoWgBDwUebgsurMCD3h4laXhlbEo_
X-Proofpoint-GUID: LCyPoWgBDwUebgsurMCD3h4laXhlbEo_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509080035

Add new IIO modifiers to support power and energy measurement devices:

Power modifiers:
- IIO_MOD_ACTIVE: Real power consumed by the load
- IIO_MOD_REACTIVE: Power that oscillates between source and load
- IIO_MOD_APPARENT: Magnitude of complex power

Signal quality modifiers:
- IIO_MOD_RMS: Root Mean Square value

Additionally adds:
- IIO_CHAN_INFO_POWERFACTOR: Power factor channel info type for
  representing the ratio of active power to apparent power

These modifiers enable proper representation of power measurement
devices like energy meters and power analyzers.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v7:
 - add modifier names to tools/iio/iio_event_monitor.c
 Documentation/ABI/testing/sysfs-bus-iio | 29 +++++++++++++++++++++++++
 drivers/iio/industrialio-core.c         |  5 +++++
 include/linux/iio/types.h               |  1 +
 include/uapi/linux/iio/types.h          |  4 ++++
 tools/iio/iio_event_monitor.c           |  8 +++++++
 5 files changed, 47 insertions(+)

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
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index d26aff649f3f..03ca33869ce8 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -141,6 +141,10 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PITCH] = "pitch",
 	[IIO_MOD_YAW] = "yaw",
 	[IIO_MOD_ROLL] = "roll",
+	[IIO_MOD_RMS] = "rms",
+	[IIO_MOD_ACTIVE] = "active",
+	[IIO_MOD_REACTIVE] = "reactive",
+	[IIO_MOD_APPARENT] = "apparent",
 };
 
 static bool event_is_known(struct iio_event_data *event)
@@ -240,6 +244,10 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_PM4:
 	case IIO_MOD_PM10:
 	case IIO_MOD_O2:
+	case IIO_MOD_RMS:
+	case IIO_MOD_ACTIVE:
+	case IIO_MOD_REACTIVE:
+	case IIO_MOD_APPARENT:
 		break;
 	default:
 		return false;
-- 
2.43.0


