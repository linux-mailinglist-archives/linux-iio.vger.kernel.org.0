Return-Path: <linux-iio+bounces-17055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E43AA6807E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AE5420BA7
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F19321146B;
	Tue, 18 Mar 2025 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBnery9h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F9205E36;
	Tue, 18 Mar 2025 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339338; cv=none; b=Tb2ZeJ7+3lykKMrKL6v6DwR1w2hlxg4PZrVRORrJQeq2h2uDPUlj4AO+dlldOHZhMYAM1qzkrKpRwqYVCKukgXub5ZjAB0bMcqWAS5TRJkGSDNwKW2qBemRfuwe2ESL92k3oijHCJqyE+pDVsyFu0iIFEXaAjtHrOzQ+6g1eS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339338; c=relaxed/simple;
	bh=w5mCLDWyx1cuGT1RX4FW60uukWc3JXofuQLqjMFFWfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u6eEYBkYmWjNd7iee3jRkG3ZZYaeQkcJ1Rqf5G1WwinV23VHSKKiZwn258mkpFh39IS5hV//t3OYB2YiQuLFyJEsZhcbiWCil5jPnj8uvuvhXGcPxjcfFrIB3d46Vsaw0ZFyDYClGowtECaMrEW4ZqC8ikMTWZz8OqeHCLCsWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBnery9h; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43938828d02so6397055e9.1;
        Tue, 18 Mar 2025 16:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339334; x=1742944134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KA9zn537nT8S1OadOFLuQ0BcFZnc5lz2tOqd9h0gF+c=;
        b=DBnery9hijLPruVMj5VBNP7Qc/nrGNKef33pvHHVDEJdhR0Jk5eTcYwwSlPgdpKcF0
         OjHR9nDKEtD1E2/cOnJ//bEGRyZr8zpNm8+I4aIH7ZLeBllUOhF+Xn/bhpQhQk3KvFYc
         UdBs5U6OfWhLZxbqFuLZPvUQENmm0esXM516etdLn1NK1CN02ZmN5rTN/OzQo2YiHFft
         1eO9GReHNMC2v1VXhrCXbJNBrp5wBQ7YKASSsUmeHyP0rb1cnE0ktHyO9pe+ps+wP7q4
         e9HfFE6JJDyassEhISihEXkKuKTzYpI5rOj+I7cQP0wnqe/DrVnLdQ/nF03V9hvbRlaD
         Lveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339334; x=1742944134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KA9zn537nT8S1OadOFLuQ0BcFZnc5lz2tOqd9h0gF+c=;
        b=gxicFp3ijjQqHOcGqEfiZLCCDVnadGMphMt8hia9qw7AfkTYnp5Sd+Q0hSMcw+ONJW
         eWpsJxfOhZ4bjM800r5TeBWdfEr1AEIlbATI7AqDcySwQwG0sQZR2OIH8c/Yutjs3Lk4
         WRZm8dbcvK/GWyDZKP6BHJYWeKOETjm23iEexvchLOt6xTSa9jwhotffsI+MeoICTd7w
         vEyongMJ70NY/ySXZ10GsPRAwXgzQvfN23mh2npVvNwAX9iEyt3R3cwxhv4cvtbLlVoi
         gJzFxdfcy0H6oLyLwpHIRWHXuxrQIYo4Odb/htDcLKLnLLcjrq5wcBU6wJnRHaMTWD3b
         7Hsg==
X-Forwarded-Encrypted: i=1; AJvYcCV4XcmW/DDXY+gVrH3DQsANYF3Q9aySL9d6qxi48SfyEZOtSU1hpyj13VW73vc+xMewow8xbrJg9lJjUtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eamAxdeKvtJJcgIGCtcHKCRZrjBRGWlJgIoDFc6A+k1lC7w7
	JZSH5NeLpIInzXKG+wGEEUwQdg+Wimll2U4O4q56p4HLRvDue1fT
X-Gm-Gg: ASbGncurNhORhoSts5M5p2akF0bEcIzx0L2OSZbyThKPdL+/fY3MBD5hxgVlY0M3VTD
	9xEvcA2VPCiIW4Pw6nn4YM9ZEpbczNhV+G9+vzzGR66jA8xwqyh1g8L4uS8Pamo55sk+1+HMZv5
	kErdXo8On9ieubSMqcb1ekpQDz6Tfjz7hY/0Dg4jf1mn7kdZB3munD3Pph2benM4CZeGPy7HwP0
	TIaPO/Vo11TAXfsIeTIOYjwcT9ezhxo/S0ILgonoMfHiw7LD0jtp6vlnPUs3EW0ARnO5fJSHCeI
	AJugr48xbUqmapWDZskpeF2avV7yH+LtuCuTTY0ig9c+DyaxjeC2IvDjsrYr61iEQdSRTJ69wt7
	9mIDww/kKd1NqPHED7UzSS9E=
X-Google-Smtp-Source: AGHT+IGV44n25SnVdgYFctrvgaChlSL/lC63ZUrmB9LsnyzT9RCnUivcB7VRyVyRN7xU6Kid+XX90g==
X-Received: by 2002:a05:600c:4e55:b0:439:8294:2115 with SMTP id 5b1f17b1804b1-43d43842710mr1023915e9.8.1742339334062;
        Tue, 18 Mar 2025 16:08:54 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm1113455e9.39.2025.03.18.16.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:08:53 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 00/11] iio: accel: adxl345: add interrupt based sensor events
Date: Tue, 18 Mar 2025 23:08:32 +0000
Message-Id: <20250318230843.76068-1-l.rubusch@gmail.com>
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

 Documentation/iio/adxl345.rst    |  416 +++++++++
 drivers/iio/accel/adxl345.h      |    2 +-
 drivers/iio/accel/adxl345_core.c | 1387 +++++++++++++++++++++++++++++-
 3 files changed, 1760 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/iio/adxl345.rst

-- 
2.39.5


