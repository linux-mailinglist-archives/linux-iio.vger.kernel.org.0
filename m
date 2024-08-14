Return-Path: <linux-iio+bounces-8460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E916395179A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 11:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E36283452
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F896144D21;
	Wed, 14 Aug 2024 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dnWNNPyk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6799143C5D
	for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2024 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627597; cv=none; b=Wc9lY4BdGt3TN4SJ7SmqkUIgrLWzHkURd+miC0w1nC0ORGF/NjfgVhn40oedZRhi3Li2mCWKGCz7n+P6HY1/8PyQQsOIlHJq6Zkr3LmI6poAw7+LKmXDfhF6LTz6v5XT4cyykLJ9S1W7m15nWxyDGpZrJpM1yObjao5xwgurY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627597; c=relaxed/simple;
	bh=XSd3GC/vD6GigFRdUJdwPYvqWhn/hvMNDJd+SrcI9DY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOdYnLpTB88OQutaSIPtKfhqBvZWx73wdcZO0g3bL0JP6aXvksKBKcjheCl2clYBgQw0gVJoj9IzVCTlzMHVBDd4WIExn0y6/xvEctycKZEDJDw6ag3O1hU8B1/eitXCJ2Pj9AwiVyBOn0OvFqY0db9I2xepPFij0ymVBNTS3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dnWNNPyk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so44583395e9.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2024 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723627593; x=1724232393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWFR1dplhqturIHla+8uDdf1jPTzY9s8gn8hBPScqFE=;
        b=dnWNNPykRvB1LtbEuToqFPdxu9fbVJ0iTH6/j/ziqNH2sZjyx/qY24KXweAZYnGyXR
         6SOkenf2Gw6xAYfHsZwnLMszPGL56U7+0cOcnWbyvx68koJkevwam3rYkp8P9SwLiqID
         LDNZM8l2yXmjb+1ZyqWGW2Ot8uwSLzpTSQcn3iubtrocWf/Ov00dO4uEyq2trQRl7zD8
         Hkgh6Ax4ymKxpHV+8KyW+dlmgZSDzxXkIEJ5RoXyQxfiR1s2+BXLQPtR6gjp2ZkhycU7
         MyamQVXrXJWWaAaMx/aSxeYutmnCf+KcbbiT2lQEUyNGTYyaQVf+dFjGwEYfrWEAiF+r
         XPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723627593; x=1724232393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWFR1dplhqturIHla+8uDdf1jPTzY9s8gn8hBPScqFE=;
        b=GBI5nS+Cd9cDeWtB1rEsIgdGpgg4Uq3/TlYadEQOdkljdxenEkMNoA85EsPKLhm69R
         2erLCRNresbCPVO4HtKnQ0pb3m6ploqTZhRImH7a/J6D/wnGxQds+njA1GkmfhIPTozq
         jdxa4Y4HBWdNwOMJN3Mlavg6FSdbx4RGsPIniBIPvSTAnm60FmCVJrSCWooIno2BXpcF
         L5dluaVn5XYjkYE0cIcS1/ylkIVkzSclZwntfoy44JaFZ8OmqCiU7gubJ+dF1AQ5YtdF
         2Gae41tmeBDZxSssJcqYd823+5xfgHHd5BCI3sCmWuUo6XQ/PqVMziGt+Y1XoObZlKKq
         IBFw==
X-Forwarded-Encrypted: i=1; AJvYcCW4eFtbZ5V0jNKma1JSK0ViYvdyWC4gvqmDjX15yekfWfrPZgSlxBni1HJsU73ee7H4u6g06ZrXOLlgie0iB1YGZNtsloss1yYL
X-Gm-Message-State: AOJu0YzjG3AGZ4byRkuu+phi6fuUcXj0oBUzyBskKVNfF/dVLSn2LY9Q
	cA5g7srCB66A+uvNBxvNyuKKhb/VhatfI6zxBoHW7BwroJ8ptuEzjQikglWYiug=
X-Google-Smtp-Source: AGHT+IEAGyFBL2pBSyxaBNonkxJ5lI432QOs6vR7Pu05vSXCEXdHgmHgADCTB9ybYJXCbAOKll2+aQ==
X-Received: by 2002:a05:600c:4455:b0:426:6416:aa73 with SMTP id 5b1f17b1804b1-429dd2364f4mr14857245e9.12.1723627592824;
        Wed, 14 Aug 2024 02:26:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9e78:fb96:21f1:335c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded80241sm13846895e9.48.2024.08.14.02.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:26:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] iio: dac: ad5449: drop support for platform data
Date: Wed, 14 Aug 2024 11:26:29 +0200
Message-ID: <20240814092629.9862-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no longer any users of the platform data struct. Remove
support for it from the driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/iio/dac/ad5449.c             | 15 ++---------
 include/linux/platform_data/ad5449.h | 39 ----------------------------
 2 files changed, 2 insertions(+), 52 deletions(-)
 delete mode 100644 include/linux/platform_data/ad5449.h

diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index 4572d6f49275..953fcfa2110b 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -20,8 +20,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include <linux/platform_data/ad5449.h>
-
 #define AD5449_MAX_CHANNELS		2
 #define AD5449_MAX_VREFS		2
 
@@ -268,7 +266,6 @@ static const char *ad5449_vref_name(struct ad5449 *st, int n)
 
 static int ad5449_spi_probe(struct spi_device *spi)
 {
-	struct ad5449_platform_data *pdata = spi->dev.platform_data;
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct iio_dev *indio_dev;
 	struct ad5449 *st;
@@ -306,16 +303,8 @@ static int ad5449_spi_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 
 	if (st->chip_info->has_ctrl) {
-		unsigned int ctrl = 0x00;
-		if (pdata) {
-			if (pdata->hardware_clear_to_midscale)
-				ctrl |= AD5449_CTRL_HCLR_TO_MIDSCALE;
-			ctrl |= pdata->sdo_mode << AD5449_CTRL_SDO_OFFSET;
-			st->has_sdo = pdata->sdo_mode != AD5449_SDO_DISABLED;
-		} else {
-			st->has_sdo = true;
-		}
-		ad5449_write(indio_dev, AD5449_CMD_CTRL, ctrl);
+		st->has_sdo = true;
+		ad5449_write(indio_dev, AD5449_CMD_CTRL, 0x0);
 	}
 
 	ret = iio_device_register(indio_dev);
diff --git a/include/linux/platform_data/ad5449.h b/include/linux/platform_data/ad5449.h
deleted file mode 100644
index d687ef5726c2..000000000000
--- a/include/linux/platform_data/ad5449.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * AD5415, AD5426, AD5429, AD5432, AD5439, AD5443, AD5449 Digital to Analog
- * Converter driver.
- *
- * Copyright 2012 Analog Devices Inc.
- *  Author: Lars-Peter Clausen <lars@metafoo.de>
- */
-
-#ifndef __LINUX_PLATFORM_DATA_AD5449_H__
-#define __LINUX_PLATFORM_DATA_AD5449_H__
-
-/**
- * enum ad5449_sdo_mode - AD5449 SDO pin configuration
- * @AD5449_SDO_DRIVE_FULL: Drive the SDO pin with full strength.
- * @AD5449_SDO_DRIVE_WEAK: Drive the SDO pin with not full strength.
- * @AD5449_SDO_OPEN_DRAIN: Operate the SDO pin in open-drain mode.
- * @AD5449_SDO_DISABLED: Disable the SDO pin, in this mode it is not possible to
- *			read back from the device.
- */
-enum ad5449_sdo_mode {
-	AD5449_SDO_DRIVE_FULL = 0x0,
-	AD5449_SDO_DRIVE_WEAK = 0x1,
-	AD5449_SDO_OPEN_DRAIN = 0x2,
-	AD5449_SDO_DISABLED = 0x3,
-};
-
-/**
- * struct ad5449_platform_data - Platform data for the ad5449 DAC driver
- * @sdo_mode: SDO pin mode
- * @hardware_clear_to_midscale: Whether asserting the hardware CLR pin sets the
- *			outputs to midscale (true) or to zero scale(false).
- */
-struct ad5449_platform_data {
-	enum ad5449_sdo_mode sdo_mode;
-	bool hardware_clear_to_midscale;
-};
-
-#endif
-- 
2.43.0


