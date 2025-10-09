Return-Path: <linux-iio+bounces-24879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F1CBCA646
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 19:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E041892DF2
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA572475CE;
	Thu,  9 Oct 2025 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rf7Hj9MJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245CF245033
	for <linux-iio@vger.kernel.org>; Thu,  9 Oct 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031375; cv=none; b=q6fVRcl6Gw1XRAQF6hGJrWKY1ZBM60BEohfoq+2WKfW2PTrGNR9aigQJGHCyDSbTCwpeuply67N5lPULEkMVJGcZj7AL/fsOk9IbOcXUJ0XEMaFMYEFJhXhhdQpYIDL7CasujbcpVlW30b50grHbulrWWZqBuvWY+NxSf/OnfjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031375; c=relaxed/simple;
	bh=/SYeFNLU2iy8w3uWLIu2KCxURtmYd9CoHQg5tdH9/1w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=UWDSwLfeuKeNy/SX01am/DsNZwbFhoK1AxfUTbxWsq9d9AG0BkMUcv/ettWoK+aiuN6fjwnxWp9uETZ+1p3tnFfxhQgbKUxWeeaOJF02/BVSt6XE8xVyFQRtPnFaNMoWqdO6REaItDjY/BLTLvKOSKFDZSD6aoyk4zU/n+hS/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rf7Hj9MJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b48d8deafaeso280096666b.1
        for <linux-iio@vger.kernel.org>; Thu, 09 Oct 2025 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760031370; x=1760636170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mh0GCFbXX/Jg13wPTNrh0yswWb/BBihUyjMJ4MtlgV4=;
        b=rf7Hj9MJiyk/jNiPXhJfXm/OcxDdcehku/47+/hYEFste2CHDlsvzH63jDu21J2+2o
         edUtyHPjUHjxxkAbCJiT1AZyzUzwlITFj8Abk2qDD1oqxXfBfTH/cAkQTn8kl5SXobJM
         MKP55IZRtKDuQA2slOfES5MCqZv/76XDTZ9UymdI9BNykKj3YkuLVjvuULyQ2CqJGLz+
         Tz0WIqrbzDUrHLVljncIhRr7Fvsr749amuvZ3xGvtEQ4oG3N8+3sASVNLICeh3yc/Rm1
         HLFCu8ZdjAUiN1RuZIURNc7SSDo+EpJzwiFtO7034WEr9Aamlg/lRVCh7z9DXz3TjHTu
         7oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760031370; x=1760636170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mh0GCFbXX/Jg13wPTNrh0yswWb/BBihUyjMJ4MtlgV4=;
        b=UZKVQ1UyM437zrB/gKay1ZpskOvIZVB0Ul5yo96hGsDj2Vt8T1jOft3m9fnFFubYOM
         6ifxSEmv4GaJos0imLTGlJGwm0zcfGxRZ1xZ7TmzHn8NIHwldWYDW4XR7aLJ3Nw7Z2yW
         Sr7UBw1T6wHDK5TOopZ5jYZk8A77NEWpO8h3h2JRgqGCzotusm1agWhaI/RnAi2CMSWh
         asF5uFc0DvvEOOobs8k3Qg4TH2Jaxg963KO13nf1jB5Ahd2B3sf00C42tfBDWhi7jh5R
         1eNDEmYkxx6X5lwJlw35wuO2XBRI2WyCJEN48LmRwEsowiL93bn6hVzbMmHyg9um0nte
         Qyag==
X-Forwarded-Encrypted: i=1; AJvYcCWkFocey1u9KNRtOhY+taDRGg3msBeTPqo3jwGH2I16/LQ1nGqHLIf5A0QvzgKTkCfWgfKlZa45x80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7gwGF4w99cH80YT5pQhpeyP+QDqQ3UjaOaGGECYYe37C6NvUE
	65pPAxHynm0oLDpJjptYpZewB8rkQH75prE953iwdlo/R3AJ7lIbZUcgrTmJXfpSyvY=
X-Gm-Gg: ASbGncsaUvktZT+uM/qU7psTcl8PbwtK7Zlaq7AlRa6g1ioj5Qac3raXiJXhAcrCkKV
	slEkkVbBVvWqM5dkt0X9/bU6YMQcPPxoimz6uSP26fQ8dCyN88fbUc3hsUKKWvQ1kYBD6jKLkus
	/I4mFr7KJ3gTU/v+5bc8TesLgdmrem5zlqSoueGhCcI10BzFYb5fUfLPRugRsYdhPnezH5kqry1
	WfbgbE6WrIoR2zHZBZzevd+VIkmhuOaaW0skZPSZywhUhhNqBW3TnL9wTYMVOCBMj8B3RXga+Uq
	t76dUGzmyFaGyswmFESGB8DaSBoXvxVfG0/omvQLLRMUoqAYXpP+x+smTUaJ8Wlk8gt6x1DuLjC
	SRZHb5v5BsXNDehmuzA==
X-Google-Smtp-Source: AGHT+IGUUgl923dofvYWCnwnBwJ5iK2BEsUopPu/EtG79xhGj80FMsabxCaEHX/FEtkUyNvprEpvHA==
X-Received: by 2002:a17:907:7fa4:b0:b3c:82d5:211c with SMTP id a640c23a62f3a-b50aae981e1mr1032203866b.27.1760031370431;
        Thu, 09 Oct 2025 10:36:10 -0700 (PDT)
Received: from localhost ([151.35.157.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d951deb6sm20543466b.76.2025.10.09.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:36:10 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate
Date: Thu,  9 Oct 2025 19:36:07 +0200
Message-Id: <20251009173609.992452-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=flavra@baylibre.com; h=from:subject; bh=/SYeFNLU2iy8w3uWLIu2KCxURtmYd9CoHQg5tdH9/1w=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo5/JEGVK232nIvaF1SA41k2gIPzlcjF3hijamy YYigWNY0lKJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaOfyRAAKCRDt8TtzzpQ2 X5RwC/9Y0G0mcswp/6fziCZGCcrAe0pRmtUdIzh7fwUhXHM8+fOWaCfjoggts8fN6HM4n07H9Lr zo2TP/JesAzzsZ1onjRK1YmhHAg1CjZJHoHueZZbmU+bb4ppftICM2g8sh5CZcK6N6dVSohRSTM T4BtpRKF0yF0Mg0+8B0SEI9nACfoO17sL8H+obwZycETXbsBmuE0z14OrUTgg9KhuFTTFSMSlyP P7e8SFUHzZdnLJoEqzjwhGpguFvSrFbqurs/2OiC/6NxwqZdVFeBEUIt3+yGAPZTkrMep3WUNO3 8QvD4LpSEJA7sHeIHr2J7js1jS9hocXO3JrJad9D319fYfuf7QrGzMjGNvMnG+R5W2jRWU3xEkA tBd8zjrR83SB6KsXVxXuR+k3ibZujJPuZjXPpH8LZO07lqD8JSIGcwAB7BajZYrLuOSdL/mfxov 2extpN6rcVSzZbQREqm6sdJj7zhTDqA9zm3y9OV9h5UColUJmY7dnK5DQpglZ7Zwhe9nk=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The rate at which accelerometer or gyroscope sensor samples are fed
to the hardware FIFO (batch data rate, or BDR) does not have to
coincide with the sensor sampling frequency (output data rate, or
ODR); the only requirement is for the BDR to not be greater than
the ODR. Having a BDR lower than the ODR is useful in cases where
an application requires a high sampling rate for accurate detection
of motion events (e.g. wakeup events), but wants to read sensor
sample values from the device buffer at a lower data rate.
This change set amends the st_lsm6dsx IIO driver to support the above
use case. The first commit is a trivial fix to the source code comment
that indicates what measurement unit is used for the `odr` field of
struct st_lsm6ds_sensor, while the second commit introduces a new `bdr`
field in the same struct to implement the new functionality.

Francesco Lavra (2):
  iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
  iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 64 ++++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  9 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  4 +-
 4 files changed, 67 insertions(+), 14 deletions(-)

-- 
2.39.5


