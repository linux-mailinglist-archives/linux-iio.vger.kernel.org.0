Return-Path: <linux-iio+bounces-23444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B5BB3CAA9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 13:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0C61BA32D5
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 11:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71CA2737F0;
	Sat, 30 Aug 2025 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3VrLx9N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30529450F2;
	Sat, 30 Aug 2025 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756555093; cv=none; b=gj41pzgk+o9Uji1JO+TFbb3/0DKyN+SDmx10ihU0g+qpMe3ToK6F+gh5ctCvrNLB6LMj1MJYhjy6U/orsvo14zw8AJPrY7dijCW3geYMHUnOwYbFB0DhgsZvIx4D09Vo1diIu0YKd6e4Vd3vD+AVka0S63jYP+EKwV1RwYDPJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756555093; c=relaxed/simple;
	bh=miazadIUwWLfO1bOZncrlgcy9YOnwXz8gaUoleSYRPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBFpBkPT2Uz7hHBLO42Qd2hnqrhkquI/NCvdYkL6uJAbkVtVKb3AvN7cJu3PwTlEhY4MO2sbDFYWoMOvnh/YucOdhcb+GThoP1iUAHWsH4cxPSP1fbuZstU/t8cFb9eIMPz0qhQd2AacRBajWSWSaGLrmN/H/Pmr9WpXpTNuUD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3VrLx9N; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b49cf1d4f6fso2107638a12.3;
        Sat, 30 Aug 2025 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756555091; x=1757159891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJod10JV24XWuNj4XpZd/2BflCc9KsUdicN8e0gz4Qg=;
        b=A3VrLx9NIln5xmkztLXbAWNLQuVj0eNO7X/JT2fHUTV1HDd+EyZKTwiMECsaBge2rj
         kEl/VLtoZPqxo8JPUJWvQhuCecgnPUC+jwoi1BJdDb8xiNf4Y8VxSfW/Yj3sD2YjmtIX
         IM2ioB9+BauGD9gxTqdkV8R0p+y4NZoX8D5BSv/o7nVXw6F5LWD4Py8ksYTTdVjSvHWH
         a6enrnqJyOsAo5BKWyezDEdh0eMBfQY/jr2HtovMpEGInMGcTKFSvDe4rs86dc72iU9z
         y8oceQj59QWZ1Gpe6+7uJkG7t/maumZSPF9NIdFcS9yDgW2cUKofJ8GWyov7gxmV8/1i
         zitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756555091; x=1757159891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJod10JV24XWuNj4XpZd/2BflCc9KsUdicN8e0gz4Qg=;
        b=C8AePIkfocS29H3wFaertRgTUMjQKnTbK64lTFCAQ8/A+JEuIAi3O582H7UtGGdfOx
         kUQb5JZ0UBD7u7RjSBgAfpeGmJ7Umw9/7dE8Du5i42MysLnejB5aUlb03Xf6rnYYwJ5G
         DcwDoAd9lZhptxH5kgRsjqOV9ZF7KgKWN7XTrXPX/Y7OPl2TW/3Mg/h3kbPkbXIPHAWV
         TkYJnjiOsCV95rm13kxqvtDPWr5AzZmctjpzKFgq9flzQowk6hXHpnb+OZxgzGszhT4D
         ZsMzbEPDxXr5k61sWdvNfy/sw7K76k8a4ir5UlbA1A5Ss3afwddlN1l/C6VGg5oE1dyI
         Be4A==
X-Forwarded-Encrypted: i=1; AJvYcCUkAka0IhqnwmIkxgVZcDsFC8ZzgBsAt67lSA/mWO6gUS33pGVeOyXvRYxJnWUExtC/THs31s21So4=@vger.kernel.org, AJvYcCXMI7VOFcqbyfKKLis7MFDEfOLENRHGjpWrxhCHIHeEnPI4CDmO+ZUKRj+fKjthRooSP0QReju7Nd4Gpmuq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxzlx8v1YxnEjoOcZMnWDGMHiG6YDV65FdPS+qAfmhnzL6+o6d
	TM5F5nyvg8WjTiusowxYzSGxzSi9Pm2g8D7WDsGrGn5pXoL0FNXwBltX
X-Gm-Gg: ASbGncs6WTLO2lZeeGllL7UPJwUdgGn2tSCyJbItoR14eD4zSeZzdPSl4k1crRgwna2
	Ylxs5ikFFsLbSZBQCHFAZPQOTTZPEqXvd3GiHa4W/KELAkQd6VjGM7BHsA47XP8VzV9xFeCyae0
	uYa+fnqRJVy1wDT525ttwm5Qfwk4XDWAxaFYzO4aNnft8yzl6LaZWqZQV5MY4Wc8Yyqn9KyUOJm
	zUPUDKZ7+HBRWesMxwjh8P8m+nK0tv1+Bjc1muThvnFBbWL+GcWaTp4NI2HFxPmnDtl/D+F3qRK
	JiOVIdYHVBnYIktAjK+nzC5zLqkm7I/+g7Cmorl5lLZp49su9T3asA0uNuqS8z+zQ3qBYBLSclc
	SbIG49MY5cBotVwRy231JfxUrP8ZK7A0yvqgfJQ==
X-Google-Smtp-Source: AGHT+IGmRpjX+hw6go6aJjkaZEex0bqMMz44W2K2BXoSVNSGSh36r9gL/34NuvvIGWIQ673pCEH0fg==
X-Received: by 2002:a17:902:d512:b0:248:f653:538f with SMTP id d9443c01a7336-24944a12af8mr28999825ad.27.1756555091319;
        Sat, 30 Aug 2025 04:58:11 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:4498:a747:8dce:6184:1430])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906390b55sm50966595ad.97.2025.08.30.04.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:58:10 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: lanzano.alex@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Gustavo Silva <gustavograzs@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] BMI270: Add support for step counter and motion events
Date: Sat, 30 Aug 2025 08:58:55 -0300
Message-ID: <20250830115858.21477-1-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for step counter and motion events using
interrupts in the BMI270 driver.

The step counter can be enabled, disabled, and configured with a
watermark, all from userspace.

Any-motion and no-motion events are generated by detecting changes
in acceleration on each axis.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
Sorry for the delay in sending v5.
As a reminder, patches 1 and 2 were already accepted in v3.

Changes in v5:
- BMI270_G_MACRO_M_S_2 -> BMI270_G_MICRO_M_S_2
- Add patch #4: ABI documentation for the exposed sysfs attributes
Link to v4: https://lore.kernel.org/r/20250711-bmi270-events-v4-3-53ec7da35046@gmail.com

Changes in v4:
- Reworked the threshold for the any-motion event so that threshold *
  accel_scale is given in m/s^2, in accordance with the ABI
  Also the range of available values for the threshold is now determined
  dynamically based on the value of the accelerometer scale
- Fixed alignment and styling of some statements and macros
- Simplified the return statement in the bmi270_read_event_config()
  function by returning the boolean expression directly
- Link to v3: https://lore.kernel.org/r/20250616-bmi270-events-v3-0-16e37588604f@gmail.com

Changes in v3:
- Avoid the usage of set_mask_bits() macro on 16-bit integers,
  use the bitwise operators instead
- Fix indentation, alignment and style issues
- Link to v2: https://lore.kernel.org/r/20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com

Changes in v2:
- Reduce the scope of mutex lock when clearing the step counter
- Change the type of the 'steps_enabled' variable from int to bool
- Add a new DMA safe variable to the device's private data to access the
  feature registers
- Remove unnecessary mutex lock
- Fix a build error found by the kernel test robot by initializing a
  local variable in the `bmi270_update_feature_reg()` function
- Remove dead code in the `bmi270_write_event_config()` function
- Add macro definitions and corresponding datasheet references for
  relevant constants: step counter maximum value, step counter factor,
  and threshold upper limit
- Remove the event bitmask from the device's private data. Read the
  registers directly to retrieve this information instead
- Use IIO_UNMOD_EVENT_CODE instead of IIO_MOD_EVENT_CODE where
  appropriate
- Fix shadowed error codes
- Change motion event to be enabled on a per-axis basis
- Create pseudo channel of type accel_x&y&z for the no-motion event
- Change no-motion event type to IIO_EV_TYPE_ROC
- Link to v1: https://lore.kernel.org/r/20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com

---
Gustavo Silva (2):
  iio: imu: bmi270: add support for motion events
  iio: ABI: document accel and roc event attributes

 Documentation/ABI/testing/sysfs-bus-iio |  40 +++
 drivers/iio/imu/bmi270/bmi270_core.c    | 384 ++++++++++++++++++++++--
 2 files changed, 404 insertions(+), 20 deletions(-)


base-commit: 91812d3843409c235f336f32f1c37ddc790f1e03
-- 
2.51.0


