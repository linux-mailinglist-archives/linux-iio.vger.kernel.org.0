Return-Path: <linux-iio+bounces-13540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FE39F338A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 15:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77DF1639C6
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0CC6F2F2;
	Mon, 16 Dec 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tvFhrWLE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A83CF73;
	Mon, 16 Dec 2024 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360555; cv=none; b=FMr8zwDLtKD4ytabh8dnh9UxpRPext9B3n/77qN5uyg9E3pG4+ZQD16/DtZg26jEGeygY1HEKVPRHmoQ6joyWG0HGJ0OXX0eq606Hf++XWFVhSk/k0LLgFjS/0ViFFGTEX+ZGTwwKDUZziWUSXdTG4Hm9p+8hbbY+dLazn92BzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360555; c=relaxed/simple;
	bh=M6x/dmJyujjiAqmDTB/v+Z+hKkmew9jaemnUaNujI6I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pJyqMkXsGNsG22aNWTy+nX9CXYRrZXdC7iO4C8AFBy0pFB0d2p72B+PGrCkzw4Cjb8OFFKZqmPobh2Hi9kOfXSy8n6MX0FKiiQ+r55/ZjHUn0d7SEdbDFFFJ4/uv/Wqbfgm+wd+r39aMT8orsNkVLemrT6sxlizb4hascE0fQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tvFhrWLE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9pqDu018599;
	Mon, 16 Dec 2024 09:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=EM7eE0k/xTE5NWvn4wZRjyPhWac
	wWivbf9LPtEUdvIk=; b=tvFhrWLEYLqdyn64yqRmcy4BUY7laA4P+Ng/lQZBag+
	RIX1STF5zcaX0fZgcssVqZvnEQe89wqqNZEcyQfw4U8xzAlnZ3Vc/gKAGHpKDDBI
	VHhhfXPjvi6u8jExjN3+l66iylnVc34pw/xayr4QDgVkLxPLiBn4zGxfAbD6rUud
	zIYtcsA1BWBhvJn1/DV30iM2tyDq+78A0SDzMjzpZdcnr8k8yfhCgW6Y4J7VEO+g
	+0OxjDnWKr66Kjrsgp32Pm1H0ZihL+FV3bk0F2wgLAzcioVSQr6YJVzrg/FlolwT
	m/X0YsV2ewD1dc76hJH90KvRNqfa+Dh8ucZSuRJdJYA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43jhxvh1cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:48:44 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4BGEmha5035919
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Dec 2024 09:48:43 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 16 Dec 2024 09:48:43 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 16 Dec 2024 09:48:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 16 Dec 2024 09:48:43 -0500
Received: from dell-precision-robert.ad.analog.com ([10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BGEmKdh018405;
	Mon, 16 Dec 2024 09:48:22 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alex Lanzano
	<lanzano.alex@gmail.com>,
        Shen Jianping <Jianping.Shen@de.bosch.com>,
        "Robert
 Budai" <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <robi_budai@yahoo.com>
Subject: [PATCH v3 0/7] Add support for ADIS16550 and ADIS16550W
Date: Mon, 16 Dec 2024 16:48:06 +0200
Message-ID: <20241216144818.25344-1-robert.budai@analog.com>
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
X-Proofpoint-GUID: fKANPEYgcOKg_NrGpaTClTsKQ8tafU0T
X-Proofpoint-ORIG-GUID: fKANPEYgcOKg_NrGpaTClTsKQ8tafU0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412160124

Add support for ADIS16550 and ADIS16550W

Robert Budai (7):
  iio: imu: adis: Remove documented not used elements
  iio: imu: adis: Add custom ops struct
  iio: imu: adis: Add reset to custom ops
  iio: imu: adis: Add DIAG_STAT register size
  dt-bindings: iio: Add adis16550 bindings
  iio: imu: adis16550: add adis16550 support
  docs: iio: add documentation for adis16550 driver

 .../bindings/iio/imu/adi,adis16550.yaml       |   93 ++
 Documentation/iio/adis16550.rst               |  389 ++++++
 Documentation/iio/index.rst                   |    1 +
 MAINTAINERS                                   |    9 +
 drivers/iio/imu/Kconfig                       |   13 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/adis.c                        |   30 +-
 drivers/iio/imu/adis16550.c                   | 1222 +++++++++++++++++
 include/linux/iio/imu/adis.h                  |   34 +-
 9 files changed, 1777 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
 create mode 100644 Documentation/iio/adis16550.rst
 create mode 100644 drivers/iio/imu/adis16550.c

-- 
2.34.1


