Return-Path: <linux-iio+bounces-8244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F2F9476F4
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 10:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9695A2812E2
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207614D456;
	Mon,  5 Aug 2024 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="HCq9Lgcn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039771494C8
	for <linux-iio@vger.kernel.org>; Mon,  5 Aug 2024 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845578; cv=none; b=aTod4BdvK5W7bFo1Zfiz5/JMGZHubkoYwIu78zLXAq3LZgWS6dSaZNGklUcbj7Stjdw7VxSSTRZvGGDC4hAiAKDGVxcdmdiMPqJc87VNMq5Cajq9hkg5kTvwHLh9ELwOwaZL4HpIt3jKGAAdPbkPBvHSr2pYzz46MKl2aSvCfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845578; c=relaxed/simple;
	bh=owHGD//UoXTaoykC5FYq9tVhxdretYz+VOyQBLd7EWk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N60OgpGXGgDerhU0JyEB471R82n7g3jXve02xXhT84MuTgIc0UumJuttOVoH6aRdBA+Rl87+Kg2FFEPNzi9enRH0Sz+N58N/Vepj3nHSWUhC4nIBB4dLiCm5t3GlMkPsEma6b0CYd7g6XuT5mnd/ezbxQBOg2If/EKPELJ7d2lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=HCq9Lgcn; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so14294495a12.0
        for <linux-iio@vger.kernel.org>; Mon, 05 Aug 2024 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1722845574; x=1723450374; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TA2i2kudlll49z3PF9HU1ldxcPrVQzQkbv1nwGsq4mU=;
        b=HCq9LgcnBEQo/Leo1+dSkhOWDW/JWnykAlhLrB/ZdiriPv902X9mNrrgzyXy2OThU8
         2PViczS2NfIsdWm52lIfn8VRx7Q7s2Hac9m07+Nkeu3B0YOTB9MtuMgGAkSDXW3e1wep
         jS1A01iOqVbuMroNI+xeRsNjJgHiXUjJ8XkeLSnMxMqZk/t96M9k1dNePME0rrZxd5Jc
         WIiStlDCCOuPba2kw1gN4VIrK6Z+fs+YH8qZg040PzjmiDWxHbLET9qtX/If1a64iqKH
         T/15UoiwGIem9TidfszJvPZSheKFukUeO0WblAM5ZlRz86EGEP4HO6Zjkg1WOv79eAQY
         3ZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722845574; x=1723450374;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TA2i2kudlll49z3PF9HU1ldxcPrVQzQkbv1nwGsq4mU=;
        b=QcUn/lhe3Wvvq9/vackRjezV9rDpiPA4dfbJeBF++YlIttelGAF/EF7GflxuHIo2Ar
         jCQ/1ebsBJkvDZjIsSojp41i2DS9c1gWffdO4ViRg+kfIdlSPv9eIVcsPvJ24Pod2sHx
         WG8+N1YdoJzP7Oiim8zW33wHDpA7xI4Gljq6vT4geKzKUTKTHUQcjKiUkFSzLPDUSkGs
         6NyZtxggLtcVOeJgD8j9Dd3+JYXQfkY2US0VjHz8AGOs3dHpeJZmXvHsKtfRzPxIt34D
         Ipf8GcY0LmDMgsTWsbW3tloatv43hCnFiCNWGPlZ2Rc5AbGmI5S7Y0HfRHFnPJVyMXNi
         o47A==
X-Gm-Message-State: AOJu0YwbD7NhYzO277dzQQJZa4koJHdfo1Pts24lEMDCFqPi9Hk40Csb
	UioWRdbyr4cPllTdcH0m1X5C/vK54WA/hTtSdltf8ZmrUK5cTEcmOYY4AvmYMFw=
X-Google-Smtp-Source: AGHT+IFjFtuXHfQiKpQPW0jaixqmRSd6ZYDq8VMWqKtP+zHDIODuYF1n9QofmYIAAUAe5GaCkEPaGw==
X-Received: by 2002:aa7:cc90:0:b0:5a1:a36a:58ba with SMTP id 4fb4d7f45d1cf-5b7f40a92d6mr8038471a12.20.1722845574068;
        Mon, 05 Aug 2024 01:12:54 -0700 (PDT)
Received: from carbon.local (catv-86-101-168-118.catv.fixed.vodafone.hu. [86.101.168.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bb88d1d9a3sm1231565a12.26.2024.08.05.01.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:12:53 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Subject: [PATCH v6 0/2] iio: humidity: Add support for ENS210 sensor family
Date: Mon, 05 Aug 2024 09:12:51 +0100
Message-Id: <20240805-ens21x-v6-0-5bb576ef26a6@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOJsGYC/33PQW7DIBAF0KtYrEs0HrBNsuo9qi4wHjCqYlLAV
 qrIdy+11SiLNiv00debmRtLFD0ldqpuLNLikw9TCe1LxcyoJ0fcDyUzBJTQwZHTlLC+cmWxEXB
 sy0uslC+RrL9u0Nv7niN9zsXL+yfrdSJuwvns86nKwUVy7Kc5+pRD/No2WHCr7sNq+B22IAeuR
 WcQoVY9mNc8kgthuNDkZj8dTDjMH5u2iL8FUQRJwvbGou5s/0SQj8L94EUWoQUpSaqySqufCM2
 DgHgXmiKYQSs1GKoB6B9hXddvPMr85ZcBAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722845573; l=4408;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=owHGD//UoXTaoykC5FYq9tVhxdretYz+VOyQBLd7EWk=;
 b=FI6u+rzKyUIB2oGI1E2gNFwn2dB/hYwIbtKWbj8ksnNZpnzl/IgC5HwHU8kBTxBqpRyt+k/M+
 pL3eygmr8QUAl2yWCQwmq6Bs/zVxXuAkoPLN0FbCQ3IPvmhGkDzuosT
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

This patch series adds support for the
ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215 temperature and humidity
sensors.

Patch 1 adds the required device tree bindings.

Patch 2 adds the driver, providing the probe and read functions.

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
---
changelog v5->v6:
- ens210.c: Improved description to i2c lock
- ens210.c: Fixed line wrap formatting
- ens210.c: Removed unnecessary comments
- ens210.c: Removed unnecessary else if
- ens210.c: Fixed incorrect cast
- ens210.c: Used GENMASK instead of 0xffff
- ens210.c: Removed rel humidity offset bit
- ens210.c: Fixed erroneous break
- ens210.c: Add error check to write
- ens210.c: Fixed general code formatting

- Link to v5: https://lore.kernel.org/all/20240722-ens21x-v5-0-cda88dce100e@thegoodpenguin.co.uk/
---
changelog v4->v5:
- ens210.c: Updated ens210_data description to reflect values
- ens210.c: Updated dev_err to always use i2c device
- ens210.c: Check T_VALID before returning data
- ens210.c: Fix short linewrap on certain lines
- ens210.c: Added unreachable instead of unreachable return
- ens210.c: Fix sparse warnings
- ens210.c: Remove unneeded i2c_device_id
- ens210.c: Remove unneeded i2c_setclientdata()
- ens210.c: Simply return 'dev_err_probe()' instead of raw error code
- ens210.c: Fix dev_info print type

- Link to v4: https://lore.kernel.org/r/20240719-ens21x-v4-0-6044e48a376a@thegoodpenguin.co.uk
---
changelog v3->v4:
- rename ens21x.c -> ens210.c
- rename sciosense,ens21x.yaml -> sciosense,ens210.yaml
- General: Changed wildcard ens21x to ens210 to avoid wildcards
- Kconfig: added crc7 as a dependency
- Kconfig: remove extra blank lines
- ens210.c: Moved constants to inline
- ens210.c: Created ens210 chip info to handle chip specific conversion
- ens210.c: Added documentation for mutex
- ens210.c: Fixed sparse complaints from kernel bot
- ens210.c: Changed htonl to cpu_to_be32
- ens210.c: Renamed dev_data -> ens210_data
- ens210.c: changed of_match to i2c
- ens210.c: Added return check for i2c write
- ens210.c: Removed switch for conversion check, use chip_info instead
- ens210.c: Removed unnecessary retry loop
- ens210.c: Convert read to u8[3] type
- ens210.c: Ensure 'correct' path is inline, use early returns to break
    for errors
- ens210.c: Changed mutex to scoped_guard
- ens210.c: Changed part id mismatch to dev_info from dev_err and removed
    return
- ens210.c: Moved name from id->name to chip_info
- ens210.c: Changed data field to be chip_info rather than enum
- ens210.c: Formatting fixes (consistent spacing, extra line break at end
    removed)

- Link to v3: https://lore.kernel.org/r/20240710-ens21x-v3-0-4e3fbcf2a7fb@thegoodpenguin.co.uk
---
changelog v2->v3:
sciosense,ens21x.yaml: Update yaml to match dt_binding_check

- Link to V1: https://lore.kernel.org/all/20240709-ens21x-v1-2-678521433cdd@thegoodpenguin.co.uk/
- Link to v2: https://lore.kernel.org/r/20240710-ens21x-v2-0-a37c22018b0c@thegoodpenguin.co.uk

Many thanks for the feedback on the driver.
---
changelog v1->v2:
sciosense,ens21x.yaml: Add supply to documentation
sciosense,ens21x.yaml: Add fallback to compatible strings
ens21x.c: Move i2c_device_id next to of_device_id
ens21x.c: Use i2c_of_match_device() instead of of_match_device()

Many thanks for taking the time to review my patch.

Thanks,
Josh

To: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

---
Joshua Felmeden (2):
      dt-bindings: iio: humidity: add ENS210 sensor family
      iio: humidity: Add support for ENS210

 .../bindings/iio/humidity/sciosense,ens210.yaml    |  55 ++++
 drivers/iio/humidity/Kconfig                       |  11 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/ens210.c                      | 338 +++++++++++++++++++++
 4 files changed, 405 insertions(+)
---
base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
change-id: 20240709-ens21x-8f2530968f2e

Best regards,
-- 
Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>


