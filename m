Return-Path: <linux-iio+bounces-11984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A81E9C078E
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 14:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30514B2131D
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85899213148;
	Thu,  7 Nov 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="y198v5tP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE3212F00;
	Thu,  7 Nov 2024 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986307; cv=none; b=QOOVGT5BTMOfnEQjqgNYM/Xv7IzTEFL+uDdJW5V1+iDHiQ0luq5j7RyDxVPxklI2yQupHtTM4mUy0z5ypV4AceIKyyZoM3VifizFvTDp5eUgTUyPsdjrOJu5cciEgKMh5VQwqjNYL60TtVLhUjiS5j2kzq1zP1w406wNAj3jitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986307; c=relaxed/simple;
	bh=HvPcRiiC1UNAlKgpFKZhn7E6XbhSJS47M3KPAzLonKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCrXy+b78Zrr4F02D8Kj6DKE0vMiXjbN7TAvg85vzv1AQmE7PTLxTyqeqrheaWyj0aLa4XM3f4JylfZf00Voc1eXYfUo/WngNoI0PPjV+BVeRayMGpMflf0/XxeN1efFVT/SN5WTtjgdQ6LlrTGQNlyXbZU2E7c+4QzNVFkSbzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=y198v5tP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A77i5lP009059;
	Thu, 7 Nov 2024 08:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SrM+p
	oWnNTaknGGFk+4XATMyky6g6ZxMOnvJdOJEUM0=; b=y198v5tPwV5cYFNV7gYFU
	pzbw/LXx5K0a9OoE+ZkkSk1MnvvQtqGR424XXordQCIwn3zp2cMZpzHi7BmOwbMM
	FNiNmJjBP3dpwGGKYIRgOOQhk3JtlW1+FwXZKpfqP9KkVxyb1d/wljQc3IxfapFH
	jlYBKm609wCj6evojmXBxkmMJw+K6PyUStuTSCD1cOcyXaQvIMZ7wIqlFai9k7yQ
	SElbYTMsF+rvzbExppMk4DFZqqjVaXJtGXy5H9a5G38cs1yu/ANE3d4e2NZ2uiRk
	YWaZ8PuW5OLF+UYTO9adpOUJbUnbpjaREqmgeGppNFQDHWRrPm7ayACm2ntvtDQs
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42rse098qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:31:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4A7DVe37034819
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 08:31:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 7 Nov 2024
 08:31:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Nov 2024 08:31:40 -0500
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A7DVUGt019172;
	Thu, 7 Nov 2024 08:31:37 -0500
From: Darius Berghe <darius.berghe@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <darius.berghe@analog.com>
Subject: [PATCH v2 3/3] dt-bindings: iio: adis16480: add devices to adis16480
Date: Thu, 7 Nov 2024 15:45:17 +0200
Message-ID: <20241107134517.3089112-4-darius.berghe@analog.com>
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
X-Proofpoint-GUID: 5PUAcDp6t1UjuR6TWE2bQXKWf51uL6lA
X-Proofpoint-ORIG-GUID: 5PUAcDp6t1UjuR6TWE2bQXKWf51uL6lA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=962
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070105

Add the adis16486, adis16487 and adis16489 Six Degrees
of Freedom Inertial Sensors to the list of compatible devices
of the adis16480 iio subsystem driver.

adis16486 is similar to adis16485, has the exact same channels
but acceleration and delta velocity scales are different.

adis16487 is fallback compatible with adis16485.

adis16489 is similar to adis16488 but lacks the magnetometer
and has a different accelerometer scale.

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
index e3eec38897bf..2d3e6ecec6a5 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
@@ -15,7 +15,9 @@ properties:
       - adi,adis16375
       - adi,adis16480
       - adi,adis16485
+      - adi,adis16486
       - adi,adis16488
+      - adi,adis16489
       - adi,adis16490
       - adi,adis16495-1
       - adi,adis16495-2
@@ -29,6 +31,9 @@ properties:
       - adi,adis16547-1
       - adi,adis16547-2
       - adi,adis16547-3
+    - items
+      - const: adi,adis16487
+      - const: adi,adis16485
 
   reg:
     maxItems: 1
-- 
2.46.1


