Return-Path: <linux-iio+bounces-11985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E419C078F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 14:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90FB1C22A0D
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1895213157;
	Thu,  7 Nov 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ek4mNUIB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F6621263A;
	Thu,  7 Nov 2024 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986307; cv=none; b=Zw2SDbI1JN6S0ucX1/LoV8O3tCW+PSFODIK/YyO9v2FsHu48QDTnI491VuhAeoyjrB5peKAkzOqUMLJlcojuzKx7tQVc0gGTm5KrlN2iwP0tY1JrZczl8cdMvQ1ob7p/OvFkiEzUqOsoiJ8hH1G04+hPhKU0Ne2VBaC/prm6I6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986307; c=relaxed/simple;
	bh=7RcmknNizBGYEvqEUZCPn1ytaYLZrWJJwLynPUvSbsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuBe2uFjwoyNeQDWJwAhmh94GDJ+If0KqjAKY0R39sFrEstzcpxXMp8yxbN+kx3m+zpdz2la/MoBtQ+XTUAnWYSwL0QJ3DSEK6wVj/vvXdQXfIUBQmLCpFcl6n81kQ7prmb5XzNZvUztZ3ocBQGXSTPty4J7O/ngFSHE4KjLNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ek4mNUIB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7C2g4p019664;
	Thu, 7 Nov 2024 08:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Lo189
	eDGt7DfOZHesYIjQu3tJSwVIv+nnPGdgw5Vpmc=; b=ek4mNUIBt7JMrv9nhXAdJ
	q4azQaI4/uQXsfSxTBGs7KeVW7a5nTI67QhvsmtsUCfUZX4wZTuk4a0FHq+CxjmS
	Zn8fnBDSuepTyLE+2DPdCXR+dcY1+edbTqFn9OAu3cKW7xfPAw4Ku80jIET5EDRD
	yYk9Nq/u7ueRb4sWIaRPDGlfPBoJW0+dr8+dIkpinaO5LeyfjXoSj8UJGFUmai8G
	wglAZzoMbBZZ6wcu5/s07xNSahygB74laKIGFJ64BTmuaSHESm9Fpwzb5rb8fMWC
	/WZYe7CMrEBS+F8Emiy1A66P9r/JA+Q0aYxBJy6D0etNHPHiEV8VTIeYTWNNZHA+
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42qbq3d4q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:31:43 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4A7DVgRA032066
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 08:31:42 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Nov 2024 08:31:42 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Nov 2024 08:31:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Nov 2024 08:31:41 -0500
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A7DVUGs019172;
	Thu, 7 Nov 2024 08:31:36 -0500
From: Darius Berghe <darius.berghe@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <darius.berghe@analog.com>
Subject: [PATCH v2 2/3] iio: imu: adis16480: add devices to adis16480 - docs
Date: Thu, 7 Nov 2024 15:45:16 +0200
Message-ID: <20241107134517.3089112-3-darius.berghe@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107134517.3089112-1-darius.berghe@analog.com>
References: <20241107134517.3089112-1-darius.berghe@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: rGP80wuYfa27GL1Ha6OsnxIDPar-Sxo0
X-Proofpoint-GUID: rGP80wuYfa27GL1Ha6OsnxIDPar-Sxo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=787 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070105

Add datasheet links for adis16486, adis16487 and adis16489
Six Degrees of Freedom Inertial Sensors into the existing
adis16480 driver documentation.

adis16486 is similar to adis16485, has the exact same channels
but acceleration and delta velocity scales are different.

adis16487 is fallback compatible with adis16485.

adis16489 is similar to adis16488 but lacks the magnetometer
and has a different accelerometer scale.

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


