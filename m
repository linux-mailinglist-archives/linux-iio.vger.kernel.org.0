Return-Path: <linux-iio+bounces-19279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857D5AAF772
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08CC4E1972
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 10:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED6D1D5166;
	Thu,  8 May 2025 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mycs1VwF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0936A1C84CF
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746698845; cv=none; b=YNH0BQw1LvaRPHT5v9vPxC+IqOjxEbUKolBP+qfMU7iYXw3XrnkbvaaTjtcALJao1AkFCuYlFP1RagYENohF0h5UBMCvqWSaz6lVD/v+Vj7aEYVKpyfRghXfHhvF+Fr6GicBabp4By7gXAmydNjmxTr6LtVxTB759DOVj+SFhQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746698845; c=relaxed/simple;
	bh=wbY05BM+oFyf5c7eesHOTO2O39mRvXwu5TpZihwG4+w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mekiKGEevVJzoeE0jKR+AG7zI+nCSO0wHFls/MPl1xy7g0hOKlovBcK5qRpvz5V+YdRNL2osURnUJndaZhFL6OmIs8rO4qlX3ghQ3NA3GpLeuMfCJVchqc/NeXvvkCGFdJJBlXx7GCoSSCtbZ9/JWOsD47Og3A3J8HhRQRcmgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mycs1VwF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so615281f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 03:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746698842; x=1747303642; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=njSz3ssZ9vsO3uOFmBi11IJ5TO4pFxRuIrUMYY6uL3s=;
        b=mycs1VwFg9fkwu2HQ5152SgC/cvMV4LhrdLq372/E59zeD4/4yrXuae0VVHxMRQJfT
         blOHlWjHxRilAP9+66/YZ3u3aXMo8JVuL1aRpSRinBZTx8cKZdsLe9Fb0ZWfpokUzmHU
         TLVYucGGQ/SNhu/tdZpBjNYQDzk0c/qgc5GRtgxfQD3WxNxuMNquXdudqawp6PpWhcJw
         ERyUFqfuY9DFz0T1sPvWTaKULafMQSS8gR/mklbS27jZ7tUaajqU3E9tzKhG2SH/w4IF
         0xvAJ2SZNy6rNm0v2ed1K4FubepjMzEFPBys+2kFjxbkgPF7IAUAAaQHEZkQUM9br+ga
         dIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746698842; x=1747303642;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njSz3ssZ9vsO3uOFmBi11IJ5TO4pFxRuIrUMYY6uL3s=;
        b=iAMk3XkNTfeZj3Ku+6P9E3Wy+DVQKxAEunC+GRUj/DYBwfqewlhmV3uV62lPYBTkT8
         R0mfic9Og5+/ywBqTdqyNy3n7zNT7SQSHz+AY6pkI4cJNJGB/MsYSF4JxTofeP+szkLV
         hs5j9mvEqG8ZTvFfDb4j/50aWPIKtSjvlyYpfSKqIjftg9uCC+1e9HxYhVVWYO0C28La
         aum885v1OtHnFVdaoYV1IdYLIpwAMuUJzUlbfisWuQ+PeM9Fu0TzbMhKsjdGoMk72aeN
         C9RfIextKS/0VUWXJd06Dv8q+YenJ6vFlDcNg8OMM67bBloYsV2fslGVWeiCLa8yjA1s
         Bshw==
X-Gm-Message-State: AOJu0YxB7uDx8Td4RLKUFr58dkcNO+FtQ6aD+9EvNloTUn3WbL2wJ6u0
	plvFiIXkfy1NT4mBBdXnphJLCQSNguZYEIR8mOMNTxtBmvhtU+7Wq2lRxB0u9i1pX3LSEpoG32B
	W
X-Gm-Gg: ASbGncthTiPAvOSd85d/MnYfU4EYmioxwhTi6ZYw9p6Oq2gOWvMNRAbu4ZQuBUgGkrw
	GdC/kYbtvzccW98pZ03O41W5F5THQkKao1Ga6/hS7JJTIG7mPpzY4sa3BXxepmLfsmt7nWpLwdH
	A+Smg48h68QvlPWXNxWjh9leGFWJg5TR+FC1k3vSfY8zT+cpw5TlFq1/QCvYO4kuPnVsZWMPfi7
	ua4DR3XoNnAo0B0UVqXSttL5dGxIQr+WPnEKFkJ1Ra3rMo2vz64leephsXYL2NNQdjenzDOwQGM
	YT9YeTvRZwkktLE8DXQzaHhw/TcVylbFdud8QHEHhJQ1EBwesCeY9F1kPVOconOjIPp4yptENHz
	QV5roED2y2R2y
X-Google-Smtp-Source: AGHT+IG5LFa6Ck9ZYFbUs7yGsWs+SbJIJB7ULfi1cZg9Cm/5pQcWo8uOLaQcTk9BEl1Kfmx1cnsDLQ==
X-Received: by 2002:a05:6000:40e0:b0:3a0:9f24:7742 with SMTP id ffacd0b85a97d-3a0b4a4b4d7mr5131493f8f.41.1746698842004;
        Thu, 08 May 2025 03:07:22 -0700 (PDT)
Received: from [192.168.0.2] (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd363940sm31699665e9.25.2025.05.08.03.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 03:07:21 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v4 0/5] iio: adc: add ad7606 calibration support
Date: Thu, 08 May 2025 12:06:04 +0200
Message-Id: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAyCHGgC/43NQQ6CMBAF0KuYrq2ZTkurrryHcdGBQZuokEJQQ
 ri7hY3GGOLy/8l/M4iGY+BG7FeDiNyFJlT3FMx6JfKLv59ZhiJlgYAZGNzJR6glXaUvnAUrc38
 NFH2bVhLB6531FnSGIu3ryGV4zvbxlPIlNG0V+/lVp6b2H7VTEiSTKcwWFSmHB/L9dOZNXt3EB
 Hf4xjLAJQwTppyhAnwJW0U/MP2J2SVMJ8wyObLsUIP7wsZxfAF9gpeqXwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2400;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=wbY05BM+oFyf5c7eesHOTO2O39mRvXwu5TpZihwG4+w=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiQaeK783VzWaW8tUYbW2vlTU2RvSetO+dn7z+042PbT
 P+/3inpHaUsDGJcDLJiiix1iREmobdDpZQXMM6GmcPKBDKEgYtTACbiNYPhn/qOtfLPde4tjr5j
 dT25m3OH0HEugc3PHKY0TJ9p9Fb8zSZGhptd/bN5ti7ZaSqfVvr8elahSO75ixMmecwoWPlad8u
 GChYA
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
Angelo Dureghello (5):
      Documentation: ABI: IIO: add calibconv_delay documentation
      iio: core: add ADC delay calibration definition
      iio: adc: ad7606: add offset and phase calibration support
      dt-bindings: iio: adc: adi,ad7606: add gain calibration support
      iio: adc: ad7606: add gain calibration support

 Documentation/ABI/testing/sysfs-bus-iio            |  24 +++
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  29 +++
 drivers/iio/adc/ad7606.c                           | 221 +++++++++++++++++++++
 drivers/iio/adc/ad7606.h                           |  12 ++
 drivers/iio/industrialio-core.c                    |   1 +
 include/linux/iio/types.h                          |   1 +
 6 files changed, 288 insertions(+)
---
base-commit: 2f122cfb4c5d0ee7e44ed34ccb2d148d4146c0a5
change-id: 20250429-wip-bl-ad7606-calibration-20a396a60352

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


