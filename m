Return-Path: <linux-iio+bounces-6863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF493915C3C
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 04:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5111A1F22723
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 02:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8092D600;
	Tue, 25 Jun 2024 02:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moVfdSRj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F4845018;
	Tue, 25 Jun 2024 02:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282683; cv=none; b=lJzA/Tg76y9e+91XhpZ5b0wO62BZLdhm99h+qvIKY/TsiQ32ZORDpNk07uGUc8xp2RyzQHGQds/lDnGD9AjhKeC3uWqscVwhOwgS7sErSNjnZwrEZoDsoYjarKNIeVa5sVnfsUkw008KGAr6ehrltbqZXbEgkoev+U6lpRfE7Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282683; c=relaxed/simple;
	bh=/1DNDeOKg177bS8nmSRJq7/0hF6aKB2PsUcmK2wMrIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r1cfhhkHADfg6NP2bXwfBeus1GZaPqIWqF+D+SyRr5KMFSKoUXZTtmM1s/erNAJckv4gUxD1EBMwsYDJ8w/2Ks3GJg2oqp1UIbdg7dXGCHENlec6sYVyDgugq5fVdfe7fRfxrNi6o4CxVLBZzAAydiu2DKoXcK5ZTsjHyFzrNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moVfdSRj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7066cba4ebbso1653710b3a.3;
        Mon, 24 Jun 2024 19:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719282681; x=1719887481; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBw7lNH2ym/ZMOFBd98xTuLuYzJbUvYI5f6jVXCpiB0=;
        b=moVfdSRjghp36/oZDQf1hBhCO1k3canxyyDHsmJ5rhKnQbzy9J6tNSl76ayaAVr0Zu
         9gwFibIIyiLjQnb6bKO+SQoBBEKbLKhT1PDVmcdjwIfgxasDmj7Elk/Oo4FornacWDV2
         IXJ2TqLAeYeRMO9MtmzNXk5OXBnU2qrMj0K7X1KbgGgChTcRsMGWncQMy+e9UT/WxxXd
         qnTJlKJctYKoyoBp6GwqG7StawHKQtbUgj1OoqAuay2eow2ws/3bpX6QV/Q6e9VVn4zc
         SYkSLQA0HdZog1EHrQOCHKd7NbvgHPVphvt0UkiqiGMOHhIr7nyl4fCziD6h8j7T4VJJ
         TEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719282681; x=1719887481;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBw7lNH2ym/ZMOFBd98xTuLuYzJbUvYI5f6jVXCpiB0=;
        b=m2vrFaRGlQ7FI4WRbweVc71qwDLRo4IBgxx5uS/xauB3kCDoHsgNBYkUMsUtv5CzIu
         zFUibDCikDIXkSmRKl7+yudbpRRXoygsVCQEkiR7H1QyqahYP099NQM/AFTdHldrd4s3
         enBwldvQzhNEemSEo/1evXXWCAFf/PFMX/snZd0NW2xTsXKQUeBzHn3biLTBWJfCeMQW
         VmdW+5Pr94lMC3kfLho8j4ScuJnfqJKDY+sE8F1JFcC+D2QNbzEwHXXWSYXAn2KnXr3E
         ZGuzd9hfFQrXgi6n6GD6TJ3UX2aRsx1An92iYkm/FRuLO7uutTWYX4kKHHuehvL07nHC
         JHXA==
X-Forwarded-Encrypted: i=1; AJvYcCU26WHoikSMyQVD8r6oL69TPnMjqyRHwuK4j39tUAtWX05CsPCxMHSFifqjQeodayo0CjM96t8al0RE9+s+haJdfmO+l/y3l1RCongBlookmaRmFWbSBsJ0C0M6x6tnfhpNhPXayyk3
X-Gm-Message-State: AOJu0YzZQsOpUgCOXK+bSPgaD1eLoFsEkJGwExWVhPrqhJbBvByJ38JI
	ihKSE2Jv0zjwMgPyLuqyPej/2ayhMSNm2X2iZGAei5Wr2OY9wgcb
X-Google-Smtp-Source: AGHT+IF+VB6cd1uxmBnpN7QTXctaq1LDfIpWfLlJmUqc1L+ycpkdhGBF/a7Jy2FU9YTlkowDnFuURg==
X-Received: by 2002:a05:6a00:80f7:b0:706:68ff:2bce with SMTP id d2e1a72fcca58-7066e4e6825mr5761481b3a.2.1719282681025;
        Mon, 24 Jun 2024 19:31:21 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70677949b97sm3582945b3a.140.2024.06.24.19.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 19:31:20 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Subject: [PATCH v7 0/3] iio: proximity: Add TYHX HX9023S sensor driver
Date: Tue, 25 Jun 2024 10:15:09 +0800
Message-Id: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0oemYC/5WQsW6DMBRFfyXyXCM/g22cKZjQrVXVjlUHEptgN
 WBkU4so4t9LyFR1qDqe967Ole4VBeOtCWi7uSJvog3W9QuIhw06tnV/MtjqhRElNCMcOK61xuO
 lnXA7SULTgIPpg/NYexuNx0bog0kPjWGSo0UyeNPYaS14/1i4tWF0/rL2xex2RW/P4uUV6JPKg
 QCV+xxyoqCUTKZFXhGRF9mjorsfsaSvu8FroMngnU7c13h27jM5ug7dWiL7bVZ8TwoFNONCipK
 LijJVZGX1TzNfzfc5KPw1R+SYYM5A8np5kwZ2p66257tunudvtdYse4ABAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719282672; l=7636;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=/1DNDeOKg177bS8nmSRJq7/0hF6aKB2PsUcmK2wMrIA=;
 b=jA6y6xDqaKas7tKSyIupdILLo+cnTsaeTpI2xldY/G0dHGKYT8W6iQFBsQPefeJIWLlUXZPNo
 wEU9v7mWSYwCTVEUcR5yrzdw1KO4aOOpedE1VrO5W0SZ+Ww4hTTQ1QG
X-Developer-Key: i=yasin.lee.x@gmail.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
Changes in v7:

**tyhx,hx9023s.yaml:**

- Removed the unused reference to iio.yaml
- Removed the `input-channel` property and switched to inheriting the `single-channel` property from adc.yaml
- Sorted the items in the `required` list

**hx9023s.c:**

- Header Files Section:
  - Added `<linux/cleanup.h>`
  - Removed `<linux/delay.h>`
  - Replaced `<linux/math.h>` with `<linux/math64.h>`
- Register Initialization:
  - Deleted the `struct hx9023s_addr_val_pair`
  - Changed the type of `hx9023s_reg_init_list` to `struct reg_sequence`
  - Deleted the `hx9023s_reg_init` function and used `regmap_multi_reg_write` for register initialization in `probe`
- struct hx9023s_ch_data:
  - Added a comment to the member `mutex` explaining the data it protects
- Function hx9023s_sample:
  - Fixed the error related to `hx9023s_data_lock` calls
- Function hx9023s_property_get:
  - Added boundary protection for `reg`
- Function hx9023s_id_check:
  - Optimized the function
- Function hx9023s_probe:
  - Changed the call to `devm_iio_device_register` to `return devm_iio_device_register()`
- Functions hx9023s_suspend and hx9023s_resume:
  - Added `guard(mutex)(&data->mutex)`
- Code Check:
  - Ran `checkpatch.pl --strict` and fixed the identified issues
- Link to v6: https://lore.kernel.org/r/20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com

Changes in v6:

**vendor-prefixes.yaml:**

- Formatted the description in the commit

**tyhx,hx9023s.yaml:**

- Added a link to the DataSheet
- Added `#address-cells` and `#size-cells`
- Removed the following properties:
  - `channel-in-use`
  - `channel-positive`
  - `channel-negative`
- Corrected the reference path to `adc.yaml`
- Inherited `diff-channels` from `adc.yaml` as differential channels
- Added `input-channel` property as a single-ended configuration channel
- Made `vdd-supply` a required option
- Used the generic name `proximity` instead of the chip name in the DTS example

**hx9023s.c:**

- Removed the following headers:
  - `#include <linux/acpi.h>`
  - `#include <linux/byteorder/generic.h>`
  - `#include <linux/kernel.h>`
- Added `#include <asm/byteorder.h>`
- Updated some macro names:
  - `HX9023S_DATA_2BYTES` ---> `HX9023S_2BYTES`
  - `HX9023S_DATA_3BYTES` ---> `HX9023S_3BYTES`
  - `HX9023S_DATA_BYTES_MAX` ---> `HX9023S_BYTES_MAX`
- Added the following macro definitions:
  - `#define HX9023S_POS 0x03`
  - `#define HX9023S_NEG 0x02`
  - `#define HX9023S_NOT_CONNECTED 16`
  - `#define HX9023S_GLOBAL_CTRL0 0x00`
- `struct hx9023s_ch_data`:
  - Added comments explaining the members `raw`, `lp`, `bl`, `diff`
  - Changed the type of struct member `thre` from `int` to `unsigned int`
  - Removed member `cs_position`
  - Changed the type of `struct buffer` member `channels[HX9023S_CH_NUM]` from `__be16` to `__le16`
  - Moved `struct hx9023s_ch_data ch_data` to the bottom
- Updated comments in the array `hx9023s_reg_init_list`:
  - Changed `adc` to `ADC`, `avg` to `average`, and `osr` to `OSR`
  - Provided a more detailed comment for the register `HX9023S_RAW_BL_RD_CFG`
- `struct regmap_config hx9023s_regmap_config`:
  - Added `.rd_type` member
  - Changed `.cache_type` from `REGCACHE_RBTREE` to `REGCACHE_MAPLE`
- Bugfix: The function `hx9023s_data_lock` now only operates on one bit instead of two
- `hx9023s_ch_cfg` function:
  - Replaced magic characters with meaningful macro definitions
  - Changed byte concatenation operations to use `put_unaligned_le16`
- Reviewed each function and made the following changes:
  - Some returns now directly return `regmap_read/write()`
  - For single-byte write operations, changed from `regmap_bulk_write(,,,1)` to `regmap_write(,,)`
  - Changed the type of loop variable `i` to `unsigned`
- `hx9023s_write_far_debounce` and `hx9023s_write_near_debounce` functions:
  - Removed magic numbers and optimized the code
- `hx9023s_get_thres_near` and `hx9023s_get_thres_far` functions:
  - Used intermediate variables for readability and simplified the code logic
- `hx9023s_set_thres_near` and `hx9023s_set_thres_far` functions:
  - Optimized the logic and simplified the code
- `hx9023s_get_prox_state` function:
  - Changed the return value type to `int`
- `hx9023s_data_select` function:
  - Changed the return value type to `int`
- `hx9023s_sample` function:
  - Added intermediate variables for better readability
- `hx9023s_ch_en` function:
  - Optimized the code logic to reduce line count
- `hx9023s_property_get` function:
  - Rewritten due to DTS changes, and calls `fwnode_handle_put` on error to prevent memory leaks
- `hx9023s_get_proximity` function:
  - Added error handling logic for data
- `hx9023s_get_samp_freq` function:
  - Used macro definitions from `units.h` instead of specific numbers for frequency calculation
- `hx9023s_set_samp_freq` function:
  - Used macro definitions from `units.h` instead of specific numbers for frequency calculation
- `hx9023s_write_raw` function:
  - Changed the type of local variable `dir` to `unsigned`
- `hx9023s_write_event_config` function:
  - Replaced `set_bit` and `clear_bit` with `__assign_bit`
- `hx9023s_trigger_handler` function:
  - Added error handling logic for data; fixed uninitialized variable `i` bug
- `hx9023s_buffer_preenable` function:
  - Fixed uninitialized variable `channel` bug
- Added `hx9023s_id_check` function
- `hx9023s_probe` function:
  - Returns directly on `devm_iio_device_alloc` error, without logging; removed `fsleep`
- `hx9023s_resume` function:
  - Calls `hx9023s_interrupt_enable` only when `data->trigger_enabled` is true
- Removed `hx9023s_acpi_match`
- Link to v5: https://lore.kernel.org/linux-iio/SN7PR12MB8101B6D0AB1246797C67E25BA4CE2@SN7PR12MB8101.namprd12.prod.outlook.com/

Changes in v5:
- I have addressed all the issues mentioned in the email responses.
  Additionally, regarding the IIO-related header files, I have checked and found no unused headers.
- Link to v4: https://lore.kernel.org/linux-iio/SN7PR12MB810129D8180B1C9593A8E078A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com/

Changes in v4:
- Removed hardware-irrelevant properties from dt-bindings, retaining only channel configuration
  related `channel-positive` and `channel-negative`. Grouped by channel.
  Retained `channel-in-use` as it is hardware-related.
- Removed redundant register definitions.
- Reorganized `struct hx9023s_data`, extracting channel-related attributes
  into a new `struct hx9023s_ch_data`.
- Optimized bit operation related code.
- Replaced `of_` versions with generic firmware parsing functions.
- Fixed other issues mentioned in the email feedback.
- Link to v3: https://lore.kernel.org/linux-iio/20240602152638.2c674930@jic23-huawei/

---
Yasin Lee (3):
      dt-bindings: vendor-prefixes: add tyhx
      dt-bindings: iio: proximity: Add TYHX HX9023S
      iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor

 .../bindings/iio/proximity/tyhx,hx9023s.yaml       |  107 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 drivers/iio/proximity/Kconfig                      |   14 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/hx9023s.c                    | 1131 ++++++++++++++++++++
 5 files changed, 1255 insertions(+)
---
base-commit: 0291f73eaa59fe0dbb715fa405bb47a1d8206e0e
change-id: 20240616-add-tyhx-hx9023s-sensor-driver-e7dbe3bfe596

Best regards,
-- 
Yasin Lee <yasin.lee.x@gmail.com>


