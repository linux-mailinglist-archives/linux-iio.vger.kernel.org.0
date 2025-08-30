Return-Path: <linux-iio+bounces-23417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAD7B3C6A6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E329E188028B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C521B185;
	Sat, 30 Aug 2025 00:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yACazYk2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1CA1DF97D;
	Sat, 30 Aug 2025 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514714; cv=none; b=YgfT3G9zQGEK9Sqx8RJ40FNAVmcG1xP0X1PoshGnRHVkZeeQLn3ps0UX+wmMBNhpA9RYDcEZ3M1uBj8Y2phGhGRrwooZjVXTCWBAGM+0VYQ2VpGa/mw6FkuSzdQrIECFb80aSMy2wTjlcEJ2OXweHS3EdN61Ll1UDy5L/BnvoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514714; c=relaxed/simple;
	bh=svKCvssCjmF18klWK/GkVt14ioiE77e5ZkqirZTQVR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+eUQKzAYix3Uzi5rb7t8hB4CQz4FayK4D4CseiJvNCxDMWE0CBapuV/IrY+IqAe8lfQVFWbEKLfnkxw4V0sRHdo0pv3/TfN1psoiQzkV1PUEnTS5EyvLGAt8Y98ZAjiOUKyJD8Uei6jwC+X8SU7B6RpHKhCed40+H4FS7CAHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yACazYk2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TJR8nd026885;
	Fri, 29 Aug 2025 20:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8n5qS
	AS3rwuWLi9zUNSuiM7ooKqT9f91t5BWBqlZn+E=; b=yACazYk2R3mLEmUMBNGMD
	K4Wo+kYJMY7tF82HR2p/c/7wNyRy2JvX2YzPcUxsPF2TKjVQhDuaPTSg+HIKoIFM
	VCy8Ljj7Ih3521JgFWfSoPkZUFCpj9Q3KQYU/mF5sva/qMghs6MjTfi4RUR0iKQY
	MWYweHh1atpcbB77P9C5Taz2kLuoN1D7Xa8FkcVFK4G2ZpeyO0xC+Z7Hzf991DYB
	la02qCIViVO5vTnpNY9y//aTBFNERTeC7WYGpI6O8gt0g/5pqULIkaCkWJ8LsEuM
	BuGtm38tf12YOA9pzLv16QG0FD4CrTkpsbPOTGqP7Aqjp+oTre/90PF4jJNXD/0W
	w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqatajk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:45:08 -0400 (EDT)
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0dHWD004794;
	Fri, 29 Aug 2025 20:45:07 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqatajk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:45:07 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57U0j6JW018950
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:45:06 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:45:06 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:45:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:45:06 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0ij6I005012;
	Fri, 29 Aug 2025 20:44:48 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <ahaslam@baylibre.com>, <sergiu.cuciurean@analog.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH 12/15] dt-bindings: iio: adc: adi,ad4030: Add adi,dual-data-rate
Date: Fri, 29 Aug 2025 21:44:45 -0300
Message-ID: <e65b8b6b14c8083a48915a7bc40b7521fc246860.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDAwMCBTYWx0ZWRfXxLxlqBlzcVd3
 e2FKf9TB7v9EO1WHG4RhfgR561OeP7HHOeufy/tXfQpTmN7qo09bRzmpPQ0CeHObbBZ/RWbqCda
 c4aaaFmY0bDjp1LDuurqtt1xXfFkx6vz3ow7bp5XmNly3sFVMlZcLs4C60lQH1lVhgWqVYB6DqS
 fivYMWoEkTHgMahr133MA67EwnuL5VEQqBNkIZJOc+eOAnWm/1xvcPmFh1qccmlMWI+W4cf4L+X
 uTJQZ8uLbVHjveikqevPCGPCPY6BQ6JDQPbmim7UsrGuUd3+8wQUM0yegqs1SVSpdbZgATBps6w
 aA0wzEnIGB3BzwYEuR8VePPjVvKtZoWULu0XtK/GVTLBxHSj465RxB/zD6XViaa851/SuJHByzj
 Efj5kZ86
X-Authority-Analysis: v=2.4 cv=Z4bsHGRA c=1 sm=1 tr=0 ts=68b24994 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=1jY0wEZUOeTI3omRP7QA:9
X-Proofpoint-ORIG-GUID: OxnmGFVBwnGd_lZgDvt7oLT8O1lu6LnJ
X-Proofpoint-GUID: xJrPRKIPNI6YFN_o5XeHG2O3Dja_HPxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270000

On echo and host clock modes, AD4030 and similar devices can do two data
bit transitions per clock cycle per active lane. Document how to specify
dual data rate (DDR) feature for AD4030 series devices in device tree.

Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../bindings/iio/adc/adi,ad4030.yaml          | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 1e4e025b835f..9adb60629631 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -90,6 +90,13 @@ properties:
       host - Host. The Host clock mode uses an internal oscillator to clock out
              the data bits. In this mode, the spi controller is not driving SCLK.
 
+  adi,dual-data-rate:
+    description:
+      Enable dual data rate (DDR) in which two bits (per active lane) are
+      transmitted in one clock cycle. This can reduce the serial clock to
+      10 MHz while operating at a sample rate of 2 MSPS.
+    type: boolean
+
 required:
   - compatible
   - reg
@@ -98,11 +105,21 @@ required:
   - vio-supply
   - cnv-gpios
 
-oneOf:
-  - required:
-      - ref-supply
-  - required:
-      - refin-supply
+allOf:
+  - oneOf:
+      - required:
+          - ref-supply
+      - required:
+          - refin-supply
+  # DDR is available only for echo clock mode and host clock mode.
+  - if:
+      properties:
+        adi,clock-mode:
+          contains:
+            const: spi
+    then:
+      properties:
+        adi,dual-data-rate: false
 
 unevaluatedProperties: false
 
-- 
2.39.2


