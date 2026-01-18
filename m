Return-Path: <linux-iio+bounces-27910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D739D39799
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 16:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE2623009824
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E7C339857;
	Sun, 18 Jan 2026 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCtvLnii"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB933291A
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768751094; cv=none; b=tmClrKk+nEPGETdy9AqxIfstfH0PXb5oCsEBFfCVHuBescFw70g8EjTnLp5+tXr/hr3u9w+mTwNAemgkYW4nxWcv7UMYEnGWz6ftg8mYy/7q+FN0fiqjy+Mk0LYzXnsUdMjMj/caVEJgiTeBwsOdA8Wl0VBdBbVB0AMmMg2x9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768751094; c=relaxed/simple;
	bh=LxBz3rw07wPHVT3ZcJ+S6GpTBYe4Z0OZ+B7cL6r5Yk0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VzMX0kNJ+zlOl4C40VKKSc7T7qHvckQ7ZT4aF8WPnFL7xEPtfhbMHcucaqvygRPXH4URUdKBmh27h2qM5Rh4HLfmqS+BHzGXXoQkuZ9smq5+KtYKuPIVrq8QmLNve2Qe4e7KSXFqTEIqdgFDsGBNjNSgNuJs1GHt+6RvqzhHSE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCtvLnii; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5eeaae02888so971937137.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 07:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768751092; x=1769355892; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx4Lot2Jy8sYT4qX9cxe1NcFvJLaRTnaOofjXfAceL8=;
        b=XCtvLnii4zwH034A/zKzeEvSTiwYKXcGOLkJzCsUZjOBGGsurDjPbI3AQEa/M2bbNm
         I+GOZXWDBpfhWme1j7DOwiWqiMc4X7+CW3i0MCdYrL7WwBkjPYTsXOUpahrBB72BnK0N
         dWviPYgQG3XnCRYfvg6fJjfSNu/TGgJZmOClHQz3pm9HNzZbZqQ2J3zEEmpz1J459/xD
         ZYSBMPNX/hNyDZIgg0R3aWoqng4EQnWsdGAIKEbZZg2XI4LXHUVu2Mj0ORBrZJfTyPjL
         9/Wrn10aY83RZqJ4I0rEd7wtTgGXj08Qe6TzgSsITaKgJFQhtXjmIOPEYR00+HCe+mys
         K2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768751092; x=1769355892;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx4Lot2Jy8sYT4qX9cxe1NcFvJLaRTnaOofjXfAceL8=;
        b=eQSUCQDbSsxjpcht4EDcyRp06dXmdwVIN4a2WnDTkc71hR3Lnlt9PvM5tMaZH0G8tW
         m8Ehnfw70RID3SA3y/ja76I9HK7tngZlUVH/9xst8fsMxBSk3qMKMRDKL8IAaw6Z9Wnq
         B76ZkFmTCYIFLFzje5JFsbXd0vgzzXjVHt1ty4tEbLYqSo4vfx8ZRZykkd31iOZOC6hl
         lCdxzAO06jf8YGySTmGM/oWM795f0CLJQxOASw1rM40+kpXCne5RJ8U90keEsVIabIDp
         M6d2UjhRixkf5kG7NcARXtvIHTFmuOojGxFWl5v21isuyzZ4eE0Zryj0PdeQ3p6S/cdl
         KLBg==
X-Forwarded-Encrypted: i=1; AJvYcCWk9x0koslgPEJOrA1NpFrGg7YEvaPqDS5IZvcIw0KD+653B/bGjsLBMmcVO3+L3PGrUMG2OGWOj9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrvMWrBvWeylQmnU/bpj0ZD/ySU7MUNBGQgvCFU5Djs1bGPRrd
	X7ZSABSBCDDulcDBsLVBhYJ23cPmugTWdogo7owbdbH7zmPYMV3JyfK/
X-Gm-Gg: AY/fxX6KmxI7IezPprd3TSvkyNIw5Ro+CDYJyQ3d1DgfE0YOZ6Y4JBMkRA8G0+DN/t6
	RWimoQd0pTOQtn7GtTmQRtCAB031cMmbv8aQJ8U/GKT60TgP77I1F3ok+Ii/2LQ/Y4Rowcp2YjB
	0yJH7NJI4pnlr0BOBwIN98amyfgnrJnK/uF3EaWEw+Rh8cicGTz3KfIXbUbKcemYR+7rpgJbg+u
	VqCDvBfNa5LrIuS1jmyiYyIZGJdNOouV2RlBRVuRNsTSKR7WXr7h2fJcb4QWznS5061jcpV+57Q
	iUBd1ZSw8IWJgsdk25uGZPe81keC4BKyySvY4ZlMarJXHsuVxpoDx2WXnNHLMOzfI33/kKbLFbp
	vgnZ8hBEyeE+Wf39VyIQBjWgJW3IrnElG7WQd+kB/EJYMxTLS5/XfhFoF8M6Xtg3B4JgHKCtv5e
	XDg5uvoNja0hqprbGEzzS4mek=
X-Received: by 2002:a05:6102:f10:b0:5ee:a309:6684 with SMTP id ada2fe7eead31-5f1a4dc26femr2529217137.10.1768751091838;
        Sun, 18 Jan 2026 07:44:51 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6d3ca2esm2832731137.10.2026.01.18.07.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 07:44:51 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v4 0/7] iio: core: Introduce cleanup.h support for mode
 locks
Date: Sun, 18 Jan 2026 10:44:27 -0500
Message-Id: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MTQ6DIBCG4asY1qVhBkTtqvdougAEJfUv2Jg2x
 rsXbZqQLr/JPO9KZhu8ncklW0mwi5/9OMQhThkxrRoaS30dN0GGOQBntBvNg/p+ClQ6xEKUBnJ
 bkvg/Bev862jd7nG3fn6O4X2kF9iv3woynlQWoIxqocDVklcC+bXple/OZuzJXlkwkQCpxCil0
 6LQtVIOxb/kPykZMJlKHiXUumKVhgoNS+W2bR8dbUzuFgEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5229; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=LxBz3rw07wPHVT3ZcJ+S6GpTBYe4Z0OZ+B7cL6r5Yk0=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJk5/5+bKbQtdK+s60jTOhXAldVYeKXi+SH3GsOXi/QPa
 Gk/ORvZUcrCIMbFICumyNKesOjbo6i8t34HQu/DzGFlAhnCwMUpABP5qszIsInxjtOS9nDxg1qZ
 27tXez5tbiyY2pRlce7KM70tN766fmNk+JjcKbXr9PfimV3ZLiEb7cobM469uvaxXELnVYt4jc9
 2BgA=
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
v4:

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
base-commit: c30e80d68a7afb334fde7147ee0106f25dd58d3a
change-id: 20251130-lock-impr-6f22748c15e8

-- 
 ~ Kurt


