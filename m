Return-Path: <linux-iio+bounces-13371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9319EDAE5
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 00:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760441887B6E
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 23:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B2D1F2388;
	Wed, 11 Dec 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMFknNZe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9F8632B;
	Wed, 11 Dec 2024 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958422; cv=none; b=gFCR4QKFW9pBKQdB0Rn3g+QsjCTZp19ETvyfWTmvcqLoEgR/rOjQFrkU2KqmuB1dKyk+7AznaWyGUwpS8kZdPtwsYibcDomBhTUnNB7RrYx5y2Pe/tfdmf5tWkdRaZJDd4/KClVpCdNKDnGYoDfHDPJInX0Nz1dyIeZ6uCVNo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958422; c=relaxed/simple;
	bh=N440mI4lPh9FV0sYkQNMGHfegipJE5wkdCagZRePdZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fD03GYc4rOH6MPCimfySVDviYbkMBYp+hnwiX+MuYw04B+7eFSlOAgVAkal1nhqjq1qW750B//TAeMIUPL+rqwtSy3aVyjSVjhrdFNcskH0KOIPW2jP+yTGb+EmbDESpmnSEh6iCNYlywpGY7SmPO2s4gQtEPYrutpf8iJNOdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMFknNZe; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa67bc91f88so79731566b.0;
        Wed, 11 Dec 2024 15:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733958419; x=1734563219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ns/gLdWbvGFbcQ77DtchWC5SisSXw1ObyqM5yQEnWE0=;
        b=ZMFknNZerz7VCgL73/k2dWJyrTQfsouAf+h8OPQLm7uDGIBGmS7mxw8IEE/jL3qA+U
         uJY4Or+d3tioRkNzEjr9+x12ES5cd7looXMoWA0qx3sio2yFAhUD3hMwuea60Vy7qvFF
         dNV8hUFweR5Wqoe253CSi9gdTCaznKJ/937AYHRW0dz2LWElbOQP/xxlS42kBlElFSQu
         Gdwv5dQRCDSgz9jbmScWDJlGNHCUWLWNVtUHmU4JhBR7UdaLiKkjumYZ3WNrcyCF/d80
         kH995VZ17rSLlZnIa4t41ZSsQhJL36SfXQI8xWRFvgTdO0rjIxaeubDXYO2yKdWKEEdR
         bOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958419; x=1734563219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ns/gLdWbvGFbcQ77DtchWC5SisSXw1ObyqM5yQEnWE0=;
        b=tye2iU+PyEfvUAY3OU1nps5UZ3gNJRk5bcW67aNdK0dUxGBuMnzbQmIU906oosgvjX
         DbVmBB2lXtOS/3+NPXHW05/Kin0j0HM4jMZC1dwtM6XrWVKC4BJ8ua1huL1YyYGShwMc
         IBju8r8PMsclt+O8PB5qFq/JSsy7poTpkGBwP+wFd6LDAFTSTDtwG4x9oX4bZ/O8ytJa
         i7Wws3pz77inLJAF/Qk0RQCvt0pa05vPfRuv6U9CfUC94+kpd3K0V3hlFgIZnboPdIga
         OhqaJASgDuNEckKXg0QpraMvAyLJ6VK/kMNExb/bRnLPly7z+ELAiEzEL2XzeBDWD6mQ
         u12g==
X-Forwarded-Encrypted: i=1; AJvYcCV/vteSLa6G0XbhXA9LjgnWHQxxTxvGNnvSnpILFxgZtuzkfqxT9jDHHTdOLtJCylEthMDGHWqdg/Fj5DQQ@vger.kernel.org, AJvYcCXO2v3dnCJ6okOqeCNlj9qGqBLfPAJF9g8Aq42nsMSRvuSR+mPtDRawcdmtykl4DOH2uUUSDEbxK7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xtVpQk/Ui+g73H5+u/D5XclKMpYi2e9+Hf0HBjc/ZZAqr+lH
	1kEyMSikD4UFafFf9d2wUVZqOaHu/OmEazS2qUHp49GpNiGhn8Lx
X-Gm-Gg: ASbGncttOPr7/7QZ4qM33p4thiR0WEGfwG1XBT9TM7Xj4UUjeofgEB/vdQbUQIT57Fm
	r0eVZF37mruNkU2WTW7jfx8nJZHEcVgQKFkMQYabXV+FYsUoTjVizj5yOMielv/vclIGlS+ZL+W
	KpVNkEt6BDdR3dRIRafegoHOzvORqPN2PKepU8EQS/8QgKxmb8k1p7us81c+erfWDEfe/SvUf0/
	vdqOB+nwo1En65OP8cQ/v5/oN25awOMIdhcMNPLYKufX7v07EEJtMMNBVdsWWPoe1PuZ+XGj16/
	mkTWXbhZ+joMIjADtHdA3cVjz0Exegln
X-Google-Smtp-Source: AGHT+IEZaLVhE4s9//07OCh7uFISHaQDEwcthssjznjoiBGBc/R6BaRpLCQ1NVTw+blU9Fu6N8atzg==
X-Received: by 2002:a17:907:7b8d:b0:a9e:80ed:5cc6 with SMTP id a640c23a62f3a-aa6b13bcf50mr146741266b.13.1733958418431;
        Wed, 11 Dec 2024 15:06:58 -0800 (PST)
Received: from 34fd2088d136.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa655653d96sm747350366b.185.2024.12.11.15.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:06:57 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 0/7] iio: accel: adxl345: add FIFO operating with IRQ triggered watermark events
Date: Wed, 11 Dec 2024 23:06:41 +0000
Message-Id: <20241211230648.205806-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v5 -> v6:
- dropped justify patch, since unnecessary change to format mask
- added separate dt-bindings patch to remove required interrupts property
- merged FIFO watermark patches
- reworked bitfield handling
- group irq setup in probe()
- several type fixes by smatch and tools
v4 -> v5:
- fix dt-binding for enum array of INT1 and INT2
v3 -> v4:
- fix dt-binding indention 
v2 -> v3:
- reorganize commits, merge the watermark handling
- INT lines are defined by binding
- kfifo is prepared by devm_iio_kfifo_buffer_setup()
- event handler is registered w/ devm_request_threaded_irq()
v1 -> v2:
Fix comments according to Documentation/doc-guide/kernel-doc.rst
and missing static declaration of function.
---

Lothar Rubusch (7):
  iio: accel: adxl345: add function to switch measuring mode
  iio: accel: adxl345: complete the list of defines
  dt-bindings: iio: accel: adxl345: add interrupt-names
  dt-bindings: iio: accel: adxl345: make interrupts not a required
    property
  iio: accel: adxl345: introduce interrupt handling
  iio: accel: adxl345: initialize FIFO delay value for SPI
  iio: accel: adxl345: add FIFO with watermark events

 .../bindings/iio/accel/adi,adxl345.yaml       |   7 +-
 drivers/iio/accel/adxl345.h                   |  95 ++++-
 drivers/iio/accel/adxl345_core.c              | 383 +++++++++++++++++-
 drivers/iio/accel/adxl345_i2c.c               |   2 +-
 drivers/iio/accel/adxl345_spi.c               |   7 +-
 5 files changed, 461 insertions(+), 33 deletions(-)

-- 
2.39.5


