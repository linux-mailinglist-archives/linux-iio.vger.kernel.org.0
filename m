Return-Path: <linux-iio+bounces-16270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089CFA4BF46
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0CD3A4DB2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61BE20B7FD;
	Mon,  3 Mar 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oD21+jlc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8AA20B21F
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002462; cv=none; b=CwJms4PMjzFibZXGPPFQotqKLzZ3o6AUvaW5Va2l+aarcWGr4pWGNCPzL7AmABlg9B+8SekWo6fiPEf8Q7Xpnq7SBiR0VkU4IbSL5AVY+zCJRqGV0CAPYv8zlaTKntGqrAtDoLR+OMbnVOpGtexb1ry07/iQE/gSc4bJJ8zZprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002462; c=relaxed/simple;
	bh=MSkPPAJbz5sNa+zrMs9bZ7T61hqfW3CG2VTMkft4RA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F/k/weLKRwaQMZkr36h7ZA3vt4vIn4IgR07eKSLz4PR+flemT8ybvXmIqAuA+9B8xU+dUTGbD3FR9+vZJy4zECrZm6lzP5AEn36uC7ZGGJ/jT3O/evCcg2ae4wrzz2LBnduuNQNrBCGwtNHFNT/rjdn6F57m9REpAUuQywvrlgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oD21+jlc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390d98ae34dso3536098f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 03:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002459; x=1741607259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnRzrlaHobBevveqGGX2+rs0jHyPzhsNBLXm4oRn0jQ=;
        b=oD21+jlcwmLPSyKeif887lRSZyyFWNCilhZbWoLgHPjsoNH8PqIroWygk48zVBvVf6
         1byNw76eIQ2Mtzr7Rew61xBjPGzjGOhUikLvC75C5cn9CBJddW633t/B0hQmh0QEGJv4
         B4kXvYwuCVJynSlkzSZdWujVdatjJ4r4KuVRRWjZS9sbhgrL4oDq1TJm5L+sMpG2LTYg
         CpnNdFQzpb517YHzK+vjQ83er4vU0+M8TPIyummcfVCVVcH6FEJgFGwNV2R98hpU9s6Q
         WGhUi6WdfDmllTjsOBSm1IRx0VwgFOry1zwMxH8g6mnNS9d7y2bmgSG5g6x+3oqhLwAz
         ucJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002459; x=1741607259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnRzrlaHobBevveqGGX2+rs0jHyPzhsNBLXm4oRn0jQ=;
        b=Vz7Gy8nKCPXOrJLEsD9B8xnkFICiL/z0957ixmWW9qRB5s3vuPiNPp3EP2qPWD0qdY
         FS/iMMuTebLn0aXvEd3VWim3kjYdHtr8n9EQfMilyRyB2ojp7GJdwnuJqrVWFCJH17Ny
         IDUAAYkCoyaplblbBiZjHNk1Fxh7pufiNvYevxaG0+jH08vVoSj2UYiiOIpCC31vxw+y
         FeRco+OoDNbDY176Tg5bV/OD4IN8ujBFdVd6r1sy9fyo+O+bwKVtnRWbv0P0McGZ+CyF
         atndqaRB3c+Bd2O4WIMJ6D955hVnQymgf3nL+VKoYr3yt7da/hoij76gBFnFpWVnTWT0
         eKmg==
X-Forwarded-Encrypted: i=1; AJvYcCWz608qi3qCEmoUNUhY3X4PMoj5OfNuFVYzT4HNhkjyMCjIBaDOrwduOsQNw3QzhVdXdNP4bD4btdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ArQc+gwWelEpPOnuV4JF+2K0eFAeA5FSjAkXawgO/rRyvuAe
	+sqTZN9Ru508L59l+rhuk1LA76A7nieJ6KrkE6UPUGtUdTgFvB9vO6V07ychg+c=
X-Gm-Gg: ASbGnct+A6ABvEVxhZi1iIMIwEuQ5VmkC8c1T1jsyhpXF33v0Vrj8EAqshDsFakDUYF
	bmDlXRM7SJUAm3NSHUCtH701d7lTJ1CQPmVP9g9yQifFnzdk1CE8a81BRxNuSRs0UFhTPHBdAyu
	1u8gv1BN+2DLWL5IOqvmzxqoOCf76HSyJftVFU+O5tFV+6WCFeS4kCI8tSWCQ6viNIN1iNMRTzY
	ZL07lzZlqcWRYbttXPROLD8NV0yw6Zi5F2mg0PtgTJKRVBM1LDdgGkDXfbzBO3ni6CAzEVkVTQi
	OvVNaqB5RmtP8vnoOkVC+Xi+BTlJmTAPNVfUMy0tadnh+ns7jubuIxCuTTyCSoskSJyeuKbD9PG
	QwcY2//oU/Uv/CTE2IoYrrFm3bg==
X-Google-Smtp-Source: AGHT+IEPelpzjBXle1ODTsLIRQuhO2S9yRtlFcuYLUIVHvjJ1DhOW+bnXxMRk/r9ecJhRnBZwEE36g==
X-Received: by 2002:a05:6000:401f:b0:38f:2ddd:a1bb with SMTP id ffacd0b85a97d-390ec7ca28cmr11111072f8f.8.1741002458633;
        Mon, 03 Mar 2025 03:47:38 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d773sm14145068f8f.81.2025.03.03.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:38 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] iio: adc: ad{4130,7124,7173}: A few fixes and ad7124 calibration
Date: Mon,  3 Mar 2025 12:46:58 +0100
Message-ID: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=MSkPPAJbz5sNa+zrMs9bZ7T61hqfW3CG2VTMkft4RA8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZazKHwSf+ZqQIxBmP/3eFs2LnAeZXIeXldZj JXjhaC9zLmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WWswAKCRCPgPtYfRL+ TgrwCACGgKQbCedEbUOvstBuXraA6Xx0XQxYnTmj0d2elbQr/e47+ZDrQBWdFRrSUmnRzbcFKNa xgHkKiN91Hjusg86MX58tkcq1Of90geQc/1hzC1CNVy7uWdtQFSDxf60sWiBzq4XjLLtfJ3d6Fy P1NScMBAb/gpeZGMf6mAgIzlzRpIAS++4+0CcsKogjW5pD6+skvNWER3PjEyrojyIiTGEwMeHD3 WXpnB4+j5W1Ry0sMKSIWT2NWK24fBzn/K3i5bMrJlGGwfMyk+jSsnXY7Kb0Fb7HJRQpuwu8h5Nd ai1aURJMDJppAihRB9kv5UMsO8OmidANxImwCvNXfAd4mVXI
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

v3 of this series can be found at
https://lore.kernel.org/linux-iio/cover.1740405546.git.u.kleine-koenig@baylibre.com .

The changes here are:

 - rebase to current iio/togreg (which required a few trivial adaptions
   due to changes around
   iio_device_claim_direct/iio_device_claim_direct_mode()

 - patch #5 (ad4130: Adapt internal names to match official filter_type
   ABI) is new.

 - refactor ad7124_write_syscalib() as suggested by Jonathan to simplify
   code flow.

 - Rework the two ad7124 calibration patches to grab direct mode.
   (There is another patch series of mine that fixes two other drivers
   in this regard. Git handles applying this series just fine on top of
   this.)

Best regards
Uwe

Uwe Kleine-König (8):
  iio: adc: ad_sigma_delta: Disable channel after calibration
  iio: adc: ad4130: Fix comparison of channel setups
  iio: adc: ad7124: Fix comparison of channel configs
  iio: adc: ad7173: Fix comparison of channel configs
  iio: adc: ad4130: Adapt internal names to match official filter_type
    ABI
  iio: adc: ad_sigma_delta: Add error checking for
    ad_sigma_delta_set_channel()
  iio: adc: ad7124: Implement internal calibration at probe time
  iio: adc: ad7124: Implement system calibration

 drivers/iio/adc/ad4130.c         | 121 +++++++-----
 drivers/iio/adc/ad7124.c         | 315 ++++++++++++++++++++++++++++---
 drivers/iio/adc/ad7173.c         |  25 ++-
 drivers/iio/adc/ad_sigma_delta.c |   6 +-
 4 files changed, 397 insertions(+), 70 deletions(-)


base-commit: 9cbc49c91d2f50f47f52c458d59253c21d883560
-- 
2.47.1


