Return-Path: <linux-iio+bounces-18468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51908A958EE
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A03C16E9E2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 22:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2A721B9F0;
	Mon, 21 Apr 2025 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKOdDGuC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEB1519B8;
	Mon, 21 Apr 2025 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273218; cv=none; b=pJW/X5NVXnzDKXR5J2Zqpk5pviqCFPvYqx1fekcDMqltHI/ZMi3Mp/ey9lw1hXUIDJO13MJ3aTcdx2rTF7OFOR91Ebow+tLpaj4Qp8h9bnWlWTGx55+1hMFSuyfOhMRHlxyqln8MscV3C/fSbX/Uj2zXpUNTkYwSDIzSKmZydZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273218; c=relaxed/simple;
	bh=C6MfdvBXnlf2J+6yGEzRE1YhM0RK8Cy77oBywTDl/l8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nbKguFxgFohRe0Hu0M++nsFN0FkaC1jLjmPTRYHBBrf79gCyWuKaJ03+8rG8cyFw2fWAirpxKpqj8a8LgVakxj8DzSi5mLZKazF+gScHJ+m30Gj2ZDWBz1XMbXyv3FSdr0Hkxj9za3mmevlj1yhDQR+7LZjYTcyEQGVZatKRf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKOdDGuC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e8484bb895so1324467a12.0;
        Mon, 21 Apr 2025 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745273215; x=1745878015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h8mqZGYqLTN8UByiAa47rvRDWl5UdqqEdI10CNaV2Eg=;
        b=lKOdDGuCG6RAS7b6Dj4iapRBx14YV1Q5jmXjcJgZvxNpjdYUMmznoDQNTUUNSCAiSy
         OT/boczHm3qOWLfc+N+r7CVt9c4FdqgL+AQsgzEuQwNFoZBakHpugMrMSZvWY7435M7M
         0rNky6atIUna+uS3u2P9lP322S/IJd24Lgcf27x8RD5Cap4qSyCRN8UYK/0IK75iL577
         SM9rYYESceTDPOwdXK8RE/nF+DYDyap1puWK8vVKgwhoxDhrQr4OyXYYgHlpP2Vyh2vf
         TXVJhjpr7I0TJi/KOtOyU6jaUo9KboxxBUMGiz030WpBWbMYp/xFmdEWozTBK1LOKH/I
         8RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745273215; x=1745878015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8mqZGYqLTN8UByiAa47rvRDWl5UdqqEdI10CNaV2Eg=;
        b=vmqCKM4zR/KqmmJ4MBDRRs+dUgqkM4u5f1RENVXlFLwoAOTn0IVYn8kPGCkrhg1Trh
         2OTgftJWrIjMQ+sP1waRJKSQhHCuwOPsu36eOgMhMntOjwnb7sMNiFtoz95txgC7gnLI
         xQnFb00/IsCXUtfTLnDu00WRFWzoD6OnJ7JYCVqIJl/vTtF4AOiY9l7kFwEwcvUF1FiA
         4IRTcdPF8DeLqmvlt5mwSS26ON5h57qhu1zWQvUFpqzpoR/fq7V2FGiq4iet3d9Q4HdZ
         1Y+XIRmOWQB3iSLC94+2zdONAwFqLL5Vfg0/OQxv19ofIWyrcp60oJIFfQOaXza0NrV8
         dCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWotr858wM1CwuxvkVMoEUUFxuDsGdJf0/u8gjLeeFvRd5Un/GY5QE6TdT34QSrYsQ97TfbJiFs0Gobig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9s2itOwZoyogwNffjv8piq+9fQ6uiix1tYaeRbpjFy96OXAon
	2xe7lnVjR0Y/0v6Cg7kYwp3b14Y1bBg92gURukrgHjL6E+2ELVCPJu1zZg==
X-Gm-Gg: ASbGnctHDg7uVsXe/Z0fr6/fX2x5aldFTxGxxgRwyCFg+5NCwc3BJwwLCyE4rSvtTEf
	CuJ4QEyj0BMnO4SQG2NYF41NpFUpbC98dk64EktesZdg9j6fv7TvRFMfKy1yOQA1/SyxZ5wpDgA
	m0YxsGL6DJY5PJYOMOp0/VhU7HHk/yJZ5m9D+5Wcg57qYzzm7h4oI4bSIHp0Z6XFyiwk6HQlVPN
	Hsg0QNLWhHrG3F79b7mU/sH0rcmOuHwfTDBW4cFrwqKZ1UtPLaSrbkNQXPnexcNeagWAKT+JBdo
	1BwYa7fRekFGVvmD8MkVDDf4jspk71kjYmVocw8dG2u2E939z9/3pJToCgNK45sT4Ve2Yo9fEIx
	zTbdTKhrsb3MSKQ5i2PQ=
X-Google-Smtp-Source: AGHT+IHy1p3hn6RDvUg/ZxbOagVKSGgCbAQxyF7F5q5szk1Z8BUEgavvdsr8iUATe52ZvEL+2XlsrA==
X-Received: by 2002:a17:906:6a0f:b0:ac3:66fb:b197 with SMTP id a640c23a62f3a-acb74ad333dmr342270566b.3.1745273214951;
        Mon, 21 Apr 2025 15:06:54 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acbb8d49fdasm80311666b.67.2025.04.21.15.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:06:54 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 00/11] iio: accel: adxl345: add interrupt based sensor events
Date: Mon, 21 Apr 2025 22:06:30 +0000
Message-Id: <20250421220641.105567-1-l.rubusch@gmail.com>
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

 Documentation/iio/adxl345.rst    |  423 +++++++++
 drivers/iio/accel/adxl345.h      |    2 +-
 drivers/iio/accel/adxl345_core.c | 1413 +++++++++++++++++++++++++++++-
 3 files changed, 1792 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/iio/adxl345.rst

-- 
2.39.5


