Return-Path: <linux-iio+bounces-20097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2A3AC9F7C
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510A11710FB
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 17:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B6F1B21AD;
	Sun,  1 Jun 2025 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYRMDFDi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209B33F3;
	Sun,  1 Jun 2025 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798512; cv=none; b=mHproKVRfdfl5LK/KvyGJJ39Sa5ZKy0YNU+cY1f0jNohyzWydCWBqtODt4YvSc6CMBd9RIJugGZgVkBLhZ7lGB4iDLpydHsNSDlnn2ufOvfYNpSTBW92f3EKoAQFDfodei5trnzHv2ivJRr7OQES9rvV5fXcaXk+YB86DAED3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798512; c=relaxed/simple;
	bh=PIukWUDTCw5TXj+RvxEOmXbYSerT1Ae80KgmZvLwJMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LmxYrppTaizNcWufr6zhRGxgGTKquyjMnqCdwW28qW1uZ56K0cXOOeBOvjFjux60e4gYQa4GawDVjDCc9hwt53REZVH4SJzvqV72LRXR2SF81++ivr2W58ZYdthXqIeLrd9v1qYinTFUBP7Pwo4v5/8ZFZzcyMwNUC5BwBZRD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYRMDFDi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4ee391e6fso449637f8f.3;
        Sun, 01 Jun 2025 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798509; x=1749403309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXSrbUu8+ap+X1JrDu/4qElvEMBtdDAY1rNkMcoCeqY=;
        b=gYRMDFDiICvANjpTj2xcWfvYrWE9iQXlJb9jt5iGaX2EEaaRQqd2Y3IBnM4InW9j58
         dIwn8oaf9ZUCNd1mgNskXaA1dNKmZmsVEr9pQWWk6PmMIp3TiskH09fob8CxfhLd3h6X
         K1GE/JUcr0PKrrAoOSbtfeIucMsMRaIHQx/zJS+Jq6lE17IHaK8Uyd+0fyqUujQE3cFW
         MymVsh3M3PbDOOP/pLZSmuceTJDxO0ShYXCa6sEkNey8rblkjWBa5DEFCPdhXim01jTk
         ox3nGHMbyJIL0ew7OTkdkfvnjaaobAAaO/Y/liYZccHk8k8trUiT4UJmnC+B3wXFEKZi
         VrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798509; x=1749403309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXSrbUu8+ap+X1JrDu/4qElvEMBtdDAY1rNkMcoCeqY=;
        b=uc5w2YLdF3pl8xTul4yrZOpnwj1qnI7nAhznQidL2Ka9M+OTaNdHv5AW9EDFlFrFqL
         RPH7Fg2Quf1tNzcWsM0oaXaPgnjXo4YeqhNnqvnhd3aJgGHlh3+obTcRHkoPO5vVN+zA
         SeGf1MH2+lALJvtr8zCoci5yIwLxo+OUBqDWORlviuku2nq3x+4Fkn5y8MTAiijWlI37
         cZnk4hZYSj5PHNM2BfmTzJ270tR+S/rK850/PTDAPaEZXRhgPTtjrRF2dli9lFakYu2k
         okN6vGrsKgtYJPXPC/Q/1vHBp1FHsMwQnJTA4qBOIQGfFEiEGw0K4AdQIiRZMmPR+9MV
         Nymg==
X-Forwarded-Encrypted: i=1; AJvYcCU90CBtX2dsQJYK11E3goUB6+Roeta6cOC0T9EvYrvzqFLY3WvkXiwJZE7fyJKF/GS2ek8DO5hCVOQ=@vger.kernel.org, AJvYcCUO2Nrs7xCnYGJg2Tm8d0viozjc/qoLFoaA0foibFnlhElMjsekfVQCZubSo6+3pI5ykvet6vvkN97CzLIL@vger.kernel.org, AJvYcCUUCVJ+CtqxiYevh1/wD+pSrfHoVu1OMgVVJTZYNLT+95D6bOuqRLVB5bcU/gwKm4Mi7+FSez0djpHm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6gIcRhN7FFcIyjiVafFNIvS5MuyQ032y95Q4anp49hFyd6ohP
	G3LfW7XW6fgVt2VbvSSWED7dwkR8/GqX7DPVEfHiL+iWh5mA70jKz3t/
X-Gm-Gg: ASbGncsAYMV8tpvpbp3EtRrgnlQe8tUGYeac94nPJMPlf0IO083xBDu9DXGIjkq16N1
	IQlwtE7HlbcGbGxc2B5pTEFzGO/uOMbkH/yV748RsACQZppXtcJ6tBg2mc1fwqs1fQ28h7wKS+R
	Fgbs+2axlV0lsz7q8cPIfQdd7a+W5h38jj5DpMMTsUdJPXFZckbTErj8mobfx8Y9VUyRmQIlN/y
	50Lkjnfs1fwkkKiNAk86XHt2w41BZS2FqK9yHufHcM3fMAdvuS8aGYeqIUmWhJl+4QG2QgVEYIg
	WyG9u73O6ymF7zIZAIo8XUWLVNDz/7CMmP8EEQFWaQdmtObjtzJO/0eAdBKWPEYTCGiTuLtNJ2r
	muLMVmdXD2mcpeHbgYZtHuA==
X-Google-Smtp-Source: AGHT+IGKLo+J/IMJnRo1X2++GuBBqzTwfUqHwHIKzMwQVKHWm8ZZLKLYDzT82o6TsJQJzjICqnOiPQ==
X-Received: by 2002:adf:a189:0:b0:3a4:f8a9:a03e with SMTP id ffacd0b85a97d-3a4f8a9a069mr1849844f8f.3.1748798508594;
        Sun, 01 Jun 2025 10:21:48 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm11890444f8f.84.2025.06.01.10.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:21:48 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/11] iio: accel: adxl313: add power-save on activity/inactivity
Date: Sun,  1 Jun 2025 17:21:28 +0000
Message-Id: <20250601172139.59156-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch set covers the following topics:
- add debug register and regmap cache
- prepare iio channel scan_type and scan_index
- prepare interrupt handling
- implement fifo with watermark
- add activity/inactivity together with auto-sleep with link bit
- add ac coupled activity/inactivity, integrate with auto-sleep and link bit
- documentation

Since activity and inactivity here are implemented covering all axis, I
assumed x&y&z and x|y|z, respectively. Thus the driver uses a fake
channel for activity/inactiviy. AC-coupling is similar to other Analog Device
accelerometers, so MAG_ADAPTIVE events are chosen. Combinations are
documented and functionality tested and verified working.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v3 -> v4:
- squash patches [v3 02/12 + 03/12]: buffer usage into the patch that adds buffered support
- squash patches [v3 07/12 + 08/12]: interrupt handler with watermark implementation
- add patch: (in)activity / AC coupled as `MAG_ADAPTIVE` event
- `ADXL313_MEASUREMENT_MODE`: adjust commit message on removal of define and adding measurement enable function
- remove irq variable from driver data struct, make it a local variable
- `adxl313_core_probe()`: flip logic to condition `int_line != ADXL313_INT_NONE`
- `adxl313_core_probe()`: change mapping interrupts from 0xff to an explicit local mask
- `adxl313_core_probe()`: add comment on FIFO bypass mode
- reduce odd selection of headers to add [`adxl313_core.c`]
- `adxl313_set_fifo()`: this function was turning measurement off/on before changing `fifo_mode`,
   called in postenable and predisable this firstly excluded setting of interrupts, and secondly
   still configured watermark where unnecessary, this function was thus removed (covers unhandled
   return value, and refactoring of function parameters)
- `adxl313_fifo_transfer()`: simplify computation of `sizeof(i*count/2)`
- `adxl313_irq_handler()`: make call of `adxl313_reset_fifo()` conditional to OVERRUN one patch earlier
- includes: rework adding included headers
- activity: change to work with or'd axis and related changes to the fake channel and arrays
- `adxl313_set_act_inact_en()`: generally turn off measurement when adjusting config
  activity/inactivity related config registers, turn measurement on after
- doc: adjust code block highlighting and remove links

v2 -> v3:
- verify keeping trailing comma when it's multi-line assignment [v1 02/12]
- `adxl313_set_fifo()`: verify have two on one line to make it easier to read [v1 07/12]
- `adxl313_fifo_transfer()`: verify removal of useless initialization of ret [v1 07/12]
- `adxl313_fifo_transfer()`: verify usage of array_size() from overflow.h [v1 07/12]
- `adxl313_fifo_transfer()`: verify return 0 here [v1 07/12]
- `adxl313_irq_handler()`: verify "Why do we need the label?" / moving the call under the conditional [v1 07/12]
- verify reorganization of half condition for Activity [v1 09/12] and Inactivity [v1 10/12]
- verify usage of MICRO instead of 1000000
- `adxl313_is_act_inact_en()`: restructure according to return logic value, or negative error
- `adxl313_set_act_inact_en()`: restructure function, use regmap_assign_bits()
- `adxl313_set_act_inact_en()`: verify makeing it a logical split [v1 11/12]
- `adxl313_fifo_transfer()`: change iterator variable type from int to unsigned int [v2 07/12]
- `adxl313_fifo_reset()`: add comment on why reset status registers does not do error check ("At least comment...") [v2 07/12]
- `adxl313_fifo_push()`: change iterator variable from int to unsigned int [v2 08/12]
- `adxl313_fifo_push()`: remove duplicate check for samples being <0 [v2 08/12]
- apply `regmap_assign_bits()` in several places to replace regmap_update_bits() depending on bools
- `adxl313_set_watermark()`: rename mask variable to make it more comprehensive
- removal of duplicate blanks in various places (sry, my keyboard died) [v1 07/12]

v1 -> v2:
- usage of units.h
- simplify approach for return values
---
Lothar Rubusch (11):
  iio: accel: adxl313: add debug register
  iio: accel: adxl313: introduce channel buffer
  iio: accel: adxl313: make use of regmap cache
  iio: accel: adxl313: add function to enable measurement
  iio: accel: adxl313: prepare interrupt handling
  iio: accel: adxl313: add basic interrupt handling for FIFO watermark
  iio: accel: adxl313: add activity sensing
  iio: accel: adxl313: add inactivity sensing
  iio: accel: adxl313: implement power-save on inactivity
  iio: accel: adxl313: add AC coupled activity/inactivity events
  docs: iio: add ADXL313 accelerometer

 Documentation/iio/adxl313.rst    | 289 ++++++++++
 Documentation/iio/index.rst      |   1 +
 drivers/iio/accel/adxl313.h      |  33 +-
 drivers/iio/accel/adxl313_core.c | 905 ++++++++++++++++++++++++++++++-
 drivers/iio/accel/adxl313_i2c.c  |   6 +
 drivers/iio/accel/adxl313_spi.c  |   6 +
 6 files changed, 1229 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/iio/adxl313.rst

-- 
2.39.5


