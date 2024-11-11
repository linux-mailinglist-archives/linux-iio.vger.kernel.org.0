Return-Path: <linux-iio+bounces-12135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297189C4242
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 16:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0E2282D19
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47E11A08DF;
	Mon, 11 Nov 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1JXKbmer"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D719D093
	for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340788; cv=none; b=neweLDBJ8DiKfkgm3p/9WlReXxrK6c9g4mHIGcJ0e7KTO0W1kd7MySY3pwBwrEHb29iYrJ2dRlNKlGYzCfpBW9h9nxxYi5vwk59GiPfNO/GonjaTRs9l/eFONr9085DptHZa0yc1dbWxmsiSN6n5zcvae6pHcMEotDRN4lhY+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340788; c=relaxed/simple;
	bh=3qLdsjraVnTkvcU62JKbOxXoJGmNXkgXinDn+n0JttA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWT08/z6UtB+76urXoKZcp+QfZB+0oyZsINMp8Ja5nylDBYK8P0xJAIs9eDWwO1Hil/BAtw/THvv6gVPMkvrQJhYdvnD+mleEMij7/qfhCreD7RBjeTrxuorhR7eNBqSnLIZJHPUGpTG2hZWxvw/+RIlsX4K6jQupLJzguJ7n/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1JXKbmer; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a6bfc1dc8eso17701585ab.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731340785; x=1731945585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oH65ZqjoIUQdyQOhxA5UJjXuUFw9k+5Mbc5ny89egoI=;
        b=1JXKbmerkTf9z93jDfu47CGaP6VnFx+TOQ5ZjfvVW+Q0f/BFAmCQHINr6P9ABPRnri
         aAxTnDdN1i5rLHhaDw8N5r+kkoOAmOeO1SBveBhRS6gUmM7RRj/Q447P6macKSLhUo8v
         SnXVXKHnwNkUi/Kck2RQkrQsH3qdjWxMPKY+xZmqsBmOxXhQ2H1VRCHdke0fAjb2nVmi
         7XJulnA0A0Np3OLafBxch5l/VycvaRPqb55chL14kirOqbbDcxL1c7V97WQ4dXfkH7wR
         TP6KtyLhn7UBfSY3gyfWZUDe1RkP3AiYG1mpUfcB2hkSZKu2GwA+O2wNHIUz4rWtc82f
         UZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340785; x=1731945585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH65ZqjoIUQdyQOhxA5UJjXuUFw9k+5Mbc5ny89egoI=;
        b=gQpXB0Mwu+72CE4lFrtRCz2/aPcbgM3dsglQqi6TqiTvkjquy0jbQ7ER7VYBpGFLxs
         uKQRuTWw1CnYJoYMCcIW3ehCQGKiEiKDJ0mxsq5LUchMh22T1vFdE5sqNd7Fn0gXKXJJ
         HFOD1q/yJLY5D+L7Dxnd6Ug9MO5TOdSgNmTM8X/oKbpmIxrESAeC9b3qKvgOyAVaJ+PZ
         WXAmaBQDsf6Drl1pRDfv8sV7l7sMidf7R8a1/2m+kfXDvGA0o4vbhIZbB9w9ZKlB1CpU
         +fyhJ0Easfot+sauJZS7Yx90hp/e10vUQxek1iGSgUyU3cw6JK8gUo9V9a1ebZXgFlML
         rQFA==
X-Forwarded-Encrypted: i=1; AJvYcCUEGJdePSUf0bZLv6HSQPTOIbjo2zPet3Va5GSzqt8Fm/c9UBhVE9cPK4pO97oPqYupHwMo5CMSTUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv/Fm9B48xQZ3em82o2bvx+0C/1GfIJYBpfXf/S29AH/fE07N8
	YhY7eok0vZH41IHASfFEAhQAYDYtzOPHSGWd/dD6IO9/GLQDhRzfkb2xB99hRkg=
X-Google-Smtp-Source: AGHT+IFdQtHgzeLQ5tHnnidCC/p7SSDtP0oKLa2pFiTuSqodXEo1Um6QA0LITpJU3QlHvh6nIzxteA==
X-Received: by 2002:a05:6e02:2164:b0:3a2:7592:2c5 with SMTP id e9e14a558f8ab-3a6f1a37439mr153211505ab.17.1731340784990;
        Mon, 11 Nov 2024 07:59:44 -0800 (PST)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787d62c6sm1410986173.81.2024.11.11.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:59:44 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 11 Nov 2024 10:59:42 -0500
Subject: [PATCH 1/3] iio: adc: ad4695: fix buffered read timing in
 ad4695_buffer_preenable()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-tgamblin-ad4695_improvements-v1-1-698af4512635@baylibre.com>
References: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
In-Reply-To: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Modify ad4695_buffer_preenable() by adding an extra SPI transfer after
each data read to help ensure that the timing requirement between the
last SCLK rising edge and the next CNV rising edge is met. This requires
a restructure of the buf_read_xfer array in ad4695_state. Also define
AD4695_T_SCK_CNV_DELAY_NS to use for each added transfer. Without this
change it is possible for the data to become corrupted on sequential
buffered reads due to the device not properly exiting conversion mode.

Fixes: 6cc7e4bf2e08 ("iio: adc: ad4695: implement triggered buffer")
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 595ec4158e73..82e930b21c69 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -91,6 +91,7 @@
 #define AD4695_T_WAKEUP_SW_MS		3
 #define AD4695_T_REFBUF_MS		100
 #define AD4695_T_REGCONFIG_NS		20
+#define AD4695_T_SCK_CNV_DELAY_NS	80
 #define AD4695_REG_ACCESS_SCLK_HZ	(10 * MEGA)
 
 /* Max number of voltage input channels. */
@@ -132,8 +133,13 @@ struct ad4695_state {
 	unsigned int vref_mv;
 	/* Common mode input pin voltage. */
 	unsigned int com_mv;
-	/* 1 per voltage and temperature chan plus 1 xfer to trigger 1st CNV */
-	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS + 2];
+	/*
+	 * 2 per voltage and temperature chan plus 1 xfer to trigger 1st
+	 * CNV. Excluding the trigger xfer, every 2nd xfer only serves
+	 * to control CS and add a delay between the last SCLK and next
+	 * CNV rising edges.
+	 */
+	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
 	struct spi_message buf_read_msg;
 	/* Raw conversion data received. */
 	u8 buf[ALIGN((AD4695_MAX_CHANNELS + 2) * AD4695_MAX_CHANNEL_SIZE,
@@ -451,9 +457,6 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
 		xfer->bits_per_word = 16;
 		xfer->rx_buf = &st->buf[(num_xfer - 1) * 2];
 		xfer->len = 2;
-		xfer->cs_change = 1;
-		xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
-		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
 
 		if (bit == temp_chan_bit) {
 			temp_en = 1;
@@ -468,6 +471,20 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
 		}
 
 		num_xfer++;
+
+		/*
+		 * We need to add a blank xfer in data reads, to meet
+		 * the timing requirement of a minimum delay between the
+		 * last SCLK rising edge and the CS deassert.
+		 */
+		xfer = &st->buf_read_xfer[num_xfer];
+		xfer->delay.value = AD4695_T_SCK_CNV_DELAY_NS;
+		xfer->delay.unit = SPI_DELAY_UNIT_NSECS;
+		xfer->cs_change = 1;
+		xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
+		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+
+		num_xfer++;
 	}
 
 	/*

-- 
2.39.5


