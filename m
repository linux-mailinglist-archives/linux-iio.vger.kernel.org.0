Return-Path: <linux-iio+bounces-18105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C69A88B89
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E8C17290C
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E828BA96;
	Mon, 14 Apr 2025 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEhPk50R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE683288CB1;
	Mon, 14 Apr 2025 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656173; cv=none; b=Aty1BR+9hSGnBuHIVjCpATe83YwEbuIO16JXMdZiXz5acfNt1n/DlarTtVmZPC82gKtsVoLhZ6BsYUjurcoA9CDtc80GGHrAJekFJ2p05w81JOvHsGliLP+nRVrsgUtMiJfEuL5XfC+XEowCCXFQxT2YXtq9Bd5vhTpYNsky+iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656173; c=relaxed/simple;
	bh=F3e8V9oxDQiLMzH2V0KG4RkL43zCgb7yd/2VTtx+0Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RHLBsSzmDmdjytifUKwhXbu8xPSSWURcG7C6mIP3CXVd286Njh27+1eKF3+WmHt8ZRIKFM9Ii/S+VDbPjwBGP52PnMyNs682Mv22A0EJxBLZo/0FBQg6T8UvyIbppmj2wGRziG3GAXb1Z2borfNl0Ifw+TRFMWkse5FIj4PdEjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEhPk50R; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac812838d86so81304466b.0;
        Mon, 14 Apr 2025 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744656170; x=1745260970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RyRwSISm7fs5b5JE7PBICNk1IaettKgf+ZtRY4XdysM=;
        b=WEhPk50R2ZcHrXCuhWP3n0xtsj8fFNkDzsZd3fCyM7bGOuo0RorH2pWwYCdzcc3dZR
         AYO2nlMFtJXJmtjFt6FX2A3huBIlR9qXg3jPKDsqRMa9/oS141Frcu0CCfP5N0i8ubxx
         dD84mfpZ9P0cshZfFUjmJoIn9rbwq58wwDa8V0zQ2vYIn/SCAR6wngI6NmvrElx3rlo7
         MNrPonOqq12MrM4qwztaMqFrlzewcZKuKWp4KloDK/FTmvRk4lr+mjJGFaD+zOouAaPn
         41LU8qqCVBZWeARanWvKqWuIcdp1h/E0dzWVxmR2qnTBo+Baah5g0J9d2b0sr66rRTjZ
         smZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656170; x=1745260970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyRwSISm7fs5b5JE7PBICNk1IaettKgf+ZtRY4XdysM=;
        b=YZRxv9NkuKmDP6xYqJNdR1wIx1x35c5nB8QP7Ak+N4gX9+Xli5v43m7ImH+2FnNP4c
         6fZKZfFX+IHF2qRLoxPPwOo0CSil6Gw8qrErGEwhEiBTI2sqmvIqflXXlcFzbzun52FV
         qctTNbeANNYhNGpmgAs1Fr5F5BjSQcy7+NNKp5GTJ05wajn7vZuicsdVp8JlrR6mvlYF
         1qhJSqqfyGoOrzYmjvlCC/xJLCUteMalGRXaWsqXyRTkTPMO0qFyq9sAsu0RM6I8E3mO
         n3DHttdndNftqzCN0F1jo2jNJ5oOPN1dmtanzdvyPIJ523uDGvaEGzbnCgtOh9SARqJ8
         99og==
X-Forwarded-Encrypted: i=1; AJvYcCUqHArYaGwdhvJViKsq8cI47Qa3y2gZpyciCvBM6S1HZM65GvwAah/ic0tZ6Q6bEwja4WeScNCBBM7PedQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOrsjUX/fySgGFb0o5Wc8x9t7bIAoBrm9wtbJNBZu/2jhe+9RN
	fmrUmZ2BRpkYtnxeO8a4QVmvqkxu2BbQeDKZ1SYoPB9KgEO4iEmcUFALTQ==
X-Gm-Gg: ASbGncuQDQLqDRzS4iB2LstZfJ+QO3NYuZuL5YeqfFDiUCDMA4SZfImmxxwv2M78DCP
	ezg0S9yg8yIAfZHQB0YpkPTnAV6M9QxR0l8as00EauoN1G3ZUqf0UY88BCZOQiakIqX0Ess0kMD
	Xkkohsz2T1yRvOtkf6C6orq5ff9I/i6ZFlvoDelXkVRJf2KMqBITjfETUaKCbu1GH4TKCfc3Eu1
	HAd0VtXFBmGKlrezX7lU1hO5yxDmVmNYqVIAEofqIQWRnv2trhmLU+reMmVTintaluzChf5qegH
	I6lP8WoYkX/7viVXic9bNNBjllN0TA7G+ehE9YZEg1vdlDJi4Rp0Lj5YRxsoGnRHKvMLzFy/gld
	MzKZISlIOHWzb7K5D91I=
X-Google-Smtp-Source: AGHT+IEvhS18wTKX+c8IYc31Au0/3KT939YFXa3BJW3vrKUed7Mj+sOxxvuClC0+8dCW0VOH8eaJww==
X-Received: by 2002:a17:907:9588:b0:ac0:b71e:44e7 with SMTP id a640c23a62f3a-acad3574329mr415888566b.12.1744656169696;
        Mon, 14 Apr 2025 11:42:49 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3172sm946483466b.24.2025.04.14.11.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:42:49 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 00/11] iio: accel: adxl345: add interrupt based sensor events
Date: Mon, 14 Apr 2025 18:42:34 +0000
Message-Id: <20250414184245.100280-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several interrupt based sensor detection events:
- single tap
- double tap
- free fall
- activity
- inactivity
- sample frequency
- full frequency g range approach
- documentation

All the needed parameters for each and methods of adjusting them, and
forward a resulting IIO event for each to the IIO channel.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
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
  iio: accel: adxl345: introduce adxl345_push_event function
  iio: accel: adxl345: add single tap feature
  iio: accel: adxl345: add double tap feature
  iio: accel: adxl345: set the tap suppress bit permanently
  iio: accel: adxl345: add freefall feature
  iio: accel: adxl345: extend sample frequency adjustments
  iio: accel: adxl345: add g-range configuration
  iio: accel: adxl345: add activity event feature
  iio: accel: adxl345: add inactivity feature
  iio: accel: adxl345: add coupling detection for activity/inactivity
  docs: iio: add documentation for adxl345 driver

 Documentation/iio/adxl345.rst    |  429 +++++++++
 drivers/iio/accel/adxl345.h      |    2 +-
 drivers/iio/accel/adxl345_core.c | 1405 +++++++++++++++++++++++++++++-
 3 files changed, 1790 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/iio/adxl345.rst

-- 
2.39.5


