Return-Path: <linux-iio+bounces-20250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B248ACF977
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 00:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F1E189CBCF
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 22:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA9C27F16B;
	Thu,  5 Jun 2025 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sas1PTQt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178727E7E6;
	Thu,  5 Jun 2025 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161117; cv=none; b=n+7sP7BKoGqKBwnTaJ8mSzVUIo6l/JfIuIanS6MQ8+OjXIsortLjKrzvpa4Wg5M3+TuansJmHP6qa7t3MljC7X5QdMb8jFH8DRfpvbRH6FyOFsypIHNPKoTfrL9X0ze+pYkzW5XjUL1M/xA9mQxMoShc7jsTWJSYGDqLDwCeyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161117; c=relaxed/simple;
	bh=3vj4K85kORNIXijyvLOkpuKK2R+wG3EegDNBKMfMUVs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OCVz9wYzre2NkTterVUlKEzEacsIH1VHw3Mdd2VpYAOnzZ8Mrb4Gets80T3urC+6G1LtVqb3YP0ea/qANSUS6XB8VulVqEzoKAIuAM8PDPm8sHYwX6shyc53GttIdBwvURlAK5X8v9GViXcxB/UaGgB7dplzKH+IGi58SDJQzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sas1PTQt; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-52b2290e292so525682e0c.3;
        Thu, 05 Jun 2025 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749161114; x=1749765914; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGastCm36FgXNCcC57ensjLOzhaOTk9LpHFAnhoMBXk=;
        b=Sas1PTQtTexTrFqpZ8YpB/1Y9YzMr3h2bgVFfTDx9YIBAcNNyM2P7J3SAvPI3MZQ1p
         +8UfUmov2xuzx0YPhCPhKSy6qIBCt65Sea017sVMQk4ojbFcoLpSCle55xeeVehoRTz2
         k1fBFyhiJgbMH4szp1E+c7QY5ozbmKnqdx+9f2MPKZkvjSWmw33yapQPbhyS+cYtnu1c
         Bs6tStlId3xBRIFlQ/9ngW/XJR4CAUJAqmhM6YaaGwINTOdcyFkwOi9KMu0/3jP+t45O
         PzIRh2fPeuqKSNN3UwTCC1JYc51+fOrFo7MVjgTOAz8zLRogWTAzovIejeDBxSDKEV7j
         gmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749161114; x=1749765914;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGastCm36FgXNCcC57ensjLOzhaOTk9LpHFAnhoMBXk=;
        b=VM3+6mIgxh3x9Hxrf5o2THYA+E06Pl5rHcZttRhj+HXsCEkgdwSYSUiXszSftiEycj
         3phkyA7Boecgc3EEG2KgvERAmCmPVapC717aTzClKB88FIRnSIvFs8/0/42umfX2FNkq
         FO/3r5CXQrcbpeRBj61chkAbDKFYNsCnXw5+guAuaRrzRkW61bmFYPNkUD8+9EmNPcr2
         4b9kRRLa6GWMFYCHq8rLfp1CHpK0KjGmg3s4rMFuSNtBIVS6srpWD2kMbHJsurRalOTy
         TSEAwtTo3jJ4kXfuw60dDsQHVcxCmvBkFlpzuXodSn7LcG9Dctnptd099r/zXWHdtP9t
         Fsig==
X-Forwarded-Encrypted: i=1; AJvYcCWkNeGyIsODdh5qT2ZX/q8k712Umlc2JHdFmYBVmZ9SlBHgV6ylyd3MvkgYHfC6gKOGVJ3aefiTy5WXEFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxgcWaW6n4BvlianA0rk2UcVIEUhvaCGebOcmPCI0nJT/y0PGT
	Xet9rPJBvajlCdOIeW6itAKL4eRnDcsCrXDhk2GRWhPceN4p1lBGBjbxylF1cOx3
X-Gm-Gg: ASbGncuxGaV1RHiCzIqVAXzSGnsjN75gLTyovPP1T8qGFnQMohLHfW+DSZ5CYk67hC5
	IKBQW3Mu9esExZ1P9XbnEstlxjlJFxtYbIw1zDbUwB4htdpVWDIirkvpuDK/D8Y0OB2Rvc5vsj9
	7XpUrhYsq6U9rIF9Cn2FCVGZb2IgUWkiqhP+p/j/ZNjey/XkukMLfp/4hTR8tce4Ayu3JFjSw59
	VO6avhYEZV66g2ztG23pIJPGU38Da0EWh3u4pmXPCMeDyUs1sgwXObCxJSzpFwI3Sc80xGGJmuA
	KOdgxTIBABND3Uf8BPm22kJIOqzlwcUDVfjAYA3rsr9c4MAWnsfpxbiheHoK
X-Google-Smtp-Source: AGHT+IF24h1xuJvON1Kzk66i7K7qvXpHURr3Q/4K2J32pCqEHM6ldxx29WQk4cw7RALd9PeIfP5UWQ==
X-Received: by 2002:a05:6102:1624:b0:4e5:97e3:a97 with SMTP id ada2fe7eead31-4e77290bbcemr1018077137.15.1749161113615;
        Thu, 05 Jun 2025 15:05:13 -0700 (PDT)
Received: from [192.168.0.9] ([2804:14d:90a8:477c:13e7:d349:8af8:5d32])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ebd219ec7sm288832241.24.2025.06.05.15.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 15:05:13 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Subject: [PATCH v2 0/3] BMI270: Add support for step counter and motion
 events
Date: Thu, 05 Jun 2025 19:05:00 -0300
Message-Id: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIwUQmgC/3WMQQ6CMBBFr0Jm7ZgytDRx5T0MC6xTmERa05JGQ
 7i7lb3L93/e2yBzEs5waTZIXCRLDBXo1ICbxzAxyqMykCKjNGm8L0JWIRcOa0arXc/e+Pp0UJ1
 XYi/vo3cbKs+S15g+R760v/VfqbSocOydJeptx8Zfp2WU59nFBYZ937/AbMpOqgAAAA==
X-Change-ID: 20250424-bmi270-events-74c6ef5f4243
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749161110; l=2012;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=3vj4K85kORNIXijyvLOkpuKK2R+wG3EegDNBKMfMUVs=;
 b=t44Ry3l1VxGbtLtzd+JFn8FGxrFErMNQqb0smpsZ4cO3gGHGd9aSLhe58dDuJTnkfw8QJPi8g
 DOd1nREujynDVt6IloX7H+Tko93qRQ5404en+Tz7EdkC3O6cGiYg2kn
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

This series adds support for step counter and motion events using
interrupts in the BMI270 driver.

The step counter can be enabled, disabled, and configured with a
watermark, all from userspace.

Any-motion and no-motion events are generated by detecting changes
in acceleration on each axis.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
Changes in v2:
- Reduce the scope of mutex lock when clearing the step counter
- Change the type of the 'steps_enabled' variable from int to bool
- Add a new DMA safe variable to the device's private data to access the
  feature registers
- Remove unnecessary mutex lock
- Fix a build error found by the kernel test robot by initializing a
  local variable in the `bmi270_update_feature_reg()` function
- Remove dead code in the `bmi270_write_event_config()` function
- Add macro definitions and corresponding datasheet references for
  relevant constants: step counter maximum value, step counter factor,
  and threshold upper limit
- Remove the event bitmask from the device's private data. Read the
  registers directly to retrieve this information instead
- Use IIO_UNMOD_EVENT_CODE instead of IIO_MOD_EVENT_CODE where
  appropriate
- Fix shadowed error codes
- Change motion event to be enabled on a per-axis basis
- Create pseudo channel of type accel_x&y&z for the no-motion event
- Change no-motion event type to IIO_EV_TYPE_ROC
- Link to v1: https://lore.kernel.org/r/20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com

---
Gustavo Silva (3):
      iio: imu: bmi270: add channel for step counter
      iio: imu: bmi270: add step counter watermark event
      iio: imu: bmi270: add support for motion events

 drivers/iio/imu/bmi270/bmi270_core.c | 612 ++++++++++++++++++++++++++++++++++-
 1 file changed, 609 insertions(+), 3 deletions(-)
---
base-commit: b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6
change-id: 20250424-bmi270-events-74c6ef5f4243

Best regards,
-- 
Gustavo Silva <gustavograzs@gmail.com>


