Return-Path: <linux-iio+bounces-18159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC39A8B34D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 10:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FD75A5294
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 08:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1CA22FF5E;
	Wed, 16 Apr 2025 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S23LeSGY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58122E406;
	Wed, 16 Apr 2025 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791470; cv=none; b=QGfSmoHMMk2jVclH31BpVWYHukmN0/Ic4odg/tVgLqyF8icDwV72S6NruhAceVxG4yP6qEdMlvoV59Pjpjb1cv9NlytJgXN2b7YWg2awUaixuSKepoWjJoHe0j3szvN0V3BwcqKWxm8Btq3+KGg6Fk5tYsOhbPiBkMceH3OTA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791470; c=relaxed/simple;
	bh=eBhnnAGZzydVrHE2B0Hn0yJ211LrD50RXVmFPWd6lgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgjcCn9f1i5p3B9+DiVSAvHmtlTklGGvCxcV98cUmmw+t51t/DSLnIugSc3bAHsklht9QmkiPbxZQDLWU5Mhuu/4+yBr6pzfMvajGHUcVTJvTyM2ZKdS7V5sE1cgtebtWOpA5Kl6SgRpsmWWZmMVD0RZwOjLcoBYJZaPxlReKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S23LeSGY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2241053582dso89469765ad.1;
        Wed, 16 Apr 2025 01:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744791468; x=1745396268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0oATAwbosz0DdswmzapQQqA784eLgKtbb7VT6D86p6g=;
        b=S23LeSGYnyNP5z6+Uuy16zYAx1Asz5wu2hRC95L8PWDv8BatVyQkPwikaD10cgaCWq
         JgQmPANrPeQjEOL+W03hTo7OluBMwZ4ZrySLpNYul4ySJL9qcy73BjF6JKrXcZr7uPdO
         HEUOJnF8UnE6D9treDKyaV/RA1/+40li7cAPENpKNAQDKuKTeMb0QT0gvENhDbZ+iAir
         tXNMNmRttB5VhMDN4zzf9W/HO5BQCCqLHyeI3V0MtIeM3ogC9Nn0odE+6o4mB412SaAu
         Gjzse3qxCjTUY1KPLoGe6Yi6uSvhH7qY1Huv1vg4mCdy3xmTsY+ZzTluHzFIx+CWK5Dw
         2Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744791468; x=1745396268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oATAwbosz0DdswmzapQQqA784eLgKtbb7VT6D86p6g=;
        b=fGhp7xoo0/a0M0juwPzXJzIeiTVRWrMQFceHLEs9OHWYIWTfRjuIoZX05W9gLlAsb3
         QiFZcNSM3c0XmeLkEFqpSU7UGWw2YcEOreC/O9Suf032HRFNfJNwOYguMs1VSU5YclwH
         da12Ev28FkCYVIraq4YqreLhCMMjy5iOWwl5jtfWiHqW/psun8xnVJNU42w15ULn9iQs
         f/ZsSo6mVDQZKbztTdPdQVd3SeXklkjnhi1/XS9KISPg0zCeG3dX6Put+z5F4jFJqT5p
         BYIrVIXqZdtB4rDNxD5TxjugojvQiZZm+qNZrXaCVmEN9XKuo8q1zDqMZfPmv3iRYWd/
         18rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtUBEoa0SuTfC6KJ1Sof8M4woE8hGfN8raaVnLLM9Lxk/vcOP90JF3mqF8NDKWlHT53KCy4LhPZ71Q@vger.kernel.org, AJvYcCXofosMaaYrEv4J57NIjQY9H2temKBm9yc4w2waPzNxCVnf83Hji6HuF+jeaRDHHWSD3nVHTWdfB+UzSPB1@vger.kernel.org
X-Gm-Message-State: AOJu0YzLjDZ/Z4yFoj4KfUpZ40t5VDo6Y2uc48qSjO9+WmQRTZqfw0V5
	JR9+tdquV+XCrX5iA4VJ/+Jw01fWHkykEYgO+7PQUJY6G+eakkDH
X-Gm-Gg: ASbGncuZABK/FpQeUsqDge/WIv8BUYG5KwXjTF65x94wzbMamyLxBazgVWORAT5tD1c
	ux4GA3HEcj/5WVA07A6pPohly9QQJzfRprMQacwhYDTQtRhe0fgHPBDWJzI5qC9IJbPyRNkQ6cJ
	e3IiYCh+SVyPTin8oBSTkE8oYfdo2FAbfzYXdtDorj20HY6BhTTGVXyAcNWubYe/Vw0oMy4nB6Q
	42FCCZ9eDO8u1D7jol4sLqtrzm6v16Fz8RoT1sQMeoL8cQ1+hKC/7/cmi9LIZjJlR6KE4u5kdc8
	9dXpitGCzz6SAEdnYHgUtyhVTvH8J3kx9fOXQHdUYH4YLTASepVK73wqNhx6FgY24REReQwP
X-Google-Smtp-Source: AGHT+IGZDOiHWyQ+UndS30b4R9KUrQEBau/3toTW95BlhJl30/S4mz20CPLgfkr67OFqa8xaf93ZqQ==
X-Received: by 2002:a17:902:dacf:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-22c358c5950mr10677835ad.8.1744791467692;
        Wed, 16 Apr 2025 01:17:47 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33faac6fsm8190925ad.124.2025.04.16.01.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:17:47 -0700 (PDT)
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
	alisadariana@gmail.com,
	tgamblin@baylibre.com,
	olivier.moysan@foss.st.com,
	antoniu.miclaus@analog.com,
	eblanc@baylibre.com,
	andriy.shevchenko@linux.intel.com,
	joao.goncalves@toradex.com,
	tobias.sperling@softing.com,
	marcelo.schmitt@analog.com,
	angelogioacchino.delregno@collabora.com,
	thomas.bonnefille@bootlin.com,
	herve.codina@bootlin.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v6 0/2] iio: adc: add Nuvoton NCT7201 ADC driver
Date: Wed, 16 Apr 2025 16:17:32 +0800
Message-Id: <20250416081734.563111-1-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/iio/adc/nct7201.c                     | 471 ++++++++++++++++++
 5 files changed, 560 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
 create mode 100644 drivers/iio/adc/nct7201.c

-- 
2.34.1


