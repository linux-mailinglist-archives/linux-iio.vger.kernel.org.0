Return-Path: <linux-iio+bounces-14982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB404A27747
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 17:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD00188440F
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5F22153F5;
	Tue,  4 Feb 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="J/Dpc3Tx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D520D4F2;
	Tue,  4 Feb 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687085; cv=none; b=CrCJHCjt+xnXO/uNLlVxHva7uMIa3V2Cyg6+Etm14yO2TOwrhusTA92SzpCjlqenXydqPMPzImhbdW0Y2NKU64rA2Gb1JYjA8gnTc7vIaXK3vZ+LceKbgIMieJxwA5LOtNuoxjVTnBXZNTk0EOmSJ+YZIISUbB1jJ0TjblUZF8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687085; c=relaxed/simple;
	bh=iZxr5kI6Nt+9ll2rFIZkKqtFcDCd2+fWpG0a1BXS/s0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jqQq8rSom2FZaQ/YkOhutMkmx/cdEzQ+XVR5lVye6+SPsjTfMBmKCga8UsSRK123xRDDuVek5R/Eub4w32QSPFUqatF37k7PAjApPM3IM8Z6NhzsiZi94Cykkrz87Yh9OVrK3cc2n5hfpMFsZKoe8j9AHY8HQ1EGJz+y/LxHaL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=J/Dpc3Tx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514E1rpR006925;
	Tue, 4 Feb 2025 11:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=f+IaR5QmLrnWJQXIuJGyLQlZrh8
	FtyTOpN7BpgX7PM8=; b=J/Dpc3TxexqZLJJE7BDjgPpnsAVcHMpUY1prckYemMP
	zUKhFOEYmOm0G6g5j28fNxaMafK33mq1Jf647n6jSqgNd9I7EYuATrIR4S8CSSYb
	DpR0eMqwJLkWLzvZXb1pasE1hhpqfP+ZFZSfRc4ZKlR0MeeKJN5nwDvryEGIGvYk
	BvNLcLVM8lI0ZVZYXl9ZBrL8Rscd7IkJb0P7qqNnQmk53PXpN6ldoXWhJirvJXTF
	u/C45fS4Fu2UlZBR9auDR0nxjJtF9Ovj+javIg9AH9+ImQQJY2yacAI/G3pfBk5u
	6mBhTRI5M/VvNal2iCAaQW/rZEZWmOQjMoGMXDlSqqw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44kma3gnsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 11:37:43 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 514GbgGL047803
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Feb 2025 11:37:42 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Feb 2025 11:37:42 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Feb 2025 11:37:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Feb 2025 11:37:42 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 514GbMFF009577;
	Tue, 4 Feb 2025 11:37:24 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Nuno Sa <nuno.sa@analog.com>,
        "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>,
        David Lechner
	<dlechner@baylibre.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        "Trevor Gamblin" <tgamblin@baylibre.com>,
        Paul Cercueil
	<paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Robert
 Budai <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v6 0/6] 	Add support for ADIS16550
Date: Tue, 4 Feb 2025 16:36:04 +0200
Message-ID: <20250204143612.85939-1-robert.budai@analog.com>
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
X-Authority-Analysis: v=2.4 cv=Df7tqutW c=1 sm=1 tr=0 ts=67a24257 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=f1vxr5TaGUlwJKkhg4gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qBxa-k-AL21U-T9CvPeP75Kg5xXf35HO
X-Proofpoint-ORIG-GUID: qBxa-k-AL21U-T9CvPeP75Kg5xXf35HO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1011 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040127

*** BLURB HERE ***

Robert Budai (6):
  iio: imu: adis: Add custom ops struct
  iio: imu: adis: Add reset to custom ops
  iio: imu: adis: Add DIAG_STAT register
  dt-bindings: iio: Add adis16550 bindings
  iio: imu: adis16550: add adis16550 support
  docs: iio: add documentation for adis16550 driver

 .../bindings/iio/imu/adi,adis16550.yaml       |   83 ++
 Documentation/iio/adis16550.rst               |  376 ++++++
 Documentation/iio/index.rst                   |    1 +
 MAINTAINERS                                   |    9 +
 drivers/iio/imu/Kconfig                       |   13 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/adis.c                        |   36 +-
 drivers/iio/imu/adis16550.c                   | 1156 +++++++++++++++++
 include/linux/iio/imu/adis.h                  |   34 +-
 9 files changed, 1696 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
 create mode 100644 Documentation/iio/adis16550.rst
 create mode 100644 drivers/iio/imu/adis16550.c

-- 
2.39.5


