Return-Path: <linux-iio+bounces-27514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C23A1CFE0F7
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 14:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC1FB310B639
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF7D341060;
	Wed,  7 Jan 2026 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMXnTQJa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C6F33F386
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793203; cv=none; b=SQ7nrnaT/pTA840saZasZ7Rw2Cbgz0h97fRu89NOjDH54l4h2ny9t2sKEWsgzjlsazz05JasW9oIM7zMWXE7MxNPl5jq+TNNvrcCnccLCcXNi07qkhs8nefDofnGVbV9Obby5tBXoM7nl1cExQegqB6D5holKHUHXUwtrjP22a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793203; c=relaxed/simple;
	bh=b4JPiwYZZNZVEP0BvLqcWwbe/rsB9saevx47a301FVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gPvDkTBirvgSZx0BcD2CpHHWGyin2VqXEWQzOShO31SbbNhGstAx7EKiiQ9ul0TYXyLEPfJTHLO/cqvq1CmMcA4vBA39r2rviAnkSy7X7m71VAEaaMqXQtfVqm6C5e8Yf5kwSgd6UxCCdwL07I6hVmWk5n7AzddCfTT+QRT/Gcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IMXnTQJa; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so932597f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 05:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767793198; x=1768397998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=essmEBOdYZvlb56f47cnSD8phUDtBzvO/hiGaoERCfE=;
        b=IMXnTQJaBvrujm3qT28MiKfy9kVPWjq/7nSb8GKZBIR8an2W63BoU2BDsC7WvDTC0z
         LQJMzHVdn8EyhcfxgZc15KqxOWOvqFTZ4fUrS8f4jWz6LDs2ixi61oDLJ3R3+F9Sry2t
         dm3rv46URR/1pYuDZLhzwuWdmdBU/ydv4gk2+cYihfqxma9hBGUETeHJr/elH4UT8qnd
         4XNlTNo22VxNC6JdDBfMN7TEfYVBpPltYBZCuc4uifZDm6tySvVp5BKfyXsCj3tdhXRG
         abHWcSRFTjlqTX5QsSTSdHo/83d3mnJ9bgDKBp8mViMfPREu3cIRjoWU5xXh0Zq0D0eW
         dkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767793198; x=1768397998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=essmEBOdYZvlb56f47cnSD8phUDtBzvO/hiGaoERCfE=;
        b=TY7wFiLWk3LSRW7vG60w6lNPwNfti5o7itXpephDwgSfg6djqI/bhjoKgm9YoMwL5a
         9Mh7437Ysng+65F88Laajn2kkA/alfLrXi1p/si1ZXzE0W/KA6240zxkPIU//tQiygwp
         73tXq0UhoWUFno2ioCvCN7OesARrjLpti7bCvyJfwmo8a/mqfpXNTQQXWB4ZoknynBgZ
         34iSvqsW1t53vCVVSOjuaBh7EHjccDUqdacq5T6J58l2oR0wU1O6yFTD6RJQvmT4D8Hx
         bw4y1XM2RTEqkCNdZIPjYqG+w9idmxGdM0M/osQnGqELDGgwIsx3GTQn8K4o5JQveuDh
         ecCg==
X-Forwarded-Encrypted: i=1; AJvYcCURyAAJ8x2xN4Z9Z8jWi2O56z1Pns6KnFcoJuaYDHLwA1MrGXlUn+2OUe2y+b9idQWQVcKDDoqMSJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhA32lswryo3KOfbEGH8hSqxZdd/p78x+HM2pDz83veR1gR0bs
	AP1W1AQ44Fo07MjApHcgkYazWaIb8lRun9nLJ3icsFHr6+HHqnQMnLokbOxtVuuh2bz1IdnZhQf
	AYq75
X-Gm-Gg: AY/fxX7ouTD0tUftUNek5VzHwECOaJWAAIUNk0GT02Y8RHsRqIU3moW/8i3PZJ/hsBv
	1i+R4iuVIuGVaJEv0BZOKSFMvzGiXH3cjWTM0hOXvNuH2kCNw4rsVusDduSczSomlWUTiKXQaON
	mdWEkGw6q+72VPFh0fhntsPmMczGtxsYKGXidGIn9Q4dVTyiJEn+loIF1+xONIdMIOvs3TEMchK
	kSNUB5C+MF64E+16yt8aVpCWxAtFqO3GT4+QaMnEsRXaU6onimLU+aTQJUlwCUl0+VJUvoxLkpp
	78l8DDUKezN3K4ljqK/9Xjc9Bi967g5mrNnQ1D9a1QCKz95HMnD/AWUL9k94lCKa90KZEkW4R7B
	WYuM7brtn00FOOvUDF3wlfc3/1Zbi315uZLdifeixymuK8pWfO3cwPDGzwwHrMsjHhGWFETuStZ
	8osNz4LrBPCeXT5xqtFq9oGZOD9QTD8+I=
X-Google-Smtp-Source: AGHT+IG5yiUMmsBELFqzl5e0cwWDO08ZlCwN7eYh8sJJ//HcdWLe6zUmYURWf7nvq3DOf61gkk+LhA==
X-Received: by 2002:a5d:64c6:0:b0:42f:b581:c69d with SMTP id ffacd0b85a97d-432c3628323mr2941135f8f.3.1767793197720;
        Wed, 07 Jan 2026 05:39:57 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:39ee:bc4c:aafe:6bd0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dade5sm10595542f8f.9.2026.01.07.05.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:39:57 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org
Cc: robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 0/3] Add the System Timer Module counter
Date: Wed,  7 Jan 2026 14:39:49 +0100
Message-ID: <20260107133953.2094015-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NXP S32 family provides a System Timer Module (STM), a 32-bit
free-running counter clocked from a peripheral clock. The STM includes
a prescaler and one or more compare channels generating optional
interrupts. When used as a generic hardware counter, only the main
free-running counter is required, while the compare channels are
typically unused.

On S32G2 devices, the STM is exposed as a simple counter block that
can operate continuously and be shared across subsystems such as the
Linux kernel, firmware components running on Cortex-M7 cores, or other
co-processors. The counter can be read atomically and provides a
stable timestamp source to correlate events occurring in different
execution contexts.

The Linux kernel controls the STM through a memory-mapped interface,
configuring the prescaler, enabling or disabling the counter, and
accounting for wrap-arounds. Other subsystems access the counter in
read-only mode, making it a shared timestamp reference across the
platform.

This driver adds support for the STM when used as a counter on S32G2
platforms. The device is described in the device tree using the
following compatible:

compatible = "nxp,s32g2-stm-cnt";

The driver exposes basic counter functionality: start, stop, reset,
prescaler configuration, and overflow handling.

Changelog:
	* v4
	  - Split context structure to suspend/resume
	  - Converted counter to a u64 to accumulate the time
	  - Replaced 'reset' to a count write to reset (William Breathitt Gray)
	  - Added events for userspace (William Breathitt Gray)
	  - Added action COUNTER_SYNAPSE_ACTION_RISING_EDGE for signal (William Breathitt Gray)
	  - Renamed counter name to "System Timer Module Counter" (William Breathitt Gray)

	* v3
	  - Fixed compatible typo "nxp,s32g2-stm" to "nxp,s32g2-stm-cnt"

	* v2
	  - Added Rob's tag
	  ** kbuild
	  - Reordered alphabetically the headers
	  - Added bitfield.h header
	  - Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()

Daniel Lezcano (3):
  counters: Reorder the Makefile
  dt-bindings: counter: Add NXP System Timer Module Counter
  counter: Add STM based counter

 .../bindings/counter/nxp,s32g2-stm-cnt.yaml   |  64 +++
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |   6 +-
 .../boot/dts/freescale/s32g274a-rdb2.dts      |  10 +-
 drivers/counter/Kconfig                       |  10 +
 drivers/counter/Makefile                      |  21 +-
 drivers/counter/nxp-stm-cnt.c                 | 433 ++++++++++++++++++
 6 files changed, 525 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/counter/nxp,s32g2-stm-cnt.yaml
 create mode 100644 drivers/counter/nxp-stm-cnt.c

-- 
2.43.0


