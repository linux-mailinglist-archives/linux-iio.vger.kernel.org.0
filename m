Return-Path: <linux-iio+bounces-12343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 096729D0501
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9328BB21AB0
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0A1DA628;
	Sun, 17 Nov 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xihp/RWu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864761EA73;
	Sun, 17 Nov 2024 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868097; cv=none; b=b7E/rdRQJboEvejc9DbVpB/AA5OR/HLnt30av8vDWDCuh17wwqMJ4esvlU4y+JXDRLs03x+Y6vaxhJXJ2shgN1owsi/kTiFYW321zqlZ3tmIGUTx1rvSxunasCfLmS/BkpDyWFAu7tjr9Dhgal7K0/M8+BnRRX+9vMLeo7pQu+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868097; c=relaxed/simple;
	bh=tYa1Z0HutYyF4t+LAAxxv0fRkYPg6GdxMWQHBmzGQWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LcBRkeEufe/KnGXs3HT5yVk7HVd2wVJfU6hDI4wQfFEqrHcHy4jbWDczJsovU2ADlrXyCmuZtBugWitczhUY5n8Jp/7QT1VMI+ndImLwz1i9AIgRbgH7rS2vlsr8W36l01qT9QPRpPiLxCL1DATuOWxcHa6+24j3J/xAm47fv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xihp/RWu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315dfa3e0bso2241025e9.0;
        Sun, 17 Nov 2024 10:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868094; x=1732472894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0yUSeeOvbqs8tHSlx92wZzZTLKipu7boU7UlyhJIHo=;
        b=Xihp/RWub+p+WU4m4xdaUDHJUzUi/spsitLCquR9QELTRRx/oRmEdyKi4Ju76y0HIK
         7JKCp5ghSX0ZYMqXTlWepXs45Wrzb78NAq9n18QmaxZWhzFK+kGT1PO1sBhpVeGedVSl
         rXYjPAZZxK504kFQb8TYONIbQQuJOlnNMdjyMsi9SfkpukyOQzFTJGjqAvfjFnLCVZQW
         iaQNhYg93QrAR5HWvCPnFLUzw/IPc1jcMA6mx84Fyq9yAvrXNkm7do+h0rYNYjP+fcva
         UCOEXbzsbLwMGXUvNQNybnlJPBi3ZscTIWgvb45oiDFec+tv1+U42sJbsKuxn3s1tHC+
         t8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868094; x=1732472894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0yUSeeOvbqs8tHSlx92wZzZTLKipu7boU7UlyhJIHo=;
        b=uc+jJf2kq20KvVPBAxK2AIZr5FfQWctYzxhBrfyU64Kv60niIykLBoKn3RktjX9/AW
         dGOBGW6HYj2j4cOabN7bdToLN33ZJsy/tG5Rjeuhkusz8qC1sq8F/YVxFrCWdsOHTBL8
         XS1H1SeAsn2p64dzRetRxoSJ/WhxT1xmGKLLWJCCc4txzEHICMmbZR6YA4DpFIFqC6rx
         7ARw0aLS/EPKyu+654SD/ZDnt14nkN4IPXSnCdspeQNk/scEGQ8FKi1VQesf+Nevx2Ki
         2T8DYlR7PLR/LSmnUd3CVQ4jUY7FhxD7iz3htyXkgGmvAPdFmlljR51oMGuqmDkDOVOg
         7tFA==
X-Forwarded-Encrypted: i=1; AJvYcCURg15wChXxMYRmt2ObuRaJrtGlmWEa4hmal9ImOsWVA/NHOPvAc4t/iAQQH5Qm+0Ok/sRHGYVD4ZmMGTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXB3/jLvyEiIRYC4Vy8ROTKkYg10OEFP55repqlweS+oNqoyh
	tWansF8i4WbZQ2YUR6OypgUKaOCAbv4td4FPrZBPL/zQ5Smjfb1T
X-Google-Smtp-Source: AGHT+IEZwmgPFtkP3s1Ya7qUEqRoryXtfa+bGnBKcgd3zgF6RbqcdvoDmOwePjeDEC/PbljwvkATZg==
X-Received: by 2002:a05:6000:20c7:b0:382:36f1:a14 with SMTP id ffacd0b85a97d-38236f10bb1mr1395953f8f.7.1731868093625;
        Sun, 17 Nov 2024 10:28:13 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:13 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 00/22] iio: accel: adxl345: add FIFO operating with IRQ triggered watermark events
Date: Sun, 17 Nov 2024 18:26:29 +0000
Message-Id: <20241117182651.115056-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adxl345 sensor offers several features. Most of them are based on
using the hardware FIFO and reacting on events coming in on an interrupt
line. Add access to configure and read out the FIFO, handling of interrupts
and configuration and application of the watermark feature on that FIFO.

The series will include the public adxl345.h used also in the
corresponding older input driver. In brief, the data fields seem to be
identical when implementing it for IIO, the file is already in public
include, and to avoid duplication.

The series is meant as base. Implementation of single tap, double tap,
freefall, activity/inactivity on top is relatively straight forward and
will be upcoming, as soon as this patch set is stabilized.

The series reverts the data justification mode of the measurements
(right and left-justified) since it comes in more handy. Further the
series reverts moving out constant defines to the header file and moves
them back into the source file. This is kind of embarassing, and
definitely not on purpose.
When implementing the features, it became clear what was actually used
to be in the header. I hope this is still acceptible, for the learning
curve.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v1 -> v2: Fix comments according to Documentation/doc-guide/kernel-doc.rst
          and missing static declaration of function.
---
Lothar Rubusch (22):
  iio: accel: adxl345: fix comment on probe
  iio: accel: adxl345: rename variable data to st
  iio: accel: adxl345: rename struct adxl34x_state
  iio: accel: adxl345: rename to adxl34x_channels
  iio: accel: adxl345: measure right-justified
  iio: accel: adxl345: add function to switch measuring
  iio: accel: adxl345: initialize IRQ number
  iio: accel: adxl345: initialize FIFO delay value for SPI
  iio: accel: adxl345: unexpose private defines
  iio: accel: adxl345: set interrupt line to INT1
  iio: accel: adxl345: import adxl345 general data
  iio: accel: adxl345: elaborate iio channel definition
  iio: accel: adxl345: add trigger handler
  iio: accel: adxl345: read FIFO entries
  iio: accel: adxl345: reset the FIFO on error
  iio: accel: adxl345: register trigger ops
  iio: accel: adxl345: push FIFO data to iio
  iio: accel: adxl345: start measure at buffer en/disable
  iio: accel: adxl345: prepare FIFO watermark handling
  iio: accel: adxl345: use FIFO with watermark IRQ
  iio: accel: adxl345: sync FIFO reading with sensor
  iio: accel: adxl345: add debug printout

 drivers/iio/accel/adxl345.h      |  34 +-
 drivers/iio/accel/adxl345_core.c | 887 +++++++++++++++++++++++++++++--
 drivers/iio/accel/adxl345_i2c.c  |   2 +-
 drivers/iio/accel/adxl345_spi.c  |  11 +-
 4 files changed, 845 insertions(+), 89 deletions(-)

-- 
2.39.5


