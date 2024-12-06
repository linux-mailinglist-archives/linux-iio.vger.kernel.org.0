Return-Path: <linux-iio+bounces-13176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945E29E7762
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 18:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F68328886B
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4237203D56;
	Fri,  6 Dec 2024 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gJERc+JS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3962135D0
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506168; cv=none; b=m4c4Xw+CKIr8WrrKMeL3lCx0jXg9NIM0qnbymeCENhFt07A9Ee+F1Ya39eG8eUs1PlLctktb0n2rYkkhB7zC5w6v1ctX86jHzuyOcwqhe1f33nuCln6BlXCScnTZvstJg0L44SQLz+oPXc+fzoyVto27sRPq5dQ/no6/oUpDAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506168; c=relaxed/simple;
	bh=ZW+oa7MWxhNOMtPfOr2oYTZlBX6HRvncMDOFB2/VzrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+0lT4sReLjxUg6wUujbuviClRQyaFFHftR4Ij1oAlqpxwnwtA3kssr3mJ3Fh6ros2IitRXXs3O8dn19+yYJReqqL15UZ7i5Ub/31kT7JeC+Wd3fliPjl1KRU0ybQKEG56koKavDNC5wQ+KzhwQ+JmeK1vlAll063uLi/wRmPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gJERc+JS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-432d86a3085so15762085e9.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 09:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733506165; x=1734110965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTDUIyF4up+AdKFo8Zi2WXzfWJlewWIW3Khnsuy+JKw=;
        b=gJERc+JSq2BTwu/cLpz1B6aqeC1QTpO91m/cxWsQAszVBy/Ly3obBRz4nJoQxoBEYY
         3gIce7OUgaJIO4J8wxqadFCuPPK367I5TLQomhZ2lNQReUKBN6rrZhrm19diH/6ZvBm1
         CRm9QDEuj8l3uq3YEeHGjjMM5kJ3p/qz0p5N3GckjjzQjz/PK5bv+cLO4hbXIFPaFdeM
         ISeJXufbPPYr/guF97XxEwa7ry2q/nA+hQkq8uLujb7VLPKurKLn7ZNKte5EUJTrSIRB
         KKgQtDImtIu9MCliCaF3NjsSKy6ROX+Jp/NFgzIoWhuanmLPRAjISx01rWit2i4Q1JAk
         Q2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506165; x=1734110965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTDUIyF4up+AdKFo8Zi2WXzfWJlewWIW3Khnsuy+JKw=;
        b=RFQS++e0QKDD5IzpePDLth7gRByYSQU0qYBBkod0ZX15yD857aHFd9Y98emWg2y1Pl
         SjDs+WipqsNl0VzJr3rPHwKIexOAyyfJsEFpFn7dNdHcQFTLRdGDsJZVrvzOU/ekuD7q
         DsHcVlYUMSlul6KOj59smbw/gb2zwmEAtUEJwnsdlT3u8bu9KM4pFa361e8ESl8xb8BE
         qMA6HoGxv1e3EZVY4w83dP3ozemUb9DddB0WyjsCp4VZuMWSIWcK2TgIrX1OLFrfXvyA
         4xfEAG7/mrWRDV8/FbelUitWIjH1H2PxxJja8PLUyvMm7z1Bhfhl3Q9hwWCK0cZOE3g8
         1DqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA9dTw+f6KXSVHNuTq3LGwv9VgLMgZS4yFH7E70kllz0aW/fm2lWb9FU2G+qnqPWuEHe229jwn2Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxresxcmE4vErAP5Ux7sjFQUu5zha1xrvUOKCcLTzZKhdGNlZ+s
	R6sJHFlpo51kLIVODnwNI1UM72SA1g5smlmbDuA1MkmqXzDoDOzem5Np9HM9Z4Q=
X-Gm-Gg: ASbGncssAl+xbrNSWDxy+bmo33cV/xoKU/XVZ1TagemwS6Hgyb/wN76sld9VM/B1Jgt
	fJzEbRxVuymli8csFOKa5caHEg9ofxZhFlGtESDrO4EWvXKH3vio7GZl0WzCT/A3USoXDsZJA6P
	7Vb49DG/OZ6YaeGEVTdoARRI8NEH5ZE2yjiHS1emlCjGFav8iUhoVhkrBfXwurooh/oMzoii1PJ
	Rek8LY9AemjCe8Tmo45s/h9n9NnbyzXKH0FfYas/XM1uI/bileeuqRDTeZ3NT3GldsVBTa5fSc/
	KChr
X-Google-Smtp-Source: AGHT+IHTKvPY499GkEjvyP2LNnV4gx5rjDH3fa1mk8k0L0vFwmzIal6IVRz9LSo2bknbBoe2x7wLuQ==
X-Received: by 2002:a05:600c:19cb:b0:434:a0a0:3660 with SMTP id 5b1f17b1804b1-434dded637cmr39001645e9.31.1733506165348;
        Fri, 06 Dec 2024 09:29:25 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273b1dsm98206425e9.15.2024.12.06.09.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:29:24 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v6 08/10] iio: adc: ad_sigma_delta: Check for previous ready signals
Date: Fri,  6 Dec 2024 18:28:40 +0100
Message-ID:  <3ec6b61fb1e527e935133dc56f589aab4b2094a3.1733504533.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5188; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ZW+oa7MWxhNOMtPfOr2oYTZlBX6HRvncMDOFB2/VzrY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnUzRYYfr9X2pbCHcy47EHryboUwuoY8g2+p3o0 F41Bm6K0jyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ1M0WAAKCRCPgPtYfRL+ TpUAB/9hIYxrYwiaRHXcRZ//YA+ruSdgN57dbq1w25YdAcCRh3LD+8QklRLEREejJP6yHxlzv3a 305o8yTEvTE2JZFG3mnHhyNAeH0fCo7r9Qn0sbM5EjAYj7kxoDHgj7817uR+ZBoTjnOzJ+aWJcG SCEPZ+q4StI10VvH1mdWNk8LJi9WwZeWMHsMI92pZGH4k0n1ISYARuOJ1eGnBb4L5rJLv4Cqhcu yYozBGVgTvP3YyqEtglYJ78osCYCxb7M0sH70zVYx/0HQqmVpQqeMrVyXjSqS2J1ilqS5Gog6Jx 5KbEsCKp6I4ntTl6YD0sbbVyVNwjh9GcpanHB/VWwlCyAiMf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

It can happen if a previous conversion was aborted the ADC pulls down
the R̅D̅Y̅ line but the event wasn't handled before. In that case enabling
the irq might immediately fire (depending on the irq controller
capabilities) and even with a rdy-gpio isn't identified as an unrelated
one.

To cure that problem check for a pending event before the measurement is
started and clear it if needed.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 99 +++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 101cf30f4458..d32102b25530 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -29,8 +29,11 @@
 #define AD_SD_COMM_CHAN_MASK	0x3
 
 #define AD_SD_REG_COMM		0x00
+#define AD_SD_REG_STATUS	0x00
 #define AD_SD_REG_DATA		0x03
 
+#define AD_SD_REG_STATUS_RDY	0x80
+
 /**
  * ad_sd_set_comm() - Set communications register
  *
@@ -222,6 +225,86 @@ static void ad_sd_enable_irq(struct ad_sigma_delta *sigma_delta)
 	enable_irq(sigma_delta->irq_line);
 }
 
+#define AD_SD_CLEAR_DATA_BUFLEN 9
+
+/* Called with `sigma_delta->bus_locked == true` only. */
+static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta)
+{
+	bool pending_event;
+	unsigned int data_read_len = BITS_TO_BYTES(sigma_delta->info->num_resetclks);
+	u8 *data;
+	struct spi_transfer t[] = {
+		{
+			.len = 1,
+		}, {
+			.len = data_read_len,
+		}
+	};
+	struct spi_message m;
+	int ret;
+
+	/*
+	 * Read R̅D̅Y̅ pin (if possible) or status register to check if there is an
+	 * old event.
+	 */
+	if (sigma_delta->rdy_gpiod) {
+		pending_event = gpiod_get_value(sigma_delta->rdy_gpiod);
+	} else {
+		unsigned status_reg;
+
+		ret = ad_sd_read_reg(sigma_delta, AD_SD_REG_STATUS, 1, &status_reg);
+		if (ret)
+			return ret;
+
+		pending_event = !(status_reg & AD_SD_REG_STATUS_RDY);
+	}
+
+	if (!pending_event)
+		return 0;
+
+	/*
+	 * In general the size of the data register is unknown. It varies from
+	 * device to device, might be one byte longer if CONTROL.DATA_STATUS is
+	 * set and even varies on some devices depending on which input is
+	 * selected. So send one byte to start reading the data register and
+	 * then just clock for some bytes with DIN (aka MOSI) high to not
+	 * confuse the register access state machine after the data register was
+	 * completely read. Note however that the sequence length must be
+	 * shorter than the reset procedure.
+	 */
+
+	data = kzalloc(data_read_len + 1, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spi_message_init(&m);
+	if (sigma_delta->info->has_registers) {
+		unsigned int data_reg = sigma_delta->info->data_reg ?: AD_SD_REG_DATA;
+
+		data[0] = data_reg << sigma_delta->info->addr_shift;
+		data[0] |= sigma_delta->info->read_mask;
+		data[0] |= sigma_delta->comm;
+		t[0].tx_buf = data;
+		spi_message_add_tail(&t[0], &m);
+	}
+
+	/*
+	 * The first transferred byte is part of the real data register,
+	 * so this doesn't need to be 0xff. In the remaining
+	 * `data_read_len - 1` bytes are less than $num_resetclks ones.
+	 */
+	t[1].tx_buf = data + 1;
+	data[1] = 0x00;
+	memset(data + 2, 0xff, data_read_len - 1);
+	spi_message_add_tail(&t[1], &m);
+
+	ret = spi_sync_locked(sigma_delta->spi, &m);
+
+	kfree(data);
+
+	return ret;
+}
+
 int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	unsigned int mode, unsigned int channel)
 {
@@ -237,6 +320,10 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	sigma_delta->keep_cs_asserted = true;
 	reinit_completion(&sigma_delta->completion);
 
+	ret = ad_sigma_delta_clear_pending_event(sigma_delta);
+	if (ret)
+		goto out;
+
 	ret = ad_sigma_delta_set_mode(sigma_delta, mode);
 	if (ret < 0)
 		goto out;
@@ -310,6 +397,10 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	sigma_delta->keep_cs_asserted = true;
 	reinit_completion(&sigma_delta->completion);
 
+	ret = ad_sigma_delta_clear_pending_event(sigma_delta);
+	if (ret)
+		goto out_unlock;
+
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
 
 	ad_sd_enable_irq(sigma_delta);
@@ -333,9 +424,11 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 out:
 	ad_sd_disable_irq(sigma_delta);
 
-	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
 	ad_sigma_delta_disable_one(sigma_delta, chan->address);
+
+out_unlock:
+	sigma_delta->keep_cs_asserted = false;
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 	iio_device_release_direct_mode(indio_dev);
@@ -406,6 +499,10 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	sigma_delta->bus_locked = true;
 	sigma_delta->keep_cs_asserted = true;
 
+	ret = ad_sigma_delta_clear_pending_event(sigma_delta);
+	if (ret)
+		goto err_unlock;
+
 	ret = ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_CONTINUOUS);
 	if (ret)
 		goto err_unlock;
-- 
2.45.2


