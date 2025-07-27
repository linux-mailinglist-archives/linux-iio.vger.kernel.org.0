Return-Path: <linux-iio+bounces-22068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B7B131D9
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 23:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21543B9095
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 21:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B61EEA55;
	Sun, 27 Jul 2025 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1T8bTyy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509FF155326;
	Sun, 27 Jul 2025 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753650024; cv=none; b=nh8amCl1fR6ynNKlmwT+wzjlplICCWNajk830EG+LbDEHJ6NbgUHZQ+Kh4BVK5v4noLP3RzCm0AsfpLAOMo7jR754mDGgrV79fW2d2EzRXXmrI0NoXZdSeYSdNWiUsIt5LAeKRAbBuLQ6JRQ1eGGuSvBohIdhit+d7yFDjfH9K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753650024; c=relaxed/simple;
	bh=tvTOXBl8ctoKubg4O37GlmooL9/YjSbde4tQpGZcYVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IZpSyCuFqTIIgCPEMLW1fyqElJmY/sye/cfc12yAuu2VoED3ZDImEb/W4zytI1HAQ1HZc9cf8IZmZlnLER/k6ciILm86+mAXgB3sCsMxI2vkn3BdUeP3XISoq9GYUYY856Ke/rDP0fp7YhWO4bLqr6QSdhvnPJKliAzOO2upjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1T8bTyy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3a4a773e1so55151466b.1;
        Sun, 27 Jul 2025 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753650021; x=1754254821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rleiyPd2PQ6cn95gbwNRxCKcB7BjVwd/bP540fh0jPI=;
        b=g1T8bTyyprQUIvfdkFFoE1sfTYK9Jhm5ndAXDFHKdYfSnm1j7FP5+30jxItCRdCFct
         HSR94p03ohzrho+x+NFgdYBFz7VZa9MnpD7JwqoDAJlDGRCB+hx+J/c13sOWHNFZ9qc6
         Zq187gzrUr2H7zuBVygpsQWZKCxmOqhSUceksW3QOUhWjpYKrGMyEzJpaaapBHg8ZTM4
         BwP00tAtsnNKnMO59iryEysgg7IAxARskO5gScN19VEtMvJ7R6h4ZOSBbiH0kFZMBNvu
         UGL1XUke9hc2juzucXgmOGuMNavLPkyZgO8z2gFczo4SGFEZQtMW5/VYDxEt7jJHi6z8
         0tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753650021; x=1754254821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rleiyPd2PQ6cn95gbwNRxCKcB7BjVwd/bP540fh0jPI=;
        b=QvUKzAEmnDsKT2NXKkVBZTd3gwOSOhF3Aw6/2Uiq4pD6U7H535hVDJ+aXVbJhTsIMg
         ZZYJVx5pk4BM2l5w3zLRSjmnpPZ+/G7aLsn5WTr8bJQnPSKY7z7mnqmhQyAmXuKbb37j
         umpDsuLlIVupKqqCCmH/i63UFmGE64rds9f8IWKlTq2TBf4eW73lW2mvjpBF2lXVulZX
         fO0FRDZ4N8r+SX0Rh7FMRPVf6hL73ELh5tI6OJzSdGyGUV+bX9C5QG84FIrAPfwUSRma
         MZpJ3dpTw7VgSr6ElhNJrx55Wq+FZ7rmz2axa0MFd2sSCzQejRuq3d70qhJG832xZvg3
         JkFA==
X-Forwarded-Encrypted: i=1; AJvYcCVzX8kD4ooP4LSRVmpzvzNpx2DKOS/52BKPVNmh6wBUREuNyULtTotHZPzXct8EdrOFMk6jTh8llyg=@vger.kernel.org, AJvYcCW00wc0bATyzhEFR1f+sO3sbRptKbzCHdimCRWRyAc+vEjbr013Cc0pnMMlhi8f/EjIF+yVURzvRVIzYAN3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuw7ZnaZmHtwkwQtuz/nL4HfIIN74yB+PKNuztKUzmjYeM+K8K
	/MwSA/LK6ui/6LyH2fAvTfTS9z1wjV/PAqZq87+3wbz0Wul1u/GJdn2c
X-Gm-Gg: ASbGnct7OyEOVxbGJAtbJj9X6sAa8HbCI1brROMdDSKfIJ49sCcXHwfghdW9oz+1GZy
	Hm9EekVwrxuMeA5PsxQvgBv7um3ZICxhjtZtsIey7ZEijYjodVfVNC3fE29DdL4YbPo3n0/QaBT
	PuDv9SWpNTiytCvUa47axNl4X37Uuo/VrHw0rJmrqLaQMh6Lxj4wvk7yAn+Zwk3O/moSTzGWUPg
	MBWh9nAzycbNHyNJ7fRYg22qBkv4BuJYUIKJ1+Jr0OBiy3aNpt3zhSJc/56er2pRq58WpLDbNNU
	0mBaFjQl8RkGZmNT+AvPFiMfDP/ajeVOiSJOQGX1gXU2hP4NWqKvSZ2T8Wh0Gp5DReef7KtdxrU
	goR6VP0Ke7lHQoEy478Ff4kLZ2cV55dwla1iQCWDNPv5JUOsFOl8DRiyqsRaRVl2tnOWF
X-Google-Smtp-Source: AGHT+IGOAmFhQzMS7Do4xRpuIsFuFj3ZVvvtfGcnReEB1MzAlaqhmk0mx76BTnPItwi9EhfZ5hBFqQ==
X-Received: by 2002:a50:cc87:0:b0:615:cba:4f9b with SMTP id 4fb4d7f45d1cf-6150cba58d8mr1391668a12.6.1753650020342;
        Sun, 27 Jul 2025 14:00:20 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500add92dsm2512774a12.52.2025.07.27.14.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 14:00:19 -0700 (PDT)
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
Subject: [PATCH v12 0/7] iio: accel: adxl345: add interrupt based sensor events
Date: Sun, 27 Jul 2025 21:00:07 +0000
Message-Id: <20250727210014.27766-1-l.rubusch@gmail.com>
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
v11 -> v12:
- [PATCH v11 3/8]: reorganized defines and `ADXL345_ACT_XYZ_EN`
- [PATCH v11 3/8]: fix idention style for `mask_shared_by_type`
- [PATCH v11 3/8]: reorganize arguments for `adxl345_push_event()`
- add patch for setting the suppress bit, as it can be simplified
- eliminate `ADXL345_REG_ACT_AXIS_MSK` and `ADXL345_REG_INACT_AXIS_MSK`
- rename `ADXL345_REG_ACT_ACDC_MSK` to `ADXL345_REG_ACT_ACDC`, since actually no mask
  (similarly `ADXL345_REG_INACT_ACDC`, as also `ADXL345_REG_NO_ACDC`)
- rephrase documentation about ideal ODR

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
Lothar Rubusch (7):
  iio: accel: adxl345: simplify tap suppress bit
  iio: accel: adxl345: add activity event feature
  iio: accel: adxl345: add inactivity feature
  iio: accel: adxl345: add coupling detection for activity/inactivity
  iio: accel: adxl345: extend inactivity time for less than 1s
  docs: iio: add documentation for adxl345 driver
  docs: iio: describe inactivity and free-fall detection on the ADXL345

 Documentation/iio/adxl345.rst    | 442 +++++++++++++++++
 Documentation/iio/index.rst      |   1 +
 drivers/iio/accel/adxl345_core.c | 782 ++++++++++++++++++++++++++++++-
 3 files changed, 1218 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/iio/adxl345.rst


base-commit: 032c1468aa0ce71fbde2ad98b020950f4674bba0
-- 
2.39.5


