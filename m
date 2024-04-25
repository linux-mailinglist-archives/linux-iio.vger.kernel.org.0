Return-Path: <linux-iio+bounces-4516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A8C8B238F
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 16:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D48D6B29EDC
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A6714A08B;
	Thu, 25 Apr 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W+8WZm8/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012E149DF8
	for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054217; cv=none; b=t2YSuV6o4ukNTj5LOICZ+nYcG92VjEnOp67ztiWZJMv+iIIWRn831PtPJ2dFk3/mRhYZw6Ib3iukZd8MxkE8zy7x3S3tTpumPN+g571k7d9FcZkBQgEOIwcDGZDiTQeB82Pv9/NO9998XUyeY1YbpK7gDbYaSmcRTgEmiMB+tCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054217; c=relaxed/simple;
	bh=3+clKuK8T/NHDacBXfosQNEM1KFC8ae6n+yXxooI6VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hoGEds273pnIpRYqpplesh6BSts6kNaaF2WC+Nbi9XrYo9IrUI7H8gBqUxhgn9Pgg9sY+F2AzaeMZG924QOLqVjIsXtSZIy/2QEmR9Vl8qYIigrp40jtx9qpVqgMcfxu5Y7d+j256zPCc5aYFxT5rzgvqMTroPTXzniwH14GXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W+8WZm8/; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-23335730db1so516781fac.2
        for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714054214; x=1714659014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teJq6nyJn4fxkVEcWVvz9Z8byUXbzOYcuXPlhjJXF6A=;
        b=W+8WZm8/DgEMh08Lx76RK28jbIyQv6an/xgaoXLoeSA/0G6JRbT/Ieer6UJS9rqg3E
         T8CGH3J3oh+exDlpUESYTZrVkxT60PAtWSkG6C9xfPH/0kYWu7OXU4tboZULHepEqGTj
         D2S59RoTuOO2K5WH0STWqM/FIenSt6eE0ib37Q1MDplvN4ctvO36BTkmcRsp9caTeyPs
         JOkE3MDUo6nI/XnpEvg3d4HkKTaUXd8mYY1+/kHAt3439hGn9IZh2SvUIs6FNjIVpNtC
         Wvxt5EXbsqFEPZTSdkHZsL8GHpihjWRFH227+P6MOL7hvB4rQ8CtPaHy+NqJ5hNytq5Q
         +N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714054214; x=1714659014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teJq6nyJn4fxkVEcWVvz9Z8byUXbzOYcuXPlhjJXF6A=;
        b=MnMmB8DBN8hQe4toz3gI4+zk7G4IDp7+0QmKptANzhwmVWJpMI3GIVbeu6Gy2xpqk5
         BjHsHJZGors65Q3k4Gqtdu/f6tPSo5vvXJBpTEYk7DGeBl1E9s9cJzhISQw/ZIbaEFV4
         HcOjXc3A+tMCG8gbRHHAFly/cwR+ba3/MuIB8GSV1ceKSho1A5mJISvOmWfUQwz9Aqem
         Kmbv+JWqFwGnKagq6rzOs4GGbN61wNazx6EhwoMYRCVt+pjLmM9aUZFNgqTjQziHXbNs
         MDLBO/qPEQJyEAMeuICeJW42UMAxcUAt/0cyZSDb7mDqWlhlcpMxl2/EDV9/afG2MxPT
         zgUw==
X-Forwarded-Encrypted: i=1; AJvYcCW8obpReAz4R/RBBZJZCTBGZp9KySof7U/sHrp6RvfFfntsofbIPJO0rkerhuakzgzQe8vnKw8qgq2PGsLX4utzzgdCaVl12nCN
X-Gm-Message-State: AOJu0YxjaYehcsWL6QncDINkhTRciliBCEGPV7Pi+iq+0cuWL7QlUHAP
	vHKT4lxgPuTc9OJG2ROJQc1HDDVNDzSBHuTaUJtueKHtovrtF4vMxYNvfeR9MnA=
X-Google-Smtp-Source: AGHT+IEcYQByXnCzw/YwDQrWCBNLbT6nrYCmIlYDyJNIh6cduxpoeD3kRx7i8oDLrwiJgVy9yp+Www==
X-Received: by 2002:a05:6870:c08e:b0:22e:b736:786d with SMTP id c14-20020a056870c08e00b0022eb736786dmr6862632oad.31.1714054214583;
        Thu, 25 Apr 2024 07:10:14 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id pz8-20020a056871e48800b0023b5203fc58sm294786oac.37.2024.04.25.07.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:10:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/2] docs: iio: ad7944: add documentation for chain mode
Date: Thu, 25 Apr 2024 09:10:00 -0500
Message-ID: <20240425-iio-ad7944-chain-mode-v1-2-9d9220ff21e1@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240425-iio-ad7944-chain-mode-v1-0-9d9220ff21e1@baylibre.com>
References: <20240425-iio-ad7944-chain-mode-v1-0-9d9220ff21e1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Add documentation for chain mode support that was recently added to the
AD7944 ADC driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/iio/ad7944.rst | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/iio/ad7944.rst b/Documentation/iio/ad7944.rst
index f418ab1288ae..0d26e56aba88 100644
--- a/Documentation/iio/ad7944.rst
+++ b/Documentation/iio/ad7944.rst
@@ -24,7 +24,7 @@ Supported features
 SPI wiring modes
 ----------------
 
-The driver currently supports two of the many possible SPI wiring configurations.
+The driver currently supports three of the many possible SPI wiring configurations.
 
 CS mode, 3-wire, without busy indicator
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -68,6 +68,27 @@ CS mode, 4-wire, without busy indicator
 To select this mode in the device tree, omit the ``adi,spi-mode`` property and
 provide the ``cnv-gpios`` property.
 
+Chain mode, without busy indicator
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+                                                                 +-------------+
+                  +-------------------------+--------------------| CS          |
+                  v                         v                    |             |
+        +--------------------+    +--------------------+         |     HOST    |
+        |        CNV         |    |        CNV         |         |             |
+   +--->| SDI   AD7944   SDO |--->| SDI   AD7944   SDO |-------->| SDI         |
+   |    |        SCK         |    |        SCK         |         |             |
+  GND   +--------------------+    +--------------------+         |             |
+                  ^                         ^                    |             |
+                  +-------------------------+--------------------| SCLK        |
+                                                                 +-------------+
+
+To select this mode in the device tree, set the ``adi,spi-mode`` property to
+``"chain"``, add the ``spi-cs-high`` flag, add the ``#daisy-chained-devices``
+property, and omit the ``cnv-gpios`` property.
+
 Reference voltage
 -----------------
 
@@ -86,7 +107,6 @@ Unimplemented features
 
 - ``BUSY`` indication
 - ``TURBO`` mode
-- Daisy chain mode
 
 
 Device attributes
@@ -108,6 +128,9 @@ AD7944 and AD7985 are pseudo-differential ADCs and have the following attributes
 | ``in_voltage0_scale``                 | Scale factor to convert raw value to mV.                     |
 +---------------------------------------+--------------------------------------------------------------+
 
+In "chain" mode, additional chips will appear as additional voltage input
+channels, e.g. ``in_voltage1_raw``.
+
 Fully-differential ADCs
 -----------------------
 
@@ -121,6 +144,9 @@ AD7986 is a fully-differential ADC and has the following attributes:
 | ``in_voltage0-voltage1_scale``        | Scale factor to convert raw value to mV.                     |
 +---------------------------------------+--------------------------------------------------------------+
 
+In "chain" mode, additional chips will appear as additional voltage input
+channels, e.g. ``in_voltage2-voltage3_raw``.
+
 
 Device buffers
 ==============

-- 
2.43.2


