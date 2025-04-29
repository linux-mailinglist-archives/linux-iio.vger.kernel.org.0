Return-Path: <linux-iio+bounces-18807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF2AA001A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 04:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127C5467257
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 02:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FBD29CB4A;
	Tue, 29 Apr 2025 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsHy5PQQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E7CC148;
	Tue, 29 Apr 2025 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745895316; cv=none; b=uWg05ShPKZXtLO8ajrjyYYDu4I28+sSGEgRSyBBKCFYSn/bAoGYw9ln4kiYrFzvTqn7vonf18lXITamlPDIrjp3IVyiYysuipnh/rnlr/lMXYQIH9anTpkZ6QxTup/ygZnyRLdLoyY4EGVnu2sDqqAMRHcLDEOqxWJstSUzo0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745895316; c=relaxed/simple;
	bh=4nzf+tieOu9e4G/3UrPKYMyCkGKYuCIODdEfrxhWjIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BRIGgRyaxGNgCfTQpRb7yp8ne5x2lLFNR3SfuxgIQ/WJOa8DLUUchXIuvG2MihASqSwUmITguxUo1LACNlVEKnmmpdT2d8PWBjF5aQkBVx7L3jIXgfxEP0GWYttYCs41ulk2eb8Hj9NEUADveAQFBRV+4j9M0STxRDxjMc0EBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsHy5PQQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7376e311086so7409249b3a.3;
        Mon, 28 Apr 2025 19:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745895314; x=1746500114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7JckEDRHtba6/m8QpSb/VSM1gjvc14dWKrAI4nTnis=;
        b=hsHy5PQQfiVtGAO7Ql3AQaNoEB3qO2QS1vKwWRdsZlKU8O7wm2dzn13AIFQ7C9iaRE
         HQbkZyJH/1NNztPk6m+aAb8TLMeRz/qJYPprHhJZftXvLu7JRZTdoNOLJE1u8jt23oX+
         UHyEQGPMUriak1XgawN9IpQzGEiiSQk3P60FpDKra+aPqofpy90BQXwulFVJm3iaik/9
         LOb9CZtTOzM61rtre4JxQgMwBb16VEo9zJ7pgwIQcbIwsr14lUrmISw19Yw3ftvDX0GI
         Y7EP/O2lq/tXFKbGZ8QawDoxl4gGC4AhhDrm9bqsDndaWcBsh1r/I+W44/Hm1iqrbkyl
         5FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745895314; x=1746500114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7JckEDRHtba6/m8QpSb/VSM1gjvc14dWKrAI4nTnis=;
        b=hRMwuAAPCsaIhfKqGIrziDQEEBsTrEJAFMZUVf+kLUBL/vUEOEmubmyuRiRtCiSn29
         2TgwnK36+jD4eRj3X/E63mcF3hCUq4MX3preojXCF3rEQ3uM7TMSZgoIkxTmsTsmXXNq
         TXVR0qB9jU77zVjY7vWRtEzqeNjmqR6i8L+5Nwu71Z33dK20sjJyTjTKEcYwfkOXaJ0q
         uSS+PHo9+QB7qjSKqEDNyrBvHN7/io/PCuiOrU2VXoYZSsmH5n2iI3fPW5SBuSluW9bQ
         /M01FkKyYHNjAGQ5NzL+wW0Xw1zjK1BQam1k8ALLuelotlPsixedf2FxFg2wDpxDtALq
         PW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8ojWPzS/Qd7rLmTQNjxRo6u2EjhgH4wRQu3Cby1RLH7AzGsejGjDuFy4z9MyTJP2V/++EK849bmJTSeYd@vger.kernel.org, AJvYcCVsRjMlhGw4JZjb5Pb6W/z6qrzawR5zDyv6ObfthsBnJ1GsAMxCV2hDnLNA5Jw+SiFfD1aKTIexKA5W@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PHxk/IP0CsJKuyB/s7HdsJEwOc/98xoMNrDHxyyUV1I323l0
	0YuwMtakMms7En9A0wrL2fwt4A/mcAMx7PkkxSUqbB3B6wlYdJSM
X-Gm-Gg: ASbGncvOTTQAD/HuaYHkHIX1zGSVuDrzQi96AxOxkA6vdk/lAGmJaOAG+BMpco4tQ6b
	4kfuvhULrx0FhHc+bssp2allIP0IzXmW80PAduc6vvpcC9/B4+mUDzPY5dQpdBz3X/4kX0WPttj
	ty2eJFq858jTBjdy/E6UCVuSce5OElt8pzkykBH7d5WEH5K9gwZnOXXl6TMLv0I9Yxc4rH1wgnl
	XWKMDuGqRmn+IxgbdRsowa1wTZvaQpTOqvjfyH7SPHq2RIVMg8895Es7UUcoaLFhPsloPC3fsn9
	pZwr5MTxFuO6UvwqTQzuwWLc2X1pXyb74LAPb/y7R32xHaCIoqXMOaB1lVUtAJFPLObI8od5
X-Google-Smtp-Source: AGHT+IGXW2QME1gcQs7Gpd8hsHAnUUsTB6wiKU7yAlG2uli0eosOA2OGDmhhXKqFgSAMmp6V+UI7vw==
X-Received: by 2002:a05:6a00:a07:b0:736:4704:d5da with SMTP id d2e1a72fcca58-7402722f82amr2564821b3a.22.1745895314127;
        Mon, 28 Apr 2025 19:55:14 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6abcdsm8797905b3a.116.2025.04.28.19.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 19:55:13 -0700 (PDT)
From: Eason Yang <j2anfernee@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	tgamblin@baylibre.com,
	olivier.moysan@foss.st.com,
	alisadariana@gmail.com,
	gstols@baylibre.com,
	antoniu.miclaus@analog.com,
	eblanc@baylibre.com,
	andriy.shevchenko@linux.intel.com,
	matteomartelli3@gmail.com,
	marcelo.schmitt@analog.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v8 0/2] iio: adc: add Nuvoton NCT7201 ADC driver
Date: Tue, 29 Apr 2025 10:55:03 +0800
Message-Id: <20250429025505.3278016-1-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since version 8:
 - dev_err_probe(), move the definition from device.h to dev_printk.h
 - Use USEC_PER_MSEC rather than the hard coded value of 1000
 - Use one dev for both regmap and regmap16

Change since version 7:
 - Fix comments
 - Derive dev from the respective regmap
 - Generate the mask from the number of voltage input channels 

Change since version 6:
 - Fix comments
 - Add use_single_read in regmap_config
 - Remove unused definitions
 - Do not shadow the return code by -EIO and let regmap API caller to decide
 - Use simple English in all error messages
 - Use a local variable for the struct device pointers. This increases 
   code readability with shortened lines.
 - Use `fsleep` instead of `mdelay`
 - Use 16 bits type __le16 instead of u8 data[2]

Change since version 5:
 - Fix comments
 - Add NUVOTON NCT7201 IIO DRIVER section in MAINTAINERS
 - Add vdd-supply and vref-supply to the DT example
 - Remove mutex since the regmap should already have an internal lock
 - Remove redundant assigning values
 - Check errors on regmap_write

Change since version 4:
 - Fix comments
 - Add interrupts and reset-gpios to the DT example
 - Use the FIELD_PREP and FIELD_GET
 - Add use_single_write in regmap_config
 - Use regmap_access_table

Change since version 3:
 - Fix comments
 - Don't put nct720"x" in the name, just call it nct7201
 - Remove differential inputs until conversions are finished
 - Add NCT7201_ prefix in all macros and avoid the tables
 - Correct event threshold values in raw units
 - Add with and without interrupt callback function to have the event
   config part and one that doesn't
 - Remove print an error message if regmap_wirte failed case

Change since version 2:
 - Remvoe read-vin-data-size property, default use read word vin data
 - Use regmap instead of i2c smbus API
 - IIO should be IIO_CHAN_INFO_RAW and _SCALE not _PROCESSED
 - Use dev_xxx_probe in probe function and dev_xxx in other functions
 - Use devm_iio_device_register replace of iio_device_register
 - Use guard(mutex) replace of mutex_lock
 - Use get_unaligned_le16 conversion API

Changes since version 1:
 - Add new property in iio:adc binding document
 - Add new driver for Nuvoton NCT720x driver

Eason Yang (2):
  dt-bindings: iio: adc: add NCT7201 ADCs
  iio: adc: add support for Nuvoton NCT7201

 .../bindings/iio/adc/nuvoton,nct7201.yaml     |  70 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/nct7201.c                     | 462 ++++++++++++++++++
 5 files changed, 551 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
 create mode 100644 drivers/iio/adc/nct7201.c

-- 
2.34.1


