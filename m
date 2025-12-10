Return-Path: <linux-iio+bounces-26987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD076CB1F6E
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 06:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80E943007D9F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 05:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF3E2FBDFF;
	Wed, 10 Dec 2025 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkEoGQn2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209E2299AAB
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765344315; cv=none; b=Fp0sTxV0OGP5gPD3QmmRa6X7ykaRf1nrmr/zryNsuxc0LWKjj0hsWW57uwoSoP+sY/RbZtOmpNHxJAoE7WHXNIP6tuQViWbIm4uxRxQmqZg+/vrlbUydPMTkphfzHpbDuyqKM6jB0bZvm7+HuBsyoZ4zjvlxcy6ILDu5Jm//MNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765344315; c=relaxed/simple;
	bh=e+j95jMXeUM0YV8aOFZvi80Us2v0kcLgnRw05P63QNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ptYOa1zbCD6x30tHfvTVbZNkGCtX85y+6HMFEpeZFv2fJShOqyTR+aurGnqof7Of3mrHErpdlq0VSpiY0RVNkiU1YLycy43hYzMM/dygUlAWuQ5m4MwbvzGrtdUI/S3eInJMq4XKRJbfkxuLZGV393e1rYjh5KBgIk5Z8Y8fyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EkEoGQn2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso84768385e9.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Dec 2025 21:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765344311; x=1765949111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eGfQ3qiTzzG9reGNHg6its+3nIMomB7nNh7rZSun6mE=;
        b=EkEoGQn2+ZJHFwir4wetRrUJKSzbyEHMDNKMmohCDhDis425tZrZdoypPmGB9NFKgm
         62oKOrDOyvswUzru+9pxfeQh8krdOvWNW/VxiKKaTpwkBX5dSP9ywnharedQ4yOgvLOx
         cDWV4YoLLFJOxzUBPTTfgpUtEVXBz4h4gPmh43rAm37XQ0nAPzJqc0fW47TuSEIH54gg
         /sMYjF6oQvDXtrJtqogO4ALNcwL/Mx/tJy+qtPn1fhGRfDw15b8bPIkBx9J1JZ6uZZXk
         QaTjHzVNStHedcGD23NwAyVryG4KMJFrbyZykUncz/Xn6J9QBhBMtG9Ad1Iade0vwfnb
         LU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765344311; x=1765949111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGfQ3qiTzzG9reGNHg6its+3nIMomB7nNh7rZSun6mE=;
        b=hbkXaW+5l655kQOhPrYRZBiX00n2Yibmw3TLIZvvRydLaaDmq7h8aZTdUU0gsRcm1z
         vzVuo+dZfzP4oHoydcmnOJbrHkFk89wciLi1ZIPn9dNYPoszlWjvxrdwKsaGmNO5dgKK
         tAtNz3TSyAr/XKR0vNQtyYu4D7tfK2wL4rKgBfBxsYCFIaLFThAB7Si3CPlN5WDdugIt
         v81duj/tysxEQjdrgpjJWqQ6IEgn6jaHEHJDUDSXtKEWKT33I1DlE39WdmnOrq4kI7JJ
         LK6KF1PRR+kRQB5p8h/yzn+zEYd2/ZmsS4mWuUMBBqsUdI9wWJm8M4CqBEKb1bNA1ieh
         XV9A==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZZhNcqs3E5qOQLz3zQgfzGMHO/nBXay8RD+IFU901E5Vi6o/Xv2GrD/nJ+I0UGt5bgPxSgklYCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmiNQZrFyJlOfmzZe9iXClPLriyBsHB8A8p6/YSfkugum3F4eP
	GqtsChnYM25Av75ac23D1vN2GiITM11vdV62MqrAfwuwESitcIagwBMTSJtHP9jhhE0=
X-Gm-Gg: ASbGncvfUaeLf3SEyup1IExZr8qlmuIDPPRZVOLB1V5A0nLstHRT5bRmw6xBtj/3E8W
	47loLeZlUNyh4rQMTlO2UUtu9l5V833efCXKiVL9pMyJFqPSwe/sw+SvHk/nfRtdld9PtydpEmp
	T8eoJjz+cJEiSAOkF013B7+VXm1QhorFfhSV9FuhKa2ThXzpgRlb2CfkUVIJ42c4T0CjnZhU4qb
	/8m8MuGX20nm3jd/mejeleU7Aqz55WfH24Q2+GSByPFzrlF8ECosxXdD2eb+YeB9s4+sCm/m5qd
	+mnLJHZTBETqdUvev1bXCEttI8c5nD2kANH449yfd7tzXjofKEBbAH+CStb3LhukSqHUbqf4njS
	VjX7JVw9BdoZmd//1t2E310/1WNQzr7Snd/7IF+GeRMJNjRFJ092oprXltYR+3m9rgoY8CJ7wRG
	MI/7Qck+PZ+it8BOby7dYE5a49AifS70k=
X-Google-Smtp-Source: AGHT+IFDRRrdDRlTyL+UUuEgDOPir+MxwY91C6SGfC4AqLJbo3UvQmoYIDZUN04cqYhCz3QTSE6IyQ==
X-Received: by 2002:a05:600c:198a:b0:47a:80f8:82ac with SMTP id 5b1f17b1804b1-47a8385848amr10132335e9.26.1765344311432;
        Tue, 09 Dec 2025 21:25:11 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:4fde:b93c:87db:86e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d3a75a3sm33485695e9.6.2025.12.09.21.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 21:25:09 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 0/3] Add the System Timer Module counter
Date: Wed, 10 Dec 2025 06:24:44 +0100
Message-ID: <20251210052449.4154283-1-daniel.lezcano@linaro.org>
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


