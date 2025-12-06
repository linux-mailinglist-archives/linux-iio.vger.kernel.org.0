Return-Path: <linux-iio+bounces-26823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 861E6CAA6BC
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 14:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A93273014DED
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81D2F7AC5;
	Sat,  6 Dec 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+ORO6uw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79372E22AA
	for <linux-iio@vger.kernel.org>; Sat,  6 Dec 2025 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765027291; cv=none; b=NdMklS9Il/hVRa1eFq0xL/rNFvCsaHx3SDfCV47AY7zJFfVdApZ52bgzoPu4TBsY8Ejoigo3m3UAOyF9HGaIqSZpPf8K/hhk+pWDDdHeFG3ERJ6WMYzOgP4laBqISfxxU22zOxqSdWMWAl0sIJGLML6zvYX4/SzB0tLGf/rJ5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765027291; c=relaxed/simple;
	bh=Lww+yXkv84Z2x7JuyrMDF39vIQnHv97nmHrcLywabYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nskdQoFKcO9ql+eKlBojwZa/tFgqJ1O4R0T1POQrfuAfm+ht9lkGcqObG/zfq75Hp4Yk04nHRSUT6ewbDYBVZSuOTo1gK4AhCZ/hzhvji6BaOme+ukOi8xDI7aNMn/go+hpntFRCx08IB8JxfP/ypH/2E5jZfZ8vSPD7uj1ISCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+ORO6uw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29558061c68so37050455ad.0
        for <linux-iio@vger.kernel.org>; Sat, 06 Dec 2025 05:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765027289; x=1765632089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nos04M0pa2LslD0D1DYgtCwpYjHoIWNMKb8Kgv78Dgk=;
        b=F+ORO6uwj42cUedwCHirUVEOKjPf5XIj74eQ9P9j0AKxNosB2YTgebsped2oe3scFF
         uqM5LfIQUNi/iA/Esr+UfE3AgFPcs8J0fbMrxi3EpboCaBdNYJqbMABy9fUWAjWyxlqq
         kF3bEVGlVyU/ug4B9DaANCMOUmMNqMpkPWfhgMz9ZbcBjjcMyAVRf7DOS7JjxpnEkCWb
         /F/BiHM1eV6Ut4MX+lEJY54xjArYd36A9wg0hofFZRdXp0ynuBARsWWgcpBvyW4Sd26g
         qCxp0T5Y2jmu6Q413W9F5BaZ7I9wtSItxIUVi/NfTvv1TAit33cPNmzta30l53qxZGnv
         F0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765027289; x=1765632089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nos04M0pa2LslD0D1DYgtCwpYjHoIWNMKb8Kgv78Dgk=;
        b=Qjs0DVHMn5y8ITHn7GJDDf6oG+cC+WaBnWp7FuOwiNQLTJVyvR3DF6zcc22dQLsb41
         kdCd1tEZeGtRqGU41zgLplb/cRzhn/tH1+f1Zg/U4YomLXeRUfPcUbgY9CsRzwo5vHlm
         RhEwZkqQ30O3E6C4YLFPzL72EcZ8YiKc4wtFGjE9VKD71D/StDvU4qEOYkExArU9MkSG
         C0m86eNH8k3DxIFH49czteqlow2cDF8aL3WG6wuQuif3lnzaXzsqzVQloLSKAbm8wOxp
         Gf0uDmqQ/MRqs25f2l4jnLNsUTbhXnZZkzgcimnjpq+REtwhRMb8tRYB8kOwZORitqJf
         I3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9SfvxThBlXVJigYhU2bfDvqzSkArbOoXk6MdQSMXG2NeRwrmQUbd133OhuloPJ8xBzuDxg+yFq7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8UvW/fAa1nsoSo0+H4b+9eoyV0c8SOaumF8MwxMWp3CfESTo
	eqwI/JcqPlDfEbhjG4glCOIc5m19QD1uLo1HVV75oW5scUg+hj80v11y
X-Gm-Gg: ASbGncvk3SuqPPRdABa6rrteorDW4D2JbDACqN5GhjzOKZ+NkF1DScH6YNyUWu2UJ3H
	S66P7DqckRopR/eivmeSpN7MX/G5Y46tKVifQ/qx8M9eczxlHnC8p18Qg8tR7u477AJf1gi6CcK
	HxeWD5tTWURmzlJLPTlwZvhTX1UknQ00Jv6NE005Zr27feKE0UDf7vyfvGQxaCRZ7UVo8EI3Re/
	yTLa3jweckwKwbAtC5k6HtYg8mWdKjMDMwo596d4ylUvS2YbgUSpkRsvdO/3lPUmYfnNJkNoVfO
	pRbQsXHqjQ17ofzXxdo4gswlD47NwRdjFq4N408kaqaYLGQUkOZlVdq++XVNIyN2DAaFbKAEOYG
	e4CtX1frtEhHMHmMd4gWej9iN5G4lmoRewRAReDjjXMiTn2QZOvye3OQb+zWWwlKNXwXHP6SdH0
	yZtDLI86Lx51atCRqMO8DisVpO93spmqSStaH010brtoLM
X-Google-Smtp-Source: AGHT+IEQ1Pna6hw0hhA30acz8/XGqWS3edWt641yZber/JrMfeUcbedx4iY9SsPIBWurgUCK1pw1Ig==
X-Received: by 2002:a05:7022:4284:b0:11b:7824:5c97 with SMTP id a92af1059eb24-11e032d4208mr1645688c88.40.1765027289022;
        Sat, 06 Dec 2025 05:21:29 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:82a2:4ba7:7b91:594d:8d90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ed82esm33437925c88.7.2025.12.06.05.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 05:21:28 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: spear_adc: cleans up, update and sorts the existing includes
Date: Sat,  6 Dec 2025 10:15:12 -0300
Message-ID: <20251206132120.11059-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused includes and add what is being used (IWYU principle) and
sort the remaining ones.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
My reasoning was not correct at [1], tks for pointing that out @Jonathan.
With that in mind, I've reviewed some discussions about the principle and
I`ve changed a little bit approach: I`ve inspected the source code again
to find  out what was being used and also checked incorrectly "indirect includes"
using the spear_adc.i file to avoid them. The result is something like this now:

Removed:
#include <linux/device.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/iio/sysfs.h>

Added:
#include <linux/array_size.h>
#include <linux/bits.h>
#include <linux/compiler_types.h>
#include <linux/dev_printk.h>
#include <linux/math.h>
#include <linux/mutex.h>
#include <linux/of.h>

#include <linux/iio/types.h>

Tks and regards!

[1] https://lore.kernel.org/all/20251009182636.187026-1-rodrigo.gobbi.7@gmail.com/
---
 drivers/iio/adc/spear_adc.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 50b0a607baeb..b9eeed5533c6 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -5,22 +5,26 @@
  * Copyright 2012 Stefan Roese <sr@denx.de>
  */
 
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/property.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/io.h>
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
-#include <linux/err.h>
+#include <linux/compiler_types.h>
 #include <linux/completion.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
 
 /* SPEAR registers definitions */
 #define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)
-- 
2.48.1


