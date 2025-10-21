Return-Path: <linux-iio+bounces-25300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1174EBF4AA4
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 07:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F42384E7852
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 05:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D0125C6EE;
	Tue, 21 Oct 2025 05:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="rqPBxmAP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F51C68F
	for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761025823; cv=none; b=sxTR7s52bOZ7yCBbKTTMWpL8XL3YJccrGopacvXwIjnkJNeawCJIVmxQ0g7eOCrBlnvX6h0UaYnOVFVTpwks0GfgtxPc4OUm93JbEr1EkDX0yW4nHsj221PoJPB88hKQ28v8djH21tzKqkPIEqih2e6CySVCPznU6ANuG3ujOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761025823; c=relaxed/simple;
	bh=y6FUjpeZnvhXWwSMNIWaqsFfcF++IOpK+TzjEhvDjZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsN1DMrrlCCEbEscqi3eHrJJ4hIvoO+fPjddkWJMlEUUToJMTEJHqrStKSpT0pPLFnF9qwWK+4946JXTFsfzHh19G//ZGTklKWh6vc+HvbmoeucamxlHk3E5m+stBowFkWhhzRD8n/Bf6T6yk6dknOTLrdx+WIvW8n5HktjVXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=rqPBxmAP; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 95EEC104CBD8
	for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 11:20:17 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 95EEC104CBD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1761025817; bh=y6FUjpeZnvhXWwSMNIWaqsFfcF++IOpK+TzjEhvDjZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqPBxmAPML0BjBHLD8nftMHttN/Xa6DHikYlp/VUVyaKHwRbpuPmrl2aPq18ZfarW
	 iHR7noNZJmBTdA/SIMmvuaCZTbg5Xg2pXRZ+aJ3TrL8yyALVnKXx1eKgvAlx8TKmcw
	 Sm2mg/bFIvWsX48a9kaXUSzpRsEazy7Qe+diQcsk=
Received: (qmail 32326 invoked by uid 510); 21 Oct 2025 11:20:17 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.389021 secs; 21 Oct 2025 11:20:17 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 21 Oct 2025 11:20:13 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 604B93414E6;
	Tue, 21 Oct 2025 11:20:12 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 4DB6D1E81391;
	Tue, 21 Oct 2025 11:20:12 +0530 (IST)
Date: Tue, 21 Oct 2025 11:20:07 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com
Cc: skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: [PATCH v3 1/2] dt-bindings: iio: pressure: Add Aosong adp810
Message-ID: <9b4eb3e2418943fa13fac8f87fa65730a1bd3f88.1761022919.git.akhilesh@ee.iitb.ac.in>
References: <cover.1761022919.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761022919.git.akhilesh@ee.iitb.ac.in>

Add bindings for adp810 differential pressure and temperature
sensor. This sensor communicates over I2C with CRC support and
can measure pressure in the range -500 to 500Pa and temperature
in the range -40 to +85 degree celsius.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iio/pressure/aosong,adp810.yaml  | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml b/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
new file mode 100644
index 000000000000..b35eb63531c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/aosong,adp810.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: aosong adp810 differential pressure sensor
+
+maintainers:
+  - Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+
+description:
+  ADP810 is differential pressure and temperature sensor. It has I2C bus
+  interface with fixed address of 0x25. This sensor supports 8 bit CRC for
+  reliable data transfer. It can measure differential pressure in the
+  range -500 to 500Pa and temperate in the range -40 to +85 degree celsius.
+
+properties:
+  compatible:
+    enum:
+      - aosong,adp810
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pressure-sensor@25 {
+            compatible = "aosong,adp810";
+            reg = <0x25>;
+            vdd-supply = <&vdd_regulator>;
+        };
+    };
+
-- 
2.34.1


