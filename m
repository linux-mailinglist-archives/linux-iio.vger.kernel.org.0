Return-Path: <linux-iio+bounces-20533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79067AD6D10
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 12:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4849E1885C94
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 10:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C69022DA0A;
	Thu, 12 Jun 2025 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey3q5xGa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB03213252;
	Thu, 12 Jun 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749722912; cv=none; b=XhxffW12i74/Rnbzs2hIEacfFy+zD7cKf/5T4WlFp91TD5OrETeU3xGTtWfeFvLO1GBqiAlgJY3U4Ux+B50ummo+Ae1P7rarVwXFXDpiu8HkBmjA3SsIptIfsBCX/RYBhSutOn2XPrvCGAD54pGcGlDCKUSLh49XTwO6HfpyYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749722912; c=relaxed/simple;
	bh=4sj4r7Jbmz3nmlhcxBiEyRblCjFF90NxdByUKtg4nfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dTDuaYwNuud5QBfimGgIcItpdk5g1DuOc8BrziYBxwsrfcI3GBp4/1Q1ARJ25C69+ylHW0sHLeMcmpT5wU0YkjI/IwPim9om/kwLlx5f95XO2YdbHUIO98C0S5s9ldGar//Yf0Ni7nW7zuxUFQSzbDCHKUvqpTuPATaH3HeljdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey3q5xGa; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a442a3a2bfso13584761cf.1;
        Thu, 12 Jun 2025 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749722909; x=1750327709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z6IAbOLTMbompAY/5ah8ku4/WSIfPEg+nIcbaDG+DSk=;
        b=Ey3q5xGaFQaFR8lbNexhjcDT8UdwH+0I/RKkJAULLRlb4FLQHTKKrPyMMTFoNAR+MD
         OIyINHseCu2rhvWYgrW5vEvN6JBdMnD8EDGAoQcBMGPL71FnOigXLR/OrdQNdDDj6Rzi
         wKQnLpYTvkGLFvwuC2GVCs6StYdbZ4aP2izGtqfoRcQdqu2x/LIqyKQsN4e1nQieYtXG
         8tFS6riySl7WbOWoSRDLnwTSXDltHpCj4nYxg9lUrdbyStgVDVFWN4TWKzNjGeAM6BPP
         ikj+vivj2jDvnVzW4x4ZUR/Smqmhy14dyOjhRpl5DqOHscU1J+QBlFDKXsrYniqHUGrO
         bjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749722909; x=1750327709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6IAbOLTMbompAY/5ah8ku4/WSIfPEg+nIcbaDG+DSk=;
        b=BpN5DeOOVJIchahb/BmqAoKaATu6amvUaMjBrbev3sY2Vx5Aq5mv8PR3n7Mb7Thwkm
         3DL7VPX79iLrQEV65eREDt400tfBzFUNw0uxbpAcfTENRDxjY2lT9jpgIN6vMNUJ0plS
         4RuhdLKARyj2wHzNxYAAw8kgywkWarePsviYXFiHk2UUf+LuKwvX24nS9PiZbV8COP8p
         Cc8ixWCoE3m+cgG/1HGJjcy31BdVZpjnvsUIubGQg/sjDyBpV7ytDmP+/TG/nYNc8LMy
         VsoCJst4uInNCjYeERM2n6w6NWdwAcbyadSx+6RSAaw0u/M0bovz7C+hTyKRyF+2PTqM
         ePbA==
X-Forwarded-Encrypted: i=1; AJvYcCVU+hZIJ+3br4c5k1e4nQN3UHKXBIJZ5uHWr7gmwBAnvs1lWw5Jw2/JeDBPrdmvXXjMw8S1Ewmrcheo@vger.kernel.org, AJvYcCVUNr9aJ5Da6RIirq8ffeM82ckXlanf+5f0hjxUAjVGqG6yl3dhwY+dVm1LUVDnOhFnGloAvI2uq2/D@vger.kernel.org, AJvYcCXkGjLleTdIrShhDd+cFDNviaXbwS+tKktRdPLghne4xYZKOcIhD81VUk7i8czMZR8GKAqey1c/CbSyKJNJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwOco12rQ7HeIdh0fo0ZOsEYJaZ0pDIt3jj0Snh5tDlBUD0iwJX
	GRz7b8yyJaJRSiDsRhD9KIcl0fKuSnJocQvMsmUlSl0bEAEgMQNGmI3DZRtpyIK9rlE=
X-Gm-Gg: ASbGnctJr4HEt5MbWOt47WNt+sH/t+YouPTCHQO2xXKCejkgc9NqxIFf7EKZW1aHNPy
	to92ihHlktRurY0cC0hX9uJNs8t1SyJAiuPvMtLjTqtDyunlz1i9nUYJRC0Pj0RHga8L5qDWuCq
	DKPtnu+W8bL1If0T5DbwZr4AD9o8Cp87S3WRLmwPJ3YVSc00pj05jXTfS7oN+kFg1PRyedrGdsM
	1qD+I7kRgbYcjVal81uxTLpWr9uasn7pM3x/y9nlWEkJabsETvWg0Oitdm4Zt9RRYsFeVKeWaBG
	VSWJmrkbSwgOwId/UaRMK+bhVvJxgwIBnN346bvYDjTyQLOH/xcyrDC9/VqXsObzbvycFcWMVg=
	=
X-Google-Smtp-Source: AGHT+IEZSHtYZazqE+Pd9vRLbylCApmsONx6MsgC9pSAn/f4eqtSnaxIFftRIU3DEvYpJx8VLfMudg==
X-Received: by 2002:a05:6a00:3c88:b0:740:9c57:3907 with SMTP id d2e1a72fcca58-7487c34f26emr4432764b3a.19.1749722899262;
        Thu, 12 Jun 2025 03:08:19 -0700 (PDT)
Received: from localhost ([2409:4071:4d30:50e6:899a:ff8f:cff5:9bba])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748808962a7sm1056014b3a.42.2025.06.12.03.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:08:18 -0700 (PDT)
From: surajsonawane0215@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	surajsonawane0215@gmail.com
Subject: [PATCH v2 0/3] iio: chemical: Add Sharp GP2Y1010AU0F dust sensor support
Date: Thu, 12 Jun 2025 15:37:43 +0530
Message-ID: <20250612100758.13241-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit

From: Suraj Sonawane <surajsonawane0215@gmail.com>

This patch series adds support for the Sharp GP2Y1010AU0F optical
dust sensor, which measures airborne particulate matter concentration
in grams per cubic meter (g/m³). The implementation includes:

1. A new IIO_DENSITY channel type for particulate sensors (Patch 1)
2. Device tree bindings documentation (Patch 2)
3. The driver implementation (Patch 3)

The sensor requires:
- One GPIO for device enable control
- One ADC channel for analog output measurement
- Optional LED trigger for synchronized sampling

Tested on BeagleBone Black with:
- P8_12 (GPIO_44) for LED control
- P9_39 (AIN0) for analog output

Changes since v1:
- Added new IIO_DENSITY channel type (Patch 1)
- Documented ABI for density measurements (g/m³) in sysfs-bus-iio
- Updated timing properties to match datasheet:
  * sharp,led-on-delay-us: 280μs (from 40μs)
  * sharp,measurement-window-us: 280μs (from 200μs)
- Added reg property for multi-sensor support
- Moved datasheet reference to tags block
- Hardware Interface:
  * Replaced manual power management with devm_regulator_get_enabled()
  * Consolidated LED timing into single delay operation
  * Improved error handling in read sequence
- Removed unnecessary IIO_BUFFER dependencies
- Alphabetized Makefile entry and header includes
- Replaced extend_name with proper label callback
- Standardized on pdev->dev for all device logging
- Applied IIO formatting conventions ({ } spacing)
- Changed IIO_VOLTAGE → IIO_DENSITY channel type
- Updated all timing values to datasheet specifications

V1: [PATCH 1/2] https://lore.kernel.org/lkml/20250425215149.49068-1-surajsonawane0215@gmail.com/
    [PATCH 2/2] https://lore.kernel.org/lkml/20250425221214.50255-1-surajsonawane0215@gmail.com/

Thanks!
Suraj Sonawane

Suraj Sonawane (3):
  iio: Add IIO_DENSITY channel type
  dt-bindings: iio: chemical: Add sharp,gp2y1010au0f
  iio: chemical: Add driver for Sharp GP2Y1010AU0F

 Documentation/ABI/testing/sysfs-bus-iio       |   8 ++
 .../iio/chemical/sharp,gp2y1010au0f.yaml      |  78 +++++++++++
 MAINTAINERS                                   |   7 +
 drivers/iio/chemical/Kconfig                  |  10 ++
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/gp2y1010.c               | 126 ++++++++++++++++++
 include/uapi/linux/iio/types.h                |   1 +
 7 files changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml
 create mode 100644 drivers/iio/chemical/gp2y1010.c

-- 
2.43.0


