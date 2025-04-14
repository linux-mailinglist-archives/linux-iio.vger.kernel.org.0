Return-Path: <linux-iio+bounces-18095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED0BA888E9
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8FA1899D0A
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB72798F4;
	Mon, 14 Apr 2025 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0WUev78"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDA25C6E6;
	Mon, 14 Apr 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649309; cv=none; b=HJG1zzXSNVkwvvZJdMGbnZ0byn2C+ChpnaJgpP9XwQUAAzltFgOrM8m33p43GdsRbC1baq0IRaI6V3cwvl8U6O/CkFM3JdxJaOC6zGLsQ7Y8ejjnhTPJA9d7eD6gwxI0wfhCLvrmW7tdrNOUnfrVjmB40et5EHL6lR1CmxVsCYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649309; c=relaxed/simple;
	bh=IMPpmSGNgTERs/O4E0W84aAiLk4GyRsj/gZ9lKv00ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FrXqW7F/VHwRZ2UjhNGc6G6PfTkyk2jnN3LBudIwe94bPLMFcUjA7XTmeejQd6jaHGI6zRheDuFj/YvUffr4okC3gEOiBXfKOFvfMB0EezJhSIr2/TwJLUsnLvhhv4/pJKHGZLn32ph4jqax6+ezCR3O9STIHzkJinFhU4ukXMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0WUev78; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso1335928b3a.0;
        Mon, 14 Apr 2025 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649306; x=1745254106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODC2OMPiIrGbg/DjmPjdt1iuNoNfGR/iB3ClA/te5kQ=;
        b=C0WUev780+CHIeYsUv66yRGUpBRrryS0gtwnQ6rf+se2cFwg1z522f7lkXFwV1VTta
         PYHRZ4uQsoPjNWHypG4RI2ihc5yNimGC4b1kHKjIOdfr9kH9Fa+KUX8mIWe3e9rS2hi8
         6ps0YrBvDInIugWwjyXlEVVrThXmbhIxwz14wrUAOu2o1hfBwAfvWV1Lzw6guD2tMspb
         Fh3yB4e3jE3Kn4E46D4vmzL5ZLsmF4/h7HPFu52YDE76jqDYGmdu1J0V2ydtYcBbuWA+
         SQj9caINfC84/Kb1UdrL6M8wu+j1Rsut8pD8n5/2qhWL5WbwSWp5AEabaO8y36UxGOvr
         8FZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649306; x=1745254106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODC2OMPiIrGbg/DjmPjdt1iuNoNfGR/iB3ClA/te5kQ=;
        b=aRJx6lxb0h2KudvLbhzVwnf25mkUxqMi4FCtUnwrfHp9i6A5Bq/a5JOW8adx6rioyF
         mnGWFArKqemiAlfJA+U0J3gZBOqkTCh/2vkCN1RVUp3I3dyoIZmnJiOxUYLSDI6TwWnj
         gx4VcYXLA7iiJfb33JNsKhMbgetKJsLoE0utzfG0hTew8QMCuvrmaPN6d0WTeNR9jTX5
         wZQgEwzgym3iluVghbMS1fPdbXkQFU3cEJKvBZpKfRnmEK45x+PFkCY3BUTG08W7Cyp4
         8iuPlfSXGrrAN+LAFkwGyL3BLs6Sl5OsQJlyN2sFDiJ8c6rugSUfn+jD2xkcg+IWX+eX
         W1Kw==
X-Gm-Message-State: AOJu0YyPd+mJA8diNGOmNBFN1TYssZh65dFYwNV0HyPAeqYBu4a3yu6d
	W5qPE8QWPyS5Z37fMXxWR/Cuy3rVVQPKszYYtWsEAZCVkJ6U/V7ifrRMmRwYXxY=
X-Gm-Gg: ASbGncuqhT4GLokwvgP+Wm0LMYTH3k/0iCkB3nvQC8pVy6yiQEguKutWuxWrLWthnrT
	xoLx5NsMUAKJ+tRpaynOrooRSGu1T4r/1MBmRs986h+4kFBM/Kya42Ly+iFGe3EqvKOkkqEGZ3a
	3FwUdKx7/KqAUan0OI1rh7bNETDLVKCGb4dYn0AxHCczKqm1agWUkp5v3lDLtgPns6XF3BJKZLz
	KBPoGpRyEGm8DKfCLULlpugQk8EPpXofMFJABbHxsgld6gIkBY1H4eASYwLwR/c2101jUy32pxv
	AhRGkNYoT2Tn0wZKbJoJ1uQ3wptjPjnKEjofDA==
X-Google-Smtp-Source: AGHT+IGQPFkuLvBdIXu8RgihuXeeTxJXEaC3yFUvhcm0uj/MhC9/nUyCI3fWNBm+MqTxe/husNsVXQ==
X-Received: by 2002:a05:6a00:1414:b0:736:57cb:f2b6 with SMTP id d2e1a72fcca58-73bd11fe7d1mr16905267b3a.12.1744649305880;
        Mon, 14 Apr 2025 09:48:25 -0700 (PDT)
Received: from fedora.. ([2405:201:f022:f80b:bc98:df72:df5a:60fa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c5f51sm7084351b3a.56.2025.04.14.09.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:48:25 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	marcelo.schmitt1@gmail.com,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH] Documentation: iio: Document ad9832 driver
Date: Mon, 14 Apr 2025 22:17:49 +0530
Message-ID: <20250414164811.36879-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Analog Devices Inc. AD983X chips will benefit from a detailed
driver documentation.

This documents the current features supported by the driver.

Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 Documentation/iio/ad9832.rst | 119 +++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/iio/ad9832.rst

diff --git a/Documentation/iio/ad9832.rst b/Documentation/iio/ad9832.rst
new file mode 100644
index 000000000000..a3a58569ff89
--- /dev/null
+++ b/Documentation/iio/ad9832.rst
@@ -0,0 +1,119 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+================
+AD9832 driver
+================
+
+Direct Digital Synthesizer driver for Analog Devices Inc. AD9832 and AD9835.
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD9832 <https://www.analog.com/AD9832>`_
+* `AD9835 <https://www.analog.com/AD9835>`_
+
+The AD9832 is a numerically controlled oscillator employing
+a phase accumulator, a sine look-up table, and a 10-bit digital-
+to-analog converter (DAC) integrated on a single CMOS chip.
+
+Supported features
+==================
+
+SPI wiring modes
+----------------
+
+The driver currently supports the following SPI wiring configuration:
+
+3-wire mode
+^^^^^^^^^^^
+
+In this mode, communication occurs via SCLK, SDATA, and FSYNC signals.
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |       FSYNC |<--------| CS/GPIO     |
+    |             |         |             |
+    |    AD983X   |         |     HOST    |
+    |             |         |             |
+    |       SDATA |<--------| MOSI        |
+    |        SCLK |<--------| SCK         |
+    +-------------+         +-------------+
+
+
+Channel configuration
+---------------------
+
+The AD9832 features two frequency registers (FREQ0 and FREQ1) and
+four phase registers (PHASE0, PHASE1, PHASE2, and PHASE3).
+The selection of which of these registers is actively used to generate
+the output waveform can be controlled in two ways: via external pins or
+via internal control bits.
+
+* Pin Control: The ``FSELECT`` pin determines whether FREQ0 REG or FREQ1
+  REG is used.
+* The ``PSEL0`` and ``PSEL1`` pins select which of the four PHASE registers
+  is active.
+* These pins are sampled on the rising edge of the master clock (MCLK).
+* Bit Control: This is utilized by the driver for the selection of the
+  frequency and phase registers can be controlled using internal bits.
+* Bit D11 (within a control word) can select the FREQx REG, and Bits D9 and
+  D10 can select the PHASEx REG.
+
+The source of control, whether from the external pins or the internal bits,
+is determined by the SELSRC bit (Select Source bit, D12) within a control
+register.
+When SELSRC = 0, the pins are used for selection, which is the default state
+after the CLR (Clear) bit is set high. When SELSRC = 1,
+the internal bits are used for selection.
+
+Synchronization
+---------------
+
+The SYNC bit (D13) determines how the reading of the FSELECT, PSEL0, and
+PSEL1 pins (when SELSRC = 0) is synchronized with the master clock (MCLK):
+
+When SYNC = 1: The reading of the pins is synchronized with the rising edge
+of MCLK. This ensures the inputs are valid at the sampling instant, even if
+the setup and hold times are violated. This mode introduces a latency of 8
+MCLK cycles.
+When SYNC = 0: The sampling occurs asynchronously, and the latency is reduced
+to 6 MCLK cycles if the timing characteristics are met.
+
+The SYNC bit is particularly important in applications where the timing of
+register selection changes is critical or when interfacing with control systems
+that may not strictly adhere to the setup and hold time requirements.
+
+Power Supply
+------------
+
+The AD9832 supports separate power supply pins for the analog and digital
+sections via the ``AVDD`` and ``DVDD`` inputs. Both pins support voltage
+ranges from 2.97V to 5.5V (5V ±10% or 3.3V ±10%).
+
+Proper decoupling is critical: both AVDD and DVDD should be decoupled with
+0.1µF ceramic capacitors in parallel with 10µF tantalum capacitors to AGND
+and DGND respectively.
+
+The device also supports a low power sleep mode, reducing current
+consumption to 350µA maximum. When powered down using the power-down bit,
+power consumption is reduced to 5mW (5V) or 3mW (3V).
+
+Reference Voltage
+-----------------
+
+The AD9832 supports using either an internal 1.21V reference or an external
+reference voltage via the ``REFIN`` input.
+
+If ``refin-supply`` is present, then an external reference of 1.21V nominal is
+supplied to the REFIN pin. If not specified, the internal reference is used
+and is available at the ``REFOUT`` pin.
+
+The internal reference has an accuracy of 1.21V ±7% min/max across the full
+temperature range (-40°C to +85°C) with a typical temperature coefficient of
+100 ppm/°C. The REFOUT pin should be decoupled with a 10nF capacitor to AGND.
+
+For applications requiring reduced wake-up time at low power supplies and
+low temperatures, the use of an external reference is recommended.
-- 
2.49.0


