Return-Path: <linux-iio+bounces-19410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49280AB259D
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 00:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDB49E0E04
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 22:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A81212FBD;
	Sat, 10 May 2025 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP91Bpq+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93751D88A6;
	Sat, 10 May 2025 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746917079; cv=none; b=lrewaCHqhjA3cbu4tWCbkQnBFOMXILFbPDpKVDuFzoZzvaFNyVn9yjwGh1l6VrwnXKhWIl+R0J5Fs/yivDZ7DFit4aB53N59KGtD6W3r5n9NBbc3Vwa0ad80kia9Bh4BVO8jdFJl4xPAGRZRmn9igYCDpOrgeATYTA3wcx7hXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746917079; c=relaxed/simple;
	bh=1sD2ANAPhxbMTgUJjV6OOFERUaKdrVWCpm2uXtIcbJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H9ZYRh9rKaPn4QhICX/2qlDZnX4ygyOnTC8QEJZ1HAwbtF5qryeJw3aYat/EXKUiRsiYu8Bx4igcjlyUw0V4lhVqTLPipt9UwRY3Iz3gPsTRYdpOjUNlc2Ya+NLikvn5OWzTvjZ/goBkeunZSsES30VKDw3arGss+fbIo8vuEXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP91Bpq+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0b570f44cso449045f8f.3;
        Sat, 10 May 2025 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746917076; x=1747521876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLfoFm2aKPUkwsjgXuQTlUH0jobhXoQ876loWM2/gCc=;
        b=SP91Bpq+5UfzU8yGxA40JARes2QhVnY8MI08ZhG1SDqqldX6vDbDy8SEkUnqGRsa9g
         iZQIoZj3z7SXgrsgsMqmmwDc8qMDd9qEZXWtX6A1/RQw/+z1iih2h3DbgDZUD2NlXxGc
         /WFsVVyPIpmfUvjSFkE2FWe5VZ2/apL00QHpgMssbkQL57hkBC0Wse/ryaOb6iLj9J36
         Z8q/MfpHzRpKuRievTGBH8SJ0Vvu6/xhEWN/meGXL5HLwrYerNH8TM6eGMJhIEOHRgMD
         lwNZqdJlPojbAvnOGCOXznk+xYd5c9KceW94aDCmbmsa0zP/AnFI032DnYg26+PIXObD
         9HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746917076; x=1747521876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLfoFm2aKPUkwsjgXuQTlUH0jobhXoQ876loWM2/gCc=;
        b=KTHNlAQ6+ZCbBaDMK/LbRq6D6TegxkWIzcvlHCH4UzTqwGwldLXkWTr4Xv+kKNKLA/
         Qsf5x48Pox+NfvDWCT3fAOvpUX5MSltl705xUrcak6gkiB1CDec1e+ygRoAwKzwGstAv
         UkfhvtlJWN0pwWyOZbPcVIm2VCFPmq9yXqs35Am/o3yYK3EnUqT0hehKqxofHfCDf9E4
         f6ntrKt6XUabFY096rcWe/8xzgM5twfraLnGBJ+XJq5Ob++Z0gHDOGVMDYe6bMYNZqJ1
         2B56z+7YX5/6f1UwpPdLdQ1hB+IvhniAVsUUXCCj4IdQJy8n7JMoyLNd0zPGAJQMxUGk
         PIBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2LM7R7ok2bJbhgIs2HMoOTp+83i+ROyZzI04QdkyxxWwTDroOgKAieJiCqI7BBpW4qyLNd2Zby8h9TSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmPDz1jfmZ2t28XXszVslA/u7UauigJD4ZbdCTQn6DWwamztlW
	CgBG2eqaS1TKD6aArUCagZxB7+76wTr87jy9dL8gWrB/ctTle4Nf
X-Gm-Gg: ASbGncu7VEsA+d1xDpw7LVW35pAj82C1ZnEb4BeLYnM0L4oymMJSa/MMRC2y4YA9xyw
	zFkv3IF5NMVDAzQze1kmG6UkIQ1sraJY/XZOYp+dzf8cnU1DlzTmcpSRno2fcMOfJD7xjNJvaaI
	YIKMxrYqlHLMKsc0BsegwaF4WxfayKaxM4UBwaUKMcbt/R4sEMMzjLXxQMruEsescQ7C7O7HtK2
	7iKgqMnEWtyWfhYJGmeNl4gC667qKNav5vbYVegEQHGejS6r7PT6FG5fGksv0mNDiC5qvCsgSZ1
	LwjcCU+u3mq/KYCi3iMvvYI0AzYX8z12VPXko+0txROSrJApWSJI/X1C4XnQ+mHFCCMc+CyZvWF
	9Bpx3TGxB9RU68x+5tmTVIw==
X-Google-Smtp-Source: AGHT+IEujXYieBF+xZYxwSREZGjjefiVBeXxKXImt1iUxerxbvjfPVA408i2Ut5KyhfNHQYbkpTihg==
X-Received: by 2002:a05:600c:3513:b0:43b:ca39:a9b8 with SMTP id 5b1f17b1804b1-442d9c8e883mr21960715e9.2.1746917075868;
        Sat, 10 May 2025 15:44:35 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f65sm7701015f8f.55.2025.05.10.15.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:44:34 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v8 0/7] iio: accel: adxl345: add interrupt based sensor events
Date: Sat, 10 May 2025 22:43:58 +0000
Message-Id: <20250510224405.17910-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several interrupt based sensor detection events:
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
  iio: accel: adxl345: extend sample frequency adjustments
  iio: accel: adxl345: add g-range configuration
  iio: accel: adxl345: add activity event feature
  iio: accel: adxl345: add inactivity feature
  iio: accel: adxl345: add coupling detection for activity/inactivity
  iio: accel: adxl345: add freefall feature
  docs: iio: add documentation for adxl345 driver

 Documentation/iio/adxl345.rst    |  458 ++++++++++++
 drivers/iio/accel/adxl345.h      |    2 +-
 drivers/iio/accel/adxl345_core.c | 1172 +++++++++++++++++++++++++++++-
 3 files changed, 1592 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/iio/adxl345.rst

-- 
2.39.5


