Return-Path: <linux-iio+bounces-6908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BDE916DA2
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B4BB21203
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9BF16D30D;
	Tue, 25 Jun 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBiZLdzF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3241E880;
	Tue, 25 Jun 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331351; cv=none; b=ZI14ZW1KXvnrao5DUG5cxw/ORY1QgxdKI0QrSfvzXN63x7skL5zZtljuxw9W2Q9zf702yZsYDLZrqRFJy+mLSuE2EXytT3enuIjddeOtWKvaceW4oEqA+9URnh22qjmR89RybiIQ8bx6jeiCT92Mk0f65EXvUhtwj/n1Wg0spNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331351; c=relaxed/simple;
	bh=w3MjqKvXOCvfTZZTK3seK4G6ECGT2Vpba6LHoB4jzT0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KAEyxnxxGGVoxbvCOm7BeS51A5V6tAQyZ353anBZCVYRq4CvczwQgZxOqXZ6w0x/MIF6oxGo7BSy2i5LQm7jc3vAwrUsO808HzWYtvBQYqKmpgPUX859QQ6FSdmgI9UBKNx9tM11bs19tRG70K6vyYL/GQJ6vuYuE+pEoaioObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBiZLdzF; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7182a634815so2801883a12.3;
        Tue, 25 Jun 2024 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719331349; x=1719936149; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/Ah6KTr4qN3qklceLjaouWh+axRQgCE/MoqHAZqywg=;
        b=RBiZLdzFJivWBHwfCCRiXYccdu1W+uXJHW+bwbpSjrvrCqIaCv3RzfeOScxZuBpUuq
         DJxFCncoCJyWWLwmiIMbi8Rl+9XItfvjnl1i0SgVXTnf+lueDbDfkEkfUvi14hlo9Wk9
         RgaRtjq9yyYDhal8Qo73Jxt0rgSsxCUD8IM+I+oK3XoPiHtMJIqrHsQOZVUWHt/0rz8w
         jVNRC7/9UVL/7G5dR0oWsKThdv8ToNOHxpeiMF3x+cjlqLCdOK/OK9Akr8Vw9dV0hHkG
         6wLEBhdfFil68LTH/L2GoiWHnvOvCo1Kjg38ciKeF1OZWJuzYrNshyzjCswkEr4DT1Kk
         rtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719331349; x=1719936149;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/Ah6KTr4qN3qklceLjaouWh+axRQgCE/MoqHAZqywg=;
        b=upi3b2AeroVeuUv/f4ME0DedmruvoV3ksdrYzEI/QY3+OtkOyRp6mH2NYhLKX1NKxC
         9GDlFwZSLNeJsY2kxaz4vD7i5RbcAlai4d/Ubp3+A9K8iPjEqi0XO77fd18uEpQATKOr
         bFsS3/IxB5H1YVy/7qdcQbHR57viRQhGOQsQ9f1fQMsWMnt47H9qXedPhzOZXFwUwCxY
         q5daQDpmlHpYJ7gqOcfQrFBiYqYPKyuV1h2fxd8328LYtUxj+2fRUUh7gHbcpvlARBfN
         P1rY0LQRrMhxp0y6ETlpZJ8LZ3GFkzFXphTC4v4WJaeF8cZWVMUHcab0XZHE49NnaopP
         Zl5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWcfYS7XbhTTiIPbrL37FuaVbkwDjj/2Wtw94NlX4aTNMmu1DR7OCxoejz5ECM4bdvDBwYG1m8XlGgr5w8UtFobJ9xz3XuqMaQ2sgguuYf7wJdXrjvvbpYJCs553l1lCT99d8PafMt
X-Gm-Message-State: AOJu0Yxqj0FoxNC7n8XVgbSNdRv2ymp2Ixxy+2IPB2ONAy/iKQA3th5T
	F7fYjOfGDwWpTcJUhAqk0yl5SQXYY9EhQEBzMObzycYQnu89z/vN
X-Google-Smtp-Source: AGHT+IGPTkSzRYvBzIr+SMsEB/iIU++4/A74QqzdXyJKZuSG3QMsFFZKdvVJlpS/UwCRCg8LA6flyA==
X-Received: by 2002:a17:90b:3bce:b0:2c4:dc4d:83da with SMTP id 98e67ed59e1d1-2c86127e1a0mr6482780a91.10.1719331348755;
        Tue, 25 Jun 2024 09:02:28 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e5af9de9sm10904009a91.37.2024.06.25.09.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:02:28 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Subject: [PATCH v8 0/3] iio: proximity: Add TYHX HX9023S sensor driver
Date: Tue, 25 Jun 2024 23:58:51 +0800
Message-Id: <20240625-add-tyhx-hx9023s-sensor-driver-v8-0-0c224e3bddbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADvpemYC/5XQPW+DMBAG4L8Sea6Rz+CvTgFCt1ZVO1YdIDbBa
 sDIpogo4r+X0KGNOkQd37vT80p3RsF4awK635yRN6MN1nVLkHcbtG/K7mCw1UtGlNCEcOC41Bo
 Pp2bCzaQIjQMOpgvOY+3taDw2QlcmrmrDFEcL0ntT22kteHtfcmPD4Pxp7RuTyxS9PonnF6CPm
 QQCVO0kSJJBrpiKU1kQIdPkIaPbq7OoK9vea6BR752O3OdwdO4j2rsWXVpG9lfO+I6kGdCECyV
 yLgrKsjTJi3/KfJW/30Hh1jtGjgnmDBQvlzWpYXtoS3v84cRvjt3kxMJVoDmrKAUJV9w8z1+ej
 ThjzwEAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719331341; l=7866;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=w3MjqKvXOCvfTZZTK3seK4G6ECGT2Vpba6LHoB4jzT0=;
 b=zBgWgigGUBMPkeSMgmVf3SMy8YYzewWJMECKwREQ2GuxLbyIijb0xgUwGPgTqzeJO/4kfu9+t
 OLyOoAZOOksD5yUc1G/sR3E4iMHscAz7Y2AAsprNcC6fl1QjjlSw1yY
X-Developer-Key: i=yasin.lee.x@gmail.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
Changes in v8:
- Removed incorrect tags from the commit messages 
- Removed duplicate properties in the dt-binding.
- Link to v7: https://lore.kernel.org/r/20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com

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

 .../bindings/iio/proximity/tyhx,hx9023s.yaml       |   93 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 drivers/iio/proximity/Kconfig                      |   14 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/hx9023s.c                    | 1131 ++++++++++++++++++++
 5 files changed, 1241 insertions(+)
---
base-commit: 1231e065edd236295c31904fe760117551608efa
change-id: 20240616-add-tyhx-hx9023s-sensor-driver-e7dbe3bfe596

Best regards,
-- 
Yasin Lee <yasin.lee.x@gmail.com>


