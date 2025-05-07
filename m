Return-Path: <linux-iio+bounces-19268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BC5AAED39
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 22:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939831B6593F
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523AC28F946;
	Wed,  7 May 2025 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Uv1zLvDn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893BF28FAA9
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650628; cv=none; b=pUjZ/OPxdXuMCJM3J0O8lWyocV7EKg4RmMiLlTmlEcIU1No2pQRgMBT7+zndsL6onJuR5RVzezfBO+P6m+tlaCo1x7psL7Eq1YQDPZtIaZd8qEHXMno4aNzCFt/49VtEs7K9/+v4c7HSolVMvj8Bfl6wqsYnBxE8Cz+UIXeS7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650628; c=relaxed/simple;
	bh=dYl7QDWnMJdjHkS6Trycc+ojlEKZD6od1/EKbXvOHQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpdWorh08BX/CntIKpf3BwPzXvHwFMb6pRTdOwdLt9BcMVMnfmqFcYGmJx/gTdr1Hivg5raBISpu4aJWoGhy3yy9UqVwhICxM7F2HFnxlmPp+h6ojeTUJAUsXoQr5fu0X+HfMDpJDwgETO7IWLglS+YKhhFq+2i7Bp9T+5C3+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Uv1zLvDn; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c76a1b574cso168395fac.2
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746650625; x=1747255425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M71PJ7VtKfkJnKGztH25+j4j9U1WKWdC9Y0jHLrJYIc=;
        b=Uv1zLvDn5puRDAdxU9uilZqS59K7g9upToVs4T7RNCqXMM6ufHwYek+ct317youaO3
         z6l22645P5mcTKLLR1J5e3/kEzHkPZDvSmVr1Umrl13d4ryEJMqV37QbnqXCZ1EQ4ZeR
         dHfvkSKfBMDZoqmEEVj9LKyixAnk0YUQs3dqPPBqKH5lRPUOhZdBKAHG4WpJ2dCODKJW
         lPhab4jxEtFpUYGPp4AVrQAD5KezLO2UnJ2GPCFrgcJSVQKr6LQrsrTRZLNISUjdNbnS
         memVRKBeSKx8iNvnx23iOFNI+QjGuUjdNv3W0P8a0NclA9gUX2O0p/02brp+U0FH3GTl
         eVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650625; x=1747255425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M71PJ7VtKfkJnKGztH25+j4j9U1WKWdC9Y0jHLrJYIc=;
        b=tXaO5APyXUKRq3Jj/2X8qRLkhl8hJlgWdbdyn82xspvGERBAi+hfNI3KHbss8mjL/+
         eY9wa8DioQOJhOrSXH6455UL47y6bbynKhswCnkwCxAN1Qnyy6sHAJo+VguTK2mKPqq+
         mhLG9y8b7lDvBJNF51AJXqpxmskIyAJeuvr7nm6kcq+YyJG0ZUhoWNfuGB1S/GgMKD1m
         hqELoY7RgKcCDW8z8lzlQrBqgZo/vCsnFNWLxZsg3Hk6dfrr5vjsigUXppB6PV7dst9H
         fBKYJIGx6EEYVKTnyfzIbF7TbT1Ao05nx4bNMReedxin+4iwZbdPwHrugsUIeoIgPhXJ
         fFew==
X-Gm-Message-State: AOJu0Yxnyi/sWwHiiKEtRzy/eDKV7aMRkMGSj+1vJL6F6rMvPf2Nt/fH
	kk93qR5w9XGi+7vx1lX6pbdfKEL+R57zG+AVgbxbZwVZzA9N+MapeP7LRc44pa0=
X-Gm-Gg: ASbGncueRT6vM0eaLVZvkAs53hbFM3JAjMb+IW04mL6e0NR5I+HCD7SZNZXMMIZVRNy
	ZG0Wf/vlEXfLiWqcxhEKqq0CYZ7kgR2N4NLCEWNgt/C1UJfoOCv8lJGUQTU3B9SFa9idqYaFXbf
	ATVigVNiKocKVWcbaR/opjiye38KMqm6dSNZkrLLEdGCnwzquJ9DAO10QSsrTh6g8H9ZI0AvAvL
	3X45/gnzk8hSD1RGymNZNk9cOIuRHn6e8orl3x1VBBcGUUXGW57QGYnC0bPS8cmLkgWtIDKBDeq
	FvLUoA8bjiS/nLmQFogK0+dRF2Kb2z6WDqFmkq1vspWkFA==
X-Google-Smtp-Source: AGHT+IGS5PMAI+KEXQKldp5GePhVTN6wjk/dkrFbe+bPctRj3wkBCKD/uHIlHK8DVJazvFjRCYZKIg==
X-Received: by 2002:a05:6870:5246:b0:297:2376:9b17 with SMTP id 586e51a60fabf-2db5beb9803mr2860430fac.19.1746650625566;
        Wed, 07 May 2025 13:43:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3356:f6f6:bf76:a32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2db5cd716d3sm898642fac.21.2025.05.07.13.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 May 2025 15:42:43 -0500
Subject: [PATCH v6 4/7] iio: adc: ad4695: rename AD4695_MAX_VIN_CHANNELS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-4-4aee1b9f1b89@baylibre.com>
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
 linux-arm-kernel@lists.infradead.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2047; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=dYl7QDWnMJdjHkS6Trycc+ojlEKZD6od1/EKbXvOHQU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoG8XfmG4GSRwHhO4k5Xnu6UTAM2KXs49zHopNQ
 MTp8SUZxyyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBvF3wAKCRDCzCAB/wGP
 wNJcB/0U6S29hjeNRGS09dG5ez/9bJJ40VCUhk8q3UOeKsPlTU/w1YytSw5Bw0w3EuHvaAAVdY/
 gUggcI4EcAp4Vt/4nxknyAoo202s77qiFZwB2q6rwdgpR3YwlJ3fidz/Dl6QFKRvPJZeJgnIIx4
 ilCsxvPKWwarTrp6o+clsBtp2xGc+IdrNGVTYL3N1SvtGiFALJjgEisiBnbDLn0s+2IWrLUs7ps
 DAD8ETakvbGbS7FOWb62oo2+13gwy3dBGAxQ2T/MRIXitJtS8HCowyXnab/3q3eri21ahmZxOiw
 fDjLxjf/0RkLfl+iCqiN4eiAQgVsfvQYX1RXPnIg+fhZErPr
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Rename AD4695_MAX_CHANNELS to AD4695_MAX_VIN_CHANNELS. It has been a
point of confusion that this macro is only the voltage input channels
and not all channels.

Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 992abf6c63b51dee222caf624e172455fb9b9900..cda419638d9a88debb3501d05a513b17a4ecde95 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -105,7 +105,7 @@
 #define AD4695_REG_ACCESS_SCLK_HZ	(10 * MEGA)
 
 /* Max number of voltage input channels. */
-#define AD4695_MAX_CHANNELS		16
+#define AD4695_MAX_VIN_CHANNELS		16
 
 enum ad4695_in_pair {
 	AD4695_IN_PAIR_REFGND,
@@ -143,8 +143,8 @@ struct ad4695_state {
 	/* offload also requires separate gpio to manually control CNV */
 	struct gpio_desc *cnv_gpio;
 	/* voltages channels plus temperature and timestamp */
-	struct iio_chan_spec iio_chan[AD4695_MAX_CHANNELS + 2];
-	struct ad4695_channel_config channels_cfg[AD4695_MAX_CHANNELS];
+	struct iio_chan_spec iio_chan[AD4695_MAX_VIN_CHANNELS + 2];
+	struct ad4695_channel_config channels_cfg[AD4695_MAX_VIN_CHANNELS];
 	const struct ad4695_chip_info *chip_info;
 	int sample_freq_range[3];
 	/* Reference voltage. */
@@ -157,10 +157,10 @@ struct ad4695_state {
 	 * to control CS and add a delay between the last SCLK and next
 	 * CNV rising edges.
 	 */
-	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
+	struct spi_transfer buf_read_xfer[AD4695_MAX_VIN_CHANNELS * 2 + 3];
 	struct spi_message buf_read_msg;
 	/* Raw conversion data received. */
-	IIO_DECLARE_DMA_BUFFER_WITH_TS(u16, buf, AD4695_MAX_CHANNELS + 1);
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(u16, buf, AD4695_MAX_VIN_CHANNELS + 1);
 	u16 raw_data;
 	/* Commands to send for single conversion. */
 	u16 cnv_cmd;

-- 
2.43.0


