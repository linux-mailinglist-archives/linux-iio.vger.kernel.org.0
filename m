Return-Path: <linux-iio+bounces-22732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F34B263C2
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 13:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57CD3A9CD5
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA962F39C1;
	Thu, 14 Aug 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYaWfW7N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032CF19F11B;
	Thu, 14 Aug 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755169228; cv=none; b=Fyx7afToPCorNMEJVb+B1NPd6ioGyV25AUrd3bZLLXRyLhTAvj01wP1DcTl98DpXav+M8CIWtSNW4vJtA4mPrCjI3kb4+FxDt+pztnUP+GhNzrVTWCBT7NBM5BVe3YDO5kNPwWWSKd7vkHW7nDRHD4ynW7PTQrAPu+NHaeJBe1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755169228; c=relaxed/simple;
	bh=Uy7vy8b0/Ve4PqRFiyW6SgaraGSuHiGGhfWaeYo9VOY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gt7Nb+52dLF/onKjkCpa65HWQkVSVj2zZ/HehEL9kZMft50uygSqsgXGhnCgOJHPrJG0M6s19cqh8jTZJKf1SjD7E9TZn/3vv7GY2zWorgiICenCQgte3C/CD353BdLSVBmXeX53AakLVyXI1oa7PloQgCWTR/g5DDRIkwUgxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYaWfW7N; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-618690a80e8so2806545a12.1;
        Thu, 14 Aug 2025 04:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755169223; x=1755774023; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZYBQ++xloO8OkMz0+ha0tp3u9TW+5yxhBPn7YbiqG4=;
        b=YYaWfW7Nyg4S+lmpsv7m0aFRNg5n+togLUD96gqxK6oR1TlwppTyPWZR87/RugX+Fk
         xBLnl0Q0IiszmlDJnY4/FLbirw4MRcFT3MQhjUeAPZO+VueL9nQ9G6ERE4xZj2M93UZ4
         1HHeZ2Q60oOHR+HVShMM4hZAXKDPpxiZAQjX6Ko5R1TO1XldP28+egU6YFUnyYDvnXzR
         aUIR4zM15MpFv5Tl9SczcywZY70nj+8b3/etUCg9ulvWWdARqBnbOybGOgqwsWoDD2c0
         OVyPXeyn7aitiVzOpc7jZVcaDDNZ0e6Zj3911BV/2X1mGhK1iERQDsMxWhGKWNHb85Yl
         2HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755169223; x=1755774023;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZYBQ++xloO8OkMz0+ha0tp3u9TW+5yxhBPn7YbiqG4=;
        b=XV+dtt4yUd4jRS1SHSY4BexfkoJivE0H0c82lTH5CGQ/Pykkx7noWj6ePnyZM9KBCm
         y2js6z9wY58vLjxh2flzepkrcGxBDHqn2cFQcwj9Fk4ysvAy8mMTKdvCBdZX94Cacg82
         bHVPoUy6zLQFPEVQRsAnEkqeC6MWFMB4HZPY/0oaKkdGJEpjfOoYg71TpZOjjSID5Nkq
         cfjvhKFUPzkjQkgTOMJw1Ki2GWzxC5XP4NiQAU1T2I+ZYIaVWoxVUfewSm//cf9G29UQ
         nTVFK/D83lKwCz3bK1mL0EouN4N7juF1OWYHZ487lgsJxUFhVVeAQLfxrmpHXGXq0YjR
         vxmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4bK3YSE6Z4iP1md+DtqTUi/bDgawI1KPxjHfzoky9ot0tXdMJbLr8b+/IpikHwiVjkjkopDUWQ4tD@vger.kernel.org, AJvYcCUwpf/bzH78FisfllyL/gtmANNcUwD34Zfh2DDYEteId6gmZxgIpglzOSSCIAqAJAZAcjWTaQ2X4fwl@vger.kernel.org, AJvYcCWzYk/W3rBZlSMj9eQBliVNeYkt2UtUZgCktIDNEf4AMbHz/9Da9iv8pWpy5e8NRJYfSHo89/CTQMVdM6Sg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4eoIdUamywiDBq1Nek/uvOO9batMsTF5ecsQ9MIALvnT+V/B2
	M4svgEXL12xxzsoF8i/I4dWvJjNIETF3ALoloEM09vTOhunSo0QXDgiD
X-Gm-Gg: ASbGncvLsLFI6CPj22M2oXRrCFXvXIZXV92EfHFXKt2tRgSnoyL+3tHjAMzJf7T2W3k
	58S1e9LcDv4Jpi6uh2v9ckSEJS4GNRZvvNBkNkQC71Gqaf7To+LFaVcULBLRemGPYxHXIYlgo/z
	+AGE81SXme4NGW45mmMeqLNWAn4SsClPVcwXYXVoUSCLiOZ9xqnRXS4zy88rOCY17EkA/wgUSPD
	rVWqGYDmUYszdJIk6cdgsT5oAB0YZe6trzqprnoaiEdENvabWQmUHnYzDoP3DCBS4HRlyfKiBX1
	jAqpV4ZN1BdRGVN7BKV5Ew8mwMpcEiFb2FQOOTUS6/8ETQ3zQhcEM19PC9Wj2Emo8ElNW4RpwOo
	S6OCAutDpVFkEPwrqOqC3lzihT4EN
X-Google-Smtp-Source: AGHT+IFH+QOo/NEkimsMhFyuqVDKumuwl+ZBcNAhvEyEh/8JNY261/HUZg+DJlQOvRrIex+GY/wciQ==
X-Received: by 2002:a17:907:781:b0:af9:8d61:b78e with SMTP id a640c23a62f3a-afcbd9334a5mr216578466b.30.1755169223036;
        Thu, 14 Aug 2025 04:00:23 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91dfd4b31sm2542980066b.85.2025.08.14.04.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:00:22 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Subject: [PATCH v3 0/4] Add LTC2495 support
Date: Thu, 14 Aug 2025 13:00:16 +0200
Message-Id: <20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMDBnWgC/02MQQ6DIBQFr2JYlwY+Krar3qPpAvCjJCoNGNLGe
 PeiSVuX8/JmFhIxOIzkWiwkYHLR+SmDOBXE9GrqkLo2MwEGFWs4p8NsoLxUtJLQcGm4sK0g+f0
 MaN1rL90fmXsXZx/eezjxbf024NdInDIqtS1NbREN4K0blRvOxo9kayQ4euLvQfa0VhaYrbVi8
 uit6/oBGBvAw9YAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755169221; l=3931;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=Uy7vy8b0/Ve4PqRFiyW6SgaraGSuHiGGhfWaeYo9VOY=;
 b=CvHBPPMEo8jnWVMF1ozzyn2XjTsPKfLA7KZ0HfKOQMf74Gf2fZ4U6lqUTzC4ScnBRg/IUJDJN
 SeP+ft/nvH/Dj2Xt9+Po66bbxX4/TvQ8yNewXHThpI87rEHb1rxjCNP
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

Hi All,

This is the v3 of the patch series adding support for the LTC2495 ADC in
the ltc2497 driver, and enabling the internal temperature channel for
the LTC2495 and LTC2499.

Thanks to Andy Shevchenko for his quick, helpful, and continued review
of the previous version.

In response to the request to check for code size changes, I have run
`bloat-o-meter`. The results confirm no meaningful impact on code size.

Full bloat-o-meter output:
```
./scripts/bloat-o-meter \
    before_patch_4/ltc2497-core.o drivers/iio/adc/ltc2497-core.o
add/remove: 0/0 grow/shrink: 1/1 up/down: 1/-1 (0)
Function                      old     new   delta
ltc2497core_read_raw          413     414      +1
ltc2497core_probe             374     373      -1
Total: Before=11576, After=11576, chg +0.00%

./scripts/bloat-o-meter \
    before_patch_4/ltc2497.o drivers/iio/adc/ltc2497.o
add/remove: 0/0 grow/shrink: 2/0 up/down: 2/0 (2)
Function                      old     new   delta
ltc2497_result_and_measure    275     276      +1
ltc2497_probe                 158     159      +1
Total: Before=1946, After=1948, chg +0.10%

./scripts/bloat-o-meter \
    before_patch_4/ltc2496.o drivers/iio/adc/ltc2496.o
add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
Function                      old     new   delta
Total: Before=1251, After=1251, chg +0.00%
```

Best Regards,

Alper

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
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
Yusuf Alper Bilgin (4):
      dt-bindings: iio: adc: ltc2497: add lltc,ltc2495 bindings
      iio: adc: ltc2497: add support for LTC2495
      iio: adc: ltc2497: add temperature sensor support
      iio: adc: ltc2497: reorder struct members to fix memory holes

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   3 +
 drivers/iio/adc/ltc2497-core.c                     | 141 +++++++++++++++------
 drivers/iio/adc/ltc2497.c                          |  35 ++++-
 drivers/iio/adc/ltc2497.h                          |  23 +++-
 4 files changed, 159 insertions(+), 43 deletions(-)
---
base-commit: acbbb5a20971089064ca6b271dd251e629be8d4d
change-id: 20250811-ltc2495-572817c13fd3

Best regards,
-- 
Yusuf Alper Bilgin <y.alperbilgin@gmail.com>


