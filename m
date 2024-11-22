Return-Path: <linux-iio+bounces-12483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DD79D5E2A
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 12:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72AC2B25012
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 11:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B441DE8BD;
	Fri, 22 Nov 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0cYh1XQi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFC1D9324
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275243; cv=none; b=a5DZBlVBIRHF/wBtqKPjxsc/JcSR104mOcIAwuiYRKZ39sw7keGgqWZ95mhPCB28M/OPc0sNCyUvJzL+MqpJunKgw51LfGeAFS/bqC3VF7MWLZcDUnmk60omTTFA8LMPRGPOH7WKg5vSyRaJgebjziX1KOB88NOBGv+C6V2jIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275243; c=relaxed/simple;
	bh=zn8zvV9Mo4O2rpc8Z3avU2Iyc7Z00tacRFBEl6WqSmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIKC4aepCUa9XQYrN6/PTswhEXvGy6ACPfNB4XqUmC0yzfVjYaBySLgy+SvZ6lw7VXTYTt+0Zp5jOElo1totjgXsxycHS23aQDRWWtG9raJMvdfG38JwnUR24NzhyZJ+DDRo3Kg0Q+Rd+Rw8CHAkQYcjsOGEjWFqj0BQNf/3jSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0cYh1XQi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3824a8a5c56so1308657f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 03:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732275238; x=1732880038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoPQYGtC/ppQEZ9aVkh2TLcv9C9qeXCGvY95zPdobik=;
        b=0cYh1XQiPrctRR6K7pJbWVxRWVV39t2BbFGOQmWbuRrdYc8aP4AL272IPRkQy6yLAK
         tHpdpwMTBsSBMU51CZBJDuCjUsQ9gaSIgG8Dz3QJnu089TYj4dizxlcL12KAHo+Hg75i
         E9nidG4Q/lWYhil2HbocybEoiibJSYfEkmgtJsJRYvjVgDkb1yeLTT/5cgHpXdAxuxwO
         dTFrRP+fQPgKM8tBBSd9aAJt1Cxrmy4w3F2igwHdOZFG2TXRPNNxo0pvJBgKTo7HaXm6
         VfIamD7hWS+HF4zAtAa9TNQDeQobQr9BVgraClxETqJJpEMF5YgOnYqwDVcLv5ncEhMH
         tqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275238; x=1732880038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoPQYGtC/ppQEZ9aVkh2TLcv9C9qeXCGvY95zPdobik=;
        b=gRLc2Qt3koLofw4wmxqyPZ2V9l3nkT4q3HC170pYw/1e0MJ4Iw2AWkDw8gaiuHIbVK
         49aQloR5G0XRwGdmoSUmBycSMUZGoymUUXwAfIhv/DNFn0rCoQMFx+lcIsAvWxK/7yeb
         NC7TcdbHiBN+b2hxu8U3TyEzgN7ena+6yG68YE2qeAtpuxZxvg1NW/r6CKNDS2Iqs78U
         h+iH04Xqgstz2mdZkBDwMY8YD88SJuSvJ+Ib+IowqVkKccXlK0LA4oWQcsuiJhc4OhLn
         tOkG6Lc65ouRrG6EHcgz3/kHIJmsNj4q9cDDV++gHQ4p+hZCaFe+g6DLH9+HFEE8pBOY
         PN7A==
X-Forwarded-Encrypted: i=1; AJvYcCXliCczw1/LFELqB0vhlZkgLGwl4ntZNj0cQnuCalo6gmu5ImTs9NzsMDfxxEJyyYu/f7l74Zs7QLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqV1nduxC1NMiJvUCuKxWI9zrJCCBanmoc3u8h5siWDELCRk7T
	EhWVa3Zze/hOugHKcmchu6kUVukfiPzlwULdYxdVGX95qt7GfiOjq5mIx02EV4Y=
X-Gm-Gg: ASbGncuiA0uSdRj/dxvIDpS8sf1n/taL9a+RjdJahHysYQs5DDEFOciinhWFZbCP5GG
	MtGChoI1y7hgznbvZ873WYgesxf7kGMW321E72VQDhgb5aF/7HiEElCXPbT/4bW6/h2bJ2Qe/WK
	P4Oiz5HH+jxlRhHY0y0J2E/ahR+ymtnF+Jz4oyb6xHQk343EW2+mKlUoIdqFn/m1KL4TQOJTBwj
	EiL5z3nODnIcW7G79pUsLh+PvzhVvUs7aH46SC7NQLXEPKsZUNgzX5kQV5H2nR345A7zUkyqEOi
	iDQ=
X-Google-Smtp-Source: AGHT+IFAFQljimeVjqw4v2+A2bwugBOINom79VdY/2/axQBoUoV9Q5ZfAKgSxtyk+H/KgWcl2L5ZGA==
X-Received: by 2002:a05:6000:2ad:b0:382:4a4e:25bb with SMTP id ffacd0b85a97d-38260bcc4fdmr2264111f8f.46.1732275237540;
        Fri, 22 Nov 2024 03:33:57 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedf63sm2151095f8f.102.2024.11.22.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 03:33:57 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 01/10] iio: adc: ad7124: Don't create more channels than the driver can handle
Date: Fri, 22 Nov 2024 12:33:20 +0100
Message-ID: <20241122113322.242875-13-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=zn8zvV9Mo4O2rpc8Z3avU2Iyc7Z00tacRFBEl6WqSmQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnQGwFdZucAX2c0f4j3lwLFQfEx4Ynwm9Zsma60 WqCqNIV1u+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0BsBQAKCRCPgPtYfRL+ TqowB/92c27FdrHVsaMkzSVvM/75ogPI76TKY+Fck42/nyak/0MB5xhqAVN2YJMG0FokNJV9MzY SEDtU7+h1v5z9i9ZBQLDLpbD6AdyipPFBY4Gi6GzjWP/vO/4i7E2m+EcWu188GqwiF1CxD6bu/B TZeRtUjhE4OdiIeDm7iywuJIiWOYsbVco0+qZAVMogRxEeJvL+4uLu1g7TERZg2KUc1YRPLCw8B tGIyVJrK7SKkBPXxrbsTzOAJN2q63JiOPJtd/pAzjp+1OWg4zozDSo2z/T/0/R3feqDevh6ZgKW YuA75Hz1LXj1PJ8cxwlGhul91KZSiXpiflNmGuto6S+c8b9P
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The ad7124-4 and ad7124-8 both support 16 channel registers and assigns
each channel defined in dt statically such a register. While the driver
could be a bit more clever about this, it currently isn't and specifying
more than 16 channels yields broken behaviour. So just refuse to bind in
this situation.

Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 8d94bc2b1cac..5352b26bb391 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -821,6 +821,16 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	if (!st->num_channels)
 		return dev_err_probe(dev, -ENODEV, "no channel children\n");
 
+	/*
+	 * The driver assigns each logical channel defined in the device tree
+	 * statically one channel register. So only accept 16 such logical
+	 * channels to not treat CONFIG_0 (i.e. the register following
+	 * CHANNEL_15) as an additional channel register. The driver could be
+	 * improved to lift this limitation.
+	 */
+	if (st->num_channels > AD7124_MAX_CHANNELS)
+		return dev_err_probe(dev, -EINVAL, "Too many channels defined\n");
+
 	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
 			    sizeof(*chan), GFP_KERNEL);
 	if (!chan)
-- 
2.45.2


