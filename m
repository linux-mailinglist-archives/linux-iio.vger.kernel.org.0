Return-Path: <linux-iio+bounces-17803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B641A7F7B3
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 10:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1213E18926E9
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A052641D7;
	Tue,  8 Apr 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1x7W2PRw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E02641C0;
	Tue,  8 Apr 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744100468; cv=none; b=Yf2IRznI/RGfEivTaJgD4pxBcXQeB08HZt5HFaE5rsrxN3Zy+3BcxOt9yLv5E0c3/XdBiK+MpcqQX8vsu2m7AjIPMM9vs9JmozmKHujr3dphpQvhKxPsGzY6iA+54tuR/+w9d7YPyxZ6wml1XxE3d1hUs6kYfNZZGLsm9ym6W4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744100468; c=relaxed/simple;
	bh=nKfoNFWReOFyONDTFWwdX4RSHSGV441gkBmYnn2xXcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=aFAC4Kk9ipt/OQQbgYzq4zY7L1BIWMd8d4pWql8TwH86dBBi18L7SgdL/k82ylLMSRiQEAYZoKVAshYySCGrBxvRy1cTEKLKVCdISP7ZEHNvNnh39osz31kKbeW8dH3g7AhtelVbOgFnirNzCEVXNs87vbpDE6O+GicqFgK8JdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1x7W2PRw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53870DKn020436;
	Tue, 8 Apr 2025 04:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Rf2nluUByTfme7Cv3TdBT5MtVyZ
	rDKfqEqnO7yl5/O8=; b=1x7W2PRwDrK5Qr27TUpk2ne9lfeSc0FDpOkzUPnQ5yc
	L1U7vlMFwdP2PLnDwhT97Nbl8wz4VRkBesutMiWXBE+FNQVMCp02cl/QsUw+Ugwc
	B9SYLdOR+4vQca3+cjP9BC/Y0m/C5y+bpSsnjy/k3M1/EBvwVJyH52tbLTAARknV
	pXFgmKHCGfAG8yN5bDGCbI/TrOghcZVxf2POMUoH6WkvMSR8QXzEGmlCtmLX+Twd
	DoFMW/520EHKC18wQtCcH1AxicNvxcLWCITX3bOFliWn/32wcL/sP8kuek5e3eoO
	iso7FFQMu+D1EWZlxGx3QYLpQDEhSLOk8MoOsuUjfIg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45txc5xta6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 04:20:48 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5388Klgc018091
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Apr 2025 04:20:47 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 8 Apr 2025 04:20:47 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 8 Apr 2025 04:20:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 8 Apr 2025 04:20:47 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5388KbEV001610;
	Tue, 8 Apr 2025 04:20:39 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 8 Apr 2025 10:20:29 +0200
Subject: [PATCH v2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250408-abi-oversampling-events-frequency-v2-1-4059272b7364@analog.com>
X-B4-Tracking: v=1; b=H4sIAEzc9GcC/5WNQQ6CMBAAv2J6dk1bEIIn/2E4lHULm0CLLTYSw
 t+t/MDjzGFmE5ECUxS30yYCJY7sXQZ9PgkcjOsJ+JlZaKmvstAKTMfgE4Vopnlk1wMlcksEG+j
 1JocrlEWFVWmRkKTInTmQ5c/xeLSZB46LD+uxTOpn/6knBRLqpkRlOm1l3dyNM6PvL+gn0e77/
 gWg2VrG0wAAAA==
X-Change-ID: 20250321-abi-oversampling-events-frequency-436c64fcece0
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <dlechner@baylibre.com>, <Michael.Hennerich@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744100437; l=3676;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=nKfoNFWReOFyONDTFWwdX4RSHSGV441gkBmYnn2xXcs=;
 b=dM0mJfygHjSA3nj+6Kwb2tCisme3XgV6PD5Lhqoq6hCNGZla4ai54FMwsDkNuRjGIsY8phn7M
 2r/eEBraf8YCH6GPmiq2q/eo4/QyDq/qWgQJhL6epikj+0jxWKz4kbM
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: DCbFVyY31ACCErKNRrR2xZlT39WNTyK9
X-Proofpoint-ORIG-GUID: DCbFVyY31ACCErKNRrR2xZlT39WNTyK9
X-Authority-Analysis: v=2.4 cv=KePSsRYD c=1 sm=1 tr=0 ts=67f4dc61 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=G02aU-f3XFZu7WhG8HgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080059

Some devices have an internal clock used to space out the conversion
trigger for the oversampling filter,
Consider an ADC with conversion and data ready pins topology:

  Sampling trigger |       |       |       |       |
  ADC conversion   ++++    ++++    ++++    ++++    ++++
  ADC data ready      *       *       *       *       *

With the oversampling frequency, conversions are spaced:

  Sampling trigger |       |       |       |       |
  ADC conversion   + + + + + + + + + + + + + + + + + + + +
  ADC data ready         *       *       *       *       *

In some devices and ranges, this internal clock can be used to evenly
space the conversions between the sampling edge.
In other devices the oversampling frequency is fixed or is computed
based on the sampling frequency parameter, and the parameter is
read only.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
Some device families such as Analog Device's max1363, ad7606, ad799x, and
ad4052 contain internal clocks used by monitor modes and oversampling.
Devices' monitor modes are exposed as IIO events.
The max1363 driver included the events/sampling_frequency in
commit 168c9d95a940 ("iio:adc:max1363 move from staging.")
and ad799x in
commit ba1d79613df3 ("staging:iio:ad799x: Use event spec for threshold
hysteresis")
but went undocumented so far.

The oversampling sampling frequency is a planned feature to be patched
onto the ad7606 driver.
In this particular device, it is called oversampling padding.
The upcoming ad4052 linux driver will utilize both entries,
it is worth noting, however, there is a single register for both
options. Since the device is never concurrently in both modes, the
values will be safely cached on the device state.
---
Changes in v2:
- Updated oversampling frequency description according to discussion 
- Don't include already applied
  commit 3a8fee68faf2 ("Documentation: ABI: add events sampling frequency in sysfs-bus-iio")
- Link to v1: https://lore.kernel.org/r/20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com
---
 Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 722aa989baac43f694076074b307d134867b4533..6f5c4060704742ae5f5672a861271b88084ac8f8 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -138,6 +138,23 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Hardware dependent values supported by the oversampling filter.
 
+What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
+KernelVersion:	6.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Some devices have internal clocks for oversampling.
+		Sets the resulting frequency in Hz to trigger a conversion used by
+		the oversampling filter.
+		If the device has a fixed internal clock or is computed based on
+		the sampling frequency parameter, the parameter is read only.
+
+What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
+KernelVersion:	6.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Hardware dependent values supported by the oversampling
+		frequency.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw

---
base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
change-id: 20250321-abi-oversampling-events-frequency-436c64fcece0

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


