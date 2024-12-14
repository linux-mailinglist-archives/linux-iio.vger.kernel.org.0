Return-Path: <linux-iio+bounces-13475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02AD9F2090
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 20:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3420D18884E3
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9FE1A8F90;
	Sat, 14 Dec 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5TFCZry"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8A01119A;
	Sat, 14 Dec 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734203668; cv=none; b=J8gRLWPNgll/QOrgvKXqD9+Ho4x0JK/JMrLDBi60VkFcGyjQMDRfAAr74TcSus/QjhYMIpCX6OImG78UCv7J1l2Vo4iGng6Gqjo0cOCYbtpFN0bSZ4vGYC2tFZMclGtrrccYlAkcU5egyvkdM50eSmg3UYzwFgjsiWGHRn5bq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734203668; c=relaxed/simple;
	bh=cYSFnGh2fLw2vwsevnBufT2TuUniHzccCwuW6w9JAyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ep9PIFJ2Gxypw9CdRqkCDE/dziDTMhLM/wlfIpsfmTANGxiU5+ng4EKlm7LKZ+yWm7CpiAycGQo/8S2AeA4Ro3gTexrps9kuXI0dBhdCyGPKR048RmXuTMHLQIkFcs96A9grqY3l3oZnzqMLhb8u2S1QSkOJZVG780MCpV226tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5TFCZry; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa67f31a858so520286966b.2;
        Sat, 14 Dec 2024 11:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734203665; x=1734808465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sHt1yV913SBKMYKwr2B62SmblfJN7VFfconWRSxrnpQ=;
        b=L5TFCZrycPSOm2d5YDLK6MtGDEDQnp73X4MUMTbIr/9tAtNEg2EYZuHb+4UmLJM/0j
         oDq7qc/vpUriq2G97Q3HUmknDdicLzb+7qB4bBdjXbMrqaIllYYnWi54xG3uOPP6yy3/
         H9n0mZJV7QnkeOzQpBk35pqr5gHUoOFCZYHFwIujMJ3IUlG1jDoihLQOY1iZlLivIX49
         LQbUR8ctC/hk9w+I2+yGKraHESHI5OWJpj/JhSU4g4Cu62ouoUQEXrm6KEhuM5fIJzcE
         zhYdMZjN9tnKFpyvQX6VqV2eJla+r0KkkkwihiITZ7adkJQLE182YpFFjwF75p8+up/u
         mEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734203665; x=1734808465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHt1yV913SBKMYKwr2B62SmblfJN7VFfconWRSxrnpQ=;
        b=FYmF/2gdPF+ykgiJjT4zBb9Rdj/CxZ4mH23cfPt7M19CoHVoHic8S/DKv+gFpW5x8q
         EDHe1Rih+h0ce5JFysLN42UuVQHF8DgxMOTdY8vDFoTuoN0leK8D5a/ujDl8rHBZPR5/
         J0Y3LSa7bqyx6+heHp3X9ob7WdbHCcNGqYkZMHQrq8vzXNhJ0b9Hg47tBT20MHr3mNwD
         ucyvSiZuzaIdrOgmXRuF1/3Z0YsLVkd+znjtNc1ahUmJySXw/C79mv9UKebBPHJ7tD3R
         DSmGCFdypxL+OVKReebNy8JlTERuCF6M8ntMNBCcX6Ccs7UsYhM+lFTMvdWgbdbQkN+j
         6aKg==
X-Forwarded-Encrypted: i=1; AJvYcCUNfzi2G96tvIqJFEdK1D7na7JYDvI7k8hPDskdHHEQJ70IgqJL+5TXKiU/3AaLFGLQrc78g/K8ubPzvd5H@vger.kernel.org, AJvYcCUxZYVsjfgG9eLYRD4Tvjzt4aAdW2zdacXB3S36e3NQp46253V3doDVt5UdUp689k9/rJ7DHuY8g6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKdHUkLViENt9/JJasDy7c0RAhkoXhRMZatejRk7Bd/Y0BzMa
	RFMFoADbXH2ktgcPkH1m6lpsZpCmwqWqQvX3OQu3t31roTKXDSaz
X-Gm-Gg: ASbGncuVWle0Nr64rv+1D+CoakKnQgDOB9qCyyi41Xdc6wNfWuQOWMDeFa3v58aCxVo
	QQgtfh4dIs74vX2E1XylckKSed8/9qBEnS+wTu3cchaLYckCz/Fbls10+0cVWLo6TE/sAm4/Gjn
	jQgDpl1O7LqlDkzxbArf4O6wcA7haVO9W6+aERJyYorc1qCJbE2+lU7B2lIF9dO72DZ1a/bzcdn
	h0v82JoCEQkrkKtXXsDmOVPdGgvUv08x6+xvqhxh6lZYjSiLOl2aSQncow3IldLI7jHCw==
X-Google-Smtp-Source: AGHT+IF21/ftMd2RPjWjRYsWHuXqfjIsab0dKZlIwKH7lKHasCwUqTODbARDsdp2mjZXQq/DRzR/hg==
X-Received: by 2002:a17:906:6a04:b0:aa6:800a:1295 with SMTP id a640c23a62f3a-aab778d9d9cmr702645966b.5.1734203665222;
        Sat, 14 Dec 2024 11:14:25 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:abde:dd08:a767:d63c])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab963c54d2sm122818766b.190.2024.12.14.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 11:14:24 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: krzysztof.kozlowski@linaro.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	abhashkumarjha123@gmail.com,
	jstephan@baylibre.com,
	dlechner@baylibre.com,
	jackoalan@gmail.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v2 0/4] iio: mark scan_timestamp as __private
Date: Sat, 14 Dec 2024 20:14:17 +0100
Message-ID: <20241214191421.94172-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:

- Droped patches 1,2.
- DLN2-ADC: zero full struct instead of just the padding
- MAX1363: add the data buffer in the iio_priv()
- SSP_IIO: calculate always the timestamp
- iio_push_to_buffers_with_timestamp(): mark the access of the
  indio_dev->scan_timestamp as ACCESS_PRIVATE()

---
v1: https://lore.kernel.org/linux-iio/20241130002710.18615-1-vassilisamir@gmail.com/

The scan_timestamp value of the struct iio_dev, even though is an
internal variable, it is being used in some drivers. To avoid any
unwanted overwrites of this value, create a getter and when all the
drivers are converted, mark the variable as __private.

The patch is an RFC because the added value might not be considered
high enough by someone to be implemented and/or it might need to be
done in a different way since it touches multiple drivers.
Vasileios Amoiridis (4):
  iio: adc: dln2-adc: zero full struct instead of just the padding
  iio: adc: max1363: make use of iio_is_soft_ts_enabled()
  iio: common: ssp_sensors: drop conditional optimization for simplicity
  iio: core: mark scan_timestamp as __private

 drivers/iio/adc/dln2-adc.c               | 21 ++---------------
 drivers/iio/adc/max1363.c                | 30 +++++++-----------------
 drivers/iio/common/ssp_sensors/ssp_iio.c |  9 +++----
 drivers/iio/industrialio-buffer.c        |  2 +-
 include/linux/iio/buffer.h               |  2 +-
 include/linux/iio/iio.h                  |  2 +-
 6 files changed, 17 insertions(+), 49 deletions(-)


base-commit: a3fb9f5202c3de0ca84848a475f59a0e0584d9fc
-- 
2.43.0


