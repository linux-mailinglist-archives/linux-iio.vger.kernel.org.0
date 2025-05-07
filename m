Return-Path: <linux-iio+bounces-19269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2892AAED44
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 22:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C286146325D
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D5628FFE8;
	Wed,  7 May 2025 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ybQv8gBW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6194C28FFC9
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650631; cv=none; b=LaIdv/uESJDeAqeOFbL6wCimXYeVe11zbquqv2MFuRa8xD7+UsJ2mqZobWI+SkTDPdc3CH2CjEUjil86JdfVlcwlAQtKI12YVsG63LNOODX0guFwUn6ofVTybtWwDT74LLM4PgFs/r5aFQHPodtgomT087Cgrca7OeDQWMYOTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650631; c=relaxed/simple;
	bh=qTxxm8SfPufoyQPrSsaW7TicDEaOrmpRvi6YmXZisJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eopWgv+NMdmnF2pjdmqgek7gU/m2gjM4Hld5TGY2RQIm7kMNS/+WJIMLOQfqagHr4KjUw2MP0xuWdL2ZIgeDXubbPZSRejRUG4GfrQZNG+snXZCVJk+4CONl37CvmCRbDov+wTTVKe5YWrQtEhRcA9l6WAzLv3CxfMLmK5X3QPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ybQv8gBW; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-604ad0347f5so90820eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746650628; x=1747255428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pd1rWEvK2H4HurtXzFWa/x9Szbu0oBY1TfY1+UU3AHc=;
        b=ybQv8gBWjSUNEdSDY7GyPVL59jR7GAG0qUOyrmNwgHCWam1Ajbe9M5YDQDMekrhOtA
         lKQ9do8IvjHYN3gdPqbOlYQtTq8jsSeulauSUUtzux9R5zaxUT4141jPnDytXs9L/3A/
         KoLObW42+uLJT3oUpBKPXw6b0VEtLD9JM2gfBYSmqYTZ5d6vhJWb2VW8qISV7c5AOCyi
         DdM6v2B+UrpWZpxIkw0hXwbPjJsVDiwFekDIZcuOB1Mnu/q4/FVRGzrKc6Ce04rMv9Ur
         MDHqV5hHdb0nsigYviTTukfrP4OjWjkgyirGOZaOhC7ImindJSMCWLf3r4eBxpYckA29
         ZwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650628; x=1747255428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pd1rWEvK2H4HurtXzFWa/x9Szbu0oBY1TfY1+UU3AHc=;
        b=oFvNbTjhlxs9BpxmCTmBj7cSKMU+r9PExrvR/i6PkToQoMvTE6F8nn/GtNJ1UjLzit
         HjY2IWL+LBEGr3eBVVyhJHCMvHIHLcwRCGTy9HA/+fR699oyDPTFdh2fI4ectMHmJKa0
         SgVdFI355GJJHToroJTe+nRadvRKtma+JAGl7T63JVIiI7IdL8w3Xdao9X97PVt/OlMn
         I9aaZ75pIWgXroqcW3/NdDTlJlkqo7MWAGglfJbuL6Ho25KthMheX4yBKE9ogyV3n5hF
         utpCZn9h43heBl4EtzmdCk8Usz5KaHQMOfUV2rIquevi29RSeOKkYVEPFqPzn/Q18gNw
         +i/g==
X-Gm-Message-State: AOJu0YxFKzGkft+Y106Ae94QcI82WJHAFIPEpbusSCwVEd86NXXQVFF1
	lTCd7j+yt0Un0Y5XmkoUYSjgppgC2HGmBNb/169zfbU9LYkevpUn9GwNDj2LjeA=
X-Gm-Gg: ASbGncs4ASqEbDR43JudYV3OFgUVTe7GrRBPS9vMkUh4fiQt0jh9z2w/pRLwhD6ycLN
	FyZmNfZKwYDVt3hXP/fv5S1Aynbq8Tqsx1GUhnvSb+R4PQN4Bto5pHk8al2ytzUGkZJGS0szWlH
	ZdDHCxrdDotZLSlJyL2Gyw5ppNybl6MwoMg0pOxQDCaszNCdMS6AaXyGvNaY3MPsgkzQI8SfO+C
	KeFWagZMVTcYYAVrvu6qOvw7naYd3kiXvgoYxjE03PFLiu3a2x7/AQMIpV1Gib75vk/n0r+EjJo
	TlUQGdQnU+fquNIsLvu1DzzOqMACVblZuLBDo004Oc4Qxw==
X-Google-Smtp-Source: AGHT+IFG69yhKzeAewFZifPcUv9VhJ1g9tWX1TCPK3VZrLJYfK0PymFFMWYMU/UQ1P6qhCb/J4P36g==
X-Received: by 2002:a05:6870:898b:b0:2b7:7abf:df6b with SMTP id 586e51a60fabf-2db5c0800cemr3373849fac.26.1746650628324;
        Wed, 07 May 2025 13:43:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3356:f6f6:bf76:a32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2db5cd716d3sm898642fac.21.2025.05.07.13.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 May 2025 15:42:44 -0500
Subject: [PATCH v6 5/7] iio: adc: ad7380: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-5-4aee1b9f1b89@baylibre.com>
References: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
In-Reply-To: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=qTxxm8SfPufoyQPrSsaW7TicDEaOrmpRvi6YmXZisJ0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoG8XlBguqCmqtDIVqJDkB9dfLXj5+9lqxiP29V
 msICqsmsqaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBvF5QAKCRDCzCAB/wGP
 wPyNB/4w+gWujWX4jrqO+DhhHJDthKJLkpfmKOfGt826Ejvq9ojUsmr0EKTXXTuQoDDSteDB83j
 232ECMEEZ1/KxZMYGwRwHiM7Ql44o7XJVgtVi4/DjdGE9ifE1ahwNlEGqa47IszLrZdnK2RpumW
 1TuYPeS83q/0utvHbfyguuS0I/5Y22fc2zz05e3brqnNH0DdRYqEafq5YI/1W+xHeUgqLJeBrYi
 gpkXbPspkbP10Fa7K0EccZnti/onu6l8ieO2a8V5z3Kia7EVPO4B9snycru05rcE4psJ0OZcwJY
 AavywEoibXqRuD1VIRuAezcdL4J+GPfOlgNCxhb2k8DLea7R
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer that gets
used with iio_push_to_buffers_with_ts(). This makes the code a bit
easier to read and understand.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

As discussed in v1, this one stays u8 because it is used with both 16
and 32-bit word sizes.

v3 changes:
* Use IIO_DECLARE_DMA_BUFFER_WITH_TS() and drop __align()

v2 changes:
* None (but I messed up and there was supposed to be a change).
---
 drivers/iio/adc/ad7380.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index f93e6c67766aa89b18c1a7dec02ae8912f65261c..ed5e43c8c84cfcc9c4ce1866659a05787c1d6f5e 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -909,8 +909,7 @@ struct ad7380_state {
 	 * Make the buffer large enough for MAX_NUM_CHANNELS 32-bit samples and
 	 * one 64-bit aligned 64-bit timestamp.
 	 */
-	u8 scan_data[ALIGN(MAX_NUM_CHANNELS * sizeof(u32), sizeof(s64))
-			   + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(u8, scan_data, MAX_NUM_CHANNELS * sizeof(u32));
 	/* buffers for reading/writing registers */
 	u16 tx;
 	u16 rx;

-- 
2.43.0


