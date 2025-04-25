Return-Path: <linux-iio+bounces-18663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CC1A9D3E3
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 23:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C3E3B5BBB
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 21:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4EC22425B;
	Fri, 25 Apr 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RZD7uDaE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEEA21CC59
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615380; cv=none; b=rL+ByZbn8X37qQhhdoYVRMjWmYCKg1u6Yt3afpvySm5jcVugMCkNMIoj6z1cBLKtZXieZdnPNfiBY9jiTkpSQXUgxP0Y2giMGK0522p7HBYNpBZMmjtXtVYbbFMbkBaZ/Do27qB6QJRaUlM3VlOWTpJr8DCIzTW9TQNn9LJ+VkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615380; c=relaxed/simple;
	bh=o7BcIIIYtQBUHMADOGXaeTJA+HEbSY/NkKPNVQoDqrs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z+uXzEV2QBeQk77CBDFI80w+CNfp7YX0lgMHtrZ78dFDpURMr4roZIUAptmtfqSTQpQ3OjVad9ZcBJ7qryMqDXcpaxuzOtlpZHIuJfo9C0cCulMKJYkvfNph912T9wNrQ7EzhgXXxoHxqSLRhOPhzIglFufvPq/UvfGfUKa8GIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RZD7uDaE; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c7f876b321so807857fac.1
        for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745615377; x=1746220177; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VpoMnDgu+7UC7RtrUCDJGErjf4myIlSL18Se8Lkjx+0=;
        b=RZD7uDaEEDsgUPOKcaEh8DhITSnuNMG786mPtCcrg0bmzefcJYMSAm/uDxIAVonIHV
         XpgVfGI9bIUpEVEfMsCplM1f0b5aNeybzmo+Vm1WfG0r/NpoF6VWNntdUd0KDrXmSaDj
         hDS/t/f4kskzX026XaC9QFD5D1m7NSTE+CyzvWV/39LmlFG5n3l05ZT2cRkEkxfbhpvS
         kf/8xVtYi1GyZGZe7QHfxGqR8gMuIf9FPPtsUR3Sh5tZldNq0tsYBhmugSwqrC6AU+rE
         MId8nOIYLFxWCN541NdnMWRqmDmogIZClNhoiLmVoM6GSX7qBgU+gMnEu/ikowIPVJZs
         ZDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745615377; x=1746220177;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpoMnDgu+7UC7RtrUCDJGErjf4myIlSL18Se8Lkjx+0=;
        b=qJpMQ7S3pyGQsJnFGDPakD4qRxnPh/dwKtRjhckDswL3+gUJfeF1zybQU4NGuCyIJD
         aMi1dQeXHEakAmIPoZNjUdyDT6aFM14ZEF5K+3yWQo1unR8VD9gYPz+6Yh62voYDRNzj
         SMY/MEJYvWVyG0CV0sdiqIDs9H96jvU8J//RwHCG2RDmZW14Wc7pZr9OqRssrTqiNOVG
         R9cGGmlKO+dR7wWRIvBUN4OeSMcibBIvQ2oDr+hRYEFazNzEZRJ/Z1ZY/PQ3W7R8xCfM
         qS/NAAsKwk1JYLD2gaq51v36OLlrQt3NxzjyE/GhftG/OcvYz08CY5c1ZJshK762A0He
         fPxg==
X-Gm-Message-State: AOJu0Yz/qfGd65fBG3ic4oIpFYugfC5+8zSq0RRt4G4+xknq+ReKXgP2
	PuhEOZmTuKgdX063C2WzOXRaaq2EZwzeDS28X6q9STVk8Sp6CfvBEsn0EXwBeO0=
X-Gm-Gg: ASbGncuj1/FzcVHWQ6v6LDiWN1T4aqmacIFuwX3bO+LvT9NV4lXnmVzTc4N0am2B4ok
	XubZtryjH1Ege4WpV3yMCGlNzrozCe5Z8Amcv8ayUbEDZTUUNqK3dronqEtbAsfWPQfurp5fTsX
	497ptCUb48ZWHk0tFF+I9k0bB5nraiCwWNyom/I6zJEDhgeUgBUYjo3bwZqZz7YxkEk3n0qteom
	YvjWZWsKQbiulw2FbEUrU4aU04WNXNXV3mqOXwh0c1wGDoZj5tKw/0l+W9Caw0/SsHWaMyy2Yhj
	CBI9f9GOXqSjAvtSmMYd0XuTugB3Hpj8oniyNfiEw0TZ
X-Google-Smtp-Source: AGHT+IHyxrjoVl0KXbSfTLDYg+CfefqZM8U73y5ZfAGM3b42y6FXuX1DXtEWNsTF1iIIW4wUhTqhCA==
X-Received: by 2002:a05:6870:4595:b0:2c1:62ba:cd7c with SMTP id 586e51a60fabf-2d9be58e9a7mr562692fac.15.1745615377396;
        Fri, 25 Apr 2025 14:09:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f188052sm847673a34.8.2025.04.25.14.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 14:09:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
Date: Fri, 25 Apr 2025 16:08:42 -0500
Message-Id: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANr5C2gC/52NsQ6CMBQAf4V0tqa0QImT/2EMKe2rvASpaQtKC
 P9uYTJuOt4NdwsJ4BECOWUL8TBhQDckEIeM6E4NN6BoEhPOeMmKvKaIjuIQvTOjho0aA7pXHpp
 2tBZ888TYNTFQbmsphZVGmYqk3MODxde+ulwTdxii8/N+nvLN/jGZcsooANMVV0IoZs+tmntsP
 Ry1u5PtM/GPNuc/tHlqC2tEVchSS1Z9tdd1fQNOGb/UPwEAAA==
X-Change-ID: 20250418-iio-introduce-iio_declare_buffer_with_ts-2f8773f7dad6
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2871; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=o7BcIIIYtQBUHMADOGXaeTJA+HEbSY/NkKPNVQoDqrs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoC/nfUdqmW0DVoD+FZo9SUw5csNWXEkaFoqBui
 bDyBU03m8OJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAv53wAKCRDCzCAB/wGP
 wLHkB/4wQyGYDFJQjZBiYUgnhQdUEp7hWNlwqnEMYH7bFvPguWYt69E7pqXyv/o8AcRNpyFNwz7
 u+Nipjjojviqe1z+4YYo2BZksKHhnD+lVzRMc3bXv6KePvl+P2mYERNI+/Tf11auIDjhSuL7rH8
 KPBmB3NxXecOJdOBdP5QUUYXQPHCraoXxDz59qmN2nxo3WrGKrc24+lYx5Dl2AjX+2h1lS0vLOU
 bW1wWQVh+tNBUPdS0Gw6eM8I6mvVSSIGSyJkPBJdJfx/5YXub2e9puPgxGWGWugNQjiRkDsCNQx
 v8dZdYryvHvoLQcKJ4YsKxnSMdkJxVZpvCJGqoyCyfNk+jSC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Creating a buffer of the proper size and correct alignment for use with
iio_push_to_buffers_with_ts() is commonly used and not easy to get
right (as seen by a number of recent fixes on the mailing list).

In general, we prefer to use this pattern for creating such buffers:

struct {
    u16 data[2];
    aligned_s64 timestamp;
} buffer;

However, there are many cases where a driver may have a large number of
channels that can be optionally enabled or disabled in a scan or the
driver might support a range of chips that have different numbers of
channels or different storage sizes for the data. In these cases, the
timestamp may not always be at the same place relative to the data. To
handle these, we allocate a buffer large enough for the largest possible
case and don't care exactly where the timestamp ends up in the buffer.

For these cases, we propose to introduce new macros to make it easier
it easier for both the authors to get it right and for readers of the
code to not have to do all of the math to verify that it is correct.

I have just included a few examples of drivers that can make use of this
new macro, but there are dozens more.

---
Changes in v3:
- Fixed a few mistakes, style issues and incorporate other feedback (see
  individual commit message changelogs for details).
- Link to v2: https://lore.kernel.org/r/20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com

Changes in v2:
- Add 2nd macro for case where we need DMA alignment.
- Add new patch for ad4695 to convert buffer from u8 to u16 before
  making use of the new macro.
- Drop the bmp280 patch since it was determined to have a better
  alternative not using these macros.
- Add a few more examples to show the non-DMA case, both in a struct and
  stack allocated.
- Link to v1: https://lore.kernel.org/r/20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com

---
David Lechner (6):
      iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
      iio: adc: ad4695: use u16 for buffer elements
      iio: adc: ad4695: use IIO_DECLARE_DMA_BUFFER_WITH_TS
      iio: adc: ad7380: use IIO_DECLARE_DMA_BUFFER_WITH_TS
      iio: accel: sca3300: use IIO_DECLARE_BUFFER_WITH_TS
      iio: adc: at91-sama5d2: use IIO_DECLARE_BUFFER_WITH_TS

 drivers/iio/accel/sca3300.c        | 18 ++----------------
 drivers/iio/adc/ad4695.c           |  8 ++------
 drivers/iio/adc/ad7380.c           |  3 +--
 drivers/iio/adc/at91-sama5d2_adc.c | 13 ++-----------
 include/linux/iio/iio.h            | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 45 insertions(+), 35 deletions(-)
---
base-commit: aff301f37e220970c2f301b5c65a8bfedf52058e
change-id: 20250418-iio-introduce-iio_declare_buffer_with_ts-2f8773f7dad6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


