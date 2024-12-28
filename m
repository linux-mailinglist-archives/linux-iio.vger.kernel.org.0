Return-Path: <linux-iio+bounces-13848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391AA9FDC9E
	for <lists+linux-iio@lfdr.de>; Sun, 29 Dec 2024 00:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213FD1882ABB
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 23:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8512E195385;
	Sat, 28 Dec 2024 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7OAglCP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308613A41F;
	Sat, 28 Dec 2024 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735428599; cv=none; b=p/7WhdHmuF+JGAlznCzeEDbhNtvyjr1nzsGF9sDf1fcu9xmzWmbJxYkqF6aMl3wr7gSj9xT7VEcE9jLcNMFtB5DBSkoQcWvgn8GE1m3VlCWIUFoYt4bVmzv8l3G1Lh5mJfuR2/bclrJljRcuSPqPEcpG8kBzqFEYhiild52FY/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735428599; c=relaxed/simple;
	bh=KWIZOnbqkz8tGaaMYBRQQwKmLN/DnrPNFSxP5mjUiq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r+PhTcMva6EOziAH76jAzm54pHlze+rVU3x/Xgj0e3kZy/yQl+/WZYX+scI+DT4xb2s1MTRsh2uKaiuS90uAdEt+YlIhpnZ+Xr5dvSUMf6lGsE3j/OtPnJc8C9/975ew1bKDTinrURrFm7dQtyr6kitkqw9/BUANshzsWkMkNUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7OAglCP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0d6087ca3so1519382a12.2;
        Sat, 28 Dec 2024 15:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735428596; x=1736033396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vzuwKv5VQE+BzfGnoubbGwlPmOR1qU37kmHf2okKCQ=;
        b=J7OAglCPcxzemyS7V4SKulF55hc4Q0qnEw5kCubxflgjQ4mMRdWMyZdr68r73J4rg9
         4YaBvR7RbHXw2fkPdETn1jYxTO1K6NnxrnQke6F7kWKv7JUhYQsUx63OUuIaC9bT7NRJ
         5r/CyC1uDx6an7ro4ei1VPapxLUj7rmGP5yYOVnqsGPc5KzxbbdZfHXPR1KdMkAasi9F
         E59y61V44v5VPTGqEUVYkbz60GmKViirAzzHs9Xl9pQT3MS++ZK9BYdtW5yoytyx2SrD
         j/b/0jIyRzDD7IprSNsk23PFWvN0Wt165dlxBchyI7rFmTzg6s7p607KNkNtMKdI4Lia
         wLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735428596; x=1736033396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vzuwKv5VQE+BzfGnoubbGwlPmOR1qU37kmHf2okKCQ=;
        b=B8l2slNFUA53H8kD3akhCcZ+z8KUbFrUR1L3Co3OYO5znsE3fnuu6tO670Zaz2bQ3N
         X3rx8sY7zOi4Cmt27Z2FsdMppaYN4Nmf1JKLOej3lziKWsWPOzB0zMFkYehhH/Y1yI7j
         zANGwMLYrmnRuOIyrtRY3wRJajCw/zjUwryFNV38rvUYn4J4bZXZqtGqGYs0IY/zVmNG
         QEw5Le2l+ewygLGesxUJkcIqRKw15AdgHOT3L+FLT+lTYlzQ8KxYfp71x5siiiXQn8Sw
         4Lwqvga6AJSoLjHvjGPWMuNKDKsTaiYsRarCrvRVhC1KYV0G47egrEg/+8AVv2LfmN1n
         2tcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj5WbjiNU02tH+NITXxT245j7rfNtckMPr/mP6t8ykxMre8iZrihf39eS2LIF4mcbegIJNVI6FjYOXK9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxB3+SRU2FkySRzuc/ZjI/jp7JNfk2zmdDXtAO2cqd4CezDRe
	6mAxIQ5HqtWEx4KAYKlQOEGqLLapneTDEb/FKIdL6md22S1jaAEW
X-Gm-Gg: ASbGncsS9iH5LcA6D/Cog+Qy3SbsqoLx/N8n2HXVeTX2PWk3n5VcgiBvCMOrVHSGRtt
	Wen7dYnxt795V3Ejw1+u62O3jGGveVZTb32znMaFU3/gl0KzktOJ26jraNfUB9Y0pEE+Ox1sA4u
	EoXoUHgdl/phcwCdprkoyG4NFRH907IADvlWnwTJoWTfh90pFQK1+hvbfZKMyUa8j2imcjT3oga
	fpD4fqcPLvvKeL+g6TMaFJuPRhOpHP9DB0eePWMHaMZBIz1QCBYGU0sT6ocWY3JKbiNcr76y5sB
	m7OGq65SaMQ4UtCqekks+Yszr360fngBU2E=
X-Google-Smtp-Source: AGHT+IGXndjiUZahsfNysyqDSy+7j7HYhm581/a7KDUcbr3c6eckw+dTPz+xWXG0Ug4AtNWfgU37tg==
X-Received: by 2002:a05:6402:3548:b0:5d0:bb73:4947 with SMTP id 4fb4d7f45d1cf-5d81dc7473fmr10286410a12.0.1735428595870;
        Sat, 28 Dec 2024 15:29:55 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ac68sm12635156a12.78.2024.12.28.15.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 15:29:54 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v9 0/4] iio: accel: adxl345: add FIFO operating with IRQ triggered watermark events
Date: Sat, 28 Dec 2024 23:29:45 +0000
Message-Id: <20241228232949.72487-1-l.rubusch@gmail.com>
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
v8 -> v9:
- move FIELD_PREP() usage to a local usage in adxl345_core.c
- remove ADXL345_{SD}_TAP_MSK macros
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
Lothar Rubusch (4):
  iio: accel: adxl345: introduce interrupt handling
  iio: accel: adxl345: initialize FIFO delay value for SPI
  iio: accel: adxl345: add FIFO with watermark events
  iio: accel: adxl345: complete the list of defines

 drivers/iio/accel/adxl345.h      |  77 +++++--
 drivers/iio/accel/adxl345_core.c | 338 ++++++++++++++++++++++++++++++-
 drivers/iio/accel/adxl345_i2c.c  |   2 +-
 drivers/iio/accel/adxl345_spi.c  |   7 +-
 4 files changed, 404 insertions(+), 20 deletions(-)

-- 
2.39.5


