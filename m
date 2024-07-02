Return-Path: <linux-iio+bounces-7132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD892401F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B807284A8F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4E1BA07D;
	Tue,  2 Jul 2024 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Bk/a63"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725F1E531;
	Tue,  2 Jul 2024 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929620; cv=none; b=pWvri7TF/uDfTtz4W2ReA/bsGvsR7OVesudRpUW0tEnKiga+67rC/+kTLC4fuEkUPf47nbrpzm2PRQ+Kv99KhkHcElq5MtfwZSEuoTnPoE+ZNx7PXMul+AkzOpYeVolpPNKyVD/fKszq/Qj7nAmnAIP77RkwxgPWD+iIyV8ws48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929620; c=relaxed/simple;
	bh=A0BDq6fxwvMo9Oxud3dZLvelp6d6AnwdUd1UvfjiVoQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bBf+KAJjXr0FkQvdmMwwzTrUurlDcfgtaqgkPRLBGiAzPamxJNeu77KMXoiI4eGuEa9UugFx1qvEplrtjHTJnCzEGg+WRMcjzIhctm2ie2u1RrJpxCYsGTf2RpuuK9k1fLKiPGrrDyybl5Ndykzm/qIi4eRefSC7hySc/4qEjNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1Bk/a63; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70698bcd19eso2727763b3a.0;
        Tue, 02 Jul 2024 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719929618; x=1720534418; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EXz8tF7sQhGGl+HiLcXEAjU23v3Vz5UXOTWI6VMp6I=;
        b=E1Bk/a63h55Y4bUaZmbAEUI9y3jUNCTDJlfCetFxsJhZSg/dRzNkxxKPE/yZPAIy7i
         kjQLAWOyWPQLxb8q42x0Y4oYDx0GFVK+cj9yRLhi1GM0550DaVX7OmJLj+y8NEH4zJkJ
         TvOD6C8fugqiXAp6ocLXItKOoIn8ZRpuTlMUS5CwM+FyjAYvz3LHHkO+YzXhnRTFzauV
         8MpRT8ImPZpCJjRe92axYr0MtRZONfvaBZsRntgX0LTFdClnDyZBwaAIMvUeAHSVkSd/
         gPV0X3eySwIPgLMBTeUmpkyh1856n5qTbgm6bm70Aw0gpE80AJuiUk+HwH9Zg7LLhMlZ
         G8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929618; x=1720534418;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EXz8tF7sQhGGl+HiLcXEAjU23v3Vz5UXOTWI6VMp6I=;
        b=NrellqOsd3ELHSxeW/Em9rlXYougEHXSSpAQyiM3FXgO6ThLdU+TeR0n59K5rEM59s
         /cbR5YY4+IrhhmPIzvTh+UExJJpDL8u/mv73JPyLRCdgQMBbfWd2aKPTIrW84LCoRtbW
         rneNHWeLvTERaVXr7QSH9bp3Qd+Zfqatpi2Cyv7cY+VJhhfy43PBtxVcd2O3zdTKi4Hf
         8+xax1ceKXYwPTGL9W3r3oNTAHDNdhhyQKqOj7kH9fm527cvcr3VOo7TjiJEtlRAoUQl
         IMjFcPBaPl7RFxxDKKXV88h46bjKeaBtZHmc+lgdLDnSqhrXcxUhIHSCwbQFrFBJneRP
         5gfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUFi6a+A6xhevx52tFs2q/JEbVw3NVjNSR0lGKOLTiiTdxncPOjlC3+U5LxS94J9V/Vngxh2WlnDTUKVj9BdGV6muz5udxqJGpIKl1B9uaw1DqLUfNOiLOh/qm/c6IzNwzaa+7E0/4
X-Gm-Message-State: AOJu0YwDLjHHcmC4ZDcs6cTN55ji4pUE4aM/5U+jYthMZJ9OVaEYKQdm
	JXVEUkp5j44IYjCiaDi48kVJZVLhm07rcJvlUYJbse7KjOzf+X7h
X-Google-Smtp-Source: AGHT+IFaHCJN/uyVWjryhW+iDVgOPockjhpneOv74Vx/Ri6oO44FfvkYookjL6+XIk5iHR+DQLFF6Q==
X-Received: by 2002:a05:6a20:9f0a:b0:1be:bf38:7b18 with SMTP id adf61e73a8af0-1bef6225336mr6903296637.60.1719929616320;
        Tue, 02 Jul 2024 07:13:36 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ac1e1sm8547872b3a.163.2024.07.02.07.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:13:35 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Subject: [PATCH v9 0/3] iio: proximity: Add TYHX HX9023S sensor driver
Date: Tue, 02 Jul 2024 22:12:31 +0800
Message-Id: <20240702-add-tyhx-hx9023s-sensor-driver-v9-0-c030f1801d9b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM8KhGYC/5XRPW/CMBAG4L+CPNeR74i/OpEEurWq2rHqkMSGW
 CUxsmkEQvz3GjqUigExvj7reaW7A4k2OBvJ4+RAgh1ddH5IQT9MSNvVw8pSZ1ImyDBnAgStjaH
 bfbej3U4znEYa7RB9oCa40QZqpWnstFlargVJyCbYpdudCz4+U+5c3PqwP/eN+emVvL/I1zfA5
 1IBA9RzBYqVUGmup4VaMKmK/KnE2b9v2VD3m2AAs03wJvPf27X3X1nre3JqGfm1XIo5K0rAXEg
 tKyEXyMsirxZ3yuIs/64D4dY6RkEZFRy0qNOYLWG26mu3/uPkJcdvcjJxDRjBG0RQcMWp+ziVO
 NYi5ulkxjTtJXc8Hn8AFVv4Mh4CAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719929607; l=9074;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=A0BDq6fxwvMo9Oxud3dZLvelp6d6AnwdUd1UvfjiVoQ=;
 b=HBJqsDZkRGypKEsTzv14HBU3FUMIcVmsE+SpRd8zKNgJNswNBiBRA4Wyk8nNMSjLH5V2jlsfT
 qZANOyyJp45AWpq/ehiK6/Mkm28kXXvYLebi6iJ8Y9fOQ7m45pE7naf
X-Developer-Key: i=yasin.lee.x@gmail.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
Changes in v9:

- Macro definitions:
  - Deleted: HX9023S_2BYTES, HX9023S_3BYTES, HX9023S_BYTES_MAX,
    and replaced them with numbers in the code for better readability.
- struct hx9023s_ch_data:
  - Changed the types of raw, lp, bl, and diff from int to s16.
- Function hx9023s_sample:
  - Removed unnecessary local variables: data_size, offset_data_size, *p, size.
  - Added comments to explain the data length.
  - Stored the result of get_unaligned_le16() directly in s16 and removed sign_extend32.
- Function hx9023s_property_get:
  - Replaced device_for_each_child_node with device_for_each_child_node_scoped
    and removed fwnode_handle_put().
  - Bugfix: changed sizeof(array) to ARRAY_SIZE(array).
- Function hx9023s_push_events:
  - Added error handling for hx9023s_sample() and hx9023s_get_prox_state().
- Function hx9023s_id_check:
  - Returns an error only when the ID cannot be read.
    If the read ID is different from the expected one,
    it only prints a warning and does not return an error.
    This helps with backward compatibility of the driver.
- Link to v8: https://lore.kernel.org/r/20240625-add-tyhx-hx9023s-sensor-driver-v8-0-0c224e3bddbc@gmail.com

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
 drivers/iio/proximity/hx9023s.c                    | 1124 ++++++++++++++++++++
 5 files changed, 1234 insertions(+)
---
base-commit: 1231e065edd236295c31904fe760117551608efa
change-id: 20240616-add-tyhx-hx9023s-sensor-driver-e7dbe3bfe596

Best regards,
-- 
Yasin Lee <yasin.lee.x@gmail.com>


