Return-Path: <linux-iio+bounces-19127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D5AA9926
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF1B5A1F04
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBC5267727;
	Mon,  5 May 2025 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="loPvF6DD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B926B96A
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462770; cv=none; b=AN+PG62KdLFzPJ4XQTaf2ans8QLmiEMRwuzAjvB+s1JypeOeDWSVLzQhyav1vNNnxfRRwiyIVvLlIQwa5NBMFN+yPQpr+kxXim7ixMJhdpITBtRK+4JINskuzJWRlMTfbpBwmyxqz3UjUKrYVu/tCHj/EIqkSCcSm7d9nhEvD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462770; c=relaxed/simple;
	bh=htzNMPXlRVfXDBCUzoC72qPIY7Dbustt/aeF0u587HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fwaTc2S0VbhsuO5LOlJcPy5UZUq7L94KZ21TSZEia1CDRxsxERD2FVmQUGCLGUttnZhgsZSgJcl/+TNJNzP0I25I2AMIi/2qsq2drpq2Mu2WR3oqoARlqrZA8jmOGnwRpBPrMI1vSigGNsw8G8YzjMx7N4ijBjdQA5GCcQRGm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=loPvF6DD; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4033c70577fso2225219b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746462768; x=1747067568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ml14j4CWVwjgejgx5bGL2isKAmgSSnndW82GfrPbAUk=;
        b=loPvF6DDnO9/xm/Q1A+M3DX79qMT7SZrDWxkQguhqTbioBifu3vAgzMMz7vXeeGVEr
         PC9qroyVKvabae5DjaCXDJCpxXYC9rxHDBbqX7RfgHIyNDM55p76rlRuzklBi4gfCAyN
         lvgVKaTsActX24OrunZdZ6OrA3utKJvvx9SAvR+nGWZQY93oLnnFQObjWytfeNZcF9BA
         I/RfnIOYvmheABYCD4Ox06udCpVbv//zjSYQ/vZAs4+Cehrh/tCt0q1Mn3J6OnUMGr1x
         H7Wl08ouwJ6tkLC9lP3WUFhN4ih3UyyJD2pKWyw8C235Kn0YCgZWQECpkna2+NkhSLyF
         j2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462768; x=1747067568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml14j4CWVwjgejgx5bGL2isKAmgSSnndW82GfrPbAUk=;
        b=MyGvjkNdb9T2z8wR5wnvOIRoaRFnMwy3Y5Qf2jRowuRA9QVMn7MQshIsMdc919y6/u
         WGehZ3CC4pjUcrFr4wAnI18UTpBoKVU3gBBAMkfYajoN8PLW7oSZcfpoykiG3CHBTuxB
         uHxqFp6rZhwj4EGoqFQQ6lEFIDIIpYscR5h5q1woqA8PMOiaiR+WWeA/ywgEw1YzKhZY
         +jnEk5YWva9nSlh9GLhTWDQPXaizdMjiirsEYdwjXQNLlIki54GMVtKjn/MNMk3DfaBn
         yX9N4Ovwx66o7YBtVV71vasFZZlWsl1+bip7/ispKnc1kdZQ/wd2ZrdXjRRFQdNgDe9n
         Ot6w==
X-Gm-Message-State: AOJu0YwkppeWFW9f/hxnqnhMXj+SbyUNikapVn1BDg7Cw+Ghq+EpEhtG
	kPIZq06Jjd+vpkAAO8RLxMmcbkNrGYmxRRQDMhx620nyoQYOKfm8xgSo7Yhitjw=
X-Gm-Gg: ASbGncv7htVNWc8KcGF78DsP2EYnBwiSChw+O/WuaKEJ8MMCB57c2sOxijrHM21HuI5
	8d8+U/4mCEudQtCBhzfgPE26as90p+sQ61GLRK8dNVMZS8VdgjKGQ9wyPbv8+063dbGyTpAJfDl
	GdzC4Qw9ce2pRpAf0yk2KMicSLe+iGQ92GbV6/x93IUXufUKY/kkZatLHLPBnKu24NS5cG3GVsq
	2OiMPKWCmXoWqn18mpWejBePAedQlwOFOchvpBPibYmmzA/KdbOU+LEoR4k6DSUnfHVa3v1Vhj2
	72bTELUxIsL834XExrin2l+hslRDJKkAkvWfYZ+nCgX+IQ==
X-Google-Smtp-Source: AGHT+IFqKHGasE/q3CxHFccgze4kDl9/B+uNOjperFB7eOc3YOSJklsXFoHknccNnTyE5kIJNN+cEw==
X-Received: by 2002:a05:6808:f10:b0:401:e721:8b5f with SMTP id 5614622812f47-4035a548133mr4310632b6e.2.1746462767858;
        Mon, 05 May 2025 09:32:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dae68f7sm1971854b6e.26.2025.05.05.09.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:32:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 11:31:47 -0500
Subject: [PATCH v5 6/7] iio: accel: sca3300: use IIO_DECLARE_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-6-814b72b1cae3@baylibre.com>
References: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
In-Reply-To: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2980; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=htzNMPXlRVfXDBCUzoC72qPIY7Dbustt/aeF0u587HA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGOgaCStXP11tomR1UVCYdZrN8uLnoILCaVV4Z
 BeCxDvcs2WJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBjoGgAKCRDCzCAB/wGP
 wBf0CACDz7JX5f7i4xgLS2PbJoMxYM+RRs6unBD67Ezb/eqc2RApwNtQ3dsCjG6QkO6AuH25Cfu
 X1K9VzIkl5hWdyKAVX6JBT9mO4sFv+yMplB4ZxzxIUzF3Yv+VR4OsgjtSbxNUF5CFLLNFSnLKrV
 tqe5q9Op5uDxpH7GR74XoJBGLtIK1qqCXQAPxF5rAzm9JPVIgCvRjttmLxM1MuDUtBpT5/JyoSH
 Vs1mZwrLz5T86vOHRXArdldRfbFG+NDH9qCmtQzPErbVO/R7q+iccd4AC7Rm33SVGdQ/PILqux3
 y0FbJEDW7xYXrJV9pscAhM/3jHQmtYdNtMt19Fr94L88A3Vg
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS() to declare the buffer that gets used
with iio_push_to_buffers_with_ts(). This makes the code a bit easier to
read and understand.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is an alternative to [1]. Also, this serves as a test to see if we
can get a rule of thumb to decide how much is too much to put on the
stack vs. needing to put the buffer in a static struct. SCA3300_SCAN_MAX
is 7, so this add a bit over 64 bytes to the stack, make the stack now
roughly double what it was before.

[1]: https://lore.kernel.org/linux-iio/20250418-iio-prefer-aligned_s64-timestamp-v1-1-4c6080710516@baylibre.com/
---
 drivers/iio/accel/sca3300.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 1132bbaba75bcca525fac2f3e19f63546380fd4f..67416a406e2f43e4e417210410904d44c93111d2 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -58,15 +58,6 @@ enum sca3300_scan_indexes {
 	SCA3300_SCAN_MAX
 };
 
-/*
- * Buffer size max case:
- * Three accel channels, two bytes per channel.
- * Temperature channel, two bytes.
- * Three incli channels, two bytes per channel.
- * Timestamp channel, eight bytes.
- */
-#define SCA3300_MAX_BUFFER_SIZE (ALIGN(sizeof(s16) * SCA3300_SCAN_MAX, sizeof(s64)) + sizeof(s64))
-
 #define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -193,9 +184,6 @@ struct sca3300_chip_info {
  * @spi: SPI device structure
  * @lock: Data buffer lock
  * @chip: Sensor chip specific information
- * @buffer: Triggered buffer:
- *          -SCA3300: 4 channel 16-bit data + 64-bit timestamp
- *          -SCL3300: 7 channel 16-bit data + 64-bit timestamp
  * @txbuf: Transmit buffer
  * @rxbuf: Receive buffer
  */
@@ -203,7 +191,6 @@ struct sca3300_data {
 	struct spi_device *spi;
 	struct mutex lock;
 	const struct sca3300_chip_info *chip;
-	u8 buffer[SCA3300_MAX_BUFFER_SIZE] __aligned(sizeof(s64));
 	u8 txbuf[4] __aligned(IIO_DMA_MINALIGN);
 	u8 rxbuf[4];
 };
@@ -492,7 +479,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct sca3300_data *data = iio_priv(indio_dev);
 	int bit, ret, val, i = 0;
-	s16 *channels = (s16 *)data->buffer;
+	IIO_DECLARE_BUFFER_WITH_TS(s16, channels, SCA3300_SCAN_MAX);
 
 	iio_for_each_active_channel(indio_dev, bit) {
 		ret = sca3300_read_reg(data, indio_dev->channels[bit].address, &val);
@@ -505,8 +492,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
 		channels[i++] = val;
 	}
 
-	iio_push_to_buffers_with_ts(indio_dev, data->buffer,
-				    sizeof(data->buffer),
+	iio_push_to_buffers_with_ts(indio_dev, channels, sizeof(channels),
 				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0


