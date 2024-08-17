Return-Path: <linux-iio+bounces-8542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B1F955853
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574811C210FC
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B792154444;
	Sat, 17 Aug 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ounaWgok"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91636146596
	for <linux-iio@vger.kernel.org>; Sat, 17 Aug 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723904593; cv=none; b=B+/3ZMSDg2cv6tnoa7RE4tRqX95wCDsNL0I3EqrXMdy6jzaBigrX5ug03yF7K6NVVPjJCP82o1TGhFQvoGEZD/HmIAz9D6L1pwrG8fPtyou3G730OfhprB3w//8GPmqvbX7E0w0LQeG7LPJ/9fBtCi2YVKgY6Pt2JQj5FzVC6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723904593; c=relaxed/simple;
	bh=uk5i5KEhn3uYO96x/ZIsSJPtmoVsLanxeeIVAC3TqRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EB7AiBmkpMIeAYe3JHGjOXEKt2N0ik5CfXti+BeI3vjMe8q53MK7BniHWhC8LcEXzN7XQCAn0NGflN4EbYzQ6VjUcOgjba+vkTPPebD4nCou2DyYwZ3tzP1XK/jmNakQ2DltxrXpIZKI6rRriOFaEfI9tEbSEb3ytab3EAvUKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ounaWgok; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bec23c0ba8so398060a12.2
        for <linux-iio@vger.kernel.org>; Sat, 17 Aug 2024 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723904587; x=1724509387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6iMaGmzWFia+xTWrULyzkJ0JdQY6tg1+ik3EJL+2SsM=;
        b=ounaWgokWLTIDTyecXlnCOKga5FukWcN/gaUg0YO+LKv5CQwa1SRYmU7QhxtBJSHj4
         0ru7cYAGKmHe40RnqVqT/DLWSosidmiNz3gc4ar12c8YzsslXA4tizY0/eAbYFymB8fQ
         AOF7/1h07SiUQ76ZFPhHlFIpvqwvCXy6oVNELK1fyzQbdxRqZQ9187phzFGovtFfs0pc
         6Iu0ciceB7vbs9zWxraR+GGHK+L/u3WXi7OrtJt0QDjv8tORr7C7aaNIet3o4kdsTSX8
         gaWVQr2Tc/0YHRLsgDjoaZRw0RrSWOtYKPvA9iAspQabj+hEhPRZ4A6PVeuXoBNhuBG0
         KgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723904587; x=1724509387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iMaGmzWFia+xTWrULyzkJ0JdQY6tg1+ik3EJL+2SsM=;
        b=Z1B81oU14hB6M9Ja9/Jtx9UFAp5ES71GsMchcMBaOHM/z27iEBgzv4ZpMsoaq+DVou
         mpItR4caHeLgncWw0ndvr7oG5IQ7p0ke/KM3qxsEzBmvollVFA1nMNT97xnhU7k+kLv1
         XH+9rdNltk8uc9ezFEU1a3i1KGQD8Bm51VtyacYXHKXKAdih133MvfPcFe5/VXlHtykr
         QoEk9FLrjhltqGA67FfK7BBcOyktnsmR3XXTLWkQW74+webn/ITZ7XvMrUpZgVtvCOUq
         E1jl5/3onDbj40IxwOu3dTpSvx3Khpt/be4lkBowHRRtosU7QXLJ+NVMC9Ey3Jn1nniZ
         lOAA==
X-Gm-Message-State: AOJu0YyEQkLn+LrgzqgvYYdSS7wuM87HaAUw9YT26yex0UjL3lOO2z9e
	u7t+D9wMumw5iG5N3DdalUIcZFjXM95jHm9mOp0sOTZAClflVnm97L8Ezs2MLSMWOmMS0C1E0iO
	lfvw=
X-Google-Smtp-Source: AGHT+IGshDUPYYZZShBNA3L65qaD2NpTDM97a/D2l47/Pel9hRVfH+U4YCFgoVu5TCAqxCfpxBkR/A==
X-Received: by 2002:a17:907:6d29:b0:a79:a1b2:1a5e with SMTP id a640c23a62f3a-a8392f93cbemr199533766b.10.1723904587038;
        Sat, 17 Aug 2024 07:23:07 -0700 (PDT)
Received: from localhost.localdomain ([188.27.129.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935710sm403286466b.129.2024.08.17.07.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 07:23:06 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	gstols@baylibre.com,
	nuno.sa@analog.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH] iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
Date: Sat, 17 Aug 2024 17:22:57 +0300
Message-ID: <20240817142257.14470-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
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
So, the easiest thing is to, just move the 'val' pointer to
'ad7606_scan_direct()'. This doesn't qualify as a fix, it's just a
preparation for 18-bit ADCs (of the AD7606 family).

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index dba1f28782e4..35b2862c3928 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -138,7 +138,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
+static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
+			      int *val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
@@ -153,7 +154,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 
 	ret = ad7606_read_samples(st);
 	if (ret == 0)
-		ret = st->data[ch];
+		ret = (short)st->data[ch];
 
 error_ret:
 	gpiod_set_value(st->gpio_convst, 0);
@@ -173,10 +174,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
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


