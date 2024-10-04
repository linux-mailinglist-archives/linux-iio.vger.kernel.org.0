Return-Path: <linux-iio+bounces-10157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438B9911B2
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 23:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82341C21CE0
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 21:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE3C13698E;
	Fri,  4 Oct 2024 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Jzbd2nIU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CDE1D89E1
	for <linux-iio@vger.kernel.org>; Fri,  4 Oct 2024 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078536; cv=none; b=k6VFqyq0juR6jCvopH5qiNtaNj1tIlWn+I8FbTaZAzXuM9oR6DIf1uOK3LxUdr8yEbHX76FO9TUi1I1sfqsvYhxnfYDcoDWN2sFrKeAvjzcEaIS3u1h8lvS7+qFDDkmfPl8Fe48DAyzJwkwOkuHQq87133DzhYGYxhtoFRxh75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078536; c=relaxed/simple;
	bh=5Ycpog1y0e3qZRjWPMcOyX7VO13ZytSC6dJsgRajg3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l8U7PMirUlXYoq4cgNYwz73xPyzk1rjVA3jSw0PAg27FsaMokXOkdjcdHwA4ZSvnZhEnEQ4qYNKq0zKPRy/GdLkQL+P+LSTR/dYOCIttIsTbtV71VWN74gUQQlmJEJnsUv4w/kUzoVVajvHu0qrZDFj/VNmUJ85VVBJHVutQmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Jzbd2nIU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so22508375e9.3
        for <linux-iio@vger.kernel.org>; Fri, 04 Oct 2024 14:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728078532; x=1728683332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okScCkfMzGgedKYFN2GyI9KcfEQ5eNPKFeZu3bGaiC0=;
        b=Jzbd2nIUne4lFi9dSUxNJS0oZFjhni8Bb8BJsEdTLRFRKPYrr05O0b5Vp7X2U/nHu6
         bx/Lo6d4VmUOB2LfEaCTFQe7hlmH02hRhAogBsQQSTfZ7nbjlSMe4q9Pwrzot1iPzvX7
         3XBAIJatpGpgOhxJM75JZbSFhPKFVC2tU92qLg1xCoNXHItXvOk5CCk47HHIXgci/2Eh
         QjcAsScj4EWabOMnl2vfFGwsMJtp2EMGP3VrER0IFidZUTMJ0r+OtV/LFlcvvcODk1+z
         vId40RegUaNO6wjl+VZU2cqOH/3r9SZExMXtbWOvICXJSDo5JCfUEwUBojpEqgsk7bff
         9b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728078532; x=1728683332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okScCkfMzGgedKYFN2GyI9KcfEQ5eNPKFeZu3bGaiC0=;
        b=mN+8MIR5peZhcbTTsLMNfMsQ8mLlfLYXNfjP/0lRY89s0BZrAPeFhnKl5kFm3SrkGd
         PNstbYEBzBWRnwoNA4Mo1qM0qZlbXlmBriAbz/wVCZZiAdYtuBomJbb1WBQZIwLrNu0y
         8WARVeNXj0zBC9GGX257cFgdnMIUER1EycVqYyCyePDnkKXwa7CKnH2MZH6YbOMvULvQ
         KqcH6iMiCVOMJqPItUSv5RZV1tuJZ6k6y2zJFTIwlt93pbCIl7oICJZ8lawR63FKy+Qw
         cBKrePOh8QEYlMTN5ezqZqDJCYP2CNJHLRFdm8An+zuvdsSEZPoL5xTbmOHPlnqSaYjW
         wgwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFDaYHVdVOWIEtYNkbasjRfBsnuUkJdoYaFVCvEGmdnhWcasct0a9nFXoyAg1o62zNoqyQklhz2cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHN3LzOQtSkAgbLiyBu8tlUsvISWnf+cpVu1lxkmrYGLkPYAV
	phiyWppw1MUUSDsrHh9SzUxwhN28+qyerPt7bdRcHHa9hsUP7qXrm0WYfeusK1A=
X-Google-Smtp-Source: AGHT+IH/aDnr0Lb84keonMSILnv9Q4qkD3NNA7237N3xWpGCLK+u5jL/aJvh6q1g7ZpNSr4f4/nDqA==
X-Received: by 2002:a05:600c:5123:b0:42c:bd5a:945b with SMTP id 5b1f17b1804b1-42f85ac909fmr31454125e9.21.1728078531845;
        Fri, 04 Oct 2024 14:48:51 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4ab63sm24680375e9.40.2024.10.04.14.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 14:48:51 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 04 Oct 2024 21:48:39 +0000
Subject: [PATCH v3 05/10] iio: adc: ad7606: Sort includes in alphabetical
 order
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-ad7606_add_iio_backend_support-v3-5-38757012ce82@baylibre.com>
References: <20241004-ad7606_add_iio_backend_support-v3-0-38757012ce82@baylibre.com>
In-Reply-To: <20241004-ad7606_add_iio_backend_support-v3-0-38757012ce82@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728078523; l=1822;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=5Ycpog1y0e3qZRjWPMcOyX7VO13ZytSC6dJsgRajg3E=;
 b=iyd18HM5iYsjPSUVsDwv80YQI2sNtNIKcU6HziJHtPsbJ9TUXE6mspgK0fmvolO8PKyGQN1a1
 M9OmZJyhEtdDgFpGOlwcMR6/P95etqcdNDci9LQWHvTTO50azPkbb2i
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Some of the includes were not in alphabetical order, this commit fixes
it.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 2 +-
 drivers/iio/adc/ad7606_par.c | 6 +++---
 drivers/iio/adc/ad7606_spi.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index ffa551a4e41d..d1aec53e0bcf 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -19,8 +19,8 @@
 #include <linux/sysfs.h>
 #include <linux/util_macros.h>
 
-#include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index 02d8c309304e..d651639c45eb 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -5,13 +5,13 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
-#include <linux/err.h>
-#include <linux/io.h>
 
 #include <linux/iio/iio.h>
 #include "ad7606.h"
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 143440e73aab..d12e55123888 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -5,10 +5,10 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
-#include <linux/err.h>
 
 #include <linux/iio/iio.h>
 #include "ad7606.h"

-- 
2.34.1


