Return-Path: <linux-iio+bounces-16786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7852A5FC8E
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E85B189F4B1
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B90268C55;
	Thu, 13 Mar 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJJQg9/t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB06126C03;
	Thu, 13 Mar 2025 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884669; cv=none; b=NFd46pdL/W3HL9aYPGXpMrpWgENZXtZJ7vH1ai9g5DAy5Eqg0ZRK5lh83+mm4cwlWpyfkes3+R3cT7xMeQFxuMnnPqSVRsGmjn+/T92DFxpUQF7zplxKtYUVhs6sSSD+ajvqKQ43MOjx5HZygKmhYL125ure1mSz7g37aSe40RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884669; c=relaxed/simple;
	bh=em0vsVkdRcTeyFDM9y7jOcKZdb6kHKRhbrJxxpapoEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ak3CaW6+GogZnfFpo5Ou1CUw4B0XhnQM3hUjUuvqRgVWiVFnTHHEku1DfGwQ7N8r1H0F6Q2Ye5xVcd+VJqboSrKyxIipSwaqQUcWehSDKfLLunA7m6QzObM+R/Ej6M61fSdtDo94w2aaKyRgi0TCmQcq4Zc4r3hsXyhVXaonCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJJQg9/t; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e835ffcf71so120868a12.0;
        Thu, 13 Mar 2025 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884666; x=1742489466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0nmPsf//pwdEeul+sBlJve73puJI4a29CY8jR2mZYs=;
        b=jJJQg9/t1FiHvnegB5QRD4JAPS0mXwOAdRhAQqHNQMq71hQ19+ZUXaVQy9ERl1Pnc/
         74ZK+ASrwwwr8HO45hFscgRVqWeoHaosZVdllA/FOZifIWRRDNyqXzh+cKE4AsVQLg1m
         p4haYN859Asz+p0nNpXGpd3VUrC3m2gls7qwCFENheTy4LjCkPVzBeXhp2JY8q2tdz67
         fFBhY5nk4m4OlR1ANd2Vdp9uhRcK9F0sdslh6hjomLZfqY5zKSb63sD/54XTzRB6HOeN
         cDhLyrfbuBGD859pIkCti27hDmQcNC2CalIeZEE8pDYZw/05bmbDj1nSF2xYufelSoYz
         ee/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884666; x=1742489466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0nmPsf//pwdEeul+sBlJve73puJI4a29CY8jR2mZYs=;
        b=sQSyJqd0B4gi5FEDYmy1EQwXM7oIqMhpM3JN9ote7/K96pYDurQk+zA3IDLGnKM7e9
         SOwHscFH7rrw4/zN3z05zSPNYBwUlOgBRwRBlVe/ZpoZR/wzW8DU4QMeNCT/EXZlnhZy
         TJe51pFPikRwFXUFs9HK0Xnxb+JERjRJz5LkDxZ4slAIC08Gn+n66yx0a03QMcHKzlwu
         9C441l2xge/ZWraNK9a2BylwTXel1tRGJcPdqPJjLSbbSSKBBbjxGjKNpMV+GPRwAb66
         A02Jgm56XjCmwg0ad8Qa3hht5/jDgZY7SbtibNfdbbdmQUR11PFALBXgHgfB/GkbqU8Q
         iUMg==
X-Forwarded-Encrypted: i=1; AJvYcCViOm52sZ0EP8DT8yn6ASEurJJS09xXEy8cdwMPnJiTfN17enGVscUEayqr7ZgJOrP4Bu9e/SJMc7DeZK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbaOBXNqn0a4ZlSgdFB4KAnS5lh7fdbxatrsRjeKz/a7d+26sR
	HJ2fCOAEffuglH2/LeRu9Ia0FsGBzBT+oreqGRprPNvLzQhhuo096MoxNCRp
X-Gm-Gg: ASbGncuKjHEvDeV8/6whsfKd2VDirU5jQSAIQdNBwiEQS4FyUz6yJYsb4fVWFb/sI3h
	Q3vKFpzVxQMdb/LHhj/8v5Hxi4OoOhzwFKhVnSgcCZJ4toiTATvG6EhnUuXqEaAJAh/XxwkcXR4
	rohG+WkwkSQSYIOGRYVpFhg09wisCQ7bHW8PfBBDFhi1e2dYnzQZrrKyhmE2EKRaVRswSbFwGp7
	+yo17kN3WslgZ/YchcHvKyX9dLy9KkxClI2vpqdClo6ceK1MvAQ2Sl7/8uahkW0Ua+/YAW0rpoI
	gsO3iNUttDGE06mggi+VbpCka6BZNAuiWQwr6LByLGRxdBTuBrCzfcSHFAFxOgZmEuUD4DbBfzo
	Lxt0C+OpezbOASa/uvwtmN0U=
X-Google-Smtp-Source: AGHT+IFiqfNuJXHzRti3j0MddeuFrau4ljxtjmDbxwnHlcWmfFGW8P16jTSHJB4ZOQtaQsUAvt8iLw==
X-Received: by 2002:a17:907:c10:b0:ac1:ee91:2cdc with SMTP id a640c23a62f3a-ac2b9e4619fmr632937266b.10.1741884666048;
        Thu, 13 Mar 2025 09:51:06 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:05 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 00/14] iio: accel: adxl345: add interrupt based sensor events
Date: Thu, 13 Mar 2025 16:50:35 +0000
Message-Id: <20250313165049.48305-1-l.rubusch@gmail.com>
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
- full frequency g range approach
- documentation

All the needed parameters for each and methods of adjusting them, and
forward a resulting IIO event for each to the IIO channel.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v3 -> v4:
- rename patch "add double tap suppress bit" to
  "set the tap suppress bit permanently" to make it more comprehensive
- added patch "cleanup regmap return values"
- added patch "introduce adxl345_push_event function", as a solution
  to the return value problem, group all int_stat evaluating pieces
  in the same function
- tap, act and inact axis enabling are using now regmap cache
- activity enable depending on individual axis now, as the sensor offers
  such feature
- inactivity enable depending on individual axis now, as the sensor offers
  such feature
- fix bug in previous patch: separate axis direction in interrupt handler
  sharing the same variable for tap and activity, if tap and activity
  enabled together
- refac of the direction identification of previous patch: only read
  act/tap axis once now in interrupt handler if both is enabled
- fix bug in previous patch: return value of pushed event in interrupt
  handler
- several cleanups

v2 -> v3:
- generally introduction of regmap cache for all directly stored 8-bit
  values, specification of volatile regs and cleanup
- moving thresholds, unchanged values and flags to regmap cache, in
  consequence removal of corresponding member values of the state
  instance
- removal of intio and int_map member fields due to regmap cache, thus
  split of set_interrupts() patches in two parts
- rework documentation
- rework of ac-bit comment

v1 -> v2:
- implementation of all events (but tap2 suppress bit) by means IIO ABI
- add sample frequency / ODR configuration
- add g ranges configuration
- add activity/inactivity using auto-sleep and powersave
- add dynamic adjustment of default values for
  activity/inactivity thresholds and time for inactivity based on ODR
  and g range (can be overwritten)
- add sensor documentation

---
Lothar Rubusch (14):
  iio: accel: adxl345: use regmap cache for INT mapping
  iio: accel: adxl345: move INT enable to regmap cache
  iio: accel: adxl345: cleanup regmap return values
  iio: accel: adxl345: introduce adxl345_push_event function
  iio: accel: adxl345: add single tap feature
  iio: accel: adxl345: add double tap feature
  iio: accel: adxl345: set the tap suppress bit permanently
  iio: accel: adxl345: add freefall feature
  iio: accel: adxl345: extend sample frequency adjustments
  iio: accel: adxl345: add g-range configuration
  iio: accel: adxl345: add activity event feature
  iio: accel: adxl345: add inactivity feature
  iio: accel: adxl345: add coupling detection for activity/inactivity
  docs: iio: add documentation for adxl345 driver

 Documentation/iio/adxl345.rst    |  416 +++++++++
 drivers/iio/accel/adxl345.h      |    6 +-
 drivers/iio/accel/adxl345_core.c | 1449 ++++++++++++++++++++++++++++--
 drivers/iio/accel/adxl345_i2c.c  |    2 +
 drivers/iio/accel/adxl345_spi.c  |    2 +
 5 files changed, 1792 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/iio/adxl345.rst

-- 
2.39.5


