Return-Path: <linux-iio+bounces-27130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E70CC66F4
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 08:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5BB3006609
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 07:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84013337BA6;
	Wed, 17 Dec 2025 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxAVFgQM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700232C2366
	for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2025 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765957818; cv=none; b=eyrygPGz1BDYK0YsV/VCPMxb7jUdKoYCSjeTlJQW3L4fOG7klV6b4BZS33vRyi8GojCH0RfozC9JAfQgCeTuzizxQf1uVWTnlawT0oMlZWixS4sY4i2foS7+CZQS9spyzIOpx5uzgajTgrxvv2tE1qtfz03llpZV3nMvi0aKjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765957818; c=relaxed/simple;
	bh=PUnnLOIItZtBkY06/aK3pdb7UGncSaLJK2ok4t8hj30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7fWVQNMWb0kUPsgNWcdNvJy8CO3HT5Ii6okcneY52H3UQSAwDO6QVIWKL2pJoWEEj45UVKAnIIHGuk9z9yZCwvB1wVULYHHzpvzictuYmfcod99USAtVsu+IQsc28kpfHrnXqB82hHSFgzvCBFNz4Y068JCKo4F8mYrQAtGK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vxAVFgQM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so42791985e9.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 23:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765957815; x=1766562615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+O9e6W3Bxj05hKh2u9o2UOrQ5o4C+FvFWwacOPc+l0=;
        b=vxAVFgQM/GPBsijcA9RKtMYI7pBSD9D8RXWMAXFFwpN2D7e7uHXmU0DZ7/2axdjY4t
         EGmhik3+u6Ol9oybjoe8ABMSVR6i+y/lH3VNrjP+1qSZZgoAOlbaqe8zhgA6AWukG6ov
         bn8mWYgqPf+p77jQjqG8DIfnBE6Hi7CKwNfmjcAO6f1fLIkpLrNRZ4luX3EnOCv/+P8w
         YH81zNity/mcH2Y4fz8IwpBg4GA+7+/lzg1pFaHhEhTIeabb3dojt1sxsfmw/acbu3ba
         qTMyjoyoI617wGmBXg722aTtbSdJzmoYrJA1suISWeUkY/Ah8+7lI3ETSzKMHXBM7bZC
         RBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765957815; x=1766562615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+O9e6W3Bxj05hKh2u9o2UOrQ5o4C+FvFWwacOPc+l0=;
        b=OYNKJ2cEi6db8DwO88pYyAwtvxjaAZL8rP5TGZdEYSRw8zu/k3f1LArvBwZGoEOMrL
         hdWLsH6A0qKs5T89y6i9FS2/RJ8nGCbP40BfeBWDz7Sl31bDzrkRM+tZ6fNIYj8GKpLw
         oBtFnRXlfqrFz+mnfl4oOi9PzDAvkFM2OCyIJ4NtRW6eXw7qaN9aOY/jzDpTvUYrBFB9
         J7jDbK6Hjpk3j6MbPeOs9GhTjNr1fQ3UEE2orH1SfTRCYeVSsHhA+V1qVxuvii+Y/TSQ
         WXeztygeqiLYhvKxqaDFhNWmJPJmUU/IOqs/njEEpu56TwPq9EfKW1wndc0vgl1+A8MY
         4ZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTpehzMgmo+JUYBH5jFLc0b+yivS5cJpG67O/Vmp3MfLCoW24OwlpAyqyuQCyeSLDExJoqyWaAaeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRAV6IaxA2FNN7J8IVZpYhOL/FJxldsKeMQV8UBoea05D0R4r
	jh/oEPU/UK7Fa+clbQUS9A8TX9zqUxliWZIDy0vx3yU2JorI+AtkH31osC2bgxE8PpI=
X-Gm-Gg: AY/fxX6Nal3dGwSoAvHROynvXjNeKqI+J4MWJCvAQFahPLM9N+sFSS/AdgHVR9cnB6b
	jijr9ik3x/x+p3SO3SWDjjCgRMsqspJh2xa1rRy8gPcmHZlje4ljLw8fJ1fnWQbWzDk0YVPGlrh
	hMZlzQ3iU9IyiZhLcijNHXoBgoEZpM+WUDsve6jMRvRPMA5sQdKPCjEW/CTg5G9CW2aokMGeUDK
	n9BVQfEXOJpGpb6RZ4E10NJdhpe68AZQhLl0Oakm01PhSX+bXGCBK4G0yJtH3GC2EXjCzymC9pb
	xpBObQxiYVcH9TwwI4iwfpv+Fu1+4DD2WHQSPl/VQOZXNY1xuvC6hDma0Jg7ER/2KKBfkGCSgtM
	MwRzZQ6fRLVU/0hJrvZVOY4aKfGqtuUw9sxJX+ZCxvTTOA4pJ4EbXBuqpoQkZDMb8l0020IBGES
	Gpu6j2DWh4wWaWg4vwZqr7coesV7Ph33g=
X-Google-Smtp-Source: AGHT+IGRqDAO52fk8qcGmvcKhV3t5iObtMWHgo4/Y2HmbK1D8Q3NfF3+JenD756iAy8zS3sn7M9bFw==
X-Received: by 2002:a05:600c:8b16:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-47a8f90e81fmr180826235e9.29.1765957814792;
        Tue, 16 Dec 2025 23:50:14 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc1edff5sm26094315e9.14.2025.12.16.23.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 23:50:14 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 0/3] Add the System Timer Module counter
Date: Wed, 17 Dec 2025 08:49:54 +0100
Message-ID: <20251217075000.2592966-1-daniel.lezcano@linaro.org>
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
 drivers/counter/Kconfig                       |  10 +
 drivers/counter/Makefile                      |  21 +-
 drivers/counter/nxp-stm-cnt.c                 | 386 ++++++++++++++++++
 4 files changed, 472 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/counter/nxp,s32g2-stm-cnt.yaml
 create mode 100644 drivers/counter/nxp-stm-cnt.c

-- 
2.43.0


