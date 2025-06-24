Return-Path: <linux-iio+bounces-20951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885C1AE7268
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 00:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13A07A8E76
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 22:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C1725B66A;
	Tue, 24 Jun 2025 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XJchwPpw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB942185B1
	for <linux-iio@vger.kernel.org>; Tue, 24 Jun 2025 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805101; cv=none; b=Y4Qm3upVTo98xjjTy60ZxASxgd31UcacUqvyhj68cu3fZItSUWosGB1AX/00BZtXl7uIWjsvlf3+lcjGazW2TQhSiAhL9GjE7sfRfDQsrFFGtCtRx+Tg45G4Nhf2CyYHtT9JGS/TCnzhvysHi7OXGWabBzp2BDnosP4Y1Sn4V5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805101; c=relaxed/simple;
	bh=mcJFllEeRF+yE7slrMbAaaS2eHVpby7as1ptgR6ihnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uLHZwm7rat6uPrdJGiZXb6NnzPWHJBTa1ER6xzblYhSbndoKEvqgoE95Udh1c9Xk/b6CDCIgMjwXL0Y2gWPC2oPknhRESUUo0fbB/lAeuS9KA6raDyMg3uD/5MDcLfUAAigeV4MgNMD2LyYwMEEVq8rJF7Gvfa7/fUIqsMIfJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XJchwPpw; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-86d01686196so35354039f.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Jun 2025 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750805098; x=1751409898; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRXMbmGHv5qc0+GRIglNxAEcLatX5Y9+ZZFfOH/sgcc=;
        b=XJchwPpww2xDUEi/0t2Go4QNJyfs6gmyh+Z391LHtt1DZvm0jenF9v/wcIE5si5uq4
         gvdLh7LX+dEqjvzmyblna39xz5ScBmfNT5CW3Y25CZFqRU73Izu2iMYPVMxeHZsBLQEU
         nqFmsorqSX8vts3ZzSiw4FrcjO5XMkj4S0YVPd7WxM5o4vT7MFxI2R15hU9tNzzYDL2Y
         GA6ZoxAx2/bX1n7qLjm8+sc3v3ElIAeQd1AtzV6k56OfrgFcM2rL6F4OoOB9erYxbIEl
         PKtr61OJpnPuGIRbnmQnfsanxJiJfkI7IDqg/vyUc+1ZL35HOi5PRWeR4pS0XJd583qH
         myYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750805098; x=1751409898;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRXMbmGHv5qc0+GRIglNxAEcLatX5Y9+ZZFfOH/sgcc=;
        b=l67czRQbt2JUioXVAJC/8Ml7f0HS1OMnGds6w5ZCzCAc85sxvWzuOTurOCJsSkPyFq
         B2VY1lNdqkEBY5sqGDlwVfHERtp7x2lL0SDijs2wO3tq/wNUi3l/AmArPJPcoXa9KHhH
         gnuIun/J8LoYRuk3OInKxbcJ4bJ0A776KWVFp7VAMw0hdeyXGtTdbY3y0rZfPnQqHaX6
         F1jrnEpKrTvLtzqSYquSzYO2rFnIOqBbF0HNAyWxxExWNOOWJAUm7+uUxrr9OfVAUZf7
         FrOu8e5fhVjA2SfNAedQMOXtq0zRCKT1GpcmaJDzALRbX09Bx+ASptXNQiR7XbpWb94K
         yT/Q==
X-Gm-Message-State: AOJu0YytT21pZlkZg3cWk5zknkEW3XpV/MqXTXEWCtW2IIYxLSNG5gZs
	udnCz7of4HXQ3fQiQcTx7XkvrvksRu7/McuZlDNv0QQD5UemfYFdWkqBkYiWKB9UxHw=
X-Gm-Gg: ASbGncsNf9YC0cQaOVXqIvc2NQmfxUEe7pW5P1L400kwYX+uChdmX4Sdt1csOJa2EAf
	KLpVNAWupuZjgJce5cfKevDxyMJyvmhPnWhApgF7hzux4JWsofiaimjG8Qk4Wp3R7zM21iQEjk1
	73ffRwulhQy/wHKczLajdPu9CVRR70SJgkc8vzHlNhPcM7tHco7eNDCQNb0agzoqpOZ2HIuOK0v
	ymNgGgsT88v4lUOCUb/FVm1bUkJrNZDdI+yQquY1PIZQXunPKOUOAU2gRqJl5MqVrYGZJA8gu3C
	qdYcAvKtkPNnwXluV+hUT/4mvhdef2TJnjfOkK80PeMcPQpRIcge7yiT8+q9pq6o
X-Google-Smtp-Source: AGHT+IH7S88HndQYh/y+AH2dYPlp+bphbSdHifv9VXqm4+49L6EVcl77epJmUEAPqt5lk9I3IFqEcg==
X-Received: by 2002:a05:6602:378e:b0:86d:61:ce7e with SMTP id ca18e2360f4ac-8766b4212damr169849139f.0.1750805098487;
        Tue, 24 Jun 2025 15:44:58 -0700 (PDT)
Received: from [127.0.1.1] ([208.115.91.129])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-501c9248983sm1086444173.11.2025.06.24.15.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 15:44:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 24 Jun 2025 22:44:51 +0000
Subject: [PATCH] iio: adc: ad7380: remove unused oversampling_ratio getter
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-iio-adc-ad7380-remove-unused-oversampling_ratio-getter-v1-1-26cbee356860@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAGIqW2gC/x2NUQqDMBBEryL73YUYo5ZepUgJZk0XaiKbKAXx7
 l36MTAPHjMnFBKmAo/mBKGDC+ek0N4amN8+RUIOymCN7c1gHTJn9GHWjN3doNCaD8I97YUCapX
 i1+3DKb7EV3Uj1UqC1DvXdoMdFzKg45vQwt//8XO6rh/EybYUiAAAAA==
X-Change-ID: 20250624-iio-adc-ad7380-remove-unused-oversampling_ratio-getter-e54413627fe0
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Remove a call to ad7380_get_osr() in ad7380_init_offload_msg. The
returned value is never used.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
I wrote this a while back but it looks like it never got sent so here
it is now.
---
 drivers/iio/adc/ad7380.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index d96bd12dfea632b62475d6537c8d6601b042de1f..abcd4cc70074723303b9b67e2b89b0c4b43c6884 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1165,7 +1165,6 @@ static int ad7380_init_offload_msg(struct ad7380_state *st,
 	struct spi_transfer *xfer = &st->offload_xfer;
 	struct device *dev = &st->spi->dev;
 	const struct iio_scan_type *scan_type;
-	int oversampling_ratio;
 	int ret;
 
 	scan_type = iio_get_current_scan_type(indio_dev,
@@ -1195,10 +1194,6 @@ static int ad7380_init_offload_msg(struct ad7380_state *st,
 		}
 	}
 
-	ret = ad7380_get_osr(st, &oversampling_ratio);
-	if (ret)
-		return ret;
-
 	xfer->bits_per_word = scan_type->realbits;
 	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
 	xfer->len = AD7380_SPI_BYTES(scan_type) * st->chip_info->num_simult_channels;

---
base-commit: b57cb7c47e31244bef6612f271c5dc390f761e17
change-id: 20250624-iio-adc-ad7380-remove-unused-oversampling_ratio-getter-e54413627fe0

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


