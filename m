Return-Path: <linux-iio+bounces-16013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B63A42A5B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5797A4795
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F1264A85;
	Mon, 24 Feb 2025 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="JF3Tmr/F"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-14.pe-b.jellyfish.systems (out-14.pe-b.jellyfish.systems [198.54.127.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA1125B667;
	Mon, 24 Feb 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419528; cv=none; b=gczB7AtgUGJ2fHDaeqgxaZYGnvRFFA2h4Yd3v39n3+UWqdSd8nqP2+4P6W/ByVAtfkCXaAQmbEtmsHqg3AKf71GAZoUHh9IXCW0QJGl0UiXHg3ZBAcWsGObvTUAGaMwKALjTy0LOWAAWAjqhbVDUVA8wZCAE6xsVlJfdhVvc77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419528; c=relaxed/simple;
	bh=PUpdGn2fYr7G7tRX2d7w/01r6lBdxn2elIxJwv8NWxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3xkqt9Tj+KTG3MkXRj34N3EoisFc15Myj2QnSuNQ9OkrjKaBrpXlfC727nJ4qbh/RQ40VCZsznhxqSkcIap2YZHUdC1yegpADeCdEq8VZpKneuvVJx8FZ5LPxI9fYCUa8sBPlWvKA5IaNyuHc6WpgasMs7TgZ1hIZHZu01Ct/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=JF3Tmr/F; arc=none smtp.client-ip=198.54.127.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z1pG774rCzDqhr;
	Mon, 24 Feb 2025 17:51:59 +0000 (UTC)
Received: from MTA-13.privateemail.com (unknown [10.50.14.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z1pG76ZmRz3hhVd;
	Mon, 24 Feb 2025 12:51:59 -0500 (EST)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
	by mta-13.privateemail.com (Postfix) with ESMTP id 4Z1pG75QS2z3hhVW;
	Mon, 24 Feb 2025 12:51:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1740419519;
	bh=PUpdGn2fYr7G7tRX2d7w/01r6lBdxn2elIxJwv8NWxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JF3Tmr/F4oe1YSRKIExDGrTjuCjsG2ADmiQrlHlpgyFa0IYEkxYZjVZDCQ+ubqiq0
	 HqZsWYPj21byqCSLv6x3L/aCwe2EXfeh1QL/CUPo/xgdA1r7AG6mtxeHG1Qzv6UvtA
	 aq/dlRU85G1IrwF9HyjIVzDOlcwGeH1SSbyaK/Ec2Y/dmMUlRDwQ4AJISeWP1s8LU7
	 h6rK97dGfLhQBqwSAFOOYH6OGB8Tiqw+EDpyJKvkSHbZ+HroWc10hXNK7CLs20L0v5
	 tKbgxzrpI+Xf617cR0R6+hzTjMXSI1vcgo8GX0GDYYjgcSH3PtLLxiRP9M9Ig4IgtJ
	 sHO562AZ0H2Gg==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-13.privateemail.com (Postfix) with ESMTPA;
	Mon, 24 Feb 2025 12:51:49 -0500 (EST)
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	sam.winchenbach@framepointer.org
Subject: [PATCH v3 2/2] dt-bindings: iio: filter: Add lpf/hpf freq margins
Date: Mon, 24 Feb 2025 12:50:56 -0500
Message-ID: <20250224175056.560111-2-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224175056.560111-1-sam.winchenbach@framepointer.org>
References: <20250224175056.560111-1-sam.winchenbach@framepointer.org>
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
 .../devicetree/bindings/iio/filter/adi,admv8818.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
index b77e855bd594..1be6f1fe4bfc 100644
--- a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
+++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
@@ -44,6 +44,16 @@ properties:
   '#clock-cells':
     const: 0
 
+  adi,lpf-margin-hz:
+    description:
+      Sets minimum low-pass corner frequency to the frequency of rf_in plus this value when in auto mode.
+    default: 0
+
+  adi,hpf-margin-hz:
+    description:
+      Sets maximum high-pass corner frequency to the frequency of rf_in minus this value when in auto mode.
+    default: 0
+
 required:
   - compatible
   - reg
@@ -61,6 +71,8 @@ examples:
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


