Return-Path: <linux-iio+bounces-28027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FD9D3BF0E
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A35C3622C6
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 06:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053E836C5B7;
	Tue, 20 Jan 2026 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPfKlgtk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F636BCE7
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890074; cv=none; b=b6KQuaAQtMrXQFkR3bAIMcUQS9mk6naNUVMDupF3wx9lOGyrGl5HfkfJOpifpH/8Wm5mjf79w10S15UAF6bYkhFWj3amWrpSSt4Z7hF/IICyQZLYOHkywm6AIRBJL3KEkFxPvNd5aTaCR7hIhMQqsGgHQ4lzOxUsmvLqArANOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890074; c=relaxed/simple;
	bh=8ACIUTMxM/zKXo7x/eO1abUeDEvW7CEDgGcDZxCz8g4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KI+vcl4ZYNkZUPStLDpUS72s6y2Uuu09V2c9B9SBezizF2z+UG85A8fWSobkBsXs70eiM8L8whOFXfC9fOUPTrnr4IihxgwujaeQw3GUV2CGDM6hUezjxyXIAgfQEyqnarHRsOx0OKRoc8NyYgHCIAAOSgQua6Niclb50gewBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPfKlgtk; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5eeaae02888so1391950137.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 22:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890071; x=1769494871; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/He2bNX5Xacc5gQDOXo1/F0LSaAQyrezJ+tls86n2g=;
        b=OPfKlgtkS2FT3t4XLKDCEPku4R+P/3RYyjvvielTspwhgQIScXL4W4hMbC/Il+8y3z
         IMoQdOVRM12Tc0rptmrjND9exuCzJvqWp1IgguaTRFytut6OaPOqnljN3CTmd5CEuyIw
         ytPWmQfNyiH7YUyQViazdLN0voldkaUlBHeEFO5MXw6xwWZNl5E7hKkCdlK22sP/Z2TB
         7fppHYKRH1yFvG22g71YATFpTLJsj6JcOkuce97ZQdTJ/5md6yytTrmlW8hnBCeG4ePJ
         HkR8kL42O4ouIXP+3g2HWoIUzqWwHxI8tEW3bDXnBz65MVNfenHzByEsoeRRvfobJKEy
         Nskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890071; x=1769494871;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/He2bNX5Xacc5gQDOXo1/F0LSaAQyrezJ+tls86n2g=;
        b=OckrbJ713bA1MkDipAEPEQoO/sxmS+Ue4MlEEO03OQZha1L3ZmEKqOGC2+cg2aPiCE
         P3J48FadVeaaQWYXfAK/XZw56iHvgz2Kne2R/aqiT2Bs3uTu1f7iKa9ejTGAFW0fyn17
         LHrl4ZNzVsxbURln1hS7nGtAChNOzNR+8BuOCO1SEyLafyqgX3BEba8Khe4gaG7pampi
         0DMEF5XKoNSWhtouzvKH/j2gzEW2J6F9Xdvu/0YVBa98NuzvDARiBFKaTdr2m/SwdrF9
         pK5VXVnyBRYEKcI/AbQcHKtjkN3n5UkNW/CMjU9yY+PG+8pk3WKNCaZOlbvfC6uVt5UK
         jRlw==
X-Forwarded-Encrypted: i=1; AJvYcCWEqCRwiBshEGO4W2YzFSvN+y3oOc3v/h8WV04jAUZgm1K1dy/aAzJqE1sUDSahJLSpOiuSFtcZO2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygfy7iydcktRoZPw/vcjoMXnp2zOao26CQVkKX9ka4ZrIejJvH
	n0FIz5kQ+CCToxgY1z0WFjsKJLgunfG4sHK4qLY8aHUMMu5ECy8SIfjj
X-Gm-Gg: AZuq6aIgR/bwsUDwCmihHOkZMgDz31Yt2scd8/aeiFbE6RIZd39hamUAlvIfEDIVn9p
	zr4kYXBjWlbdeX0lc0BLmTkH3633Mq28TkzjcEzvweH/oteVTObLyQuUcffW2DAhQjJeO4ZTH4V
	DUu6uxTaB3YU5ufkC4GUpwrA0BxqGjNtRxrr9xEZLnfs5Urbd+gkDH0Z8Nlysr60Sik/nBf+VzW
	eu23jSWQAM9hWHYcn1YyFK9g1sB5yB8hrtZQrra6iTxmacX4/GjcUqBUhEuaP/XItZcYSgdIs0C
	RzxH7GScIilWuyvfjd25dARkD0vezL1CbO0EooRnwepmu0e78qdyIYQrbAtMhpcDBM5PBvwkXBM
	d+CGMTGzcHah89MevCbM7N1GZBIEyPxlRzecNMK4Xast5eBgjfZThBckJ9YQMgRKL51zljRnW+U
	WwFxHX7kDUT6AMoTGCnb+Vs7E=
X-Received: by 2002:a05:6102:54a2:b0:5f1:555e:a0b4 with SMTP id ada2fe7eead31-5f1a557be80mr4122229137.32.1768890070503;
        Mon, 19 Jan 2026 22:21:10 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6900c1esm4057944137.3.2026.01.19.22.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:21:10 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v5 0/7] iio: core: Introduce cleanup.h support for mode
 locks
Date: Tue, 20 Jan 2026 01:20:40 -0500
Message-Id: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13N3YrCMBCG4VuRHG9kZpLG1CPvQ/YgPxMNa62kU
 lyk976pixA8/IY8b55i4pJ5EvvNUxSe85THax3d10aEs7ueWOZYtyCgDlGBvIzhR+bhVqRJRDt
 tA3ZsRX1/K5zy49U6ftd9ztN9LL+v9Izr9b9CoJrKjBKk1w5TNKrXpA6nweXLNoyDWCszNRKxl
 VSlSV7vfHQukf6U6i0NIJhWqiox+h56jz0F+JS6kWhbqdc/g43gmC1HauWyLH8gbIziUAEAAA=
 =
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5359; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=8ACIUTMxM/zKXo7x/eO1abUeDEvW7CEDgGcDZxCz8g4=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJn5cod0J6aIdx5/dN+NVfVqrafgcbNel3P9xk1nFLzeT
 1x9OjOjo5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACayay3DP5Uk72ZOiRtVGrud
 D7adSX7z7uLB/dtnBSzb4+80nynjyidGhmPqtyNLWAxzHl/WZ7Rc/9+J5fBpmy27fpjHJ82/PkN
 wEjcA
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
v5:

  - Fix all function/macro names in kernel-doc

v4: https://lore.kernel.org/r/20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com

  - Replace "," with ";" in __iio_dev_mode_lock() docs.

  - Fix "bellow" -> "below" typo.

  - Drop first example in IIO_DEV_ACQUIRE_DIRECT_MODE() docs.

  - Match variable names in kernel-doc and definitions.

  - Replace "markings" with "annotations" in the "static inline" remark

  - Replace "claim_ptr" with "claim" in IIO_DEV_ACQUIRE_FAILED() and get
    the pointer inside.

v3: https://lore.kernel.org/r/20260106-lock-impr-v3-0-1db909b192c0@gmail.com

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
 drivers/iio/industrialio-core.c                    |  86 +++----------
 drivers/iio/light/opt4060.c                        |  52 +++-----
 drivers/iio/light/vcnl4000.c                       |  49 +++-----
 include/linux/iio/iio.h                            | 139 +++++++++++++++++++--
 8 files changed, 190 insertions(+), 184 deletions(-)
---
base-commit: eab91f819af428173f7e0aa1c80b3e561c3707bb
change-id: 20251130-lock-impr-6f22748c15e8

-- 
 ~ Kurt


