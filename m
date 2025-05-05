Return-Path: <linux-iio+bounces-19083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC2AA8F75
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 11:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79EE67A0812
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A351F585A;
	Mon,  5 May 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwfi9T22"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D11F470E;
	Mon,  5 May 2025 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437172; cv=none; b=n4FpfrYvWWXI7kqQZj1oaXJjYHBxE6/aaebywY5CPU/Pp0EEdf/Gn6SrY9OL/h8elOK1eLZ/RXIqjK+tFzOqDf3BMXQBt+y7v1HqWz5fRfdqTHAWV6i1Apoc4eTpNQqlYGrLOTtMUS00RmEYHztBymr5QI2uJhrlEWc0YxEVXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437172; c=relaxed/simple;
	bh=Yk3OZqOn6A9EIo7uEkMjs4xvroEFFyQK/soU6vJie2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGu9iA46z5Z6traDsp6Li8g4wXti/6Y+ByGkmyERw2brZFDYZgpznD8yecesASaT/AqJWQ37WEipoQx54RFLxIEw/9tjzBv/kEbjiKux5Oy3/pMAoynu0Mlyf9+MigC3sdE3K0qb8U4DiamTz6XQfAHC+ZPaXvNDY0E+cxZFYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwfi9T22; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso4175232b3a.2;
        Mon, 05 May 2025 02:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746437170; x=1747041970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TFo53WacOzcxwWBDcoCY5+G7006z8+N2fRouRbOOg1A=;
        b=bwfi9T22ue678pFqtkQEEKnAoRU1QlhxViGVlRRCrcZnddmPFUdoakfuX22PykM/Pw
         mZfOFLCqFVCTNBvQJXLaZ355YLMFtIekRpkDUjDFcRleteXuXzAFs4RmZzUEoo5DPgSU
         0LkRdhv5oq1e2RdSQtZglVldpFABoKnwQfcFdac17cfEueTS+7Rn7ywPM6pWSsWixxh6
         ZBZir7qr2m6YiHO7yzzMtTdHqjax4T/yo7bq11oJmNOxJtaW8vsg+SCSZdWQg0JW8N1b
         CsJLpu6zL4IF4NXvWdR3VF1jmNoGP5AUvt2uNwd9nPpjoZgIJINHdoC/TgfDoVf2qSBE
         XMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746437170; x=1747041970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFo53WacOzcxwWBDcoCY5+G7006z8+N2fRouRbOOg1A=;
        b=I6hqtkev9gYzCM2tgkzhHvuxO9YrCmF6ES5CVzxvBhMriMdWGOX5QDKKAyluk4yIsF
         bRIjeBh78vU8Eo9/ROTDwatznSfOqb12O+KFQKZA6x9+l/ptOh4xS4Xbpu1gqVj+O1Ew
         Ibpc7JbDJq7upankYL8cWCEDB7bZ74auidrLuWRblwzU3Jcs8G/HyrU9kRHfS94PQst0
         poN93yOotnNekqUvTG8ldB5qWcv8LiJHmJfr/TSGbv7EOIjxgX9kIEc7Zg+n0fAEGwEY
         cnq4XGu7rji972WPV9WmrFDHhGCBwhxEMu2OIWkhC6GLzbC7EwsXEtwDNfNZRlfRtsPH
         YXKg==
X-Forwarded-Encrypted: i=1; AJvYcCUlEP4AEVYYOmEA4xs3Ww+qUg7xdWRZaXPycyqQAuB0l7ErvR4fdZAig5cNW0KJ6jdmm4DXpord3A6r@vger.kernel.org, AJvYcCUlztMOJxbxNi89L57YKhKPqkXzeIE8IKHNYO+oUufwHYP/Ggc5/kNYi2CjHWTOpMdCiKXJxmaXcdYh+8sI@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnlK/NURy7UuN++RRfZ7Y/E7NdMnY1x9x7JmsQA1+no78H1lZ
	na4hlEONExDWCJh0k+PaSw8+mhDRQl0pcLi6yiq8L+MTyw/By36t
X-Gm-Gg: ASbGncvaNqRv8LgWLYHxT0b+JcQRpr/YvHB+kiB0KLaIxQGYb4e/q0hRicMByjTuOiG
	Uj+Klm9u8ZHW5oNribqIVPHnBA+S+fPhLe7IpXluyAgGDif+G4bFpI+KtZAlcgP9iXJx9oUeLv7
	6VBb9xIwJmMsPngdrDoxSrjQ3OpesJ3/BLaH/EfFbrQ5OhEq56Uw5HDpl2t+GS3gecNBTsV3YaU
	3pfimnPjSDBMUr0otM7kNbFeCo/XvD5rMljvQPyRCty9SKkl5N44OTiSQSYImG2lUEkS/iz8wfR
	jtLTrTCSRKLma4dNIIEd8sLvmPmizm6bH11BGAbO0RL9sHJdjq9D7NHEtJyyGCv7Y9BEpyqMKFi
	B6QF2xyo=
X-Google-Smtp-Source: AGHT+IGwm4cT3yJ4lewoezkZiCi583zQoSW1M6ZcIXhz33/6OsxkPLWiNFBEQG0KXVtWFOFJ3NPl3w==
X-Received: by 2002:a05:6a00:ab86:b0:736:ab1d:83c4 with SMTP id d2e1a72fcca58-740587626dbmr16576349b3a.0.1746437169882;
        Mon, 05 May 2025 02:26:09 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058df2a6csm6288000b3a.81.2025.05.05.02.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:26:09 -0700 (PDT)
From: Eason Yang <j2anfernee@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	alisadariana@gmail.com,
	olivier.moysan@foss.st.com,
	tgamblin@baylibre.com,
	eblanc@baylibre.com,
	antoniu.miclaus@analog.com,
	andriy.shevchenko@linux.intel.com,
	gstols@baylibre.com,
	ramona.nechita@analog.com,
	matteomartelli3@gmail.com,
	marcelo.schmitt@analog.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v9 0/2] iio: adc: add Nuvoton NCT7201 ADC driver
Date: Mon,  5 May 2025 17:25:58 +0800
Message-Id: <20250505092600.962675-1-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since version 9:
 - Fix comments
 - Change vin_mask and mask from CPU-endian to little-endian
 - Fix access to restricted __le16

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


