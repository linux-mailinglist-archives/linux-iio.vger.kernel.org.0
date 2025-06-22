Return-Path: <linux-iio+bounces-20873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED88AE3093
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 17:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B05497A54E9
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D11EBA09;
	Sun, 22 Jun 2025 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6P3W6qr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A5C13D;
	Sun, 22 Jun 2025 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750607418; cv=none; b=uEm50NidS9ncsZ38c3nc66x1c4KOZb0p02OnCk/A0R+GeQ6kbMc5h+Lka5dPH/VxwUc+4UFpK/dVKyXqTUsHEp7RDTQXr+fcs2D4CnIDVramnx8XDR5fGYTspzhAmc6zA2udgUxxwyiEJi3R+TJJT6AU6kAuTzIuCTaPzKS40UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750607418; c=relaxed/simple;
	bh=4cpbv4GXP5DJghRVIIidouvP5TUzvpYP05Z+n+VvxdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HJJwqSSCZOBpH+kF4ZajJijWd2hXXZuHLGxcNPz93GrIde24ohRtW1rsVOlk9VvVhMl7Gn1KIUzoAt0oNySMspwgKmrSdOOSEiK03F/+1HSkalCMlUxWBzbvpkUiFgPmQ6m4OtYWspYFlQ5MyTPbgX7FCmMKclYWTEAqbb3oq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6P3W6qr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-adb4c022f77so48327066b.2;
        Sun, 22 Jun 2025 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750607414; x=1751212214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/k25ORCK5f+atk2whpnM88FBbR+Wl3QiknsMbJ1VXp0=;
        b=B6P3W6qrhyS6BDMjcH+xXXyGFQapmhlZ2DS5be1fiYu3X46ZT07cwEqNCXmxxEeHNe
         dUbyrlRClm74ShWUZ1Jl1EzJZ3gfuG1Kw8z/4bI6borp9ar+msB+HzjA+KewMzpAgYU+
         Pj5seU/LySXGAkEBiRIkIfximRtBSVeNk6XZij6uMBNkHKglfOEHuIcOBV07JpLT1eQw
         vv+AB8jtv4r04JwexfiuBKsS+AdtSFg+LX/aOByUk4PozjGPu0/gjLQ0R26sAEzHh8DH
         M1i/NMOFRTN74ZXXaJbvmQaUTVaDA+AN1I3JzB3LrEwdoONrYKJGQCGopCqxniT8pjqM
         E3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750607414; x=1751212214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/k25ORCK5f+atk2whpnM88FBbR+Wl3QiknsMbJ1VXp0=;
        b=CbB2tfdyY35ILCJ5m85SB1Sh5eITj3jWDWlMd4Zv0av77c5Qh3bl/cmrQLphErDRri
         lEfRlbooux8IFg0PCymvPyD5h+iyB8KMuO3QaUmU56cH7/i19iKiEXefbPZGewUMMfCP
         rL6ki0svhln+SNJIJ5KJD8z51bM29oSrA/q2sog98SlU94xLp2yMczATzhmm33DS/5RP
         uaWhncEbWJ1aWzbtKz34QiiAb4CepmG6s18v5wNo3w/SzIgkZDLiEtHsEZ05blAvZ7k0
         RG27lEcKaYzg4fd0gjJl/4Cb3oKsW1S4yvRCmSlxItv+nGnhUSjwy8LjUR/BvrYu9+F7
         C7tg==
X-Forwarded-Encrypted: i=1; AJvYcCUHsC8wJ37IaZUARh7ouXPl1WTCS5ZT6JmeSmRra0CpRpps2aLEu8HLM0xdaswzEyUeZP/y2hFlomf1p+fD@vger.kernel.org, AJvYcCWPaN0GzZ3rmayk8jfkL4N+om5j7lu3st+i/rL2EUHXgE9sAzidoV1v2hPNdUNIO58uiuhaLwVnzx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznMU8EHNAX++vqjsIGB6ESeD6kpte9XHd+cjmc+hUlB4csZcSH
	PND+JDenk+BM1tpbdpOcz8G7qPoBngWFs3wOD7+YnfK+O376Wc+4lOv/
X-Gm-Gg: ASbGncvSNjI+1CFHkTgdMKcv+1/nT1Luu4+0DS44pJSjHD53WM/mkiH1WdUubn3p2v+
	+Te6iU5NFPLfc+DPdSnwqtddO1d+DgSg57faHI7C5JQ+K7YcGpnayVY1udMGjuc0/wX5LI9fVIH
	lc2y2QTfMEoz+f9NyuLAQMkWase/ScCZ9FQamT722LN9raG3KGQSrU8eL+uL3OUkpel/tB3qAs3
	dfmomAIwz7JpjEvFj9HURnb6tPLYHRJoGhaCaM3qWf4eYwQvJF6/mi0S25GwlD2cz4ogxi8R/fu
	jPKOxC6YyP2znKe5mZHL/0NabiWH3l3icj1jbh2af1YkP6M1pMdb8x1z/l5k1+11F4e2zUfp3Zr
	5QzP8VFbDOJWPtwnx9cxY+X8bOckHw3eY
X-Google-Smtp-Source: AGHT+IG0DKRfGGnnpQTj/RCpKKVUR9cip9i9vp7Xg1pRKGXXDRQnr73fHFWpGB0YFDhfyuhNTFXmTw==
X-Received: by 2002:a17:907:3da0:b0:ad8:908a:544e with SMTP id a640c23a62f3a-ae0579c85f0mr302603066b.8.1750607414081;
        Sun, 22 Jun 2025 08:50:14 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ecbd9esm552781966b.38.2025.06.22.08.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 08:50:13 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v10 0/7] iio: accel: adxl345: add interrupt based sensor events
Date: Sun, 22 Jun 2025 15:50:03 +0000
Message-Id: <20250622155010.164451-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add several interrupt based sensor detection events:
- refactoring and fixes
- activity/inactivity linked and auto-sleep
- AC-coupled activity/inactivity
- Extend inactivity for inactivity under 1s (using free-fall register)
- documentation

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v9 -> v10:

- [PATCH v9 01/11]: Dropped
- [PATCH v9 02/11]: Applied
- [PATCH v9 03/11]: Applied
- [PATCH v9 05/11]: Replace literal number 2 by a `sizeof()` statement.
- [PATCH v9 06/11]: Applied
- [PATCH v9 01/11]: Tap scaling patch is kept unmodified, since the
  threshold has been in raw register values, the patch scales that to
  g/LSB. There was no other advice (so far/to my understanding) to drop or
  modify this patch
- all (remaing) patches: Rephrased commit messages
- `adxl345_is_act_inact_en()`: Refactor the function; Check for a valid
  threshold earlier based on the enable flag; incrementally construct the
  switch/case conditions
- `adxl345_set_act_inact_en()`: Refactor the function; implement helper
  functions; group checks at the beginning, return soon in case of `false`,
  group `cmd_en` using calls to the end
- `adxl345_read/write_mag_config()`: Introduce the helper functions when
  activity is added, and prefer using switch/case statements. However,
  retain the internal nested switch/case structure, as it appears more
  appropriate in the context of handling other channel values and
  configurations
- `adxl345_read/write_mag_value()`: Introduce helpers when activity is
  added (keep internal nested switch/case)
- `adxl345_core_probe()`: Rephrase comment on default values
- `adxl345_set_inact_time()`: Rephrase function description
- `adxl345_set_act_inact_linkbit()`: Factor link-bit and auto-sleep
  handling in a separate function
- `adxl345_set_inact_time()`: Use `clamp()` and convert `min_boundary` and
  `max_boundary` to int; in cases of `>max_boundary` stay with the clamp
  behavior for inactive period
- `adxl345_set_odr()`: The return statement is kept as is, due to several
  refacs it won't change so `return adxl345_set_inact_time(st, 0);` only
  becomes `return adxl345_set_inact_time(st, 0, 0);` throughout the patch
  series
- `adxl345_set_act_inact_linkbit()`: Apply `ADXL345_POWER_CTL_INACT_MSK`
  directly
- `adxl345_is_act_inact_ac()`: Change to use switch/case for clarity
- `adxl345_set_act_inact_ac()`: Additionally accept `cmd_en` to turn
  coupling on/off
- `adxl345_set_inact_time()`: Return from within the conditional cases as
  of the last source patch [PATCH v9 10/11]
- documentation: rephrased major parts (ai based rephrasing)

v8 -> v9:
- githook: apply codespell checks, extend by spellcheck using ispell
- refac: apply `regmap_assing_bits()` in several places
- refac: remove ADXL345_POWER_CTL_STANDBY in adxl345.h not needed anymore
- refac: rename `ADXL345_ACT_INACT_DC/AC` to `ADXL345_COUPLING_DC/AC`
- refac: remove variable irq from `struct adxl345_state`
- refac: apply expressions, such as MILLI or MICRO from linux/units.h
- refac: apply (missing) scaling factor 62.5mg/LSB to tap detection
- change `IIO_EV_TYPE_MAG_REFERENCED` to `IIO_EV_TYPE_MAG_ADAPTIVE`
- `adxl345_fifo_transfer()`: eliminate variable for expression count / 2
- `adxl345_is_act_inact_ac()`: make return boolean, or negative error
- make activity enable cover x, y and z axis together, while signals come
  on particular axis
- `adxl345_read_mag_value()`: separate `MAG` and `MAG_ADAPTIVE` event
  value read and write function to reduce redundant code
- `adxl345_read_mag_config()`: separate `MAG` and `MAG_ADAPTIVE` event
  config read and write functions to reduce redundant code
- `adxl345_set_act_inact_en()`: move linkbit detection out to
  `adxl345_set_act_inact_linkbit()`
- `adxl345_set_act_inact_en()`: fix unsetting register INT ENABLE at
  disabling feature(s)
- apply scaling factor 62.5mg/LSB to activity/inactivity
- apply scaling factor 62.5mg/LSB to activity AC/inactivity AC
- drop dedicated freefall patch
- add patch: fix missing scale factor for tap detection
- add patch: make irq a function local variable
- add patch: simplify measure enable
- add patch: simplify interrupt mapping
- add patch: simplify FIFO reading
- add patch: replace magic numbers by unit expressions
- rename `adxl345_set_inact_time_s()` to `adxl345_set_inact_time()`
- `adxl345_set_inact_time()`: implement inactivity using inactivity
  register (period 1s or higher), freefall register (below 1s) or let it
  setup a period based on given ODR (0s provided)
- doc: update documentation

v7 -> v8:
- activity/inactivity are MAG events
- separate AC coupled activity/inactivity events as MAG_REFERENCED events,
  since AC coupling introduces a (some kind of) reference relation
- since freefall and inactivity (DC coupled) are then actually identical,
  this results in a challenging situation for the freefall patch. Thus,
  the freefall patch is moved to end of this series (before documentation)
- freefall: provide separate sysfs handles to configure and enable freefall
- documentation: update sections on activity/inactivity, freefall, event
  names and examples

v6 -> v7:
- freefall: add a virtual channel, replace OR'ing the axis by AND'ing them
- inactivity: add a virtual channel, replace OR'ing the axis by AND'ing them

v5 -> v6:
- replace bool axis_en for tap and activity/inactivity
- apply freefall bit mask
- change `measure_en` to use `regmap_update_bits()` for POWER_CTL register
- fix comments and update documentation, particularly on inactivity time

v4 -> v5:
- read_config_value() and write_config_value() now use direct returns,
  in case of a failure, measurement stays turned off
- fifo evaluation returns 0 in case of success
- axis enum turned into three different set of defines for tap, act and inact
- turn the suppress bit into a separate define macro
- variable naming, generally use axis_ctrl for similar variables

v3 -> v4:
- rename patch "add double tap suppress bit" to
  "set the tap suppress bit permanently" to make it more comprehensive
- added patch "cleanup regmap return values"
- added patch "introduce adxl345_push_event function", as a solution
  to the return value problem, group all int_stat evaluating pieces
  in the same function
- tap, act and inact axis enabling are using now regmap cache
- activity enable depending on individual axis now, as the sensor offers
  such feature
- inactivity enable depending on individual axis now, as the sensor offers
  such feature
- fix bug in previous patch: separate axis direction in interrupt handler
  sharing the same variable for tap and activity, if tap and activity
  enabled together
- refac of the direction identification of previous patch: only read
  act/tap axis once now in interrupt handler if both is enabled
- fix bug in previous patch: return value of pushed event in interrupt
  handler
- several cleanups

v2 -> v3:
- generally introduction of regmap cache for all directly stored 8-bit
  values, specification of volatile regs and cleanup
- moving thresholds, unchanged values and flags to regmap cache, in
  consequence removal of corresponding member values of the state
  instance
- removal of intio and int_map member fields due to regmap cache, thus
  split of set_interrupts() patches in two parts
- rework documentation
- rework of ac-bit comment

v1 -> v2:
- implementation of all events (but tap2 suppress bit) by means IIO ABI
- add sample frequency / ODR configuration
- add g ranges configuration
- add activity/inactivity using auto-sleep and powersave
- add dynamic adjustment of default values for
  activity/inactivity thresholds and time for inactivity based on ODR
  and g range (can be overwritten)
- add sensor documentation
---
Lothar Rubusch (7):
  iio: accel: adxl345: simplify interrupt mapping
  iio: accel: adxl345: simplify reading the FIFO
  iio: accel: adxl345: add activity event feature
  iio: accel: adxl345: add inactivity feature
  iio: accel: adxl345: add coupling detection for activity/inactivity
  iio: accel: adxl345: extend inactivity time for less than 1s
  docs: iio: add documentation for adxl345 driver

 Documentation/iio/adxl345.rst    | 443 +++++++++++++++++
 Documentation/iio/index.rst      |   1 +
 drivers/iio/accel/adxl345_core.c | 802 ++++++++++++++++++++++++++++++-
 3 files changed, 1223 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/iio/adxl345.rst


base-commit: d1584d12ec8c35534172882c1713947110564e4c
prerequisite-patch-id: c3c61d8d9cbb12a2d79a094519bf07dfece74318
prerequisite-patch-id: 253d3d6df17bca006f85763b9cc47a4ada07d3ec
-- 
2.39.5


