Return-Path: <linux-iio+bounces-11769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D45A9B915A
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 13:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70271F22B5C
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC48B1A00E7;
	Fri,  1 Nov 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ennqS3I8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960619E7F7;
	Fri,  1 Nov 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465638; cv=none; b=GL3o81Pl+jTyRSDhqiGgOs7ebiLoi8E5xDnxY7kQ2Hix0wkALfjA66dt/sn+aNrmDKdEU5yji7fswJTn4rVvkat0FP5nJj3aBdiiQxLv2RwpSihHQr3HWmekWvtRO6djTxM80s+26qUL5NB9QBPVSw4nAkkAIl0281GfEWuR2Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465638; c=relaxed/simple;
	bh=bvWL64nG6pRVSsmiZWcR7RtbaxpstiqBS/uO4aIaJC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgkNXKOtTqoT0eCePOM8JU4OsMvg/r7aIsqYWa5zfxP13e3qMZWB8S7zWP59J3Cjb5qbF91j3bQwClvtWmHDgyJfBTJenE+pMLo8KJVsqZlSMITADGFDBNiS5DCw/V97/ruKtIOxL8HnCdGI58l16xxTDK0nJUVo73PZDDZnAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ennqS3I8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1BNois006063;
	Fri, 1 Nov 2024 08:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cZ5wX
	QQPQLRf4GhrUpAd6l1erdAf9ubmupruBnLvXvE=; b=ennqS3I8Pf4RnY7GOYG0d
	DILx3kXgnE/fkCqoc9HMWMRoCU3R3zMgSPaUhNOgFGaOxcueC+ps67tc2a+t6rAr
	REz6FcG7CjHMlLJk2qd1sxR4YrEBnT++sgqrYTohNkxij2SFMEJOmzHTyKImubWb
	GZmRW8f+lfNKQhTLywMGLG9Jyf9ShfnVRkffO/Wfu6RZdp+Bkq0cMgll7DDZc7EB
	z8XveRzWOyDJbCa9726WyqyGGU2Ttv3aj2OQx7qMuKMaPn6vqjzQm+kIvOGMljOC
	ZLTs+Ui/PrJhRbitGDeUZ1maW70+h5AmVybCHZz7Gnokg2wrcWkZsQnKNWODK+A/
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42k6yvf5ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 08:53:53 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4A1Crqk4020286
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Nov 2024 08:53:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 1 Nov 2024
 08:53:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 1 Nov 2024 08:53:52 -0400
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A1CrflB029504;
	Fri, 1 Nov 2024 08:53:47 -0400
From: Darius Berghe <darius.berghe@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <darius.berghe@analog.com>
Subject: [PATCH 2/3] iio: imu: adis16480: add devices to adis16480 - docs
Date: Fri, 1 Nov 2024 15:07:41 +0200
Message-ID: <20241101130742.3479110-2-darius.berghe@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101130742.3479110-1-darius.berghe@analog.com>
References: <20241101130742.3479110-1-darius.berghe@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: u4miibULsq8PqLDb6E3Y3NAS2Z33XVHB
X-Proofpoint-GUID: u4miibULsq8PqLDb6E3Y3NAS2Z33XVHB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=683
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010093

Add datasheet links for adis16486, adis16487 and adis16489
Six Degrees of Freedom Inertial Sensors into the existing
adis16480 driver documentation. The adis16487 is functionally
equivalent to the already supported adis16485. The others have
slight differences in terms of channels and scales with the
already supported devices.

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 Documentation/iio/adis16480.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/iio/adis16480.rst b/Documentation/iio/adis16480.rst
index e3cc64ddc8f6..d911131c613c 100644
--- a/Documentation/iio/adis16480.rst
+++ b/Documentation/iio/adis16480.rst
@@ -12,7 +12,10 @@ This driver supports Analog Device's IMUs on SPI bus.
 * `ADIS16375 <https://www.analog.com/ADIS16375>`_
 * `ADIS16480 <https://www.analog.com/ADIS16480>`_
 * `ADIS16485 <https://www.analog.com/ADIS16485>`_
+* `ADIS16486 <https://www.analog.com/ADIS16486>`_
+* `ADIS16487 <https://www.analog.com/ADIS16487>`_
 * `ADIS16488 <https://www.analog.com/ADIS16488>`_
+* `ADIS16489 <https://www.analog.com/ADIS16489>`_
 * `ADIS16490 <https://www.analog.com/ADIS16490>`_
 * `ADIS16495 <https://www.analog.com/ADIS16495>`_
 * `ADIS16497 <https://www.analog.com/ADIS16497>`_
-- 
2.46.1


