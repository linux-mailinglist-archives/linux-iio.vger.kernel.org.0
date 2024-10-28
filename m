Return-Path: <linux-iio+bounces-11455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D819B3020
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F5028128B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 12:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88311D90C9;
	Mon, 28 Oct 2024 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CFzMFMAJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C717C61;
	Mon, 28 Oct 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118404; cv=none; b=VVlx5xshWzG0I8xSI4EFLCtur5tzfvhk5Nq9gBRYnxMhOxfUIs6CYNZTT7opFGbL8OulbwFGBSY6KE1H6NKRBfsq/X7TQWqJf0WFlKbGpKg7FoBvTv5MCud/OxdW2bHgZyYnEoPVMeNB6EElO70xrR6IAJKg1EfHwLu9CHqLGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118404; c=relaxed/simple;
	bh=rMSa2GblHCzLvcvkl4pyYdF3B9UzPJexGxowAWH/Rfg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uCM3bsVtrOB9ikr1ExWWuICRu0FRNKv/ZB/dPIqNwjdFypZaMl1At5FL5W40chWr2122F50Ku+k+idHJv97IKp64his0hj205LG/eGMZDhq7aIBDyddZujaIvsFv/pXT/K+eHJtsDzYZdFqU5V3pNHsPUFJqRq/42eU9gi78ZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CFzMFMAJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SB3aeB027558;
	Mon, 28 Oct 2024 08:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=B2yzXic/ytcByJ2vquRJuUQRg1/
	c6Qn9AbDplfhz4Q0=; b=CFzMFMAJhonGDRJuZ8aMKm9qmgak6cXXGqSEJ4m4juB
	JVzs/SRLXZalv6STli3h5715InjyRIeb2pZferxipv/0bhjNOGEPSffCEOWZtLbw
	NpPIDqWziM4nDm+zcpkSlfQTEyHFTaXZI78A4UKOUW96smlaY4UFwiZf/txcDOtB
	0wbT7oGEZBNT2pmRLYC3DNoNgSY5s6jrq8A77LpKsaal/QAeTpXQRr77TO8Gcxaz
	iRYudEHYfYoCRKEXlxzfTk3i6OxYTzFXqrpdAbdmkmzOv+pzE4OawjGiAfnMPZHS
	ARwu5y8/jsETjfSE6a6/s6K2X95avjcGYNfg5UQ1moA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42gt92reva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 08:26:15 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 49SCQEnJ024341
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Oct 2024 08:26:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 28 Oct
 2024 08:26:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Oct 2024 08:26:14 -0400
Received: from dell-precision-robert.ad.analog.com ([10.48.65.123])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49SCQ0aK026080;
	Mon, 28 Oct 2024 08:26:02 -0400
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Ramona
 Gradinariu <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jagath Jog J
	<jagathjog1996@gmail.com>,
        Robert Budai <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <robi_budai@yahoo.com>
Subject: [PATCH 0/5] Add support for ADIS16550 and ADIS16550W
Date: Mon, 28 Oct 2024 14:25:32 +0200
Message-ID: <20241028122543.8078-1-robert.budai@analog.com>
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
X-Proofpoint-GUID: 84cTicoNzj_1Vyn_LX_pcCrvYCq6x8Cl
X-Proofpoint-ORIG-GUID: 84cTicoNzj_1Vyn_LX_pcCrvYCq6x8Cl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280100

The ADIS16550 is a complete inertial system that includes a triaxis gyroscope
and a triaxis accelerometer. Each inertial sensor in the ADIS16550 combines
industry leading MEMS only technology with signal conditioning that optimizes
dynamic performance. The factory calibration characterizes each sensor for
sensitivity, bias, and alignment. As a result, each sensor has its own dynamic
compensation formulas that provide accurate sensor measurements.

Nuno Sá (3):
  iio: imu: adis: Add custom ops struct
  iio: imu: adis: Add DIAG_STAT register size
  iio: imu: adis16550: add adis16550 support

Ramona Gradinariu (2):
  dt-bindings: iio: Add adis16550 bindings
  docs: iio: add documentation for adis16550 driver

 .../bindings/iio/imu/adi,adis16550.yaml       |   95 ++
 Documentation/iio/adis16550.rst               |  389 ++++++
 Documentation/iio/index.rst                   |    1 +
 MAINTAINERS                                   |   10 +
 drivers/iio/imu/Kconfig                       |   13 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/adis.c                        |   33 +-
 drivers/iio/imu/adis16550.c                   | 1228 +++++++++++++++++
 include/linux/iio/imu/adis.h                  |   33 +-
 9 files changed, 1788 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
 create mode 100644 Documentation/iio/adis16550.rst
 create mode 100644 drivers/iio/imu/adis16550.c

-- 
2.34.1


