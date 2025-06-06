Return-Path: <linux-iio+bounces-20264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA45AD03D5
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 16:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FA2189979F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1019169D2B;
	Fri,  6 Jun 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UmOUUv44"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED627453
	for <linux-iio@vger.kernel.org>; Fri,  6 Jun 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219640; cv=none; b=Zo07LdC4ffI3Evgo7XXfcsUSUj9jJ6WJtWX9aV3vcunLEgbu3xGU/3jeFnJuY5OZuNsssgbFM+N8eLDG7xCErgam+AX/MpXeIVmYUPHT5NnyH7WT7v+BAnD+IG4uRBMwMXZ2+EJ1pCqfslxXlK331/pPbop79JmdNTrCzd2O0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219640; c=relaxed/simple;
	bh=OZrzbP1SbRGVb+WCBZuIR/Xx/XISjeOLbhSk+S2W58Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MmMQydwgvYeHf923+hkEcgbJ94V98MC6WpSDxxfw0VYOxfoUP6aTVM8ZXNOI2lqCGUn4x//9NuL1ilL9ABhpadEKlaNm3hVEKCg3fi8+hgzeB06TQ/lKYYNookdpmAUTMbpnI7urxqHOvDSWCgF+2u44LUa24GzyLFrkuqSNu8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UmOUUv44; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so28022525e9.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Jun 2025 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749219636; x=1749824436; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjGat8Y0B+/GQXbzYuSVj2PQ8u5SUEo0nANMq38jBNs=;
        b=UmOUUv449ZyMaqDfiJp/kfQVa3KlZ4Mfm+GHWHmAg5mvwjEj6CPFOMgQ7nwKflJV30
         nvzy6WzssR+1wytBI9Ox4PH+TT46Ai9Ro7yftLqORivvWTlRW1ne7g+Em6oF2y54weHD
         124uvlTxfodVPb7kgI2hiISVNd8N6A98OIxnitemKBIztrFQZE3tPrGR2/wqoahSImrL
         ZgbJ6F/aJvcM5pYGCxooGDfHbRDGm0Bh3IVjhZxGLvFZ9PiIqx9RRl/m4C3/+MwIkooQ
         cnkPxmLeO37IzQrgUoUrAp4uOpGeuGJHdWNmAeDIrYz6Tus5Mz2fLI1a1lq27YmQsfDG
         BWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219636; x=1749824436;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjGat8Y0B+/GQXbzYuSVj2PQ8u5SUEo0nANMq38jBNs=;
        b=LVjgq5O1JJUM/24CyYb3yBuiNDQQcS6KJInkhvJk75FEdQZkGgBI+pypTn1oIkTr+o
         GUJXuSiOzF+Ti17bEMRO+IJq3jhoHf/9+Ks1HECWbYf63wLN967QjpHzUYHopMygVTdP
         RL1jnmnrtda3f2hwftfXtTDRiiLRlAvt0nSHhUFEPwxBzgqALrnLFM41p/NlE2KY/TRz
         53F5+VmjDYOzfepU1pBY6kKkJWKl7Y6B7hRZBhKrfBM/pRLEGdKKi7nVneOvccpRbYsv
         y2/8wjcKQ4jnlPxumokiG31Cgou4PqssPFdm0fSfprlxJuniNBEfNT9fouxEvek51KbJ
         DHdA==
X-Gm-Message-State: AOJu0Yx85LRVbOEFZAPv37d1gANU03blIFKEyp7yCMYWSmcdZcjlsrqx
	YD13aVy6/tscDIEcSW9p/JlvaoKwemqdxOkz06GdqISaNlwqZtYDvAf6ZYJJzTumNU0=
X-Gm-Gg: ASbGncuX6FjE/m3RjvR3Q5dpNnoGUPKThQ5mkFIuwfi9ZIyvbYRoc782yDpZqEshmbD
	kXmZqYBSZVi77zvguAT3qvucMcrl4vDdXAad8i7Ca9NXWWVDQ+LyOHmhUWfoMhfk22IWLMjoz8m
	CuuepIQwSbNX1shP4a0fDgIjqgBxe6jv36NFvvnIzdhjykGq+vsf10qgiz5Idkj+UN0VVI8BtYw
	HCfizUWty1kchvzfebWq/Tf5zolVA1O0+l1+UsRC86cQU+813ucwbAhapNope95zAlfmgi3cZYR
	7DBpoIg5nmfFuzsSzFQlofSOnuUBXaoMseGXeMlJvRRoimKqCAT2WxFH3FcxUrYtyBgFWSZwVb7
	yzOg6eA4nq4NDzO76v1lOdYeX+zryoh+9o0GVwTkoNw==
X-Google-Smtp-Source: AGHT+IGAmJ6OQn+Rk5+zosv7byWwapXctFy1BWUaDJa55qiK+0N+TiLKkkIXrOnKe/WuXhNlWgKrQQ==
X-Received: by 2002:a05:600c:3492:b0:440:6852:5b31 with SMTP id 5b1f17b1804b1-45201391186mr44123055e9.10.1749219635948;
        Fri, 06 Jun 2025 07:20:35 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213754973sm25686345e9.35.2025.06.06.07.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 07:20:35 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v9 0/7] iio: adc: add ad7606 calibration support
Date: Fri, 06 Jun 2025 16:19:15 +0200
Message-Id: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOP4QmgC/43SwWoDIRAG4FcJnmsZR9fRnPoepQd1tRHSbNgN2
 4aQd+9sLlnKIj3+ynzKz9zElMeaJ7Hf3cSY5zrV4cTBv+xEOoTTZ5a15ywQsAODXn7Xs4xHGXq
 yYGUKxxrHcOEpiRC0t8GC7lDw/HnMpf487PcPzoc6XYbx+nhqVsvpf9RZSZA5mt44VFERvsVwX
 a7zaxq+xALP+MQ6wBaGjCkysYdQwKm4gek1ZluYZszmSNFmQg20gZk15lqYYcyroAs6Tdlu/ax
 bYarZWceYgc6URMkX3W9gdoVhszO7YI6iB6N1H2ADozXW7IwYi6wBYsrK+w3MPTHepRbmGENNK
 pMCV/Tf1bjf779NyXBC4AIAAA==
X-Change-ID: 20250429-wip-bl-ad7606-calibration-20a396a60352
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4039;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=OZrzbP1SbRGVb+WCBZuIR/Xx/XISjeOLbhSk+S2W58Y=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYshw+vHMaM/+/17cT3Xklqiwa3EGrC55kt28KidmzyQ3I
 eOcUImsjlIWBjEuBlkxRZa6xAiT0NuhUsoLGGfDzGFlAhnCwMUpABN5uJqRoedd0cojHl2xb8oD
 zpy4VH7L92pY0lr15JJI98ZoT+nPWYwMpwKDQx4KyniXHuR6eWb9os9lquLnxZ7Mzl3mb3w8Wle
 XAQA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

Add gain, offset and phase (as a delay) calibration support, for
ad7606b, ad7606c16 and ad7606c18.

Calibration is available for devices with software mode capability. 

Offset and phase calibration is configurable by sysfs attributes, while
gain calibration value in ohms must match the external RFilter value,
when an external RFilter is available, so implemented through a specific
devicetree "adi,rfilter-ohms" property.

This patchset depends on:
https://lore.kernel.org/linux-iio/20250505131544.0a7477a2@jic23-huawei/

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v9:
- add patch 6/7 changing chan_scale to a more generic chan_info, 
- parse gain fdt property in existing function, to reduce code.
- Link to v8: https://lore.kernel.org/r/20250603-wip-bl-ad7606-calibration-v8-0-2371e7108f32@baylibre.com

Changes in v8:
- fix bug related to wrong calib gain setup,
- fix return value on wrong "reg" read from fdt on calib setup,
- fix commit messages/titles,
- add new function to write calib gain on ADC registers after reset.
- Link to v7: https://lore.kernel.org/r/20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com

Changes in v7:
- Fix each wrong commit desc. occurence related to convdelay.
- Fix ABI documentation with better words.
- Fix wrong comments in driver source code.
- Add r_gain default before reading the fdt value.
- Link to v6: https://lore.kernel.org/r/20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com

Changes in v6:
- exit for error in case of fdt that breaks the dt_schema,
- add (5/6) patch to fix the above on older code too, 
- Link to v5: https://lore.kernel.org/r/20250519-wip-bl-ad7606-calibration-v5-0-4054fc7c9f3d@baylibre.com

Changes in v5:
- fix tab/spaces wrong formatting on ABI doc (1/5),
- fix description in ABI doc (1/5),
- fix code multiline alignments (3/5),
- fix calibration offset calculation as oneliner expression (3/5), 
- Link to v4: https://lore.kernel.org/r/20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com

Changes in v4:
- fix ad7606_chan_calib_gain_setup appropriately to be called once.
- Link to v3: https://lore.kernel.org/r/20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com

Changes in v3:
- fix dt_bindings,
- change sysfs calib_delay to convdelay,
- fix sysfs documentation accordingly,
- used u32 for reg and r_gain,
- used DIV_ROUND_CLOSEST for setting r_gain,
- minor syntax fixes,
- Link to v2: https://lore.kernel.org/r/20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com

Changes in v2:
- change phase_delay to calib_delay,
- fix dt_bindings,
- fix gain calibarion fdt parsing,
- fix ad7606c-18 calib offset range,
- fix calib offset calculation,
- fix calib gain range,
- Link to v1: https://lore.kernel.org/r/20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com

---
Angelo Dureghello (7):
      Documentation: ABI: IIO: add new convdelay documentation
      iio: core: add ADC delay calibration definition
      iio: adc: ad7606: add offset and phase calibration support
      dt-bindings: iio: adc: adi,ad7606: add gain calibration support
      iio: adc: ad7606: exit for invalid fdt dt_schema properties
      iio: adc: ad7606: rename chan_scale to a more generic chan_info
      iio: adc: ad7606: add gain calibration support

 Documentation/ABI/testing/sysfs-bus-iio            |  24 ++
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  29 ++
 drivers/iio/adc/ad7606.c                           | 351 ++++++++++++++++-----
 drivers/iio/adc/ad7606.h                           |  22 +-
 drivers/iio/industrialio-core.c                    |   1 +
 include/linux/iio/types.h                          |   1 +
 6 files changed, 347 insertions(+), 81 deletions(-)
---
base-commit: 351e9e8549a49300e674fc562b4b2a7e4bd74a66
change-id: 20250429-wip-bl-ad7606-calibration-20a396a60352

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


