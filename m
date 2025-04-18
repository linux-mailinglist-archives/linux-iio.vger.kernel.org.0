Return-Path: <linux-iio+bounces-18315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049EA94018
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 00:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3FA1B66EE5
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E049254865;
	Fri, 18 Apr 2025 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O5NQWVHM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561BF253B66
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 22:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745017161; cv=none; b=VHST/WuDqwsEtgpcUoq1d3/RzNIfeaJrQKgR3M4vROzR2qvUsKfq2dj/ah130gYF1oOkEOMQ4PbM+8sKL+kOsJyK5lGcCmlliIFiEQgtEnpO7/OM9/oiCbS5x4jZxfdJ648rRX/sFklauuU71AMrwdA2kMF0S2t0KQnZy1sJikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745017161; c=relaxed/simple;
	bh=AhweVhEH25d8wvLOV8U3tgjVpTfYu6HqQRzrCrL17tE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hl3dtVZ5Hp8vZwCGtfAtA9BlDlkTzbU443qoJV7Rc803M76yXuOs9u+0G/i3WEwGx1CI5xdki90nxPnyK9AzoZD4QmI/mE1vkL35CNDmJFNeCpHT+RVLgQ/qjLklag+nY7xqLtv2zGb3JDJcbFDpNXQZiWB8B92nKJGWrN61y0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O5NQWVHM; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6021e3daeabso1040275eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 15:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745017157; x=1745621957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qcd8b+sFJozfLFSGqyv9tVesse4R4meJLMxQxoDs5cY=;
        b=O5NQWVHMQB3pz0Hxer+nJY2ILrk4n7S9Nrd+2Lntx/1EG0BRuIeFcuCmygnie05r9z
         RIsKgCyizuscR5q9h3UWNxT/citM4rvNzVrY4kLwMA97s/OY85aNIXnipu3xlLf3SWmg
         9sAP7ZkynEaptmX7hZy75vBWhS+IfvRzehSMzRO1i+DYb+DjCp5KdB3NFKWj1N5t2lAx
         btxMX3UvzH/ILh/U9xI9ZV+F7yyefdD29zJAAtot8XJhCDIAu993ZqTiphgsDa5iU9pO
         Lwv3v4dIGs5JjvHkO9s5J4TlIPg8LH4SuHe9gzoNhFd+4HoHU6TTHNx0P5C6MBCsiKDV
         s8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745017157; x=1745621957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qcd8b+sFJozfLFSGqyv9tVesse4R4meJLMxQxoDs5cY=;
        b=TZY6fzZdPraH7zySunGaFn1no+pKrZu3jmbZe1AUY/Bm2kW+vrvAg/7slScyvdIDKZ
         TAEQ7SzVWLrtM6VUlGDjuR9tmy/GYh7iD6sgvSNDgNdEfdBV+V1an3HhoieLftnHUyby
         iSJQldEznRzExModHARiGOfOmWWeVT90tXy28XYCyrBkiBewqoNPx18c8mMSgmrJtNXG
         ARyw4crYyy/UjyXXCM4mpXmP4LifwQtt68sMlsoaUjK+WrSvFwnlWKE6OBXgAoEc92vG
         IVL8NIQZN1qlV0NHl4CNSCFUAId98CPFpNQEoYAg1QUBou9ZkhLF4kSOGDXhIojIPy/d
         rS9w==
X-Gm-Message-State: AOJu0Yw2EQV7g9GolP0pQj9ygeVZgDsL2kZ39WA3k1IM/EdQFjKSPXqK
	MUYaWUkHkzOaAYgDzzt3+/DTqkMhgP6Bo1k0PuyieupxGDV9zy1+piZn9v2RC4c=
X-Gm-Gg: ASbGncszMsdu6Zl9m1x6+Wi9t2b0LRykcTTQ6L81QUwj2YA2hQJSPPGtBr5giLIgKuk
	7C7cL16QdvT6GbEyHum3UAiXLXBJvYc2AP8qaHxkaGX8GtixIAN3eWps07wnf3LPkLcbRKJeRnN
	zOdZxlEl7Q4pqHb6Lfsa0EnrPlcCTd7k0MXG5pfYhf01v1Ky20Mj+qYvtx2/peV5tDdW3nCwusM
	rtSzimK0WZiRkR9v0HngQQW3QQ2x0ZvDZm02GIzTJLe39fvh1oRjchfCt3GKuYY5zqQdlksS/yc
	ECKvBQ6/mwIBUl0Xt++x2plHlRoYfcRylpd2/rkbccjhR0A=
X-Google-Smtp-Source: AGHT+IEqI7qvS/d0QPEDtMVFvFJPfknYM8BmtKsJXX8Dihq16YiQi+FdZpmjzCPfTelnznsjB0NpXw==
X-Received: by 2002:a05:6870:830e:b0:2d5:296d:4ed4 with SMTP id 586e51a60fabf-2d5296d5a3bmr2074062fac.28.1745017157331;
        Fri, 18 Apr 2025 15:59:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730047ca051sm500187a34.36.2025.04.18.15.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 15:59:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 17:58:33 -0500
Subject: [PATCH 2/4] iio: adc: ad4695: use IIO_DECLARE_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-2-ee0c62a33a0f@baylibre.com>
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
In-Reply-To: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=AhweVhEH25d8wvLOV8U3tgjVpTfYu6HqQRzrCrL17tE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAtkwbaokaUxwrPZaLomgNtqgyv4GS7ATOqORj
 0P+ER/gwqaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaALZMAAKCRDCzCAB/wGP
 wFEaB/9kNMjrqZsGk4OBPqABJHXa9sFYcNgxYZ2NRZNHahhqWZTGvAnhd3VEGXSd7fSGIRIQhga
 7AXUpuemh2Vi4EfeFeqwsQpLK6tkDk/9WiU0SbUqU9T6gaZb+bRvy7ws/QEduYEBZUR6peuPa07
 xs8tFTOXjWlNhf2SgeVO1YGSZmuJL+TepRK4TzmqKuH5Nzy7Z8xBHFW+T5HdV3m8lP/UbuWj/kp
 6iMmxNtFOY4pCueCqHyGHG7YEL29rH+VbNfN3AZkFRyzxGFV1f7yIBwgNh8zg36Zer++S7xuzV5
 ALMD9JKMw5wg4pzqXjpKFe+DQtHhh6H7vs3esTIAbsDaVsNr
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
and understand.

AD4695_MAX_CHANNEL_SIZE macro is dropped since it was making the line
too long and didn't add that much value.

AD4695_MAX_CHANNELS + 2 is changed to AD4695_MAX_CHANNELS + 1 because
previously we were overallocating. AD4695_MAX_CHANNELS is the number of
of voltage channels and + 1 is for the temperature channel.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 68c6625db0d75f4cade7cb029e94191118dbcaa0..9862ff99642b61db42b16b797ae046efd99c2811 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -106,8 +106,6 @@
 
 /* Max number of voltage input channels. */
 #define AD4695_MAX_CHANNELS		16
-/* Max size of 1 raw sample in bytes. */
-#define AD4695_MAX_CHANNEL_SIZE		2
 
 enum ad4695_in_pair {
 	AD4695_IN_PAIR_REFGND,
@@ -162,8 +160,8 @@ struct ad4695_state {
 	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
 	struct spi_message buf_read_msg;
 	/* Raw conversion data received. */
-	u8 buf[ALIGN((AD4695_MAX_CHANNELS + 2) * AD4695_MAX_CHANNEL_SIZE,
-		     sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	IIO_DECLARE_BUFFER_WITH_TS(u8, buf, (AD4695_MAX_CHANNELS + 1) * 2)
+		__aligned(IIO_DMA_MINALIGN);
 	u16 raw_data;
 	/* Commands to send for single conversion. */
 	u16 cnv_cmd;

-- 
2.43.0


