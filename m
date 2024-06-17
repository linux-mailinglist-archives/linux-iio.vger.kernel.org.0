Return-Path: <linux-iio+bounces-6432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D65890BD3F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 00:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33E81C20D39
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F51991BA;
	Mon, 17 Jun 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeXignhI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38797492;
	Mon, 17 Jun 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661963; cv=none; b=LF/PLNSSChYzCGBoYkL6KFP1+ND7DnEK51WlDSuohBT5MlPlDBxVFUthetHmDDUls6k4ZioIsSunRi2izy7Vk5dKmzAA93gkmzj0QXN/yRaLAn/mQF2XGNeSbvq/K63aiWE6CTDuaSDaDz4mCoFQ4P0m+w4hUqdsAMT3qEra9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661963; c=relaxed/simple;
	bh=/hWPDOnmI2yUJYDl5gQyCSpT+WA3huxuW9NK3NL7qIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G07agkY9YrrqI9s5jVayZZkH7t4qNy7Vd8+X69QoV8Vxw34aTIZ4E2Gonk/nlQK68vYDvSfg9IrPBWMJAYpW5Giwevh8H2u/gPQjthgZGDAOq95NkLo4YkZzLMJlubjS8K2eOZJ3fgyWeg4lMVilXw8WBc69KP4dxtnmUIPqcfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeXignhI; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-250ca14422aso2670408fac.0;
        Mon, 17 Jun 2024 15:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661961; x=1719266761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/Su6zOhJKHHuZVcMf95zxNGwUW/D3aqWfw+kVjdFyg=;
        b=jeXignhI5iwKigMsJ0zWKjYKfdGVi5EU0fTlYToCpGD7GCv++CceVg+feHT/jdb/Wc
         9/o3uAdvDkpwc8fD8mFqA42H1GI81oCK8LqVf5SuZPydFPzwK44CEu6g7+r+OXfSakif
         6FUbv9C2w7vW2QTcwfglzSnuh3dA5FRSdVqJulGBRaeusPzOn5tGgq6WMgaZ6CiIgA/C
         JPqQkESZlck+JA6G9JRA9cTSx7RRDb9sBZqgRJD30Qjt7qT2v6qstT5XtZL8M2mErTJk
         bUUKq8BLf2mTx2dw5wvSs1kUKB7ae5wB2gnEZl/UcWAZPD+cM84IOEU5Oc6BOaM/LdNa
         vQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661961; x=1719266761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/Su6zOhJKHHuZVcMf95zxNGwUW/D3aqWfw+kVjdFyg=;
        b=nHxXRYRPHs6TF7Cpe74Bqh7zHR0Z430dgRG1GVxOYJKrHCjd5stFLT2hQBdg/133ap
         9O/t/oyGU3wgLYxrR9UKo4jx/H0zE9vipGP047rpdDqstv8qqknbiw1WU0mHl8Wdo8m1
         7z5vBDKm9XpV1qd1v8X164jmIDryawBBagpVcOwekUvdQAsW0HBAddy9PINpEf8eWWnK
         EQLnP1gfDgj974ji2ITP/UGMBuFDeqhTMve0zeeScumiK9uKWELhY7/4kefjdWhoxJaj
         58pRCCnkcuOG73sn0z9uMilTl6voMceI3aygcbwmLgnvHAY0EVWHh/UtxZAsS1hQ4BRV
         IZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYOkptTrVhtTY+4OJrTk2JBlHhonSxTsKgmDAmGXbNj1H52y+ejf1esMtOqH1bPKN8MjAxpox/XEDSs6NFVMqSMG8HZBplusdINYm1FTpePlOpqvzXmFWVXpqCnL3MMu6cSpr1zg==
X-Gm-Message-State: AOJu0YyjZI5Zjz3J2GJ5KKnifWuwpoHvYmWeCb8lFlkpBaQE27P9Dto3
	toTgKY9FCe4MiVLwfsNGgjVIQLEHtR8mPp7bNahCyHMiP0a0gyzP
X-Google-Smtp-Source: AGHT+IGTkEJLjAQsBDyPVepbzS96rgjLZUNQCfs/a/TVEyMYrXfJ/EQuJc6ranGmaMtM25H5ZoBEcw==
X-Received: by 2002:a05:6871:5c9:b0:24f:ee90:4556 with SMTP id 586e51a60fabf-25842552a80mr12620848fac.0.1718661960812;
        Mon, 17 Jun 2024 15:06:00 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b0fa8sm1664232a34.28.2024.06.17.15.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:06:00 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	broonie@kernel.org,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/8] Add Battery and USB Supply for AXP717
Date: Mon, 17 Jun 2024 17:05:27 -0500
Message-Id: <20240617220535.359021-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for monitoring the USB charger and battery charger on the
AXP717 PMIC. This required some driver refactoring of the axp20x USB
and battery charger as the AXP717 is somewhat different but can still
benefit from some common elements.

Note that as of now the charging current now value may be incorrect as
the scale and offsets were not documented in the datasheet. I suspect
the scale is 1 and the offset is somewhere around 450mA though.

Please note that this patch series relies on the following series being
applied first [1].

[1]: https://lore.kernel.org/linux-sunxi/20240418000736.24338-1-andre.przywara@arm.com/

Chris Morgan (8):
  dt-bindings: iio: adc: Add AXP717 compatible
  power: supply: axp20x_usb_power: Add support for AXP717
  power: supply: axp20x_battery: add support for AXP717
  mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
  iio: adc: axp20x_adc: add support for AXP717 ADC
  power: supply: axp20x_usb_power: Add support for AXP717
  power: supply: axp20x_battery: add support for AXP717
  arm64: dts: allwinner: h700: Add charger for Anbernic RG35XX

 .../bindings/iio/adc/x-powers,axp209-adc.yaml |  10 +
 .../x-powers,axp20x-battery-power-supply.yaml |   7 +
 .../x-powers,axp20x-usb-power-supply.yaml     |   6 +
 .../sun50i-h700-anbernic-rg35xx-2024.dts      |  21 +
 drivers/iio/adc/axp20x_adc.c                  | 167 ++++-
 drivers/mfd/axp20x.c                          |  30 +-
 drivers/power/supply/axp20x_battery.c         | 580 ++++++++++++++++--
 drivers/power/supply/axp20x_usb_power.c       | 350 +++++++++--
 drivers/regulator/axp20x-regulator.c          |   2 +-
 include/linux/mfd/axp20x.h                    |  26 +-
 10 files changed, 1102 insertions(+), 97 deletions(-)

-- 
2.34.1


