Return-Path: <linux-iio+bounces-2498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64B3852285
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 00:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D905281A89
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C091524AA;
	Mon, 12 Feb 2024 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a3/WL/Aq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C1D50A7C
	for <linux-iio@vger.kernel.org>; Mon, 12 Feb 2024 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780481; cv=none; b=cQfh7tMU72JCqQGZ06A3tkOZfKo1+fyqELAAPXb/wdJtlxo2cJBm61dNC3lFMas8+guL6xAiMorLlEuZb8by/8jOjEa3ybHwDC4kuWmCU10ghJxYZGJgvE8iL0N0ayC9qCd6KuVklBXozg/cwVTZI6phDuavdaBU/ahOWb3EhBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780481; c=relaxed/simple;
	bh=TolsSfnf5ZNv9qUX//b4LDHC0qhXpGT9ROt+eluCm0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPNA0wbi6Ib97GXEE4zrvvaZqNFkDZ3RsMtPtUWAwIm/yvZ9R+epr8DfmwHYldDEVnXjVWqDVMMvegS4MxcQpEnbHm7Rm+o3rZD/jr5axw2d+Hh8EtJaUWGdJG/Wkm8oM3sQcOLKXFuojoG13VwTPy6gt4FqX1Egn3OyS/E0t/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a3/WL/Aq; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2185d368211so2465754fac.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Feb 2024 15:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707780478; x=1708385278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPDb6hVtEhiljZHBpIuJ6/eQfkiQhhMGNrzlPsHzoEA=;
        b=a3/WL/AqH2ZWQLcLhsxTE0qiy6qY5KqxBIoUJg6PzfSP1C6ZGXcfOSIIoHH5kGnrb/
         4KR71zKRU3q3IkXaoZl7Q/iGoDbVGj1C5fE9paCxenVvRZ4Et0kjxCMyvpmy8YlUlp2M
         z+P5+1GzBEG/TV5oqSnkcL/HXoVTlvelmeitYxK/ZJfpN88bgbaSq2SJwyXkdJd/zvzw
         8do58f56Y9dQto6zWftnPN0J7HRjrHlTOgggEcFISaAyckbV6ZK0xQHllRwS8Ww5v0hx
         KLFen3sgREBW1yeD069FfHIyekDaj+gnHnPwjQoVQN+DHzNzuTllfoe583/pTAwnZ99Z
         3Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707780478; x=1708385278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPDb6hVtEhiljZHBpIuJ6/eQfkiQhhMGNrzlPsHzoEA=;
        b=ZqZ0dmYG6RSFrupmY3kSsG3AD323pieCYwj4tku3IgtpA5s0cQUvOghSTFp9SDhVAE
         XIqE7DFKmSzVeFR+oYcwd4yktH4b489xWe0h2qEWU2QybPqvYyc41Zjt86Y/PRizKpV3
         Zoi/YMtZCWUg7ZS3cX0mtNhneN0Dti4R5jK6ASBKlBMj1xxyQIGBetTRAmllkfBo1fO4
         17GayLGp7amSotikOMzX7ZNzc5pWfaGi3fqZWsXgvZswaiTGEzH01wmah6luk0gjcBKN
         6Kh28q85Ln0gpsvqoMN0Py89YBNUiAR/XuzQXgXpmewGp+MXnkFffE7LtYIXfBwDEsc7
         dgoA==
X-Forwarded-Encrypted: i=1; AJvYcCU8jBKysBTR6sdV7DZXn/Kxb4PVT6bmOxxYAmMxywZKcq2s5KoR8lXqm2U+IC/AlhL2oIU9UUgJ8nqk479ihA8AUDXukNWCWrzS
X-Gm-Message-State: AOJu0YxFnKlNUUGw0fUqIDTEv7KYquaCZQVlLYj9bk6hJ8pwSqwm9yK7
	Mv80CRQctOKqkRws+JDMRuUOL6Y3r5jg3ijU++M4VP/RttcRbc0t7Y4vvlpnPg2GdKFp8lwLhFa
	Q
X-Google-Smtp-Source: AGHT+IH9erOJCDaYbmQDWF2K81JN0GKgiq54irJeN5yLR/tg4FUJhNIMhrIkifdGOu4oAL5TJZcC0Q==
X-Received: by 2002:a05:6871:5c48:b0:219:c8ea:ecfd with SMTP id os8-20020a0568715c4800b00219c8eaecfdmr10850888oac.15.1707780478627;
        Mon, 12 Feb 2024 15:27:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/sChhyo7/S+ePAw+fUTZa4Fa+c+iizdHVFXCth9k0UVOZs5C2WlgRtbyufn7EOEddQq5CkoNbtZtOlCdXpnzPXFGf760G/g1P4jT3D2BZM851R0PtrDuAkl06AR06eLUGEITPtV1UK0F65cIlm7ccxGgZLoQPiwMwsyuL5+SNLnL+D8pJj8ktyPxbGY2KEjPfVcWo3aru0369a6RMQJWdab/0ibpad8aRXTQjKE2CY2ZgZKHfkTlJl+JJ28mwL2pNejLLTSSa4B9k3zuc4nDciUgdcuwoMeHfxozDYXDiKfMYPfC3BEJVdK3sFLpvz5Z2Y6K087Zk6+hLDN3ceLH0IZuGlif8dpiVSs2aw4qqhk80aOpu703oSYX2fa2Zy04rdtzhykVvL9yVQLic9YrrrC+2SmVp0ygbRulhgWff+wuEJGaDvt46o+YtUGYq2F+yoofZRk2mrtpYLyyJ/fhAMTQctHXdcSryftOnYMqxIPwVdTitM4q3WhWgmLLWBe+3CCel/7DU5WydgyihQ23lXKvMWqg=
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id pk17-20020a0568704c1100b0021a7a45e0b1sm330141oab.35.2024.02.12.15.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:27:58 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 5/5] iio: adc: ad7380: use spi_optimize_message()
Date: Mon, 12 Feb 2024 17:26:45 -0600
Message-ID: <20240212-mainline-spi-precook-message-v1-5-a2373cd72d36@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This modifies the ad7380 ADC driver to use spi_optimize_message() to
optimize the SPI message for the buffered read operation. Since buffered
reads reuse the same SPI message for each read, this can improve
performance by reducing the overhead of setting up some parts the SPI
message in each spi_sync() call.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 52 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index abd746aef868..5c5d2642a474 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -133,6 +133,7 @@ struct ad7380_state {
 	struct spi_device *spi;
 	struct regulator *vref;
 	struct regmap *regmap;
+	struct spi_message *msg;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -231,19 +232,55 @@ static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 	return ret;
 }
 
+static int ad7380_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	struct spi_transfer *xfer;
+	int ret;
+
+	st->msg = spi_message_alloc(1, GFP_KERNEL);
+	if (!st->msg)
+		return -ENOMEM;
+
+	xfer = list_first_entry(&st->msg->transfers, struct spi_transfer,
+				transfer_list);
+
+	xfer->bits_per_word = st->chip_info->channels[0].scan_type.realbits;
+	xfer->len = 4;
+	xfer->rx_buf = st->scan_data.raw;
+
+	ret = spi_optimize_message(st->spi, st->msg);
+	if (ret) {
+		spi_message_free(st->msg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ad7380_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+
+	spi_unoptimize_message(st->msg);
+	spi_message_free(st->msg);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad7380_buffer_setup_ops = {
+	.preenable = ad7380_buffer_preenable,
+	.postdisable = ad7380_buffer_postdisable,
+};
+
 static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7380_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfer = {
-		.bits_per_word = st->chip_info->channels[0].scan_type.realbits,
-		.len = 4,
-		.rx_buf = st->scan_data.raw,
-	};
 	int ret;
 
-	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	ret = spi_sync(st->spi, st->msg);
 	if (ret)
 		goto out;
 
@@ -420,7 +457,8 @@ static int ad7380_probe(struct spi_device *spi)
 
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 					      iio_pollfunc_store_time,
-					      ad7380_trigger_handler, NULL);
+					      ad7380_trigger_handler,
+					      &ad7380_buffer_setup_ops);
 	if (ret)
 		return ret;
 

-- 
2.43.0


