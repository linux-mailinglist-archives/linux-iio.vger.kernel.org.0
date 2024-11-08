Return-Path: <linux-iio+bounces-12033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441539C1D43
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 13:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A6F286093
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 12:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331EB1E909E;
	Fri,  8 Nov 2024 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Pr+dLgOJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877DA1E572F;
	Fri,  8 Nov 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069893; cv=none; b=Fh2eOkOaPgW87j332eTzmDAbFsFjy494Pe1jAT0qfMKB0huyttuoaiporDgSr3ZrOtl4Nfgtj2GYkuMfW8IILlwsVr5ihyL9/BE6zJx/BQ8Bzs93W7oKrFsDm3m2pkOQa5xLu+lO939XwkTtUOTwNCr2HC3FGV2LaHBHDj2nrA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069893; c=relaxed/simple;
	bh=fMAs/dLeRF3yNNq2BxZZKriRjKvdO4aQdPryUzbHMcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqG9wF2+Z/0oRWhgZzsYLHTrOSuum8w4uLo0QZF33JiKgmRRnLBi5xbVBz3ILYqhMCYGaRv71LQSrrPPhFMEGHhDE0zqIL2NULGbCv/yCVxFTehO6jDw10gHJj581katFxVaiG5/FdZOqGURtRXLLczlz1E7XeCxQ5qupooKeqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Pr+dLgOJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A89pHib018402;
	Fri, 8 Nov 2024 07:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FQC8k
	YwEFbuxm+sYIQtO2eVJbQF6NGv6XDLTzJIFrZc=; b=Pr+dLgOJ9p6bCD5aoe/Xd
	FYUUK381qFp8qia4A17CUM7cxWeHwn02sQkgO8INmfTqcljRjn1FNWop+n4iH6gN
	/17ROVUpnQQ1Uj1i2BkA8Ih/x4bjzbMTbWZzesxfibKCjmtGfo9Dmud4dv3p5A5m
	LFJuAR9Nno4tF0EAUj3tdB2YPuUBo3YeX85OMJ8T7xfUh9Mh3jcAA+DFZxEO5bCm
	7oOWTJL+ApFuQmT4F8dmS0zV21PDyY/hsJGqzeVtV4E8ljnvTgdy9zLiDDeFJeAc
	zHKxjrjLZEumAt4uyIFncpcx5+PnEi9fUqoh5a4qJGmPogYfLR1+KbriERFCjsW+
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42s6g7k74a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 07:44:38 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4A8CibeJ020354
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Nov 2024 07:44:37 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 8 Nov 2024
 07:44:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 8 Nov 2024 07:44:37 -0500
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A8CiNcZ003412;
	Fri, 8 Nov 2024 07:44:33 -0500
From: Darius Berghe <darius.berghe@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>,
        <alexandru.tachici@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <darius.berghe@analog.com>
Subject: [PATCH v3 2/3] iio: imu: adis16480: add devices to adis16480 - docs
Date: Fri, 8 Nov 2024 14:58:13 +0200
Message-ID: <20241108125814.3097213-3-darius.berghe@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108125814.3097213-1-darius.berghe@analog.com>
References: <20241108125814.3097213-1-darius.berghe@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8hSjOgvx3aW03TvBhYmEzjfCmX8OHN5R
X-Proofpoint-GUID: 8hSjOgvx3aW03TvBhYmEzjfCmX8OHN5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=832 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080106

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
index bc78fa04d958..4a2d40e0daa7 100644
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


