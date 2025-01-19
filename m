Return-Path: <linux-iio+bounces-14482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A17A1635B
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 18:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C927C1883C2D
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE0B1DFD8E;
	Sun, 19 Jan 2025 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtqDeMw9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF451DF984;
	Sun, 19 Jan 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307926; cv=none; b=udY8Ns/GkBuW4K4YtF/rNwh1kIXHHmNzZEAEb3VnSHT021J+U0RdjD8DEeDsJ7ygehwAbwhVasCt5vfDNRE+PkaSHowL4yXw78qEFjN59aZxoQwjLrByLK2HbvTU1RCBRsLB6dPuBj/9qKiVZT2cCZLkprn2Zl9YIHa8RVS6QSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307926; c=relaxed/simple;
	bh=13lwxD8OxuxW/JgjQOeaS0pQ+G4HQYmb55K45oqJFOw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uacO2w3WP4X2VbkAG4h0euEfvEBfREdBoJ0VU8wFgCnX4MG1giYpV/GKKwwhLywU8zTmrAoBbQNaeNt4jxASjwy7sxFRjgoZy3dWGMCs9/oQ2M+hqGSbg0r9X9wV+X5TftYQ9cq/yq6NQeV6dA0TLCbmEALWQrAl8VFHMQ16Czg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtqDeMw9; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-386329da1d9so1941769f8f.1;
        Sun, 19 Jan 2025 09:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737307923; x=1737912723; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkWAIW3gTiiFDWKCcqLALzuUttF9rKCJ8CPIBv0JgjQ=;
        b=YtqDeMw9Ed3rHgRbos5oC/DmUX4q4VIBu7XiXhxqDOOGriZ0S7vr2Xfjrskq7ZlPno
         KhyE20X5Adh8+wg4fRoMpGIhWbq0iQIdvwZy2sz5gujRLNAqJ0xOi7PGSIxbLVRiZfCS
         r4XS+JxQPeVC11tCKN0zvodwEH5xOW+xwWf/v2VioRSl4U30Y2Uv2B04py6M2lMU56Ue
         +sI0znSSDNfXBB/Ew/W+0kgqAqBz4rnz8KqjFF8xLOSJXpQLGWNijla9sF8PSzUZng4A
         gTOL/gPGITSl4HHPMK1mhzIn+1/BJlgCaE2SgpnCr3W4zTmQ70bcIYxJHDyu/uLoycBK
         Bavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737307923; x=1737912723;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkWAIW3gTiiFDWKCcqLALzuUttF9rKCJ8CPIBv0JgjQ=;
        b=XKOusEnu+/M4xRAtD9AJJXzQff44brRg8trt6QXeF+12mJ132UgsfzQvQ2WU5jBgRk
         JNeQyQmNHEFFH0j1DEiilpMX2CZAfvuQGwGz8lnN4e5REpjCDjgVQPM+o3eU0asfNz1E
         Hw/cZQ4oDRk9O4s2YEDZafhtENFlgCJdSHXgVOX5FPNneuQQXoMHY8fSZ82bi0X8PR9R
         i2ohrXs7xIZUhuzTFIohnQfviJOG+oxFQ5WAcrmnKo1lm1Hcq2jsB0vt1Wz6eGeSQPFn
         c/8aeTZEYMs+TyoFXBgBpvzfLkcyrI338JdmuRY98HGOMY814CV6WQbpEBxHOLwWvo+5
         arUg==
X-Forwarded-Encrypted: i=1; AJvYcCU2nYHGYdjCPeO/lbJ16VODkxtpBVwSzdmm7qN2s2X+ls3EkgjbYB69nODmr53i7e7KSNn8tLAth1pO1Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7XZNHmwWiLXx5u0DRfbc4N4qtSbv2onc81oigcvQwv2wHND+P
	UB/yIdprndHFnZrAkg4Y/yShj0+LTU3gOfBDw3+/q5ZgCVf3d2xv
X-Gm-Gg: ASbGncucqM2j1DM9IKS6oHK3qL1sbUkseQ3gGo/CYJHd5wc64U+khvmBiNmmNSYUK5B
	YdQVt9J9f6A9kZIDHLJJ40JIFk/sNrFuhkKEHrs6SKPiS6Flxyov3GtEp9mDZGGrJS5VUEXU8rQ
	aOteYUQR58DCOJIGs28ZLJSU6DKILNfqV+2B7wXQPebaAGCFu+fwreCu1hm2yAN9tCCrZWqn4sX
	XK7qCRu3La7/MdByHOwadyOm2oAfsTske8QLoLQCHeiB6pDJRVl5s4l9Rnm+R7BubhYe8PPcCy4
	7JwOUe9/Wx7qq8IHrku8YIxQnkDI/GJuilotChGb/zABM5jDoVpsN76eSJjlnWPdfTBS8BWpQf3
	bFfuNz2w1P9b79o7U
X-Google-Smtp-Source: AGHT+IEQKmAeAYpZdZYx8uWBP9xvOOAjsiCwyUq6WalID7pwHnSCJtEu6a5Un3BHq2iCzOq/ROsoDw==
X-Received: by 2002:a05:6000:1863:b0:385:f560:7911 with SMTP id ffacd0b85a97d-38bf5655589mr10046924f8f.10.1737307921221;
        Sun, 19 Jan 2025 09:32:01 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-ec17-b16a-8f4c-782f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:ec17:b16a:8f4c:782f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32221e2sm8299423f8f.36.2025.01.19.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 09:32:00 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/4] iio: light: fix scale in veml6030
Date: Sun, 19 Jan 2025 18:31:57 +0100
Message-Id: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA03jWcC/13MywqDMBCF4VeRWTdlZmJVuup7FBchjjrgpSQlt
 Ijv3uiyy//A+TaIElQi3IsNgiSNui45+FKAH90yiNEuNzBySWzJJJmnCi2a6N0kpqGSe9vUUks
 F+fQK0uvnBJ9t7lHjew3f0090rAd1Q8L6n0pk0BA3JNZ1SOwfw+x0uvp1hnbf9x+CzR9nrAAAA
 A==
X-Change-ID: 20241231-veml6030-scale-8142f387e7e6
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737307919; l=2881;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=13lwxD8OxuxW/JgjQOeaS0pQ+G4HQYmb55K45oqJFOw=;
 b=oeHUNi7CiG8mYMPok+R+DvGsbImo3pLwKQ9CFUFKe3el/LdxuRBdMMCS3eIyvh2etaTdINPJT
 x1paIDz4YsuDbLgvqCapxr9QHz1Jz4svk1B8zh8l109g7Lsf6hx+x8b
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series follows a similar approach as recently used for the veml3235
by using iio-gts to manage the scale as stated in the ABI. In its
current form, the driver exposes the hardware gain instead of the
multiplier for the raw value to obtain a value in lux.

Although this driver and the veml3235 have many similarities, there are
two main differences in this series compared to the one used to fix the
other driver:

- The veml6030 has fractional gains, which are not supported by the
  iio-gts helpers. My first attempt was adding support for them, but
  that made the whole iio-gts implementation more complex, cumbersome,
  and the risk of affecting existing clients was not negligible.
  Instead, a x8 factor has been used for the hardware gain to present
  the minimum value (x0.125) as x1, keeping linearity. The scales
  iio-gts generates are therefore right without any extra conversion,
  and they match the values provided in the different datasheets.

- This driver included a processed value for the ambient light, maybe
  because the scale did not follow the ABI and the conversion was not
  direct. To avoid breaking userspace, the functionality has been kept,
  but of course using the fixed scales. In order to ease the
  calculations, iio_gts_get_total_gain() has been exported to avoid
  working directly with the scale in NANO, that would require 64-bit
  operations.

To ease the usage of the iio-gts selectors, patches to support regfields
and caching has been included.

This issue has been present since the original implementation, and it
affects all devices it supports.

This series has been tested with a veml7700 (same gains as veml6030) and
a veml6035 with positive results.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Rename SEL_GAIN to indicate they are in MILLI.
- Split first patch (regfields and chaching).
- Use regfield structs in chip struct instead of function pointer.
- Use total gain to derive scale, avoiding 64-bit divisions.
- Link to v1: https://lore.kernel.org/r/20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com

---
Javier Carrasco (4):
      iio: light: veml6030: extend regmap to support regfields
      iio: light: veml6030: extend regmap to support caching
      iio: gts-helper: export iio_gts_get_total_gain()
      iio: light: veml6030: fix scale to conform to ABI

 drivers/iio/industrialio-gts-helper.c |   3 +-
 drivers/iio/light/Kconfig             |   1 +
 drivers/iio/light/veml6030.c          | 608 +++++++++++++++++-----------------
 include/linux/iio/iio-gts-helper.h    |   1 +
 4 files changed, 299 insertions(+), 314 deletions(-)
---
base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
change-id: 20241231-veml6030-scale-8142f387e7e6

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


