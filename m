Return-Path: <linux-iio+bounces-24193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20ACB7DB65
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB077B2F15
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 23:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB952D3230;
	Tue, 16 Sep 2025 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdypApED"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66412D373E
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065817; cv=none; b=TjgRQ8MmBpOtc0jFwuMwM4BYCQ4SLWTxnH3i3V/e1nOl2ivsEmx9hl3SVgdYZ+ikojR3TWajxgr2D6hU1vgo8emhtrVLtBssPjCJ0F33M/vkQTnUy/dOxvn2XnzPJ4VXVcfXWT+QHcQgXTiSkh3XkNouj7uxaKjeS0V/rdLVn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065817; c=relaxed/simple;
	bh=ux4vTV9k1F2IlqXazpfiOiRpfiil7AqpVgIY1h7Rl94=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P8YPGOet4NubR8igvE8fBCb8PsP1dR2RAcoTBx90HeeESP+fCQ0No4gZpDG4Mzi3gJjZIjwzX2N49MSBEObcDFEQSnoha/xesPRZT8SpZjoX2FVaJ3QO2h6Sq/PMSO5GgZOMmSl6z1I5Bpo5XJsfaq1aU03CCg9upY4eDWhzy2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdypApED; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-776b0100de0so302011b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065815; x=1758670615; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=06FhR2szwm48UxYlWBuBoQo1LvMZ65nCk6zvBCkN7uE=;
        b=bdypApEDaeq/nYrD8dtaoburYsJl16M78udCThb2N1KQ2QrvR50ELWHTv9eE48IXbP
         Rl2PKOndecYb8oSpzxu8U5p9hGRgSxsX5uDRD13d+8iU5ckRK1RIUfTr7E9VZflWxTLz
         6sVcXKicSQJ7p11rMGbpjOqbwLTMLCOLQHr8gHMw7/NJ0icNS3FcNhM300Yo5on/FSrK
         YqMkvh5wxSAcKwaAxis9YORB5G8AxwxBOsS9Wtb3I0ywEduJAhoiTb8660LfDomHbayw
         cMOIlenGjkfZckGw+c4XhIcIkrgeR8oOdt8n4SodU7Nee+TmAKKqTp6wqG3xMBednbz2
         7fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065815; x=1758670615;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06FhR2szwm48UxYlWBuBoQo1LvMZ65nCk6zvBCkN7uE=;
        b=ThPM8Axx8/bN8gx/yxuF3WMuTXirxTdrGvoQR/nLQNgIzVmRuuRf2+HUAKg41yLb+F
         wS8Tt8RNfTZtocshANZTsq7mD1ai54JPaOcPFisA3j5EFGSgo1bQYABNENikKZFTr+ki
         8iFIgcrLEzqbziWgj50j3Txr56kFtUuXmHhH8ROuxniCUgvd7CUz+lGkaK3KECEFvA7m
         R4BtC6Xter6XkdZdWbA/XpTSOshlMeAhlGVs5qIJt62ek1qaZP5IeiStTzgA+CgR2kJm
         vvkTVq8WwjfGVItVyQh7A8fIPXKVI85TG6prd4MgxvRpYtO9HtAi6zcCjvage8VU4YNg
         gXNQ==
X-Gm-Message-State: AOJu0YwfMrpkeHcdfQIr9+fDpUjwZl9/AUVAGKBevUKtWfAwcohH9kjp
	QCAkW6UE/E65CkKporQPE/IydjHZ8jCn2DaHLXNzj/QRnAeEWAM1JLvi1nXqKfT3
X-Gm-Gg: ASbGnctiHSLIYgsRi9ur6Q07eJRWz0QJbkfNLXNozTXwVBg1U7Uru4/C2+wFseBN67Q
	xCoyf1qbaH6srHvzCO53LkQd8OVeXxSlZ7pv+fegTZ+IlR4SehVI5mUa4GFcfMASHEF6HOngev9
	kRyv2hdhsERVRqQxBcJOmPAze0LfDiQ4x+FpKGB9T4ko6IxwN5jWJ9XhP95JyVpKFVRwybeMwFR
	yUjUaPhnl+Nkyz2uUY+c0JyBagVENgtKKThuvMjFl637nJvlmTXL85fOh3vachKLzE91eOgoD7t
	98Dw5XAAtYqBCHhhF+D2moanhgF/0E5Rc5mAlCj+y3Arm12Kgn+TIpI2wvAForqT72ggnU/L99V
	iWxFL1X1O7kUbMe0=
X-Google-Smtp-Source: AGHT+IFbIaDttvHSss02DB3J2sabVWmuDkUm+pxcUy11qsOZlX3cQ7YoKmt3SPdkkuCUEqrbhbl8cQ==
X-Received: by 2002:a05:6a20:7f93:b0:263:bee9:1af0 with SMTP id adf61e73a8af0-27a19bb78d0mr166460637.2.1758065814874;
        Tue, 16 Sep 2025 16:36:54 -0700 (PDT)
Received: from [192.168.1.135] ([2804:14d:90a8:4498::371])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b8eb4737sm10108298a12.9.2025.09.16.16.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:36:54 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Subject: [PATCH v6 0/2] BMI270: Add support for step counter and motion
 events
Date: Tue, 16 Sep 2025 20:38:22 -0300
Message-Id: <20250916-bmi270-v6-0-6acd8d26a862@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO70yWgC/0XMQQ7CIBCF4as0s5YGUARceQ/jAulAJ5HSQG2MT
 e8ucePyS/73NqhYCCtcug0KrlQpTw3nQwd+dFNERkMzSC4Vt0KxRyKpObOohVXGh8AHaPFcMND
 7d3S7N4eSE1vGgu4/N0cuhDLK9FKctGaCxVdd3JpjcZ96jcnRs/c5wb5/ASGEfayYAAAA
X-Change-ID: 20250915-bmi270-9e71958cff0d
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758065905; l=4015;
 i=gustavograzs@gmail.com; s=20250915; h=from:subject:message-id;
 bh=ux4vTV9k1F2IlqXazpfiOiRpfiil7AqpVgIY1h7Rl94=;
 b=Pq/JO67kd/BVABDVixzvaOo3oUctX4gXnb7ttakcfLcoqXvYhuQvkSXLCgILChnfir+mn46lZ
 UB7HaHG56q+AS9lXANU9IW9WQkHwBcOcgaW60zRIIuaUGd1WoPSgE49
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=kYkFqZEIlab+1AaYMvpqhTQxwPXcJiTXdMaBQbfORrg=

This series adds support for step counter and motion events using
interrupts in the BMI270 driver.

The step counter can be enabled, disabled, and configured with a
watermark, all from userspace.

Any-motion and no-motion events are generated by detecting changes
in acceleration on each axis.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
Changes in v6:
- Use IIO_DEVICE_ATTR_RO instead of IIO_DEVICE_ATTR for
  in_accel_value_available.
- Replace ternary operator with !! to fit the statement on a single line
- Change the description of in_accel_<x|y|z>_mag_adaptive_rising_en
  attributes: 'adaptive magnitude' -> 'adaptive threshold'
- Group in_accel_mag_adaptive_rising_value together with similar
  attributes
- Clarify in the description of in_accel_value_available that the values
  apply to all in_accel_* channels
- Link to v5: https://lore.kernel.org/r/20250830115858.21477-1-gustavograzs@gmail.com

Changes in v5:
- BMI270_G_MACRO_M_S_2 -> BMI270_G_MICRO_M_S_2
- Add patch #4: ABI documentation for the exposed sysfs attributes
Link to v4: https://lore.kernel.org/r/20250711-bmi270-events-v4-3-53ec7da35046@gmail.com

Changes in v4:
- Reworked the threshold for the any-motion event so that threshold *
  accel_scale is given in m/s^2, in accordance with the ABI
  Also the range of available values for the threshold is now determined
  dynamically based on the value of the accelerometer scale
- Fixed alignment and styling of some statements and macros
- Simplified the return statement in the bmi270_read_event_config()
  function by returning the boolean expression directly
- Link to v3: https://lore.kernel.org/r/20250616-bmi270-events-v3-0-16e37588604f@gmail.com

Changes in v3:
- Avoid the usage of set_mask_bits() macro on 16-bit integers,
  use the bitwise operators instead
- Fix indentation, alignment and style issues
- Link to v2: https://lore.kernel.org/r/20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com

Changes in v2:
- Reduce the scope of mutex lock when clearing the step counter
- Change the type of the 'steps_enabled' variable from int to bool
- Add a new DMA safe variable to the device's private data to access the
  feature registers
- Remove unnecessary mutex lock
- Fix a build error found by the kernel test robot by initializing a
  local variable in the `bmi270_update_feature_reg()` function
- Remove dead code in the `bmi270_write_event_config()` function
- Add macro definitions and corresponding datasheet references for
  relevant constants: step counter maximum value, step counter factor,
  and threshold upper limit
- Remove the event bitmask from the device's private data. Read the
  registers directly to retrieve this information instead
- Use IIO_UNMOD_EVENT_CODE instead of IIO_MOD_EVENT_CODE where
  appropriate
- Fix shadowed error codes
- Change motion event to be enabled on a per-axis basis
- Create pseudo channel of type accel_x&y&z for the no-motion event
- Change no-motion event type to IIO_EV_TYPE_ROC
- Link to v1: https://lore.kernel.org/r/20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com

---
Gustavo Silva (2):
  iio: imu: bmi270: add support for motion events
  iio: ABI: document accel and roc event attributes

 Documentation/ABI/testing/sysfs-bus-iio |  40 +++
 drivers/iio/imu/bmi270/bmi270_core.c    | 384 ++++++++++++++++++++++--
 2 files changed, 404 insertions(+), 20 deletions(-)

base-commit: 91812d3843409c235f336f32f1c37ddc790f1e03
--
2.51.0

---
Gustavo Silva (2):
      iio: imu: bmi270: add support for motion events
      iio: ABI: document accelerometer event attributes

 Documentation/ABI/testing/sysfs-bus-iio |  34 +++
 drivers/iio/imu/bmi270/bmi270_core.c    | 381 ++++++++++++++++++++++++++++++--
 2 files changed, 395 insertions(+), 20 deletions(-)
---
base-commit: 91812d3843409c235f336f32f1c37ddc790f1e03
change-id: 20250915-bmi270-9e71958cff0d

Best regards,
-- 
Gustavo Silva <gustavograzs@gmail.com>


