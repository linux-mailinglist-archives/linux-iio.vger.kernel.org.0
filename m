Return-Path: <linux-iio+bounces-26705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32484CA167B
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 20:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3308A303212C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369D93321D4;
	Wed,  3 Dec 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSKoJovZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2328F324B26
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789580; cv=none; b=Ufq/6utZULWN0mDFny95+FguvXS1XA24OPGyrR80A3nB7PGGz5MymMNmN1O7NW/T63929lU7xDMqLexggp0W+aIqOz1gm+zq52a4F/SCdhKjeaiSyEMebBFfqdvGxo3nfgh9NsaBE4aN1jKnemsgGQtz6UoA0jl0rBasl6gcScs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789580; c=relaxed/simple;
	bh=2Ews3nCp5RcsOWe3/ZSjBTP5CQV+y44P8Wfs0s+BuQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=udvZ6HBk30yZ0wcEJEQ6jseqbm8828RKoEal2+jB49ASR696UuW9SVFe5FgOVx3G/csbdZyxZVALl139rlZX8DiTh5X+8te57Dlq3eQ1Wa3Ax1r4ZNkU8leSgHSxkCfJEkzVDHtBwIOotTHo1IaIAjR6kUQxnG3XhBnK0rJLcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSKoJovZ; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-559836d04f6so78568e0c.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 11:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764789576; x=1765394376; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsWm84k2qtEC6zCHV3II8eQa45w/fBWOUPbdCR/O5So=;
        b=JSKoJovZ/6DwuAMPU28HIaO5WEJv1YyUM7WDiDG0YFGHoNASxZC++RwXzs9kwDUxVn
         mnz0mvrrehgJDex3FyCYWWf1fEnu/t1ku9CYgywOz7Q1AGaW75wPRQGWx83VwWdOpdlY
         DqzYV2xRvUmgkNkog0PAYvmYqqNjnLUG2k6i+L8BMYH5K+g3pEkVYPyaMvIDaFLKc+lh
         SJCJaN6/+IIMX1GQWQfOh+NRTEMFFmKZLwxkvZWQnpA5c5jWypSXTq6kvzY/99urB8B2
         /tQbyi5IwvLCLBElOJHnwzO1UvuCnHFdEijuA2UvIjoNG5l8HDlo6ppY0wDUlMHVyKBj
         DiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764789576; x=1765394376;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsWm84k2qtEC6zCHV3II8eQa45w/fBWOUPbdCR/O5So=;
        b=PIV9u6h+y1z0V1BsPtTZgM4dqneXftvhjftgrjV+XCKxKECvqXZfw/Fn9e9OM7MPm+
         uFTo2+77fJG8wP7qjjvBFjUZjcd+ZhQU0Cxs4avrWy2+le5cTUaK1v7LJV9lid+J/GUJ
         o4nFc9jE6Qex8A1NQnhrqyBajJm+P0KctCpzC8nlD8o1lGisYkv3iPUNdhrdEVs1RPwG
         DnqtdmPBVi/VpTGyLOpAYejQFwFmXCDpmDLN7ZOdQykpLY0MSDf0KVSo5ZGoaYu3Pbwm
         9el5U4h5QvtzHcBj2SPokkEJHdEpgDpWunjjT0IDHcxv8RyDvhrwtGZZ3Vnrm1yTz/zE
         aZSg==
X-Forwarded-Encrypted: i=1; AJvYcCVtEoVG5pN8JY7wmveQOdFzNx9TztgQSW9AytblA7tEUZXDMpAoHn9gXbiFUvjGRUYbGDp2b0GIInA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNnlqzfrGKTJpSNhDVlxFUS2uWfstGWueJ4O/gYA6b4Y2qDq3
	MVVz5/eY5PIjgu3ypWh6WKwUxHRFsSubgIwymCcAI6hrrITL8o6mfkjj
X-Gm-Gg: ASbGnctgTQruU9VjglsY7cFPqMeCehQhVq++NAWKxLNhlKuCT2NcCl6WMFGlM5sXg+s
	A3LZWXUQwl5dHLhtKHAsjVjdqRcNLZjFrNNFeLkipqlcZa629lZQEGzsNCrSQGRdYbFbGLtEH9g
	GL3Zhc8A5i9Zjz8BrDDWq2zwYZWDYgY+VEo5xxGfJeFrQpnJ2N4NgX+AeSXLZT9uC4LcnKKM4QH
	u0VtduilJT9drfm9q33PD/kW0+eQyd7jWrHG4QEerNM3X5Oy9agCDw2O8pWG0glDy4K1gyPYIVp
	UAH37ZRQdiQD4mKdRL7AruNGloLEa/5izt3BSHIPjqPao/V0V6G61UyqDudxEhIfcUdB6dsN4Xd
	V4/2wbmw7opAM8yVNhNNpw4DRGkRECc6jwD5NwnOwJ0pYdwwhp7IN55m/VEaRI5ewzRUwpSx6B0
	XKzxAIkbrdE/1v
X-Google-Smtp-Source: AGHT+IFawNilC7IYRWjKVXVVeZWmWiJzDYwMx1u5PNwmhAzymV5Livw2jtngj7e3+W9FLy7L6P6jMw==
X-Received: by 2002:a05:6122:2516:b0:55b:305b:4e29 with SMTP id 71dfb90a1353d-55e5bfe64c5mr1532422e0c.21.1764789575866;
        Wed, 03 Dec 2025 11:19:35 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf4e1d56asm8121346e0c.4.2025.12.03.11.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:19:35 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH RFC 0/6] iio: core: Introduce cleanup.h support for mode
 locks
Date: Wed, 03 Dec 2025 14:18:14 -0500
Message-Id: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPaMMGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ2MD3Zz85GzdzNyCIl2zNCMjcxOLZEPTVAsloPqCotS0zAqwWdFKQW7
 OSrG1tQAFzaXRYAAAAA==
X-Change-ID: 20251130-lock-impr-6f22748c15e8
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, 
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=2Ews3nCp5RcsOWe3/ZSjBTP5CQV+y44P8Wfs0s+BuQA=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkGvRp1XLc4OYPm/FDJq/q6YFfM4W8frz1/z/hnyvo7n
 YpChbemdZSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBE7Kcz/M+0N9Kq/3vA1m/v
 lO3LGR2755830pTXPnL0nPCf5B+rNkxkZJilu5BxSXHHZoUT0b//7gt6w7TBiZO3MvtMyx3xYiN
 bBh4A
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi,

In a recent driver review discussion [1], Andy Shevchenko suggested we
add cleanup.h support for the lock API:

	iio_device_claim_{direct,buffer_mode}().

Which would allow some nice code simplification* in many places. Some
examples are given as patches, but the last two are the biggest
differences.

Although I was never entirely sure if Andy meant cleanup classes for
locks or for iio_trigger_notify_done(), I still think this is a great
addition to the API :).

Thanks for taking a look!

* It's important to mention that David Lechner expressed some concerns
  about this [2], hence why this is an RFC series.

[1] https://lore.kernel.org/linux-iio/aSsBdJZDWcadxEHC@smile.fi.intel.com/
[2] https://lore.kernel.org/linux-iio/248b009e-0401-4531-b9f0-56771e16bdef@baylibre.com/

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Kurt Borja (6):
      iio: core: Match iio_device_claim_*() return semantics
      iio: core: Match iio_device_claim_*() naming
      iio: core: Add cleanup.h support for iio_device_claim_*()
      iio: light: vcnl4000: Use cleanup.h for IIO locks
      iio: health: max30102: Use cleanup.h for IIO locks
      iio: light: opt4060: Use cleanup.h for IIO locks

 drivers/iio/adc/ade9000.c                          |  4 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  7 +--
 drivers/iio/health/max30100.c                      |  4 +-
 drivers/iio/health/max30102.c                      | 24 +++-------
 drivers/iio/industrialio-core.c                    | 34 +++++++++-----
 drivers/iio/light/opt4060.c                        | 52 +++++++---------------
 drivers/iio/light/vcnl4000.c                       | 24 ++++------
 include/linux/iio/iio.h                            | 24 +++++++++-
 8 files changed, 83 insertions(+), 90 deletions(-)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251130-lock-impr-6f22748c15e8

-- 
 ~ Kurt


