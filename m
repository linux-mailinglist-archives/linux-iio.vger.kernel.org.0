Return-Path: <linux-iio+bounces-27492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD6DCF74A1
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 09:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBD9C31773AC
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CBD316912;
	Tue,  6 Jan 2026 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POPEMgLs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECAB316197
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686834; cv=none; b=HSdY3jGRumYhOAr/s5JreyhA8xgPUBLbuZVOXqNGI7+2djY9DNWLFFoFH2Hay5B5YXe04RBJVTOkd8EQddIjWzDIzEcbRC4Hpwdy8IZa8+qR/N1njWM+oqRG/JZ53HNSLzmqngV6cJX7DAZulkg9z4YQwZojBHyI4D46yq62b7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686834; c=relaxed/simple;
	bh=H51AqsAvN4LukC4x3boJnwjsgg1viNsO8J1scP7xvlY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SBSy0q2+iSlyA25t/Jl6ue6CrBts52B/yPCONGsAacLRIQ4jk5c+XnBnkLDKWev1TOnJRZdDiOPrZIl6rEZrsA6vrp/RwxfvG7Gumu3bHkSWxx6LMjIOPWpKG+pua4zJd2bMA71ijOdZ5XNpcniBciXKq1Dabz/89sdyUIWk9Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POPEMgLs; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5eb8f9be588so552902137.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Jan 2026 00:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767686829; x=1768291629; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=biXuMr/nGp2EvgJ6L44BwMP+XXmVCC/TEkgK6E6Xo3I=;
        b=POPEMgLsDKaE2deT3tVzBh97Nz6uHU8KXEvcjXajT4wPnAT1bVcDd6k0mxWVdUMw4Q
         WW6KuY1wVhCE9bEMoBI0ge5PzFJ+c93eoHj8Rnyp/5SYKtsbRQ4Z+E6Xm5ChsUgUdLHb
         AQJqA0dlk91k3BChzw7sNbQb3R9UZ2ET83moyNx/1y0npiGGIvufDQMjPaFgN5OXiid9
         yawZ2Bg/NocWpJpck6u4nDyBy13PoumHqZghBIGDYxl7J6ZeDrMNZj6HV8GeRxs85yjm
         Cgk+30bYBbfrNz2Wv3qFjWSVLuBV9HuxZNAcaO2Zuryfmk07ARYw1IYrtcL8gasfavJ1
         6jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767686829; x=1768291629;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biXuMr/nGp2EvgJ6L44BwMP+XXmVCC/TEkgK6E6Xo3I=;
        b=e6JF51cs/4oplrJvic9hCWgF6J2mva0Sr9faGfoLotjGSv/dbOlgqldXhg7JOdCmlg
         mJHEFsnvG9BZyckGhUd6DfLjA6B0nul4VDw9VtZ60FmEN9xHWH9NAlPL3ACbi9Jn4pZF
         J9azscJvq+2dRm5Br4wvxJXeBPtkteLk3gacR3QgplyfhnVpMpHasmyvl+4cXxAEKD2g
         BpyK5uyFe08rLTazoPcumJpKOB2rUkck45DUENyoBASCxpYgUVp+Fm4qdbiTv2LzNtlt
         CDwOoA/ya+J6OHb2EC/fYZdaxscQzjPcn/idgP0yUVFM32sREeZKRdPZShZscWsES+Sd
         7tRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxM7C6GsPb+mV1LNXUjy6A+O5cJbhCbmoiUmCHRv1hmMQM/YpCHtPRVxnO++09Rz0nPq6+Ts+TZBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66G+A7QaQvMfhIfMFrJplS+zjAiWjPdH8a3lr+UGBkwwblU0c
	9ZuxoxMW3NAAVib0W6Pxb9xy/u0hYiKpzLLe7AIFVpwr04LGKeF0qHIc
X-Gm-Gg: AY/fxX6hTxygA42QEdBQcNwU00pCbeMGKqY6B0Q0Y76Y7YKOpk9NX4epOkfbeVUSuXW
	BCHfwnCdx3iU5ltXSWH6DaUJnM3qH+9Bi3xOcC0WvwBxPOx6b9Ct2LZUWCaNJ2DgKDL5QC+GgGf
	rqH5h8j9EG1wtch8O8QNN6Gp6etoHFIDKYXaYP9MzzrkDI4W3ofAbAhoFj+GjOWnI9OU1auTzNJ
	jikAAdgLyYY7OjHsHSXuzRrrKxCrqGAqsMdoKQuTZkLRVOpODTps6ujTLb1tybMyQMI4O0hCkpP
	ktG5WJpa7HLf4UGSBuaM1DOV9NrG67DvoTqxdY0SvzO0PB1aP44Qomis4SilOvcJstZ0cehPqY1
	B69odtKfJEe/MU2zGeyOk2Rh0eFTab52d/4qLA5tfq/4uKhU2nlTOxgn/utUKyq936ylxUD33SM
	hkDiFYOM9uYNFZ
X-Google-Smtp-Source: AGHT+IHmioVFP08GI01Nc8JhNekoVnKFd9MQD7ix0v/GYc8lCbyEExeYdsvPZdDGlSjsB6ThnUchRw==
X-Received: by 2002:a05:6102:dce:b0:5db:e6fa:f7fe with SMTP id ada2fe7eead31-5ec74524ed7mr596607137.24.1767686829463;
        Tue, 06 Jan 2026 00:07:09 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124a3386sm457615241.11.2026.01.06.00.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:07:08 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v3 0/7] iio: core: Introduce cleanup.h support for mode
 locks
Date: Tue, 06 Jan 2026 03:06:55 -0500
Message-Id: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ/CXGkC/02Myw6CMBBFf4V0bU1nWh668j+Mi1JamCiUFNNoC
 P9uwU2X5+aes7LFBrILuxYrCzbSQn5KIE8FM4OeesupS8xQYAkgBX958+Q0zoFXDrFWjYHSNiz
 952AdfY7W/ZF4oOXtw/dIR9jXfwWFzCoRuOCt0uC6Sl4Uyls/anqdjR/ZXomYmQC5icmsXKvqt
 tPaocrNbdt+tewNetwAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4751; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=H51AqsAvN4LukC4x3boJnwjsgg1viNsO8J1scP7xvlY=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkxhxZnfoperHj45eOGr9cmuvieSehmvyio5+Y49YBY3
 xH3TXZKHaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjCRxbsZGebdUggRE2vbtWvB
 udAJ37894Xn6WurLf7nlXT/2Jjp/rIhh+B+1y4bH6a00w6PsyqlJJ+aoBydNn6T1xfErhwJrR1K
 QPysA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi,

In a recent driver review discussion [1], Andy Shevchenko suggested we
add cleanup.h support for the lock API:

	iio_device_claim_{direct,buffer_mode}().

Which would allow some nice code simplification in many places. Some
examples are given as patches, but the last two are the biggest
differences.

In this version I dropped the RFC tag, as the general feeling is to go
through with this after some modifications. Main one is the addition of
IIO_DEV_ACQUIRE_{BUFFER,CLAIM}_MODE() wrappers to avoid drivers using
the guard classes directly. I also added comments on the forbidden ways
to use this API but I definitely still take suggestions on this.

For now I dropped iio_device_claim_buffer_mode() rename, as this point
is still being discussed. My suggestion based on the RFC discussion is
to do it, but in a separate patch (using coccinelle) and while we're at
it rename the whole API like this:

	iio_dev_mode_lock()
	iio_dev_mode_direct_trylock()
	iio_dev_mode_buffer_trylock()
	iio_dev_mode_unlock()

Let me know what you think and thanks for taking a look!

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v3:

  - Reword commit message of patch 1: infallible -> unconditional.

  - Drop "*strongly*" in __iio_dev_mode_lock() kernel-doc and be a bit
    more clear on the function's intention.

  - Keep comment about inline functions and sparse markings, but drop
    the __cond_acquires() part, as the new implementation makes it
    unnecessary.

  - Implement iio_device_release_*() as macros around
    __iio_dev_mode_unlock().

  - Rename iio_device_claim_buffer_mode() ->
    iio_device_try_claim_buffer_mode() to avoid silently breaking
    out-of-tree drivers.

  - Drop the `_` argument prefix in new macros, as there are no name
    conflicts.

  - Drop "dummy" from IIO_DEV_ACQUIRE_DIRECT_MODE kernel-doc, as the
    `claim` variable does store the error value.

  - Drop IIO_DEV_ACQUIRE_BUFFER_MODE() until a driver actually needs it.

  - Rename IIO_DEV_ACQUIRE_ERR() -> IIO_DEV_ACQUIRE_FAILED() to make the
    name more clear.

  - Rename IIO_DEV_GUARD_ANY_MODE() -> IIO_DEV_GUARD_CURRENT_MODE() to
    make the name more clear.

  - Add missing . in iio_device_release_direct() kernel-doc.

  NOTE: Andy suggested __iio_dev_mode_*() be exported into the IIO_CORE
        namespace. However, this cannot be done because these functions
	need to be called inline, so Sparse can see the __acquires() and
	__releases() tags.

  Happy new year to everyone :)

v2: https://lore.kernel.org/r/20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com

  - Add __iio_dev_mode_lock() (formerly iio_device_claim()) in the first
    patch.

  - Added comments to make sure __iio_dev_mode_lock() is not used by
    drivers to protect internal state, or in general.

  - Add patch which re-implements iio_device_claim_direct() using
    __iio_dev_mode_lock().

  - Match iio_device_claim_buffer_mode() semantics by reimplementing it
    in the same way as iio_device_claim_direct().

  - Guard classes now are prefixed with __priv__ to make sure drivers
    don't use them directly.

  - Add IIO_DEV_ACQUIRE_{BUFFER,DIRECT}_MODE() documented wrappers

  - Avoid any function renames (for now).

  - Rename dummy variable `claim` instead of `busy` on vcnl4000 patch.

  - Avoid scoped guard in max30102.

  - Keep using iio_trigger_validate_own_device() insted of
    iio_trigger_using_own() in opt4060.

v1: https://lore.kernel.org/r/20251203-lock-impr-v1-0-b4a1fd639423@gmail.com

---
Kurt Borja (7):
      iio: core: Add and export __iio_dev_mode_lock()
      iio: core: Refactor iio_device_claim_direct() implementation
      iio: core: Match iio_device_claim_*() semantics and implementation
      iio: core: Add cleanup.h support for iio_device_claim_*()
      iio: light: vcnl4000: Use IIO cleanup helpers
      iio: health: max30102: Use IIO cleanup helpers
      iio: light: opt4060: Use IIO cleanup helpers

 drivers/iio/adc/ade9000.c                          |   2 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   5 +-
 drivers/iio/health/max30100.c                      |   8 +-
 drivers/iio/health/max30102.c                      |  33 ++---
 drivers/iio/industrialio-core.c                    |  86 +++---------
 drivers/iio/light/opt4060.c                        |  52 +++-----
 drivers/iio/light/vcnl4000.c                       |  49 +++----
 include/linux/iio/iio.h                            | 145 +++++++++++++++++++--
 8 files changed, 196 insertions(+), 184 deletions(-)
---
base-commit: fb2f4eb29a258145b0336601f00509cab6e93e7c
change-id: 20251130-lock-impr-6f22748c15e8

-- 
 ~ Kurt


