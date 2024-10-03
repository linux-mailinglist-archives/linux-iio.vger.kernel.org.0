Return-Path: <linux-iio+bounces-10052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27AC98F47C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42AC0B21D53
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77F11A7ADD;
	Thu,  3 Oct 2024 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O76jESMp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DF1A7244;
	Thu,  3 Oct 2024 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974190; cv=none; b=rGj7O/cSO0mk4EYWLxvC3C+j7t9cvcUZVQ3XTx+w+i9IWpJYCAJHMLa3DQckI2ULSbsmcsmGq+zTR4CzdUYhNdcS57FkxQ0sdWqc6urHlRiLRFQxrw992UcUltSKnt1ST0NKPFl2SAKXOJGE35CSFBycjLDGBbgJXzK8PIR5Fv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974190; c=relaxed/simple;
	bh=PGVZdAVp706EcaODvJAL5I2pCioDQjFawY0FIibt5LI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dHn3/zRqDRJH7XAnqU0FJVHHsjLRnSxQF+Tck0+xHXHc2LZEq8iIZT+5ELSjpW6GWDPTRu4i1nMVMNxBgYH/JR9bNSMtSJRijSGLb4ZVTyKj7z/ZfHeYghazlqVKKp4BR2WXawYmLdnBbIwPPt+DeKv1xoz4uJ18Kt9yCbq0zQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O76jESMp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb2191107so11076085e9.1;
        Thu, 03 Oct 2024 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974185; x=1728578985; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zi8ocouF20x7x4ZH39P3NgmMN5HAoApUxySM8OlpSFM=;
        b=O76jESMpTrb/Q2Bc3ol659wPfyKdg2oPkj94Pmc2gHkHslpmp5g75K6PXl9qlbffjO
         8hUIuD/LoyMAhRIOudNM6JCkRcNwcXCxCIalDQB6glRBFu4Y4PQfKW+foPqHBvJgGD24
         xKNQDidHxlWFruQV9bOonSs82oodOGKP9u/9Nr2lDkrbOoX9JIQ9idoJOJQJMqziWGQq
         JWQgkHEcJipEX/yIb/RdZNVuIjx/q7zBb/YMkVU6aPGcc5dfIoDLgJ4CoOz7KACQZ3FF
         RV5cBscb1iM2+ohRnxq581otoOKp1rZQRExA3T34+hi7hO5Gz4Lx5UYTPdTJTHgyXE7o
         ZrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974185; x=1728578985;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zi8ocouF20x7x4ZH39P3NgmMN5HAoApUxySM8OlpSFM=;
        b=iN/toi8U8IuOmQvi/qbjpcyMQIekFO7uieW4AtFuwdcrxzft6AGRXMlIrJbEsuC/wk
         1jqyATlVRA57ujC6xWwHVXWZ4Q1MLTojEY8aId0pL4V1ZoW++aqZwhMZIIWf9JNIyTed
         BKCLle0jrSv9UqWogCc75xHrU71+SO8iZR9GOZiVKk3guIIUcv7R3xesZhtT1sAsCPtG
         Iz2GNYNqCtXNBHukqnf1/4/c9FHifEhhQJUiw9/ZRyzsxCgnf+5j0zLTQvMhkNlOlork
         Gt31qqobwe5ZiPMbIp/xhkW3fjI38ScORD7t9R/S3rqm7dLRToDEO3Y8cDVkuySBsDpQ
         IOiw==
X-Forwarded-Encrypted: i=1; AJvYcCU0BlJyrxOr0Pk/IWxr3z+P+g9SXjO0DnN1YblQBb7n5pELDVVahpAoLxslfC290TD4JYf9q10iASg=@vger.kernel.org, AJvYcCUQVokBks7KU6QbOqP95XqAYiMs4kVF5Ew295ZTDZBSSSdVKcuDHSxLRykhnOKw0uxoSuGZBq4XWf7RlCMm@vger.kernel.org
X-Gm-Message-State: AOJu0YwMRNtml6NoSDFiQbg+1XPo5PboLTfTO/H/JjOFetF4/VRV+bB6
	66hlJ+lUj8vzSNJfE+d7YWQE69PgQl9Fd1gBcqTsnlF90vml9tpGzBZWGUC0
X-Google-Smtp-Source: AGHT+IEu5VnRlj59BdPG1wgcT+b4lpRwANcYJcpNwSF5BH5EC08SOmRkh9OpLSnwL5gVciYvwgM+3g==
X-Received: by 2002:a05:600c:4ed0:b0:42c:a8cb:6a96 with SMTP id 5b1f17b1804b1-42f778f12b8mr59254605e9.31.1727974184480;
        Thu, 03 Oct 2024 09:49:44 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0134sm19783385e9.31.2024.10.03.09.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:49:43 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/8] iio: {amplifiers,dac,frequency,resolver}: add missing
 selects in Kconfig
Date: Thu, 03 Oct 2024 18:49:32 +0200
Message-Id: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzL/mYC/x3MSwqAMAwA0atI1hbSD1i8irgIGjUgVRoRoXh3i
 8u3mCmgnIUV+qZA5ltUjlRh2wamjdLKRuZqcOiCRfSGZqfWWTTKO0+XIaTOU4joI0GtzsyLPP9
 xGN/3A9HZp6hhAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Cristian Pop <cristian.pop@analog.com>, 
 Mircea Caprioru <mircea.caprioru@analog.com>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727974182; l=1660;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=PGVZdAVp706EcaODvJAL5I2pCioDQjFawY0FIibt5LI=;
 b=WMva4m3TYHQ725VVLwrm4NSvLF0SI7PFUCftBS5QF0X2qOiYzdALUz8s7hlEeDY7VtEgBs6Jv
 1HVoYDw6K8bBb1AE6ds8Ers/BhVMnpfkXUzHsHWjOILpmFVJgVKhCje
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds some missing selects in the Kconfig entry for the
following drivers:
- ad2s1210 (BUFFER, TRIGGERED_BUFFER, REGMAP)
- adf4377 (REGMAP_SPI)
- admv4420 (REMGAP_SPI)
- ada4250 (REGMAP_SPI)
- ad4770r (REGMAP_SPI)
- ltc1660 (REGMAP_SPI)
- stm32-dac-core (REGMAP_MMIO)

Usually you will not notice the missing dependencies, but tiny
config files where those drivers are include will lead to multiple
errors when compiling and linking.

The issue was found while compiling the ad2s1210, and then I looked for
other cases where REGMAP was missing.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (8):
      iio: resolver: ad2s1210 add missing select REGMAP in Kconfig
      iio: resolver: ad2s1210: add missing select (TRIGGERED_)BUFFER in Kconfig
      iio: frequency: adf4377: add missing select REMAP_SPI in Kconfig
      iio: frequency: admv4420: add missing select REMAP_SPI in Kconfig
      iio: amplifiers: ada4250: add missing select REGMAP_SPI in Kconfig
      iio: dac: ad5770r: add missing select REGMAP_SPI in Kconfig
      iio: dac: ltc1660: add missing select REGMAP_SPI in Kconfig
      iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig

 drivers/iio/amplifiers/Kconfig |  1 +
 drivers/iio/dac/Kconfig        |  3 +++
 drivers/iio/frequency/Kconfig  | 18 ++++++++++--------
 drivers/iio/resolver/Kconfig   |  3 +++
 4 files changed, 17 insertions(+), 8 deletions(-)
---
base-commit: c02d24a5af66a9806922391493205a344749f2c4
change-id: 20241003-ad2s1210-select-a0a73a48038a

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


