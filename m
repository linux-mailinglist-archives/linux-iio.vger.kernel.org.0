Return-Path: <linux-iio+bounces-3397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4649887708F
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 11:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B6BB21071
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABBA383B0;
	Sat,  9 Mar 2024 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="Cg8DcmjA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0F38382
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709981509; cv=none; b=QhcqhrIjHhGlnZvslJtYhFe3QYAdXoeNfA5lxfvby4jC3kIu8Cn5TYzlDYsYFj80bz2ARPxKCftkFW2Tcm/tf5UIbpLs5eTB95vx4ksj96+YT0v1vMoGytJkkqYU+CmNNOo3rGH8kOzQMbCJBjKhReBOzAu8/nbdGf2w8NmQLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709981509; c=relaxed/simple;
	bh=k7EL7I8iMzIIPRV/KSU7eMMp45PZgVy1NNbbVouy5oA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bWFbAD+ObFt39Qd/TMs83P+0hy4sRb3jOYxJC3z+HJiTsCSvwrIlYfjT9x/07xmqaZzsV+iwSxQ/L1CuajRPEjs4TrWnisjzXdpSTb9v/DQ9a1HSmzK4NzDMWiJOJcR1mGQWIXxVr5JS7MJeuxnhwZtEzQmPXP7oGaSpzORDJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=Cg8DcmjA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd6412da28so13791815ad.3
        for <linux-iio@vger.kernel.org>; Sat, 09 Mar 2024 02:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1709981507; x=1710586307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChW2BCmij4u5H9wErfx88Juqp6RMsFgTqdJYy2yRPmw=;
        b=Cg8DcmjAuUvhCx9hmCOm3KmIU2awGSgv3MFQzJoOjzD7O/duIWYrZh+uB5bbig5nro
         8pb2ZHcvnVy4A3f9X51q/Wy94fr8p3jPFkBd0prjSrkDmmgaJBMuQlDu3th1IFsVqc9c
         qK9u8t3AaQwJkal8lddNBKJPF9VhsLG44/rShxTtPy2D0kaU2cpArHL7QUl30fHauhEo
         b72i9Gc2fDvx56ymMbDddjKlc05NGMRTqqf2gWGXP4DqdZx3NWhm+BbsGN+0tPSawyvt
         V3RzFyM4XSWPa9jyYyia8Ah5H4Q6HCc2UHtgx72Aku9nmrP0puqXhe7JTMJYzWr6k4+i
         n62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709981507; x=1710586307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChW2BCmij4u5H9wErfx88Juqp6RMsFgTqdJYy2yRPmw=;
        b=rXXUXQG4oVtAh8b8LNLMuscMjbLUrLNt05dIqZwrf5XQQ18v0kTtHzenUISoeHN2jA
         PPZZu1xhRN5sfiPYzdBAPbK3exoarIKRjUncloxnKpGRb7XFBLc6Mkolv1OEtKRdat8O
         9PtjdtAneujA4ysqpFCb0VoHBfVV52rugRaMXbyK5Qm6aIx4h1jvsl4CJhojXrgENp2k
         PNAHTP5TDkPqI8jrRfEVTz+eTSVc1S/2ZRs/ZfaKq2gbD4VfAFnu8HaPOL258+5EEuIF
         gQjGWIfLqNtU0SJx7zyG8PweKzFnXvq4TDFbQ0LVjNr/oK61PKk0jIAV4m4CWSM3fzL/
         aoFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbt79AHOwy3E5K53DdMkKaLju7izJJzPEXKaFhYDqmy1IfW+tmQJfdWZ7wF2bZqMfJIbR0UuABtWHU25DL+AUIJzW9I0iUqEW+
X-Gm-Message-State: AOJu0YxOjHW8VZBrVnBe3Xs7FClI+otgLHycyYwQctTreFnBAgzswICd
	atg9aj3N67ZDvywPX1vPPrzhTkkxLoo87YvSk2PHgVqRFHT3en6dq/Y5uam06PE=
X-Google-Smtp-Source: AGHT+IEOvoe8ptXFdYNVsPoVvqHJq26q+wKLhyaa5Q0+ODO0iWi4qNvmYIQaB651Ed26ktBgzz2xtA==
X-Received: by 2002:a17:903:11d1:b0:1dd:7920:428b with SMTP id q17-20020a17090311d100b001dd7920428bmr1640598plh.2.1709981507670;
        Sat, 09 Mar 2024 02:51:47 -0800 (PST)
Received: from localhost.localdomain ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b001dcf7d03824sm1070608plh.55.2024.03.09.02.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 02:51:47 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/5] dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas
Date: Sat,  9 Mar 2024 21:20:27 +1030
Message-Id: <20240309105031.10313-2-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
References: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge very similar schemas for APDS9300 and APDS9960.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v8 -> v9:
 - No change

v7 -> v8:
 - No change

v6 -> v7:
 - No change

v5 -> v6:
 - Write proper commit messages
   Link: https://lore.kernel.org/all/1d0a80a6-dba5-4db8-a7a8-73d4ffe7a37e@linaro.org/

v2 -> v5:
 - Removed 'required' for Interrupts and 'oneOf' for compatibility strings
   as per below reviews:
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
   Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/
---
 .../bindings/iio/light/avago,apds9300.yaml    | 11 +++--
 .../bindings/iio/light/avago,apds9960.yaml    | 44 -------------------
 2 files changed, 7 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index 206af44f2c43..c610780346e8 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -4,17 +4,20 @@
 $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Avago APDS9300 ambient light sensor
+title: Avago Gesture/RGB/ALS/Proximity sensors
 
 maintainers:
-  - Jonathan Cameron <jic23@kernel.org>
+  - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
 
 description: |
-  Datasheet at https://www.avagotech.com/docs/AV02-1077EN
+  Datasheet: https://www.avagotech.com/docs/AV02-1077EN
+  Datasheet: https://www.avagotech.com/docs/AV02-4191EN
 
 properties:
   compatible:
-    const: avago,apds9300
+    enum:
+      - avago,apds9300
+      - avago,apds9960
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
deleted file mode 100644
index f06e0fda5629..000000000000
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
+++ /dev/null
@@ -1,44 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/iio/light/avago,apds9960.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Avago APDS9960 gesture/RGB/ALS/proximity sensor
-
-maintainers:
-  - Matt Ranostay <matt.ranostay@konsulko.com>
-
-description: |
-  Datasheet at https://www.avagotech.com/docs/AV02-4191EN
-
-properties:
-  compatible:
-    const: avago,apds9960
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-additionalProperties: false
-
-required:
-  - compatible
-  - reg
-
-examples:
-  - |
-    i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        light-sensor@39 {
-            compatible = "avago,apds9960";
-            reg = <0x39>;
-            interrupt-parent = <&gpio1>;
-            interrupts = <16 1>;
-        };
-    };
-...
-- 
2.34.1


