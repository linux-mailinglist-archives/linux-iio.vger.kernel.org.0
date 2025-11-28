Return-Path: <linux-iio+bounces-26546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39944C92C8B
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 18:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7BC3A7991
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED0432E72D;
	Fri, 28 Nov 2025 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a65JjCEf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABD2627EC
	for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764350505; cv=none; b=DBm1JyK6+Dt3zynZeLjtveTS0gp+gLHLy/4yGVJWmeeaAV3XkQwyIOfPWr0TtDdUbHs0OuD/6YI+/TXjwEuAQ7OAHAEmgHpZtNgPqMT+rSSDy+9KnIJT/6+zh+ZLgJ0tFUBDnjszwUkKUo/4BPnXU9dkQweQKBdn+HhQzJsV8sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764350505; c=relaxed/simple;
	bh=uDYERl7M4CHVlX3TL7em9lSGrgrS5AMYJsyyfd4wiSE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=jeTDaZ+Boj7+K++/+3whGEdoLuF11N4lzFWvPyX8klUiqgKA65mRmXTawh2IygI4lH7zZ3/A/+RcR4EfIiWIzvRDWQsG041nBcEdB0CtF1JahluXMaKieoQ+UXIjkaOVhQzshIeFmlceNOcQ4yBd/Hm/uodIErrKzQkg9FT1JLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a65JjCEf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7633027cb2so163792166b.1
        for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 09:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764350500; x=1764955300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0o316vC9WiaR3tTaCWrIiITBeYf+5Kgf/Kcm7GUATFM=;
        b=a65JjCEfXV8zC62byEpnw2Hhuqz/5bGa83l5O367ZIQvsEC24Vf0k4Sdp+LJ9vrwfI
         wGcwwrdtlgHn9ctMyRu/UbMpkaNOTUhzFrVM8i1D1lXLr/4XAGpQbZ0GvrpNfGpL4+Fy
         HqiMMVRX4McDh0HiGomAgTKssVpGX5ECloaKHZaYbGFaDWNK+9b7mIF/SeAFASGbqO2v
         fvhz2gV46dMfPZBQIAYyULGHvA9VkAbAbiO3qoMfVr+MtRHDrNeu9DGcZj3/iveQ0ZLT
         x2xSuiFH0h23paW9Tn7jUKWyZJLJ4WQ/LY8XUWn0Bt+Sv3kRYm3H80bHeNMECgheb3Bx
         myLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764350500; x=1764955300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0o316vC9WiaR3tTaCWrIiITBeYf+5Kgf/Kcm7GUATFM=;
        b=A+q09QH2O5K8uB0rK2R6fZV95LOOdduTJQNez/MjKGgg9RGhyW4xljJ+TSDelwCUUW
         C68R7sx4pTWy8kkJxT9wXBb3qSjkAtJUu61fafKlSuqxe5v8RivHqFcjyjXnHOYC+tiL
         wr4guEXES7pB08cC8TCr6Qfufqf/Cc5PvNOVNCZQgaUjC933aUvKwX71H92wrrg70tWN
         SC2VdjGM+8a3G6h9L6lAKoaWVAYKdgCzFIlTqJIYA7TmK+JrWItZuN6FFhoOdp+tDrhs
         hpiy7N4zpuzmH5CerO7Bf/TleG/tPtUaROBFWRVARlbFMRA+ocU23z7/hVuSGnXxiG1h
         JTwg==
X-Forwarded-Encrypted: i=1; AJvYcCVdOufeoHaH+tq9JWIEjLERWI6HI8Eojac59AaZYWI1t376brNqc0baqyPOw8RMNOVG8E6ojWD9aUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfU6CGy0oF2e9xwyZQ2WqQc5avyFyN+gCdW4ZDsX93BkHdLWD
	R2bJqsKO0RWp17DqGVB/9gLx8nt0delXApjDGa5ptENGAl56AFIhJAKzhUdjDEp61Lo=
X-Gm-Gg: ASbGncuVyu5N2Qt1WsmQv1rCi3VbDjv6csBXtvNZoVXBEhAPXlBFbSSMfVATFhPlfru
	dJLVjc9exs4Q4hS22AkX8+5dz6bp6bBvNrFw4+5oLBl2yBhY93ou8kCJrKINw/oUmQTRcN25jIp
	T0D1BvJTQx0rH5F78V4691aCnYKpJo+Dsvyj/xEB8+A/44hBf0h92Eg1ZmLNy9V/Tf3dVIOSNi4
	QocWkT+M6o96s/HVGLmkVqUDaDt7XIP+SZV+5KeXLrF4amO4jQGZdjbNqZ4hStqqRbscuNdHNnz
	JrvkkfFY7K9PBkzX0zqyLLJN/xZb8I4g5Cf93WQRrzPiXV0kjbCs/rKKowWdlnYc1ClbzqUl84c
	SK6bkf1FPwvrPNWLydMri+XbRtBUDNr5GaBSu6hjYThRHaJwAODYycoj97Z3Ocug6eIoRsgK+3f
	yFsg==
X-Google-Smtp-Source: AGHT+IGmpNEn2fy1edz63cjxx5L1QCCwvrbgiP5eTG0zfIU1MryJIhORXDLagO2TT8pRFNM4URvWlw==
X-Received: by 2002:a17:907:6d1b:b0:b76:fe3f:e76d with SMTP id a640c23a62f3a-b76fe3ff0femr726893366b.15.1764350500468;
        Fri, 28 Nov 2025 09:21:40 -0800 (PST)
Received: from localhost ([151.35.208.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a4b926sm493521366b.68.2025.11.28.09.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:21:39 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: accel: adxl380: fix handling of unavailable "INT1" interrupt
Date: Fri, 28 Nov 2025 18:21:38 +0100
Message-Id: <20251128172138.257961-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=flavra@baylibre.com; h=from:subject; bh=uDYERl7M4CHVlX3TL7em9lSGrgrS5AMYJsyyfd4wiSE=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpKdn24Y7qQupxDrr9JGAedi2Q+p/corh1sUBVp F44zgdNqhaJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSnZ9gAKCRDt8TtzzpQ2 X0H6DACm+jgfQZHcI4WNcN+r5LnxzXXx94gNep3p5KRZyazeHrdZyXxiRNh4bilx4HoqEjCfdOC tBhbsO2yNUROn6+C6YY6vdOn3OScWvm0zbJs0lKGsDEl6PdQf/RcdHiP+vOfJ/M8avEbCzvDHqJ fE+WphGAViYiPjjNvsGHabS6TGXkeRaYhN2ZSyOOUOXdTS4+AlDojdB5xI6kn6jGB1XLn8/d5z+ m9Jkb+rgzishqLUCD+R7lIFV5PjQfxBlSO7CWJk5u0EAtGBGajoYSJhw+eaefmcprqtWkt+hdTK R0Cj6a1SF1Uufe/+zH88D8eSpfdIRUubVeltmrV7EE9IryJJ3ldhSECxS4o9bS28eSWTxA5VDKz V6zgBYP/VCJFgLg519yku2jpyw1aHqV0lZJfx0cexkTznq2lp052mnrYa43vSiXO5+Q7uelHEwP 426j/wsc52niX2Cr142z/WW7M5Acc7tzz2598gUQuEOhQ8GHTC8m8s+HNVLGtb2GeVn+A=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

fwnode_irq_get_byname() returns a negative value on failure; if a negative
value is returned, use it as `err` argument for dev_err_probe().
While at it, add a missing trailing newline to the dev_err_probe() error
message.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
Changes from v2 [2]:
- added missing trailing newline to the dev_err_probe() error message
  (Andy)
- added Andy's Reviewed-by tag
Changes from v1 [1]:
- added fix to `err` argument passed to dev_err_probe() (Andy)

[1] https://lore.kernel.org/linux-iio/20251126144624.24512-1-flavra@baylibre.com/T/
[2] https://lore.kernel.org/linux-iio/20251128140726.243005-1-flavra@baylibre.com/T/

 drivers/iio/accel/adxl380.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 0cf3c6815829..6d82873357cb 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -1728,9 +1728,9 @@ static int adxl380_config_irq(struct iio_dev *indio_dev)
 		st->int_map[1] = ADXL380_INT0_MAP1_REG;
 	} else {
 		st->irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
-		if (st->irq > 0)
-			return dev_err_probe(st->dev, -ENODEV,
-					     "no interrupt name specified");
+		if (st->irq < 0)
+			return dev_err_probe(st->dev, st->irq,
+					     "no interrupt name specified\n");
 		st->int_map[0] = ADXL380_INT1_MAP0_REG;
 		st->int_map[1] = ADXL380_INT1_MAP1_REG;
 	}
-- 
2.39.5


