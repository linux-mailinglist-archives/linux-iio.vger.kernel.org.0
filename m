Return-Path: <linux-iio+bounces-22759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4120B27DDF
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 12:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AE8AA2596
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF032FCC15;
	Fri, 15 Aug 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKMDJkHb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5B2E06D7;
	Fri, 15 Aug 2025 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252129; cv=none; b=VAHxMC15Q9OVpbzIFHeLyfNadKQyNS/qPtCF71MLpB0taDsGHcs5gtab7rQxGQe9G6Ae/I+lQ3fSYwfmHovGTpAB0CUlFjYHn8qFtdZLUMAijdGxiaH59bxDProSFIjI8Tkoo1aj3LZCRaKAfjaybRp/4WJZ6S2dTDf8QTeWdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252129; c=relaxed/simple;
	bh=XFsa1A1RlVh5HNiltbJK3moglD5C0EL09rbKvb5+7Sg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TNxxnLfR0MxrUG8M+Oh1EJbaA8VKYcSuc2e5TecRXNbcGyKIcnjHZVGHLgVSOFKA9OEBbcF8HJJkOq3GoDwaglMk10eowHoUWFmRe80+p4HxdwbCdPMXasRUM9zsI34mVegLe2IrweymDS65tBIKQDf1DlinF8M6v8zlKMcs8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKMDJkHb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae31caso320069966b.3;
        Fri, 15 Aug 2025 03:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755252126; x=1755856926; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=leiYjfH3gx5kap/lKvoIzFQxVLM2gzXx/uKrU+UQ468=;
        b=OKMDJkHbLfEllujW+Qr738uGGzUFKesjlEfyYxMKLvmew9xymkoAmrhq6YLgbmumIy
         rtr+P/vRoURswu6ZTqXr2EcAhxYR/4gjI0JGc76oVZRakI3JMd0EhjX+7qh5UfxHhK0H
         lssjnoM+FJr9CtsRtuoMcZ2GaruqcZo/MAc7JUnCIJv9AK+QDWFNXi9Mxzw/wiBmn9UG
         MPLXxO4oh/+3BDKzyxm9g2DHfM2ZTBu8CXRUhvIgoq7WBB6eGhOJypijFIIUlsJEeWHG
         AoycUIpwwPfrh5QS/12/CCKDfDN5n5xnzHSpu+qy6cGaBF9bHTQInj1h3KwQO4EZnRNY
         NtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755252126; x=1755856926;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leiYjfH3gx5kap/lKvoIzFQxVLM2gzXx/uKrU+UQ468=;
        b=aFxrVCU2xcccqMiyhPf3XJPB9MY9rZbKpYU4hkOuyR+TeYGNErdWNAxLJ9br6HCEFb
         5He3tPyi16FAI/Fhxo0K46RQDIPe5abAeDsLvX0ZrHOEu6xjCNOpTcFS3ptvy7XIsBP+
         3Tz+TWDYO06kMNXqiOqYeUoiD2qxrnpbmQkIc+nzd/tEEMMg5HdcnIOjkBd8EcAhLTfT
         t8vw9oBLLZQuiQm8aRgFE7oq6qxvV+2ZXpu11/yE+lU/d9teOg3CpaS97H/JBGNJFJEz
         3T2bo1rPXYslb1Uy5ik4cE62hIVnn1g7DXX74EcIEGGSzDVKcVgkwfUlLDjL2MjR7ggY
         OymA==
X-Forwarded-Encrypted: i=1; AJvYcCUjYTxVjOi5uo6jMX1xqX5WPwX7xiFviOTpBZCFmmwNwXIVJhe0WfSVynreCleSZd/w1Zi2tOZa7SigAECO@vger.kernel.org, AJvYcCV/toIwNHUHkRR6UkgT4pVGp1jKZ6ulO8Ezkh3KLI0YSHLcJXfF+KlGEgbNkeCYDxz+j0kJcA6yaHCl@vger.kernel.org, AJvYcCX7McUv6PAGLVFqCyqHbT6LOSiGnddEAHY/nQh25QcM0Zrrl3qm4yhW5RKMN8F4tmH2fVotjCIEojAh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/P2XmTpzYBSKV5+QMbehOWRE4wvLEdywX1NpZMTevTJv6pOX
	12OpI7deES8DT7EayzFP0tu8f9cWbh1zRsWdcH5kf3Q2Dl0VS016LL2m
X-Gm-Gg: ASbGncv6gQdC2jGCAWizrzyxSkfSuDPaFobmGlgjtFmz7BobzqmDIE1auqt9zvbKUKe
	YHw2mmhgyXL8ds7OV2/tGAOM4lKXp97UbffGP4m0QYM58/9XWegFUh29QsA43LTwFpf8cKpZFvr
	mIs+59lFTKJyJlgcshaSx+pfkY+9wx2UP+nby1qTC90jtg42cPIRuGe8YNc4poD8fLz+Uoh/3OE
	SJAOgU0CfxdWKuor/xOPKPFQA3tRF7IxtKja4KP1dKPNsbx3gfU+vA83t03FCgEcJ49zn/NYj2q
	kQRXI0FYImkXnh6NNFNAE1s8u5puR1JyC2vjS8RG5FL+qZGin1zbzlUzqY3mMLb+pMQk3/XlQkJ
	p635y1+fTrMgr5erPEiPapQu+LN9L
X-Google-Smtp-Source: AGHT+IHh6miiqifUZkWoFKn1f9nBbVB6w2SPtEr6DDO1033fTTFXxMdt1+vOv3n/5FmMPN3Kff1OeQ==
X-Received: by 2002:a17:907:7e87:b0:ae3:635c:53c1 with SMTP id a640c23a62f3a-afcdc32d8d1mr127216766b.54.1755252125767;
        Fri, 15 Aug 2025 03:02:05 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce72d5dsm119031766b.37.2025.08.15.03.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:02:04 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Subject: [PATCH v4 0/3] Add LTC2495 support
Date: Fri, 15 Aug 2025 12:02:01 +0200
Message-Id: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJkFn2gC/13MTQ6CMBCG4auQrq1pp+XPlfcwLtphCk1ATCFEQ
 7i7hUQhLr/JPO/MBgqeBnZJZhZo8oPvH3HoU8KwMY+auK/iZiAgFYWUvB0RdJnyNIdC5iiVqxS
 L389Azr+20u0ed+OHsQ/vLTzJ9fptwK8xSS54bp3GzBEh0LXujG/P2HdsbUxwdGp3EJ21xoFwm
 TUi/3fq6PTuVHQIJkPCKrNleXTLsnwAPqPsVA4BAAA=
X-Change-ID: 20250811-ltc2495-572817c13fd3
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755252124; l=3476;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=XFsa1A1RlVh5HNiltbJK3moglD5C0EL09rbKvb5+7Sg=;
 b=tuCYhguyUC+4tcB37JB+c7e2MCKlkdiSObqmtt7Yk1z8/ZulWHbXvwBgqAw6E8dLIIhtxqJia
 l1TQAZ3MuRlA026aqAuAIquGq8V6fD6z+irU1zxyts7KUbGZsyVM1X2
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

Hi All,

This is the v4 of the patch series to add support for the LTC2495 ADC
and to enable the internal temperature channel for the LTC2495 and
LTC2499.

Thanks to Andy Shevchenko for his helpful reviews on earlier versions,
and to David Lechner and Krzysztof Kozlowski for their feedbacks on
v3. This version addresses all feedback from v3.

Best Regards,

Alper

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
Changes in v4:
  - Removed the verbose formula derivation comment from `read_raw`.
  - Reworked the temperature channel definition to omit the redundant
    `.address` and `.channel` fields.
  - Moved I2C-specific bit definitions from the shared header into
    `ltc2497.c` and removed the pre-combined command macro.
  - Simplified I2C logic to check the channel type instead of a
    non-standard address.
  - Combined the basic device support (#2) and temperature sensor feature (#3)
    patches into a single patch (#2).
  - Link to v3: https://lore.kernel.org/r/20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com

Changes in v3:
  - Used the standard `kelvin_to_celsius()` helper instead of a custom
    define.
  - Corrected macro definition style.
  - Renamed `LTC2497_CHANNELS` and `LTC_T_CHAN` for clarity.
  - Combined all struct layout optimizations into a single patch.
  - Link to v2: https://lore.kernel.org/r/20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com

Changes in v2:
  - Rewrote all commit messages to use the imperative mood.
  - Added a justification for the new compatible string to the device
    tree binding commit message.
  - Removed all unrelated whitespace and formatting changes.
  - Removed redundant explicit `false` initializers from structs.
  - Replaced the magic number for Kelvin conversion with a define.
  - Improved comments for defines and temperature scaling constants.
  - Renamed confusing macros and struct fields to be more descriptive.
  - Replaced dynamic channel allocation with a static array approach
    using a shared macro to improve readability.
  - Optimized data structure layouts based on pahole output to remove
    memory holes.
  - Link to v1: https://lore.kernel.org/r/20250812-ltc2495-v1-0-7bf4c6feec2e@gmail.com
---
Implementation Notes
 - checkpatch warning: The new static array approach uses a shared macro
   for the common channels (`LTC2497_CHANNELS`), which triggers a
   checkpatch.pl warning: "Macros with complex values should be enclosed
   in parentheses". However, this will cause a compilitaion error, as an
   initializer list cannot be parenthesized.
 - uV to mV conversion: I could not find a standard macro, so a manual
   division is used for now. This could be a point of future
   improvement.

---
Yusuf Alper Bilgin (3):
      dt-bindings: iio: adc: ltc2497: add lltc,ltc2495 bindings
      iio: adc: ltc2497: add support for LTC2495
      iio: adc: ltc2497: reorder struct members to fix memory holes

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   3 +
 drivers/iio/adc/ltc2497-core.c                     | 132 ++++++++++++++-------
 drivers/iio/adc/ltc2497.c                          |  39 +++++-
 drivers/iio/adc/ltc2497.h                          |  19 ++-
 4 files changed, 147 insertions(+), 46 deletions(-)
---
base-commit: acbbb5a20971089064ca6b271dd251e629be8d4d
change-id: 20250811-ltc2495-572817c13fd3

Best regards,
-- 
Yusuf Alper Bilgin <y.alperbilgin@gmail.com>


