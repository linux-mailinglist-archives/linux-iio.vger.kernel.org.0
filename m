Return-Path: <linux-iio+bounces-17841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D162FA81A71
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 03:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93FF1B6833A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 01:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2915855E;
	Wed,  9 Apr 2025 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZuPOyjA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E081547F5;
	Wed,  9 Apr 2025 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161850; cv=none; b=jjNz+xaQXk7jXod1VSAuPsZIpkncQfTTnX/h22YqzGKcb9E6wHR0eePSDODXfhycnRZV0bRitB8GiQmqInzRzlDw9bJimqdla9LqSL6etMO8rnrCfwpnC+AEk0lBrA4HHmm92hTZWFBf6LXGwGQ37RRTwf+p9BGlVWrjVmSSb+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161850; c=relaxed/simple;
	bh=PEjH+eXLRl9dy4bF44gfF/M8NVwgUGrQzRXiPbdzkcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GTGNH2fDpGKDlW7C4zmFdjjJFMIC1Omyoi5P5/j7QkjcUVr1YkxdB90J21jpX193rJnnFT/AwXkGo2bsGh9yqeFNEkamOhXk2mJrtfBLzN5VrinqUhLu1kT/ZloJpgHmaMBtMUvOAVqtuTN4UfAeb+NQxK/aiL+TupnLEQHf+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZuPOyjA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225477548e1so59360545ad.0;
        Tue, 08 Apr 2025 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744161848; x=1744766648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bfkP4g8Jb3w2hHeMhkJm/ow/E9NOTus+U2Rh739edcY=;
        b=hZuPOyjAHzBdUU0MUgiTz7xiacyKQ2/spcZfCgWGjfjDZ/Sp0+ApQlViCwqobdcRYK
         Ckb+4rr/aQzfR3u+D+gAwNTRBYdMG3VM1LZ3sHW6gr00lBEB+VogbG0iinllHcNhJz83
         KRiJ6PEB3Zy3PTvVxtFhy/73z65Xr2rJcGkYtXssIy3gzNwrOBbHFXa7ZjCnxejss0+D
         MW+L7nBpkvXlDAT3JWORSHX/syTmNuxqNjeevXKPPEn5AYQRRiiQdHH8X+MSVt3GZBjg
         kun6rfq4QCehqW9oUEOPumh0vr6LDyY/gFPAPkFaU2naC8iFCw3eZ80akYBl/2lVYlmS
         as2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744161848; x=1744766648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfkP4g8Jb3w2hHeMhkJm/ow/E9NOTus+U2Rh739edcY=;
        b=t0LwgkUfL16q0vNvkGUyCn7CJFHExh/JC7nzdOpo+nYcGlg7Vg8UMRs+b+DD+gNHzq
         zDP7D1C9DqrlkhCJJ7PCN06KRUMRJNWlP2+5whf5WwRB/qq33r7uFa62gIxziNEKcDOn
         64P2hvwTYjuf1KeFmhaf3uQP5ztKdiOAI6aBu2lw92Kepczbk4btWy4r9esoruMQgQs4
         jcLiJ933Q2LiiteNg7yBklcocbOTaHqlbF3EBYyPL/VzFQtM1p3KeS99fEkcqkZsibwl
         FG046JVMTJzhjgIi5YCCsQtWv49lkEVyi+APPSP5MZJ/eNq4t3T4g4CKVOjvlc4pj+XU
         b1zg==
X-Forwarded-Encrypted: i=1; AJvYcCUvAJvd9ALBkzqGh7nVN1jq2K0/d1R5IwKz6HXNacOclebCDzKSA02IuberN21QMcL2MugyqpfCeKi2@vger.kernel.org, AJvYcCXkAbrsSu10JQh7TBiJ7k1EVWwz59MI0KOI6w0kBR2a7gm4dJAOiM0YZR+sdAwhE3gagioWtDjIeS4U/xfE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzui7K7hDvY1/hfepLPm7Ma2PtLnVZhsNECtrkS0y56yNhR7Wic
	w+dbRZbFAFLwT+gkQmVZHWxQkwG7Fa4X9PtQiWiexYaZagRg6rOq
X-Gm-Gg: ASbGncvFv680qJMm1RNJo5Xc0F8Ltm9vZZiY+/Ghp7JBdMDEsS8oP+OfOBbbI+IwtWQ
	MWFsgICvhuLXqsp2/rEwORAcIWi9aHbctcUEGl5k3lcUSm/qo0X515405Z+7t5NXqT4CDfxH29y
	/rDWIBWEy5tHuPypiTQmeZ+SDluh1mlJhbTReokDHJBLRfGBQ9eFIpdzGryhmIBBr0KDrAnYjrt
	uK5f3Kccn00GmyK9kpGX6oosy+nlVwzssyVdVyxegYdyWvfsP1+sNa0/yo/NWELxcZlGcriqmb5
	WVLIqN3RH8HFwnS6DqkcYBMTf5xMPW1mlLzLI5vRfQGEC/ULus1IqancSQOo0+G1HYkREOklUhM
	h
X-Google-Smtp-Source: AGHT+IH4X51GFsYYl6Bp43XniLs5+eccW8YssxIWvHhQ9XIDkHdUGTv9oyyXOlh9L694RBHZqEXU0w==
X-Received: by 2002:a17:903:110d:b0:223:4816:3e9e with SMTP id d9443c01a7336-22ac2991426mr13494085ad.13.1744161848358;
        Tue, 08 Apr 2025 18:24:08 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b6288asm20865ad.9.2025.04.08.18.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 18:24:07 -0700 (PDT)
From: Eason Yang <j2anfernee@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	gstols@baylibre.com,
	tgamblin@baylibre.com,
	alisadariana@gmail.com,
	antoniu.miclaus@analog.com,
	eblanc@baylibre.com,
	andriy.shevchenko@linux.intel.com,
	jstephan@baylibre.com,
	matteomartelli3@gmail.com,
	angelogioacchino.delregno@collabora.com,
	herve.codina@bootlin.com,
	marcelo.schmitt@analog.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v5 0/2] iio: adc: add Nuvoton NCT7201 ADC driver
Date: Wed,  9 Apr 2025 09:23:49 +0800
Message-Id: <20250409012351.2543450-1-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 .../bindings/iio/adc/nuvoton,nct7201.yaml     |  71 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/nct7201.c                     | 488 ++++++++++++++++++
 5 files changed, 578 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
 create mode 100644 drivers/iio/adc/nct7201.c

-- 
2.34.1


