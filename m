Return-Path: <linux-iio+bounces-19795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AF4AC0CC3
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 15:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BD73B054E
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F092D28BAB9;
	Thu, 22 May 2025 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RcqIlTYI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3A28BAA5
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920584; cv=none; b=uMOexjPXFu747b/gZ+9IzEJSYRicbHah3KX7EFkusfBxQWN+mPzm1ztFuwrM0tn7IvoZVPzyiHQ1LlPhz/Gao/D80mmigd0N5r3QkpDshS/6on0cBdCyjDvOqWQpa3dvlrgInLgOQDTw7IbgamHMGh7ebSc9ezVwiszA5J1bJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920584; c=relaxed/simple;
	bh=YvxmOcwXxySke6hJNz3qXEpH82+lpny5SEPaKZ39tzA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XehMxdbDjq43il/HRT3USg4j1hAwsZty7txADKMDiYQBYEitJVqCUcY9ReFXfeMfpWouoq+truai+UQr9no2dob7TkZzS8lN7UmWwCoKJc6Z1tW/iy6+RBSTEwE2uGgQpHdyfiuEHRG3NhO8YujJjeeCMsrGzxUDS3S7l6Wp9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RcqIlTYI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441c99459e9so53370585e9.3
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 06:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747920581; x=1748525381; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIzpzapNTYH4VGBko38vkkxsTkjFZRUZnHumpB9vr+c=;
        b=RcqIlTYIKFM23kLsONtpo1F7YAv0TM+siEzdQkBN7akYsoi+KXx3zwz/qcpU9zhm0t
         8r7mqpyR926veWXzJiEMtMfUOJPDGNKj3bOYgNoEMpjO/eJMpgvMWBZSr6MoiBCgGriv
         +oS0xTq+gaQH8FLMjwezwFAegKak1mRaO89swafNAQap7croNxgAhd2Q1+OoFX4iOADE
         qyntnhLq3vaYugCglzNi8hI8upHOV5qle8nof1SAPGHliQB5bA7EpuHfmwL32LFkrJTP
         bjghAJ2Xmrc19//3MgKgx7TW93PlFb7mgwq4UCjKJ0wDbEEAPeg3nJLEtX21wOw7tyxG
         RMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747920581; x=1748525381;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIzpzapNTYH4VGBko38vkkxsTkjFZRUZnHumpB9vr+c=;
        b=Hf5OYm8mLtvlihqwCrMg9GBlWMSMYu2G3WlOwQMVP5H1hvQcy+TYlNYbHknotaY7aQ
         Q1O+I2BI3s+taFcPhcapVFIz4fdrAWvHFf/XpRJuZyoxU7SbDDWWrFWHy015cq//fO77
         +Mbeaefgq0GSS1z0FTEyDd1/v4zPNnA2E8LCP66nzlcx+UG/i9p6nK49OllUrOeNSpgg
         jfaDMHmIdRomhL+BCIn4qWJ57VetP2cy/Sy9JxdP9Qd+cnge5rfS6M7HJVTkAtZc6eV7
         CRg2GfUbhNKRI64Ot1UEvZP75PVHF1mPxAnyVvOEXuGHBfNCu3mFfnm1shvzTgPpQA60
         YYaw==
X-Gm-Message-State: AOJu0Yz8icx+mtlqCHerKDLIpHhq2SGvafYFDxlPyMSpR1awRkfLApct
	mjkmN61cMwu3x/OZy5+3XqHr8AD1v0FLXm+X085InULzaeFJb3xAn3rmyCJbZ2mADaU=
X-Gm-Gg: ASbGncvwa4NRHL89m9SCps0GkD9puaEwpGMrtrSIMWeub0/K33goPK7NklDJiqqzxP4
	KPqI64zvEWglaQWdHjUF9a6HMWHvElo30nGxASK+EScikmqR7BVvuZSu7PodVyjWmCUajutl8Pe
	IqO5EjUF7ehIpb6t++UjY7Zhi1b1C3G02dpnIeiS3AZSl/RVRw8G5CW6qR/aKQDQ5csrqALssKU
	+9SGH6MSVQ4zwGle6gTKWMYU3KOByGQNnVVxRMsiEOhPbdGCpk3bgUAiNPujBsGCdRoV5hpIcnE
	eZI50yphGEN9tAu2Evgb84P43wk9X5+Rqk9QTRMvwSIZvY62SGf/a1xG3gPxWgiB+eV5mDPS2y8
	o4zsxVv6ClDAAhr9fvSc/SOW1LjjlVio=
X-Google-Smtp-Source: AGHT+IHj5yBsUYf4YI13lVQPPXM3bDI+sCi+sYh/ZaKSTJgcKvk6X18B9cO02f0AvngeuLfOR95OZA==
X-Received: by 2002:a05:600c:3d15:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-442fd625120mr229896315e9.9.1747920580841;
        Thu, 22 May 2025 06:29:40 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef0b20sm109837585e9.14.2025.05.22.06.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 06:29:40 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v6 0/6] iio: adc: add ad7606 calibration support
Date: Thu, 22 May 2025 15:27:01 +0200
Message-Id: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACUmL2gC/43QzWrDMAwH8FcpPs9Dlm052WnvMXbwh7wauqY4J
 Vspefc5vSyMEHb8S+gnobsYuRYexcvhLipPZSzDuQV6Ooh49OcPliW1LBDQgsFefpWLDCfpkyM
 gGf2phOqvbUoieN2TJ9AWRZu/VM7l+2G/vbd8LON1qLfHqkkt1f+ok5IgOZhkOlRBOXwN/ra0+
 TkOn2KBJ/zFLOAehg1TzoQEPkOnwgam1xjtYbphxMEFYoca3AZm1li3h5mG9crrjJ12TFuX2RW
 mdn9mG2bAmhxd7LNOf7B5nn8A4uNIaPkBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3048;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=YvxmOcwXxySke6hJNz3qXEpH82+lpny5SEPaKZ39tzA=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsjQVzOoubh0u3WXZvNv/cBjkiKd7rckGu5vedMj/FCe8
 3tgV9XKjlIWBjEuBlkxRZa6xAiT0NuhUsoLGGfDzGFlAhnCwMUpABNJMGH4H+f4Tdbe48RmrXq/
 Q55S3m7fv77Mn+xUXlcisllSr51TjJHhWMCb+ijH/9OYZxca3/KfMME2XP3U/DTFz7apu5zulDn
 wAAA=
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
Angelo Dureghello (6):
      Documentation: ABI: IIO: add calibconv_delay documentation
      iio: core: add ADC delay calibration definition
      iio: adc: ad7606: add offset and phase calibration support
      dt-bindings: iio: adc: adi,ad7606: add gain calibration support
      iio: adc: ad7606: exit for invalid fdt dt_schema properties
      iio: adc: ad7606: add gain calibration support

 Documentation/ABI/testing/sysfs-bus-iio            |  24 +++
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  29 +++
 drivers/iio/adc/ad7606.c                           | 225 ++++++++++++++++++++-
 drivers/iio/adc/ad7606.h                           |  12 ++
 drivers/iio/industrialio-core.c                    |   1 +
 include/linux/iio/types.h                          |   1 +
 6 files changed, 286 insertions(+), 6 deletions(-)
---
base-commit: 5f7a3b3aa8dc5fb3103322c30c690d38d1a25071
change-id: 20250429-wip-bl-ad7606-calibration-20a396a60352

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


