Return-Path: <linux-iio+bounces-15647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6AFA383A1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821F8172F27
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F39521C18D;
	Mon, 17 Feb 2025 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qjVZpAJv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D821C17E;
	Mon, 17 Feb 2025 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797172; cv=none; b=MV9BY1m9syv/fPD227jxSTuFa9XlzKXWNFLjSNfE4l7VDw6xSGHIngupJ9aeN+dbXGrfNkVL29R7klKBHChkIAbdX36pY3DwU+7FTcV+Gc/QDQlIO234o2oQSR8fw/mZ3Qqm68VGvo6dVGJp1zAw6v4DX/HXvkxy9Ay8C6eAIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797172; c=relaxed/simple;
	bh=w4qUqGu+pnae/CodpYx0ogkuKuGj2dZyD24Fd0C1thM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qePrcFIU5gHLBhenAvU5p/XKERszJshwNerTxpfN04sVIorVHJmY7LoQd/Kfrl+HzQ7lTTGQA+JUGPWiU+NUNnFeIf9kPOy5+WMRuR7mxSOohOaW/dKoLOZIpw+D0F3UeY/ZfsxxfupA7V+OCzwUebPBY3XHMV8HWh8Bm1113fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qjVZpAJv; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HA0AP7030330;
	Mon, 17 Feb 2025 07:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=NDHtPjXfrkrLO78RC509HQt7UeV
	gB+a/yBdbiL+s/rU=; b=qjVZpAJv8d5dy02jovx0OawjPSnJXSB9JuKlOEBw5Tc
	Y58WFUGAe9cRvutXeU2+yNvmVLhew/KDnNCYf+kksShsdUpYZyQl61cFy5hhB+N3
	2R5W4lJR68gV4vf/ZVp6FVjhhy12ysL0r4q+3rSKBCvjUtgWJvRqnnCh5umIjccs
	L2QexyeTXRbWT/8tK3/yBH4cOgPGV0k3emTZvGjY1Bt7ZU4+S6ryKGqoeBB3LohY
	/3Dj8o7KNr6Woh9zKwUP+lXRRL02nRHZgDqnK/hlP0aJKZ+nuBAzrlWtGjhfszP1
	hslswiNAXmnJr6v03brxeZDxJTIw9osXW9A940wbixQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44v2ysrkub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 07:59:15 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51HCxEp4012185
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Feb 2025 07:59:14 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 17 Feb 2025 07:59:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 17 Feb 2025 07:59:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 17 Feb 2025 07:59:14 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51HCx3Eq018359;
	Mon, 17 Feb 2025 07:59:05 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Robert Budai <robert.budai@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [RESEND PATCH v8 0/6] Add support for ADIS16550
Date: Mon, 17 Feb 2025 12:57:44 +0200
Message-ID: <20250217105753.605465-1-robert.budai@analog.com>
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
X-Proofpoint-GUID: USUwmwpAzYaJI1JtDR4r62nDSNRUELh1
X-Proofpoint-ORIG-GUID: USUwmwpAzYaJI1JtDR4r62nDSNRUELh1
X-Authority-Analysis: v=2.4 cv=ELj800ZC c=1 sm=1 tr=0 ts=67b332a3 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=TpNKFGk_wJGFTPuD7poA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=1 clxscore=1015 bulkscore=1 phishscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170113

The ADIS16550 is a complete inertial system that includes a triaxis gyroscope
and a triaxis accelerometer. Each inertial sensor in the ADIS16550 combines
industry leading MEMS only technology with signal conditioning that optimizes
dynamic performance. The factory calibration characterizes each sensor for
sensitivity, bias, and alignment. As a result, each sensor has its own dynamic
compensation formulas that provide accurate sensor measurements.

Robert Budai (6):
  iio: imu: adis: Add custom ops struct
  iio: imu: adis: Add reset to custom ops
  iio: imu: adis: Add DIAG_STAT register
  dt-bindings: iio: Add adis16550 bindings
  iio: imu: adis16550: add adis16550 support
  docs: iio: add documentation for adis16550 driver

 .../bindings/iio/imu/adi,adis16550.yaml       |   74 ++
 Documentation/iio/adis16550.rst               |  376 ++++++
 Documentation/iio/index.rst                   |    1 +
 MAINTAINERS                                   |   10 +
 drivers/iio/imu/Kconfig                       |   13 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/adis.c                        |   35 +-
 drivers/iio/imu/adis16550.c                   | 1149 +++++++++++++++++
 include/linux/iio/imu/adis.h                  |   34 +-
 9 files changed, 1680 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
 create mode 100644 Documentation/iio/adis16550.rst
 create mode 100644 drivers/iio/imu/adis16550.c

-- 
2.34.1


