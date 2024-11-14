Return-Path: <linux-iio+bounces-12268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F39C95CE
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF811F22864
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53F81B219A;
	Thu, 14 Nov 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arGwfRKa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A21AD3F5;
	Thu, 14 Nov 2024 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625816; cv=none; b=IskpLvDGngz/JdcYu1UxGLB6Rupp9QZYGQzlVWZ3ZVYHdePgdOgq/DPu0rLCsu/oSddkhGG7UZ3NutXJFI6IEwiemd18zRdrFHipQ/1xZ5Ck3cKexYomhNs+PHXysi/EKKlWP2MBhq9f346egGExIwBM3AJLe1WNjH4zfkRIEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625816; c=relaxed/simple;
	bh=EtxgykpiwTGum4emwebpSI10Ti+cO07K3Cy+24jDlWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YJdwSmKYxQIn9k0syew0WpFyVydr/L2FYfeSWlWj8IM662zy4ohN0ApVm6MWU2wr/2JchJeDL4QutVcxiyttUpCNY+ZYoR4oaj6RNwFhcY1zSLQx5I9mXwTc6/IV1R5n71pib/6tVbnQnB9A0DGnn3d0PJAoqqlGNW8Rmegjgtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arGwfRKa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43159469053so626065e9.2;
        Thu, 14 Nov 2024 15:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625813; x=1732230613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrFI0I6oUGMqCgCVk1ek/DuzLyfec2IzYEyQbc1aETo=;
        b=arGwfRKaWOdc0RwQ1MHCW/G7QNb8+yi4qRW3218uGyKIDvrGQ4+pWWXmSfrXeCVzvB
         Y3VOPWJfGrX3vOs6iIIsnQAbgY1dInNMz3C6v+2U6Y4yYS9trf37FHXV2Q1PqLsiy1Dz
         0Zouw4J64rxGU1Wef+YtAtIJdO38YIcVBc5COCMFDOwvHzEmZEIDjSGbB93mLs6hADGV
         SBtVXxJ2RvksUqngzrp3ajI2CCjWadS4E4zjOjw6aWN6sLqQ72wsL8A09gwba8LkszrE
         BLVqxh/aM1biFx/LP6nLuQBH12kb1AhOXZAn7UdvWcuzJXozIdWStXJswGMa0+LF7P5L
         UZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625813; x=1732230613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrFI0I6oUGMqCgCVk1ek/DuzLyfec2IzYEyQbc1aETo=;
        b=rpQQiOA9y/pCfafHBhbZEYLcU1Xf7XH11YdCzUSKWcIX04B/tvVSvBcDlD21On5Y8Y
         pzT9pvRH4MapDr1D8bNe3yKS+5XKqG1KCiN5VSRPC0In4IyX2EmrpIy5mqAHRYOuPF5Y
         4Y1WMo95NZgAQXIbofa8LsW43pbLGV6IgG+Etm50l2v3WP4dusUaANnhiy1NaLMmgCec
         30VkLt+iHXpKps7UKhpCbpovnpYf11wFky2MCRDj8y7JfnnchPZEdbQx+ArVl3EThtQ2
         KslRu0BuIwjJeLY+aKaU0DokmsX6DFQBhk5U7JhVR13p3R6J++lT5PuHUvXvKRA9YSx0
         IMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvZZM9TXWgkkRm4IuB8ySTGD6kFvi75uKu7b8dWWax5ZT1T0tPcY2piJ904Br/sjXb/dCRi+IR5k/9/TdR@vger.kernel.org, AJvYcCV2DL1+CjLqi0GxHPCVgkvezuIo8KRgeUMOBOSUTlWyU+NMbfQFU5aGlZ3AB23Bf05x0woA8EzfcQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysqL1HexiAhERSoUgLfCmNhKMl3/3V+sOfBVzPQoNjxw7OC2Bw
	ewQVZ2U/VxRM8ANnN0hq8AhRvlqsMpAHMW8CpTs6FDibyPS1rN8v
X-Google-Smtp-Source: AGHT+IFpPZyR9cC1fTCt9fWazoRXtXVw7K6C696QtleyuiEIP5NO0dQ/izTa9RvoDdfKszjplAX2rA==
X-Received: by 2002:a05:600c:1991:b0:42c:ba83:3efa with SMTP id 5b1f17b1804b1-432df6841femr1833195e9.0.1731625812856;
        Thu, 14 Nov 2024 15:10:12 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:12 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 00/22] iio: accel: adxl345: add FIFO operating with IRQ triggered watermark events
Date: Thu, 14 Nov 2024 23:09:40 +0000
Message-Id: <20241114231002.98595-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 871 +++++++++++++++++++++++++++++--
 drivers/iio/accel/adxl345_i2c.c  |   2 +-
 drivers/iio/accel/adxl345_spi.c  |  11 +-
 4 files changed, 829 insertions(+), 89 deletions(-)

-- 
2.39.2


