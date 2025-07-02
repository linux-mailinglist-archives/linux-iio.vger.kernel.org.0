Return-Path: <linux-iio+bounces-21261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E927AAF65D1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF011887E1E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5661425228C;
	Wed,  2 Jul 2025 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlFBQya1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241D82DE70C;
	Wed,  2 Jul 2025 23:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497416; cv=none; b=rO94G5dzg1uvYuJ+rwj+0S85zvBEFYt3EgUyirilYPzcDyeaVD0hVmDEuuukDq5g4OFBv4lbjepOF5wwYiyQCE5v9xRjzH5qtKfzF2kf9O0m+9IXCVsg8clZwT6qEza/J1DNOXzGzaC4jsjlcejiLpB9LuJQ7q8yYJzMb5hbMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497416; c=relaxed/simple;
	bh=ZBGavM7yNSd7VWz1jZOFoqIrOK1Zz3e0RjDet7tvJ+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ESQbZ7ng4DQ4KuxbdcJPqwVkdTOWG1/+PVttiUJu6emdHk4Ne66ZI7ckQqQQvwWXbN37ab+sDerYODexzqC9xtDICIGunGih4BbscMwdsH2YPz/tdVtPpcKzYezhLRL5/pN7hrH8dEhBuszxs1NIocuAavzAR/PYR2BSlJHub78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlFBQya1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-607fbf8acb6so1223464a12.3;
        Wed, 02 Jul 2025 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497412; x=1752102212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SxMO4pTUs9EKXL/1ocdRdKYDlXOA39qf6es9x3xlsU8=;
        b=RlFBQya1YXaAqXK67K2MCXANuCDw182ujdueXhwfMRgeLVJr6UKHmBYUgQZ8U09oMZ
         Tjg0YbvxaXH0EXV8HpHnZKPuj0uMH3Q/n9xBsNMY+G53KTn58oVOn3uN6R5XGUzJiFrW
         D6xm/A7B/H5rMgNoJwlsP/8OSWo9kMgrgNOaAIIaaMNV7TIRZ1bGpof29BXFkmeDpRnI
         /IuorbX9EArBH4GrL7HjpI3NGUbqvWFSRIeqqBn+7NUVQAksbgMkaGvKg/plkukadsp1
         e2y5sfLo2mBBHiOSbUZnFVDQSu/IvhILrw2TMcj6W+K2ae8ZMckY2Xa2j0HuKjk9FWBz
         P0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497412; x=1752102212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxMO4pTUs9EKXL/1ocdRdKYDlXOA39qf6es9x3xlsU8=;
        b=RBPoEnzYMnBuaI14bzk7qVrVSarDvWmny7DsEL3RI07rzPIbbqcABCcKOeBc4FYcMQ
         MoAfK4oJOuS9VzyFbIc95HMnnqvSE23sQEyoPyoFE+hi+idez9UW5JeAQzMnA+ScEPeo
         2B+j8/n7A6xC7PItGPD05oQGSgx+4FY/jG0oJ5xREEeTcb5zWzFt145W1AsqDchTAjjW
         YwaGR656eDkGAAGZjOu7+PmZJ307Jm8qnl8Owl34svLoyO9yEvtt/K4TAUNeJJYmhgTf
         oLTN5QQcu88MMuR0lgM4bLqNU7nFZr4FZortNdjZNluVY6cjZ5Gd61y3406WkGudVCwi
         zWvw==
X-Forwarded-Encrypted: i=1; AJvYcCVQpzefJed/mqCKZT+ahaRVb0ZZ6RI0nCmp4r5sNGC0+mTpBXCSQRlcqiwJZ2GLqW3QheBY0yIREvebAtxo@vger.kernel.org, AJvYcCVuO/j1w97YXuc/T2xV6F045mCvcOong4NgXQg7PnB8KUIJ6W9hUXIql64u5ZxQ/g8s0V1kTJAz79U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUAbO3gRQGFuJCSvLX8kmhA7uIyhzNL9H7amQX45aK+8N1SRtA
	OCKYWHzJvJvne6na+yh03oNjhKAoZcvg+8Omg4p6rFAvJjDLXodI4UWY
X-Gm-Gg: ASbGncsb9EZA1qXo0Dvilp7tP8in6aAnggOJFldlgNO3IjPd9AzetlMapYQhFu7iUac
	m28EdGBYwzJibKyRiy2mxoJtifexCgF+joqId6l/SYlFiaEyOs+nggFQ5SxQYLUU+IUjXKys5k4
	9GFCDy7k56BNoSzRfzNk2LaIfhoRIcgJzpJrcoEy7KqgnrNoJAy4X5tiBNUlBiKY8k9g/aM4LC2
	gNLHhgkfS5oaj2+e/YWKPKLr7QHF16zEgowtGwYOfO/EgwH0ddBr+xjoR6UeuQGlRHkm4SXwV2v
	oW7HTkyFLWms4PZUBnvZ5Skf8wLiKtjJ6MdG8LA1Ls2eCxjSa1x8wEZQY4/IoPO/1f8RYxJF0iU
	31ZreEUX0ksMoW4R4G8wwFhkYsa7nbwZD
X-Google-Smtp-Source: AGHT+IFaucalMX1Aa9eCFTE2Sn+qUco+KZECh+lYnGkQsq7BYJqQdAgVeVsO5QA/3QQ2rqzuVP/JkQ==
X-Received: by 2002:a05:6402:3585:b0:60c:3cca:6515 with SMTP id 4fb4d7f45d1cf-60e52ccba8dmr1525156a12.4.1751497412013;
        Wed, 02 Jul 2025 16:03:32 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319e706sm10031469a12.47.2025.07.02.16.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:03:30 -0700 (PDT)
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
Subject: [PATCH v11 0/8] iio: accel: adxl345: add interrupt based sensor events
Date: Wed,  2 Jul 2025 23:03:07 +0000
Message-Id: <20250702230315.19297-1-l.rubusch@gmail.com>
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
v10 -> v11:
- [PATCH v10 1/7]: prefixed `_get_int_line()`
- [PATCH v10 3/7]: add `ADXL345_ACT_XYZ_EN` to reduce LoC occupation, in
  cases of added features, the line formatting is actually kept the same as
  in v10
- [PATCH v10 4/7]: add `ADXL345_INACT_XYZ_EN` to simplify and reduce LoC
  ocupation
- [PATCH v10 5/7]: Break the variable declaration and assignment into two
  distinct lines
- [PATCH v10 6/7]: `adxl345_set_inact_time()`: Extract conditional cases
  into separate helper functions; Use a nested if/else to eliminate
  redundant val_int == 0sec checks
- [PATCH v10 7/7]: Separate the documentation sections for free-fall
  detection and inactivity detection into anothe patch

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
Lothar Rubusch (8):
  iio: accel: adxl345: simplify interrupt mapping
  iio: accel: adxl345: simplify reading the FIFO
  iio: accel: adxl345: add activity event feature
  iio: accel: adxl345: add inactivity feature
  iio: accel: adxl345: add coupling detection for activity/inactivity
  iio: accel: adxl345: extend inactivity time for less than 1s
  docs: iio: add documentation for adxl345 driver
  docs: iio: describe inactivity and free-fall detection on the ADXL345

 Documentation/iio/adxl345.rst    | 443 +++++++++++++++++
 Documentation/iio/index.rst      |   1 +
 drivers/iio/accel/adxl345_core.c | 816 ++++++++++++++++++++++++++++++-
 3 files changed, 1237 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/iio/adxl345.rst


base-commit: 42498420746a4db923f03d048a0ebc9bd2371f56
prerequisite-patch-id: c3c61d8d9cbb12a2d79a094519bf07dfece74318
-- 
2.39.5


