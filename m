Return-Path: <linux-iio+bounces-15247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13490A2EA5A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA903A2210
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5249E1DF99C;
	Mon, 10 Feb 2025 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R18zQKaa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547EB1DF26B;
	Mon, 10 Feb 2025 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185297; cv=none; b=fzgSFBc9LI/eqcChqtGbwTenLU6YeDQXwDwCrv3J6L47VZC8vAkgDQ2Tq99ZB0bLxAM07OA72L8zvoYPG56DWHsDJo2mlMGpP28618/h/Mmfkuhleq2zbQ3avfCTkLP1Zhzi+MqiOzoqxMlVqOmPL4/vbCuuG0xDykMkBKUWuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185297; c=relaxed/simple;
	bh=Rr9UUcX+33xdUc4/5xVaE1y9xYYkfHcWmdwbBqN1Xt8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uPQkvRpGe268UTMMNSSsT5G5QXrNFcMbRdwfCAtxa9RVXqPbPk+JNHfyXSSKJHHhl9T1lHebc2+SRZM6JSS+9XJVPf87aW7azr2gB7jkT+gyEt1HvvE0gMFgp4dVDMs3Nhpg0iHj0A7IzUxv7plooLtXgCWvaqmNbWkw6LmO50s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R18zQKaa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5de38708eadso661263a12.1;
        Mon, 10 Feb 2025 03:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185293; x=1739790093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H9pSHqreoAEYLO5B/PXo3JmsRj3itJwfodn5sU9RTgs=;
        b=R18zQKaapQYsZQgGHIfNhxzlWibe8imZCb4YxUHyqgwCrs+rzYXzHOy4Ur/jv39v2h
         OExr5vutZGT4dTNzoABrsM8LIO2O23AX//vXkK4ALOnsWje7VzaDHtdKd9G0ZJ5ozw9k
         48Z/3Cumxck/iHrgOdStAmfsYB9kRjlMK0F05Xi88D4AwORP1pefpnlu68C+1VxO42lV
         JLy7FgvvvCZgClIrbphQDuFSexg7XMckjq47imY/xQXCSRmlnR5bqwnVv19WcBgJ2ooh
         FI66hNPbkZpV7PZZ1KIpJ7BKcNfxRQxrmltGqVFk/DSwiFJ0gN9vV728SOJ+x9rQx+/y
         b5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185293; x=1739790093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9pSHqreoAEYLO5B/PXo3JmsRj3itJwfodn5sU9RTgs=;
        b=ONsytpusi3I/XDBTAiD9mDNlXLkb0xBjZY98C2kx15026KfXVDC2w9TMSaKId7j6yU
         uI1NBmvwlI5hRA0rymR8FYL45/Z4xUXrSGmgtb+PjIRmAp13FERpIfQVPjK6LxsFw9/T
         wCIIx8Mb4/PYv5XCxUx+FIcrahq27dbnoFpBG/ZMO0yoASlHwdMe4kVP/AuNtbEL/az/
         zBSPkpPO91YFbFxAdjyCA+xNLSCBUyvG8l3rpXhUUhBYcZl+Zu29OCtWuFxfcy591cZ3
         uIu7DMsprwdBkbv0aVTqSyJG5bXSM//kj9fGvkKA1ak8BF+5V+POlYdg2N+/HMEVbrFQ
         p4iA==
X-Forwarded-Encrypted: i=1; AJvYcCXpUfR/POqmp54XtMBpy5TeJdRaQzdul9YN4m/ZvOp5MHmfzEaE7ckyjVRfQorzp6/PfqrRO1L0+cznPGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJctt9+KmuWIm6SS4FvVEHHSbcll/Qdu9WpsTkwfrcI3iAghb
	7SrD7Bynt2edjWtyJWPuCm+TK6aeCmtTUdxR2FJgAGikXFiVW3yC
X-Gm-Gg: ASbGncv75Xm3amF9QFdSuRguAYOpupiJOfkUVqJ9s/OI07dbat90WhXPCXpbAM88G8T
	tC0F1R/ilU5zv8bTBCzUpsYlIMRV8b4V2cym0yoQWZvBH+9rsbAXt/FDKtGS08XXWKgQh8Fnk4/
	Yl1sRgFk7IdUwZTc/x+/0WIRb/8RyIgf+o95Sbd6tplf4TDtm1xxNKrqcoCZGqWphHjgJfcKbGc
	wlbwofi8YuIoTUl5JbzqK6Rtyou1dNoMCgYnX0XoaMLgceDCDSFBrc6IbnP7jXh/0qzPha4fKZF
	xL0KipUOpYi5MlDWXewKwXX9epSnfv8LjBajBltolU+YDqNIJFF7vuKk0DNj575FQH/nkg==
X-Google-Smtp-Source: AGHT+IHp5xhSiRZxOzQfnMkh9Jr6dHwBa59wo5aWroPS3jjaFbdcqQD0EBIrmHr6KW1kV4XX+HYkTQ==
X-Received: by 2002:a17:907:74a:b0:ab6:d660:c84a with SMTP id a640c23a62f3a-ab789b35f76mr568351766b.4.1739185293162;
        Mon, 10 Feb 2025 03:01:33 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:32 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 00/14] iio: accel: adxl345: add interrupt based sensor events
Date: Mon, 10 Feb 2025 11:01:05 +0000
Message-Id: <20250210110119.260858-1-l.rubusch@gmail.com>
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
- frequency g range approach
- documentation

All the needed parameters for each and methods of adjusting them, and
forward a resulting IIO event for each to the IIO channel.

Q: Please have a look into event handling, I'm not sure there seems
to be something open (if more simultaneous events arrive)?

Q: Please, let me know if the single ABI change is legitimate, where
I need to document it?

Q: Please, also have a focus on the scale factor handling, is it
correctly setup? (I think) I can see it appearing in iio_info.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v1 -> v2:
- implementation of all events (but tap2 suppress bit) by means IIO ABI
- add sample frequency / ODR configuration
- add g ranges configuration
- add activity/inactivity using auto-sleep and powersave
- add dynamic adjustment of default values for
  activity/inactivity thresholds and time for inactivity based on ODR
  and g range (can be overwritten)
- add sensor documentation

Lothar Rubusch (14):
  iio: accel: adxl345: reorganize measurement enable
  iio: accel: adxl345: add debug register access
  iio: accel: adxl345: reorganize irq handler
  iio: accel: adxl345: refac set_interrupts and IRQ map
  iio: accel: adxl345: add single tap feature
  iio: accel: adxl345: add double tap feature
  iio: accel: adxl345: add double tap suppress bit
  iio: accel: adxl345: add freefall feature
  iio: accel: adxl345: extend sample frequency adjustments
  iio: accel: adxl345: add g-range configuration
  iio: accel: adxl345: add activity event feature
  iio: accel: adxl345: add inactivity feature
  iio: accel: adxl345: add coupling detection for activity/inactivity
  docs: iio: add documentation for adxl345 driver

 Documentation/iio/adxl345.rst    |  401 +++++++++
 drivers/iio/accel/adxl345.h      |    3 +-
 drivers/iio/accel/adxl345_core.c | 1378 ++++++++++++++++++++++++++++--
 3 files changed, 1703 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/iio/adxl345.rst

-- 
2.39.5


