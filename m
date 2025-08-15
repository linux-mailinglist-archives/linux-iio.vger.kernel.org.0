Return-Path: <linux-iio+bounces-22754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1F7B27DA2
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 11:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C2EAA0573
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B6E2FCC0A;
	Fri, 15 Aug 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Wyo8O/8j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B52FCBE0;
	Fri, 15 Aug 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251867; cv=none; b=cBwLMr8HUR8C0SBABw/2Pu4/jGV49PfwYgEbrQH6Tw92enHEib3yuNUvXOBkvtOlqNWbuE2KiEdy3mXJmJJlrvWx6JlL8DmOmVfM9NN6o3sOgn8DgtX5f5/z7P88hqed3yCtDLuaS4lLZLEadMvMdeLSWkrLA1nKjNSCTNR66y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251867; c=relaxed/simple;
	bh=lRmwS9R55uGoD0hRrdYCsxfZ+aakmCXqPtAvt+j78mU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmM8QhiCB3rG8ajhlxAk4elU+DELxU2m6yUFjhURV2d4Ff/JyI8XNsCf2bij+GZMnnY3EiX+YT8oRIYycnhvzY0VNnzMDSCKSeoXA0BI/A2o/JUCbGtQGaR/prdlhdGn83u3PyIihl8W8CTu0ezqAb3jvZCLHusMT2/H5bxzjZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Wyo8O/8j; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F84W8n007522;
	Fri, 15 Aug 2025 05:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4QCIv
	U2dzE/GP9TqfiME/bVavk/yW7AacTRjng4E/NI=; b=Wyo8O/8j4tEa4s2tr0wF8
	N087Z5uogJOC9lrQKfe6wVxqsm+NPMRlXdwSKnFkPrF1X51cf+AzXLgYJPsIbsrr
	ZD1QqvlEUsVA/5CldH4d7hYxZE/8OVfjQKKsD0eNmKZVtxeElgkOrKkoFoi/fq0J
	HUcsYW+3EdAt0Q2iCLxNL5qBNWXiHsxZsjfjClRX8vfENyVu8QSMs6Heywgwm8S3
	/KfnokzAwzcyqZ2EElcploYqixjFDrNSG071DFXwLgp8J0cvNGDtepqT5+dWeDDG
	pPPN5aUXqNJSirL+BYDJhOubSBbfFRcfke08oENyAkV80hpAgQx6Xuh4//4PLReM
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48h51egp25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 05:57:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57F9vUkG034242
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Aug 2025 05:57:30 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 15 Aug 2025 05:57:30 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 15 Aug 2025 05:57:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 15 Aug 2025 05:57:29 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.226])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57F9vJiu027486;
	Fri, 15 Aug 2025 05:57:26 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 2/5] iio: add power and energy measurement modifiers
Date: Fri, 15 Aug 2025 09:56:35 +0000
Message-ID: <20250815095713.9830-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815095713.9830-1-antoniu.miclaus@analog.com>
References: <20250815095713.9830-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=BNezrEQG c=1 sm=1 tr=0 ts=689f048b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=skdMUFx4Ewza9nfW7JEA:9
X-Proofpoint-GUID: hK7kfPyQi-5rM1hdsj22UuNM4TiC3DsA
X-Proofpoint-ORIG-GUID: hK7kfPyQi-5rM1hdsj22UuNM4TiC3DsA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDIyNCBTYWx0ZWRfX20ku1B1l6Ui8
 vD8GK3ZABQ4Sg/WtX01k3pHOn3bkeKNkOaLjh0FutUFum+MIqjAcEP+AKKmIY0fSzHuy339q9op
 c6Gin+5b0HO1BPgAXC48JKX/felTlmlwSPdMv5BiGq8LeU7ejaWa0p2tGXrhLahIJcdK0hv6fwR
 uWNXHSgLMLxU/lsZM6bp26h4PiFYSQoAcQKgOlMl24eLrXbIho4KuxEz5UbEg486CMJ1cHslP0p
 MIVK7YzePpxvipEzL/bht3nZSzpeP6lBvohZLLb0axWGwMwymbdDaORDHt5BfsX5N/wGl37bi8p
 jKhxBpM6O+hIKZKKhTmUFC3XOQybD/Ta5CJoPpBa2uRUz6pRRZvXdqT3pEqVgurX0UZEjtvPeHQ
 fSXw1d98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508130224

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
changes in v4:
 - add proper KernelVersion and Contact fields to ABI documentation
 - add detailed description for power factor measurement
 - add altcurrent RMS measurement support
 Documentation/ABI/testing/sysfs-bus-iio | 27 +++++++++++++++++++++++++
 drivers/iio/industrialio-core.c         |  5 +++++
 include/linux/iio/types.h               |  1 +
 include/uapi/linux/iio/types.h          |  4 ++++
 4 files changed, 37 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2fb2cea4b192..9d283b23d3c0 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -167,7 +167,17 @@ Description:
 		is required is a consistent labeling.  Units after application
 		of scale and offset are millivolts.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw
+KernelVersion:	6.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) RMS voltage measurement from
+		channel Y. Units after application of scale and offset are millivolts.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_active_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_reactive_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_apparent_raw
 KernelVersion:	4.5
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -176,6 +186,13 @@ Description:
 		unique to allow association with event codes. Units after
 		application of scale and offset are milliwatts.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_powerfactor
+KernelVersion:	6.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Power factor measurement from channel Y. Power factor is the
+		ratio of active power to apparent power. The value is unitless.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
 KernelVersion:	3.2
 Contact:	linux-iio@vger.kernel.org
@@ -1569,6 +1586,9 @@ Description:
 
 What:		/sys/.../iio:deviceX/in_energy_input
 What:		/sys/.../iio:deviceX/in_energy_raw
+What:		/sys/.../iio:deviceX/in_energyY_active_raw
+What:		/sys/.../iio:deviceX/in_energyY_reactive_raw
+What:		/sys/.../iio:deviceX/in_energyY_apparent_raw
 KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1707,6 +1727,13 @@ Description:
 		component of the signal while the 'q' channel contains the quadrature
 		component.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_rms_raw
+KernelVersion:	6.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no bias removal etc.) RMS current measurement from
+		channel Y. Units after application of scale and offset are milliamps.
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


