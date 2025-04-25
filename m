Return-Path: <linux-iio+bounces-18628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E61A9C770
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9151BC63CF
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 11:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916723D2BA;
	Fri, 25 Apr 2025 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rPY1cMC7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6775220C00D;
	Fri, 25 Apr 2025 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580359; cv=none; b=rpNCCJvE7Qw0EveWzZMQkOcQfEm7eQh6qud73+xcmAJb7uVVeq/OW5LSqFQKD0OI/csxxXrzvttrTMkvrOAeqO+aJa0qP4YlSv7HywQl545oWYEEMIA1IQngVaD6yXD0IXKXV1O+mNfI3SY6CwAcTcKM1a6VPVQ64P/Ju47jw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580359; c=relaxed/simple;
	bh=HwNclwhZu1+YzJSQZY1o6WF7qBz10lbXi+Lqv49OtYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WxSb0acfyOxagDnLzu0sFg6xHA20atAZ8v39JiH8HfkbkKUSpbfnemd4eoW1dkhRN2MmJVpOKPQespCfL2qvNcoVz0Ft7Njy+fbqli0hvT4B74I1T8j5hEdmYMX+SJDVm9S0PH7psk/8OIwUV5PRPviu++iwccTAThufuxZ4+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rPY1cMC7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9ocmK014720;
	Fri, 25 Apr 2025 07:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=wcAa+la8WiRgRCCraAw+huYsPLT
	fRct07+F04OZ7Oeo=; b=rPY1cMC7dGTNrr6CqZ+lQgsn4dRBv0snmYf/XT/KYjY
	YH0nQlmM7sxlbLHzsArdyXAl56i9CDITaWQIvqq51A12Tame16dZQpNQdrypommV
	dOexevrsHl2uAPIfEpufJ7nWUWkm/wuTO0+bACCBIJbH8BQtadf/d2Hv7PgtIuvd
	AUATabCztXLrB8vHbnZ5CQTgSUjEC/k5h2AsXOnhoz3mWp+PkDpBxw7LgpO595Gc
	86b9EwZWF7D3DYwpZrfq2vhIRzkFDlxIiRJVmyQ6fWTOvj5VKzozoRqHQo8vz/KP
	sN+f0GYoJ3bMllB4XULNA3w+e1eUhDwyEgATBh5cOHw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 466jjwf1ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 07:25:54 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PBPrF0049188
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 07:25:53 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Apr 2025 07:25:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Apr 2025 07:25:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 07:25:52 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PBPjbq003881;
	Fri, 25 Apr 2025 07:25:47 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 00/11] Add support for AD4080 ADC
Date: Fri, 25 Apr 2025 14:25:27 +0300
Message-ID: <20250425112538.59792-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: AWAWkRaNkfWwErbt3YAzllhP-aKyar26
X-Authority-Analysis: v=2.4 cv=JMU7s9Kb c=1 sm=1 tr=0 ts=680b7142 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=HubKl35eoKcbRmig0ccA:9
X-Proofpoint-ORIG-GUID: AWAWkRaNkfWwErbt3YAzllhP-aKyar26
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MiBTYWx0ZWRfX+xE2lrjgFaHi 1ZMxxnW1UP+SVYbZu85bbKQM0a0kv14fIYhx0edxsXhFvMp/HuJ6Uc5ayq6TW2QMjUAUhIrfZE3 mQFlkN0FJ+hmbCHmKTt//Ge1seIiX+a9HhegUYPNcUQelDRG+cG9HU7r5M1CP7gCxuKx8wno0Qh
 XyRz2yijuz3/C0bn+x0d8M2HFkfCt2KLFn1a9sSua9lEXEFciEyCn3LH0Bi/C09ISyVsrfZsBDx gMuRZRTwMyKpoVqfG1ed/VcGC4W5W8vAJXsYQdDF6Oii/BOXpzQwTFIxDkJ+1mQGE6l9a9zyhgZ EqhuT7Livie5ioK7lG0COTuBMxp7SGb18dwtxT3krwPmGby9I+5Adwisy9gdmeQTrcDT/zJYH1X
 rFNBQ/YY7e0CQFEj/+UIsWxxlNIotNOCvTCgGAvbs2/AsW63Xb6tZPRHSFocQO3Eiwma1KAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250082

The AD4080 is a high-speed, low noise, low distortion, 20-bit, Easy
Drive, successive approximation register (SAR) analog-to-digital
converter (ADC). Maintaining high performance (signal-to-noise and
distortion (SINAD) ratio > 90 dBFS) at signal frequencies in excess
of 1 MHz enables the AD4080 to service a wide variety of precision,
wide bandwidth data acquisition applications.

This driver aims to be extended in the future to support multiple parts that are
not released yet:
    AD4081
    AD4082
    AD4083
    AD4084
    AD4085
    AD4086
    AD4087
    AD4088

Antoniu Miclaus (11):
  iio: backend: add support for filter config
  iio: backend: add support for data alignment
  iio: backend: add support for sync status
  iio: backend: add support for number of lanes
  dt-bindings: iio: adc: add ad408x axi variant
  iio: adc: adi-axi-adc: add filter type config
  iio: adc: adi-axi-adc: add sync enable/disable
  iio: adc: adi-axi-adc: add sync status
  iio: adc: adi-axi-adc: add num lanes support
  dt-bindings: iio: adc: add ad4080
  iio: adc: ad4080: add driver support

 .../bindings/iio/adc/adi,ad4080.yaml          |  96 +++
 .../bindings/iio/adc/adi,axi-adc.yaml         |   2 +
 drivers/iio/adc/Kconfig                       |  14 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4080.c                      | 618 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  95 +++
 drivers/iio/industrialio-backend.c            |  72 ++
 include/linux/iio/backend.h                   |  25 +
 8 files changed, 923 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
 create mode 100644 drivers/iio/adc/ad4080.c

-- 
2.49.0


