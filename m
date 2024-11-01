Return-Path: <linux-iio+bounces-11768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6E89B9158
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 13:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF473B20E36
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFC019F421;
	Fri,  1 Nov 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qytA8CAH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D9199E94;
	Fri,  1 Nov 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465637; cv=none; b=GbapibBFcIp/18mZHKg3Ovzq5a/a36n4iPvxiT7OgZALt6WkWRL2HXwlgnnwwMyQb6gdBGMLiKuqnIhc3PrKYHinxmmU/J6c5ZAAe1Tomz9VK7gf4cWV5nQwOpI/D5ij5tiuMsYcV5QCEbR8xiP85qMvuCRVqzXuDE5dvXV7gAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465637; c=relaxed/simple;
	bh=d1ADj8Z7ocVwIed5cjNekI4yxO15nSgouwJmZs/S2ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPZLEXWSPNmqugoE0CeBg2GGKTp0z2vjHsVXBaSw851HHjYNQK4epEL9AM6B1cGa/GMttCGkPAL7ARFzQeJ+c8SaV7N10vwp8CuUyI2LYy1BFBpyHYen09xO6ju4sbozlKIJmVJwwpd4droTYXLLgsZ48mLJRjkgbO1rhLteh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qytA8CAH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1BcFhA026680;
	Fri, 1 Nov 2024 08:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iS+wL
	PVyVkJdVGWWKfXNgb+BfcXqnS4Lg1sea0gg1Ok=; b=qytA8CAHgTXxKmUqJfVVz
	kjx4eaiI+zOh7n1ZjDwEbtT/HDx5W7IdKgMHjeCHOq8aDe9Ah6ZZ0ydjzdvTn6XD
	zD8wqk2mEDs5msMsxv0OlIH0mYp1ZpyI532eIQvNsXEqaKoWoq6C7YeSQqiAs0w8
	LMDFkJlnNYc3RJ2zDtZxxn3RTqpO5flKCBExBIOPaNoO2eoinqjSYbiFTDtVwB+9
	TRpqhBGy9J5HrPLeEOr3hxGmj/yJOak7iPv5WEnTZ4PsK5SDZ6NHFPN0xSg8BS7C
	RbI1s7iYt22JHjtaeJ/ew/TZDiipej5nrJwgUVOdRrRcGBkpWv9QRy5FJFSRBahd
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42m2gmqdrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 08:53:53 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4A1Crp9x020283
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Nov 2024 08:53:51 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 1 Nov 2024 08:53:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 1 Nov 2024 08:53:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 1 Nov 2024 08:53:51 -0400
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A1CrflC029504;
	Fri, 1 Nov 2024 08:53:48 -0400
From: Darius Berghe <darius.berghe@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <darius.berghe@analog.com>
Subject: [PATCH 3/3] dt-bindings: iio: adis16480: add devices to adis16480
Date: Fri, 1 Nov 2024 15:07:42 +0200
Message-ID: <20241101130742.3479110-3-darius.berghe@analog.com>
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
X-Proofpoint-GUID: NqUgUvk6T9lYO-3kKjITzGVckPb3IeM5
X-Proofpoint-ORIG-GUID: NqUgUvk6T9lYO-3kKjITzGVckPb3IeM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=858 spamscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010093

Add the adis16486, adis16487 and adis16489 Six Degrees
of Freedom Inertial Sensors to the list of compatible devices
of the adis16480 iio subsystem driver.

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
index e3eec38897bf..5bef2878a0df 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
@@ -15,7 +15,10 @@ properties:
       - adi,adis16375
       - adi,adis16480
       - adi,adis16485
+      - adi,adis16486
+      - adi,adis16487
       - adi,adis16488
+      - adi,adis16489
       - adi,adis16490
       - adi,adis16495-1
       - adi,adis16495-2
-- 
2.46.1


