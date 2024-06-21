Return-Path: <linux-iio+bounces-6658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F84D911D05
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 09:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83761C21CC0
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 07:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3987A16C445;
	Fri, 21 Jun 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6NPyA2f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C314038F;
	Fri, 21 Jun 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955775; cv=none; b=e4zQaY+5OA6dayOYvF/Fx+NUTk9HH8KeNv2Hfvq9zKPjomVVV/yLZFbkKyWjhmQKsTDWo7X6p8gdCRqRf46rN9AOFPfGjWAKfy7e2k0DnUPmDi/AJkM4HkKR0tCzb0qiGL6Cqykq7ckQoYq+TmHEUfy15/fqHAu0O0XFIpy0DPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955775; c=relaxed/simple;
	bh=dnlH0L6LYfyEAg5RphafQ6sQ10wzebcPnC38I5sz3gc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RljxOXqxvFTZPjyDNd2o/NVDZ0UaPf1VgZwVsdZY0MyDheOomevo3t0QVgB0uOEs9v+FDliw/5F5lfB94m2Laj7GqtwAcpBo0WkgcBkVnVpXXjR0WykAtCaXZxRSNrEcD8Ps+7wQU9BtHO1IZIaig5YFOnaDlE6XSM30iYuKE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6NPyA2f; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9c2847618so15176045ad.1;
        Fri, 21 Jun 2024 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718955773; x=1719560573; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ8u3HDjzaBMmMDZjLTsq9+sv8vwxp4cau5AFixtAks=;
        b=g6NPyA2fhfI2myKhfjPAvWiYGJa/RQ1UxRUveR/T7xKMh42rvfDiWgDkCAV1kHq34b
         TD1kgW8gZa3pBHpsSXm6mCt88lZa23G1OXS/jLlWoEY6PA1sZMzs3IXPWzXrwRY8xxHn
         7WGAtUmgI5YQ43rYRkMMnhWGIYodzuIOlVgC5wYQnvwHLNTQ4bugnHiiAOcTzpekhcIZ
         7iCBsPWagZQpOr7EdvNtxT+2zfLQk01HbrodpWc3y8CGMq37fPOIPGNhm8cRERKZFOuM
         RlmJKczsUi6tWqEznj0k3KeAfOTMST62k7S0m42AdyTQKz2fVteUKGQqUWU+9H/DZl5Z
         Waew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718955773; x=1719560573;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZ8u3HDjzaBMmMDZjLTsq9+sv8vwxp4cau5AFixtAks=;
        b=gWb1vLwryyirzySMov5bGuTIEyt+YCNpaZECBMdJOXUKANz6NlafEkxrTIc8sLhPe3
         0Szc0+oldFVBswUEDEoZib+GIWHTOgPUVnNpYDnQ1DaJ8Y4WqYaXE5sj6v7UkHx36Lc+
         k3rdL9l3h9hUcC/LmAGsb72bys1F44rqPtnjXoCQ1t3kFUiU/1Xzw25SyWJDhUKAOc8j
         3lEnazx8YCLTsa6VymR2w/7YYyF6pTok7ftYcjD3abLYQHu1awmaqywB9fkySM2kQ5c9
         QFkkLKr1BJyh9S/mvfUFEzhDcc0AGCGGhWNr9mPr0MbtCRXyBM36vbfZpX2ldw7WbIIx
         0lDA==
X-Forwarded-Encrypted: i=1; AJvYcCVHGNKo0KwvFg3/23ohfTJr7n/6zf3FBOLwf4eY7/hKgzIIcTxdWXsgrZMwR5SmpDl2TjIzGEqUiRQNH88z9WHcYdX9Zq3xAeW6kIp4OoqPII+HmTDQItxSUBiSiCCknf4A38lN0TPV
X-Gm-Message-State: AOJu0YwsWUCciZ0JuGVbCO5Mt4MKxFI/AVVbbC3KxQq3AUzXjXcrsct3
	FquCvxhpowzfly+2fwtUxsfc30vf4n5kS1Ee0eafn7fnh0pJmDAV
X-Google-Smtp-Source: AGHT+IElghCFolHpReYAuBBbXEVct4c/BXQ2Rsk9qWrVmAtiStebtg6tMpjty6MBeVSk0jDQIO4BAA==
X-Received: by 2002:a17:903:1112:b0:1f7:4021:50a4 with SMTP id d9443c01a7336-1f9aa45a79dmr89800335ad.43.1718955772598;
        Fri, 21 Jun 2024 00:42:52 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5a87sm7893745ad.203.2024.06.21.00.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 00:42:51 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Subject: [PATCH v6 0/3] iio: proximity: Add TYHX HX9023S sensor driver
Date: Fri, 21 Jun 2024 15:40:48 +0800
Message-Id: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIEudWYC/5WNvW7CMBRGXwV5riP7xvEPE3FIt1YVjFWHgC/Ea
 okjO42CUN69ga3q1PF8+nTOjSSMHhNZr24k4uiTD90C8mlFjm3TnZF6tzABBoJJLmnjHB2u7UT
 byTDIE03YpRCpi37ESFG5A+aHExZGkkXSRzz56RF4/1i49WkI8frojeK+kv2rettxeLGaMw5mq
 7lmllemMHmpa6Z0KZ4tbH7dsq659NFxyPoYXBa+h68QPrNjuJB7ZSz+mq3cstJyEFIZVUlVQ2F
 LUdX/MM/z/AMFfsufMQEAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718955766; l=6244;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=dnlH0L6LYfyEAg5RphafQ6sQ10wzebcPnC38I5sz3gc=;
 b=BrTSRtGovvvOJNyt0s6DNhiL0QIOJIJzRGyjjF6uu8B4s90w9ZLLw/Kv3VvNIb7Zw1zj1KEhv
 Pp0ZVfPMxVrAvo8L95ITsGC290xH6pNIEyfBN7qYWyffpU8STHZdqGQ
X-Developer-Key: i=yasin.lee.x@gmail.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
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

 .../bindings/iio/proximity/tyhx,hx9023s.yaml       |  115 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 drivers/iio/proximity/Kconfig                      |   14 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/hx9023s.c                    | 1150 ++++++++++++++++++++
 5 files changed, 1282 insertions(+)
---
base-commit: 0291f73eaa59fe0dbb715fa405bb47a1d8206e0e
change-id: 20240616-add-tyhx-hx9023s-sensor-driver-e7dbe3bfe596

Best regards,
-- 
Yasin Lee <yasin.lee.x@gmail.com>


