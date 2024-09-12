Return-Path: <linux-iio+bounces-9456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9F5976617
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 11:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A327528515F
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E036D19F11E;
	Thu, 12 Sep 2024 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Rfun2qR4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDE184558;
	Thu, 12 Sep 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134928; cv=none; b=b9A5lgQePvcEnF7Wd0XTyH5qbLYqJzOmtIDYzv4FM+rvkd1FmVx7wnpYUs9oqzcjnczfL9nSe87bcLb7/mmONEAeb1jBtY1m9T4yVUC64w/SSSQKd1QDSxP92YVWH3uvhp1XCUwkzR+HpTE/A9QTQHNMa3QDAdnO8wUM4D1YbMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134928; c=relaxed/simple;
	bh=xFBLCtD6Bsp91VuMR8B/WYgWsL+sw63x7VySWKoaV+o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qoq/h7Vj+5iM4pRjR7VmKQiSKu6MOk1504MpMOXwekCy10/ee5G43lByZnk0aYKGs4mo4C4mYxvOKnFvyqQgDd6YRBUcxQrPpeVecWhpshSXXB6/SI8u+D7r4klPicb5Fbnn/mjLAYCRwXiwv+CM7+bOkdOiqppeO/1Tax65U6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Rfun2qR4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C9fgxQ031886;
	Thu, 12 Sep 2024 05:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ew9oyy0FnZ3UDR6qW2rk6IXXfbP
	L1U9LXel+SAz486M=; b=Rfun2qR4vEccMl7CoI3GvZ/8ovdYRm+gadIUspIFrle
	Z8yD03miREoXGCWmhEyeLp+W6tdhVsjLkVRlpbCN3s9G4BjNj4MTDZ7M9i9PJ2Iq
	exYoKuz+OGDmIo5QQdqFRe4ObAq6hA+vA584qu6kPAoRVb7/zhyQgAhtxEXgRS5g
	Nhaaa8haDU2kyYcAxCTv5KHiyRye+8QRTcllPM7oen4ltbqXGpljp6Jlcmk7cyld
	QsWMyP77PS7+7fOA7sQ8yHsQgmEvLFFvXOVs+AXU+zZkOyT90XcYM5HWVfXwbmDH
	/JwwKGxr2KKx9oNN2CmmmjjmUu/0eD1+QcnbrAmU2iA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41gyh1kbqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 05:54:59 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 48C9swGv007693
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Sep 2024 05:54:58 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 12 Sep 2024 05:54:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 12 Sep 2024 05:54:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 12 Sep 2024 05:54:57 -0400
Received: from MTINACO-L03.ad.analog.com (MTINACO-L03.ad.analog.com [10.117.116.121])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48C9sheQ026249;
	Thu, 12 Sep 2024 05:54:45 -0400
From: Mariel Tinaco <Mariel.Tinaco@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Marcelo
 Schmitt" <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>
Subject: [PATCH v4 0/2] add AD8460 DAC driver
Date: Thu, 12 Sep 2024 17:54:33 +0800
Message-ID: <20240912095435.18639-1-Mariel.Tinaco@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 2VoEmhpbKhFsLpMDU16EW6K8iFor9NCS
X-Proofpoint-GUID: 2VoEmhpbKhFsLpMDU16EW6K8iFor9NCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120069

Apply comments for adding support to AD8460 Waveform Generator DAC

changes in v4

ad8460:
  * Fixed spacing issues and tab format of includes.
  * Changed data type of spi_tx_buffer to __le16. Then used le16_to_cpu and
    cpu_to_le16 functions for bulk read and write access.
  * Changed print format in sysfs_emit for unsigned int.
  * Added comments on powerdown write function to describe logic.
  * Omitted "_shared" parameter in AD8460_CHAN_EXT_INFO. 
  * Applied further changes to channel definition (endianness = IIO_CPU and
    AD8460_CURRENT_CHAN output = 1).
  * Reformatted section that reads REFIO_1P2V voltage.
  * Fixed upper and lower limits for checking of REFIO_1P2V.
  * Removed comment for arming the device in probe function.
  * Created a section for IIO related includes.
  * Replaced mutex_init with devm_mutex_init.
  * Added and enabled the other supplies using regulator bulk enable
  * Handled devm_iio_channel_get error -EPROBE_DEFER by returning
    -EPROBE_DEFER

Bindings:
  * Removed description on clocks
  * Reverted GPIO pin name to shutdown-reset-GPIO
  * Added minimum, maximum and default for setting voltage, current and
    temperature
  * Added required supplies
  * Changed additionalProperties to unevaluatedProperties

Mariel Tinaco (2):
  dt-bindings: iio: dac: add docs for ad8460
  iio: dac: support the ad8460 Waveform DAC

 .../bindings/iio/dac/adi,ad8460.yaml          | 164 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/dac/Kconfig                       |  13 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ad8460.c                      | 947 ++++++++++++++++++
 5 files changed, 1133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
 create mode 100644 drivers/iio/dac/ad8460.c


base-commit: fec496684388685647652ab4213454fbabdab099
-- 
2.34.1


