Return-Path: <linux-iio+bounces-20386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF3AD453F
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 23:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA88416ECDD
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 21:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD33E284696;
	Tue, 10 Jun 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnMmgD/c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A8218AAB;
	Tue, 10 Jun 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592784; cv=none; b=BYd5wSU/t58cjjK3/m+wf4K8RItyqnkx25mtUUsL1IigwMy3WzDjvg3hn/5cTiqeitAs7H0PIwxFFs4S1J8rha5rq7rt9RY4bjjaKd0bfbC+EYUmcqBwX1csJXG8jInKiwy+pdoOTcmi6J5ADnp7K78jL02LC+zVRNVkf5tTsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592784; c=relaxed/simple;
	bh=T1RG2dHGltgiK3WpIJDwW9Fd9WrgWZmkMz/O92jXKdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hRzonmgPzr42MhJpuwsqXY43gkOIrC2wVo5qLyK392A4y9ZQ8Fgiz6SqDjDhDW2PgP4oEhvf18D2XJfyIsHdU7gddoW/+L7l81UPZFZOR6cZMKoraVLqTS5SEctnpHtLxy2/kWsCBM5K/Pu6PRuvY5idLleXHmnn8sMJrge0CkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnMmgD/c; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4e575db1aso777646f8f.2;
        Tue, 10 Jun 2025 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592781; x=1750197581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1b/tA/78vzSKx8bD0pcCFLvLidaruLr5dztNEqFUNSs=;
        b=MnMmgD/cD0AdGa40kZZO21n3FXh34gAOW3TgvIV9zXb1U2erDJRcyNjSKd1mT+79ab
         oqs3VrLGckRE1s9Wcn6qLRgNrQe3ZowoXzL2Y41+wMOFRtuH3FjPeZqnlUymnPKhPkD6
         +85qY/TF+wE83eg5jgQSdV05zmdAgPXnvpkhOKDU81giiZfxppYwuzog69w5N4fgtp2p
         HV0WHeAimMLFy435996iYcI/jgrIgUxIaIDsDUuvVLqm27ULmrwyHFJ39NWl8A3q1rxS
         II2s/rOMsaz5JEDDVOoBjZb3/B7CPGOSWVdP7PquPkALcq8Im5mlzk6jqEiNvRHusX39
         5F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592781; x=1750197581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1b/tA/78vzSKx8bD0pcCFLvLidaruLr5dztNEqFUNSs=;
        b=Aszrifjpa0XYU1W2O8RxCXgXr5crmPa7e9dpt0l9YLEhWR9MuRD+5NndsTHBJ1Ojwk
         eyNDf1UXI6/pWtXDZJG5T1FubDbJNozAnUK09cWXnxUCI0altnwWXsSpZCLaVxYQl7/h
         Dd1c7V9YQhLcwEs4Cicx54mNOAqnEBKW2Trw1bW9jLZKCDiERCGeN07mVzJrwLGe9Bxs
         BpEfXEUlXh41r2lEOLGeq/dyT+meRVfdcnPbjVRoOpDlHdyMjELKfyCAAqHg/VNKnV4e
         fBtVgSfJ2uo68kv2e80JuFU0gt3DSbmIs7+p9HtVHoFQ3/2of2r9viKwLlmqaajTOdMR
         4/fA==
X-Forwarded-Encrypted: i=1; AJvYcCX8nRhaIoXelHkGg+ewroM/ERWb5XpCvUNvpAy+VaMLq3HRJjT1gZVxSjgTgQ/ywv2ok53OiGS0cjWsQKQu@vger.kernel.org, AJvYcCXzjs3VW0DybOW24d1DPJKKWYl1Q9N2u2BrTLqiS26sVjaFj8y9ZhrzqF8NNa+bVAKNMWXedoUFNoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXRuoF2Z0WgMIz5+ALir+/Dd3YKrFIeIo+yeyJMrsWHrOQeTcB
	PzD5wOVZLLS6jymoZNDmQLXxHZ/I3wdjoh42UXprwkT6/F7E0T0UmHwZ
X-Gm-Gg: ASbGncuFJ3mAqO0emxuAueM4hnMecHECkQaARauobxc1kBef/vZ6h3lYXKTtK7CELwL
	G4nGNgAcAnO5ChPwE3tOknyBhjUjrZtIq8MisLPOCy/9H3fyP+plwgjLp8xjDp2yGLPGoq6pXMf
	nb1ll1T+r4Z3sApxqde0sem4jdSXyo558bS8BzOGhNE3XacI5cEiX5LvV8CjW0/SDMBnB3jbc7a
	KsxAFkbBCM7IYhVCrotAKu/5n9tTb/lOsnn8j3iEN2iZfC+/hjGzTTmsjmGdh5rhiLh2Yg+8l7C
	yV74ofMLZBqhl4bF3Lmsm5liE725qJzDWt/iNzCfWXbTIeV1uYX8CtfB68xVHi5cgCpV1W86X4s
	vYCxUilQ9ohUQHN9i/Dix13hHsI5s3cwj
X-Google-Smtp-Source: AGHT+IGjg/gPJHdEEzqSMuf/axfH6ETfuDeoTj3rgXGPhtimf78EeEan6RLHku/rvOx0n1IjiAPMWw==
X-Received: by 2002:a05:6000:178a:b0:3a4:e0e1:8dc8 with SMTP id ffacd0b85a97d-3a558803128mr179618f8f.9.1749592780588;
        Tue, 10 Jun 2025 14:59:40 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f04dsm13312647f8f.73.2025.06.10.14.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:59:39 -0700 (PDT)
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
Subject: [PATCH v9 00/11] iio: accel: adxl345: add interrupt based sensor events
Date: Tue, 10 Jun 2025 21:59:22 +0000
Message-Id: <20250610215933.84795-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several interrupt based sensor detection events:
- refactoring and fixes
- activity
- inactivity
- documentation

In brief, this implementation uses the inactivity registers for inactivity
events with a period >1s. For a configured period <1s the free-fall
registers will be used. The related features, such as setting the link-bit,
auto-sleep, the AC-coupling events, etc. are turned on/off accordingly. For
instance, activity and inactivity enabled imply a link-bit set. Disabling
one, removes the link-bit. Setting e.g. activity AC with inactivity DC, sets
the link bit and so on.

Due to several items found for the ADXL313, I tried to apply those refacs
here as well. I'm still unsure, if I should rathe wrap them up in one big
refac patch or keep them separated by the items as I tried here.

By the number of possible combinations of configurations and their
verification, as additionally the refactorings - I implemented an automated
verification by a labgrid/pytest setup with over 300 test steps and hardware
in the loop. Hopefully the setup is mostly correct. Further I extended the
codespell githook by an ispell check (which gave better results).

Let's see how good that works out. Somehow I'm sure you guys will (still)
find something...

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
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
Lothar Rubusch (11):
  iio: accel: adxl345: apply scale factor to tap threshold
  iio: accel: adxl345: make data struct variable irq function local
  iio: accel: adxl345: simplify measure enable
  iio: accel: adxl345: simplify interrupt mapping
  iio: accel: adxl345: simplify reading the FIFO
  iio: accel: adxl345: replace magic numbers by unit expressions
  iio: accel: adxl345: add activity event feature
  iio: accel: adxl345: add inactivity feature
  iio: accel: adxl345: add coupling detection for activity/inactivity
  iio: accel: adxl345: extend inactivity time for less than 1s
  docs: iio: add documentation for adxl345 driver

 Documentation/iio/adxl345.rst    | 429 +++++++++++++++++
 Documentation/iio/index.rst      |   1 +
 drivers/iio/accel/adxl345.h      |   1 -
 drivers/iio/accel/adxl345_core.c | 793 +++++++++++++++++++++++++++++--
 4 files changed, 1195 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/iio/adxl345.rst

-- 
2.39.5


