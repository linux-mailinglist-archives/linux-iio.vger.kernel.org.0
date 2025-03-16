Return-Path: <linux-iio+bounces-16911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAD4A635F6
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 15:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7221170616
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A2D1ADC8F;
	Sun, 16 Mar 2025 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="i48D6J6F"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-09.pe-a.jellyfish.systems (out-09.pe-a.jellyfish.systems [198.54.127.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA11AAE13;
	Sun, 16 Mar 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133604; cv=none; b=Py7brnQyH2s+52S1mFo9Xqxz4R0Vtm6SOg0i3q5nSiCmih6/R6WrkSK54RDsIOUDlwH2hrABxKEFdp+ltON46/ZrkELbyTNBeEGGT3dNoQ/eZhrg84i3DbDVXaRlIZnjjXdSxJI4xhOjzlOFvY85CdOjCkZuTA3+ur2Uozj4lZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133604; c=relaxed/simple;
	bh=EdJSBFycHciE/hpVez5MYlDu+bm8+MG1UwWwOySVc74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OiNmbkWnhOqSGdGysQJ5lwE7XTNc6NbbNScqYgAaFqtS26iWkFrelSMhbjyGNWSudyCdEbxNPmC5O0QbyhUfr/nITtA0xfByB8POY99HZxZqV3kk+a7tUlKTz/WAi7HbJmQ2wJx1a6VERO2g9zY+KZV2Of+76Ya+hLdxYseHWCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=i48D6J6F; arc=none smtp.client-ip=198.54.127.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZFzyc2ZsFz9sHW;
	Sun, 16 Mar 2025 13:50:48 +0000 (UTC)
Received: from MTA-12.privateemail.com (unknown [10.50.14.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZFzyc1tHDz2Sd0Q;
	Sun, 16 Mar 2025 09:50:48 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id 4ZFzyc0Srhz3hhRs;
	Sun, 16 Mar 2025 09:50:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1742133048;
	bh=EdJSBFycHciE/hpVez5MYlDu+bm8+MG1UwWwOySVc74=;
	h=From:To:Cc:Subject:Date:From;
	b=i48D6J6FjsPyzGnezRHbIbjsCzbTu6hXJic0KAaSRGHfTyM11Tnmrb1WcpQI++E5X
	 heWJtySyaR/bGXcXYWvghkIR1pK59WQTXEKdnCzN0o+zJVi4Oxk8EQKed5+ZN/GmUq
	 rsIGQvnK5kXqa9x9GkLV2+lR7eanm6oGzmdpprtnDA+lFzDv41lSMTsOkPWZRTk5YG
	 qgENqTYXwUYRfrrjD1xPWA58Qn8gDhG2t0ugJj2DFbbmkfPMf4jJmldfKlyeUpGOOa
	 7MrCZnTrVnWpUt3Fu3n5zfGuwgSE7+1M8C/xK5Q7ojAyiV7jY0uioog80HdOQ5mNeh
	 C4vnrl/a4otVA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Sun, 16 Mar 2025 09:50:33 -0400 (EDT)
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	sam.winchenbach@framepointer.org,
	bpellegrino@arka.org,
	Sam Winchenbach <swinchenbach@arka.org>
Subject: [PATCH v7 1/6] dt-bindings: iio: filter: Add lpf/hpf freq margins
Date: Sun, 16 Mar 2025 09:50:03 -0400
Message-ID: <20250316135008.155304-1-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

From: Sam Winchenbach <swinchenbach@arka.org>

Adds two properties to add a margin when automatically finding the
corner frequencies.

Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
---
 .../bindings/iio/filter/adi,admv8818.yaml     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
index b77e855bd594..ff0cb553e871 100644
--- a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
+++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
@@ -44,6 +44,24 @@ properties:
   '#clock-cells':
     const: 0
 
+  adi,lpf-margin-mhz:
+    description:
+      Sets the minimum distance between the fundamental frequency of `rf_in`
+      and the corner frequency of the low-pass, output filter when operated in
+      'auto' mode. The selected low-pass corner frequency will be greater than,
+      or equal to, `rf_in` + `lpf-margin-hz`. If not setting is found that
+      satisfies this relationship the filter will be put into 'bypass'.
+    default: 0
+
+  adi,hpf-margin-mhz:
+    description:
+      Sets the minimum distance between the fundamental frequency of `rf_in`
+      and the corner frequency of the high-pass, input filter when operated in
+      'auto' mode. The selected high-pass corner frequency will be less than,
+      or equal to, `rf_in` - `hpf-margin-hz`. If not setting is found that
+      satisfies this relationship the filter will be put into 'bypass'.
+    default: 0
+
 required:
   - compatible
   - reg
@@ -61,6 +79,8 @@ examples:
         spi-max-frequency = <10000000>;
         clocks = <&admv8818_rfin>;
         clock-names = "rf_in";
+        adi,lpf-margin-mhz = <300>;
+        adi,hpf-margin-mhz = <300>;
       };
     };
 ...
-- 
2.48.1


