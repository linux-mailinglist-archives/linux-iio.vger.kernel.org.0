Return-Path: <linux-iio+bounces-16530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8640A56B11
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 16:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1410D189A1C6
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB8B219EA5;
	Fri,  7 Mar 2025 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="tAe9EA5z"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-10.pe-a.jellyfish.systems (out-10.pe-a.jellyfish.systems [198.54.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3E21C9E3;
	Fri,  7 Mar 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359767; cv=none; b=LAUiVgy8PHvaiBV8mw7Bcl59VMgEPke0FzTubpAw3nJoc9swquu5CeAWsbXxwPW1FSjvmFQxZDoNp9tRvuMqc9OXQHf5slot66+fohGQIqGpI9no10k+oah//+a8radyq1bOIMjlIubRZY/FLJXaS0n339ywtgygGgQFSomdfh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359767; c=relaxed/simple;
	bh=lb4uAfI1SXGgn8ggLjB/c6P103RVqbD3+e/SwUMNEq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQWZivKvHo9nRTkzyaaZ4DVdgfrYhc883VDcWWKIRCSE9ImSX+GPOFvwaj0STbV1WSsIMVfxddRlKjh+c+9+O5HauS5f4B5Xx40b/g1AZKc95Iokb2336ouXO5kgXwiufGqDm9y6/l7J2VCi7w13OxCutWLcOY/y6U7WdMWU1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=tAe9EA5z; arc=none smtp.client-ip=198.54.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4Z8Tzl5ThGz9tTZ;
	Fri, 07 Mar 2025 15:02:43 +0000 (UTC)
Received: from MTA-09.privateemail.com (unknown [10.50.14.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4Z8Tzl4chdz2Sd0Q;
	Fri,  7 Mar 2025 10:02:43 -0500 (EST)
Received: from mta-09.privateemail.com (localhost [127.0.0.1])
	by mta-09.privateemail.com (Postfix) with ESMTP id 4Z8Tzl3G0Sz3hhRy;
	Fri,  7 Mar 2025 10:02:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741359763;
	bh=lb4uAfI1SXGgn8ggLjB/c6P103RVqbD3+e/SwUMNEq8=;
	h=From:To:Cc:Subject:Date:From;
	b=tAe9EA5z2kSFNqRUhyg6XQhAtOLtCTCqF4i9VL4Q1fgpNoH7zv2AhNf3A0FxA3Ji8
	 ucLtPVbxBg98AJmRNjrrzZqftlhiGMVwf8pPyA+aInATgyBU1u1rTla99io8+nmjMt
	 CBSPWuW+iw9SGFKx+W1GmNi2siWuQqlg5ueKcJzXJtbkyU8Wg+sL4wRWlQjkxEWAcD
	 aD2IcImWHtPJmOS2nCFIF530f4Jd8tPRasraqe3RuVItvk8PJpARSonuP1wdv/lLrA
	 CJsFEt99cGFr6oEL9mR54wpHtJGZNaqf4xgpsKhZIfh4A3XTnG/nW3hmoaN8Dt454q
	 AIQJi21WF4Zhg==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-09.privateemail.com (Postfix) with ESMTPA;
	Fri,  7 Mar 2025 10:02:29 -0500 (EST)
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
Subject: [PATCH v6 1/6] dt-bindings: iio: filter: Add lpf/hpf freq margins
Date: Fri,  7 Mar 2025 10:02:11 -0500
Message-ID: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
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


