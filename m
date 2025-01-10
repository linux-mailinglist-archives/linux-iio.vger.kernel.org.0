Return-Path: <linux-iio+bounces-14069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7556DA0893B
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 08:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F12169562
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98723207675;
	Fri, 10 Jan 2025 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DFCSwCio"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EED206F1B;
	Fri, 10 Jan 2025 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736495010; cv=none; b=iNc0ENLBwxm6JOeVOCCpMJ3CzW0EX/AQi7LOYtfLvWseR/W2eS/ME9aFTMg/lr470uQwRsdHEb9LBv+l6Fl2CFW2a6Gw3G0RuYZgtEZtheuxT9F5cp5N7ZjPXn7XI0d32nM7wUL4PBMptFhbXZgmCKLUWstVM1wCOKtL3f6jcLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736495010; c=relaxed/simple;
	bh=7N0olu4BlMRguZ5wloHWkhC+2NeWyOGqmceCcv0hPUY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lhN7x9KHqGzXO4rn3VK7eqALY9Unbsg48AaoEVEmW92FjiXhcKvxBm58nMtJCAjvA4xJbC3C8YWTYken8PXqMi8U1en6l7E8u/hLqKI5VUmN/8ffdigM7y++AViY44yGPbmxtMz4DtDXf2RfFlHecY6Kb+edu+nqjVnuo5PW9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DFCSwCio; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A6LCD3001985;
	Fri, 10 Jan 2025 02:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=cwERC/HaSv5cWLlyrMkI/z2Ygoq
	6SWAxVZxBwsI3Sos=; b=DFCSwCioGZ7B/Fx7kJ3+ZKF6zr/KGphJI4rHwOz3kWT
	VHSmpNTiutuLdEtkHpszN1zviuM5Os5V12KFbGJGZc1rlZ4WMMRb/MbOtGowC64I
	l+TcsnIrayADCZ8lWOPnFGGfMj/BfFqA2UMZ0OMBj3YWN5Vg8QwGqnGkAbpNG2RY
	lVSHpCvuPLIeOFomcfnRStKpDFORYTO6mLfqaIouQorJsHWbBEBBkC1WkbgR8j3Q
	nZCYqlrooTkmIByYnw5kLpJ++JbQ6yYdXxC+8rmxIp6hGsKTOmwJYXWPsVYdvKkW
	/oRJP7jREXl1VaXAhasZ6UVGRFyO88SfzlAAXnRRqOg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 442mavam1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 02:43:11 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50A7hAwc051810
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 Jan 2025 02:43:10 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 10 Jan
 2025 02:43:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 Jan 2025 02:43:10 -0500
Received: from dell-precision-robert.ad.analog.com ([10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50A7gvop032122;
	Fri, 10 Jan 2025 02:42:59 -0500
From: Robert Budai <robert.budai@analog.com>
To: Nuno Sa <nuno.sa@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Robert Budai
	<robert.budai@analog.com>,
        Alex Lanzano <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v4 0/6] Add support for ADIS16550 and ADIS16550W
Date: Fri, 10 Jan 2025 09:42:48 +0200
Message-ID: <20250110074254.38966-1-robert.budai@analog.com>
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
X-Proofpoint-ORIG-GUID: sI04RTTAfgY72GnptvE2XQzZ7dd_hSji
X-Proofpoint-GUID: sI04RTTAfgY72GnptvE2XQzZ7dd_hSji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100063

Add support for ADIS16550 and ADIS16550W

Robert Budai (6):
  iio: imu: adis: Add custom ops struct
  iio: imu: adis: Add reset to custom ops
  iio: imu: adis: Add DIAG_STAT register size
  dt-bindings: iio: Add adis16550 bindings
  iio: imu: adis16550: add adis16550 support
  docs: iio: add documentation for adis16550 driver

 .../bindings/iio/imu/adi,adis16550.yaml       |   96 ++
 Documentation/iio/adis16550.rst               |  378 ++++++
 Documentation/iio/index.rst                   |    1 +
 MAINTAINERS                                   |    9 +
 drivers/iio/imu/Kconfig                       |   13 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/adis.c                        |   30 +-
 drivers/iio/imu/adis16550.c                   | 1202 +++++++++++++++++
 include/linux/iio/imu/adis.h                  |   33 +-
 9 files changed, 1749 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
 create mode 100644 Documentation/iio/adis16550.rst
 create mode 100644 drivers/iio/imu/adis16550.c

-- 
2.34.1


