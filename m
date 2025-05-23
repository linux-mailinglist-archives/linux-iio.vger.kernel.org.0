Return-Path: <linux-iio+bounces-19836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6060BAC2BC1
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665599E2140
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB7A213E7D;
	Fri, 23 May 2025 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0K+hNdB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B74E3D76;
	Fri, 23 May 2025 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039755; cv=none; b=pg5eianWIYeT0KutVipPi2Z7LY9EDWZ20+FwuvCk7/HTfq4wv+mwPenYDjcseJq7+uAUAonbwOofD1+Wt7xtLz7PZck3+r5duPIzXGHvyruA+M/8aOaA71EI3dKv2uKglf8D2j4H+xkWmTFWC4HaZ1bA+cS1SgPpD7SXnOm+uyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039755; c=relaxed/simple;
	bh=R3v32M7eOha9gh09Kow3yei6xT+ZwIa9TVcaF1rvUUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UqKgAnqHWQiV247tyMJJYs9OsJbjuhpOAqQgdWVQMa6prxzFVlCXUZsmXeI4qjU0+bsxBKFfPlTARrW9gd3MWXo26PbcUeeRB6jQDUG6Kvvb9ITT/Qfx3K0Ws1tRocnnxoErZAo6powyVaorpmWSiCHkTHisHV+d8iMcxszXB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0K+hNdB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a37b5de515so59793f8f.2;
        Fri, 23 May 2025 15:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748039752; x=1748644552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lgVAHO/czzeAtaJDGCKfGMz8u6/aTJ16whMyiWADto=;
        b=D0K+hNdBrcI1vIEcLNgtZoCuLf0eJyiPoI/BqiAh6ULiHAoGH7T5GC/hfBT9Ez7+8Y
         rStpR3I/HXbVqRBKngvcv8BQfQobgjCzuPBBFWoD/T0Dpe/2BkhkgKw1nZmuSpxStRUV
         v6fKvdgqhVEuLB4P/vlqlmBF5MD2MSfaQBBFtq7sYB1fbEf8u9PVMqrk55wdWdfLbTRC
         e6V9nGPuHwBOEsj8LvSotStrADecU1fkM3UtPt2YjcaKK2k1cqDSXS2XyXJmnOJ6Ww5K
         TAUrEqE9woagIkkvTtb91bnyVLpISl1KE/4bNqzEoXWBNuhy1HxXBCVmZo1KD9jw7d/R
         kdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748039752; x=1748644552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lgVAHO/czzeAtaJDGCKfGMz8u6/aTJ16whMyiWADto=;
        b=cHfzLWh2w0F3hhHdpvCdFvzJQ22qwr5Ws8O1yPEjZT/24v/lYgukVB3yvbpQJu+81k
         eBKOdvhsKw8Qlmr3AqeSXz250Lk6tJTcb3q4KVMhyReQTPUCu9TahPf2FWAquUdOrdyk
         xKXQoPbkI9MtrxlLYINgq7SShhq2zYMmKBrvJ2bwXdoTctLSYpx1TqJ8X+Atv8Ls5/Ow
         kccyVfb1t2ay85BvaQ3EzAUv/oyOpv9ubSeu8NwYkwD4qxrg/xhpJZ2u3HadyAKyir/x
         E2iDCLtJYeoUdvc+AZxDbDrCw74LxvlRPqX1t4A6Pe+27l4VaiQiW0CWv/mKArDYbBlp
         59+w==
X-Forwarded-Encrypted: i=1; AJvYcCUNGGb+y15M0ajJ13eAt1ZxFJVaUWYFuuXVnKx25HhEARPSZ77dmEnSnuqDCkk1YKHAdnd4YxqVj7vz@vger.kernel.org, AJvYcCVhQHjDR5FZOQUp/saIm5V3GPeOwAA3pxrFRhbAnQxSJD5GPmCFu0DwvFGMAKrafYECm4oP72xwUr/mlfbe@vger.kernel.org, AJvYcCWigtwX+QfdiUjLtYwF8kgeAmSEreFJ7OI/dqenvihSM9DRCEvd2p8z91c7HXusETadKRRk+IOlZiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRi7H1RLZIJvFkPzUAaELu53p8hCDVPWUq4rDdM5k/LwBAErj
	JjrzIdxJ8YIjAKQBGUD93Rx10GxVw5KCqOqpveqol0wV8tfgH3TlWN5F
X-Gm-Gg: ASbGncs0wMGJVgdm5WJDA5AimTwxO3XKbiN8GD5D303yzivzMFyPZCNd69t5opVlgbd
	kTTnxxQInJuyp+SHtkDcWKtkho6B6ftYkTT3Bj+PUOYyZCoW7itgp1hlJBOx+N9Fpbz/Jm04hPU
	Jw4qk12reMEf9gKjl8eaSkB74tJYAZWwSmQNxkJ7XuJCyGC9SDneCMjF/3a1MSK9dbWHK24y8aY
	BiisfJPR2UtIXgZ5SWno0q5kC9dfR4VSijffV2q0GuCftMiw/gQgMZ7rFc3USWW6l/SeUu0/IG/
	voCsuvSf2IJWfWbeGtAqe99fpxrYFzDyopHhz0TSckTz5X5sflvj4yEgxm/AzMohPR9HDDUoBWk
	OgKe83mL5LGO7ECRXKXdzyw==
X-Google-Smtp-Source: AGHT+IHNCmDrthyRWLdsW0S4y1tBk2Qg7NjozkGUjBeOQg4TdeelrMl1BaksiVpfVaJ7NZZqdianyw==
X-Received: by 2002:a05:600c:511b:b0:43b:c0fa:f9c4 with SMTP id 5b1f17b1804b1-44c94c246aemr2310755e9.4.1748039751408;
        Fri, 23 May 2025 15:35:51 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm165202375e9.3.2025.05.23.15.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:35:50 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/12] iio: accel: adxl313: add power-save on activity/inactivity
Date: Fri, 23 May 2025 22:35:11 +0000
Message-Id: <20250523223523.35218-1-l.rubusch@gmail.com>
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

Since activity and inactivity here are implemented covering all axis, I
assumed x&y&z. Thus the driver uses a fake channel for activity/inactiviy.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v2 -> v3:
- verify keeping trailing comma when it's multi-line assignment [v1 02/12]
- adxl313_set_fifo(): verify have two on one line to make it easier to read [v1 07/12]
- adxl313_fifo_transfer(): verify removal of useless initialization of ret [v1 07/12]
- adxl313_fifo_transfer(): verify usage of array_size() from overflow.h [v1 07/12]
- adxl313_fifo_transfer(): verify return 0 here [v1 07/12]
- adxl313_irq_handler(): verify "Why do we need the label?" / moving the call under the conditional [v1 07/12]
- verify reorganization of half condition for Activity [v1 09/12] and Inactivity [v1 10/12]
- verify usage of MICRO instead of 1000000
- adxl313_is_act_inact_en(): restructure according to return logic value, or negative error
- adxl313_set_act_inact_en(): restructure function, use regmap_assign_bits()
- adxl313_set_act_inact_en(): verify makeing it a logical split [v1 11/12]
- adxl313_fifo_transfer(): change iterator variable type from int to unsigned int [v2 07/12]
- adxl313_fifo_reset(): add comment on why reset status registers does not do error check ("At least comment...") [v2 07/12]
- adxl313_fifo_push(): change iterator variable from int to unsigned int [v2 08/12]
- adxl313_fifo_push(): remove duplicate check for samples being <0 [v2 08/12]
- apply regmap_assign_bits() in several places to replace regmap_update_bits() depending on bools
- adxl313_set_watermark(): rename mask variable to make it more comprehensive
- removal of duplicate blanks in various places (sry, my keyboard died) [v1 07/12]

v1 -> v2:
- usage of units.h
- simplify approach for return values
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

 Documentation/iio/adxl313.rst    | 196 ++++++++++
 Documentation/iio/index.rst      |   1 +
 drivers/iio/accel/adxl313.h      |  35 +-
 drivers/iio/accel/adxl313_core.c | 625 ++++++++++++++++++++++++++++++-
 drivers/iio/accel/adxl313_i2c.c  |   6 +
 drivers/iio/accel/adxl313_spi.c  |   6 +
 6 files changed, 859 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/iio/adxl313.rst

-- 
2.39.5


