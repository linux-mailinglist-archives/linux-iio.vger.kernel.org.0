Return-Path: <linux-iio+bounces-11237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D4E9AF3F3
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 22:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30A91C22753
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 20:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB28C2170C8;
	Thu, 24 Oct 2024 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWJCvmCs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A7170A27;
	Thu, 24 Oct 2024 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802696; cv=none; b=FssI8EPDqIqiBwASbzEK0oYfI46NqFfT7FuSWGlPhKvDnuEfsZdqFC+D6RTVsq22D1D/Tc64migIKJ4apCCY6UyjIgx+fJFck9MhMSvSxutH5zR6FAuU2lfGSrAUev+c68eoI95cIk1iAy/E+rZihiaQfzlt+tof9EjAJPQgExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802696; c=relaxed/simple;
	bh=7Jk1r7FEDBwbN3+UFT8qeXUAWHBJzRgT1WoU9XdCVb4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dNz1S3mFGvv8NRB3+kc6GxJHyix61E0ZB54S6z30SPHZcf+FnyYAM+AhPy+n2/yhAtHHlBT4/YRSgrAiv+XCMcFPqcMcvQsvvSYd8aXd0gHJ6bBjRoNLJfQx3gQwrp1dNOFc2yvdYK2jbBHRKqLwlqTOrWbacyxGxQNRaIYuJGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWJCvmCs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so14198125e9.1;
        Thu, 24 Oct 2024 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729802693; x=1730407493; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEY3S1tCv6SXbdC1v1hCbjXPWXWqVFBlAfEOqTO87X8=;
        b=CWJCvmCsYnDw7nCq9qP79h00QXUVnsG9TvBSCtx0OyHjamVjGOpKt4W7N2YfZOSbqF
         320DV60Lfddk4c2WhlInsa5HKyBYzA5Wb6hHDXMaxhBcnmXEkChCAutyV8CfeYHmupCt
         r6dCh0rg8g7fYjjFLNrjfDQszWp+RJTLsvVNie3K2WEIfS8FGnJjjvw3kJ8/ihXBl8VX
         aThxMd9kzMFy8SRiM0Yjy+sbe1jzvjsGfLmchKd8jjUWzzHSefxi8Rpf65hu6phHZj3F
         wr31t0KjVIvBSObT6L7H39keU3JJSf7Ph4Uep/yNZ+Mf2t8UqbUz0DkcXChUxkzwm+b1
         dFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802693; x=1730407493;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEY3S1tCv6SXbdC1v1hCbjXPWXWqVFBlAfEOqTO87X8=;
        b=w+kMsxU6cSMo1XOWmSW/Qob1OSHZMHiJNFwG6dV0ux4oBqEGnIEk8FURLTA9IW5jHv
         Q818CkfIyuaNGeLXlvfwUi1TjF3Y2xLSm7OM1zI2Vk0Dlq5O1TV0VU17AEeSsIPH4oUY
         qjz8vVQ0qWBVJ+Rj+5MXq7qbKNMf0zR/rjavlztWnymM115o/vdsqNnvPi1GpsWT7D4C
         IE8TEH9TdRphF6A3yheQCcLVsj0l78LWHAT4ysrebgNaz/St35vzpIY4dtZQE1B85Y1L
         oq465GPmRQmoIyRtC3WVHu1PHn9TCsS/SosfVOtwHDN1ugcT+gDyrJf6f+E1OuwUZ1mF
         ATzA==
X-Forwarded-Encrypted: i=1; AJvYcCV6vZBfDqUIH2ROzNxzsOd6cD7GzxHxS2xRz+aAIAWJNk6NoUdJ6wf13qr8jg4PeJeQAIdWqUT7fGkd@vger.kernel.org, AJvYcCW5xE0WP0Qa/jMlhxL/vt3+ziMpD3p1W+Mq0cm1zpudPRi6rJOAMqEwIMawdCVDkUADnEV10qSRCy6DPIje@vger.kernel.org
X-Gm-Message-State: AOJu0YwrfXOG+e+2hoNBwOaIO3LukfaBzo67BH72d2WmligYjf++CNZN
	WJ9nqgygcoJL2ul97RKDOi2qNRXjn4H+E1/JMGGouNtUrfVI/k8h4BdyYg==
X-Google-Smtp-Source: AGHT+IEAH8NpRrDUMYeicG2rAmt5mKr/3D6/Y0ofdlREFgSmhTaCHojirwDiNb4HplHUDFaTOqH4xQ==
X-Received: by 2002:a05:600c:354b:b0:42f:75cd:2566 with SMTP id 5b1f17b1804b1-4318c6e902dmr27718905e9.2.1729802692427;
        Thu, 24 Oct 2024 13:44:52 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-937a-2f15-cf5f-c6fb.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:937a:2f15:cf5f:c6fb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4ad48sm12105728f8f.42.2024.10.24.13.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:44:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/2] iio: light: veml6070: add integration time
Date: Thu, 24 Oct 2024 22:44:47 +0200
Message-Id: <20241024-veml6070-integration-time-v2-0-d53272ec0feb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL+xGmcC/32NQQqDMBBFryKz7pQkVVO66j2Ki8GMOmC0JCG0i
 HdvKnTb5fvw3t8gchCOcKs2CJwlyroUMKcK+omWkVFcYTDK1FrpGjP7uVVWoSyJx0CpCJjEM9q
 ro6FmImcGKP4z8CCvo/3oCk8S0xrex1XW3/VXtX+qWaPCS6Os09Y1raH76Enmc7966PZ9/wCnF
 fkdwgAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729802691; l=2000;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7Jk1r7FEDBwbN3+UFT8qeXUAWHBJzRgT1WoU9XdCVb4=;
 b=FQ/grfkkDv0owoaTQ8Zy5xy8l5Svj1oYU0d1/Uy5ZoCeU8/uuMUKAkmQW+b2U91Y4KP3lPCSv
 hSN0dC7lLC8CRMeqi29DgfjOqcsX/STMHqM99trGQI4yCa16ozv0ppv
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds a missing feature in the veml6070 driver to select the
integration time, which also depends on an external restistor that has
been added to the corresponding bindings.

The datasheet provides a Refresh time vs Rset graph (figure 7), which
does not clearly specify the minimum and maximum values for Rset. The
manufacuter has confirmed that no values under 75 kohms should be used
to keep linearity, and the graph does not go beyond 1200 kohms, which is
also the biggest Rset used in the application note. The default value of
270 kohms is the one currently used in the driver to calculate the UVI.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Rebase onto iio/testing and drop applied patches.
- veml6075.yaml: use documented -ohms, top-level definition and
  per-device restriction.
- veml6075.yaml: add default value.
- veml6075.yaml: fix typo in commit message.
- veml6070.c: adjust rset property name and convert from ohms to kohms
  to avoid overflows and work with the same units as in the datasheet.
- veml6070.c: change default to 270 kohms (already used as default
  value to calculate UVI).
- veml6070.c: calculate UVI according to the current integration time.
- veml6070.c: re-calculate measurement time (i.e. msleep()) with the
  current integration time.
- Link to v1: https://lore.kernel.org/r/20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com

---
Javier Carrasco (2):
      dt-bindings: iio: light: veml6075: document rset-ohms
      iio: light: veml6070: add support for integration time

 .../bindings/iio/light/vishay,veml6075.yaml        |  27 ++++
 drivers/iio/light/veml6070.c                       | 137 +++++++++++++++++++--
 2 files changed, 156 insertions(+), 8 deletions(-)
---
base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090
change-id: 20241014-veml6070-integration-time-78daf4eaad2f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


