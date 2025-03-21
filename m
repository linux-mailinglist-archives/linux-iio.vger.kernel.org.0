Return-Path: <linux-iio+bounces-17175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE23A6BD98
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 15:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E825188E43B
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851DC1D63F5;
	Fri, 21 Mar 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fSCAE1so"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19DE154426;
	Fri, 21 Mar 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568644; cv=none; b=B3AxU5SXsUthZfD1tYGPDjAkyNkkcFyTMg3ZL4VpZHALHIy8oNO151GE7k8ViE0sZZQYceREj9mEGFi1T9S+d+B7rCI7abaJ2O3THHyqJGKTPK+uQ/WoSCNdZmJcsJzmHTP/pOzcTNXeWK6mtWQZk6NrhB0wkw0f5abKK4sh6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568644; c=relaxed/simple;
	bh=Ke392798YfqkVccnJJgazt7Gp27vIGbDkb8+U/l8CmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eixLJ1TmOBhAW01B8EQLfZLuyA955dlItpKKRqm1aCeoOqV1HLm9EpBXCTNtCA98iA90NBCh7qu2RwAAwCvR1mqw+G8dTF/UACkXntHhUg6bpi7yqZRcFJIv2QosW74T5LeSmdmB05JI0HKAnRWUe5kiq+4lRCDe/IFy1kEPxYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fSCAE1so; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LD320O030121;
	Fri, 21 Mar 2025 10:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=usz+o
	DcQFrn8eUMbhg/PwWMQWmpZt+5cevytTEXV5gY=; b=fSCAE1so6zDQUhZKxqerg
	LRDqLsgFTJFG/IK+ZBk0A9SXx9EiXyL5k8TDDduSKveXjfS9nz433fYHfMTGAUF7
	XvBeCyYMU1b6vC1UqKilQtdf50RfaYMdTtywCDbcZOTx6XwdedZ4vAFFQTWGvLHM
	itwNs15a2jEtttBohsr718zZu/o9n3XN8ldavYxE2tpDa4EVdFkJAb3mFY0zNWoR
	WxaHWZm6nXyotqq1eT6L4Q4eVb2yn0Dnujdh+qNpSaYEt1b4QlM5hApoIWbN3f0y
	Xnk22lbsGq2jwRH7ww+/n3jfx6bAdJQWkrLpORnFahZJj/eZaBr/TGt+7bb5h8yg
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45fwvmwg33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:50:14 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52LEoDoD057360
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Mar 2025 10:50:13 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 21 Mar 2025 10:50:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 21 Mar 2025 10:50:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 21 Mar 2025 10:50:13 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.52] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52LEo1cc011710;
	Fri, 21 Mar 2025 10:50:09 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Fri, 21 Mar 2025 15:50:02 +0100
Subject: [PATCH 2/2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250321-abi-oversampling-events-frequency-v1-2-794c1ab2f079@analog.com>
References: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
In-Reply-To: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <dlechner@baylibre.com>, <Michael.Hennerich@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742568601; l=2033;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=Ke392798YfqkVccnJJgazt7Gp27vIGbDkb8+U/l8CmE=;
 b=JkbroxQO5TYpQtQAZvVd4ToVMrbKA/MhFxw/svM14FgFXf0fuWBlZ6izF7cyiX0HEywzyETDZ
 YMf7O6C9/fcCwOuETCWv+YA/Bq4van+dUC3YIIos1BJaCfTwhLoYemy
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jPKrQntXUjSJdKHpcEg6z-xyIXE188il
X-Authority-Analysis: v=2.4 cv=J5+q7BnS c=1 sm=1 tr=0 ts=67dd7ca6 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=Lzo1KZEzI_3Gt0V5Qg0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jPKrQntXUjSJdKHpcEg6z-xyIXE188il
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210108

Some devices have an internal clock used to space out the conversion
trigger for the oversampling filter,
Consider an ADC with conversion and data ready pins topology:

  Sampling trigger |       |       |       |       |
  ADC conversion   ++++    ++++    ++++    ++++    ++++
  ADC data ready      *       *       *       *       *

With the oversampling frequency, conversions can be evenly space between
the sampling edge:

  Sampling trigger |       |       |       |       |
  ADC conversion   + + + + + + + + + + + + + + + + + + + +
  ADC data ready         *       *       *       *       *

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 33c09c4ac60a4feec82308461643134f5ba84b66..2317bacf6a2884691a08725d6f01d18555a96227 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -139,6 +139,23 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Hardware dependent values supported by the oversampling filter.
 
+What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
+KernelVersion:	6.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Some devices have internal clocks for the ADC oversampling.
+		Sets the resulting sampling frequency to trigger a conversion
+		used by the oversampling filter.
+		Can be used to evenly space conversion between the sampling edge
+		on some devices.
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

-- 
2.48.1


