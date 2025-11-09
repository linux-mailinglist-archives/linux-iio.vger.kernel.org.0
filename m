Return-Path: <linux-iio+bounces-26070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE01C43FC2
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 15:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EEDB188A850
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3372FD67A;
	Sun,  9 Nov 2025 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld+8G5Qr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA92EBDCD
	for <linux-iio@vger.kernel.org>; Sun,  9 Nov 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697506; cv=none; b=EYw4J2RLlYbeQNcHN65cxyzU39W+wpxdFFlQ4Tr/BP8zlwmQO6jRJer16Ol3VFLB+/Nircdt3xtvRCQ0QQVDDVrqy1ETahfYywzIwQzn15EIRsgJ48Kc4ap89UCgN8AWiID5xXbl8roj4ZxdD+dPk+UKFgwa/5A4Y4gT1CJi9vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697506; c=relaxed/simple;
	bh=Vy4v663byFI/J5rgp6z8mHMaGRohYoClqvZGWuEUl4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M8azgLuOKFaD2n2ebSWdYVkvEreypL6YwsR+WssibP1qmabuqYs/BL3FRWwtFIht651G/3YwTVz+F9NClXcq/AuGThfujoNxs+Q79JQnusfmpf5RmF04fpX8uTGKJha0SygEW+X8nf2s2/oTE9Cvhnkcgv1vtDYtId2NcoeYC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld+8G5Qr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so2632454b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 09 Nov 2025 06:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762697504; x=1763302304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/NRAJqvrniTCxicYWw7CVxJQJTdmyRR0h5G6gK7WiU=;
        b=ld+8G5QruDH8P/jraEOiNcHwTHp4TX20qN5xzjcDG58LkSQNsebRjH/t2RBoSE0FRK
         a1pKQ56d6dRhXtB6rkjyrdKpOeOl2U0Td3DldoMHX7noQhqY8dLc+DTstziKIn9gp12q
         I2dq691wjjXc+aWlB3uR/rdiUHbjGCuaifQyQJBgHkao0RhthJdDNsakrlpGq/c+uGVt
         ledTWpNYIlWrnxeuM937yXAVmPsS0zKwLc+pVk75YxDgb585Rq5uju+79fKfc+BedVjk
         7H+jYORB7fJzAuC7FgeXWl1XtZZruGFIckgFdAmzQ5cHrk/JnsqkQ0YMmRf5q9s8Hosx
         YIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762697504; x=1763302304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/NRAJqvrniTCxicYWw7CVxJQJTdmyRR0h5G6gK7WiU=;
        b=V3csBOTKt+RBylMvt61SdR490+I6LqDy0nF4KklvWgwrpcC5hOq3UaiIeJY8MUrvXD
         z7XtNUAj+ao/cKkJzD2RQM3X8dN/rTsDUyZa0FzcVTaXbI5phvcsCwSXPPWNoBhV/Tny
         7rYdotHo/hulKNpcsGr5+L00vaFMkBY4yNkjM7dVwxRuMIJ+FLhfye5TEvK0O0SKdTTf
         ZxL27tBqDl6Yu15t0/IQ+wwqsf0MxBNvFbZipO7rbm5xaphdEG7Q9E9cRl/NQNKoJiDP
         BwyCTtzPP/jUhP1mHeFHGUxz9rOEJzmiM2OvOLGsaNffaXq6qndHWUwQablqrOpco6Sg
         6mbw==
X-Forwarded-Encrypted: i=1; AJvYcCW80fN837NsLyQqpq41PBkAMDNm4fL88viiePeeGPpxedo2gmTiA3YDQusyjlH9XJUPO/8fjXko0sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoyAN3x+5BRTMTwZYxHkU35x/YZifs6kxikIg8P04uJ2d9l8aF
	w2fqJ0Xjoj8diR7pZGXEEOsJpICnZDsxhaA04QO7fffyTlisi93/fn1d
X-Gm-Gg: ASbGncsIWwuR/h7IJ25PEqLqdlF90eCL6Xvim5I3P2V1YrO2sDpIv1JF3V0F2XNgeiN
	Pmlyk1G5op/S/X3ZWNpRKbiE7M8clmVGYtAMikEUlk3OKifL9FGkPULM3Kxk1HV3LD7odEmwk+/
	jTZLHvE06sIZBRfiDeB5hpB5lIFMDReXhLTb2arHxFp7vaDQaBPhagBWyWzw6PPpiFBoI6KnSIQ
	hid1h3ATU0eApJPAC10VGz6GLdYquM+RM2Hs1CgKlFkI5ZXvGtOgoU+2AtanL00PoPWLr6mhiRf
	Hgul1UnR6a2zrKzuQCZthm4IZSxK4rxq/j83FO3YlCc/XAblN4oA47LuGDGCJ0fV01WmJ00OofH
	1mP2nNxMoMRd/Gs1roXwrIxTW0mNolNibDXyVrns+582uNF3MJqFW7I5LOkQe9luucuyteDFHOM
	orgZU+uona6/w/8yTeWiezIJRKi+nLdw1e6fvRqJh/0mkfvT3HoAzXIratkah6gm2G88gYKD09Y
	ag6p+T3nORS4hl+vh7m7n1UKGVdyWnlqnIldr8DkH5OOZGcWB/xcBvb
X-Google-Smtp-Source: AGHT+IEhrosVa9kLKfF0yTd5v+2n7rNzshxcCJDg4A3X/drthxw0eliFiJIyGzq9xbcEMcaJwkIWKg==
X-Received: by 2002:a05:6a20:7488:b0:334:9e5e:c2c2 with SMTP id adf61e73a8af0-353a14b0b6cmr7184434637.13.1762697504346;
        Sun, 09 Nov 2025 06:11:44 -0800 (PST)
Received: from ajianan-Latitude-5591.. ([2402:e280:21d3:2:5455:eccf:e73:de96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bad33c801d1sm6582780a12.7.2025.11.09.06.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:11:44 -0800 (PST)
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajith Anandhan <ajithanandhan0406@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: ti-ads1120: Add driver and dt-binding
Date: Sun,  9 Nov 2025 19:41:17 +0530
Message-Id: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the Texas Instruments ADS1120, a precision 
16-bit delta-sigma ADC with SPI interface.

Why a new driver?
=================
The ADS1120 requires a dedicated driver rather than extending existing 
TI ADC drivers for the following reasons:

ads124s08.c - TI ADS124S08
 
 - This is the closest match (both are delta-sigma, SPI-based)
 
 - However, significant differences exist:
 
    * Different register layout (ADS124S08 has more registers)
 
    * Different command set ADS124S08 has built-in MUX for differential
inputs
     * Different register addressing and bit fields and conversion 
timing and data retrieval.
 
would require extensive conditional code paths that might reduce
maintainability for both devices. A separate, focused driver 
seemed cleaner.

Changes in v2
=============
Driver improvements:
- Fixed all register bit definitions to use field values with FIELD_PREP/FIELD_GET
- Moved DMA buffer to end of struct with proper alignment
- Added comprehensive comments for mutex protection
- Used regmap framework for register access
- Added all 15 channels (differential, single-ended, diagnostic)
- Used guard(mutex) and cleanup.h for lock management
- Used devm_mutex_init() for proper resource management
- Fixed error handling with dev_err_probe() throughout
- Removed redundant state variables (gain, datarate cached in regmap)
- Used sign_extend32() and get_unaligned_be16() for data parsing
- Split SPI transfers for cleaner command/data separation
- Added GPL-2.0-only license identifier

Device tree binding improvements:
- Added required avdd-supply property
- Added optional vref-supply for external reference
- Added interrupts and interrupt-names for DRDY pins
- Added optional clocks property for external clock
- Added ti,avdd-is-ref boolean flag for AVDD reference selection
- Added complete example with all optional properties
- Added datasheet link in binding description

Changes in v1 (RFC)
===================
- Initial RFC submission

Ajith Anandhan (2):
  dt-bindings: iio: adc: Add TI ADS1120 binding
  iio: adc: Add support for TI ADS1120

 .../bindings/iio/adc/ti,ads1120.yaml          | 110 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads1120.c                  | 631 ++++++++++++++++++
 5 files changed, 759 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
 create mode 100644 drivers/iio/adc/ti-ads1120.c

-- 
2.34.1


