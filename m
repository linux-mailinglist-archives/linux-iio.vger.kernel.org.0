Return-Path: <linux-iio+bounces-9672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A55097D785
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 17:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C116B2844E8
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE017AE00;
	Fri, 20 Sep 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JgIS29AT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6113D28A
	for <linux-iio@vger.kernel.org>; Fri, 20 Sep 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846513; cv=none; b=gKyStjK/4yCCCWnhOvJi1qPunugbkC4OLqw0hhohgKj2HfgUgExg4nsk5aLj8vQVt5CgP4zFnPv3rmSAWiNUu3zuLnEkastUrYh83jLlMvnkS7e/f8rDqHV+QGCJD8rGUnN6s2pQr4Igz7VmnBMEzrBVhEwEsFLxoISSokSLQ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846513; c=relaxed/simple;
	bh=tfIGSP4Ol7ZC+tdjR1Qmch4/HwGaOe2jwmbITgTSrI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u8N8Mwjc9y1TMaNtSdWYaJcaKsY2HOh9LHZh2cK8bClUke0H0PzSx4+tpJwpP0jOAdCFQzpM35GjSBMcUSF+sbafpcMZaz2RaZQKYwE17kW3cCgTZt6/2YIPZwrXVS1zdgTRhElyd+VEmeHPyfte9wBDtor/N00JmLROAs8Jgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JgIS29AT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so19074155e9.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Sep 2024 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726846509; x=1727451309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6D6jFV+EtVEkTrb7wGVPzBlF8Edw7D7uAJ2rY5esVgk=;
        b=JgIS29ATWXDexJVP5FY2q4iF9O79abNKG87Pp/jG76tZtJadf1FkZFEFKq9yDKmBLy
         6hs7eMaLBY9xkwiNb7J/bEUmRRJiscSbQ3J5dYif4gKMcSwrYODL+5TsjZ8YXrCPUCVd
         VsFGxk+fZVi9eLCHYEqRRlynRKIhyICbEVtcBaLjjgqYonH8G91CBQdzCwwkmsw4qKCd
         lP122UDRwu3a3H85Hz1hejl/l3RpUq4cfNzqQKqBsDJIWpJupGnQ2a3MM8Fylx79G6dy
         E23xMHq7nA5OOg9pdH9TQLijFzujExXyCVsn/4heCNLc1rSYbk5zFx3JK1Eh26PQOXt8
         jY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846509; x=1727451309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6D6jFV+EtVEkTrb7wGVPzBlF8Edw7D7uAJ2rY5esVgk=;
        b=lkm9KGz2uJVr+oErsSjwaz6mhaVc1Iy9kDdKuAjWCde7wxVP9ZWakzT6TUptDdCo/Y
         SbcsWDMPrMO6gIRBs8kKGBnlgEiKK79PibCoQJjxuGzDJ0c8D+EnRvsP+kbTjexyxUk5
         /eFfi0fYqdzeNThvrWnrmzHQ1EFDyumoHGp/T9vPuAoiB6OwkT/NuDsmsvBXTdi959LK
         IEHUCP9u4TEWMqqLa1u8/ojB/w7MswKJpwT5QEQ8I9lom6OArmufPreMKUOuFXTO4H/b
         XIwIcqjTlpq2Z5xvWfnQSwEn5bGqz7Z6UJ67gz5+SzZEGYoa4U5bCI/EZzUdztdAPtpI
         eZpg==
X-Forwarded-Encrypted: i=1; AJvYcCUTXxRHy90kmd1/ERGzagjg7e1ojynYJJcWRXQloFP2A0Rcq97ppizS15SoiPJdnug4/eUk1LIZSys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHmGDA0QdjPJlJ1dkzndCIWrW98SeJALMqFNxHdVaoeBqXG6V
	rXeozrxQk/e1geXIG348qTd06Vbb7kC4Ek957lKs9yglL4faFcBca28oeZCBXDk=
X-Google-Smtp-Source: AGHT+IEgb/7g4nYLxnsDGfI9WSAOc7KsrlcAmkAksO38iuZUkUjHMqBTw+JcPn4/+yUpZ7oUy2IzOg==
X-Received: by 2002:a05:600c:3591:b0:42c:b63e:fe8f with SMTP id 5b1f17b1804b1-42e7abfc4d8mr26364795e9.13.1726846509360;
        Fri, 20 Sep 2024 08:35:09 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e49casm17948252f8f.20.2024.09.20.08.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 08:35:08 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	=?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads1119: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Fri, 20 Sep 2024 17:34:29 +0200
Message-ID: <20240920153430.503212-11-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=tfIGSP4Ol7ZC+tdjR1Qmch4/HwGaOe2jwmbITgTSrI8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm7ZYKfW2W17KtBkTzvxLthEZ3aQC/tqn9cceLJ qQx68xeSqmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZu2WCgAKCRCPgPtYfRL+ TukdCAChAcgZnClGoeFB36rbaz/+y9aF8aB8qIPnDUPYfwA+yLkBq9XP6KH6Nn0qWIIwPI3dZQU 068I2g2qagezPrVuOA9ybCdWeVZnswoaUTWSjS+hAVlrYqnU86wfcRL+NAYyAiyfPseVu7H+gk+ fqEF7jBPlTo44pzoolGdkgrWwPlHd2t1uxzgQ8KkT4+tso7iSmCkeqOvkYLxVOGV5vhqH9ZK3Vv izCZP1xtMio+4hAEWDLcWY9qscw8y1hUxX7G9P7d4sLZF34wNMrHMklo/9wdm59GTk4bWfF91zH eTdE1sFfgUIb9lYk92V1wVqFULuTesxjkAMonQDVI9IuoAoF
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ti-ads1119.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index 1c7606375149..e9d9d4d46d38 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -804,7 +804,7 @@ static const struct of_device_id __maybe_unused ads1119_of_match[] = {
 MODULE_DEVICE_TABLE(of, ads1119_of_match);
 
 static const struct i2c_device_id ads1119_id[] = {
-	{ "ads1119", 0 },
+	{ "ads1119" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ads1119_id);

base-commit: 62f92d634458a1e308bb699986b9147a6d670457
-- 
2.45.2


