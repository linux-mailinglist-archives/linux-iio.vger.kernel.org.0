Return-Path: <linux-iio+bounces-18593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D65A9A5DF
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 10:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ECC57ACD40
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17E91FF1B2;
	Thu, 24 Apr 2025 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ7/m5TO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E21F4174;
	Thu, 24 Apr 2025 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483413; cv=none; b=nP1f+qu3G0tZ03+uzl4zBCSOPkYP3Ocrgt6mLuBzy10BsdCTfQkYfNIJgEE2JNDnJ1oahFRTY06T1P4+22xrNmFarKQgajPxcMvYCL7upXBdx5XcJ2YJJ8fxtuZXzBpZ0kQcQ+yNG51ifRyv/qSjAPWYnDk4GSykjqYxJAY9tk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483413; c=relaxed/simple;
	bh=Z7t/xpfDoUKZVCpP332wUvOPBO0Lvs3yJa0aUAB46uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TILQ6Q/TWdkI0QZCdEc+LPOJ5MMM7dD0GrX9vM/Gk/A3u3QE9VYE2X61fSZHdkW9AbZj6kTAr/AKdlT0kvQtwoc6XuV7nwsu4OgCc9JqQl4PzyMLJ5wEA6xSQ5N6ficAvJg8hVoEeD9jm6fwhvK3R0TQr+9iQtfWZeoL6Y0FVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ7/m5TO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227a8cdd241so9099315ad.3;
        Thu, 24 Apr 2025 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745483410; x=1746088210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gaef/WTXD13qYijzVNXLZ3kYFUuIuFHeo1TNnGDAMdE=;
        b=CJ7/m5TOgnmxJ0mRefblwfCEgV43h743tBq8cYye0CKqCsh+V8PD2zf0dXuV93+Tqq
         vG9rc6unQri3BB2GRkG/UA9c2up+dPC7wLuwex5PAU5NRu4qnn55apXFiKhAARHuP5G0
         Zz7OchGQ5Gw/g07d10ZFAP6uvShkZPSutuZrkYFMQ30RkxHvUeNaWqZ6eQtUQSNKQFrS
         oEW+s/gYvvyVTuuYA1stmQni7ZhF3m1aNpzgP6aUvydvIAznld5ukdUAQm1/9MN4+aMH
         +XDNE9UgoHeLx0eAJKqg60TPRfLiW8Nve1f4t13P3xJpqCrG8YMR9e0JS31L+RREXctV
         f+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483410; x=1746088210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaef/WTXD13qYijzVNXLZ3kYFUuIuFHeo1TNnGDAMdE=;
        b=AhFJAUqrNrwIw96iqd52whnYTSaV4QglB1Yx07scrgJVew0UcNGV0IPWohmnVJVOH3
         YUSNB3ekbjrC3tyJlubMiEEcBSSR8NgiPnnu4gHMGpqf42zb+C4U8fBbHJdMIm+r+Cvx
         HOet/XOA4UpMZDjPlWC+3Y3POgjCDMvJr4sD6yQfW0hUV7bQyfIoSZgzp/UL2F1ZeI3Y
         QqS9DrC/UYfUzkmiLcDGiZMIPLdltu8XfkE2/H0h6QnkGmFVonP+qfhcMCfDEfiFaw9G
         0Q8WySlgUz7nmn9dBmewHnedtsoUHDOD5oAwQ1AmHegyfXy3lvvdiklPxie7rgzvfmOZ
         fuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcG6CFXw32xlVTGt7IT78rolZN0pzPje5md+bxuj0PvmSYYONCARONRuTYYqukCO3cEyqYhdqJxzMgDxUc@vger.kernel.org, AJvYcCWcGcd8Yy6Y8R44Ut/S3vETqafIlnqopUFKMmsM00kg2T3lonmISzCIiv/Oap8cAhN0EHRo5U3fW0b8@vger.kernel.org
X-Gm-Message-State: AOJu0YwrAUIAc6VWttlj1RD+hfPTRve5tqW6ac9+ztcD1l1e6p33GOIn
	KNy+wybTx1ebrzvsio9CQVmBQe2NNqu/H0eVPBQdG+zvZx6lPxc3RIQ4AMDI
X-Gm-Gg: ASbGnct6+fz6Ka4wdMjs6r6VSDw0LqFf/jq/IdhzMwhJvvfDN1snzk0cuArhm0kjRtg
	k60/MBdg83wPfQ7KDkUh6JjDhHU25aHVmU4ijT/KlZSDGyan6sCP9wAsfUOMDskPR7F/XEhrdUI
	u51mqVD7hzKIex0LLUWIZJoadK7N4TKm+9daco6OeJiHR4ntzW17HquTn3jHoEoHAhBpoWG/m5X
	kzz8fndIDX+ds1MjwyBCUSRQb42/9agjzTpSHN5aKgdDK91f9HbkTsqDAUOO3A7t8ZWctgQKdL1
	lwWXe62K/xdAbh/vGHP/5I8wU3wwV17R/OedBmsLxsqd9Lw6QtiSzoIwFiDHTZOBLqscV268
X-Google-Smtp-Source: AGHT+IEMIbhHQiBfKg6+VcVkj3G0wjA50Q8YjTwkOe9Zs/wUBwLuEhqFYCzMEm0scJdd4OgPJi4oMg==
X-Received: by 2002:a17:902:ebc3:b0:216:3d72:1712 with SMTP id d9443c01a7336-22db3dacd5amr25429885ad.48.1745483410312;
        Thu, 24 Apr 2025 01:30:10 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221600sm7525505ad.213.2025.04.24.01.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 01:30:09 -0700 (PDT)
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
	olivier.moysan@foss.st.com,
	alisadariana@gmail.com,
	tgamblin@baylibre.com,
	antoniu.miclaus@analog.com,
	eblanc@baylibre.com,
	andriy.shevchenko@linux.intel.com,
	joao.goncalves@toradex.com,
	ramona.gradinariu@analog.com,
	marcelo.schmitt@analog.com,
	matteomartelli3@gmail.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v7 0/2] iio: adc: add Nuvoton NCT7201 ADC driver
Date: Thu, 24 Apr 2025 16:29:58 +0800
Message-Id: <20250424083000.908113-1-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/iio/adc/nct7201.c                     | 468 ++++++++++++++++++
 5 files changed, 557 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
 create mode 100644 drivers/iio/adc/nct7201.c

-- 
2.34.1


