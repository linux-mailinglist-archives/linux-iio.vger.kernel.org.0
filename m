Return-Path: <linux-iio+bounces-19615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ABFABAFB6
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 13:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C717A17D1
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 11:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCD721577E;
	Sun, 18 May 2025 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqCq/d/8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4201FDA;
	Sun, 18 May 2025 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747566818; cv=none; b=ahqa7rGmW08SryojNjYQhiFKAY01gLFCepafmS8le+BiMtoEIhp32jiN8bKPzOREThQy6duqyiBOiyjHXzZ4xj8m2we6ssxNq2qMvFSItYJ8lSqMez34WQf30V8Su29T2wVyD3G+0CocQLFxQ4NkhwrI9FUbYJfuvZgK7ICDCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747566818; c=relaxed/simple;
	bh=R+TEraDLDNidnCV2uxbixNQu/nbUtr3STwS7VAkKwZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rfSk+ZAbFAWJavyf5ok3/Eyk49VfYKbJdXcq5G5U787Hm74zNGcVz0TgCai/xOWRGaMdjIiijSTfxImAcKKxF69YNLCGVx6DfNzWVKklan2s9fEKKLDcGBxlDeBcov6vuSJuuyKPwdWUO3rz1fqSK3VqeKWjXmTN+tRaI24UO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqCq/d/8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a368259589so153661f8f.3;
        Sun, 18 May 2025 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747566815; x=1748171615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udI0P9KnZ4OkRW9TYCKx0BAqR2AQ70yA+7pr8haeQfo=;
        b=HqCq/d/8748nNvlB1iZMCytbOtlKmrd8yVn4ShdWVPvexkcDkuL/aTSxJJuoBU9UIv
         61B3qlvm3ReH/0XOnpzb3Iv6mWysnTtrbfsVrVSt14cprdX/YPcTlgWIiXbX78wclD7Q
         X08yht/nxbtWbUSX0XdIRr3KGG7tfbyFfgTW5kiCmwtPcgZirFMG05y74NoRQPLaVntG
         YBMDmVCDJybl7SVONO29y1sqS8EMtthl1PmjgZSIGRCr+RQym5K5ezlkO4RXwgKcg51W
         v9GUopjLoqf5X6/2ob6bOlXntHlm0R3ZEYCJ3w4DEp/QTEoWuG/8kvKYFGlQRR1zf9nn
         m+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747566815; x=1748171615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udI0P9KnZ4OkRW9TYCKx0BAqR2AQ70yA+7pr8haeQfo=;
        b=m6fx+VLJiWlQUcgkT+mMzLIAPt7q8a1jRnLoJXGh88Tww+7mDT3ZkbI2kRSYQFbxvd
         ACaxD+Ah//hQa4zTKT/3BKM3pdMwm2VW2JVjdWVBNS5y/75jmBwN68OA2vp0xbDEogMJ
         SXfOZm2h/5zJnwr199nXpcquXSASqGJ5LvasknEQTT3F5SzawmcQo8RD058ArBmQ/IWw
         iZ1exwIdKiuX1un9RjANubKp1J8Sx7qYjthbSRAIGg/i3mriNFeptjcR8hyqidzE8ydi
         viDYmt5liaBxL72A2rRjxS7k3U71SzeRj8stCIo0MRA/GGU1k0ielkXvdqq5PjQM/VC8
         D3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPIELo04XiqET0u6+DBWVA69H0/je11vlU4jSu8hMhk0D6Fkq0yOXRyF8XdwWGPiz6u2bCBE3Wms0=@vger.kernel.org, AJvYcCVrj8CFUJ3EOEMpf0ixiGqfdOt3xUfMHe4kRWe0/yDD85WvK5NM+WA2j9dT6IK3grd0Z/TOSKPSr25Ipfau@vger.kernel.org
X-Gm-Message-State: AOJu0YzzDyVhrhbksjB8wI5PxI907Z/WK/YK+1Dv1Bj/GBGnRWeDYHMe
	Dw3hprld21BDYX0gR0xVORDGTnN9xfin8N/ebjh5vlK7xOPlDqPg2oG2
X-Gm-Gg: ASbGncsS0vE89jt3h4D78lt1bdA1m7XzcopvX2940KBiSAcHj16JFKXV4u0vafVwOEU
	gs4qZJUcS3SUDgAQKsESZZ1W8nA8ghfP40FXR6B26CTHq2twTabjjt9QrVSE+oPaqOLg8VMhW24
	Jo3Utwtszji1U+/1be47DOLyHt+NFfmosGv2SFGIZaDbOSQbDUY/Zwks/p6PxjNWSfhJ/qdaF2U
	x7NP7pUpPiy5640IehoLY8Wx9rTyc3XQcp+YWbWHksjbddP5kiXlb5PufFxX78aKfiIufzDNSbi
	K2ApttZ98sDjrYeq/Y2lGDTX6L4iRF1WkOTr9XoAEUQu5YJEgIcHm+8/PrfUj1/ceDyCc1BHbgX
	HW5Un2c2s+5o4ycWsYK2p4Q==
X-Google-Smtp-Source: AGHT+IFnS1JrojVbae7P1o//nUXJgNSG7rUZiFcVW+tiUlY+rr/dakFmfpUKqaM+dOoVjm7xhUMGEA==
X-Received: by 2002:a05:6000:400f:b0:39c:1401:6ede with SMTP id ffacd0b85a97d-3a35c80a23bmr2737364f8f.3.1747566814796;
        Sun, 18 May 2025 04:13:34 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm9287446f8f.18.2025.05.18.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 04:13:34 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v1 00/12] iio: accel: adxl313: add power-save on activity/inactivity
Date: Sun, 18 May 2025 11:13:09 +0000
Message-Id: <20250518111321.75226-1-l.rubusch@gmail.com>
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
- documentation

Similar situation and approach as for the ADXL345. AC/DC coupling might be
a pending option as it is quite the same as for ADXL345.

Since activity and inactivity here are implemented covering all axis, I
assumed x&y&z. Thus the driver uses a fake channel for activity/inactiviy.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
Lothar Rubusch (12):
  iio: accel: adxl313: add debug register
  iio: accel: adxl313: introduce channel scan_index
  iio: accel: adxl313: configure scan type for buffer
  iio: accel: adxl313: make use of regmap cache
  iio: accel: adxl313: add function to enable measurement
  iio: accel: adxl313: prepare interrupt handling
  iio: accel: adxl313: add basic interrupt handling
  iio: accel: adxl313: add FIFO watermark
  iio: accel: adxl313: add activity sensing
  iio: accel: adxl313: add inactivity sensing
  iio: accel: adxl313: implement power-save on inactivity
  docs: iio: add ADXL313 accelerometer

 Documentation/iio/adxl313.rst    | 196 +++++++++
 Documentation/iio/index.rst      |   1 +
 drivers/iio/accel/adxl313.h      |  35 +-
 drivers/iio/accel/adxl313_core.c | 658 ++++++++++++++++++++++++++++++-
 drivers/iio/accel/adxl313_i2c.c  |   6 +
 drivers/iio/accel/adxl313_spi.c  |   6 +
 6 files changed, 893 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/iio/adxl313.rst

-- 
2.39.5


