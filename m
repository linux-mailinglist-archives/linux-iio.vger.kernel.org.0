Return-Path: <linux-iio+bounces-13417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 119569F0824
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 10:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE49D168BF2
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460DE1B3953;
	Fri, 13 Dec 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gf8lisPg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A01B3943;
	Fri, 13 Dec 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082792; cv=none; b=oB6G8HsE1oTjmfQMKG06keXB6/IuTpHlGE36i8dkhdvGrH0RiKQQCxE0g/TxOl3F5FZ78OAo09aUfASSWM1yiPyQn8GqirDjZohnCEH6ih7QMxHnVCDh5qM22xvMalCotail6ORkhzfdgZ+L2X3swexAw6J0oImI2eN08ldqqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082792; c=relaxed/simple;
	bh=Qzgv2j1ZS+5F7c/B/LXvb+uhY1wNk4BIc5Fqavy29+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfz0YdboC8O5XZ2/z0bUpm3HoJT7xS+ELu60bMKxQkrANl2aPeBU6F1ohc9pWP3D8XjQojVr+SvR9yeWOCtO776AL3sUBpTkZCStZ4urVoZIo2uha6ANinrZf2FiKnEsa+UPzoL0KOVfnZKBC42GiURTKSRwBBjZ1NPbhRLrKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gf8lisPg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD8G1MR003170;
	Fri, 13 Dec 2024 04:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fbQaK
	0jECSkUPuaSYvgn2vxsQoGUUqb6C8JFVFKevm0=; b=gf8lisPgH/nrSvnsDk44I
	/vKb/mV6+o3BtscSXOnWyEQAehEcDgExLElHcX7Arj+0j5tskuLkNrqv5PC/NHDH
	VJDBzsa40rQeOyLF0SVQcZaDAYs4HPuMh3l9kNQbwTetytqqJtkBZYy+G+OGqrLb
	GpYt0CHCSHepW3XHk5pX0qZbalg1XeD4NlhGoVYOAojzJ/lXGt7g0UhfCTvGm2De
	Db2Q0kW9dz2FKeZnXwkBH7GOfLIRf5XALrV9+EMsp5p7h+Fc14qtLZ9+ITHoB3tR
	QzUA70OtgwC7kq6o2hQVyLdjoKQq3WwKz9QjqF6RyYrEjilkwvcM+k7OaAnCOtaP
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43gh8y0amh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 04:39:36 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BD9dZpL013984
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 04:39:35 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 13 Dec 2024 04:39:35 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 13 Dec 2024 04:39:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 13 Dec 2024 04:39:35 -0500
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BD9dLXa028481;
	Fri, 13 Dec 2024 04:39:31 -0500
From: Darius Berghe <darius.berghe@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <darius.berghe@analog.com>
Subject: [PATCH v1 2/2] dt-bindings: iio: adxl367: add support for adxl366
Date: Fri, 13 Dec 2024 11:52:01 +0200
Message-ID: <20241213095201.1218145-3-darius.berghe@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213095201.1218145-1-darius.berghe@analog.com>
References: <20241213095201.1218145-1-darius.berghe@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 6meWdYaqY8FsUPD9C0MSw6jepISY3AJL
X-Proofpoint-GUID: 6meWdYaqY8FsUPD9C0MSw6jepISY3AJL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130065

Add support for adxl366 Micropower, 3-Axis, +-/2g, +/-4g, +/-8g
Digital Output MEMS Accelerometer into the existing adxl367 iio
subsystem driver.

adxl366 supports all the features of adxl367 but has a few
additional features for which support is added in this patch:
 - built-in step counting (pedometer)
 - non-linearity compensation for Z axis

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
index f10d98d34cb8..272be616e979 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
@@ -27,6 +27,7 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,adxl366
       - adi,adxl367
 
   reg:
-- 
2.46.1


