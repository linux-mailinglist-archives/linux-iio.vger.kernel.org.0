Return-Path: <linux-iio+bounces-5075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF88C819E
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 09:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6379F282410
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 07:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C555D17BAE;
	Fri, 17 May 2024 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns/c29ZO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6017BA5;
	Fri, 17 May 2024 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932077; cv=none; b=bSvUXiTTUkTdBs8A6U65msVBZn0XWYdvGD2QZ3hxCZV/f9Emgiu4bUAD1dGCWwM1CzUnzey1tlZVXEO0HoKKB4l+Ap65Yy8oy0uACQMFFUBK7xZPL/kVSLOuRMoONEp5P9nT7ES7H9KM+kovgX3wNW5dwZEZYzIoWt8OLpXLPM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932077; c=relaxed/simple;
	bh=qE+/k0B7V6egRjbqmOye7yr70PCHiNMYWyP+oM9TdGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fneN9lxuz7XyLYGSFwWMCwzUAFhx4Ah8kWW9S/8rLhA5n+uJdHSEnXi49Mp5s7FbQLP3WMb40ZHrJo2vA3KB5j5Sl0kWITSWFXfo0xCKBKBVTp3w3vdYmrTxUz0lJMGWNrr99AWeoDzWGLNk95FlZz3iqhC+waS5Y6tZbvL1coY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns/c29ZO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4200ee78e56so45460705e9.3;
        Fri, 17 May 2024 00:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715932074; x=1716536874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JoBzN9djlJxpJaXKm3xKHuIL+i4B9g57qXebcYydQSs=;
        b=ns/c29ZOkelm0xm9FZOQ2M2a1FSdP+vDMnff38q9Qeag6ZENHsQ51u/ESk7dwiwCjd
         P1w2tpoX7Crbl3WpZ3iNpMLbIgRTOMyOEwXc1BEOSFdqcHc0/XZXjAsf3+Jke2fPxBDJ
         7J4eZ0tszXqcWXw1qD9hmvDkzLcbWhWOwmWzMYbw3XDBR7x/00KgOnSpm3y60swHmiKr
         hC/QBgejJbZLdnCMRNKLrc2k2M0BD8F8PHTg1zhge/srOZgtZZZnYyYXB6FZteajm3/G
         nrYmATIMBYpmOTOr5d2HtMRdZe05et/2vcM/VY+7JoduqqTnw8yjmNjzi8wWt6wvHmfF
         vLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932074; x=1716536874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JoBzN9djlJxpJaXKm3xKHuIL+i4B9g57qXebcYydQSs=;
        b=O4OVxbM+3sc2xf0GRVOmfsklfssnstc8ZLx6+ejkwjnK/0oQcs6rfZIdmKgVOkrs/W
         ikuWwpP+J2Tg1CPV9Trww4VgqCi4Kzi0/gVimWkwDxJi0imcUAB0xpz2X+VsU9gFGHEm
         xtNzOlvNQIjYRj53DhMEyEROiWZ1n2zYujSazc4e2DggIR+D+QnBblILoJ9gBruKcSeg
         fvQsp9qesT4lGB+gfv4ssDuw/XpPP8kF6Y/b2Wh2yyOrn/HM21QePT3uhjVCD1pqtzbJ
         EBAbBKD22PT3xrKyhNGgRB6vkXP+6GG8v3hUAkATNzO6pplWJ8kCWzVh8JnrYfhoGHjz
         /AOw==
X-Forwarded-Encrypted: i=1; AJvYcCXATQumzMeMYfXmRQfC1Tth6zOFKZYR5CneK+WArN+oElmA+7OdfRVqCb0AWjJmtuiFqiPxcwvcRejnDA153N8suzkl5WdSLuEncNyiDX32V4tJAayBS95TE0x+uj+VbjBkw5mo8A==
X-Gm-Message-State: AOJu0YysFKBQgxVDXCVje6k2W0Y0R4FojMHpQw6XlauG+dThyIH0w0Ks
	UnHA4mc8+3k0HrTHclco3/AA/n5Tz31e4FGdcQmssiyrGf+cwYjYop3GJNksEds=
X-Google-Smtp-Source: AGHT+IGVGOu3Gwg6UKzMcRLe19shTT5VlFaOsI9y9rQAhRSZkPS1HxjFu8di27ShTBxXuvKzAXQZrA==
X-Received: by 2002:a05:6000:798:b0:351:b7c8:3f08 with SMTP id ffacd0b85a97d-351b7c83fa5mr15729302f8f.10.1715932073602;
        Fri, 17 May 2024 00:47:53 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:569e:359d:dfe4:922e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacef2sm21104207f8f.85.2024.05.17.00.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:47:53 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v3 0/9] adis16501 and adis1657x support
Date: Fri, 17 May 2024 10:47:41 +0300
Message-Id: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add adis16501 and adis1657x support in adis16475.

Ramona Gradinariu (9):
  dt-bindings: iio: imu: Add ADIS16501 compatibles
  drivers: iio: imu: Add support for ADIS16501
  iio: imu: adis16475: Re-define ADIS16475_DATA
  iio: imu: adis_buffer: Add buffer setup API with buffer attributes
  iio: imu: adis16475: Create push single sample API
  drivers: iio: imu: adis16475: generic computation for sample rate
  iio: imu: adis_trigger: Allow level interrupts
  dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
  drivers: iio: imu: Add support for adis1657x family

 .../bindings/iio/imu/adi,adis16475.yaml       |  31 +
 drivers/iio/imu/Kconfig                       |   4 +-
 drivers/iio/imu/adis16475.c                   | 788 +++++++++++++++---
 drivers/iio/imu/adis_buffer.c                 |  32 +-
 drivers/iio/imu/adis_trigger.c                |  39 +-
 include/linux/iio/imu/adis.h                  |  19 +-
 6 files changed, 767 insertions(+), 146 deletions(-)

--
2.34.1


