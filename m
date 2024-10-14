Return-Path: <linux-iio+bounces-10553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2C899C6C1
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 12:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191371F2102D
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 10:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3955C15B11F;
	Mon, 14 Oct 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MscM6HC+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F769158DD4
	for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900579; cv=none; b=GAtYPCtcS/rHRGleQicuCK5IVxUK2PxMyQ/Ck5uvA7+J8PvJXsw9+4UYAMSjq1mzWbaw9YiA/3n5hLA8EPkjThhdb2vBvb7XyrhU8BQ+Am4dO5Q2wbfZm2PF3JoFf4J58W104d5DkhyeJRIy+5IfU9UlbrpUBCDHdoldtdc/g2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900579; c=relaxed/simple;
	bh=Ufrl1G32HPaK9YbxxkKR6cLXScnqLBewjFuoRruYw+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=icqDCqSX2CyUmA/kI5e33GmQ0gGxm+ejwKcFAKPMWOqrMxeJHHfoXrEHPSq+2Cp8x2iXeGJ/rjneRUhDXfPS+pKE38H076suq3ef6dy2BXYHUFixZokW5opaaCDfzimnMIsVU+uxx6wVScZZWKTVwtxCFPi1TtifAeTWi2f6Cxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MscM6HC+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d5aedd177so1810558f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728900575; x=1729505375; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHzJiDYdxbz3V4wyTfg+ycSw2GEuLFIK53ckSocrufI=;
        b=MscM6HC+aUpJLsK4x2/rcPccdXZkLEd/CZc7povBdfTFbDi6lWZKgB+msQe98+LOgd
         n0uAn/x4phmXY8G/tm8J58Tnxs2efMNbSEQhSnPx++0ld06TyLe8oCrj0amJ/m92/LCR
         wuD5sB+6h/J6s2uC8aVx7TIIuE0NffuRVWIPo96s3/h3BV5hFV94Q04U43CvlKS3ybxG
         fQw8u7oZAyTAF5YH2W51+zLmLSq0VAwzVS0Fslc7CBoUDcDwliboOIxPaWjTGIjWqnNP
         c1uASiUi9rIPyzG2OajhcMaHasvheRRIDxr1SfrjLBOreA11Bi0vS/WsDMqUzI94j1R2
         dK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900575; x=1729505375;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHzJiDYdxbz3V4wyTfg+ycSw2GEuLFIK53ckSocrufI=;
        b=mSj1vjyUaJ9FjMVvPuKpSCT392oxsbGEcOqAF2Wfy/+B/Mjd6nnlCz5t8Ki7hTkpwn
         lbzVaQg6L2BdqIBN2P3kQ9eneMTvjEvup18FAWU1ywS60HdtYU+5IT30xaof8lGVRe+R
         uveAcEV5eFxGioLWOSWgVWkXr73QCv+ScyBOeFyQTQcbJ7Pul4c/v+0PGbf+We83rc1L
         8kcQf73+/7827z2ej0cIz+R6dPWqWueTVCfK0wu3vluL0pxhufo6yYnbgs8/l6bLtCP5
         2UQu88crANIa24+UJ9VzabCVl2q5UIKQk3kZjwra7lsf+1bnve6MRHtN9jRRisUN2KH0
         bkWw==
X-Gm-Message-State: AOJu0YzcivZNO1x2lSxlYFQHa/K1EObwiHionV3Zwhc4kw4mcPBhh+us
	/p/FIm8nlTCxLFxFkIXSoXQb0OhCBRlKnHN4EnEBS12U5vE11mZ1ch6z7Xsgpuo=
X-Google-Smtp-Source: AGHT+IFpD1y8+6QlQ2E33JPuw87FP00gcVM5rP6Q/o92UV+bYxktnpily1MRzhLG90w7cvRNE7587Q==
X-Received: by 2002:a5d:6703:0:b0:37d:498a:a23b with SMTP id ffacd0b85a97d-37d551d5242mr7983197f8f.21.1728900574789;
        Mon, 14 Oct 2024 03:09:34 -0700 (PDT)
Received: from [127.0.1.1] (host-79-45-239-138.retail.telecomitalia.it. [79.45.239.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee0afsm10969352f8f.102.2024.10.14.03.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 03:09:34 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v6 0/8] iio: add support for the ad3552r AXI DAC IP
Date: Mon, 14 Oct 2024 12:08:06 +0200
Message-Id: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbtDGcC/x3NQQqEMBAF0atIr22IMSrMVQYXHW2dDxIlERXEu
 xtm+TZVNyWN0ESf4qaoBxLWkNGWBQ0/CbMyxmyyxrrKVI5PbOwXlrFuGhtZLvBhGFh517QjzOy
 k09YaP/lBKHe2qBOu/+PbP88LsXsY+HMAAAA=
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1

Purpose is to add ad3552r AXI DAC (fpga-based) support.

The "ad3552r" AXI IP, a variant of the generic "DAC" AXI IP,
has been created to reach the maximum speed (33MUPS) supported
from the ad3552r. To obtain the maximum transfer rate, a custom
IP core module has been implemented with a QSPI interface with
DDR (Double Data Rate) mode.

The design is actually using the DAC backend since the register
map is the same of the generic DAC IP, except for some customized
bitfields. For this reason, a new "compatible" has been added
in adi-axi-dac.c.

Also, backend has been extended with all the needed functions
for this use case, keeping the names gneric.

The following patch is actually applying to linux-iio/testing.

---
Changes in v2:
- use unsigned int on bus_reg_read/write
- add a compatible in axi-dac backend for the ad3552r DAC IP
- minor code alignment fixes
- fix a return value not checked
- change devicetree structure setting ad3552r-axi as a backend
  subnode
- add synchronous_mode_available in the ABI doc

Changes in v3:
- changing AXI backend approach using a dac ip compatible
- fdt bindings updates accordingly
- fdt, ad3552r device must be a subnode of the backend
- allow probe of child devices
- passing QSPI bus access function by platform data
- move synchronous mode as a fdt parameter
- reorganizing defines in proper patches
- fix make dt_binding_check errors
- fix ad3552r maximum SPI speed
- fix samplerate calulcation
- minor code style fixes

Changes in v4:
- fix Kconfig
- fix backend documentation
- driver renamed to a more gneric "high speed" (ad3552r-hs)
- restyled axi-dac register names
- removed synchronous support, dead code
  (could be added in the future with David sugestions if needed)
- renaming backend buffer enable/disable calls
- using model_data in common code
- using devm_add_action_or_reset
- minor code style fixes

Changes in v5:
- patch 2/11 set before fix of ADI_DAC_R1_MODE patch
- fix dt binding check error
- patch 4/11 removed
- fix stream enable/disable call names
- fix axi-dac clock names
- fix axi-dac platform device unregistering
- minor code style fixes

Changes in v6:
- remove patches (fixes) already accepted
- move platform data include in drivers/iio/dac dir
- minor notes added to commit description
- fix axi-dac platform child-device creation
- minor code style fixes

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

---
Angelo Dureghello (8):
      dt-bindings: iio: dac: ad3552r: add iio backend support
      dt-bindings: iio: dac: adi-axi-dac: add ad3552r axi variant
      iio: backend: extend features
      iio: dac: adi-axi-dac: extend features
      iio: dac: ad3552r: changes to use FIELD_PREP
      iio: dac: ad3552r: extract common code (no changes in behavior intended)
      iio: dac: ad3552r: add high-speed platform driver
      iio: dac: adi-axi-dac: add registering of child fdt node

 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |   7 +
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |  56 ++-
 drivers/iio/dac/Kconfig                            |  14 +
 drivers/iio/dac/Makefile                           |   3 +-
 drivers/iio/dac/ad3552r-common.c                   | 170 +++++++
 drivers/iio/dac/ad3552r-hs.c                       | 526 +++++++++++++++++++++
 drivers/iio/dac/ad3552r-hs.h                       |  18 +
 drivers/iio/dac/ad3552r.c                          | 461 +++---------------
 drivers/iio/dac/ad3552r.h                          | 207 ++++++++
 drivers/iio/dac/adi-axi-dac.c                      | 325 ++++++++++++-
 drivers/iio/industrialio-backend.c                 |  78 +++
 include/linux/iio/backend.h                        |  17 +
 12 files changed, 1478 insertions(+), 404 deletions(-)
---
base-commit: 89f50f021566cb68bff8880f00b470b323c2b44e
change-id: 20241014-wip-bl-ad3552r-axi-v0-iio-testing-4a7e620bfbca

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


