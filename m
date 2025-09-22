Return-Path: <linux-iio+bounces-24343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F05B8F2D3
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 08:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADF917E36F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 06:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4FA2EC571;
	Mon, 22 Sep 2025 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdPZHB8E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2E4248880
	for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523091; cv=none; b=a4IhcytqqmipBPTxvsSWt7iq+5Zf0LZt3DeTVM3+L75hxro1mDHaJEUlBnXGXv7PFVBG9Ys/Xr4UTtkw3p7Ny0BQArvIayu3gk/yk8p8IpUTHb6zcTKrmnsSqh03gFmnwkRhrwP1Oc1Kbv96YREH06p7hVL/t/vR3W7LWWDLMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523091; c=relaxed/simple;
	bh=WIER8c2mKqkhk+RGmQeGAh8ClSePfIreHUbcG9aeDJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVAI+b8TxhXcIT04IhA18VgtJryNyJRw1UwYoQ4P6O1p2O8TM50URNzo5aMjdneGYT+zqGIjQcFhqCEkk4AjKDKxhNsWgBnnBmb7G/rDobhEYnYCm5FjozbePe/hTGcCNwesPnzV0AWR92PR+HP7OEltDROlZ44hqa0pKilR4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdPZHB8E; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-25669596921so41471635ad.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 23:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758523089; x=1759127889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbZxxzNbGXKFGJ3KpKcsJGk+kSH40TJzWJbjDNAzLEI=;
        b=jdPZHB8EuQ5sc9rcDdA3fqY17jIV+dKSpz3nQnj7c4YpEoDJoVcbe+RR10VufWl6y9
         ipeXo2D7BDZBGw+yDmxsvBuRfm5aAL4kXWxpQandPYe1VsVicrsIU+q5VwELIefSkpKr
         K8iwCOFFyC/QKKLnMSEbdtUWrt6uQID8JxHWpPsllaqUg8Lg3GUlRxKb+pmR9b3eMyrS
         uTCRUbwrOX2wJvAyzGDU3tLMqxpceJ9Ft0QnYmMrd6EwJXh82wFfxQQZDNCZuVahueta
         hHVJSZhWoEHtu1DaOUwY+xtS25V909wxLze1fu1+hNjiEJ0tk71lOfcjJ3gftmnTHJUn
         Skgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758523089; x=1759127889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbZxxzNbGXKFGJ3KpKcsJGk+kSH40TJzWJbjDNAzLEI=;
        b=xFMf0iFtHDggtMveB5C6vmewkQYlJDZWGjD5Q4banHVyX6bfG+v3R0/Ns36Hqv8emI
         GIgDV9nWJHxvx+SR8CI4xkjqfoaaesV0gdqmrIu99O/tEsV2tTzIYCF73tUN7i+D8oLd
         3E/UEa46iKon8YwyUeX2teWQXY0DjNZQ07gyzxYxPS5emffrMqET5n4Kig+Fm/0qmNre
         Y6lWnTB7nCX2Ul2sxtLEGwENag1NkZ6IGHbgG3r5227ex3FXjbWi44ezwOm5cQvnj7nC
         1DWpGrhGLl4WIoPxIJ2GYeoqK1VoxCs6xEe0witt5jlaQvJvuW5jORYl79KSryB7FgyQ
         p6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWqAZxKgP8MpbSzskcySQUMzzLFOhkEngTst28HX3ltv2iH5ooJtKQkEZHb7wcDQMgYeNqW41C/Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Da2XsTWQQk0mDyh3fgkKsLXk+yxD9HIOIM66y9yW9dYfTmYf
	w+WdZEIaG7HYPv8ygimEnK/E5pQgohT5VWg7c8DmgLN8XgYdooKAEayXh8kLf7k4
X-Gm-Gg: ASbGncvEYa7Xnc4WLl/hxRW6ZZp8tV8IE0IMULXiXPOu36s6fkOcXW8kWScUSvC2ZzO
	jneWH7ZZd1jQ+DJ+prK0dRTxx7DTkT0B7Z1AJBPMVd7aW22DTQqe1QwmgbD0VkDcMdls7/Uuxe8
	wuHtqfIhniHvlmc68MRK+OUbH0kZeDBJExxaYPYrfg+CPGKmB7neEz5Bk4HsIvB7R4mrjRRAk8B
	SfYa93xEL0H1Q7emJmo2pbOkhywo+H5D+mgL3K8FJUdMxppKpma0xNkj664lprh7hHnzje/EsFw
	Wxq52jcgRZMjFxKXCjg18tpBy9BA4R8rrMtTXKLOskapmK7aephAlDIXS2EzRz1N5G++7nfiDVv
	rFLnF7KWtKjpTrbQw8u1rRQ==
X-Google-Smtp-Source: AGHT+IEueJ6WL1Yk1kHKY6sJjKww7EG4lz99L2dAxOx0yuQwLDHaIcxLIKhyrFcPWMrloura1GOrSg==
X-Received: by 2002:a17:903:1b0b:b0:267:a942:788c with SMTP id d9443c01a7336-269ba3fa0afmr175389435ad.1.1758523088903;
        Sun, 21 Sep 2025 23:38:08 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033d2a7sm119488145ad.132.2025.09.21.23.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 23:38:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1BECE423FA7F; Mon, 22 Sep 2025 13:38:05 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IIO <linux-iio@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: iio: ade9000, adis*, adx*: Convert IIO subsystem cross-references
Date: Mon, 22 Sep 2025 13:37:54 +0700
Message-ID: <20250922063754.21190-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5064; i=bagasdotme@gmail.com; h=from:subject; bh=WIER8c2mKqkhk+RGmQeGAh8ClSePfIreHUbcG9aeDJM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkX3uVFTLs6y2Pf129elw0Do3dILH92auvMBWbdIuevN TUpZ1ie6ShlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEpFUYGV56Sqq4zXOpvM0s V974+kX4DL4p9+pvrth3t1FdvimAZT3D/7wSCef9YVNObxA8+P3ktHkvZrH2zPmxO8xDfNO7xey vHdkB
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Cross-references to iio_tools.rst (IIO Interfacing Tools) and
iio_devbuf.rst (Industrial IIO device buffers) are shown in inline
code instead. Convert them to proper cross-references.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/iio/ade9000.rst   | 2 +-
 Documentation/iio/adis16475.rst | 4 ++--
 Documentation/iio/adis16480.rst | 4 ++--
 Documentation/iio/adis16550.rst | 4 ++--
 Documentation/iio/adxl345.rst   | 4 ++--
 Documentation/iio/adxl380.rst   | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
index 43d4b8dc1cb72c..c9ff702a42512b 100644
--- a/Documentation/iio/ade9000.rst
+++ b/Documentation/iio/ade9000.rst
@@ -264,5 +264,5 @@ Configure RMS voltage event thresholds (requires interrupts):
 8. IIO Interfacing Tools
 ========================
 
-See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+See Documentation/iio/iio_tools.rst for the description of the available IIO
 interfacing tools.
diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis16475.rst
index 4bf0998be36efc..89a388490ab735 100644
--- a/Documentation/iio/adis16475.rst
+++ b/Documentation/iio/adis16475.rst
@@ -374,11 +374,11 @@ Obtain buffered data:
         00001740  01 1a 00 00 ff ff fe 31  00 00 46 aa 00 03 37 f7  |.......1..F...7.|
         ...
 
-See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
+See Documentation/iio/iio_devbuf.rst for more information about how buffered
 data is structured.
 
 4. IIO Interfacing Tools
 ========================
 
-See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+See Documentation/iio/iio_tools.rst for the description of the available IIO
 interfacing tools.
diff --git a/Documentation/iio/adis16480.rst b/Documentation/iio/adis16480.rst
index 4a2d40e0daa798..cce5f3e0174158 100644
--- a/Documentation/iio/adis16480.rst
+++ b/Documentation/iio/adis16480.rst
@@ -436,11 +436,11 @@ Obtain buffered data::
   00006b60  09 63 00 00 00 00 1b 13  00 00 22 2f 00 03 23 91  |.c........"/..#.|
   ...
 
-See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
+See Documentation/iio/iio_devbuf.rst for more information about how buffered
 data is structured.
 
 4. IIO Interfacing Tools
 ========================
 
-See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+See Documentation/iio/iio_tools.rst for the description of the available IIO
 interfacing tools.
diff --git a/Documentation/iio/adis16550.rst b/Documentation/iio/adis16550.rst
index 25db7b8060c421..c9bbc0a857b03b 100644
--- a/Documentation/iio/adis16550.rst
+++ b/Documentation/iio/adis16550.rst
@@ -366,11 +366,11 @@ Obtain buffered data:
         0000ceb0  00 00 0d 2f 00 00 05 25  00 00 07 8d 00 00 a2 ce  |.../...%........|
         ...
 
-See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
+See Documentation/iio/iio_devbuf.rst for more information about how buffered
 data is structured.
 
 4. IIO Interfacing Tools
 ========================
 
-See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+See Documentation/iio/iio_tools.rst for the description of the available IIO
 interfacing tools.
diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
index afdb35f8b72e78..bb19d64f67c3d2 100644
--- a/Documentation/iio/adxl345.rst
+++ b/Documentation/iio/adxl345.rst
@@ -433,11 +433,11 @@ Obtain buffered data:
         00000f0   00004   00014   00015   00005   00012   00011   00005   00012
         ...
 
-See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
+See Documentation/iio/iio_devbuf.rst for more information about how buffered
 data is structured.
 
 4. IIO Interfacing Tools
 ========================
 
-See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+See Documentation/iio/iio_tools.rst for the description of the available IIO
 interfacing tools.
diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
index 66c8a4d4f767e5..61cafa2f98bf36 100644
--- a/Documentation/iio/adxl380.rst
+++ b/Documentation/iio/adxl380.rst
@@ -223,11 +223,11 @@ Obtain buffered data:
         002bc3c0  f7 fd 00 cb fb 94 24 80  f7 e3 00 f2 fb b8 24 80  |......$.......$.|
         ...
 
-See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
+See Documentation/iio/iio_devbuf.rst for more information about how buffered
 data is structured.
 
 4. IIO Interfacing Tools
 ========================
 
-See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+See Documentation/iio/iio_tools.rst for the description of the available IIO
 interfacing tools.

base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
-- 
An old man doll... just what I always wanted! - Clara


