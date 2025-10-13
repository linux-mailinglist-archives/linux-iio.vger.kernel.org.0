Return-Path: <linux-iio+bounces-25036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11641BD56EA
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 19:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56D83E6606
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A032BF013;
	Mon, 13 Oct 2025 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="ZPHVfjUf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2D29A307
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374943; cv=none; b=iBGx+4KvjkofGcEg3z9uiMi6TP1qiG02PSj4s05lWwnsumAaKYVycCYOVth5198RROgvSfyNKznunef++lfHBzN1gbh2qLtTbpK2MDaN3xIRxJ8vRcJNG3YYHaNNlfXMLmc0cQ0XE4IN+q/PNHz4PG9Z0C1RgPAFzhb91ZTNy8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374943; c=relaxed/simple;
	bh=y6FUjpeZnvhXWwSMNIWaqsFfcF++IOpK+TzjEhvDjZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsLy7kTuUKRgw/YW9eiZ4mXY0HpRQCXQTQa7A/kFt2Jg0ZJY+o5Y7QqMYAewe1Xpy5OU+4poGhcDiskY/TKq2K2KFcrH0u3HpU3kcx29Q/WgK4hdwOSj2wjQwaE6bVZmbxHWp8tsdhvaVlUKEa12kgxEeqYxsxpIDyUFO5bhz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=ZPHVfjUf; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id BC7A21038477
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 22:32:17 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in BC7A21038477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1760374937; bh=y6FUjpeZnvhXWwSMNIWaqsFfcF++IOpK+TzjEhvDjZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPHVfjUfqF5TZ4ZSEZurEsBbDXaqeU9HL3hj+tig8IKw4nML14uzlLUukwDdPHubC
	 x0RkHsulGm9SAjD7Ha+HzN4Gzw6oigp2sSotjVQFiLfglP9H6MD1Cf3WEresiLb4HF
	 dR/RZrxPuoD+IhXajyOAL840va+4HARI0C+kOVpg=
Received: (qmail 13180 invoked by uid 510); 13 Oct 2025 22:32:17 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.431314 secs; 13 Oct 2025 22:32:17 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 13 Oct 2025 22:32:13 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 844ED341500;
	Mon, 13 Oct 2025 22:32:12 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 48C551E8152E;
	Mon, 13 Oct 2025 22:32:12 +0530 (IST)
Date: Mon, 13 Oct 2025 22:32:07 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com
Cc: skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: [PATCH v2 1/2] dt-bindings: iio: pressure: Add Aosong adp810
Message-ID: <c9904b804afe04df87c1716c733840d3b5a99a3e.1760374257.git.akhilesh@ee.iitb.ac.in>
References: <cover.1760374257.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760374257.git.akhilesh@ee.iitb.ac.in>

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


