Return-Path: <linux-iio+bounces-10857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477AC9A68F6
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E18BB247E0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6361F4FC4;
	Mon, 21 Oct 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VATmSdcd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125BF1EF09D
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514498; cv=none; b=Fa/ULVGSpdAJYMRwmNJS8Yjvr4DEgfrDmEY8DQB8jBaSjijnoizSHfNVNH6dA6R+OF2oXiBCdMFdWGYpjP03cb3ynPYPAlJmWTRUpw/SqwddWMgleXALdzmYzsLbwRSLTDzyOGHJiZh3gWEvh3LpnSCpTb9sy+IdLOB6lq+edDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514498; c=relaxed/simple;
	bh=rK40G3UDFzvkj00Bk6/5++MKVSbpdbXtH+EyX5EjeP4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LIuOP9KbXqw6IQI0U1T77fXrNf/aab7f3KCu7suJ8f3SDHaCTPteK9Y+8aFieS+ZF78Mv+huXOkNsH3wkk6qP91jVno9SqLNYG13oWb9WjqO4TNpzDurzkQP+QHXB/W+XoC90bMbaWe+a0oadlh9kQvG3S+B29J6+g6eX1+uqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VATmSdcd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43159c9f617so41799135e9.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729514493; x=1730119293; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi3qUmGWBrFJiRzS3/1u3SbHMDmxLKjlgr+XPQ4rWlA=;
        b=VATmSdcd7KdYwy+B/u8gGNvFrfw/55PPliHSA0rVs3QyR6BHEP9S3pAGXTV+GE2AhF
         xjJ/KbFjTZ4+2XzyA3YVStCPtZqjLlhAvPz7DEGOjczrrjSqwW7DyeRNdOlLdO1aa+C2
         L5tpEDm1jSv5f9INZWBcC+mnLER7/blV49RwEJDIKvpBr/b4JH0q1jbpMljx7hK8Y2gZ
         Wt+py8JoUUD+TWUTacALI1nwAp3OAdMMradhNd6TwvHWtn+76RFJU06XrVdERNBxVjLd
         TKBl4IEOa3lm0eEuu6b8fPw5oMxSyOp5cmniBnvCwOT6djXgY+9L7hjxf4PGfKEQ72St
         EKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514493; x=1730119293;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oi3qUmGWBrFJiRzS3/1u3SbHMDmxLKjlgr+XPQ4rWlA=;
        b=TqaKUnG98SbrqGv0mKXr1EeLusNxYGRyoOuJb35U23iZXBgLcxmixOQ1F9uUdBCqMZ
         KX/jdBehsKZYnE7SDqa+kypD3zZ8WLhvEzmgz4SEvNO3DBMia0E67WpH3Cq9DB31NGsO
         HCNQAsuCoBN33llnhgBF43ppcux32HHdaGkDKqdDQBvU5WFWvvLW/FOFLofNyXeETLIO
         VHYEf2IrStPn54SOR7RHhyUEXzRbhS3sBRp/EaPQhShDnysa5a3rIs/JCgt4gq6mxQHq
         DAvgTtQXRjW4TtfS9yHMCYJtF8pUcqPrAsy8f+kT0hsgYitSzSfixi/Pq+wMlAaTUDhk
         LG5w==
X-Gm-Message-State: AOJu0Yw2f/1r7YjJ1Ihg2mPAR5VoCe5qtn+WnvPa0qA+LzSUhuJG+lE5
	LBwaUnCplHMaCGXojKtJsV/jvBKUI34IT3r5D0oqDh773BJopxc1ruclLmZzyjA=
X-Google-Smtp-Source: AGHT+IGYh6R46+ei/pyR3JwDqOJxmmZ4iPe/t6CUEn9kcTeORH9Ws0fa9aQH5R41v018z0m20zYXjw==
X-Received: by 2002:a05:600c:458e:b0:431:561b:b32a with SMTP id 5b1f17b1804b1-43161647f5dmr77061735e9.19.1729514493249;
        Mon, 21 Oct 2024 05:41:33 -0700 (PDT)
Received: from [127.0.1.1] (host-82-61-199-210.retail.telecomitalia.it. [82.61.199.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc88esm55996075e9.46.2024.10.21.05.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:41:32 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v7 0/8] iio: add support for the ad3552r AXI DAC IP
Date: Mon, 21 Oct 2024 14:40:10 +0200
Message-Id: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKpLFmcC/x3NTQqDMBRF4a3IG/dCkib2Zyulg1if9kKJkogVx
 L03dPhNztmlaKYWuTe7ZF1ZOKWKy6mR1zumUcG+Wpxx3hpn8eWM7oPYn0NwGXEjVgNywqJlYRo
 Rgh/am/Wt6a5SO3PWgdv/8Xgexw/22DticwAAAA==
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

Changes in v7:
- add per channel offset and scale
- change dac clock rate considering always buffering and DDR 
- fix axi-dac fdt property conditionals 
- fix getting clocks from high-speed driver, with a NULL as fallback
- fix missing dma buffer free callback
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
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |  69 ++-
 drivers/iio/dac/Kconfig                            |  14 +
 drivers/iio/dac/Makefile                           |   3 +-
 drivers/iio/dac/ad3552r-common.c                   | 248 +++++++++
 drivers/iio/dac/ad3552r-hs.c                       | 547 ++++++++++++++++++++
 drivers/iio/dac/ad3552r-hs.h                       |  18 +
 drivers/iio/dac/ad3552r.c                          | 556 +++------------------
 drivers/iio/dac/ad3552r.h                          | 230 +++++++++
 drivers/iio/dac/adi-axi-dac.c                      | 322 +++++++++++-
 drivers/iio/industrialio-backend.c                 |  78 +++
 include/linux/iio/backend.h                        |  17 +
 12 files changed, 1607 insertions(+), 502 deletions(-)
---
base-commit: 9aa2ae2926c35263df81ddde5f051627421eab03
change-id: 20241021-wip-bl-ad3552r-axi-v0-iio-testing-554f691460b8

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


