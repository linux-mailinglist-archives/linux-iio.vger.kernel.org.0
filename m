Return-Path: <linux-iio+bounces-15637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB5A382A6
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 13:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F13B3AAC1D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C0A21A425;
	Mon, 17 Feb 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zosBcGvf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933BD2185A8;
	Mon, 17 Feb 2025 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794446; cv=none; b=kVN9AfpO+CkcIJyMuhsWjNqjrCLUC0LGvVBr9DYuFU6XuBby8X1wUvATYEehDizf8bISA9beiDZI6TcdZuR930VabyV0LY+/FbJD2zdVtvwyiVd3ks918k0z6Va47MQNbLMGA01aruoFrycvB+US0JYvJ6LQiHiveaJL/dPjW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794446; c=relaxed/simple;
	bh=HBsy5RTo5q+NJaeKSFcGgHYgGChfcYKkWDMlY/qvf1w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V3QpFP2kSoN8Jvl+Lberye2FnT1WIprQz71a5pC5/nKDfJAz10iNxX15Uo9uR0ooFIGfFFusYFq7aQ7J3zNMiJu15g6KHe2JlAe73NrdZsqaHSpMVLwt5ZVm3lGZBFpdu4T6burLTutRuAFtt9pR6w/nS7LiJXDz/NpcPkzm/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zosBcGvf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HA0CYV030466;
	Mon, 17 Feb 2025 07:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=xZQbkymXR6jaKSMYeUzs3gXZo8/
	3BkzsN2CDrGajyBw=; b=zosBcGvf5FoBcBUu3YCuAElvjfZ5VJMe4wE20pkEnVr
	RLLgn5PqA1ExLeKSJpVgRd3whtfs2DpuwVxJtWfXLvIUUieKl1VNSQj8+WWpCfPC
	6rzoLcWZG1CGLPMhpGj9FJji0gr4fksoy7OoJ2nbnY1Mi1xEkVmS6Gu4YtKqT6Ox
	GYmCvD2mlSoxHu3Tapm0nVfBB23CBtAlS46vw4LcL/8gCmWioIuKlHn0YEm4PuOG
	XUiMdnAFhjmszGmbhlxESLDSpi1YQhTK9mAoALv+lw0TXAfemsrklmoCyTr2Rlmp
	YtMe8pepVGoaPjfxcYD9Pb5EipGVDi2vpEm2EA2dE4A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44v2ysrffx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 07:13:49 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51HCDmHB010512
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Feb 2025 07:13:48 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 17 Feb 2025 07:13:48 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 17 Feb 2025 07:13:48 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 17 Feb 2025 07:13:48 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51HCDZMO016764;
	Mon, 17 Feb 2025 07:13:37 -0500
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
Subject: [PATCH v8 0/6] Add support for ADIS16550
Date: Mon, 17 Feb 2025 12:12:13 +0200
Message-ID: <20250217101221.600898-1-robert.budai@analog.com>
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
X-Proofpoint-GUID: bl9QxCyc62VrUsqekd_H_lWbcXZtVGjj
X-Proofpoint-ORIG-GUID: bl9QxCyc62VrUsqekd_H_lWbcXZtVGjj
X-Authority-Analysis: v=2.4 cv=ELj800ZC c=1 sm=1 tr=0 ts=67b327fd cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=TpNKFGk_wJGFTPuD7poA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=1 clxscore=1015 bulkscore=1 phishscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170107

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


