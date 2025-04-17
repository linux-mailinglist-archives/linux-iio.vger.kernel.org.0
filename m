Return-Path: <linux-iio+bounces-18203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA6DA92317
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 18:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EEE3B4A0D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D6F2550B4;
	Thu, 17 Apr 2025 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SnK8VwPl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E63C19DF9A
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908819; cv=none; b=U3ASEtVsEDDaUCd5GbH9s5v0roQGhjJv2+YVdl3nEDsDR580yzhAUnJhC1Ke50Vq9+9+xqdrOfddiKY77IjUHgdEryRxvz6qhx2OM8XF2tEkQvBV7fucm97H6jpFVCx/2u8agsaDb9tTaHgnpqeKPL/0ORzeHpq0aZRAnZjyLvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908819; c=relaxed/simple;
	bh=Sz+7sWlyolxS4Zl/eEi8a9e44hyD2IGfO6dXn8EDJGw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ja7WLN6XFTjrJsxlzVRtoJ92JPJwXnwxiCjdGAcu14Fxwt9aQ7XM+LWfUBwHI3OfO29wx2EJ+WrwQYHe6GvWCt481Vbh2eeWpsxgLDQTpgCQ+TkzeI7lQzONVZm8UV1oGOxs51JlonI1hxXHnXGiFpWjSprj6kjtFX6ww9ZO7AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SnK8VwPl; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c12b7af278so674060fac.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 09:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744908815; x=1745513615; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMsi2WwJ6hjhub+TfZ/EQK2V+POxMxNiG2BzOtIkvYw=;
        b=SnK8VwPl3LPb76nnvSb4z0D1/tyGV7x5zbiBFAFlUOFLnnFHT01/YdvQi2vmOHvhn0
         yjAJ/dSJljFZuAH7XrxmMvRopQ9TtgW1aENU3663K8BGHyTtxdwUvG3FHc0jOkynGqov
         VZIv1NpmzVbd5UNESm55CKWeqw80p/qOh336HXNWeA9eeKnPKCcw51TpIvTEtXkC9Qb7
         AYLqdZ0xboXq6Ozk6FCaEbHAhNZTXRmzgKiYZhoRuZ8WUSrCVAoPtTzEDg+itcAcBQdP
         UNLlnxoWK4plFasLpBPReDjlmR1u9xyIZjRmkI9Y2hM+Msw+yuQA08pA1do3yRfWwixO
         zS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744908815; x=1745513615;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMsi2WwJ6hjhub+TfZ/EQK2V+POxMxNiG2BzOtIkvYw=;
        b=XGFqprDXM33okRnvz3U1Xwb1qVzhkEro1AkqOfIH//AEQHnROwevJHXp0OYfj1puM+
         elL4Vcvxza9NjbitQa22zE6I8p40ecCykc7ES8OUcEzjLAnday/aoXcp7USf31OaiQKB
         XAdfPCTlSK4BBt5h9yVgCHFQpMCKzOqlcHN6YMkns4bZyO5njbtrF/wMVYNB+4VX5r9L
         2sqDtblXu1Yn08eqg3XBHs/obp92CXAt8FB3bat3oDK4VGpgqmNVZkgHQ5EHfC7XYxri
         /1rW0Fx3u/3SLTNOlXL1FO3/jRzuNXG7ZW1PVei2e9G3/CXDwyQIvpjBb0YIGI4GtiCb
         MDag==
X-Gm-Message-State: AOJu0YwIq3Ylg4Y0nMYd4IB4K4S6MS2bVaDzGHdnlL/llVXtvqApRSRS
	nEfF3lsHLWCFeNCWaNAlieliy5kHRE+N5JmQbJiHibvT2qVucpQ9KxwX/IbDTGTx3bjPSkwObQh
	DofE=
X-Gm-Gg: ASbGncu0K2hB9TOht2HjtzXYCOYSt2nwJLceKdF+xdrDFhI9hbW0g3l+bg/tpHXNMol
	2PhmhygWL8D6QUiFfcU17W5QII+4Bpd+4yERpudPm0kN9OnFgnth76meoAj9bV35MshjBLpcbw/
	nsmXW7K4TJknKfAd18j1WA1EdfWWY2IEG2ITWOc2uO58jydWQLSXDYPqO77V51Khbx+yNaQfo7H
	yIddnSk+OXHHMS7WFDWDWEl7ffojoyZ6FgBq35LtS+xtnUeCKOusp4nL6kWDQZ3ECA0wdafs9PH
	tgCF9RMP2xjQtGlOxRW5JpGJpifc/RwHhx65rNCvsZsKpP8=
X-Google-Smtp-Source: AGHT+IFY/vO7y8M2CG7Oo5TX+7MViwzoQKB+pziGqNMOOxstSmF5iwhAC/aDMXMw925f6TrhRA+Olw==
X-Received: by 2002:a05:6871:71c1:b0:2cb:d32f:2f18 with SMTP id 586e51a60fabf-2d51df2a8f2mr362900fac.16.1744908815275;
        Thu, 17 Apr 2025 09:53:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5218248b7sm15812fac.47.2025.04.17.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:53:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/8] iio: more timestamp alignment
Date: Thu, 17 Apr 2025 11:52:32 -0500
Message-Id: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANAxAWgC/x3MwQqDMBBF0V+RWXdAxVrpr5QuRn21D0wiSSgF8
 d8Ncldnc3dJiESSZ7VLxI+JwRc0t0qmr/kFyrlY2rq9113TKxnUhQjNdEjZ3Ka2cvEOPms/lWx
 4YJxNymKL+PB/7V/v4zgBSmlh324AAAA=
X-Change-ID: 20250416-iio-more-timestamp-alignment-6c6c6a87ebda
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Tomasz Duszynski <tduszyns@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Sz+7sWlyolxS4Zl/eEi8a9e44hyD2IGfO6dXn8EDJGw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoATHTMUD0F9owkDNUGccr2O9643S49NzTkqNd8
 qD0QXO+JF2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAEx0wAKCRDCzCAB/wGP
 wPrkB/44BUumGHVPTUE3N/as04EvFSkdabzEdJ+zuY8Gv7nu0W0unpkR8WIuN6freUelK+lDnsz
 aoZzHpnCJbmaP0oogKGJpWPhmUGK8+ubL5bCgkevBCpizO9+B2P7PmmH+QRI1YJYk/nTwR03+Be
 tys5+hxNRkMNHrz1Vi3ORz04S579JM0cyJnUMg2HcI0jYNC4YWvPBxy5UQTMUVcdmLshiV+seAv
 6oSaxrXmLE0I55TicHv9sP3uNkJuRCZJMEjb7AM1yl3wpkStx0bTjU7SzSkI01INwxLmBRzuj5/
 2u2+9LvXToRIZ5CF/BHCR3JX5yD4lKx41QwRgNWsXt06XUpE
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Wile reviewing [1], I noticed a few more cases where we can use
aligned_s64 or need __aligned(8) on data structures used with
iio_push_to_buffers_with_timestamp().

[1]: https://lore.kernel.org/linux-iio/20250413103443.2420727-1-jic23@kernel.org/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (8):
      iio: adc: dln2-adc: use aligned_s64 for timestamp
      iio: adc: mt6360-adc: use aligned_s64 for timestamp
      iio: addac: ad74413r: use aligned_s64 for timestamp
      iio: chemical: pms7003: use aligned_s64 for timestamp
      iio: chemical: sps30: use aligned_s64 for timestamp
      iio: imu: adis16550: align buffers for timestamp
      iio: imu: inv_mpu6050: align buffer for timestamp
      iio: pressure: mprls0025pa: use aligned_s64 for timestamp

 drivers/iio/accel/bmc150-accel.h           | 2 +-
 drivers/iio/adc/dln2-adc.c                 | 2 +-
 drivers/iio/adc/mt6360-adc.c               | 4 ++--
 drivers/iio/addac/ad74413r.c               | 5 +++--
 drivers/iio/chemical/pms7003.c             | 5 +++--
 drivers/iio/chemical/sps30.c               | 2 +-
 drivers/iio/imu/adis16550.c                | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 +-
 drivers/iio/pressure/mprls0025pa.h         | 2 +-
 9 files changed, 14 insertions(+), 12 deletions(-)
---
base-commit: 3159d40a2ca0ae14e69e1cae8b12f04c933d0445
change-id: 20250416-iio-more-timestamp-alignment-6c6c6a87ebda

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


