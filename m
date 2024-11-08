Return-Path: <linux-iio+bounces-12034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66999C1D47
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 13:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AB8B25A46
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 12:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA101EABA9;
	Fri,  8 Nov 2024 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1i6/6+SC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6E1EBA07;
	Fri,  8 Nov 2024 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069897; cv=none; b=XCL0Lo/4QVuLZ5NFy5FoDCTDjvIyiwhOZpTvcQEWxpy+esHa2ZRLYxVGx/scDbEe7CENy3ScRlU3eDaV+fK3ar9ZgUrFq4+wBWAsu5uo9lv0svI9V0lEJwSoEobVx6JHTVKb8TGPuNa+Bap6iXrT2B4LGjeUiDw+fxuTgjKBAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069897; c=relaxed/simple;
	bh=U+67OIQ2c58e/Bd+/4wKWvkI8Xjg4EknaZc7K+ctL9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pl5WwDPoUZ7ylkkBq1GbTwEZKbXvnMv5jMrp6DIVzbaeXzVqbKS9+QTIqLBLn4AEmTZSrnFUA0ksox3NES6qqGfFR+mUQTfSER2JgYOACyVbvWjeRUOjkNrXKu3tcqsSvig/U1mhnmT5dA/3X3Tvj1O4nmjqtfKxcU4kMApXd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1i6/6+SC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A89FfYq020246;
	Fri, 8 Nov 2024 07:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fsJar
	vn0b7hrkfTpjJlOMKMmr/huC1+WZ/1frECXZbk=; b=1i6/6+SCE9uNElllODuCu
	MXyEtx653+iLvoORjU2SbI6mDy/gfCEgrOPY7DpMW7cOPj6sZ1JBDix33omY852j
	wVwnnwvlRFFzBxfNbkR6xxI7pFxlZvA/aVtXtFn1lTrVBDl/6k0fieGMlfwCqgMr
	anvEzGeyLRIbdtl7ZQLHc2gQP+8+lzKfN/qDBiLf6rYj/sftCsUXe0pRiRfbNnhu
	swDIurGBMOBuakWw8CCWBdDYIyvPN5QqWaelEXnhSzfVgQEF//8ZZhzFdfzY5box
	sKha6gxDzphRDe4nhI4L/dpoFP9WrZaTBN+HbQ7oYUj6vMm0LcE4MSK29ID0F7W7
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42s6g7k74h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 07:44:42 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4A8CifxS040865
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Nov 2024 07:44:41 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 8 Nov 2024 07:44:41 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 8 Nov 2024 07:44:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 8 Nov 2024 07:44:41 -0500
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A8CiNca003412;
	Fri, 8 Nov 2024 07:44:35 -0500
From: Darius Berghe <darius.berghe@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>,
        <alexandru.tachici@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <darius.berghe@analog.com>
Subject: [PATCH v3 3/3] dt-bindings: iio: adis16480: add devices to adis16480
Date: Fri, 8 Nov 2024 14:58:14 +0200
Message-ID: <20241108125814.3097213-4-darius.berghe@analog.com>
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
X-Proofpoint-ORIG-GUID: 7C7DqUvmR-9oPHbgalodOxI-Rl5ibh_k
X-Proofpoint-GUID: 7C7DqUvmR-9oPHbgalodOxI-Rl5ibh_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080106

Add the adis16486, adis16487 and adis16489 Six Degrees
of Freedom Inertial Sensors to the list of compatible devices
of the adis16480 iio subsystem driver.

adis16486 is similar to adis16485, has the exact same channels
but acceleration and delta velocity scales are different.

adis16487 is fallback compatible with adis16485 and as a
consequence, dt-bindings list was updated to use oneOf.

adis16489 is similar to adis16488 but lacks the magnetometer
and has a different accelerometer scale.

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 .../bindings/iio/imu/adi,adis16480.yaml       | 42 +++++++++++--------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
index e3eec38897bf..7a1a74fec281 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
@@ -11,24 +11,30 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - adi,adis16375
-      - adi,adis16480
-      - adi,adis16485
-      - adi,adis16488
-      - adi,adis16490
-      - adi,adis16495-1
-      - adi,adis16495-2
-      - adi,adis16495-3
-      - adi,adis16497-1
-      - adi,adis16497-2
-      - adi,adis16497-3
-      - adi,adis16545-1
-      - adi,adis16545-2
-      - adi,adis16545-3
-      - adi,adis16547-1
-      - adi,adis16547-2
-      - adi,adis16547-3
+    oneOf:
+      - enum:
+          - adi,adis16375
+          - adi,adis16480
+          - adi,adis16485
+          - adi,adis16486
+          - adi,adis16488
+          - adi,adis16489
+          - adi,adis16490
+          - adi,adis16495-1
+          - adi,adis16495-2
+          - adi,adis16495-3
+          - adi,adis16497-1
+          - adi,adis16497-2
+          - adi,adis16497-3
+          - adi,adis16545-1
+          - adi,adis16545-2
+          - adi,adis16545-3
+          - adi,adis16547-1
+          - adi,adis16547-2
+          - adi,adis16547-3
+      - items:
+          - const: adi,adis16487
+          - const: adi,adis16485
 
   reg:
     maxItems: 1
-- 
2.46.1


