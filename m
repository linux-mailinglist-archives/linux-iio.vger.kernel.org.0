Return-Path: <linux-iio+bounces-2675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959938584F8
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 19:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BF02840C7
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54099134CFF;
	Fri, 16 Feb 2024 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Jf15LL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C727913340D
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107399; cv=none; b=ENRelNBfM1ZHVW0EJhLBPROoau3OMhnnyYpPDj56Ok2X0I4cu/M08xLMHmlZgB/EpYAFB5FNfmnjWvMTzeH77MSrdD7ZXrbvFzfWR7gE1a3Zt3vfaHzRglVyZEjhXNj69Ou2CBRwtXIL/nF3LFSR5kTafqvI61seWj+fYbHRFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107399; c=relaxed/simple;
	bh=FdJdzTVuBRA7U9Bfhmz6iwbA35jhqFNQ+6V2S0by1Cw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=a1Ix+K8ooUZDUR0Gf2BwTGkb7MucFjx4zsNbxhCiMqPqlpgjqMXADxJDUCyMpRbShw0Gv3Sxn4k2Xw1WBBxzJK4GTGl65plsktd4GC0C8idjbcCGEg0cXUop2GoXgQk+j1xKDXPzY1RHLkTcWBll3R0u/E2yZJ2Db9hHG4C+QrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Jf15LL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1346180a12.0
        for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 10:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708107397; x=1708712197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EC/QYMO3fgMpljqQ9u7uhTQo1257lEwVQUf7xE45gI4=;
        b=g2Jf15LLSGBlO5u/v2Z9lxhP1gqBdudCrYHUQZDK8R8QIheEdxw9N+vzNdn7Td0enN
         qtFe27MCPFpYC9EOzMoMvFohcib1oCIykPHmW5unm4vCcGfgnvug3iTGG5TyseUk5tjV
         GJ87X24JJghbuPxkAoD12Da1vk3IRA++6zNq1mVyTceLGCIthzvTkLeaeG0PQrzN5K9w
         BGik6e3FwrHYyDrMZ5P1rdkPYpbRO4nKfbGtmnf/YOzwgPZIJHDqq4Q2YMIm5XUZrCKy
         dkychYUgOaeDKLS7v3voD4QpDgBpAzoc9NQLrEXz43HDUqzTsmmD+uGAzqWP2lZg7Hqd
         excA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708107397; x=1708712197;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EC/QYMO3fgMpljqQ9u7uhTQo1257lEwVQUf7xE45gI4=;
        b=byvoKTDh1N5w5JfT5m0g9ZC6OsiZ6Ov/Qw7sb83hNv8d75buyXYGhVSZDlZ434+R3u
         g/sYzNsDLQgIaYu3FUJgGUovL9p608Hpb7D/YYuvojZiLol9nDtkYbb3R8DJ0f0B/WZF
         gD1cXSSJzYFGtd1kof2yoicw+Z9tq3+OaLRcfKNdj4Y0kVe4i9Erix8l+WTbw7v/QoNz
         oqFauvUI8j6RRS/uIDa/CthM8vENZ961eZ4fAzUW9/WLriwHi+pIDeHQfq7jCta6JeFl
         zs7bh1SFi2Y21aEGSNo5sxVR+51AO3iuGi/KjTGSEVXCh3VnHM0wgSHzfD2LxQEjIS+6
         MsGA==
X-Gm-Message-State: AOJu0Yzmbhcc+SSJKG9XjI+q/SiQF+MFWSY6eB9eWZJHa9KOATE4OVGM
	g03Cr2dYZlCwLpfWcz3n3GvIZWVEF3g2IHBE0eBO2jfWPf6HKFNo6pgqsciV+7g5FuO+M4A8Umo
	ZenRW/9dKMEB8ZuRzTUKbJmLXZ5c=
X-Google-Smtp-Source: AGHT+IHfvWNfO1Po+3LVtJ9cDBQZjjobYNi9+2U2/65D8j/afy8vSznUY/cPQUU65dPs44klMta3Xz3J34SSBdT+UTk=
X-Received: by 2002:a17:90b:118e:b0:299:29e1:d0e7 with SMTP id
 gk14-20020a17090b118e00b0029929e1d0e7mr4329499pjb.8.1708107396859; Fri, 16
 Feb 2024 10:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jonathan LoBue <jlobue10@gmail.com>
Date: Fri, 16 Feb 2024 10:16:25 -0800
Message-ID: <CAF6rpDwZaCJOpLEYayVW8_aXQwKdpcLCDSRjbTNk1rr43EPriQ@mail.gmail.com>
Subject: [PATCH v6 0/2] Add bmi323 support for ASUS ROG ALLY
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Hans De Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	jagath jogj <jagathjog1996@gmail.com>, Luke Jones <luke@ljones.dev>, 
	Denis Benato <benato.denis96@gmail.com>, Antheas Kapenekakis <lkml@antheas.dev>, 
	Derek John Clark <derekjohn.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Jonathan LoBue <jlobue10@gmail.com>

This patch series adds comments about a duplicate ACPI identifier
between devices using bmc150 and bmi323. This series also adds the ACPI
match table for devices using bmi323 to allow those devices to load the
proper driver.

Changes since v5:
- Updated patch titles
- Add patch description to cover letter

Jonathan LoBue (2):
  iio: accel: bmc150: Document duplicate ACPI entries with bmi323 driver
  iio: imu: bmi323: Add ACPI Match Table

 drivers/iio/accel/bmc150-accel-i2c.c | 13 +++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c  | 20 ++++++++++++++++++++
 2 files changed, 33 insertions(+)
--
2.43.0

