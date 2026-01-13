Return-Path: <linux-iio+bounces-27675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BBAD1A6DD
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 17:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80BB930194C4
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB734DCE4;
	Tue, 13 Jan 2026 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zuh5SqVI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F21F461D
	for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323149; cv=none; b=NitLooAmCw/ojwxwdM1myhbiXkjH0nxKT0wkE5+LiZHi2JK44SBaO6YDbDqmoVFmJaPr6a1nQ5qepx42q73P+Yx00wP9WvKwfO17uonZ+K918PY3HhqDnvWogYmvR8StxDcngRcKTPvCU+jQ6CD+3bslrKZsn5JQuZ1IryYWI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323149; c=relaxed/simple;
	bh=87sM8oKP90w0z33dkwRxWaZIAcg0ysEHSvMr/Qcbr1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ebsJy+wjqlGXhVzN7DiWP+kaYxK/Igo5pEy1ft/OtqAfPfJJqveAhWTFbe591+n7+rlFS2TkjXjNJWgvA54CVyg3jScPVteJOKoP8ZyfPcN/A/yiCrtZ2nMsvQCTt7hdCQDNu0ejo5fS+qa0wZWWDaKjIj3aLRuoDR1nH5X+aVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zuh5SqVI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47edffe5540so4698685e9.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 08:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768323146; x=1768927946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pccbmgwn2QEBQTzOfFfVx5vnJQO1AdZUP/7cqVG+l70=;
        b=Zuh5SqVI3nB1f2A6D0Xwke4Uwe7iANDCX52uSozJ/uEowwwbOREqM8UKK7zqgZN4rJ
         9juBxgesr1nARzjrm9Ik/P4KpZn0BjKK1wckKEhT7Npqvm8fDFfPg020JKZ5fFx+zyzw
         BZfi97nYZ2nYmLfIH4xgh2dPCeQao3xGq7LWUfDI1iHujMwvfgeQN1ijs5zq7GDvlNW5
         U+6lBtnzrOkWCBhF8/419BZ0S0qeruKEg7wgaarORgmxw1o8mO42+Vk6N9XYIc+PvaD4
         IoLFNB9U0qvnkH9mp6Rvmxp06jETnrEP9SnZ9YFvu+9QLYXRjWlmUjkP8vbJYUnERv6a
         RA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323146; x=1768927946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pccbmgwn2QEBQTzOfFfVx5vnJQO1AdZUP/7cqVG+l70=;
        b=Ytk13YqtOan5OPQ8BepcqqsZKPu8T3GC9x0KSxpNjpd5pR0TOehxsvlSdZ6N6+nBrz
         cW2x1lrnqYscUokbWFYwx6+dv5bcJ+shOuHSEg7bXe8qteB3QmeAVOYr6d4P/AVvA8UV
         lhXjmheue2oXRX5r+p8mYB+LhC8vTOaV0VRY5L2d+bM01iYckko9w2AUok4x0HB4JFdb
         laxO/XHTq33ZOCjqs0JWY21oqKut/AzHWOkb/sBfPQ1dkHmuUE+MBYIybmGGMuhpPdj9
         gZ5TWY4owdwGKFXhzlZcPWzixwyin3uDtfwRbPirlXaN/LSBfjvXiElf6iy9EOk4K2KU
         YZQg==
X-Forwarded-Encrypted: i=1; AJvYcCXMbOqWHIKOBFEDPqtQ8bP3TT2LGgD6RfuDBSQ9luJq22X9RsMl6m1btmdtEiLVD13FD8uMz4CCOBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSTBzSyFodyHR6U/qELjtJ7Ampo1zTptpua4V2LTSunTkkyPCK
	yuhl2udpxWYavf9YEPEiCqy/BgL5WoLviGWE/nTObpIuRtovI0YFdBGsaT2d7RtSG7E=
X-Gm-Gg: AY/fxX4Xx4Bejpz6jXhwYFDvgNzo8aBkZ+34F/dcuTjQmvt5XvIXKUUWLLxPrAKR/hq
	EVZLWR1IVvFcNj7tCn8HjK/g8/XRrQwwRTH9hPqdjWEB6xPInalfEGK9NY1E50rwYffEVihv/e8
	kgN4WzfT8DK1L1ILPyUG934P4RjrOtVsimxiqNRenYD1B25ooHm3tdq0Nk0ZTjsA/luZiKDBpTw
	Ez2HX+zN6hLXEKbcJJmRz3tzzZ++lbSf1spkz1s36pmlK96oks1cP0m1W6SdOG6sI2+AO9gSrUQ
	SQaxNq6PoJGS9/ABWm91CFaFEHMSNM+CyZN8m9hlBfAR1pbZ19sIW8lMWSgGXBuCaHDuXvYaEHp
	KtMxkYIK+crTXa7aD2oAvz0/9bWK4TCa+8gQ+LTjwgcUCkzIQZ/qBF0/6fjdkrr20mU2Zoh/QM7
	rRG9tWzYplO2eiuyUQyt12l9WgZQ8aA5M=
X-Google-Smtp-Source: AGHT+IEIp1YZBUlweYWaCnnIBVy0+bF1LqyJ+T0qOr1ZxyTRb97O7yWvJcGGelOgdVfuRVXXKCscSg==
X-Received: by 2002:a05:600c:3114:b0:47d:3ffa:5c75 with SMTP id 5b1f17b1804b1-47d84b31531mr215631915e9.20.1768323146177;
        Tue, 13 Jan 2026 08:52:26 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:3594:70ab:9964:c5ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm431684925e9.7.2026.01.13.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:52:25 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org
Cc: Frank.li@nxp.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 0/3] Add the System Timer Module counter
Date: Tue, 13 Jan 2026 17:52:17 +0100
Message-ID: <20260113165220.1599038-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NXP S32 family provides a System Timer Module (STM), a 32-bit
free-running counter clocked from a peripheral clock. The STM includes
a prescaler and one or more compare channels generating optional
interrupts. When used as a generic hardware counter, only the main
free-running counter is required, while the compare channels are
typically unused.

On S32G2 devices, the STM is exposed as a simple counter block that
can operate continuously and be shared across subsystems such as the
Linux kernel, firmware components running on Cortex-M7 cores, or other
co-processors. The counter can be read atomically and provides a
stable timestamp source to correlate events occurring in different
execution contexts.

The Linux kernel controls the STM through a memory-mapped interface,
configuring the prescaler, enabling or disabling the counter, and
accounting for wrap-arounds. Other subsystems access the counter in
read-only mode, making it a shared timestamp reference across the
platform.

This driver adds support for the STM when used as a counter on S32G2
platforms. The device is described in the device tree using the
following compatible:

compatible = "nxp,s32g2-stm-cnt";

The driver exposes basic counter functionality: start, stop, reset,
prescaler configuration, and overflow handling.

Changelog:
	* v5
	  - Use a lockless version to implement accumulated time (Frank Li)

	* v4
	  - Split context structure to suspend/resume
	  - Converted counter to a u64 to accumulate the time
	  - Replaced 'reset' to a count write to reset (William Breathitt Gray)
	  - Added events for userspace (William Breathitt Gray)
	  - Added action COUNTER_SYNAPSE_ACTION_RISING_EDGE for signal (William Breathitt Gray)
	  - Renamed counter name to "System Timer Module Counter" (William Breathitt Gray)

	* v3
	  - Fixed compatible typo "nxp,s32g2-stm" to "nxp,s32g2-stm-cnt"

	* v2
	  - Added Rob's tag
	  ** kbuild
	  - Reordered alphabetically the headers
	  - Added bitfield.h header
	  - Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()

Daniel Lezcano (3):
  counters: Reorder the Makefile
  dt-bindings: counter: Add NXP System Timer Module Counter
  counter: Add STM based counter

 .../bindings/counter/nxp,s32g2-stm-cnt.yaml   |  64 +++
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |   6 +-
 .../boot/dts/freescale/s32g274a-rdb2.dts      |  10 +-
 drivers/counter/Kconfig                       |  10 +
 drivers/counter/Makefile                      |  21 +-
 drivers/counter/nxp-stm-cnt.c                 | 432 ++++++++++++++++++
 6 files changed, 524 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/counter/nxp,s32g2-stm-cnt.yaml
 create mode 100644 drivers/counter/nxp-stm-cnt.c

-- 
2.43.0


