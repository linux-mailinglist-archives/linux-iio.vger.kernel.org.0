Return-Path: <linux-iio+bounces-14686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0727A218D9
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 09:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BAD3A5E27
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 08:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B081D19CD1D;
	Wed, 29 Jan 2025 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pjBYYnsz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1422911713;
	Wed, 29 Jan 2025 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138892; cv=none; b=N1VwezlkYOX1oo8m+AYJuToAHCD+ZhLvcYHTn9JYfwOqttHpDXMgKQsJ0kednlbJ1vw2JZR0QpzsjhCsMt7YtyqabrBmjtnjqOD5RmXEX1poD35SCXL1veXKQEZGoh77OkvHUtLiXspcAxixVsKZHqxInJTSLoObI0CK6bKrZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138892; c=relaxed/simple;
	bh=Ken+uZ/t5YexFja91w7Oo46S4hnD1GZlSEbhLAEKeAA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RaKnp0IwCtBc7qmOj06IvITSvvlif/RASXSN086D9wQjunrYz0/iRa1Po1orK7bxdTc77Ellozr6fx3Q+OFlJ5ocpWGM9Pq8penoFm/iYXJRp+mocqi5Ke/11pO62QpDI8OLx7JAsbpuU1mbRUFIjpPQJvoN19JdDX2DveVxO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pjBYYnsz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T5nLgU004116;
	Wed, 29 Jan 2025 03:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=AA2cuBi7WabAVEbPnfPRDcjkiFZ
	yO2weZBGTATd6qNo=; b=pjBYYnsz74M9kH9nhUKKJJQdJ9oFiHkhghTv5Fpyvuj
	Y6gsiK2mJss0fiFGoJmpma+gviUTwgvEzxA4XPbDmDArDRcDEWXltKJn7DfeymPn
	UBMeJ5XMV30rVjl3HPLaC74NuBqFELKuTOu3uw1DZ9tgYWurItVTCY9CLSTGxM2g
	3ltvd817STVxTnL8UDggJI6qzuMcv62QfZ7r3meRY7BcziHSJUCebgsKv68ofcpb
	LYgF6uNH43Z7KZGeWa+vdO6xZTvbpzjLwTHUK5qXetvF8EthY8E1RYBsJAPziTbv
	l1tkick4tAiMHn4bz/1/s13T0A5kXD0KWidtVTDRo/w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44feh7ge8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 03:21:12 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50T8LBhK028231
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Jan 2025 03:21:11 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 29 Jan 2025 03:21:11 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 29 Jan 2025 03:21:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 29 Jan 2025 03:21:10 -0500
Received: from robi-Precision-5540.ad.analog.com ([10.48.65.150])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50T8KtHG025874;
	Wed, 29 Jan 2025 03:20:58 -0500
From: Robert Budai <robert.budai@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <ramona.gradinariu@analog.com>, <antoniu.miclaus@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <lanzano.alex@gmail.com>,
        <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v5 0/6] Add support for ADIS16550 and ADIS16550W 
Date: Wed, 29 Jan 2025 10:20:40 +0200
Message-ID: <20250129082053.19077-1-robert.budai@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: EIjPALIGHBoeSMIQiaDhgW29mmf9fTfv
X-Proofpoint-ORIG-GUID: EIjPALIGHBoeSMIQiaDhgW29mmf9fTfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290067

Add support for ADIS16550 and ADIS16550W 

Robert Budai (6):
  iio: imu: adis: Add custom ops struct
  iio: imu: adis: Add reset to custom ops
  iio: imu: adis: Add DIAG_STAT register size
  dt-bindings: iio: Add adis16550 bindings
  iio: imu: adis16550: add adis16550 support
  docs: iio: add documentation for adis16550 driver

 .../bindings/iio/imu/adi,adis16550.yaml       |   80 ++
 Documentation/iio/adis16550.rst               |  378 ++++++
 Documentation/iio/index.rst                   |    1 +
 MAINTAINERS                                   |    9 +
 drivers/iio/imu/Kconfig                       |   13 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/adis.c                        |   31 +-
 drivers/iio/imu/adis16550.c                   | 1182 +++++++++++++++++
 include/linux/iio/imu/adis.h                  |   34 +-
 9 files changed, 1716 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
 create mode 100644 Documentation/iio/adis16550.rst
 create mode 100644 drivers/iio/imu/adis16550.c

-- 
2.43.0


