Return-Path: <linux-iio+bounces-18787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56617A9FA6D
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 22:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F387A91DF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 20:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B211D514F;
	Mon, 28 Apr 2025 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hwHVHWBO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353C8C0E
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871846; cv=none; b=YbnTu0yStASBq1zrhPXKGMuRrt/m/U/S8rMZwIzckB/UBt/GLfQKdsCU95l1nome3hi6CNCMdGP6mwaH5PjWE4s9SpkVcd64XE1IDv1U+WqZ0bs73G7z2/MZYkqrsHcwZRo7zpUAdKgA1YZ+OMr/cnbYx3o1WrSzcAx3PvkqG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871846; c=relaxed/simple;
	bh=a8bJv4lOvUcgV41/KJzOF4OaGq1VqvfSWIwe6HuDGqE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W7XcUpVgeVXAYhm6vhtGMqjIDC/t2bgUZn9IEZtzHiDJZ85yngOHNuBr2wDs0kwn+EUL4i/tQ4mSZruCwAOdlLw7wX+BUBSo0azQpFSWJXXok/iv1h/dE+KhDTeZPwKzrvMKMgbR+j31g7nr5S6eOXLcTJeFXLwfZXFz1X3bm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hwHVHWBO; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3fb3f4bf97aso1607739b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745871843; x=1746476643; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9tdKCqfhNi/JvvQ3LXajpm7vHRn6watP93o/+t4rnHA=;
        b=hwHVHWBOUSROCpowmDTJHiytDhEYmm6ncbCyiNfjlSALkwYTpGNNntFqNeXNHfkEul
         NtmoMqI+lfHI3NX0J+Hjkd4nyARLPWkARcs/0w34TiTk8+mCMgpa7p3LxqogXfD/eCSL
         NrVy9Bg699CyH6u+Hpxf3hTq8HV9Bg62t7R7TItX2AMYRMfdKdurxTID2rUOl8CtUreH
         Czk2zQtboluf7dgjYomxmNeFtkccnfa5UaAwhR3XP8mfuzrpuB1rekjC6VDTkOLR7EeS
         J3uihtUNZdeb0z4FIgeQ9XviCaeeZeAKt+A7TXnTyl5+BuBtcwa5DfvoQSHQrbLZLEXR
         yu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871843; x=1746476643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tdKCqfhNi/JvvQ3LXajpm7vHRn6watP93o/+t4rnHA=;
        b=nxKSNRWqnu2p2XqvDjpS+zQuMaHsppVHtN4LZfJg4U1y63qCX6C5l/W4cK2L+nw4pq
         0iW2aej8aS8+MI+N9p/3G98mSZ7WRoNJqm7oYMjYHfFSIMyNh/+1HgyrAP6ucO052KqT
         YDnIuwmljPn13ohDaiNm/OnP1vZvrtYAtoSb6pbZwnPSu6ASnCOPxZ6/7X0A48JGNAfq
         oNFrZaOPYeVDcZQc7IRxRtC6AqchwSCHuMNWBYU8tGgkPE1XTV74FWYMFdhq82YhQoG2
         sqWUhNylzSAaw60fn7hbbxSqoXdVgfcSMlfatF/KpuEmXtb+7ntm8ElzeSOhIQ0ossun
         RNRQ==
X-Gm-Message-State: AOJu0YzNJ2g3SdNSPZ1wk1FkgIaiNhGdrd7aygiVXmdGxud0InJ2Qru9
	GUBHNNXZuGe4YnGm2+GWzTbeDggZLvoWBrhQV2onuj3qIsjGUN7ayKByDgHx0H4=
X-Gm-Gg: ASbGncvOaz6LAjbUKV7hLS2ZedmzRoyUzE+EgiUreSwqSjdV6ym4OMPLv/hxYzYd3nE
	VhWJHyN5JBm8pcTyZU3wTkAddSGYfkhJncVRbjb0JDZMnVKSsKjsmTYkPBWBp7WPp/0JPL1k7id
	26l1pAzYGLY6tfNEAELFUKCALihXUC0wrRyvUyh2DFZ2HYbi1AUWnjBQ/dm2KuWcm12XyPGkZ5J
	+FjlTHKpvvyDUJywwZkt4uMdr5RZkOfPhy8sEOXRiTxec3pra9edRnls9N/HqPpr5i++C8fiDZZ
	hjL6DU9EK2COei4c6g5Y8SHUV1QeVCIrqcCCnUL7HaZa1S8=
X-Google-Smtp-Source: AGHT+IF1EuPjn/DEf1QhC+aDlZPSIxSeXzD/o5izMSvjBsPrlYnTcW9R+2F3oqNl0RUDxTkvTw1Hfg==
X-Received: by 2002:a05:6808:45e8:b0:3f9:28b9:7013 with SMTP id 5614622812f47-402116321bdmr140283b6e.39.1745871842781;
        Mon, 28 Apr 2025 13:24:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401ec970ec5sm2196187b6e.34.2025.04.28.13.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:24:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 0/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
Date: Mon, 28 Apr 2025 15:23:02 -0500
Message-Id: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKbjD2gC/53NQW7CMBCF4asgr+vKHidx1FXvUaHIsWeakWiM7
 CSAUO6OwwpVbGD5v8X3riJjYszia3cVCRfOHMcS1cdO+MGNvyg5lBagoFaVbiVzlDxOKYbZ41Z
 dQH9wCbt+JsLUnXgauilLoNZaQza40IjCHRMSn+9XP/vSA+cppsv9edHb+sbJoqWSiMo34Ixxi
 r57dzlwn/DTxz+x/SzwYAO8YEOxDQXTVLb2VjVPbPNo1y/YptikIZDuiaBq/9nrut4ASKi+Y5s
 BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3246; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=a8bJv4lOvUcgV41/KJzOF4OaGq1VqvfSWIwe6HuDGqE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoD+OqjReq+BhspuUVtz0EMsqRO/lA3U1zBWnP4
 ZDmhDleszeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaA/jqgAKCRDCzCAB/wGP
 wJ8ZB/0dhW1BDI5dhJvZZQbIpgkQVXzm3FHw7pEzQ4dLhe+9NyHNfV+/EvpQ02GLQZoBB3LMG26
 KPUin42QdiNYuFXDQ0G2WIVSQAXEpPU7gpIdKCKH+XECYH2eEG0byEGcvqVR//BBsxWnMyMT6ht
 6WGTgzJqMciiPE4RJrZ2iN4197LY3qvKppTRqh4tde/4eKKI5wcUQ+YSkuWsHPwm6sbgMZi/50s
 NplZKQIQJgrrP/5AyXbECJqkEvuQUy3QxA/h/bRYYwo2LT61TiYYCsGAaWro+il1pXb+WPTly19
 k3S/4+j0KA/nqaSvHpyqhAVj0FQsJtWPfJfOOGxk+/P+Qedq
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
Changes in v4:
- Dropped static_assert()s from the first patch.
- Handle case when IIO_DMA_MINALIGN < sizeof(timestamp).
- Added one more patch for ad4695 to rename a confusing macro.
- Link to v3: https://lore.kernel.org/r/20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com

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
David Lechner (7):
      iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
      iio: adc: ad4695: use u16 for buffer elements
      iio: adc: ad4695: use IIO_DECLARE_DMA_BUFFER_WITH_TS
      iio: adc: ad4695: rename AD4695_MAX_VIN_CHANNELS
      iio: adc: ad7380: use IIO_DECLARE_DMA_BUFFER_WITH_TS
      iio: accel: sca3300: use IIO_DECLARE_BUFFER_WITH_TS
      iio: adc: at91-sama5d2: use IIO_DECLARE_BUFFER_WITH_TS

 drivers/iio/accel/sca3300.c        | 18 ++----------------
 drivers/iio/adc/ad4695.c           | 16 ++++++----------
 drivers/iio/adc/ad7380.c           |  3 +--
 drivers/iio/adc/at91-sama5d2_adc.c | 13 ++-----------
 include/linux/iio/iio.h            | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 48 insertions(+), 39 deletions(-)
---
base-commit: aff301f37e220970c2f301b5c65a8bfedf52058e
change-id: 20250418-iio-introduce-iio_declare_buffer_with_ts-2f8773f7dad6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


