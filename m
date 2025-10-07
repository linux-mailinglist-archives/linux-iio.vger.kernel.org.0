Return-Path: <linux-iio+bounces-24789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C6BBC0436
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 07:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93A53A3B9D
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 05:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764E721A94F;
	Tue,  7 Oct 2025 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nElzAMXN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53C1D554
	for <linux-iio@vger.kernel.org>; Tue,  7 Oct 2025 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816522; cv=none; b=g9sg49yvokp2elKmxx/kyK1rX78rD+qehsveGM0nM5It7hGWnMlJxPmW6iYNdQk2LFer/wFOSiue7cdLoGLoFD67QCYQRQ8Kg51mLipZGlPdnK4omF0lgXz5RvAb83GBrRll8dLpYyQiFDKH/aFNb0lcQswPfsgjDXS61wwkrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816522; c=relaxed/simple;
	bh=168NfD/ecb5wgu5xNFlCaKmte6hBtMqFpQKOiKMR9bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l7RBP/5ow5dPPUKvpvm276Eh+lbWIUy5SvGt2QMGHUJNNJ5lVIJN1RIgdXz0BfzIAh8gnyP9ddhU5wbnrIyhMZMW9MaechAQSn8wm9kfTfoEKyQdHW+LPUmpjtNcvsE7YVau3i1WWHWFNw79OK/T4BLuaZ3h5aaw19zSDjdo0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nElzAMXN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so6353564a91.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 22:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759816520; x=1760421320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZghIXdaSi6t4gvdCfT5o16EuMxkJyf71bvQeFQdK0A=;
        b=nElzAMXNwLAIuqsktVYxSH7O0Rd5U5lEOggjTm7nc4IF9ofS+G/FPiLYjn4MLocpIX
         qe+h/ZpcI5r524rkMVo1mzsuqxYc/yQ6rG34o1M+5XNBlaNiMIJy2S4SohUw99UUYllK
         C9RDfH5wtf3zVUfHV9sYRO2HhEFnRD2hKb/tuLKms46qaCM3XMB0ec4CLYmw79S2llYo
         9AEzaoKspOPmC73ScvVQiARYaQDkMLwCPKkvfznPS0wLUXhLTQ6YUXORc7mPmjGMdr2t
         bT7OfVl1OG6hXhVCV15VwkP6szjDym4xFn/DyKpwbJmTJL0U1sZNccMeMyHlyEvT83FR
         nsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759816520; x=1760421320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZghIXdaSi6t4gvdCfT5o16EuMxkJyf71bvQeFQdK0A=;
        b=MbTDhvdobLsDC4k8PSKrRCZUJTafnpOZwi/VAHbb06X5wZttLZu/jhhO7K1+qwBqOg
         dzV/84p1H1VXLRwOss9fJuXIwUas8AEAASi+jDOw1sgg8Y+UqwTo5TI8fyayWezDA2a5
         fmGDBUQJN1uQI84ML33iimm9LsGvEDB99NXpmWEs/EMX5rWJ0QfGyQdHe/4uzTT3pNDA
         n5mBWtT1R0oqPWK8S3l4NAHTMpuYsPrq7o08fHGcHvoK/uktIcP5DubokzB4bv/q7a7O
         I88r0AxzsSnLX5grZipbZ6DJldchQG0OUM/tQugWDUUrIpRlX1gr27NEQRYBhywUlIdG
         42sg==
X-Forwarded-Encrypted: i=1; AJvYcCVUaT7Z5WH5pqBmxJTbL6Nu1KmaYvs/RY5M8kyOBvSIIk7owjLy1zWhIBFMuToYyz4lyJ0HQu04do0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy52C4DQWCzgyXjaYoDjc5r1GHXDjp9UWCfUOvpA8rYVCb9EmFf
	AjGimI3KRTgfU/1WyS1WMzoyKZQ7EdyxL2r/np4z3ZyruJUBL2xH7TBg
X-Gm-Gg: ASbGncscYNQCEdIW2LW0D2O+jchDI3Cw45Zz6l7pqe1/rTIsuVex2ppXegqpdNbL/4w
	ez4qfGPqgoPgPp+bF/B5UQ87xIuR4D+mQ6UcimeRNIHHC7KTptdE/HQGbRvGHRs8vEfnF5l/sTp
	QrV3vnBhi7qHWV3fXeY0vgezU+fMNz/ytkin/U/nbdFlstb24RkP/HJ0MqiHD8MZCxW3YXFN1do
	zWkkbe1t3MY/k2uEFeJUmKLgnUER8D7i/nvwq5/FP6AA7wxIacnRincbUC4bAATpBLCSsBEs1Qo
	kmqWtFiA4DxQoZaH31j4sXuQ9PAL9/i/pcRWZJptgZ/b/MrQpuZVlSXPXW0lZk+JwOh8GcqiB/i
	Q1+TFrLtLz/cbDmYjcFD91CVVfpkIqqgBLKEAfq62V3wibl4JXq4trxpw
X-Google-Smtp-Source: AGHT+IH3yHUpHO8MPfqkfmLVrGO6eAOQw4CzhIMeoYO6hXLvDJrn7+BIDzWj0TidI6q1e0vocpVVwA==
X-Received: by 2002:a17:90b:17cc:b0:32e:5cba:ae11 with SMTP id 98e67ed59e1d1-339c27859aamr18418727a91.28.1759816519760;
        Mon, 06 Oct 2025 22:55:19 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a9e8sm12983829a91.11.2025.10.06.22.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:55:19 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] iio: accel: bma400: Refactor GENINTR config and register macros
Date: Tue,  7 Oct 2025 11:25:00 +0530
Message-ID: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors the BMA400 driver with a focus on generic interrupt
configuration and related register usage. The main changes reduce
usage of hard-coded values by introducing macros and formula-based
register addressing, and add a centralized lookup indexed on iio event
direction.

Alongside these updates, the series also reorganizes and renames register
and field macros for consistency with the datasheet, and extends comments
for additional clarity.

All patches are pure refactoring. No functional changes are intended.

Akshay Jindal (6):
  iio: accel: bma400: Reorganize and rename register and field macros
  iio: accel: bma400: Use macros for generic event configuration values
  iio: accel: bma400: Use index-based register addressing and lookup
  iio: accel: bma400: Replace bit shifts with FIELD_PREP and FIELD_GET
  iio: accel: bma400: Rename activity_event_en() to generic_event_en()
  iio: accel: bma400: Add detail to comments in GEN INTR configuration

Changes since v3:
- Insert a new patch into the patch series for replacing explicit bit
  shifts with FIELD_GET and FIELD_PREP macros
- Assigned explicit values to reg field enums introduced.

Changes since v2:
- Split single patch into five smaller patches as suggested
- Addressed review comments related to trailing comma [Patch 2/5]
- Extended renaming of macros to TAP_CONFIG registers [Patch 1/5]
- Addressed review comment received regarding write then replace in
  activity_event_en() [Patch 3/5]

Testing Summary:
- Tested on raspberrypi 4b and 7-semi bma400 sensor breakout board.
- Since no functional impact is there, so before functionality is
  expected to be equal to after change functionality.
- Tested mapping of GEN1 and GEN2 both on INT1 pin as before.
- Tested both activity and inactivity detection by setting attributes
  events/in_accel_mag_falling_en as well as events/in_accel_mag_rising_en.
- Did read and writes on various attributes such that write_event_config(),
  write_event_value() and read_event_value() callbacks are triggered.

 drivers/iio/accel/bma400.h      | 148 +++++++++-----
 drivers/iio/accel/bma400_core.c | 349 ++++++++++++++++++--------------
 2 files changed, 285 insertions(+), 212 deletions(-)

-- 
2.43.0


