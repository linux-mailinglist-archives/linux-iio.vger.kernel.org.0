Return-Path: <linux-iio+bounces-16059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135F8A44148
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 14:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D275A1647F6
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44082698AF;
	Tue, 25 Feb 2025 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="QDngqJpe"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-15.pe-b.jellyfish.systems (out-15.pe-b.jellyfish.systems [198.54.127.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20105262D20;
	Tue, 25 Feb 2025 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491223; cv=none; b=OWqczcjabVhwsipJ6aybFH5PY/EX1oQ0i8R4HCiof2HqncuQ3YWsEWHafyLOGGpNzWDt8UAsfXSWqZUtWsEVielWhskicr34ySiSuCuosJqlvyNq3gXYQ6C6XxqUJxSpMT9g6Y9wNT1cRG/Pb/LHLEu3SH3DOT4u2HNAUIRlG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491223; c=relaxed/simple;
	bh=JdvGGa12TDQfsAZPHTVvG4jsURBueHyKXE+Pkyfv3do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E27q6urAJ8+A0rQoz9AwfOitm1QqWrwSdwiCKer6VaeSW0qdlOEgW6jRcfuJcp1M4kodm3EHqOYwfbID89F260Cz9OhUGq8U9Lueb7bM1L9yPSmuVl2IY7P1FgWEZfSCPYqePrbapepi/nFI6KLvgHe2ePsYOdimb2ad34JnP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=QDngqJpe; arc=none smtp.client-ip=198.54.127.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z2Jmv0wxNzDqs8;
	Tue, 25 Feb 2025 13:46:55 +0000 (UTC)
Received: from MTA-12.privateemail.com (unknown [10.50.14.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z2Jmv061Lz3hhVg;
	Tue, 25 Feb 2025 08:46:55 -0500 (EST)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id 4Z2Jmt5ljhz3hhTw;
	Tue, 25 Feb 2025 08:46:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1740491214;
	bh=JdvGGa12TDQfsAZPHTVvG4jsURBueHyKXE+Pkyfv3do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QDngqJpeGXvq2AmCqbz8Rmqb6EGcT5EAzgMSq4paEv72p38HnFnifnYYS/NDJslNn
	 3xQw0yxs97JZ7AI6ZTRz/HMS+5upcBEEh/MtmZGBE8T2m1omyH/l+K4x9LkTQae79K
	 jicnLx4SK18LJBJiwi+a/IWtPP58IDbh5iy5XlsSq35aIAt+dqPjVytoRcY/VOxGa+
	 Fcw9gFCXJmUTz6fiNnuNsOKSsEweejTImdInElOZZhluDBH5oGpfoP7+KgS8JHzz14
	 r5Kuhtmsut67PAsS0UxSqcsaGa1jmWvdxfYmRKGZfRobn3cj+wpOMaJOePfGibfQ+n
	 ZCOgCvRsMiooQ==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Tue, 25 Feb 2025 08:46:41 -0500 (EST)
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
	sam.winchenbach@framepointer.org
Subject: [PATCH v4 2/2] dt-bindings: iio: filter: Add lpf/hpf freq margins
Date: Tue, 25 Feb 2025 08:46:12 -0500
Message-ID: <20250225134612.577022-2-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225134612.577022-1-sam.winchenbach@framepointer.org>
References: <20250225134612.577022-1-sam.winchenbach@framepointer.org>
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
 .../bindings/iio/filter/adi,admv8818.yaml          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
index b77e855bd594..2acdbd8d84cb 100644
--- a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
+++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
@@ -44,6 +44,18 @@ properties:
   '#clock-cells':
     const: 0
 
+  adi,lpf-margin-hz:
+    description:
+      Sets minimum low-pass corner frequency to the frequency of rf_in plus
+      this value when in auto mode.
+    default: 0
+
+  adi,hpf-margin-hz:
+    description:
+      Sets maximum high-pass corner frequency to the frequency of rf_in minus
+      this value when in auto mode.
+    default: 0
+
 required:
   - compatible
   - reg
@@ -61,6 +73,8 @@ examples:
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


