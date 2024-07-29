Return-Path: <linux-iio+bounces-8015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B093F1DC
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 11:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6861F20F75
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A1C1448FF;
	Mon, 29 Jul 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LspEiCPt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E75B13E032;
	Mon, 29 Jul 2024 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246697; cv=none; b=AuEtCG2v/jl4+1owAIn2BSrDnu4nOkxMIYxEpNZWnYMlIfIeRd1BbZQ140f5yKih/eoXkGXRezrpwxLTnIyYnDduX7csJQgOqow3QFlJgyOFk2RWHi4fU1zroPPQQBHlO9XTTKTNWi5qVLGn0o/KBR0IltIQ6OhYmEtaCNSTo9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246697; c=relaxed/simple;
	bh=SAB8STQWpC2Uf4Kiz4CMElCfOmfMMJMtn+hU/I7SCsQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXt6n7GIoosjajBtgIuNtwVCIOAJdYjoYJcnC+d8/2O8hR6TFmsh65PwjKizbfhQ50Z25zz88Qsm/ZHUkSfngYmvqma/Q2cW1gmmrVhAzmdphkc4Lk7gW4GFPZV1IByCL4oemlumwqCnwoQqqksCZ2C/Itm5HU9E40SMIS/dzxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LspEiCPt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T90o9I023535;
	Mon, 29 Jul 2024 05:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xFMds
	8ph0HWoMjq2J9D7kv+OSsDxFqQfnA81FE0vBqs=; b=LspEiCPt2/K+U9YB5Z0gT
	QijmA8Z1Bv7Dmwlx5u8Kr7cQ5oJRo4wzLckYgB25KJgsg/dvNnGOtIZA0tt5VNvs
	vEXEomh30aUY1T+zBr2DgUXJClfBwT3UAfr1EI+HGSDfmDSJzGsMGgHUtkOd/0/j
	zx7UuaIB63S9BYYhJ0aj/VbXQ3IM075TlpbCPKiEqOVtmWjXxt+1W/rIbUrHxb80
	25oJLymsUElCyWUSbZpXtL1IILigKFvOlxACEXqtjVVijFLLvToXmJKY6auxgdpb
	V11yNqpGCXPNuhLLtyNf+5xV2WxYpRabnF6xdnfH+2YqQPnSv3ePRRIEf8ohuSFd
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 40neb9upfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 05:51:10 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46T9p9BD015971
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 05:51:09 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 29 Jul 2024 05:51:08 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 29 Jul 2024 05:51:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 29 Jul 2024 05:51:08 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.170])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46T9orqW024934;
	Mon, 29 Jul 2024 05:51:00 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: adf4377: add adf4378 support
Date: Mon, 29 Jul 2024 12:50:43 +0300
Message-ID: <20240729095047.25040-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729095047.25040-1-antoniu.miclaus@analog.com>
References: <20240729095047.25040-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: KoZrxD3di0oM7ETsz_3zZj_ZDmCtzkeW
X-Proofpoint-GUID: KoZrxD3di0oM7ETsz_3zZj_ZDmCtzkeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407290066

The adf4378 provides only one output channel. Therefore there is only
one gpio available to enable the output. Reflect that into the bindings
using property conditions.

Add product link for the adf4378.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - update commit description
 .../devicetree/bindings/iio/frequency/adi,adf4377.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
index aa6a3193b4e0..5f950ee9aec7 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
@@ -17,6 +17,7 @@ description: |
    applications.
 
    https://www.analog.com/en/products/adf4377.html
+   https://www.analog.com/en/products/adf4378.html
 
 properties:
   compatible:
@@ -73,6 +74,15 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adf4378
+    then:
+      properties:
+        clk2-enable-gpios: false
 
 unevaluatedProperties: false
 
-- 
2.45.2


