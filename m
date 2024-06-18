Return-Path: <linux-iio+bounces-6478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0981E90D2C3
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F681F242B4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974914B95B;
	Tue, 18 Jun 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EhZKGFs8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69C13AD0F
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717331; cv=none; b=iANy59jQwhBm6+i3WRXSot7BBMoA779/aJBFkK6ujjWRGKdi6bLdcu51lnpEn6lhYGFw47izZqB5rUuuelkgnsCrwXLlFaZ5gY/GD+ewCQu7G/8t4Yz27ucj+oNquNIiLC3nYTs0IiHWN+ZEMSLRmitniwOennz02txFHrQZfJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717331; c=relaxed/simple;
	bh=sz7muEiHocZnG0HtwFydePV1iRo8mJ8rOC7/V2DlN60=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=A9MpLmJYBSjuwLAdKQdnRtv1bfuq8ur/5oJTvO5sT+Qxb9vTjSpaCmHfMh1/2DYPnBKagckYaf1ZMlB046+RbDto9K0RHcYr4K58q9XqRKKy+sgBCUw4KQ0/9xEAWR3qEPNln4MbGbF8FA8REaAyGLD8D/WqApfJnDrAjBNNriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EhZKGFs8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IC3voL003805;
	Tue, 18 Jun 2024 09:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=SNWBflz9Kbj201XL0qXnQhfvvy+
	bLQ2cWk4YGYiORC8=; b=EhZKGFs80lRh6rNdpDee/0TMqW5guEBSxUcRqAA7I54
	1sWh6wIM5BK/vA9neFK6eJM8vfDe7uuu5jju+Bi6KTXcIQxCurdTncNDs6eWwCwQ
	BdOKFXH09HOggYcyCaWPf5Oo0DPju3urYFPkPD7+t/4hewaoL8VGpNeKa7mtZ8e6
	htTiRE60kQe/cpMq+VFnsTD+Vkuz6eK9c2RBYVDCYDAi4g2H2EUJE7DBcAx8leyb
	TauKKTfEb0KCT2qtb+W4us0J3y4t+FrMlg/xnuaohDgUK6cIQWKtseO2PIxIldKc
	dn0jyazbHpu8Tig0a8k7FiYHFgtPSAkjzuXfmKub05g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yu9wtgb1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:28:35 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45IDSYV1023607
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 09:28:34 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 09:28:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 09:28:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 09:28:33 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45IDSLWK025769;
	Tue, 18 Jun 2024 09:28:24 -0400
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH 0/9] iio: imu: adis: make use the cleanup.h magic
Date: Tue, 18 Jun 2024 15:32:03 +0200
Message-ID: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFSMcWYC/x3MTQqAIBBA4avErBvQfiy6SrSwZqyBsFCSILp70
 vJbvPdA5CAcYSgeCJwkyuEzdFnAslm/MgplQ6WqRhndI3FCkQMtScRlZ+uvE2fTdtoROdY15PQ
 M7OT+t+P0vh9BUbccZgAAAA==
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718717531; l=1598;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=sz7muEiHocZnG0HtwFydePV1iRo8mJ8rOC7/V2DlN60=;
 b=gOG/nqtc3ygbZWXH0mhiVcNyaXnfj+7UOEkO17TT60lAVQqg/TFw6ILbrRACVX6lqqIHDJiUo
 O9hrwf54zZvDI6KUZCb32Vb0+dJ6R8ZVpbWIHivEbc0TGkRm0fsBGfV
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 5vruMRtq9_0c7nomoTVryly7dbW6Xsvm
X-Proofpoint-GUID: 5vruMRtq9_0c7nomoTVryly7dbW6Xsvm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=511 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180100

This is a simple series for moving the adis library into using the
cleanup.h based locks.

It also introduces new helpers (a normal and a scoped lock) for grabbing
the adis device lock using the automatic cleanup guards. In the end
(after updating all users) these new helpers fully replace the legacy
adis_dev_lock() and adis_dev_unlock(). 

---
Nuno Sa (9):
      iio: imu: adis_buffer: split trigger handling
      iio: imu: adis: move to the cleanup magic
      iio: imu: adis: add cleanup based lock helpers
      iio: gyro: adis16260: make use of the new lock helpers
      iio: gyro: adis16260: make use of the new lock helpers
      iio: imu: adis16400: make use of the new lock helpers
      iio: imu: adis16480: make use of the new lock helpers
      iio: imu: adis16475: make use of the new lock helpers
      iio: imu: adis: remove legacy lock helpers

 drivers/iio/gyro/adis16136.c  | 26 ++++++----------
 drivers/iio/gyro/adis16260.c  | 19 +++++-------
 drivers/iio/imu/adis.c        | 11 +++----
 drivers/iio/imu/adis16400.c   | 72 +++++++++++++++++++++----------------------
 drivers/iio/imu/adis16475.c   | 43 +++++++++-----------------
 drivers/iio/imu/adis16480.c   | 65 +++++++++++++++-----------------------
 drivers/iio/imu/adis_buffer.c | 52 ++++++++++++++++---------------
 include/linux/iio/imu/adis.h  | 66 ++++++++++-----------------------------
 8 files changed, 138 insertions(+), 216 deletions(-)
---
base-commit: cc1ce839526a65620778617da0b022bd88e8a139
change-id: 20240618-dev-iio-adis-cleanup-b6571fddfe13
--

Thanks!
- Nuno Sá


