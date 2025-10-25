Return-Path: <linux-iio+bounces-25436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D11C08BDA
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 08:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02A044E5FDF
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 06:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C1F2D3755;
	Sat, 25 Oct 2025 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="cz8QiEH8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05652243946
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761373134; cv=none; b=ZEKJrtQwd8ysbtB9LedXgcn/w2Oh2BC6Fvl7hUqx5wFDscQNFVWa+ODDyzCh3xwO2FRgQmMoZXCDpUowKrlZP6+yeCcHgQwqnTjHl9IDmvWyWPOLEHcAeUsu+ps7ZZ1D1Ilqmyj7YYYB/QCqTEpCQZ+kSvBSNNfeKAG8fGesYAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761373134; c=relaxed/simple;
	bh=y6FUjpeZnvhXWwSMNIWaqsFfcF++IOpK+TzjEhvDjZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF9+KgYygrSuWsVJFHrYoTT65UoD1YsGZCDiEFAdukzaPhghDwx8EP2a0cdCdLf2BKWfSQIpx+taWGI6dxAZwBu6dJRwEgZyFAZqle4TB/Layt49SMXO5Ld8JDIR3+x5LVOow0+IxK4b28x3VlJfglUdDnOi0IEYznWfvGDkZbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=cz8QiEH8; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 8279B104C1FA
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 11:48:49 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 8279B104C1FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1761373129; bh=y6FUjpeZnvhXWwSMNIWaqsFfcF++IOpK+TzjEhvDjZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cz8QiEH8R9aPtspqBAFe3Q9aay4q/ntb9cGI9ZZACQRJzJ9z0kzcmwcwo6A8YOsIg
	 Am6JeDh1M96szDg1sdJzfL616GHmf00fHGVSXLWN6Tf3foIwqx/enoUIvdBHLOANrQ
	 I+dWHr5hZ42uuW1SxVWSp9xE9CiftVM0gD4R3hU8=
Received: (qmail 17688 invoked by uid 510); 25 Oct 2025 11:48:49 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 1.503822 secs; 25 Oct 2025 11:48:49 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 25 Oct 2025 11:48:47 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 0EA60360035;
	Sat, 25 Oct 2025 11:48:47 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id CCC801E8160F;
	Sat, 25 Oct 2025 11:48:46 +0530 (IST)
Date: Sat, 25 Oct 2025 11:48:41 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com
Cc: skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: [PATCH v4 1/2] dt-bindings: iio: pressure: Add Aosong adp810
Message-ID: <4bb1fb34d32e7433120407a1111dff6732e05f59.1761372227.git.akhilesh@ee.iitb.ac.in>
References: <cover.1761372227.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761372227.git.akhilesh@ee.iitb.ac.in>

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


