Return-Path: <linux-iio+bounces-16487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC7A5552E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 19:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4702B170738
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D5126B957;
	Thu,  6 Mar 2025 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="GoavmFVy"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-11.pe-b.jellyfish.systems (out-11.pe-b.jellyfish.systems [198.54.127.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198A1DE4EC;
	Thu,  6 Mar 2025 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286402; cv=none; b=AZE368dskt7t6nqEVsvQ52fbNCshHWlUpYz70uenA+f7CqiaO3l8K2moMOdKjv1dhTNLDze2Cx7YrcOG4FKNxBSNOW58KPMPLqhVUk0mGv4tf17fVHhnlrdcYmmkoFSgXdXOmEEj3Rmh6ERipUpcIXUZqTgKm58pRQ7jiM9Iw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286402; c=relaxed/simple;
	bh=B3hEEmDyirOujbQd6HZ+qxeIuXyQLTcoA8FLF1pGAfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEAP6NxR2jTdU0aBKRnILYPdSXqjpwAB1/FxdBxQ7RFUuLydzuDqY0W+CpvKlVqZQ6HiNInJ5kQhZe8eoZHt7jK9us25fMH5lMWQKd5Y1eZM3PxGEPeMkh0qp2AwUvjv0WQES7VtLIHosRN/HB1VvGy+yJfbWCvK1CV9Hw7L3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=GoavmFVy; arc=none smtp.client-ip=198.54.127.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z7yjj3gFwzFprf;
	Thu, 06 Mar 2025 18:33:45 +0000 (UTC)
Received: from MTA-05.privateemail.com (unknown [10.50.14.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z7yjj2m1Jz3hhVZ;
	Thu,  6 Mar 2025 13:33:45 -0500 (EST)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
	by mta-05.privateemail.com (Postfix) with ESMTP id 4Z7yjj15b8z3hhTv;
	Thu,  6 Mar 2025 13:33:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741286025;
	bh=B3hEEmDyirOujbQd6HZ+qxeIuXyQLTcoA8FLF1pGAfE=;
	h=From:To:Cc:Subject:Date:From;
	b=GoavmFVyZmdJgmE2vVwHJzx8Q3FJDDbhdQCt7nwpJiB+v7zXfXlOc++SLECovwRnE
	 NHaHeGpbLg40JSiyhaaKFKwX7T7kupW70uZnJdaVeAmOFwLSME4ceQGFyCDGffzbjc
	 +zsMEq/R+bFAUvQmS1yA/PFk0DvUTG/D7SrAuY1wpE7MMgEhfo35tnrCbkioo6l9Pz
	 1t/fjgsO4rQ2jM8qluMKuB4NO/R0oUp2uAs1K6vb2T9Fu2/xaL6VFC6uUPOYuIHDgA
	 4AZ6paxgZ9kUJFuqp6lUni8wR6C0N4HkbzEvgep+ojK3LZSWtTytxGr2qAtIK8EyHr
	 Uo9Xp99Q0DFbQ==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-05.privateemail.com (Postfix) with ESMTPA;
	Thu,  6 Mar 2025 13:33:31 -0500 (EST)
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
	bpellegrino@arka.org
Subject: [PATCH v5 1/6] dt-bindings: iio: filter: Add lpf/hpf freq margins
Date: Thu,  6 Mar 2025 13:33:09 -0500
Message-ID: <20250306183314.150253-1-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Adds two properties to add a margin when automatically finding the
corner frequencies.

Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
---
 .../bindings/iio/filter/adi,admv8818.yaml     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
index b77e855bd594..3f9c61547a78 100644
--- a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
+++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
@@ -44,6 +44,27 @@ properties:
   '#clock-cells':
     const: 0
 
+
+  adi,lpf-margin-hz:
+    description:
+      Sets the minimum distance (in Hz) between the fundamental
+      frequency of `rf_in` and the corner frequency of the low-pass, output
+      filter when operatred in 'auto' mode. The selected low-pass corner
+      frequency will be greater than, or equal to, `rf_in` + `lpf-margin-hz`. If
+      not setting is found that satisfies this relationship the filter will be
+      put into 'bypass'.
+    default: 0
+
+  adi,hpf-margin-hz:
+    description:
+      Sets the minimum distance (in Hz) between the fundamental
+      frequency of `rf_in` and the corner frequency of the high-pass, input
+      filter when operatred in 'auto' mode. The selected high-pass corner
+      frequency will be less than, or equal to, `rf_in` - `hpf-margin-hz`. If
+      not setting is found that satisfies this relationship the filter will be
+      put into 'bypass'.
+    default: 0
+
 required:
   - compatible
   - reg
@@ -61,6 +82,8 @@ examples:
         spi-max-frequency = <10000000>;
         clocks = <&admv8818_rfin>;
         clock-names = "rf_in";
+        adi,lpf-margin-hz = /bits/ 64 <30000000>;
+        adi,hpf-margin-hz = /bits/ 64 <30000000>;
       };
     };
 ...
-- 
2.48.1


