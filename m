Return-Path: <linux-iio+bounces-9509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25558978206
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34201F26424
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 14:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F061DEFE0;
	Fri, 13 Sep 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PNxrspRp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA81DEFC0
	for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2024 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235876; cv=none; b=n+XGcpvDWI68+thm/6NQdDb81K4Y/yhRRXvciF8Rw1n66v+F13yntyEf4XsioDguNKA0Gc9nfXTmdy7eGyXVQ/7HtNrhZHRMPYF2ZNXCwmtaxSZf2NVvfnBxAyclB+G8QszO/ZsZUaw2y7mdNgZrjhkZ7vGLTDPbd7nAV3HgcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235876; c=relaxed/simple;
	bh=ykUyvmQc/5wbFyrFRMV34ty22I9dWMk9TBb47ILEe4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0RNAEF4a8+fyfkfCx6Mf30oXfk9M69QI9grIyHY4A60PpnFpdzG+muqqd16C3Q6WQGOkDUePhqaHBoAYOeGBPILiMTNXuNuSmmcqUmvtuNZabsMKT4e5mq/riiczhQFJcSM3xl1n8We2BecpVt4oeP9knxdAhBplCqRczrYNC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PNxrspRp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so12784655e9.3
        for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2024 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726235872; x=1726840672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4rgjfNfx6m5HjjB8s+u7qEdTS2g8HjBiOKrDc5NZNs=;
        b=PNxrspRpc13iD1sNcrmh+vlfA30bQP+dBSSKqCwFDTRYJ/bqQv8h+08bQoB1QyzxPJ
         MtvHXTqtSheWngYZANTmeJ7HqXN0RUIRgrCKo3EHfQjcWL4JryUfFHHIx43Xn6oAlBWy
         QJgRzllQXNntOpv5ASwIsLxRtdVzU54ZkMmE5qa+DgLlB6YovuOA4twtIEBqvQS55EjE
         5E4ip+hCjbh3ertfR2EhsPu0QnRpz9XzL6eiScDMrg327B82eEEQe4uxjv8nttEsRR3N
         Qohfy+88u/y5DtnXkqFDG1W7hPJUB8HURHaoKf/wg2QuqjKY2TW6vEGKT+svQSyP07jx
         2JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235872; x=1726840672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4rgjfNfx6m5HjjB8s+u7qEdTS2g8HjBiOKrDc5NZNs=;
        b=QS10/JJ5GQGZ0uEHRIuZSSjkti52lKwkwUGZdxSU22gd3QGDahFXnVzR2zwu5VAATF
         ZlddskYs7mwg5TtvQGabGci2qi3HRo9RetSRTQJ7SaLD9YnJt4AMMW8OugWsSinfom1D
         sIVTG78v0U7q02tuCQi3OXtoFyUqKO4j5MHCV9ALJmFl7gUIFNIdR2BdroSmLyJmNJpU
         cj2Lrez6tKSQpjPO3ZUjHSC+RvdpRYvr3r33FgKaRojr3gKGj1i4h4CaoeOkqJbgr7XI
         Pq6Xs34a0zUQJlFf7XYGuC/L1HvKllE35dLsHg4elY/603brImdsMzElG0NEptCvoxaU
         vmfg==
X-Gm-Message-State: AOJu0Yy9izPFj+b5reSyWNLqTy9AT44M00XCh7PH/DyoOAHINslndsGq
	T9LBhJ17I6CdTkUspdPo6wjrjkoJpY25jajBS99bLHYb1Y5XRDSSgAcSnBHwPZrktc3qBa/d/CY
	ixi0=
X-Google-Smtp-Source: AGHT+IHKl/sekJF8kry63CsXxWoyv5gAnBtahL/o0D2gWDcZ37fkQHvGiSnOeYrYCCK3s3dcaZ0Iug==
X-Received: by 2002:a05:600c:46c9:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-42d908267d1mr32500025e9.15.1726235872095;
        Fri, 13 Sep 2024 06:57:52 -0700 (PDT)
Received: from neptune.lan ([188.27.129.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3941sm17104749f8f.84.2024.09.13.06.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:57:51 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v6 2/8] iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
Date: Fri, 13 Sep 2024 16:57:37 +0300
Message-ID: <20240913135744.152669-3-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913135744.152669-1-aardelean@baylibre.com>
References: <20240913135744.152669-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ad7606_scan_direct() function returns 'int', which is fine for 16-bit
samples.
But when going to 18-bit samples, these need to be implemented as 32-bit
(or int) type.

In that case when getting samples (which can be negative), we'd get random
error codes.
So, the easiest thing is to just move the 'val' pointer to
'ad7606_scan_direct()'. This doesn't qualify as a fix, it's just a
preparation for 18-bit ADCs (of the AD7606 family).

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 8ebfe8abc3f4..032a8135c912 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -114,7 +114,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
+static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
+			      int *val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
@@ -128,8 +129,10 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	}
 
 	ret = ad7606_read_samples(st);
-	if (ret == 0)
-		ret = st->data[ch];
+	if (ret)
+		goto error_ret;
+
+	*val = sign_extend32(st->data[ch], 15);
 
 error_ret:
 	gpiod_set_value(st->gpio_convst, 0);
@@ -149,10 +152,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = ad7606_scan_direct(indio_dev, chan->address);
+			ret = ad7606_scan_direct(indio_dev, chan->address, val);
 			if (ret < 0)
 				return ret;
-			*val = (short) ret;
 			return IIO_VAL_INT;
 		}
 		unreachable();
-- 
2.46.0


