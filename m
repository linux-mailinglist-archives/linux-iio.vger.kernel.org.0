Return-Path: <linux-iio+bounces-7274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71C29269DE
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 23:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286671F26C24
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 21:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2F2186E2D;
	Wed,  3 Jul 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVrMTQh/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB210A1F;
	Wed,  3 Jul 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040696; cv=none; b=EqcOrtdPzQ3fX6ZGXipfCkS9Uz4OCxdRMBxemkVo0GF4VAtC7/jZpGCg3mS+cbUsFrozinLuWAhb9OrkWh7QHrFrFD8MAbjLlWD5HZUBRW6vY817PNdGcMQgXaU7QuJBS6k3mgo7JmRICX5X8cA9xuxZjpV/usgoQ50M9lksz2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040696; c=relaxed/simple;
	bh=oHUbC0Frm2Z9eMFMoAhWcqVdR69fhOuFlCJxS28o33s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XBOBGuI39QgSuP9hW8EDZJUcZXRJozySILCpaNrQT0/ZY9LpFksJIvYXrT5li6iXzQvDmDBIKsctuMaM7qEXcU9gUKvTzQRHJBnVPc2AQapOSPJngiYRCLtC+xqpIdc+cPsdC0YGbgNmKbpMgwtS5pgnEZulWMdXS+iZ79/u0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVrMTQh/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4256742f67fso42391665e9.3;
        Wed, 03 Jul 2024 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040693; x=1720645493; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dLWcNRv1upsJ3L9uziPBig2HPbeNtJlCnV5ndEQFD4=;
        b=FVrMTQh/YeyvyD8X/NJ07uPlM4hQD1aEpvtFh7Og6wP+gaO12H1CpNK7XEMIqrz8ZX
         yFF+SR6WQDVKH/+HEUqaTAvmBR5n7R9daX8R01vwauaAdxnADXHILxkEtkac74RyRBpr
         bgkbqnKrGQcMpeuokcTpmJ0CA8WZZuUKBZ5z7xVYdBh0cAFxVi9cE6sKVGOJCG6XzvFK
         L1HJHcO4CclMz7FvCxdWhjUelqlNMlHP/vDnFQjgAjuwSIGTxQ/Q0r6cCTyfm7ve5678
         m4h9L/n+ijrhELELHELNbXFLgJo5XmqcsYG/eeVrNIv/v11FLoJ8bJkDv/HGCO748U9y
         waEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040693; x=1720645493;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dLWcNRv1upsJ3L9uziPBig2HPbeNtJlCnV5ndEQFD4=;
        b=oMwwZ4LwGQt/RCNu1g403ONp04lSAqO5TPMvUIPZE/GBzLMBZGP+ZnRn5q73XyCKvA
         jgC74yza7DQLOh2N+kbPlGwNtgG+so28YP9crB6Y4NlOFLsE+8UHRA/s/cykoW25wNjW
         JOcPWPzDtyKj2J/Gxy8KHGH0DLmEvx+c46OEQ3+Ki6V2mTr5OvmrTBBPkwC8QZYykgKb
         xh5yvY8FmNEUeH1Zl25fnhvXAxzg73x9UJASCuMh/tA/dQMq6XOA3rpyF38+3ebc59p+
         lsd6mXW1qceGJ2OwZ0vsDkw4PhCjQA59dYTUUSFAeCaX5W0H8A3Z6ZNyjpQVAdFHnFQb
         nRtw==
X-Forwarded-Encrypted: i=1; AJvYcCXYAQIm25SHpHzlFtlwKvP1dtV/0NEWNd52EuUANBtrF9eAQsXwCWhiAr4AqP0JilSPDJKjmny9q0gdvTuHQek4OWO12TnVcb8RPObE
X-Gm-Message-State: AOJu0YyRPmvLbytrK26M2qSD2AigI2/r5cyg6Soy9KljMBZu8RH71u9B
	4EhsdmxkDUqhizYXi25KG910mNOK2hjz+p2HSv36XCDtzJTZS8Lr
X-Google-Smtp-Source: AGHT+IHDgWjeHxtt2g/hVU/3TRl9qcFhdZcV2B18vBMFJuDj7hH7ARLmzCghYbRLB48ebN9jXgXAgg==
X-Received: by 2002:a05:600c:4fc5:b0:425:6f3a:651d with SMTP id 5b1f17b1804b1-4257a020e78mr84264035e9.27.1720040693235;
        Wed, 03 Jul 2024 14:04:53 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0971d2sm249676355e9.31.2024.07.03.14.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:04:52 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 00/10] iio: Constify struct regmap_bus
Date: Wed, 03 Jul 2024 23:04:43 +0200
Message-Id: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOu8hWYC/x3MTQqAIBBA4avIrBuwP6yuEhFmU80iFa0IorsnL
 b/Few9ECkwROvFAoIsjO5uQZwLMpu1KyHMyFLKopJIlMjs0zh4YaN21H6cz4qJq1Uymadu6glT
 6QAvf/7Uf3vcDmrQOgmUAAAA=
To: Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720040691; l=1641;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=oHUbC0Frm2Z9eMFMoAhWcqVdR69fhOuFlCJxS28o33s=;
 b=NCL2AdlLpny6BJjY+XwwqargiwFO0AF4ZN0Ua70Lch/ib8dUlGuibHWLVO6YA/3mG1GGG1r4v
 4J6ZQ67FD6sAuQkjIFsVq485J3QxtPNNBc27DOUiJd+JHwy5c5kUIgz
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds the const modifier to the remaining regmap_bus
structs within the IIO subsystem that are effectively used as const
(i.e., only read after their declaration), but kept as writtable data.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (10):
      iio: accel: adxl367: Constify struct regmap_bus
      iio: accel: bma400: Constify struct regmap_bus
      iio: accel: bmi088: Constify struct regmap_bus
      iio: adc: ad7091r8: Constify struct regmap_bus
      iio: chemical: bme680: Constify struct regmap_bus
      iio: dac: ltc2688: Constify struct regmap_bus
      iio: imu: bmi323: Constify struct regmap_bus
      iio: imu: bno055: Constify struct regmap_bus
      iio: light: gp2ap002: Constify struct regmap_bus
      iio: pressure: bmp280: Constify struct regmap_bus

 drivers/iio/accel/adxl367_spi.c          | 2 +-
 drivers/iio/accel/bma400_spi.c           | 2 +-
 drivers/iio/accel/bmi088-accel-spi.c     | 2 +-
 drivers/iio/adc/ad7091r8.c               | 2 +-
 drivers/iio/chemical/bme680_spi.c        | 2 +-
 drivers/iio/dac/ltc2688.c                | 2 +-
 drivers/iio/imu/bmi323/bmi323_i2c.c      | 2 +-
 drivers/iio/imu/bmi323/bmi323_spi.c      | 2 +-
 drivers/iio/imu/bno055/bno055_ser_core.c | 2 +-
 drivers/iio/light/gp2ap002.c             | 2 +-
 drivers/iio/pressure/bmp280-spi.c        | 6 +++---
 11 files changed, 13 insertions(+), 13 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240703-iio-cont-regmap_bus-f7578bc89954

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


