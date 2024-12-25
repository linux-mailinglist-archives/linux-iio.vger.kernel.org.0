Return-Path: <linux-iio+bounces-13796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B4D9FC638
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 19:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1DB162B1D
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979B1B415D;
	Wed, 25 Dec 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVIoBM3h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6E450F2;
	Wed, 25 Dec 2024 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735150427; cv=none; b=Q3Wd0erzZXD+YPATH8KyLmYJKQS5WI8O+Gy0XwBZTcHLPL3syAD61Cgltm9VTKhS4FMx8X51FdZB9eWWqx4kYBeN6l1QV68o9iSNPF+OdK5F1wYNMwPP377ro0Dvet5VMjXgbvwEmzGUdnrYGsfiRtC8DXpFq7gRNEiZJLpQi/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735150427; c=relaxed/simple;
	bh=BVyaI3g2goJNx8xyRpeaF4adkuxvEojqdgOou4HEp9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=anctIKxDtnXtm1ZwT5k5+lzbixxKY9hthmdDug53kRVMObTCDEHoGGtmPuVFfV9tvwYWMA9vplP6T93fNMkY7rAO+bB7LLn/V4Yy1NTNZMLC/UB1thAIU84OZ6yOQwQYStsrCuRmRK0msnHUI6lo+ZGB+qyFicKeRW2RuA9fQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVIoBM3h; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d44550adb7so1183734a12.2;
        Wed, 25 Dec 2024 10:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735150424; x=1735755224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YAUTjqZLt5uwBF8xroq+8SIW9LOxnJsHSka91lm0l4Q=;
        b=UVIoBM3hckGTIQotitCTH/ZaNJ6mnolCEZH+LzjptTCMugmtvhplS2is6ekNLv/S9/
         YFycHcuAOLbrxrfZNUz/miD1VY71rz8unT0xoBrCYP7xOyLuksQ0O/Mugs1vOpq6e8pC
         yozLPypfmnm4N9G64wMUwOe4CC814J65b+jc6EV/jx+dEzP2aRuwSx9MWJ0miMtqNuZr
         8FH+mD9YW6Zd5oOL7BX9+v0azE6OqhgUd8ZcPFul3FvpH4fzSqgH1TDfL4w36rSck+dg
         qdthxHLunaWwskZdGz/gwTQAdD4oNkXeFMqQeLk9B7mG5NYM/8S8HMSEkqJE0PGTPPUI
         t2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735150424; x=1735755224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAUTjqZLt5uwBF8xroq+8SIW9LOxnJsHSka91lm0l4Q=;
        b=RIYZ4zsKV7VkwqW915eHOyHbBEG3o0dmAhF9NglNj5ozGTbQcapY0Yaj0svuIBaD2+
         QPyQOFDSmhPotWE4Tktjzs04RquxTTUhXitCCUa8YGqnbnY7uksVVePkDuz4VCaED6x1
         ZshWTPSRG6tdBcCx6JjgcHPNXxhgBfJfWOaKJYNEZbhexZrNQlXR8NeCgEaiCBZsy+hz
         ZVmJzGyP2qfFd8xR6TkAtUQE1xF46GrhjDAI1PdF0vvdqYks6mXmFoBmTyi2ICCFs6p0
         C8jW5ZBsNmNyLlsPF99TBJDS0YOrStoT5Rf90YBVdgdjhDV8PLCVRJG69wukKMXLBicX
         rHXg==
X-Forwarded-Encrypted: i=1; AJvYcCWTNvDsheh6FNCsJkYJ5wpJZaxCXmj7Rd9QQSJosziK8J51MEpQ2GEHzF19+Pbx21/i8S6yCgHhsKcgQuTX@vger.kernel.org, AJvYcCXrL4UVX7Mp8dPVsxMOMoXY+bnnck9odQBzKw3ucp4GW1VmphlKREL5G15RGuyLpX3WGLI83JfI1j8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XIQsFkxc6r2WncRktnklUHHT31dm+FZAyOnX3HAip0KtlzXa
	HrfPBefhyTV8TCGPRii6BBiQ/myRwQMDzpSnCu1W2ZXmTBnPYWzU
X-Gm-Gg: ASbGncu2IHW4iNUC4mwkb3tjFzQo1OL6bQtyTYTbKRPWNl6GhW/IMHJ8i+Iu/EGhnns
	uixG5u/zd8LMcat2RyIMOlaaN8jawdL2ncJICluT0hbV8dri9VrqK0KDizd3OUydej8mEXM5fzT
	T8n/t12agYoJMCy5zRxUbuIM5GOr1RvNeu8yl/dyedWEYWD9RZ9Yeb1ULkJhx4+jwMvxSAmUkUe
	pe9bCU+MZZWHeCGi96aNr3TSylWndUp4k+pSked499UHceXQ+wjnYmYjHB4xWI/DiouB75HZ2cd
	Eb9kE7+bCwKr6MCiq1uCuAf+UO81uXhwIrE=
X-Google-Smtp-Source: AGHT+IFKtZiW6wNmcGK8MXa6VR3IHtjFopwMfDd/DMFIKcxzrvbIHScBEq82h8zPIYDq7wnUvyO0dA==
X-Received: by 2002:a05:6402:5187:b0:5d0:bf79:e925 with SMTP id 4fb4d7f45d1cf-5d81de07d1dmr6406642a12.6.1735150424042;
        Wed, 25 Dec 2024 10:13:44 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm7721141a12.88.2024.12.25.10.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 10:13:43 -0800 (PST)
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
Subject: [PATCH v8 0/7] iio: accel: adxl345: add FIFO operating with IRQ triggered watermark events
Date: Wed, 25 Dec 2024 18:13:31 +0000
Message-Id: <20241225181338.69672-1-l.rubusch@gmail.com>
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
v7 -> v8:
- remove dt-binding quotation marks
- add DMA alignment
- fix indention, formatting and text alignment
v6 -> v7:
- reorder dt-binding patches
- extracted FIFO specific from constants list
- reorder constants list in header patch to the end
- verify watermark input is within valid range
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
  dt-bindings: iio: accel: adxl345: make interrupts not a required
    property
  dt-bindings: iio: accel: adxl345: add interrupt-names
  iio: accel: adxl345: introduce interrupt handling
  iio: accel: adxl345: initialize FIFO delay value for SPI
  iio: accel: adxl345: add FIFO with watermark events
  iio: accel: adxl345: complete the list of defines

 .../bindings/iio/accel/adi,adxl345.yaml       |  11 +-
 drivers/iio/accel/adxl345.h                   |  85 ++++-
 drivers/iio/accel/adxl345_core.c              | 335 +++++++++++++++++-
 drivers/iio/accel/adxl345_i2c.c               |   2 +-
 drivers/iio/accel/adxl345_spi.c               |   7 +-
 5 files changed, 417 insertions(+), 23 deletions(-)

-- 
2.39.5


